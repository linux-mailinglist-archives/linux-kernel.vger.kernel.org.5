Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95B97AC23C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjIWNVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjIWNVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:21:30 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDFE11D;
        Sat, 23 Sep 2023 06:21:24 -0700 (PDT)
Received: from g550jk.localnet (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 504B8D0F49;
        Sat, 23 Sep 2023 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1695475252; bh=iHvBiQzorU0EG6kr/U8qttUZDmGPcm76uY0tqu2HcNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ebZzoxdWLbWYX/Or2eyq2ZhgXvDatM9iwHqwO2K0KhZMXy77gGYA6bPNcij9tTraY
         hyZ7MVaTnCemeQcnYgJ9TFtuuHz9MPvE5ZSll6zxlUNFQw91wwlkJBy3LZ82HS9STJ
         WuoFvJ1l+t4UVlfHtV8UsSV6XovH8sKTOLFm098Q=
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
Subject: Re: [PATCH v2 1/2] pinctrl: qcom: msm8226: Add MPM pin mappings
Date:   Sat, 23 Sep 2023 15:20:51 +0200
Message-ID: <1866740.CQOukoFCf9@z3ntu.xyz>
In-Reply-To: <20230923131432.21721-2-matti.lehtimaki@gmail.com>
References: <20230923131432.21721-1-matti.lehtimaki@gmail.com>
 <20230923131432.21721-2-matti.lehtimaki@gmail.com>
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

On Samstag, 23. September 2023 15:14:31 CEST Matti Lehtim=E4ki wrote:
> Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
> through MPM-connected pins.
>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>

Looks good now :)

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
> Changes in v2:
>   - Add missing entry to mapping
> ---
>  drivers/pinctrl/qcom/pinctrl-msm8226.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm8226.c
> b/drivers/pinctrl/qcom/pinctrl-msm8226.c index 994619840a70..4030baa3715f
> 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm8226.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm8226.c
> @@ -612,6 +612,16 @@ static const struct msm_pingroup msm8226_groups[] =
=3D {
>=20
>  #define NUM_GPIO_PINGROUPS 117
>=20
> +static const struct msm_gpio_wakeirq_map msm8226_mpm_map[] =3D {
> +	{ 1, 3 }, { 4, 4 }, { 5, 5 }, { 9, 6 }, { 13, 7 }, { 17, 8 },
> +	{ 21, 9 }, { 27, 10 }, { 29, 11 }, { 31, 12 }, { 33, 13 }, { 35, 14=20
},
> +	{ 37, 15 }, { 38, 16 }, { 39, 17 }, { 41, 18 }, { 46, 19 }, { 48, 20=20
},
> +	{ 49, 21 }, { 50, 22 }, { 51, 23 }, { 52, 24 }, { 54, 25 }, { 62, 26=20
},
> +	{ 63, 27 }, { 64, 28 }, { 65, 29 }, { 66, 30 }, { 67, 31 }, { 68, 32=20
},
> +	{ 69, 33 }, { 71, 34 }, { 72, 35 }, { 106, 36 }, { 107, 37 }, { 108,=20
38 },
> +	{ 109, 39 }, { 110, 40 }, { 111, 54 }, { 113, 55 }, { 115, 41 }, +};
> +
>  static const struct msm_pinctrl_soc_data msm8226_pinctrl =3D {
>  	.pins =3D msm8226_pins,
>  	.npins =3D ARRAY_SIZE(msm8226_pins),
> @@ -620,6 +630,8 @@ static const struct msm_pinctrl_soc_data msm8226_pinc=
trl
> =3D { .groups =3D msm8226_groups,
>  	.ngroups =3D ARRAY_SIZE(msm8226_groups),
>  	.ngpios =3D NUM_GPIO_PINGROUPS,
> +	.wakeirq_map =3D msm8226_mpm_map,
> +	.nwakeirq_map =3D ARRAY_SIZE(msm8226_mpm_map),
>  };
>=20
>  static int msm8226_pinctrl_probe(struct platform_device *pdev)




