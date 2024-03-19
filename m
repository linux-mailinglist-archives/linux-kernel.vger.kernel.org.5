Return-Path: <linux-kernel+bounces-107625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D106587FF51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552D52831EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DE08173D;
	Tue, 19 Mar 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QboZVeOC"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691517D3EA;
	Tue, 19 Mar 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857230; cv=none; b=lgKV2KPlYuNhe8GRFVYFZPWeuBTE2gKG4h0GFXc4OcnpYJZ1tSG8bAfpIbLz123nR3SXIyPt+n0GMr8TkuLoCCYc4L/VgRYZMRv9IQLZGkePEdxBR8Ob1uVWQCil3hwejzPnDnP3j41MhMtiID+IcZK+9JrYtPNRuBXLDvm4wUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857230; c=relaxed/simple;
	bh=pRuZMlLOvOCtBUHG6gDGRpdoz38rFmiYXsWOnKTa1PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkANvn8X3LGw0gNq/bnRmzNgRKEGiEGNsVRRQKAdKDHewMMMPh8qqXl84Icg70AApDSQsJHgz2g0NpPvhUTzXJ7lF75N6sFRoACa9ZGrQDThisxvjEnJZEgjrKc/cJHYOI9cDUAfV9Q6eqghv/YOhhFuv9RRZiBOBessA99/qvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QboZVeOC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1df01161b39so28765475ad.3;
        Tue, 19 Mar 2024 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710857228; x=1711462028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RREg2igfyHsUB9UVUQWGd5w14ea5dynh8ZqR2r9I7Ow=;
        b=QboZVeOCY6lcYOu5uJ77SU999TKl1rEuEH3h2LOUSJCEo1bhZQTS8Rhfmvrbhvg7Mm
         DtGiSOuDgxiD1ToAriNvR1O2wj9SoiewQVcVFJOAF7ZIGR3xGSNJHHo4nb4qcUVz4aWW
         MupASjjrhO06/Ou8C9JNiHwVJbPLvSxV1uL+4HeY170pLfpLG1bUOCS2NQ4pr/yjhwYn
         RcECzY68axfjd/DSfviSexaN+JOGkA+41TBsr9Q8V7Nh/raed41eKjinStFGemzDAB99
         /tFkJIqkFE16PQz9K1smTn/aL4K1xYIKEJ1LxEqVSH6sXgTFW7YtbZI++JIMSUaaUZjg
         Ji1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710857228; x=1711462028;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RREg2igfyHsUB9UVUQWGd5w14ea5dynh8ZqR2r9I7Ow=;
        b=SS+NOLh7BT4lLK6/zb0mVXB/o7E7Xd2DNc9PtwPvC67D+13ZUhIPSXYiJnBfwJBYKX
         3yeai6f7QBcZsxzQCFo+jBpKubSGnpzNuKGmZ/TwwpHO0oQw9EZuFdx3EyGXdEWTk7oW
         TLukC75L1DBAHS04B+n5ddAj2RK6n51vL9p6k3dXa/tYO6D3TZmyw3bg0jdsDwihAhPC
         FNHTG9uP7ee6U8XL68emrgtsQsa/RDeeNhAsQ5rOTp4vQ0DKRkM5+pCR8OBox2wQdjrL
         vdW9D08SBw0Hr+Ds5Db4s5jxF7f24nRLtcTVNEG9NgJ8XHONU+7ezZ8N4mGTwCAaMBTt
         4uSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXupOJ+tNN1K7VBU70R45Z/cn/p0n3uaAXKjHTkBvw028OSLiBvg8C8/Y+LXgKYezOBp1MF0bTRhiDr/eXGgHR+u9jwq102FymxhCGxGvLerMwgRqrDthJYgAf8au+jPNd+F5DLINpwkFnyTmw=
X-Gm-Message-State: AOJu0YySTBL9Ftdekve0kB8V7dcZdCa5Xfh8Xcoo+EQvMQq4rC/o0fy7
	MQr5JJBdsUjcYcKNXf8/FcchmFSeO1DCqXWNL9mY8qAglpGWu7cP
X-Google-Smtp-Source: AGHT+IEXfyZYvUe4BW5f4SBetB2P3H5AzqMYAtH46gSwzFC4nX3Ud7Wc30Tvvd4cJoM83cmWFvH7cw==
X-Received: by 2002:a17:903:244c:b0:1e0:444:5f55 with SMTP id l12-20020a170903244c00b001e004445f55mr12945718pls.47.1710857226659;
        Tue, 19 Mar 2024 07:07:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001dd4b1fb72csm11433192plb.189.2024.03.19.07.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 07:07:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e4c2d5a-9f28-4946-b69d-63f5af3bc3da@roeck-us.net>
Date: Tue, 19 Mar 2024 07:07:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: xilinx_wwdt: Add check for timeout limit and
 set maximum value if exceeded
Content-Language: en-US
To: Harini T <harini.t@amd.com>, michal.simek@amd.com,
 srinivas.neeli@amd.com, shubhrajyoti.datta@amd.com
