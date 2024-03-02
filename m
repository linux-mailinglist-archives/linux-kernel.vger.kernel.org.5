Return-Path: <linux-kernel+bounces-89509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3FA86F157
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B23D1F220AB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF352261F;
	Sat,  2 Mar 2024 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2R0DoYH"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445E249E4;
	Sat,  2 Mar 2024 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709397363; cv=none; b=l1kRNFNYNglTbaOHaX3nBnWKKijmHg64cLo7gpGcazd2IZyejno3voTJMdMsy6SCQKXWIjCZTSROGuIWqW3LRTX4mKrTX6r/edhPh/bg9EX7qqn2CkryDwOsL2VGZMJc8JTXUs2RC4b/skfMrMus/I9F+ED8qM8AFXAy3WfrUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709397363; c=relaxed/simple;
	bh=Xtbx2nuYQWaCxqLgTDSpprolfWKnQ7oHy+aJnjiL7EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKloqYGtnHBdX97odUSGhgEOCF69dz62scld/NM/9Mt/dSVwDvonJTW0KDzamX8VK7b0M5YQYbPeVj6wrrVAk2dEHc7fubUFVpcNO0CHFfCyLbjDcNErXQODwVKjFQnk4QswaDn0pziP827SyUYJvWkouN4VXsO0Ma+LP0nDRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2R0DoYH; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1e7a92a8eso121843b6e.1;
        Sat, 02 Mar 2024 08:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709397361; x=1710002161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmozHj9JCHaLBysyp3+5vSLKONfn8+Lx9doGoqfw5j0=;
        b=h2R0DoYHItdrYUwjW2TRFddUILhfpIKa+Adv2BAcqVPWbwAHm1zsYZceqCA4CFHNcK
         jhpFKJ/MDqmGDLEbR0fj5Jy1Sc7O3WtaOl9rqf2AOMRDFAKk4JFOg8il9nvsUTt1p+vM
         n16e4PIuAoEzxyQdCU//eJdF/ObA01P3Yb6xJwhqur2W+dfBFGeQr3MJ+91/u4/EJO2l
         C8rq6XWlmDmOn2QQs9OHqTuO/jbEVs9t1Swf2jVDk0gXg99bRK9vjMN7HLZlWiOe2eO8
         sfsH1VJYlsJd5qOlnk+lNd6NXh3EEvhrJtUclMWNGrQBHDbfB6uEq7S5TPsazz0qhG6h
         y3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709397361; x=1710002161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmozHj9JCHaLBysyp3+5vSLKONfn8+Lx9doGoqfw5j0=;
        b=fWKdcX5jobD3UO3bUXEHjnkrFuXbdHCIQ6eI35Y6KAwvc4gxedeUJVdkc9H4u2sV9+
         lw1R9ciqtTcHy+kghvcc1Ax4rNjXoCe/pErJXD17n0x96ShiHeh310WGZZPHvqNygVW2
         BjeEzpQaqwgD7SaCgcw6ouULLETlx4nDKlcAQP6iodL1/H0f/sk+nBqppyv1pCQKn0Zw
         mh9qv/KDcVIEjDVVWdIHKUZ59yYABXpC5RuO2Xc/CfAtr7DcsGpH5LrEVRozd9etqhk6
         AeoHKhKXttCl3BrBK0WWuu/lvYr6gmcEal9m5XxouXcJN0dzge6fzRiv+kb+a0nTw6Ti
         EssQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyrQXIJAudwca12PXttSI8Te7z5pGK5fwjc1AK/omc6G6MWsAp2mz1cbA+iMPADu7XwB4REYtaqtpsx8Ae91MGWuUj9IpQNy6kG4PxBtqG1W5ZfzsmDNibEAx49rSrjTE9qEZ3VVopKS7E+4RrFZrYCLsLXRYZ3oODKm/wjvWPHSGOz7VhfFaVkF4=
X-Gm-Message-State: AOJu0YzX18pqWQSg8ntkTmHtINwUdiaBj4rhveFMj6Zxa1wFaxIKXglt
	5PZGqKBlPu3dtE5gY7e2E6iom9KZAhD/jNtHmRi9JEj9eqCZxE+PEeeZZgLoWuq3m3oXqWoxTnb
	e5Racy6ciUKLaqbHEz1dUzOIFKU4=
X-Google-Smtp-Source: AGHT+IE/hmhDISfbeu6Of94WJBDXm80DHpfhb3KQdUwmZi1drGckce+BfkYWP75tx/tTTDDdE89FUa+AnizRUXo9G1U=
X-Received: by 2002:a05:6870:e305:b0:21e:e583:25e1 with SMTP id
 z5-20020a056870e30500b0021ee58325e1mr5567366oad.32.1709397361171; Sat, 02 Mar
 2024 08:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193831.3346-1-linux.amoon@gmail.com> <20240301193831.3346-2-linux.amoon@gmail.com>
 <3d1c7682-d163-4bcf-bd41-d7db0c8f61d1@wanadoo.fr>
