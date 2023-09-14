Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB827A072A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbjINOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjINOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:22:26 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43368D7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:22:22 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d81b803b09aso160725276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694701341; x=1695306141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=siGnD8mv7ZGXDqoYiiYARYvMo2BIyjZLHIMQhwKWqcc=;
        b=S3/VHlF5AHxXvFgxZwKe3dknSP5arWJLuu001HyBnTOOV3zGRk4NfFUotMuT2HKUn5
         nTceucGXLK9BT2iVEXVETBCcS+Yd4L3lQRIUHiAc60Bir9pJln3XgtSJFTd1nTtGgBQY
         WgrGu5F2poTuTW2KtOtoGDK70zx8gTq666ROhq+yOM1J2QiH6egC6LgCvVOChYxgsgUz
         zHxuhZGeIHrRx/L6z35BHhIKo7s0JHczqC2S6rNThzNUYex5PI2Qw5KzTWmwedZr8AEZ
         k1eQsHd7yeDyIS2wOZIyHJNakb0s6L6XVqtAuvNRPgICN86Wh3x+HA8rU2a2AVYqAvDc
         EHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694701341; x=1695306141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siGnD8mv7ZGXDqoYiiYARYvMo2BIyjZLHIMQhwKWqcc=;
        b=dEtJu+kRVreEm3EO8tZi6cy4wpIRCi6ngIYfVgBfPdoVAE0XTOOVOnwxEkQm9AzCDC
         bhAEXbHEuBtpyQj40R7Vkb0NspttmWgifnb67QjxPiZ1cSENQNDUfDpAVbYVsdAu7TmF
         AKaKcFVJbaVWveWSc6LG2tGG/5uOznqAe4j4SQZfK4PO5fWAgb3Bmry4APM12pADroms
         MYKBj42fruxWo/meY3p+Dv/MYCvFVX6NtOP6bGteXhTMa8agsIZXRgXpShfbv+1O1BKd
         X+ipUK6yy31sVCorTZU0cpZyf0qINkcV4LI2W1q0td4wAFp48j6E5zfSOv7q+kFTP15g
         K3Iw==
X-Gm-Message-State: AOJu0YwiO2HpiirrDQw0tp2f/kW7I19Eg8SIOTR65+pXxO8qeNAAok7v
        K1rSK8Z9ETgKQySVGoj/rLbTLHWy1VYbN7Kahgg8VA==
X-Google-Smtp-Source: AGHT+IHFAuCP2uoju7CksC5vowKm4+oiBG/gIKeINeuHZ1dgl5os9uYw2gNvRW4Ksk+sIbkGzJA8617U5zKwvSPW0vY=
X-Received: by 2002:a05:6902:705:b0:d71:6b6e:1071 with SMTP id
 k5-20020a056902070500b00d716b6e1071mr7252852ybt.32.1694701341482; Thu, 14 Sep
 2023 07:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230911153246.137148-1-aubin.constans@microchip.com> <fd02d42e-7b24-4f50-849e-b0c752d1f011@microchip.com>
In-Reply-To: <fd02d42e-7b24-4f50-849e-b0c752d1f011@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 16:21:45 +0200
Message-ID: <CAPDyKFpYzgwPvrWntgDQCZo97OZr2qd2FaVXpi7OnNc7i_gYtw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mmc: take over as maintainer of MCI & SDHCI
 MICROCHIP DRIVERS
To:     aubin.constans@microchip.com, Ludovic.Desroches@microchip.com
Cc:     adrian.hunter@intel.com, eugen.hristev@collabora.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com,
        Hari.PrasathGE@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sept 2023 at 07:21, <Ludovic.Desroches@microchip.com> wrote:
>
> On 9/11/23 17:32, Aubin Constans wrote:
> > On the one hand Eugen has taken responsibilities outside Microchip,
> > on the other hand I have some experience with the Microchip SDMMC
> > SDHCI controller.
> > Change Eugen as reviewer and take over maintainership of the SDHCI
> > MICROCHIP DRIVER.
> > Also, take over maintainership of its predecessor, that is the MCI
> > MICROCHIP DRIVER.
> >
> > Cc: Eugen Hristev <eugen.hristev@collabora.com>
> > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> > Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
>
> For atmel-mci:
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Sounds like the patch could be split up, as there is an agreement on
the atmel-mci part.

Aubin, can you make a separate patch for the atmel-mci part and add
Ludovic's ack to it?

In regards to the sdhci driver, I suggest you just add yourself as a
maintainer too, along with Eugen.

Kind regards
Uffe

>
> > ---
> >   MAINTAINERS | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2833e2da63e0..52beaf4f7fbb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14022,7 +14022,7 @@ F:    Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> >   F:  drivers/iio/adc/mcp3911.c
> >
> >   MICROCHIP MMC/SD/SDIO MCI DRIVER
> > -M:   Ludovic Desroches <ludovic.desroches@microchip.com>
> > +M:   Aubin Constans <aubin.constans@microchip.com>
> >   S:  Maintained
> >   F:  drivers/mmc/host/atmel-mci.c
> >
> > @@ -19235,7 +19235,8 @@ F:    Documentation/devicetree/bindings/mmc/sdhci-common.yaml
> >   F:  drivers/mmc/host/sdhci*
> >
> >   SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
> > -M:   Eugen Hristev <eugen.hristev@microchip.com>
> > +M:   Aubin Constans <aubin.constans@microchip.com>
> > +R:   Eugen Hristev <eugen.hristev@collabora.com>
> >   L:  linux-mmc@vger.kernel.org
> >   S:  Supported
> >   F:  drivers/mmc/host/sdhci-of-at91.c
>
