Return-Path: <linux-kernel+bounces-94509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A6B8740D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E287286A48
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ECA140E42;
	Wed,  6 Mar 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq2KT4Gt"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1B140E23;
	Wed,  6 Mar 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754683; cv=none; b=hRQOSd45DQywKYpLDvm3n+2Sdj/cWQu/8bLOO8nnPTRCkKqZpCQhALEAiWHwgDqS1dVndW0S9Rb36mojWs7RJINFp/pX2sVPl3NHsAZ6bCwzCVpEk0D/PthOmYEt5vCtM2LKks1pnazNVFCKHTgRLsQbZt3DgR4rrAwpOgx73BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754683; c=relaxed/simple;
	bh=gNDcxxtPCp3Ie6kOqVmKL+FqDqj4N2k7hc5kPZFFnic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGpUMxbCmE8Iih2Pu9I84aY42nhWdTNN8+du+gGyIkP3UGa9jQskxKe/WXWHaKp5EVWApEixVYc9b0dfwS4IzvZLZVqpeZ/2qR7BGmQV9hGrvR4SxWHaqui0sney0vMth6ft72ZClc+/oIECLrnrihEbmHwU2+uIYqxn68IfOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq2KT4Gt; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29b73143920so936030a91.1;
        Wed, 06 Mar 2024 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709754680; x=1710359480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/5scSK9eywFVdWF/QT915II0GhypL657WWWqgaOSUY=;
        b=kq2KT4Gt1suf3xKSnNS2BOA5gDGIMPJ/L5d/J9SIovaLz+cft2ItZ525nEXJTTrGHU
         xMpUVhtTEpK0qxQX4JHm8RxMv/5pHlrD/JqJe3BLhsqz28bO7GloqJcc1vzJlhX8Z9Wv
         Mnls7p/EOWay6eYAlbMcr4iQlOSzmL0ro68VckqSZqwPxrkyt7MSYvFADNlUntYP6Op4
         s9LffAxyXoW2ktHeJqfwT86PUcYTI0YX7v6hFJyYAPJ2Tz5MNUwfSrZztnhHimkIlCak
         LdW77mSKwHR1pFe0i97EXuEO0MowLfi5Brt6LQUNDXYXysrGS/fcrcmFu0QlbFH8Cj0L
         WBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754680; x=1710359480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/5scSK9eywFVdWF/QT915II0GhypL657WWWqgaOSUY=;
        b=r95Ve1noupN7gRLH8oXN7J+FNNEBYZ0BjNGrcZX1corSxnf8CA1TfJgbBItOYXFdnE
         tBLyfGeDXG7krwIvPxK8y/CjHoG+DUPkmA58514PdTRGtOtDfOYoTc84xRzyxSBNyXyp
         iwq4pESOkuZyDxAitfL+E8CTT1a1qHmCvq3IjYFP9Gu555Hv/haKD5AdBjX+82QPimNW
         4oxuCNzllUW1S4RHh4hYI67Yv4LtJvPtHWcW0zeb1i4cgqcAuamaTH5ADbnGPRiSUlPP
         5mUjCISMsuPm6NhSIWd0lbRc/i/x5y8Dc6PEogrC21b/97gx8ROxMkoEUlp0338F3r/j
         ObTw==
X-Forwarded-Encrypted: i=1; AJvYcCVtvQea1cyr4HvSZoK9/x1Jaw6+VIrbz+XV4darKb0vlUBr54iYvAjha/COMmoAksBTQFL1Z1O41rBMQ90L/U/VZidkh2e6AG20Sk7zLX4+4V3G7x7MJ6cbNmQOvS5EJu9mrhCPgq9CJvwYZgw=
X-Gm-Message-State: AOJu0YwYCgc9xTZ+IkVfNfJSvcMSbO/6oKYBpamcw0Usuz/PsZr4/VzD
	+IohXwTwkh9A2tF5dsh35Xyzq0PkQYaekfiHTtzjYFPxOws3Zpaz1UV2f1wno15oqZg1dncUB7a
	dJMEipSJ4lP74aZl9jxC1pAkLdkY=
X-Google-Smtp-Source: AGHT+IEOmOxjAa4ogttziRxmO01/p9TmAh7mA6UqMqBq39Dne4eQ74iDM8wHySMC+bXE3Fe6VQSKzYsSQE5CYsMNRVA=
X-Received: by 2002:a17:90a:d304:b0:29a:ad3b:6586 with SMTP id
 p4-20020a17090ad30400b0029aad3b6586mr1570003pju.5.1709754680437; Wed, 06 Mar
 2024 11:51:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306123028.164155-1-rand.sec96@gmail.com>
In-Reply-To: <20240306123028.164155-1-rand.sec96@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 6 Mar 2024 20:51:08 +0100
Message-ID: <CAOiHx==HHd3Nu=p5192=tOP-kAzJZUg2iRO2j8UCtcpfGT13nw@mail.gmail.com>
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvalo@kernel.org, deeb.rand@confident.ru, lvc-project@linuxtesting.org, 
	voskresenski.stanislav@confident.ru, khoroshilov@ispras.ru
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, 6 Mar 2024 at 13:32, Rand Deeb <rand.sec96@gmail.com> wrote:
>
> The ssb_device_uevent function first attempts to convert the 'dev' pointer
> to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
> performing the NULL check, potentially leading to a NULL pointer
> dereference if 'dev' is NULL.
>
> To fix this issue, this patch moves the NULL check before dereferencing the
> 'dev' pointer, ensuring that the pointer is valid before attempting to use
> it.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---
>  drivers/ssb/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index b9934b9c2d70..070a99a4180c 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -341,11 +341,13 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
>
>  static int ssb_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  {
> -       const struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
> +       const struct ssb_device *ssb_dev;
>
>         if (!dev)
>                 return -ENODEV;
>
> +       ssb_dev = dev_to_ssb_dev(dev);
> +

The NULL check is what needs to be fixed/removed, not the code
surrounding it. This function will be called from dev_uevent() [1]
where dev cannot be NULL. So a NULL dereference cannot happen.

Most other implementors of bus_type::uevent have no NULL check. To be
precise, there is only one other implementor with a NULL check,
rio_uevent(), and none of the other ones have one. See e.g.
bcma_device_uevent(), memstick_uevent(), mips_cdmm_uevent(), or
fsl_mc_bus_uevent().

[1] https://elixir.bootlin.com/linux/v6.7.8/source/drivers/base/core.c#L2590

Best Regards,
Jonas

