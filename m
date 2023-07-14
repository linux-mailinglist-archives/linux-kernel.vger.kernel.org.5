Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161857536F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjGNJr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjGNJrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:47:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622611989;
        Fri, 14 Jul 2023 02:47:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-993a37b79e2so236863266b.1;
        Fri, 14 Jul 2023 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689328028; x=1691920028;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGYaz8TI1Z5CW1NeLVdMshEDbPGg3BH2iJl5JNjpBz0=;
        b=KsCWr/be2NLFDsr3/LF1j284UjHOJwn1Qpf3oCg8dSpwZtDVBHOSVtSX1n/LQyhxiv
         MeRE0QfWBqDg92FWFFrkbESBhL0M5YTFDuP+31wRQnR/etR+/Jmfu3gsnbQd+V4DQA5o
         Ydtaju5Q9jvSOf3K90R4x27DBP3widQLdnRrsND7wgFpol3L53oP0e1Se3DEXc9+mhDq
         SBlIXawiJdI/SpOoIQp5E3/ykOytWAYHgnsfLiC+INpOWr88TEI9JOeWEmmOMfvaaFUb
         gk6yHRZ3cRCVh0NFYm9wBb2HTxL1i+9oYtUbeWwGHOKula7SQlpVLJAr/+mCXrz0vJ+G
         d8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328028; x=1691920028;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGYaz8TI1Z5CW1NeLVdMshEDbPGg3BH2iJl5JNjpBz0=;
        b=jr/N8rf7TtrFHicFy9jlQweumnMUKKmQQsnukY6UigUsImqBXEtLMMF8HdxYyec0fM
         e82j4/SY9rE4+Y9pt1Fv3M7r69n4zbJSl0qdVKlDH4p+aoSEV8Dg91m9Ptl1J4KIlOhn
         2po1hJtD0Zm6bE7TTlimmvlwtjgZBzVoJqfUHJ2TZagS6xPrYxY4Q0hDoutgcXQtg/NK
         4AiqNsuT3HrswMq072TZz1vdnytsmdqahv2ifhbhdUCrAjLMA7WDy85UJPsTTRAhmEom
         Mldd/NnNT0lIH+TlYB3qMrPwnzJDGikGWMO9BAIYv6Ma50cHqA0cIlgCKGCQkzB1m9U8
         h9YQ==
X-Gm-Message-State: ABy/qLYFCaYYHTOzRw2U+tfNPr3QkOMCAkupKyc7ppgAQ+oVn1znijDT
        zAYIMabI+43OQH26RKgmEQA=
X-Google-Smtp-Source: APBJJlHsNtW8rKB0/w075MJIN4AQGD8aoS9UNYvKSGyyr903BkaCado4wm2Z2NSukoD+Hl5YCYM5HA==
X-Received: by 2002:a17:906:c:b0:993:f611:7c95 with SMTP id 12-20020a170906000c00b00993f6117c95mr4038435eja.39.1689328027556;
        Fri, 14 Jul 2023 02:47:07 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h14-20020a170906110e00b009829dc0f2a0sm5237469eja.111.2023.07.14.02.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:47:07 -0700 (PDT)
Date:   Fri, 14 Jul 2023 11:47:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, jonathanh@nvidia.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: tegra: Add support to display pin function
Message-ID: <ZLEZmX0LzwCNvf5h@orome>
References: <ZK7BRXa9geC8SAGs@orome>
 <20230713082106.838-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fvj6s3HeolWgeMJN"
