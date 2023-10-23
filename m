Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A26A7D30AF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjJWLBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjJWLBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:01:09 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6FF10C2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:01:04 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9ac43d3b71so3045665276.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1698058864; x=1698663664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQnyw3MjdCXKTfyQSa/jGUuKdoEycBcWTe0sh3zaKAg=;
        b=hTCnmESm0n9IdCN3jOGrqBRmMrgLENDWDIXphQB0v/rbTChX5BHJNWGO7PpIDg51lA
         ibv14Xq+gI4ZtgNh5Vi/4Fe0EA75NxMZhuueZo3AzT0/4MPy0iHb6AyHi1dAFLsK+HwP
         ILEOCDaT+eBYSPu+7HQAZ/O9e8p3Mbzj8cyGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698058864; x=1698663664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQnyw3MjdCXKTfyQSa/jGUuKdoEycBcWTe0sh3zaKAg=;
        b=G6dPT+K1yN59FgIoHmEJ5gpyjtVlzoG7X+Xdp+N19RvJP2++0nX4TCvlVd+E7wilnL
         I81F0jiFYvvIzqoIMbv3YS2zQxx4BIV9CmydvNdyTzjokjzZ2HRLKmK4MvEE4fYKJAyn
         9bi7iZmnDD71AWMtohqBm3OC5PWJRdw9YUpLoc08qgSzW3YYPnHKHlwD5ZDIDh4xmrI/
         tuacs1S1e7FnVrAhbz8ajjd1cofg4Q4WDkGNEAJ5YiUcZBorOWf/vrBjY+ghnbXMOcbz
         +pfqaYCda8v74ZtRp5b6tpACeY+S6crhe68s5AycnrZPvsb/PGuDi5rg8bcQIliPE/qM
         FKOw==
X-Gm-Message-State: AOJu0YyVQGYFQp3D0ft6UVD8wt6UPUFdhuAZL64GeUvy59ZGDaNQg33c
        CXXDq8cnybqvPJXQLgKQ4Dk9lV0AxJD1dek/CnTL9g==
X-Google-Smtp-Source: AGHT+IHsgGGa2skrDGr96nwbMOiC55O2cCdp4sM8NTs6qixH/wFcZIQVI1iSePRLMK2nXAYF5AkwHSE0OOXJHQbWoxA=
X-Received: by 2002:a25:4217:0:b0:d9b:3b3e:5a07 with SMTP id
 p23-20020a254217000000b00d9b3b3e5a07mr7276609yba.5.1698058863818; Mon, 23 Oct
 2023 04:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230904180635.923506-1-dario.binacchi@amarulasolutions.com> <5e75b5fd-c351-1f42-94ed-b6dc1d3f030e@foss.st.com>
In-Reply-To: <5e75b5fd-c351-1f42-94ed-b6dc1d3f030e@foss.st.com>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Mon, 23 Oct 2023 13:00:48 +0200
Message-ID: <CABGWkvquib1WEKGR-DFiNN62gLcYF3Y==K29_w-=9pV0gnjEqg@mail.gmail.com>
Subject: Re: [RFC PATCH] ARM: dts: stm32f469-disco: use the same 3v3 for SD
 and DSI nodes
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexandre,

On Thu, Sep 14, 2023 at 10:57=E2=80=AFAM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> On 9/4/23 20:06, Dario Binacchi wrote:
> > In the board schematic, the power supply for the SD card is the same 3.=
3
> > volts used to power the LCD panel and other peripherals. By generalizin=
g
> > the name of the voltage regulator, it simplifies the device tree and ma=
kes
> > it more readable.
> >
>
> It makes sens as it is the same discret regulator (no pmic involved).
>

I don't see it applied to linux-stm32/next. Is something missing?

Thanks and regards,
Dario

> regards
> Alex
>
> > Link: https://www.st.com/en/evaluation-tools/32f469idiscovery.html#cad-=
resources
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> >   arch/arm/boot/dts/st/stm32f469-disco.dts | 15 ++++-----------
> >   1 file changed, 4 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/st/stm32f469-disco.dts b/arch/arm/boot/d=
ts/st/stm32f469-disco.dts
> > index cbbd521bf010..8a4f8ddd083d 100644
> > --- a/arch/arm/boot/dts/st/stm32f469-disco.dts
> > +++ b/arch/arm/boot/dts/st/stm32f469-disco.dts
> > @@ -69,16 +69,9 @@ aliases {
> >               serial0 =3D &usart3;
> >       };
> >
> > -     mmc_vcard: mmc_vcard {
> > +     vcc_3v3: vcc-3v3 {
> >               compatible =3D "regulator-fixed";
> > -             regulator-name =3D "mmc_vcard";
> > -             regulator-min-microvolt =3D <3300000>;
> > -             regulator-max-microvolt =3D <3300000>;
> > -     };
> > -
> > -     vdd_dsi: vdd-dsi {
> > -             compatible =3D "regulator-fixed";
> > -             regulator-name =3D "vdd_dsi";
> > +             regulator-name =3D "vcc_3v3";
> >               regulator-min-microvolt =3D <3300000>;
> >               regulator-max-microvolt =3D <3300000>;
> >       };
> > @@ -164,7 +157,7 @@ panel@0 {
> >               compatible =3D "orisetech,otm8009a";
> >               reg =3D <0>; /* dsi virtual channel (0..3) */
> >               reset-gpios =3D <&gpioh 7 GPIO_ACTIVE_LOW>;
> > -             power-supply =3D <&vdd_dsi>;
> > +             power-supply =3D <&vcc_3v3>;
> >               status =3D "okay";
> >
> >               port {
> > @@ -219,7 +212,7 @@ timer@2 {
> >
> >   &sdio {
> >       status =3D "okay";
> > -     vmmc-supply =3D <&mmc_vcard>;
> > +     vmmc-supply =3D <&vcc_3v3>;
> >       cd-gpios =3D <&gpiog 2 GPIO_ACTIVE_LOW>;
> >       broken-cd;
> >       pinctrl-names =3D "default", "opendrain";
>


--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