Cc: srinivas.goud@amd.com, wim@linux-watchdog.org,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240319111219.21094-1-harini.t@amd.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240319111219.21094-1-harini.t@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 04:12, Harini T wrote:
> Current implementation fails to verify if the user input such as timeout
> or closed window percentage exceeds the maximum value that the hardware
> supports.
> 
> Maximum timeout is derived based on input clock frequency.
> If the user input timeout exceeds the maximum timeout supported, limit
> the timeout to maximum supported value.
> Limit the close and open window percent to hardware supported value.
> 
> Signed-off-by: Harini T <harini.t@amd.com>
> ---
>   drivers/watchdog/xilinx_wwdt.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
> index d271e2e8d6e2..86e2edc4f3c7 100644
> --- a/drivers/watchdog/xilinx_wwdt.c
> +++ b/drivers/watchdog/xilinx_wwdt.c
> @@ -36,6 +36,12 @@
>   
>   #define XWWDT_CLOSE_WINDOW_PERCENT	50
>   
> +/* Maximum count value of each 32 bit window */
> +#define XWWDT_MAX_COUNT_WINDOW		GENMASK(31, 0)
> +
> +/* Maximum count value of closed and open window combined*/
> +#define XWWDT_MAX_COUNT_WINDOW_COMBINED GENMASK_ULL(32, 1)
> +
>   static int wwdt_timeout;
>   static int closed_window_percent;
>   
> @@ -73,6 +79,24 @@ static int xilinx_wwdt_start(struct watchdog_device *wdd)
>   	/* Calculate timeout count */
>   	time_out = xdev->freq * wdd->timeout;
>   	closed_timeout = div_u64(time_out * xdev->close_percent, 100);
> +
> +	if (time_out > XWWDT_MAX_COUNT_WINDOW) {
> +		u64 min_close_timeout = time_out - XWWDT_MAX_COUNT_WINDOW;
> +		u64 max_close_timeout = XWWDT_MAX_COUNT_WINDOW;
> +
> +		if (closed_timeout > max_close_timeout) {
> +			dev_info(xilinx_wwdt_wdd->parent,
> +				 "Closed window cannot be set to %d%%. Using maximum supported value.\n",
> +				 xdev->close_percent);
> +			closed_timeout = max_close_timeout;
> +		} else if (closed_timeout < min_close_timeout) {
> +			dev_info(xilinx_wwdt_wdd->parent,
> +				 "Closed window cannot be set to %d%%. Using minimum supported value.\n",
> +				 xdev->close_percent);
> +			closed_timeout = min_close_timeout;
> +		}
> +	}
> +
>   	open_timeout = time_out - closed_timeout;
>   	wdd->min_hw_heartbeat_ms = xdev->close_percent * 10 * wdd->timeout;
>   
> @@ -132,6 +156,7 @@ static int xwwdt_probe(struct platform_device *pdev)
>   {
>   	struct watchdog_device *xilinx_wwdt_wdd;
>   	struct device *dev = &pdev->dev;
> +	unsigned int max_hw_heartbeat;
>   	struct xwwdt_device *xdev;
>   	struct clk *clk;
>   	int ret;
> @@ -157,9 +182,11 @@ static int xwwdt_probe(struct platform_device *pdev)
>   	if (!xdev->freq)
>   		return -EINVAL;
>   
> +	max_hw_heartbeat = div64_u64(XWWDT_MAX_COUNT_WINDOW_COMBINED, xdev->freq);
> +
>   	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
>   	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
> -	xilinx_wwdt_wdd->max_hw_heartbeat_ms = 1000 * xilinx_wwdt_wdd->timeout;
> +	xilinx_wwdt_wdd->max_hw_heartbeat_ms = 1000 * max_hw_heartbeat;
>   
>   	if (closed_window_percent == 0 || closed_window_percent >= 100)
>   		xdev->close_percent = XWWDT_CLOSE_WINDOW_PERCENT;
> @@ -167,6 +194,7 @@ static int xwwdt_probe(struct platform_device *pdev)
>   		xdev->close_percent = closed_window_percent;
>   
>   	watchdog_init_timeout(xilinx_wwdt_wdd, wwdt_timeout, &pdev->dev);
> +	xilinx_wwdt_wdd->timeout = min_not_zero(xilinx_wwdt_wdd->timeout, max_hw_heartbeat);

I have not tried to understand the rest of the code, but this is just wrong.
The whole point of having max_hw_heartbeat_ms is to make the actual timeout
independent of the maximum hardware timeout.

As for the rest of the changes, max_hw_heartbeat_ms should be set to the
maximum hardware timeout. Similar, the minimum timeout should be set
to the minimum timeout possible. As such, the checks added above should
not be necessary. Something looks wrong, but I won't spend time trying to
understand this because, again, limiting the actual timeout to
max_hw_heartbeat is just wrong.

Guenter

>   	spin_lock_init(&xdev->spinlock);
>   	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
>   	watchdog_set_nowayout(xilinx_wwdt_wdd, 1);


