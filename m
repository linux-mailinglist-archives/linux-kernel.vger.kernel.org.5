Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B118D7B7625
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbjJDBMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjJDBMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:12:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E458AB;
        Tue,  3 Oct 2023 18:12:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-58949a142bfso60456a12.1;
        Tue, 03 Oct 2023 18:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696381952; x=1696986752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fas0XW9KdFPhCRYKtIjUyg9fUjXrDBEyScssVvJXH/A=;
        b=UqVyN9seF/pKtvdft4Eo0V+0P0hWx5L8c2TUqMA/z6WeEtwSrNjlb2aoAY8bwYKEvC
         BQPCRGlQmvPaw6k1YYRd+z+U1+SQEtsHyQ84DBQu+eiuQqqQf+wSCxHnsf0KWlXQMPql
         qkRz1wPvYgj/dV7Fpa56KKYNzLzQD0t3iSmYXabYbw5Df7iGEN30n87XnGUNryPbniBv
         CJhq/SefBb+C/QORiPbhtNlBYTTCgld4CzkSVr+h4aV27lCWovSmNyrfWL/oC83j6Foc
         xi6qHyOH2XEoHv1tDPZMfzwLLrUh7DUdWvXjni0YyB3AVu6wVG2yoDv6O2xdYQCuAStc
         Asfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696381952; x=1696986752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fas0XW9KdFPhCRYKtIjUyg9fUjXrDBEyScssVvJXH/A=;
        b=PIcfljMI9KMIlKYBhUvToctU2OfbbUs0u81hXV4KD3GXdHNidipdoXbA0R6qXyf/w7
         3IM5O9nS6sCCB5qqPsVRV1k2SQRwt57rnvxN/SKwVLPwfpwdMBRYypgu8erYykIa/dk9
         CJin+irIheZFMhjLoiAeBTlNggEF/xUvuLUDnbVV/KXD0ZV1O33XLn91+8ql9PwNYxev
         SmAb/XnRWqDkxzTeJxjfrYvwzmY/vd4tlhtLWwVDz7hqFEg3StcD2JJ8RDx02sjBCO5M
         c3RweDJvIzgS5NFBdk30DLn4LZnaAP2cEhtlKvcPRAJrRHUAzCNXuMD/TXXh2qXFzPU2
         DNjg==
X-Gm-Message-State: AOJu0YzLZF6MfxvYgfDxftyf6rxbLxpdrEkRKnMyqhfs93iDTkrzSali
        JP3DNVA5mvf/8T5AR6helEDSnXpBq909TW/03gE=
X-Google-Smtp-Source: AGHT+IFen0a+X+gv/rudm9g2ZVTwJtB9njJO1Lz/cEwq0MQEtgeUeeSEuWPSIwYeovwRMb7oV3/tUMeNH3CCdZ3MKcc=
X-Received: by 2002:a05:6a00:10c2:b0:68f:c9f6:f366 with SMTP id
 d2-20020a056a0010c200b0068fc9f6f366mr1240061pfu.0.1696381951815; Tue, 03 Oct
 2023 18:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230831044431.250338-1-aford173@gmail.com> <20230831044431.250338-2-aford173@gmail.com>
In-Reply-To: <20230831044431.250338-2-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Oct 2023 22:12:20 -0300
Message-ID: <CAOMZO5DyZJuqYswLYhf1f3zP7Rc1ZhnPfq26dpyU2m5mhvRtVw@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] arm64: dts: imx8mp: Add micfil node
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marex@denx.de,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam and devicetree folks,

On Thu, Aug 31, 2023 at 1:44=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The i.MX8MP has a micfil controller which is used for interfacing
> with a pulse density microphone. Add the node and mark it as
> disabled by default.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  The AUDIOMIX_PDM_ROOT doesn't exist and the real clock is
>      called IMX8MP_CLK_AUDIOMIX_PDM_SEL, so swap it out.
>
> V2:  No change
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index 3167706d81e1..341fd0369ce9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1479,6 +1479,27 @@ easrc: easrc@30c90000 {
>                                         fsl,asrc-format =3D <2>;
>                                         status =3D "disabled";
>                                 };
> +
> +                               micfil: audio-controller@30ca0000 {
> +                                       compatible =3D "fsl,imx8mp-micfil=
";
> +                                       reg =3D <0x30ca0000 0x10000>;
> +                                       #sound-dai-cells =3D <0>;

After this patch, the following schema warning is seen:

imx8mp-beacon-kit.dtb: audio-controller@30ca0000: '#sound-dai-cells'
does not match any of the regexes: 'pinctrl-[0-9]+'
from schema $id: http://devicetree.org/schemas/sound/fsl,micfil.yaml#

What is the correct way to solve this?

- Document #sound-dai-cells in fsl,micfil.yaml as an optional property
- Remove #sound-dai-cells from imx8mp.dtsi
- Document #sound-dai-cells in fsl,micfil.yaml as a required property
and pass #sound-dai-cells to imx8mm/imx8mn/imx83.dtsi?
