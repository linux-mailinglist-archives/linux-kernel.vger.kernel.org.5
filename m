Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758DE7B9E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjJEOJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjJEOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD7822C83
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 03:43:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-504a7f9204eso1029635e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696502585; x=1697107385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVObFCNLlwBPipdK3H8KmPs3z72Q3xYU1AFPpgt6DIU=;
        b=AOa420kLUB0ARHlS9yJpUptTHxVGNbSzGIgOS7VLxaQIF8KBR3laYErI29O7I9olPk
         ZXDBaN38om7wMOQKSGJ2hTWLYVlqHFT77j1CRFxVa1JX2kcxTYOB2KucfF5Ihs6N17EE
         EmuCk9fyRAi9UqeV88/vaeXUdquTwq8OBtwVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502585; x=1697107385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVObFCNLlwBPipdK3H8KmPs3z72Q3xYU1AFPpgt6DIU=;
        b=PTcC0k6jy6nyOyDjphRmp9hF+Rww8xqFy47DqUMVhUI0N7dMFjCC9VVVt0f2AYr67t
         RAVlAeS1oX71H4CNeCVToRaOk+w3d/HWAKW2/Ilphrj7hnpMvPY1SfaFX2sVF3a2JmVr
         lEzAPWrSpTg3l/qIDmInQQysiL5+bl+blPPi+edAD6rWvVb2uTqhFSIVKgJqEyQArhSc
         L/c/DbFCkgVMfvu5WYx0HGvWs+NCG7IfEo/bxWhjRyB1JTinacZuyY89PGic8JdMEhPs
         rcaVRnbyV1VmAz5S9AtAqTDl2RFlQlySSc3lua13ROSDyISQ/pqtAbSfWGR2ju6wDR0r
         cruw==
X-Gm-Message-State: AOJu0YyKxsK5LQ/zAErnp/QPM15Hl9vqWpqjNj7cbB/Uy4rHTVBc+wJF
        i0k+y0nX0xsQ6e3jif2tFtRRXDrX0insQNTJwZBxWA==
X-Google-Smtp-Source: AGHT+IHq9DTTPcqEv9hIoZgRG2eMrgjishCCWpwEDsoQWepchJMVarAVpJnzNCiyrgnB7Vjj2+qg9uOeeeYiBZ0Vpnw=
X-Received: by 2002:a19:4f4d:0:b0:500:bff5:54ec with SMTP id
 a13-20020a194f4d000000b00500bff554ecmr3807702lfk.3.1696502584574; Thu, 05 Oct
 2023 03:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231005103041.352478-1-eugen.hristev@collabora.com>
In-Reply-To: <20231005103041.352478-1-eugen.hristev@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 5 Oct 2023 18:42:53 +0800
Message-ID: <CAGXv+5GRhqC98=PARwbD4ueaWqdWZiYwSPS4F8TEUF57dnH2WQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: fix clock names for power domains
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 6:31=E2=80=AFPM Eugen Hristev
<eugen.hristev@collabora.com> wrote:
>
> Clocks for each power domain are split into big categories: pd clocks
> and subsys clocks.
> According to the binding, all clocks which have a dash '-' in their name
> are treated as subsys clocks, and must be placed at the end of the list.
> The other clocks which are pd clocks must come first.
> Fixed the naming and the placing of all clocks in the power domains.
> For the avoidance of doubt, prefixed all subsys clocks with the 'subsys'
> prefix. The binding does not enforce strict clock names, the driver
> uses them in bulk, only making a difference for pd clocks vs subsys clock=
s.
>
> The above problem appears to be trivial, however, it leads to incorrect
> power up and power down sequence of the power domains, because some
> clocks will be mistakenly taken for subsys clocks and viceversa.
> One consequence is the fact that if the DIS power domain goes power down
> and power back up during the boot process, when it comes back up, there
> are still transactions left on the bus which makes the display inoperable=
.
>
> Some of the clocks for the DIS power domain were wrongly using '_' instea=
d
> of '-', which again made these clocks being treated as pd clocks instead =
of
> subsys clocks.
>
> Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

This brings the display back to life on my MT8186 device. :D
Thank you for tracking down the issue!

