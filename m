Return-Path: <linux-kernel+bounces-90120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B04386FAA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9275E282EDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74E134D8;
	Mon,  4 Mar 2024 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sV0iYLs/"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0AA134A3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536936; cv=none; b=pbirSh9PevGpp9LLNwzLqYzJCpLHSa3ZsS7b/Fk0vDHI2ZmKjJeeu5MBrGEocMLlww3RyPN9/pR/J58XmrFJHp6Ohc6bxm1r2yPLfIsrKOfm/qmjkjJ5YHWh1ETUAt2ehXMU5olqv+9+/QHqUykuuZJbT5gdpQTvcMi/zGmqMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536936; c=relaxed/simple;
	bh=O/kfQPkIV9JlvqxHj3mnwQ7B0NpO0wYlAi0L3j79bP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsDUEL+CSPop4MveuAe0xQ810G9cNcg0FVCRqPc29KbOh8EVEhmTaKJ3QYgIwCggLUTtTY02tVHgH6TOVqrhKzQ3CPmq9WrCY39woWxckaUeX11RUTguIYVjiwBxqQP0j7xu3UK0/1QzOygb/P5qr2eavacGp/2NiWTg7kKZMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sV0iYLs/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc5d0162bcso34660135ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709536934; x=1710141734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7IOi+lBwBPEsnrXI1uHhBJLz+FkscxIVherwRbg+HQ=;
        b=sV0iYLs/eLmkXTcMrxuDlbdzRrUF0h52EEncB0FADBX7uwaL3t24UQcRD0wFTbuaV+
         zZXRX5WmtD9gvW1dGq96eTc6q1suXB26SkEJRIi5q0pvgeYPXAf5mLvAewGCqcEI59M9
         oqVcu2Bvew9xSNBhakOvPWvvRGqtmL2YzxsPn8imBFGsmkjFoi1KF1KJdklQp3Ce2t4D
         oqva9oTusRnSK9wtcgjS8FVwAXMGYq4G668TUEnb9sWelGumCseHEKOE2munvUbnmkkF
         TeZCGqqSL2g/PRnsD7qkBzoVf6CrDFx82SycAcVX5W8Sk3qteLs8Qz+vocsUvU1ZT/yT
         ASQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709536934; x=1710141734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7IOi+lBwBPEsnrXI1uHhBJLz+FkscxIVherwRbg+HQ=;
        b=Wj2GO/B5NliFedgDA+CoTL8pif6ke6iQP/OZNDr8UXNEo2Hk8iCREHDIFgfND87PwO
         aL24BLPkdVF2n4F2e6Swr8xJFzMhJ87z5huLbIlaPc42sm5N8zTYkvZm3SfkG7KgvRhh
         skoS70nBHRvQnmAb2nTjsrljt9ZX8sIk8TpDoxBGEdY0xfFZWmm+U3auakNGp4OJfmX4
         QxMOEzmhXF/qL73DhMaKZZJie8ub4TKmsh4VHdZjhOR81P9vBytyr3D/FQ9EXUDK1pGG
         wRQOxQ3bDLh9SJMc/5a6877og3zIi/H5olDO9Su2QH3t3hRhhiPG6B+tr8/UyniJoPp1
         xtJA==
X-Forwarded-Encrypted: i=1; AJvYcCXLMTjmCwdhxoix+BxGAtHw5l4CXF3SqGC7nLNDpZOujNPvYbuMRO/b0EhXoyu3qrNzOfZoIGi9DOglGc3kTFT7ioPKAWSUHnIsjL5r
X-Gm-Message-State: AOJu0YyA2M5upu5a/o7zT54gRC2oloqlUx0bsqWDU+0bz3npUvr5cD9o
	wkwyWYI5/iU8l8LkmHiRUzeAl9nEuO7y/pz3xHUsuJSHT1gHE75nyFzd/2DyF+4=
X-Google-Smtp-Source: AGHT+IHilpBY5IrWPN8JeI/zH1EYi232lMDhDDtxciRZja+KuMbEyCFyJZWkIbhb3Bed1Pe5GUJEKQ==
X-Received: by 2002:a17:902:e552:b0:1dc:3c3f:c64d with SMTP id n18-20020a170902e55200b001dc3c3fc64dmr9306319plf.3.1709536934190;
        Sun, 03 Mar 2024 23:22:14 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902c40b00b001dba98889a3sm7725307plk.71.2024.03.03.23.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:22:13 -0800 (PST)
Date: Mon, 4 Mar 2024 12:52:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: sudeep.holla@arm.com, Sibi Sankar <quic_sibis@quicinc.com>
Cc: cristian.marussi@arm.com, rafael@kernel.org, morten.rasmussen@arm.com,
	dietmar.eggemann@arm.com, lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH V2 0/3] cpufreq: scmi: Add boost frequency support
Message-ID: <20240304072211.luj44tpybmschl5t@vireshk-i7>
References: <20240227173434.650334-1-quic_sibis@quicinc.com>
 <20240304070911.lr6uye75ykz4gilj@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304070911.lr6uye75ykz4gilj@vireshk-i7>

On 04-03-24, 12:39, Viresh Kumar wrote:
> On 27-02-24, 23:04, Sibi Sankar wrote:
> > This series adds provision to mark dynamic opps as boost capable and adds
> > boost frequency support to the scmi cpufreq driver.
> > 
> > V2:
> > * Document boost flag. [Lukasz]
> > * Remove sustained_freq check. [Pierre]
> > * simplify sustained_freq_khz calculation. [Sudeep]
> > * fix default per-policy state. [Dietmar]
> > * fix typo in commit message in patch 3.
> > 
> > Depends on:
> > per-policy boost: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240227165309.620422-1-quic_sibis@quicinc.com/
> 
> It doesn't really depend on it, just that there is a bug that needs to
> be fixed.
> 
> > Sibi Sankar (3):
> >   OPP: Extend dev_pm_opp_data with turbo support
> >   firmware: arm_scmi: Add support for marking certain frequencies as
> >     boost
> >   cpufreq: scmi: Enable boost support
> 
> Sudeep,
> 
> Can I apply this series ?

I have gone ahead and applied [1,3]/3.

-- 
viresh

