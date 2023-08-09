Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0577E77666D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjHIR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjHIR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:27:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5DB8E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:27:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c1f6f3884so17163066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1691602022; x=1692206822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=locXRAZShx/Ip09/WBeCOmXx0r2GGenxopdxoXszxv4=;
        b=y3JdGKp6XUwqjk5BTCCcWOSzYHLli0AanC7EjSVi+9o0f+WfR+lqztQvdzDIAL9L/e
         0I0VAp5tOdVvxELYy6mxepOWpK+uSajeU12W2WDZGEX8sVKJcruxVBs/oqNHY5aFewca
         WO0DcYG524ZrsJiD5IQlU/R+C4JwtWMlzB6NunHWMbHcCRESKtfc+gg4WRVlJgF9SvUB
         9e6xSq/W+30fyz2Ae4aPIbvi5O/lPTrzk3iTRzDjTcRAh9+Wld7mhzZvEIvJpIOGAB3L
         69Z41NR4qctOqsuv7VkdtCbSLynNkWqE+byOeGGog+kqYbkpoLWsjFPlwcOvZ/XDWe25
         CcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691602022; x=1692206822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=locXRAZShx/Ip09/WBeCOmXx0r2GGenxopdxoXszxv4=;
        b=XY9oH5gkZJ3sfC/kUn7l8NSMhiRaZYrtJ9h4F3JIY4cDjcBz7EVOeF9CtVI4rRJeAa
         WAlHEYkHzgy8LECWNh7XUNJLLJ2C4sYwFEVv4i6G01DR+0gFDkaPf/t9neh9Yae5viJc
         kebfCAuUe1zwVBD8PHZ89fL5TVKiinnkHVhw76MhunCFwVFZtiVoHR3NbtkwhvmhEZkx
         5hwtY6yw/xT4dMcxSXMnV+DAuoZJ0gA7tTurxNfUJdhsbcHmIdbbypxhkpoZEP3FaQnp
         KmaWjXsBvm7H3UqkIpXr4IJI4n5q4R8B53NVcqzzfrslitgbSkqoqdTj0x8Kubm2XYDK
         tReA==
X-Gm-Message-State: AOJu0YxbRGYm6DKAJElVCoIwPQaUg3IAdwvjDzMXRs+fOn4d3h3tI12a
        HI6mbj2HSRfVyA3G+94nS2LLkSTSTTdud3KRUht2wQ==
X-Google-Smtp-Source: AGHT+IHtrMogMIA6OZzL5wgc+r5NnSaIuZnZRBEHDfchxWZ56RmJp/KfgGoxAx8j/5a373SPm/bsc/EoQEvJQeZRbI4=
X-Received: by 2002:a17:906:76d4:b0:99c:581f:7f51 with SMTP id
 q20-20020a17090676d400b0099c581f7f51mr2651367ejn.54.1691602022140; Wed, 09
 Aug 2023 10:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230806233333.815702-1-festevam@gmail.com> <CAJ+vNU0cDTGHoqJMDdwea48RSaETyvsg2NXCcEE3FBNr4-ckvg@mail.gmail.com>
 <3bbd635f-85a6-9031-3264-e5209f8bc44f@linaro.org>