> ---
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi | 42 +++++++++++++++---------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8186.dtsi
> index af6f6687de35..7121d4312bee 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -924,7 +924,8 @@ power-domain@MT8186_POWER_DOMAIN_CSIRX_TOP {
>                                         reg =3D <MT8186_POWER_DOMAIN_CSIR=
X_TOP>;
>                                         clocks =3D <&topckgen CLK_TOP_SEN=
INF>,
>                                                  <&topckgen CLK_TOP_SENIN=
F1>;
> -                                       clock-names =3D "csirx_top0", "cs=
irx_top1";
> +                                       clock-names =3D "subsys-csirx-top=
0",
> +                                                     "subsys-csirx-top1"=
;
>                                         #power-domain-cells =3D <0>;
>                                 };
>
> @@ -942,7 +943,8 @@ power-domain@MT8186_POWER_DOMAIN_ADSP_AO {
>                                         reg =3D <MT8186_POWER_DOMAIN_ADSP=
_AO>;
>                                         clocks =3D <&topckgen CLK_TOP_AUD=
IODSP>,
>                                                  <&topckgen CLK_TOP_ADSP_=
BUS>;
> -                                       clock-names =3D "audioadsp", "ads=
p_bus";
> +                                       clock-names =3D "audioadsp",
> +                                                     "subsys-adsp-bus";
>                                         #address-cells =3D <1>;
>                                         #size-cells =3D <0>;
>                                         #power-domain-cells =3D <1>;
> @@ -975,8 +977,11 @@ power-domain@MT8186_POWER_DOMAIN_DIS {
>                                                  <&mmsys CLK_MM_SMI_COMMO=
N>,
>                                                  <&mmsys CLK_MM_SMI_GALS>=
,
>                                                  <&mmsys CLK_MM_SMI_IOMMU=
>;
> -                                       clock-names =3D "disp", "mdp", "s=
mi_infra", "smi_common",
> -                                                    "smi_gals", "smi_iom=
mu";
> +                                       clock-names =3D "disp", "mdp",
> +                                                     "subsys-smi-infra",
> +                                                     "subsys-smi-common"=
,
> +                                                     "subsys-smi-gals",
> +                                                     "subsys-smi-iommu";
>                                         mediatek,infracfg =3D <&infracfg_=
ao>;
>                                         #address-cells =3D <1>;
>                                         #size-cells =3D <0>;
> @@ -993,15 +998,17 @@ power-domain@MT8186_POWER_DOMAIN_VDEC {
>
>                                         power-domain@MT8186_POWER_DOMAIN_=
CAM {
>                                                 reg =3D <MT8186_POWER_DOM=
AIN_CAM>;
> -                                               clocks =3D <&topckgen CLK=
_TOP_CAM>,
> -                                                        <&topckgen CLK_T=
OP_SENINF>,
> +                                               clocks =3D <&topckgen CLK=
_TOP_SENINF>,
>                                                          <&topckgen CLK_T=
OP_SENINF1>,
>                                                          <&topckgen CLK_T=
OP_SENINF2>,
>                                                          <&topckgen CLK_T=
OP_SENINF3>,
> +                                                        <&camsys CLK_CAM=
2MM_GALS>,
>                                                          <&topckgen CLK_T=
OP_CAMTM>,
> -                                                        <&camsys CLK_CAM=
2MM_GALS>;
> -                                               clock-names =3D "cam-top"=
, "cam0", "cam1", "cam2",
> -                                                            "cam3", "cam=
-tm", "gals";
> +                                                        <&topckgen CLK_T=
OP_CAM>;
> +                                               clock-names =3D "cam0", "=
cam1", "cam2",
> +                                                             "cam3", "ga=
ls",
> +                                                             "subsys-cam=
-tm",
> +                                                             "subsys-cam=
-top";
>                                                 mediatek,infracfg =3D <&i=
nfracfg_ao>;
>                                                 #address-cells =3D <1>;
>                                                 #size-cells =3D <0>;
> @@ -1020,9 +1027,9 @@ power-domain@MT8186_POWER_DOMAIN_CAM_RAWA {
>
>                                         power-domain@MT8186_POWER_DOMAIN_=
IMG {
>                                                 reg =3D <MT8186_POWER_DOM=
AIN_IMG>;
> -                                               clocks =3D <&topckgen CLK=
_TOP_IMG1>,
> -                                                        <&imgsys1 CLK_IM=
G1_GALS_IMG1>;
> -                                               clock-names =3D "img-top"=
, "gals";
> +                                               clocks =3D <&imgsys1 CLK_=
IMG1_GALS_IMG1>,
> +                                                        <&topckgen CLK_T=
OP_IMG1>;
> +                                               clock-names =3D "gals", "=
subsys-img-top";
>                                                 mediatek,infracfg =3D <&i=
nfracfg_ao>;
>                                                 #address-cells =3D <1>;
>                                                 #size-cells =3D <0>;
> @@ -1041,8 +1048,11 @@ power-domain@MT8186_POWER_DOMAIN_IPE {
>                                                          <&ipesys CLK_IPE=
_LARB20>,
>                                                          <&ipesys CLK_IPE=
_SMI_SUBCOM>,
>                                                          <&ipesys CLK_IPE=
_GALS_IPE>;
> -                                               clock-names =3D "ipe-top"=
, "ipe-larb0", "ipe-larb1",
> -                                                             "ipe-smi", =
"ipe-gals";
> +                                               clock-names =3D "subsys-i=
pe-top",
> +                                                             "subsys-ipe=
-larb0",
> +                                                             "subsys-ipe=
-larb1",
> +                                                             "subsys-ipe=
-smi",
> +                                                             "subsys-ipe=
-gals";
>                                                 mediatek,infracfg =3D <&i=
nfracfg_ao>;
>                                                 #power-domain-cells =3D <=
0>;
>                                         };
> @@ -1061,7 +1071,9 @@ power-domain@MT8186_POWER_DOMAIN_WPE {
>                                                 clocks =3D <&topckgen CLK=
_TOP_WPE>,
>                                                          <&wpesys CLK_WPE=
_SMI_LARB8_CK_EN>,
>                                                          <&wpesys CLK_WPE=
_SMI_LARB8_PCLK_EN>;
> -                                               clock-names =3D "wpe0", "=
larb-ck", "larb-pclk";
> +                                               clock-names =3D "wpe0",
> +                                                             "subsys-lar=
b-ck",
> +                                                             "subsys-lar=
b-pclk";
>                                                 mediatek,infracfg =3D <&i=
nfracfg_ao>;
>                                                 #power-domain-cells =3D <=
0>;
>                                         };
> --
> 2.34.1
>
>
