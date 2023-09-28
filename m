Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8F7B2491
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjI1SBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjI1SB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:01:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A53319D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:01:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad8a822508so1749510866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1695924084; x=1696528884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiur2uBooxXQUwnNCRFKyJNY9Mbndh5Va49ZBRlBVnE=;
        b=EQe67hE51E/a6VgfxXlBAzZCIDwxZJPDV2ZBN3AT9RwqBeUYxm8q69zZdJ0jEA/gNf
         IirJYjKSyZUgJt1PVEw7QrLXIcCxUV+PSY5zKHYzggHDxp0gvCesEyMZKaIqE3bSk0oO
         JpemQ1kLIjtcjLBQ+hM9p7gozeHe4O4tV1rVdoQBaceOU7yDyBixyslDIKOkp+6tI6zz
         5Yo1CjTihKtDAhxhT+cM+5fkC2IWNMFApqpMm77AP8NdAB38ffhHQkP6oJu8ibCr78pt
         BbkfnHJ3fZ84OxQ6HWGjHbjnjokI2oXg8vssBisDXNTinYXDkSHfXlp3Agym3+0bRDLh
         PsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695924084; x=1696528884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiur2uBooxXQUwnNCRFKyJNY9Mbndh5Va49ZBRlBVnE=;
        b=TBLcnrYe1PlNrwv8moPwmkwrtmrEf/Po5DxCFLCprlJj1BlVYPs/yBQrLMFnpEGhQ+
         ugh/F9TjwdKm0JIeflhpKWAp4S2SSaZ4h2eQVpTLGe/kAtNih3dDBzpHmVsviU4rR1eF
         9xLenFz2HwqU1w3BeZrSZSdzlMl6hMwmwcmRm9zHc3DM2E29sq/Uo7yCBZUZUGSbTEl6
         bVypsNTDq7s2D3yCpmIA3hAY2XEnBixVTgKATEUizr3stR2EJ6y1v43P9atYTuAZMVIx
         kh51PAYzhp7WIMg06GSWQB3l1xXACl9bnqq1lnQ7YYwMqFmHeELz4EYal8LNIYZbxa2n
         lGcA==
X-Gm-Message-State: AOJu0YzhEet2VObv+sfMaasBEMGTBdexnDhSwV0zWPDgsPyzesg/tDr6
        U74Gn313sTXPL/Yu5n3mY5bATCVGx6kbyiBXXqoqOw==
X-Google-Smtp-Source: AGHT+IGaXe8uTKz9Ra+54w7HxJaOzDdbmCsFVteQiYOGSh3tR/eEZ9h+AFAxYV1KjHvtL2mksRiQ52ceS6LkJ4KGNgY=
X-Received: by 2002:a17:906:5393:b0:9a1:f73b:90ce with SMTP id
 g19-20020a170906539300b009a1f73b90cemr1949184ejo.54.1695924083992; Thu, 28
 Sep 2023 11:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194335.1451802-1-tharvey@gateworks.com> <a3b3d647-4995-4d55-b6f9-a93119caf86e@linaro.org>
In-Reply-To: <a3b3d647-4995-4d55-b6f9-a93119caf86e@linaro.org>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 28 Sep 2023 11:01:11 -0700
Message-ID: <CAJ+vNU0R_zU2wh1Om9wgLp4ZREAJia5uxBCgrO7MxNmcZf7uLw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw73xx: add TPM device
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 12:58=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/09/2023 21:43, Tim Harvey wrote:
> > Add the TPM device found on the GW73xx revision F PCB.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  .../boot/dts/freescale/imx8mp-venice-gw73xx.dtsi      | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi b/=
arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
> > index 48a284478468..43e5e838cefa 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
> > @@ -95,8 +95,17 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
> >  &ecspi2 {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pinctrl_spi2>;
> > -     cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> > +     cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>,
> > +                <&gpio1 10 GPIO_ACTIVE_LOW>;
> >       status =3D "okay";
> > +
> > +     tpm@1 {
> > +             compatible =3D "tcg,tpm_tis-spi";
> > +             #address-cells =3D <0x1>;
> > +             #size-cells =3D <0x1>;
>
> Why do you need these?
>
> > +             reg =3D <0x1>;
>
> reg is always after compatible
>
> > +             spi-max-frequency =3D <36000000>;
> > +     };
> >  };
> >
> >  &gpio4 {
>
> Best regards,
> Krzysztof
>

Krzysztof,

Thanks for the review - I will remove the unnecessary properties with a v2

Best Regards,

Tim
