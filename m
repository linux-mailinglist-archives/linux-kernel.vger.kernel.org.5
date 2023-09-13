Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A2479EA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbjIMOHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjIMOG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:06:59 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE2719B1;
        Wed, 13 Sep 2023 07:06:55 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6543d62e9a4so4404686d6.1;
        Wed, 13 Sep 2023 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694614014; x=1695218814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SVzpvJyQ79cqOeCOnbam7O9cjKj9BttoysEnsRs/uM=;
        b=MbQ63YRi3YCQsGz/kJKQpXlDUkFoDOKZYRKiaZEw3S5KfrgoGgbCWSitkPqf671Fep
         IO+s+Stv36zmB6wNYeQFL4sf3mTLeJ/Qlet8GhiRJEiDk/qcjHQkQh/WsSid/AXYfjqA
         EjzgoRXrm6ZATz2rY9EM9K4LllZzcJ8PxFIIgktNKqxoVggQeADa3Kppq3r9Ry1nCzbK
         s4DKm4Fz5YSebPt2XVSof7tcN1YsfypZ7g5tVJK59KAyCCV6MTI7xwEWgC8cCXVLrOD7
         KM/Lh2acTehla5yDV5Nj/6lN4T+i4WbKDoF4m0CexXoNiltmMX4BwmdjeZdMg6r7BPu6
         oQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694614014; x=1695218814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SVzpvJyQ79cqOeCOnbam7O9cjKj9BttoysEnsRs/uM=;
        b=Jzif9CaYog1bQiCN8vrIlIKEQS29uPpV7OmnmMyKL2zOF1ZgKpNjnbEYsnabYeNZhA
         2m/ktAIrHwEj9XiUe3sHUX+kYbpRBKdrp+D5aiwyOhYESXLh8ah90xxpQ1oq4DNbhkQz
         wWKWbPDA6WaBJtrVvOov+VfbK8w2NOQGBb8tWT1cDXfNLJJLgj89S5i4J13GgGRRTq5q
         2Ytug968HBRGkBg+L+r8GTmnNPRbwWxeGynsHqebeySGmy7sWZRIuJm6pD4BuGXcXkcu
         JjhQojlSjOZplBPi3lwf/OWqEchqKdOJ1FYZr142H8pZEvpaqUPPVHY386PHfJHrGXt2
         DtHw==
X-Gm-Message-State: AOJu0YyybHolDBjYWjGR/qe+oCGMryN8VeVDQ8TTuvngv+bmtYMhtuj/
        +4xzMjhWp4mg52rsn1suN79hmeoLjAxHvWW4ILg=
X-Google-Smtp-Source: AGHT+IGUBofx2QUGO40aHH0tMK0OQB083JOU4Kl31Ibbf/55KPiYWU6g3VDRmXNrjg+zyMkEylga1UnXSckBBe6qmmA=
X-Received: by 2002:a05:6214:2cc6:b0:656:12e4:cb87 with SMTP id
 lf6-20020a0562142cc600b0065612e4cb87mr847046qvb.25.1694614014483; Wed, 13 Sep
 2023 07:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-3-yangchen.openbmc@gmail.com> <1bfdc230-e358-6aa4-7d60-03b5477a6be9@linaro.org>
In-Reply-To: <1bfdc230-e358-6aa4-7d60-03b5477a6be9@linaro.org>
From:   Yang Chen <yangchen.openbmc@gmail.com>
Date:   Wed, 13 Sep 2023 22:06:43 +0800
Message-ID: <CALFa7M_bAvpm50Mvi738ZcY_oQUgJftZO56Eht7Kw9n80H2oow@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        patrick@stwcx.xyz, Jerry.Lin@quantatw.com, Eddie.Chen@quantatw.com,
        EasonChen1@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2023=E5=B9=
=B49=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:04=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 12/09/2023 16:05, yangchen.openbmc@gmail.com wrote:
> > From: Yang Chen <yangchen.openbmc@gmail.com>
> >
> > Add linux device tree entry related to the Minerva Chassis Management
> > Controller (CMC) specific devices connected to the Aspeed SoC (AST2600)=
.
> >
> > Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile             |   1 +
> >  .../aspeed-bmc-facebook-minerva-cmc.dts       | 265 ++++++++++++++++++
> >  2 files changed, 266 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerv=
a-cmc.dts
> >
> > diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/
>
>
> > +
> > +&i2c15 {
> > +     status =3D "okay";
> > +
> > +     eeprom@50 {
> > +             compatible =3D "atmel,24c128";
> > +             reg =3D <0x50>;
> > +     };
> > +};
> > +
> > +&adc0 {
> > +     ref_voltage =3D <2500>;
>
> There is no such property in the bindings.
Thanks for your advice, I will change this property to
"aspeed,int-vref-microvolt" which is defined in the binding in the v2
patch.

>
> > +     status =3D "okay";
> > +     pinctrl-0 =3D <&pinctrl_adc0_default &pinctrl_adc1_default
> > +             &pinctrl_adc2_default &pinctrl_adc3_default
> > +             &pinctrl_adc4_default &pinctrl_adc5_default
> > +             &pinctrl_adc6_default &pinctrl_adc7_default>;
> > +};
> > +
> > +&adc1 {
> > +     ref_voltage =3D <2500>;
>
> NAK, there is no such property.
Thanks for your advice, I will change this property to
"aspeed,int-vref-microvolt" which is defined in the binding in the v2
patch.

>
>
>
> Best regards,
> Krzysztof
>