Content-Disposition: inline
In-Reply-To: <20230713082106.838-1-pshete@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fvj6s3HeolWgeMJN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 01:51:06PM +0530, Prathamesh Shete wrote:
> The current function for a given pin is not displayed via the debugfs.
> Add support to display the current function that is set for each pin.
>=20
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c | 19 +++++++++++++++++--
>  drivers/pinctrl/tegra/pinctrl-tegra.h |  2 ++
>  2 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegr=
a/pinctrl-tegra.c
> index 4547cf66d03b..4da8873942cf 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -96,6 +96,7 @@ static const struct cfg_param {
>  	{"nvidia,slew-rate-falling",	TEGRA_PINCONF_PARAM_SLEW_RATE_FALLING},
>  	{"nvidia,slew-rate-rising",	TEGRA_PINCONF_PARAM_SLEW_RATE_RISING},
>  	{"nvidia,drive-type",		TEGRA_PINCONF_PARAM_DRIVE_TYPE},
> +	{"nvidia,function",			TEGRA_PINCONF_PARAM_FUNCTION},
>  };
> =20
>  static int tegra_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
> @@ -470,6 +471,12 @@ static int tegra_pinconf_reg(struct tegra_pmx *pmx,
>  		*bit =3D g->drvtype_bit;
>  		*width =3D 2;
>  		break;
> +	case TEGRA_PINCONF_PARAM_FUNCTION:
> +		*bank =3D g->mux_bank;
> +		*reg =3D g->mux_reg;
> +		*bit =3D g->mux_bit;
> +		*width =3D 2;
> +		break;
>  	default:
>  		dev_err(pmx->dev, "Invalid config param %04x\n", param);
>  		return -ENOTSUPP;
> @@ -620,6 +627,7 @@ static void tegra_pinconf_group_dbg_show(struct pinct=
rl_dev *pctldev,
>  	s8 bank, bit, width;
>  	s32 reg;
>  	u32 val;
> +	u8 idx;

This declaration could be moved into the only conditional that uses this
variable...

> =20
>  	g =3D &pmx->soc->groups[group];
> =20
> @@ -633,8 +641,15 @@ static void tegra_pinconf_group_dbg_show(struct pinc=
trl_dev *pctldev,
>  		val >>=3D bit;
>  		val &=3D (1 << width) - 1;
> =20
> -		seq_printf(s, "\n\t%s=3D%u",
> -			   strip_prefix(cfg_params[i].property), val);
> +		if (cfg_params[i].param =3D=3D TEGRA_PINCONF_PARAM_FUNCTION) {
> +			idx =3D pmx->soc->groups[group].funcs[val];

=2E.. so that this would become:

			u8 idx =3D ...;

Either way:

Acked-by: Thierry Reding <treding@nvidia.com>

--Fvj6s3HeolWgeMJN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSxGZcACgkQ3SOs138+
s6HAexAAueTXvqtLfeJE+GYFXpZP8Axd/wMGl3np/2XP3uMuonlW0YolTmJ9nZKO
9MILPsKn1/TYL8AsdeRRHCnCDdl5LrZTzbr01hCJof63V01co5KSKZ2lq5WU+0qX
3l0E9BmyEY2/hqv1Od3zBlaliwoYQOFe4gp496/gRK2gjtq/yuL3pTjnFKrdbWCs
z9rRdt/NTrRkr2t/PrWS5BZAvzWt9zivRY3GAdft12vnmGWEksm6IWbZzJH+qS2A
blSwPeYapQqMVYziEO2YSRmYG3YR0+p2TFVTcBGAUK75ayrRtYtUcIS9v6sJqh+F
kZxb/8aQcmE0OdJBa31ozsIBzK9vkagvO+FfTS1SfYg4njJRq+IDdqZzEzb132nZ
wCspM5Sn+LrERg+H2GYRV5LKZwjqTdVL56YOhcp+RwtfmdqdCVdqA79q4Ku1PIdi
nZeoj8/5NrbVnaO/yYo7orJin76cfkOufSNu9+d1P9WASe29GkPcYcpGwHCDAC/D
Ke67A2gWTUxIWHZCnasCj3aVrwNFPlhgWbmoV2qENR5Km0PCL9R2YZmN5RR+ApRg
FGB8OPov0nK6Net9yuY72oaPIRBaja+BMXFT1zYh4pLELVdUw7Aa2NamnZNPyvHT
DM9WNr7+eZLzKvN5sG1b5AydSSPj78wRlgTJMJtxSCJ2oG6Jnnw=
=UDaz
-----END PGP SIGNATURE-----

--Fvj6s3HeolWgeMJN--
