Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681147597AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjGSODn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGSODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:03:42 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3042A8E;
        Wed, 19 Jul 2023 07:03:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55b78bf0423so380598a12.0;
        Wed, 19 Jul 2023 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689775420; x=1692367420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G9aCedrr+FpW0g5m8JBEVdwLj0gqKmqNTrO4zT5WCs=;
        b=dOCyzne0zRAbf9xUUnpkFEzMLMkY53DFWy0c6DSmmg1EGV7RlmECjPMNJoOlpfx3CN
         7kRtsDhfKJyHGMzn17S75fE098qhWvqwGWVije+LoFqxqf2wjizLEykv0ZlDMD9rTpX9
         v7O4Fam5E3RW23OpooWzkG//O6i9ydTAGYLtRhIHv9F88u24lMsMGBhttA9b30I6zIqc
         myJawj61oCkJCUgnWhttMuwAKIioEDfi7ttsRKp0IbUqZRcFQ1cJRVb5+dcAvNl7veJ6
         l9uX5C/6kzaDOU0QThGpifNwlDJ4Ka/X5Uhujhi6sbzbwQPF3RxvcAR4upxElrxKupvp
         q50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689775420; x=1692367420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G9aCedrr+FpW0g5m8JBEVdwLj0gqKmqNTrO4zT5WCs=;
        b=Myy0dgLYUqvWUHEptWqqjy4VrUlffq9rgidJvgbBEKQdME76ZyrMxTavGvZYMTOn9O
         qaLt+TaWp3tblGFDgvSKVnYe4oQKcA6CGTHkf3MmBQ83Uwy05fNV9USmShtBaedfqdgj
         ++F2ZyeT70JQlyPKpGmr659hIFBaeusRjrOsN9gGF3MKnz4tv5NU21oubanAhM0E2Hkd
         Qk8jUE8RmXXPziGYOx7Mlx+ti5XKuarX4zrtDDwtOaE2t5H1OATPNzGNjGWJUY80mcgv
         chpygzD8K3jS4L58Exx+gmA47vazWIucw+zfYB5dHWEFENbBIOxMSUxsRu7JrN2EpS0H
         QMaA==
X-Gm-Message-State: ABy/qLY9UoSE8hYuMCUUilFYOhwD4y+HQquQw9HOHa8ZI8+0z8lISzA6
        kB41NJ5DgwiUO+99xAuLQCG/NfjRtcqHFtzVE4I=
X-Google-Smtp-Source: APBJJlEBRF7KT2vOnVYifiIqR/XmjsT9yopLf2Ak/r/fgsKUinwcBFxR3bIDQyCRqmYM6ExWqeH5EkHSrZjSGYzWtTM=
X-Received: by 2002:a17:90a:17c7:b0:263:730b:f568 with SMTP id
 q65-20020a17090a17c700b00263730bf568mr2116751pja.3.1689775420470; Wed, 19 Jul
 2023 07:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230719-imx8mp_enet_qos_use_125mhz_clock-v1-1-782c9ac6e121@pengutronix.de>
In-Reply-To: <20230719-imx8mp_enet_qos_use_125mhz_clock-v1-1-782c9ac6e121@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Jul 2023 11:03:28 -0300
Message-ID: <CAOMZO5AP1zDQPGnctq+UbPSiv+7Rg=DGABb7-mZV__HZ4qpMBQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: use correct clock for eqos
 timestamping counter
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        patchwork-jzi@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Wed, Jul 19, 2023 at 10:59=E2=80=AFAM Johannes Zink <j.zink@pengutronix.=
de> wrote:
>
> The i.MX8MP Reference Manual rev 1 06/2021, section 11.7.2.5 "Timestamp
> Support" indicates the PTP timestamp clock expects a typical frequency
> of 125MHz.
>
> As this also improves the precision of the measured timestamps: assign
> appropriate 125MHz Clock parent. As no one except the timestamping
> counter uses this clock, there are no side-effects of this change in
> other peripherals.
>
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index 6f2f50e1639c..7f80dff914c2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1334,7 +1334,7 @@ eqos: ethernet@30bf0000 {
>                                                   <&clk IMX8MP_CLK_ENET_Q=
OS_TIMER>,
>                                                   <&clk IMX8MP_CLK_ENET_Q=
OS>;
>                                 assigned-clock-parents =3D <&clk IMX8MP_S=
YS_PLL1_266M>,
> -                                                        <&clk IMX8MP_SYS=
_PLL2_100M>,
> +                                                        <&clk IMX8MP_SYS=
_PLL2_125M>,
>                                                          <&clk IMX8MP_SYS=
_PLL2_125M>;
>                                 assigned-clock-rates =3D <0>, <100000000>=
, <125000000>;

Shouldn't this also be changed to:

assigned-clock-rates =3D <0>, <125000000>, <125000000>;
