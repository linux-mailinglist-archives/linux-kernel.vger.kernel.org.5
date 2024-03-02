Return-Path: <linux-kernel+bounces-89480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206F086F0E7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97377B22592
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A423A1E892;
	Sat,  2 Mar 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldbE4Xzb"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB591BC44;
	Sat,  2 Mar 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394133; cv=none; b=NXbm6vqi6HD8Y0826stL21hL6qU91LUnHNepV28VI6GqTeFYV87xy3seCplY4YBBEi30DGpkPhWuz8LtVpBT4zOLjjj7CJWVMTGCX11wmdYfbjRJrvn4+HJnZQIf3XfPjIrEfY47DqojsO0lq3IGzfAi3iHbeETDqKhAzrWf1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394133; c=relaxed/simple;
	bh=GndPFW3ZeOhsg6TV5TPlXvv0chx0vpvmJpX+pPqnDhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXp7B53+vesfAi7O6HlDQ50Tyy9k5MWBJOwTcNZ9UmWkHWJOvzglRUmq3ihGtkI9VlJo7V457giNYIhTZ/5IP9q4yo0cS2Ey1YyxJTDE3D+h05F2hAb29nKls5G97M8LjS9p0YfEFwiOP1TV/ElmLs1j85Eu8/WDornHZbchdkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldbE4Xzb; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a11b781a79so337874eaf.1;
        Sat, 02 Mar 2024 07:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709394130; x=1709998930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s7RhG4vxHt8Dk6ktHYVdXLXH46IhWtDO5k97LLOdGGQ=;
        b=ldbE4XzbQXr1P3S3CLwvFL+OyIr+hY6nn4CaC91AsxG9yLyxN91TGX6zTkJ+/kjp0e
         paRq5BqVQN1qQ6IwkvKSYAwXfFUeniooeSNnFDQjSkkSd720CyGgOO4LN/G/X5UN3B0K
         ZIAqh7/Dw3JEZm4PJSeyTxQuJ3NqDxpkDI95f+0E4wteWtUbJ3mA2u7yT1/62nIRLmlt
         +dJz4RVYyWSxXnFPXzI9eFi1bra0csHyDLzmmCLd/BSZgngYh3f5rk9kwYjt4Y/DeuGv
         5O3HKsVeUr4WP2GlgVMEZaFFO4C5WrNDpcs5M8huKT8gi9KQ20QK6FK6VE2M+cWSowLi
         QSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709394130; x=1709998930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7RhG4vxHt8Dk6ktHYVdXLXH46IhWtDO5k97LLOdGGQ=;
        b=T5GRNYXQ+nJecyKGldlAvYb2qUwtKaJD0UGGYOcnyRa/mBR0k4/MNeTYyl9xohVmZ7
         tFwnBVceKjgkenD/cdof4+C24OjiuqQ+Kj+asGVRpvaSQe/qPgbVVuP+e46LkK24d+NH
         Ya7XXeSiU2sMe0IYmNAbMAAoQ5X9XVGpnM5ZZ0fFDglaEqiON7aD+9Z+9ZPjRmjNleqv
         Ad9VAZZYq6hPx4wDEgpnzhn+/c4JW+0mEDvBUDrG0EECKInNIHT4R1N7H80xk7/PcMsn
         XwJmdPAnyiBCDqlDbjI5si8QJcttWrXPp46HU1SAQs9sMUXx+HgusTvuZlD6FC5MPkJ8
         iz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwv54L2B26lrHwkGkEVe90CMBppIKkGRkocr8RnjfS6OeoGlrgHOhsiiLmZF4HAd59ZNv+bf0caGEQzQ1hlkVdeBQoo9RkaDnrtALUbQ6RcA027YTkUtKw4OZamAsfoWgocRWN6wGrR+/n/FrWh4zuEMsMoUYx9P5QZ2iOZcXzR5b0KQtpuMz4AV4=
X-Gm-Message-State: AOJu0YzcWL9v+0guQyU/zpbQdqERL6ZLM7tQwiURdeg4n8Teja9RDjyN
	bniTjOqskLy3h4ml4Lwx2PXkgfDLnkERNuumVxpO167Gv18cF1qyS4s9C7PjL3M9tJaYbnc7CzH
	2sCF6hrfGNnk3dvI0MBVXegojfio=
X-Google-Smtp-Source: AGHT+IE8J0NSExiaRYqNiR+vM4QnH/09T1Fgx6PzJqkrpemovrvhHrIaSP6Qtc/YD7czILhdJ/QBV4k7yniMvD/W/F8=
X-Received: by 2002:a05:6870:b526:b0:21e:8afd:65d0 with SMTP id
 v38-20020a056870b52600b0021e8afd65d0mr4764327oap.52.1709394130537; Sat, 02
 Mar 2024 07:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193831.3346-1-linux.amoon@gmail.com> <20240301193831.3346-2-linux.amoon@gmail.com>
 <d3c72bbf-2dd2-4d7f-9882-08710baa3f3a@rowland.harvard.edu>
In-Reply-To: <d3c72bbf-2dd2-4d7f-9882-08710baa3f3a@rowland.harvard.edu>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 2 Mar 2024 21:11:56 +0530
Message-ID: <CANAwSgSaT5TQDp-hRO===ky+XLe4D9+1pboQTRu9nEFsOT=FNA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] usb: ehci-exynos: Use devm_clk_get_enabled() helpers
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alan

On Sat, 2 Mar 2024 at 01:49, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, Mar 02, 2024 at 01:08:08AM +0530, Anand Moon wrote:
> > The devm_clk_get_enabled() helpers:
> >     - call devm_clk_get()
> >     - call clk_prepare_enable() and register what is needed in order to
> >      call clk_disable_unprepare() when needed, as a managed resource.
> >
> > This simplifies the code and avoids the calls to clk_disable_unprepare().
> >
> > While at it, use dev_err_probe consistently, and use its return value
> > to return the error code.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/usb/host/ehci-exynos.c | 30 +++++-------------------------
> >  1 file changed, 5 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> > index f644b131cc0b..05aa3d9c2a3b 100644
> > --- a/drivers/usb/host/ehci-exynos.c
> > +++ b/drivers/usb/host/ehci-exynos.c
> > @@ -159,19 +159,12 @@ static int exynos_ehci_probe(struct platform_device *pdev)
> >
> >       err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
> >       if (err)
> > -             goto fail_clk;
> > -
> > -     exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
> > -
> > -     if (IS_ERR(exynos_ehci->clk)) {
> > -             dev_err(&pdev->dev, "Failed to get usbhost clock\n");
> > -             err = PTR_ERR(exynos_ehci->clk);
> > -             goto fail_clk;
> > -     }
> > +             goto fail_io;
> >
> > -     err = clk_prepare_enable(exynos_ehci->clk);
> > -     if (err)
> > -             goto fail_clk;
> > +     exynos_ehci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
> > +     if (IS_ERR(exynos_ehci->clk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ehci->clk),
> > +                               "Failed to get usbhost clock\n");
>
> What about the usb_put_hcd(hcd) call that used to happen here?
>
Ok, I will update this in the next version.

> Alan Stern

Thanks

-Anand

