Return-Path: <linux-kernel+bounces-90413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CACC86FECF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD7028359F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14003C497;
	Mon,  4 Mar 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1v6gwCK"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51EA2574D;
	Mon,  4 Mar 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547414; cv=none; b=Bg2cse9RsPWukdnP1InQmkGN0IYh5llLkrS9/KW+WsmD/rjGIEa4SXC4JPQZM7ITHBT/vx48mVfRyW25inSp0Gmo7i3I7ZNhfE2LGT/10r87/p+B5KtF4AfuBNREofXyUfizlRZ2cwXubbJI4blRCuC5KwrvPhDDqovAqTQBgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547414; c=relaxed/simple;
	bh=r9R7fsoaFTssCD4S8pAvGpfWz79/sdKQ+D2RchM3Vp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sACfMU//dZUIQWAhOoYx7BTdnKjzvzlQbTs+cwoiYGqY36o1tgZdEeKvEEnretEZbOFq6mWQ36SP25BM6x/01rcOAuyYcs3av0O+A6vHetHmv5eg/M26Sagid60/wcN+oDer7coNFj12tGvOeBJBG92zbcGEDNbcHj3gFrmYLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1v6gwCK; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a0932aa9ecso2244363eaf.3;
        Mon, 04 Mar 2024 02:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709547412; x=1710152212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9IduB56gCouP3puaRFBT9qXQWpSpTWONTThlDJRHj/0=;
        b=m1v6gwCKzw48XrtMF9FKJ7IGIkm2+RdpmNCD6V2UnWqJrnPCCIHAw1M7/lmyl31oRa
         gnvlz1YoolMrnWd4A59JTsRiAquY/9e8zuVwkB3tueL1zgN1ZJX0MWgr88ygXbOWEEnY
         /BEJOARYB+t5VihMuRgbzJnPHYpQAVdrUVUsivWg31JU2B20fOJ5lhIfK1ghfxAXbSFa
         HyDk7Q/h1ZTeT3BvM8qdjQ5h6oZPYDmIqqQEp7zWAZDNEkcb9paqLXvpzcpbgvpEjjaH
         MddkcwIpqTE4AHojjE3khyIwleeAfpBHAWvuT7iF23L2DgDJ+O7FSwRyv3/7O/gAKlRT
         YuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547412; x=1710152212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IduB56gCouP3puaRFBT9qXQWpSpTWONTThlDJRHj/0=;
        b=t9OuSEJQBD0APTWMN9oXqD+WZ6xJRRr2nyYOyB89nxzDIfr4QnzRpT/GTzRbyHQ8o+
         nEKK7Z5KcfjLkS9uUUrFbbAEfUv9Z/xVY/iSaroxCvET6WvGwCtcPHy0WJwcFhqTa9c9
         J9HUhcxturenhMuMJNC5kiKMAwpMaakzSan1NSmSTGgbPBWCZdey+8zbAwyWq5rDSSHP
         zyH3geKJNs6gHZbKXe0kNCY6LV42OwwLcqM5u4N8eEmr/nKiMqMqpY/ypIrHQaDxINBk
         EnaL81gKmv9VTUyk10nQhnnRzTh3ye7Il7gjOD4plTkyGXQCUAkSk+uz9avsVbq9hm2L
         43wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHN2W0nefe09Q1Ssc/tXfdXwWFpR/qwzdgqKtJPL4XPkkRqi0CHkqgoUGs+EpGVRiwSN4aol65A843lvUxw5KH361bODi7L9xQMeiyj6lxbOorFbwqXXDd4m52nl0ctgJ3ID238nByVZNrvf/Tf4tQ7WSd0KwnwFZYeYzS0D9q9TDspwrbhqbQBz0=
X-Gm-Message-State: AOJu0YwtTW8uGZpJ2dxeRNtXMlzPv5vvHu8LaozsnQ95I0b6LkNiV3Rq
	Cec+TEziiTep0UUskOQyNnpHSTVG5o47dNxpbL9clwzr51lRhrOmLdEtg9MsNmbIol+ppGe//qr
	2grawcS0m4upTJPykFO4n5cnBvMk=
X-Google-Smtp-Source: AGHT+IGKlDQiwe2ETynuP1WjM66TUUfTvgAkEekSsjW8GST4aMh5tCx5vaqg6xAtZrzbO88Nx3b5zZhE0vTBzIOc68s=
X-Received: by 2002:a05:6820:808:b0:5a1:ff2:4c46 with SMTP id
 bg8-20020a056820080800b005a10ff24c46mr6436866oob.9.1709547411912; Mon, 04 Mar
 2024 02:16:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193831.3346-1-linux.amoon@gmail.com> <20240301193831.3346-3-linux.amoon@gmail.com>
 <ZeWSp4ohOhHGclud@hovoldconsulting.com>
In-Reply-To: <ZeWSp4ohOhHGclud@hovoldconsulting.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 4 Mar 2024 15:46:39 +0530
Message-ID: <CANAwSgShe9-Buyta5Ej9nmhp1dy467da6Cdfm5a+pwpEjem=QA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] usb: ehci-exynos: Switch from CONFIG_PM guards to pm_ptr()
To: Johan Hovold <johan@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Mon, 4 Mar 2024 at 14:51, Johan Hovold <johan@kernel.org> wrote:
>
> On Sat, Mar 02, 2024 at 01:08:09AM +0530, Anand Moon wrote:
> > Use the new PM macros for the suspend and resume functions to be
> > automatically dropped by the compiler when CONFIG_PM are disabled,
> > without having to use #ifdef guards. If CONFIG_PM unused,
> > they will simply be discarded by the compiler.
> >
> > Use RUNTIME_PM_OPS runtime macro for suspend/resume function.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/usb/host/ehci-exynos.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
>
> >  static const struct dev_pm_ops exynos_ehci_pm_ops = {
> > -     .suspend        = exynos_ehci_suspend,
> > -     .resume         = exynos_ehci_resume,
> > +     RUNTIME_PM_OPS(exynos_ehci_suspend, exynos_ehci_resume, NULL)
> >  };
>
> This is also broken and clearly not tested. See the definition of
> RUNTIME_PM_OPS() which sets the runtime pm callbacks, not the suspend
> ones:
>
>         #define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>                 .runtime_suspend = suspend_fn, \
>                 .runtime_resume = resume_fn, \
>                 .runtime_idle = idle_fn,
>
> Johan

Ok, I will drop these changes.

Thanks.
-Anand

