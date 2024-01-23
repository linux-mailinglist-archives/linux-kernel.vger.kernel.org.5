Return-Path: <linux-kernel+bounces-34752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E7083871F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0591C2311E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36094EB39;
	Tue, 23 Jan 2024 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCmW+xS8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5704EB2E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990112; cv=none; b=XItPvuT80LsRVtJqJDFx79/R7AfBGLUp6nHqdeEUAKOy38UFYn8lb8ldDHrztHjQNmHU0TyFPxrlWxoapplK+kOyuMySduUL/XxyzU4Soyrf9mLqWM53Lmte2l+N6TmpFzQtWQJdN/omZoT1I6CNiutVZQF1Z1H/ufd4E6fIEfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990112; c=relaxed/simple;
	bh=GUVsGZBjrAhZKwiHlLce8FOhfmc02VxxhC42+/QGmU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMvwtBJB4qT3jYkj4n2IJKeqEE+x1j9K6Oiq+YstjNmeQa/BFQBeLIesIlhiIBLHf0vFL7eoKa2b/jegG0nxPDZ/UX94dArhg1JYuWLcMX2Gn8El8GGUDcIVS97nxLWVo5Rg9L+Ms8g8DcNq30MlXtS5BOGOFv5FZppteA9PnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VCmW+xS8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dac225bf42so2092315b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705990110; x=1706594910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjCYKivQOpppRY3k2NnoMHNr/HHiX+mZSow7Cat6y2Y=;
        b=VCmW+xS8zVWkD2/thgJUh6pHzBvF+mv0FMYR0Iiw+rWWe0CoP662UqebHp8Bxm+1SX
         xD7jD12qYDjJMKqAeRLGR8OCq3HY0Dm8gwcHOZYeNKqSEbkg8yGIxbOyPCOqF0zloZDy
         3AB+gT9lqJ87szhLKPUWgBvHcTZGAwbsushkkdcJvz6LDel6u744R2p3nIjBnWEe1dUL
         fZhVihD13DhHmKPra+4mUSJ8jAtZMp1TvOI+krTlJyBbcUnLNvtumc0psta8XRIXvxnb
         kxc+EawWdiFcugLoyiusPVz28yZ+rHPbYlwYiq3HEIWgGvJhpJNi9N95pTh25i/pjI6N
         jOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990110; x=1706594910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjCYKivQOpppRY3k2NnoMHNr/HHiX+mZSow7Cat6y2Y=;
        b=ldrSRz1oNt9BKgx3IAhwNVjTfx0vaz290s0szTvalRALfIaYIxDPC46rhj/U9orj4J
         CKvJpyH+pTiae+ktYnkt+VAIwOtuersT+fgsE3kQowG+iIcaVHTd7d0sn681sXk3ut9l
         XFSin83qmygiOXPdnkLaVP4s5n5e1lkVPLyFO4I9vRSYix0+zaAwGV8VK14aF3dPCR4c
         7XzIFyZS/ZlSsYavLt4iQuFgget0s4rTk+g+TzYMAxh8XCGTdG/c9IGjT70In1kG6NK+
         UxAQr42wRkh2ZFjiF60I+jUmlx8Z7q7i5eCLHOBdf/Cjvw6p6u7gF4JJSy3BwfD1jV4y
         7ZJg==
X-Gm-Message-State: AOJu0YzQ1RnZwO4wEqZuONC1psuFbRLb6VzuHaG1nTaM6k48l//sjjrF
	RwcZvRnQUSPhiiM5FEfvl3ady7CRZLXwSmoM4Y0Sn9fn662bQTfzBAXGklZxPEg=
X-Google-Smtp-Source: AGHT+IEVo+v4xwoQJxR11YbNdoxhbM07qMqKJcJcblpXRA+N7B5HyOF3Bstk+bC8IGfKD3nylQrRwg==
X-Received: by 2002:a05:6a20:12d5:b0:19a:7e25:d7d3 with SMTP id v21-20020a056a2012d500b0019a7e25d7d3mr3294088pzg.18.1705990110050;
        Mon, 22 Jan 2024 22:08:30 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b001d70e875533sm7551881plb.160.2024.01.22.22.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:08:29 -0800 (PST)
Date: Tue, 23 Jan 2024 11:38:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH 0/3] cpufreq: scmi: Add boost frequency support
Message-ID: <20240123060827.a3vszziftj6pszt3@vireshk-i7>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117110443.2060704-1-quic_sibis@quicinc.com>

On 17-01-24, 16:34, Sibi Sankar wrote:
> This series adds provision to mark dynamic opps as boost capable and adds
> boost frequency support to the scmi cpufreq driver.
> 
> Depends on:
> HW pressure v4: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240109164655.626085-1-vincent.guittot@linaro.org/
> scmi notification v2: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240117104116.2055349-1-quic_sibis@quicinc.com/
> 
> Sibi Sankar (3):
>   OPP: Extend dev_pm_opp_data with turbo support
>   firmware: arm_scmi: Add support for marking certain frequencies as
>     boost
>   cpufreq: scmi: Enable boost support

Sudeep, please lemme know if you are okay with the changes. Will apply
them.

-- 
viresh

