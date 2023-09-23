Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2367AC187
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjIWLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjIWLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:53:23 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03930199;
        Sat, 23 Sep 2023 04:53:17 -0700 (PDT)
Received: from g550jk.localnet (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 26024D0F49;
        Sat, 23 Sep 2023 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1695469965; bh=OKF1zzcs43ZDoi4cDiGqdLlW1pZIC+kMc6jGkGBwd0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E6p3uEeWIWbNdfji9G0Dqf9szr70mHEXuu2bSClzufk+CT7OCosIoZBxpRe7elbZY
         cYGfeC/FXzvHXmtpY//wSNV1NA8CQeXmg3OOJo2fMJql4Trupg3PSq0uQd8cHFVyuZ
         KIhFlplG2nYWhtS7sG650wYiuwywHiUKqOs9nzqM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: qcom: msm8974: Add MPM pin mappings
Date:   Sat, 23 Sep 2023 13:52:44 +0200
Message-ID: <1769487.VLH7GnMWUR@z3ntu.xyz>
In-Reply-To: <20230922224027.85291-3-matti.lehtimaki@gmail.com>
References: <20230922224027.85291-1-matti.lehtimaki@gmail.com>
 <20230922224027.85291-3-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 23. September 2023 00:40:27 CEST Matti Lehtim=E4ki wrote:
> Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
> through MPM-connected pins.
>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>

Based on the discussion in the 8226 patch, this looks correct, compared wit=
h=20
downstream arch/arm/boot/dts/msm8974pro-pm.dtsi.

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  drivers/pinctrl/qcom/pinctrl-msm8x74.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm8x74.c
> b/drivers/pinctrl/qcom/pinctrl-msm8x74.c index d5fe62992849..238c83f6ec4f
> 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm8x74.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm8x74.c
> @@ -1045,6 +1045,16 @@ static const struct msm_pingroup msm8x74_groups[] =
=3D {
>=20
>  #define NUM_GPIO_PINGROUPS 146
>=20
> +static const struct msm_gpio_wakeirq_map msm8x74_mpm_map[] =3D {
> +	{ 1, 4 }, { 5, 5 }, { 9, 6 }, { 18, 7 }, { 20, 8 }, { 24, 9 },
> +	{ 27, 10 }, { 28, 11 }, { 34, 12 }, { 35, 13 }, { 37, 14 }, { 42, 15=20
},
> +	{ 44, 16 }, { 46, 17 }, { 50, 18 }, { 54, 19 }, { 59, 20 }, { 61, 21=20
},
> +	{ 62, 22 }, { 64, 23 }, { 65, 24 }, { 66, 25 }, { 67, 26 }, { 68, 27=20
},
> +	{ 71, 28 }, { 72, 29 }, { 73, 30 }, { 74, 31 }, { 75, 32 }, { 77, 33=20
},
> +	{ 79, 34 }, { 80, 35 }, { 82, 36 }, { 86, 37 }, { 92, 38 }, { 93, 39=20
},
> +	{ 95, 40 }, { 102, 3 }, { 144, 41 },
> +};
> +
>  static const struct msm_pinctrl_soc_data msm8x74_pinctrl =3D {
>  	.pins =3D msm8x74_pins,
>  	.npins =3D ARRAY_SIZE(msm8x74_pins),
> @@ -1053,6 +1063,8 @@ static const struct msm_pinctrl_soc_data
> msm8x74_pinctrl =3D { .groups =3D msm8x74_groups,
>  	.ngroups =3D ARRAY_SIZE(msm8x74_groups),
>  	.ngpios =3D NUM_GPIO_PINGROUPS,
> +	.wakeirq_map =3D msm8x74_mpm_map,
> +	.nwakeirq_map =3D ARRAY_SIZE(msm8x74_mpm_map),
>  };
>=20
>  static int msm8x74_pinctrl_probe(struct platform_device *pdev)




