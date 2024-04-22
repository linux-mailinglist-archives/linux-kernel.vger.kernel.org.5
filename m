Return-Path: <linux-kernel+bounces-153436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248098ACE15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F844B23611
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A614F13C;
	Mon, 22 Apr 2024 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNqHNIDb"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4514C630
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792225; cv=none; b=RdcYX+M4qTIBgNn15bS6qzKzMFC9RcqbGJVpHnLmqdvS2FHrZjPBLLN8VJqpyKndCdrF9sLJcuYRsibVTbqwr0uG2hOScITZN7AE+ObG5LuQt0wjINlO7h0zS91LyLymXCMwgB/3pdBdSDYZFFVI9KjVA0g6hMAe0b7oG6aoOxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792225; c=relaxed/simple;
	bh=JEGTtKoYqoRQEIhvAWZYDI4jU+0cahwBSD1cUipuo6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPL4U/iF6VH78TI1pnPgeqiKMtwVoh8ZZQr9UrosegMFPnj3GsVgCMAvJSsFHWsVaH5LA0zSQcGXmueF17l0e28I9WynMJBblLysLx7FiWny10fr7ANz6fGusvfsciZx8eRFGtcbYgIqs1lxHdyGKGGlckOJatuHV4RRoQ7hiCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNqHNIDb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so4749658b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713792223; x=1714397023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=n+oZTUMCoWv4etqAZUIuZUGf6aZKBh2WNmCbx0112Hw=;
        b=JNqHNIDbA8551iuSsypykD5rl/wpx09BtLZKyJ2UeNmQBc0OMztkH83OKE+Hbb2XD7
         58wl7XrbZp8khX8ciiqrF1S2ZBHP+5HzBq7XaCOD2Sh8Rxcl2jO6CdNAEOu9M/u+Lkgw
         kC212jG6MdnTtM/RsMHK9wmUyRe5Y6qJN4ajCkXpY2Wd+uRWfNAalnZn4n0OtoaeF+s/
         wPJOw2YKN8ZC+b+nySa74N1D6ut5Z6qzjLH41f+vRIhL07cr7xTEMayKncjnhV3iAbiC
         90Wxs6zBp4okMW5nwwGcRgmYti2Lec7luP5LPz5+Qh1yVXBCiPnvTfSnx6ZzIkUCrI3r
         cizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792223; x=1714397023;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+oZTUMCoWv4etqAZUIuZUGf6aZKBh2WNmCbx0112Hw=;
        b=REjxCkNekrz6DcEhLdrIbj14RFLcLaSPU/2Wnum4COGlqpeYbrRSm0Z544lyxYk6WR
         r4C4CP885wtc8KbP1f+epjb4T+JuP0BkY+t0eUdB59kc7mhkrr6oBZ3PKXNY9VVll+v3
         L592vIWkFd8/j+uSdKfeypUYpoFhDLIZppL7mDygYz5M16lx8JwP5Eyl5Wrfn2Im4a1t
         N4PUNLD6v8BuJl73PjIQSqXdyuCPsd7GLbNOsTQqCEapjaf6uDFq5GK5EG5Lq4SrZtYT
         Vm6FCn7YvBk/nA7dzfZiI6aJKhTKFtOriT5EGvVhmGoBWYqAR8wnhukkjnQQJW9hUDGl
         NWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsau6q/s146BYiZobet8KAP6s6t9pEWwk2NhDoGPPUN09XVtyNdxI0EYug1VHx58QaeY6nRg49TPSwEdjTflrSfOlhu6FIt+36uvJ5
X-Gm-Message-State: AOJu0YwP97A46l/XoJGQTVvt/OaDRS9ivdY4F6vvP05ckLrqibqQPbNV
	6j9OLBvXFKEsUoEdUg+9iAIuanfVjUrMB0VI2gB/Oka0wz+UP43w
X-Google-Smtp-Source: AGHT+IEPcnKY4g2pRyWqnFuQQ/gDygqZlZk+2XS6X1rWZlGRFxvQWbICY6zNqrCttHC4G9ejm4Xh+w==
X-Received: by 2002:a17:902:f608:b0:1e8:c994:b55b with SMTP id n8-20020a170902f60800b001e8c994b55bmr14318258plg.7.1713792222894;
        Mon, 22 Apr 2024 06:23:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ju24-20020a170903429800b001e3d8c237a2sm8074538plb.260.2024.04.22.06.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 06:23:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <18d4811a-7c92-4bd7-b44f-aacf3c1f2f65@roeck-us.net>
Date: Mon, 22 Apr 2024 06:23:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: change stubbed devm_regulator_get_enable to
 return Ok
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, Aleksander Mazur <deweloper@wp.pl>
References: <ZiYF6d1V1vSPcsJS@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZiYF6d1V1vSPcsJS@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/24 23:38, Matti Vaittinen wrote:
> The devm_regulator_get_enable() should be a 'call and forget' API,
> meaning, when it is used to enable the regulators, the API does not
> provide a handle to do any further control of the regulators. It gives
> no real benefit to return an error from the stub if CONFIG_REGULATOR is
> not set.
> 
> On the contrary, returning and error is causing problems to drivers when
> hardware is such it works out just fine with no regulator control.
> Returning an error forces drivers to specifically handle the case where
> CONFIG_REGULATOR is not set, making the mere existence of the stub
> questionalble. Furthermore, the stub of the regulator_enable() seems to
> be returning Ok.
> 

Yes, that was the reason why the lm90 driver worked pripr to its conversion
to use devm_regulator_get_enable() if CONFIG_REGULATOR=n.

> Change the stub implementation for the devm_regulator_get_enable() to
> return Ok so drivers do not separately handle the case where the
> CONFIG_REGULATOR is not set.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reported-by: Aleksander Mazur <deweloper@wp.pl>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: da279e6965b3 ("regulator: Add devm helpers for get and enable")
> 
> ---
> Please find the report by Aleksander from:
> https://lore.kernel.org/all/20240420183427.0d3fda27@mocarz/
> 
> This patch has not received testing. It'd be great to hear if this
> solves the issue.
> 
> I see the regulator_get_exclusive() and devm_regulator_get_optional()
> returning errors. I thus leave the
> devm_regulator_get_enable_[optional/exclusive]() to do the same while
> wondering if this is the right thing to do, and why...
> 

At least one of the callers of devm_regulator_get_enable (exc3000) checks for
-ENODEV and ignores it. I assume we'll see more of those unless this patch
is accepted. Many of the callers of devm_regulator_get_enable_optional()
explicitly check for -ENODEV and ignore it. Others fail if CONFIG_REGULATOR=n.
My plan for affected hwmon drivers is (was ?) to check for -ENODEV and ignore
it to match other drivers.

Returning ERR_PTR(-ENODEV) for [devm_]regulator_get() made sense because
the returned regulator pointer was often used to obtain a voltage or to
do other regulator operations. I don't really see the point of returning
-ENODEV for the _enable APIs if regulator support is disabled.

Anyway, for this patch:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter


