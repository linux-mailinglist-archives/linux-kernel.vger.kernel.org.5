Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D688774F93
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjHHXxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHHXw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:52:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D2C198D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:52:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99cbfee358eso511968266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1691538777; x=1692143577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNHcxyY8uAbrLOV+yNc02fSgEaBar5i9jaS0vjO2gZ4=;
        b=qtnKiwyfpFHZFX2PeO+WLRfpHUlPJogeQbaK2WRnjKla4ILCWWPJmnhwqXrNSt701D
         0XRvT4eDgLhu4zn8GMfIgdxeeEaW0Ca0wcVCVOoCP/oaCtdSyQHHAMHgNoLrmZ4Yj896
         +fk9yVjSxjRlNNZ9HfdcRDu+hJH/858TnHjqHqYBltQ8aU4XaH4Rd2wIsfJvKe8/LWtq
         h7UMcsm1pnKdgjD+iu0/qlaKXdsF30+QdIiOHIA5sqqyXtIpEvZDWQVIIH+hjCakaFTP
         1CczNg/Dlc/WtIBdM0a07wTyY3AYgR6l0y674q2GZr6KpkaZhbAFgwq+FpHA9PLXBHa1
         +BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691538777; x=1692143577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNHcxyY8uAbrLOV+yNc02fSgEaBar5i9jaS0vjO2gZ4=;
        b=Jh7jIciumJR+Md/j2ZPhco8cexBzOKSd06ARhKCGFT4938r3SOQODTAAa7dk5Ak/sg
         mgDOlLsdX4c0Bi4/z+LTJq9veASggkH97WplmaSfn32tdjNJ9OIWF50kBw3jz6jOfFvP
         SxU6lQNv9I2MVonkiWjVLYAb8YWsDsM8yUosNixfVtKibbZhycsEaqepoj+v25BL3u8P
         iYiXpTdudVfhCBtXcL8BoVjBPYz7/UYASj4g+/B2spEjtF1cD/yKBugxuBsmgh1zbdDb
         qNduWJ+qd7Qq4nArwV8VuzP0wx7xXkcAq+In5w9xhpDbF96x0EbbzAbMhleLWTus0MZk
         fxTg==
X-Gm-Message-State: AOJu0YzyCwK6TDsdWM/EUk6Qnjg5tD4O9fDqHf9maHEjRBM25hrAalIy
        3YUMzpQxxLl9KlmDecMu2EExAChkwfIzlJdT54UYwg==
X-Google-Smtp-Source: AGHT+IEW8MizYSuc7VpLCAaDikyZzCrDO7awOg9MaEWHmlJ66DS9bCDvlNTIK4Hqw81gjT5P83PRiAhThuNbg72LJqI=
X-Received: by 2002:a17:907:2710:b0:99c:440b:a46a with SMTP id
 w16-20020a170907271000b0099c440ba46amr671473ejk.1.1691538777385; Tue, 08 Aug
 2023 16:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230806233333.815702-1-festevam@gmail.com>
In-Reply-To: <20230806233333.815702-1-festevam@gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 8 Aug 2023 16:52:45 -0700
Message-ID: <CAJ+vNU0cDTGHoqJMDdwea48RSaETyvsg2NXCcEE3FBNr4-ckvg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8m-venice: Pass "brcm,bcm4329-fmac"
To:     Fabio Estevam <festevam@gmail.com>
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

On Sun, Aug 6, 2023 at 4:33=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Pass "brcm,bcm4329-fmac" to fix the following schema warnings:
>
> imx8mp-venice-gw74xx.dtb: wifi@0: compatible: 'oneOf' conditional failed,=
 one must be fixed:
>         ['cypress,cyw4373-fmac'] is too short
>         'cypress,cyw4373-fmac' is not one of ['brcm,bcm4329-fmac', 'pci14=
e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433']
>         from schema $id: http://devicetree.org/schemas/net/wireless/brcm,=
bcm4329-fmac.yaml#
>
> imx8mn-venice-gw7902.dtb: wifi@0: compatible: 'oneOf' conditional failed,=
 one must be fixed:
>         ['brcm,bcm43455-fmac'] is too short
>         'brcm,bcm43455-fmac' is not one of ['brcm,bcm4329-fmac', 'pci14e4=
,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433']
>         from schema $id: http://devicetree.org/schemas/net/wireless/brcm,=
bcm4329-fmac.yaml#
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> index 21d7b16d6f84..cde29aa1a0a2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> @@ -801,7 +801,7 @@ &usdhc1 {
>         status =3D "okay";
>
>         wifi@0 {
> -               compatible =3D "brcm,bcm43455-fmac";
> +               compatible =3D "brcm,bcm43455-fmac", "brcm,bcm4329-fmac";
>                 reg =3D <0>;
>         };
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> index 964cc4fc2ddf..0bff7a6fdca6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> @@ -726,7 +726,7 @@ &usdhc2 {
>         status =3D "okay";
>
>         wifi@0 {
> -               compatible =3D "brcm,bcm43455-fmac";
> +               compatible =3D "brcm,bcm43455-fmac", "brcm,bcm4329-fmac";
>                 reg =3D <0>;
>         };
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arc=
h/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> index 3ac011bbc025..9a36edc60394 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> @@ -679,7 +679,7 @@ &usdhc2 {
>         status =3D "okay";
>
>         wifi@0 {
> -               compatible =3D "brcm,bcm43455-fmac";
> +               compatible =3D "brcm,bcm43455-fmac", "brcm,bcm4329-fmac";
>                 reg =3D <0>;
>         };
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arc=
h/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> index 3473423ac939..faa370a5885f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> @@ -737,7 +737,7 @@ &usdhc1 {
>         status =3D "okay";
>
>         wifi@0 {
> -               compatible =3D "cypress,cyw4373-fmac";
> +               compatible =3D "cypress,cyw4373-fmac", "brcm,bcm4329-fmac=
";
>                 reg =3D <0>;
>         };
>  };
> --
> 2.34.1
>

Fabio,

Thank you for your continued efforts to squash out all these
dt-binding warnings/issues.

Can you explain what the difference is in the dt-binding yaml between
compatible/oneOf/items/{enum,const} and compatible/oneOf/enum? The
first list for Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-=
fmac.yaml
has a much larger set of enums including the bcm43455 on these boards
but the second set of enums has a much more limited set. There is no
driver code to look at for this because it is bound via SDIO device
id's instead of the dt compatible property.

Best regards,

Tim
