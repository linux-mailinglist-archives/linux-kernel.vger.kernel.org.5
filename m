Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B991C79F080
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjIMRkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:40:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF581981;
        Wed, 13 Sep 2023 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1694626814; x=1695231614; i=frank-w@public-files.de;
 bh=zlxr35DekYYPKmID3fS8P77AnLWSssDEYIMXwOZms20=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q0PeXcRWOySREMcb/6Z+gZ8FgvAwd0hC2cV41KZ5t/g5rTnEqTg5N5GIwNozsEwzQJtIKvSvmMv
 YbSd9dazCc4jq+Wbf3KFtpqlXAshQhWlJ+wj7RsFD7hrVUCiQFZcTrhiNQKMcgS81Ng/Rna00Lc+X
 Kgu+fe438+94siO+NOZ76LLlmrmWvga3hhsex19E/LymD6adecaFqhEbO7cHkjkKGA37VLtOJij4r
 2J6UEv3fjcpYMMzPfvNBNukC+PykreWjJXgcEBM+9oHZkqtO6CRP3h/0Yhjc0VrNbBPviVzTLn9dA
 oiB0PNZLDyWg6rFYXLg2roUS1PbPdv3qWKqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.75.211] ([80.245.75.211]) by web-mail.gmx.net
 (3c-app-gmx-bs38.server.lan [172.19.170.90]) (via HTTP); Wed, 13 Sep 2023
 19:40:14 +0200
MIME-Version: 1.0
Message-ID: <trinity-fc45afb4-bb5a-42f0-aa8d-94a5189cd1f2-1694626814181@3c-app-gmx-bs38>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
Subject: Aw: Re: [RFC v1 2/3] thermal/drivers/mediatek/lvts_thermal: make
 coeff configurable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 19:40:14 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <99ef1b62-0676-a912-20fb-c04c427c4d01@collabora.com>
References: <20230911183354.11487-1-linux@fw-web.de>
 <20230911183354.11487-3-linux@fw-web.de>
 <99ef1b62-0676-a912-20fb-c04c427c4d01@collabora.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:3/YlO/7vNs/7eVdt8xMtZurWYj2SOKr4oZqwwIOQcEwolVs53E0xbvvW53R7JXikSl5qB
 zgDI8nMnUunmMp1fL6QEosnxadKTzFB9eZGdTUsBCEloTTF3a6TTRcWGSPlfF9KdjH+O4/JZ/ULX
 Sh4BtDEOwLKP5qp+muZZh/24KQc7USQ22B4VocnqoYZd2K2wEIl717lt714weBGGbIKW2ShYN8mP
 at4xmILYUDHseyeI/d0XbnU5PKkMwF+qtq0sc9i/4jBhw9sRDZn9PHkBZf13/SWSrw1Dis8Ybovr
 xw=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tIYAfuq7yh4=;kca3ih3XJyHLM3ljjH9RlY19OHp
 tWJG3tBhSmB4WnIzzIlreZs4zIPHFjN7wRRwwOyyCO1c9848ccpNHpKyz3DZVIOIIg0Gu87tK
 tOxGu24DkyYbpUgnoR+oKljcXo7de0f5hBVXVo3+HIaYsMsU3Fw8VGh5vnFeDcJEWnlBCTMwz
 V7uP+/5XdTZSTkvq+aIH9BqjMrFotb8bBh2YucI09cX5QKlAMWfzgoipm/6qwzT8ksIAIZEkz
 U9svAnE/jFBPhgYi5+Hy21+QgIBJPykGY5xghRUIql8SC0Xf97sUzlwU2bM+mBQwCEMxMJpe4
 FJX8M1Fu1RnsnMFEaY2gZwhC46VfMW9GHzqvnZzIjI3yONSOs5OX8/2i1DMBukim8UIKSTxMC
 7ObGnONrLF4IIZ3tnOsGUDdTgN3dpM+1/tYSsUsCf1DS3Ww3Eqcyv0GhIeLV/uU7aGZstpIKy
 kmimgRgGOVeAI38az1Sb2wHo6tEue4yPz08Al2yuB/23ausSYul4EcM08AC6cRQwrSxjGsoUk
 5ltWfGWqPiQo8uU32aW6k0NevGjxNbzzAonXF9UEEQmkmZLgE9B62FQ9hHutgyWrILPEOcFaH
 IpBgfW3u2+AqUucOXGe9L0KGewH6msxxTs4gzC3Fb0ghKWmWaWp5ZvhOh+CTUfSE2IgPhx+Aw
 YXpR4zMDvUdpyORwSv+41q7YuJ1H1UmBjP+oQDtODl+veNKdL+nqV4HC85LIrQ+8q0xyFMWLa
 Ewa40XuA3JUDmzgMOT83ziAhnyjkvY1P8SQOWNY9UFpTBDBpLDxfCzgqPI6buXeykmpCk5SkP
 MJBOu+QcBARHc2PCE2fn1pKjyC5lEbZY3EvKGVIRStY5o=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Mittwoch, 13. September 2023 um 10:03 Uhr
> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.c=
om>
> Il 11/09/23 20:33, Frank Wunderlich ha scritto:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > The upcoming mt7988 has different temperature coefficients so we
> > cannot use constants in the functions lvts_golden_temp_init,
> > lvts_golden_temp_init and lvts_raw_to_temp anymore.
> >
> > Add a field in the lvts_ctrl pointing to the lvts_data which now
> > contains the soc-specific temperature coefficents.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >   drivers/thermal/mediatek/lvts_thermal.c | 56 ++++++++++++++++++-----=
--
> >   1 file changed, 41 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal=
/mediatek/lvts_thermal.c
> > index effd9b00a424..c1004b4da3b6 100644
> > --- a/drivers/thermal/mediatek/lvts_thermal.c
> > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > @@ -80,8 +80,8 @@
> >   #define LVTS_SENSOR_MAX				4
> >   #define LVTS_GOLDEN_TEMP_MAX		62
> >   #define LVTS_GOLDEN_TEMP_DEFAULT	50
> > -#define LVTS_COEFF_A				-250460
> > -#define LVTS_COEFF_B				250460
> > +#define LVTS_COEFF_A_MT8195			-250460
> > +#define LVTS_COEFF_B_MT8195			250460
> >
> >   #define LVTS_MSR_IMMEDIATE_MODE		0
> >   #define LVTS_MSR_FILTERED_MODE		1
> > @@ -94,7 +94,7 @@
> >   #define LVTS_MINIMUM_THRESHOLD		20000
> >
> >   static int golden_temp =3D LVTS_GOLDEN_TEMP_DEFAULT;
> > -static int coeff_b =3D LVTS_COEFF_B;
> > +static int coeff_b;
>
> This could be renamed to `golden_temp_offset`
>
> >
> >   struct lvts_sensor_data {
> >   	int dt_id;
> > @@ -109,9 +109,15 @@ struct lvts_ctrl_data {
> >   	int mode;
> >   };
> >
> > +struct formula_coeff {
> > +	int a;
> > +	int b;
> > +};
> > +
> >   struct lvts_data {
> >   	const struct lvts_ctrl_data *lvts_ctrl;
> >   	int num_lvts_ctrl;
> > +	struct formula_coeff coeff;
>
> You can just add the coefficients here directly... and while at it you c=
an
> also make it self explanatory, because the "A" coefficient is a factor w=
hile
> the "B" coefficient is just an offset.
>
> 	int temp_factor; <--- coeff_a
> 	int temp_offset; <--- coeff_b

makes sense...imho very good idea.
originally i took the naming based on the Constants which maybe should be =
changed too?

> >   };
> >
> >   struct lvts_sensor {
> > @@ -126,6 +132,7 @@ struct lvts_sensor {
> >
> >   struct lvts_ctrl {
> >   	struct lvts_sensor sensors[LVTS_SENSOR_MAX];
> > +	const struct lvts_data *lvts_data;
> >   	u32 calibration[LVTS_SENSOR_MAX];
> >   	u32 hw_tshut_raw_temp;
> >   	int num_lvts_sensor;
> > @@ -247,21 +254,21 @@ static void lvts_debugfs_exit(struct lvts_domain=
 *lvts_td) { }
> >
> >   #endif
> >
> > -static int lvts_raw_to_temp(u32 raw_temp)
> > +static int lvts_raw_to_temp(u32 raw_temp, struct formula_coeff coeff)
> >   {
> >   	int temperature;
> >
> > -	temperature =3D ((s64)(raw_temp & 0xFFFF) * LVTS_COEFF_A) >> 14;
> > +	temperature =3D ((s64)(raw_temp & 0xFFFF) * coeff.a) >> 14;
>
> so that this also becomes more readable:
>
> static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
> {
> 	int temperature;
>
> 	temperature =3D ((s64)(raw_temp & 0xFFFF) * temp_factor) >> 14;
> 	temperature +=3D golden_temp_offset;
>
> 	return temperature;
> }
>
> where temp_factor is lvts_data.temp_factor, and golden_temp_offset is a
> rename of `static int coeff_b`.

right and passing an int (instead of struct) is easier and more readable t=
oo.

> Cheers,
> Angelo
>
>