In-Reply-To: <3bbd635f-85a6-9031-3264-e5209f8bc44f@linaro.org>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 9 Aug 2023 10:26:50 -0700
Message-ID: <CAJ+vNU3UERhaODKE_Btzei-HYEkvNK=roBh5i9Z0GQP-9dryBw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8m-venice: Pass "brcm,bcm4329-fmac"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 11:33=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/08/2023 01:52, Tim Harvey wrote:
> > On Sun, Aug 6, 2023 at 4:33=E2=80=AFPM Fabio Estevam <festevam@gmail.co=
m> wrote:
> >>
> >> From: Fabio Estevam <festevam@denx.de>
> >>
> >> Pass "brcm,bcm4329-fmac" to fix the following schema warnings:
> >>
> >> imx8mp-venice-gw74xx.dtb: wifi@0: compatible: 'oneOf' conditional fail=
ed, one must be fixed:
> >>         ['cypress,cyw4373-fmac'] is too short
> >>         'cypress,cyw4373-fmac' is not one of ['brcm,bcm4329-fmac', 'pc=
i14e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433'=
]
> >>         from schema $id: http://devicetree.org/schemas/net/wireless/br=
cm,bcm4329-fmac.yaml#
> >>
> >> imx8mn-venice-gw7902.dtb: wifi@0: compatible: 'oneOf' conditional fail=
ed, one must be fixed:
> >>         ['brcm,bcm43455-fmac'] is too short
> >>         'brcm,bcm43455-fmac' is not one of ['brcm,bcm4329-fmac', 'pci1=
4e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433']
> >>         from schema $id: http://devicetree.org/schemas/net/wireless/br=
cm,bcm4329-fmac.yaml#
> >>
> >> Signed-off-by: Fabio Estevam <festevam@denx.de>
> >> ---
> >>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 +-
> >>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 2 +-
> >>  arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts | 2 +-
> >>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 2 +-
> >>  4 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/=
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> >> index 21d7b16d6f84..cde29aa1a0a2 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> >> @@ -801,7 +801,7 @@ &usdhc1 {
> >>         status =3D "okay";
> >>
> >>         wifi@0 {
> >> -               compatible =3D "brcm,bcm43455-fmac";
> >> +               compatible =3D "brcm,bcm43455-fmac", "brcm,bcm4329-fma=
c";
> >>                 reg =3D <0>;
> >>         };
> >>  };
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/=
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> >> index 964cc4fc2ddf..0bff7a6fdca6 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> >> @@ -726,7 +726,7 @@ &usdhc2 {
> >>         status =3D "okay";
> >>
> >>         wifi@0 {
> >> -               compatible =3D "brcm,bcm43455-fmac";
> >> +               compatible =3D "brcm,bcm43455-fmac", "brcm,bcm4329-fma=
c";
> >>                 reg =3D <0>;
> >>         };
> >>  };
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/=
arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> >> index 3ac011bbc025..9a36edc60394 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> >> @@ -679,7 +679,7 @@ &usdhc2 {
> >>         status =3D "okay";
> >>
> >>         wifi@0 {
> >> -               compatible =3D "brcm,bcm43455-fmac";
> >> +               compatible =3D "brcm,bcm43455-fmac", "brcm,bcm4329-fma=
c";
> >>                 reg =3D <0>;
> >>         };
> >>  };
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/=
arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> >> index 3473423ac939..faa370a5885f 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> >> @@ -737,7 +737,7 @@ &usdhc1 {
> >>         status =3D "okay";
> >>
> >>         wifi@0 {
> >> -               compatible =3D "cypress,cyw4373-fmac";
> >> +               compatible =3D "cypress,cyw4373-fmac", "brcm,bcm4329-f=
mac";
> >>                 reg =3D <0>;
> >>         };
> >>  };
> >> --
> >> 2.34.1
> >>
> >
> > Fabio,
> >
> > Thank you for your continued efforts to squash out all these
> > dt-binding warnings/issues.
> >
> > Can you explain what the difference is in the dt-binding yaml between
> > compatible/oneOf/items/{enum,const} and compatible/oneOf/enum? The
>
> items defines a list. items with enum and const, defines a list of two
> items, where first is an enum (so oneOf few) and second is fixed.
>
> compatible/oneOf/enum is not a list. Or you could look at it as
> one-element-list.
>
>
> > first list for Documentation/devicetree/bindings/net/wireless/brcm,bcm4=
329-fmac.yaml
> > has a much larger set of enums including the bcm43455 on these boards
> > but the second set of enums has a much more limited set.
>
> What's the question here? Both define different things. One defines
> compatible devices with some model, second defines just some devices.
>
>
> > There is no
> > driver code to look at for this because it is bound via SDIO device
> > id's instead of the dt compatible property.
> >
> > Best regards,
> >
> > Tim
>

Krzysztof,

Thanks for the explanation. I see now that if I want to specify
anything other than the enums in the second item (brcm,bcm4329-fmac,
and the pci14e4*), per the first item I must follow it with
'brcm,bcm4329-fmac'.

Acked-by: Tim Harvey <tharvey@gateworks.com>

best regards,

Tim
