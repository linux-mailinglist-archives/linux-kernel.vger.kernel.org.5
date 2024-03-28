Return-Path: <linux-kernel+bounces-123697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18D890CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A8BB22A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E3913B784;
	Thu, 28 Mar 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgrPeAsG"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550E13B2B0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663233; cv=none; b=M9obC8urAbj76LsOfp/gh45voEX/kAXE0JHWjzNUx1PpYZNfjMalnaS+bgPEpmrEp1A70+INXLcG4TxAuQGE7rubia5psjfuOmVeiL+0zllmBKWDsA6yYMGDv+mt41iAOlv7L3z0hppzuT4PQ/Akh+3gxyCmMbWQRtEgpkDcKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663233; c=relaxed/simple;
	bh=/5ShKS2I5HOZ+M86MaNNhos7tZdJ6tALgsSh5kaTARo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf+CG2i9KQDCMcL+c36y71AjPCpXeaJnV6JNlrJrUMV53VvjwrXiKDLLdj+2XRKI8FibdO5d47Y9cPAC4myisLrA20Q+TT2XwUuZpS5GiCY8aw2AH8/ecjj/9X58iFnRiK18J9EeQMp5VKTkn8B6iezMoVTzRdvGLnkR3iSzBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hgrPeAsG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609f1f97864so16656047b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711663231; x=1712268031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8LWmQEfer8ejO45BikMeQB8+xHEa60SulCja1mzY/U=;
        b=hgrPeAsGBtKkIDCkCtXMhYSeQfSqQ8Eu+H7YAAWg/Fyk5izhGNcvnLAftmN74pjalC
         qcyn4k7s5npVGrhdJKJ4A8/nqTaZ6tC6iYWktDmvcuupRTdgtOzGUuTCfWW+Nq5YTNi+
         bqekqUycBuwfNrvz130lIup8ghXdIYsTZGz8JnX9qtGkqc+kMrJ9z+ojDWZHDAi0xMeX
         iExNkRv/GFIDHPoJdvPbcCxwPXQAhZDEJtt2CO3uS9HPTql4SpUutETMmLrI00yx5OiS
         SKB1WSi5LFxhUj/sTLweNQ/KJ9O1IyYzys7Ez6IuOtP1ygfvvX8gohcEHGl1RVigwVW5
         Ssrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663231; x=1712268031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8LWmQEfer8ejO45BikMeQB8+xHEa60SulCja1mzY/U=;
        b=FFDi9Q9bjXn6NYI4bDUFQrfR/vP717HOMba/ZyXORTaDXOhJvT/kexltgow1VPiQiq
         F/vm4iJIbwZc4pWD560Oi7wzsFUKZjTYV8wvcL5zPJxbEX87uDhqCTlsw7Prl4oQ32Qn
         5cJXBxGlDzZuR0qJV9pPfw9tCDDHaw78q3T+8xlaFUOq6xQtr3LL/NkdVQGo3kYNSb6b
         qI6BB0bL98o/syNEywqyrTmHzwhiixnehyciUdkCMrRwOn6oGZicIJwfKoywKrqfAlrJ
         HL7aY1V7BHKQYmLWOgD+IHUjDq+nZpwm7mUPNH9Br3UHsF+Iy29PKIoDFIyoYkLfIdN2
         8kRg==
X-Forwarded-Encrypted: i=1; AJvYcCUpBjZuPG22sSCUgsD7Q+JuoMsuvTDHPWU8crBSx8FoQBYlza3pq7+1Zy1G46NxfZEaYlsWPeQ0hxFqh2vHO34kewG6WH3zEZDVdRMT
X-Gm-Message-State: AOJu0YxVi92gIHYT00VJpWdq5dxBvkFANqmT7n0YhETtxKXXakGghzOl
	lOz9fUOayT+Jk0E9J+CPL0Fy4Bp9E8qm8NzRhL9w8r/kyPvq8NKDtEeQC3cXBMGLyF0gzeLtisg
	k6xTsyOeQVo//sLAcbu8RgNg50nUMH8nPU9FjZQ==
X-Google-Smtp-Source: AGHT+IFKTlhxo5mhLpmv4Enu6A4flubvBEGa1+sb99OBmJRhBVArCLejpOyDtntLufE/YPSliQ+4VUsczm9MCK+Nfvk=
X-Received: by 2002:a25:1184:0:b0:dcb:fb49:cb93 with SMTP id
 126-20020a251184000000b00dcbfb49cb93mr597178ybr.45.1711663230642; Thu, 28 Mar
 2024 15:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320165930.1182653-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240320165930.1182653-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 23:00:19 +0100
Message-ID: <CACRpkdYkh7EFWehDStQRpB_2pau9qNaM02U1=VBRxC7hsbmSEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpiolib: Fix debug messaging in gpiod_find_and_request()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Stephen Boyd <swboyd@chromium.org>, Ferry Toth <ftoth@exalondelft.nl>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 5:59=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> When consolidating GPIO lookups in ACPI code, the debug messaging
> had been reworked that the user may see
>
>   [   13.401147] (NULL device *): using ACPI '\_SB.LEDS.led-0' for '(null=
)' GPIO lookup
>   [   13.401378] gpio gpiochip0: Persistence not supported for GPIO 40
>   [   13.401402] gpio-40 (?): no flags found for (null)
>
> instead of
>
>   [   14.182962] gpio gpiochip0: Persistence not supported for GPIO 40
>   [   14.182994] gpio-40 (?): no flags found for gpios
>
> The '(null)' parts are less informative and likely scare the users.
> Replace them by '(default)' which can point out to the default connection
> IDs, such as 'gpios'.
>
> While at it, amend other places where con_id is used in the messages.
>
> Reported-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

LGTM
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