In-Reply-To: <3d1c7682-d163-4bcf-bd41-d7db0c8f61d1@wanadoo.fr>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 2 Mar 2024 22:05:46 +0530
Message-ID: <CANAwSgR0aQ7nt1y5xknvVjHSnfvTaC8JZMLWurb8z2D0Oxg6Rw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] usb: ehci-exynos: Use devm_clk_get_enabled() helpers
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Sat, 2 Mar 2024 at 21:19, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 01/03/2024 =C3=A0 20:38, Anand Moon a =C3=A9crit :
> > The devm_clk_get_enabled() helpers:
> >      - call devm_clk_get()
> >      - call clk_prepare_enable() and register what is needed in order t=
o
> >       call clk_disable_unprepare() when needed, as a managed resource.
> >
> > This simplifies the code and avoids the calls to clk_disable_unprepare(=
).
> >
> > While at it, use dev_err_probe consistently, and use its return value
> > to return the error code.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >   drivers/usb/host/ehci-exynos.c | 30 +++++-------------------------
> >   1 file changed, 5 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exy=
nos.c
> > index f644b131cc0b..05aa3d9c2a3b 100644
> > --- a/drivers/usb/host/ehci-exynos.c
> > +++ b/drivers/usb/host/ehci-exynos.c
> > @@ -159,19 +159,12 @@ static int exynos_ehci_probe(struct platform_devi=
ce *pdev)
> >
> >       err =3D exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
> >       if (err)
> > -             goto fail_clk;
> > -
> > -     exynos_ehci->clk =3D devm_clk_get(&pdev->dev, "usbhost");
> > -
> > -     if (IS_ERR(exynos_ehci->clk)) {
> > -             dev_err(&pdev->dev, "Failed to get usbhost clock\n");
> > -             err =3D PTR_ERR(exynos_ehci->clk);
> > -             goto fail_clk;
> > -     }
> > +             goto fail_io;
> >
> > -     err =3D clk_prepare_enable(exynos_ehci->clk);
> > -     if (err)
> > -             goto fail_clk;
> > +     exynos_ehci->clk =3D devm_clk_get_enabled(&pdev->dev, "usbhost");
> > +     if (IS_ERR(exynos_ehci->clk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ehci->clk=
),
> > +                               "Failed to get usbhost clock\n");
> >
> >       hcd->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &re=
s);
> >       if (IS_ERR(hcd->regs)) {
> > @@ -223,8 +216,6 @@ static int exynos_ehci_probe(struct platform_device=
 *pdev)
> >       exynos_ehci_phy_disable(&pdev->dev);
> >       pdev->dev.of_node =3D exynos_ehci->of_node;
> >   fail_io:
> > -     clk_disable_unprepare(exynos_ehci->clk);
> > -fail_clk:
> >       usb_put_hcd(hcd);
> >       return err;
> >   }
> > @@ -240,8 +231,6 @@ static void exynos_ehci_remove(struct platform_devi=
ce *pdev)
> >
> >       exynos_ehci_phy_disable(&pdev->dev);
> >
> > -     clk_disable_unprepare(exynos_ehci->clk);
> > -
> >       usb_put_hcd(hcd);
> >   }
> >
> > @@ -249,7 +238,6 @@ static void exynos_ehci_remove(struct platform_devi=
ce *pdev)
> >   static int exynos_ehci_suspend(struct device *dev)
> >   {
> >       struct usb_hcd *hcd =3D dev_get_drvdata(dev);
> > -     struct exynos_ehci_hcd *exynos_ehci =3D to_exynos_ehci(hcd);
> >
> >       bool do_wakeup =3D device_may_wakeup(dev);
> >       int rc;
> > @@ -260,25 +248,17 @@ static int exynos_ehci_suspend(struct device *dev=
)
> >
> >       exynos_ehci_phy_disable(dev);
> >
> > -     clk_disable_unprepare(exynos_ehci->clk);
>
> Hi,
>
> I don't think that removing clk_[en|dis]abble from the suspend and
> resume function is correct.
>
> The goal is to stop some hardware when the system is suspended, in order
> to save some power.
Yes correct,
>
> Why did you removed it?
>

devm_clk_get_enabled  function register callback for clk_prepare_enable
and clk_disable_unprepare, so when the clock resource is not used it should=
 get
disabled.

[0] https://elixir.bootlin.com/linux/latest/source/drivers/clk/clk-devres.c=
#L75

I have also tested with rtc suspend & resume and did not find any issue.

> CJ

Thanks
-Anand
>
> > -
> >       return rc;
> >   }
> >
> >   static int exynos_ehci_resume(struct device *dev)
> >   {
> >       struct usb_hcd *hcd =3D dev_get_drvdata(dev);
> > -     struct exynos_ehci_hcd *exynos_ehci =3D to_exynos_ehci(hcd);
> >       int ret;
> >
> > -     ret =3D clk_prepare_enable(exynos_ehci->clk);
> > -     if (ret)
> > -             return ret;
> > -
> >       ret =3D exynos_ehci_phy_enable(dev);
> >       if (ret) {
> >               dev_err(dev, "Failed to enable USB phy\n");
> > -             clk_disable_unprepare(exynos_ehci->clk);
> >               return ret;
> >       }
> >
>

