Return-Path: <linux-kernel+bounces-90103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1009B86FA66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B3F1C20D0D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5C13AFB;
	Mon,  4 Mar 2024 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g16hHZIQ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010413AF3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535663; cv=none; b=RpTpJtiS94DiHysG7dOgjp5niMIIYLX7cUrDaa1WyTDBa1H+ZD86tthydJqrg+fq0tmlqqW7KelzwMK/ZKZpXSaKkrTjX6T4usxh+OrkcnVaA77yo2mk+zpo5CPH1/IK0MAc1DbkLNVtuC01aXRnF/E2hskfwL9uFW0V/Qjypc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535663; c=relaxed/simple;
	bh=upBZ3X4KyzBhefJvfJWbA3FwdXqEK3kl16bErZwbfYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYsU5STH7o6ZFuHhjblerV0kFptDmR84trk2zjlMqkhCzuHiFkJ9l/dsXEcpIGRBPIuk9Z1EFgdLs+1oQ6f6zVJQUGBwSERYjByPcrScyqC68kNABJk/SefsRf+JPbTOF4q+EMJo737+ZMlDwOqmu38EiIQwrI+HVBiNzWtnWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g16hHZIQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dccb2edc6dso33591845ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709535661; x=1710140461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gERSIBQAtMeYIzaUm04+6jDxHIyp8hzEX/WUtLzEWU=;
        b=g16hHZIQDA4PqYQXY7Kbd8IzvSji9ISNB6ubabcWDg1arkEdJD43ZflBq1Xlt9soDV
         e1RhBYdbSYxHUo6aVdTsmApVsOkkDl6AK7gc7tXIek9XHl13ntFgGIq3svtt1lMYuj3B
         EyGIcCIBdsWquCXRqZo+jOqVbKagmryu0OKKq9eXEUr1+Xie/O17ETCffAhknhZ43YXc
         AYi9wwpFIroGMESjvOyckZsK8HF8ZYTCU8zS1GgNKu6ASE9qhTvYUZYGt47Z2sJNDJOe
         Pa48LqJx+NfuDGBPtqNLicpolsAkPiuC5z/3BYPdbHXyWepgvp7PdPtTW7ukpGf+gynq
         JqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535661; x=1710140461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gERSIBQAtMeYIzaUm04+6jDxHIyp8hzEX/WUtLzEWU=;
        b=hPZNDbkQi5yHrZrmsapvQLC8W2Tf4xGUkvMOFnxDgP7S4TIYS32DKBAek9BLgSyUMT
         Z0Ln7GYZEFzjqUnKUnUWDTvmMyMvcbC4h4KvybIVfiSRuCnjtmT+KEYD+iKrtJeTeFBl
         EE3SYnAWUFgh8Xf+bwezi3Chop64mg4XXfmghAF/96GYbAGKCx2TPrZ2K+gZQSv+m7DK
         lwNvLuNeelmreAG9Gbs6524bRK+RK3aWrfRSAkPuAjcO2MA6xbTwgVVu3wsgICulA0OP
         XSNM9iTLFy9xK0N5J+VymslRChE4/iT5Cw+3Bm3r0jd55m9TTuWNbH4aiTip4TzQ8IYO
         onSQ==
X-Gm-Message-State: AOJu0Ywzs3WPJyQhI8eQEk4YEvhP9u4mU6PrxRyTb3VOKz2/DoelArCK
	Xz9ShgTN+PMrTw8eb90Hp90mGnic7UtXHXTz4HCfkbk5HBqy6jenjq0Wx9Eruv4=
X-Google-Smtp-Source: AGHT+IEkpf0f5HD53mpwoT/e2x1p6+nsLCC+7Oq38TcI/bj0FDtTuR+h843J2e7GJbLWWhkRw6bwyw==
X-Received: by 2002:a17:902:ec83:b0:1db:f952:eebf with SMTP id x3-20020a170902ec8300b001dbf952eebfmr8764554plg.44.1709535661270;
        Sun, 03 Mar 2024 23:01:01 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902968400b001db8145a1a2sm7715773plp.274.2024.03.03.23.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:01:00 -0800 (PST)
Date: Mon, 4 Mar 2024 12:30:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3]  scmi-cpufreq: Set transition_delay_us
Message-ID: <20240304070058.kfqg3ypssn5x6k7s@vireshk-i7>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222135702.2005635-1-pierre.gondois@arm.com>

On 22-02-24, 14:56, Pierre Gondois wrote:
> policy's fields definitions:
> `transition_delay_us`:
> The minimum amount of time between two consecutive freq. requests
> for one policy.
> `transition_latency`:
> Delta between freq. change request and effective freq. change on
> the hardware.
> 
> cpufreq_policy_transition_delay_us() uses the `transition_delay_us`
> value if available. Otherwise a value is induced from the policy's
> `transition_latency`.
> 
> The scmi-cpufreq driver doesn't populate the `transition_delay_us`.
> Values matching the definition are available through the SCMI
> specification.
> Add support to fetch these values and use them in the scmi-cpufreq
> driver.

How do we merge this series ? I can only pick the last commit.

-- 
viresh

