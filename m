Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0DB7EFC27
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346303AbjKQXg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQXgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:36:24 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ABFD6D;
        Fri, 17 Nov 2023 15:36:21 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so2455638b3a.3;
        Fri, 17 Nov 2023 15:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700264180; x=1700868980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9qNCEpN9tV4OA/IjVzX3FD26FjmpjuQwgfoGVnG3ls=;
        b=PWXkDy+e7HVH2GGLNmelsS/SYz1ewvikUqDUiOk9u3Vn7PWhFSqm18Bf64g5Ua/DZs
         ikZKo9UJmt7y0r7PfPpVPy5OjEm2EjrDn5aNzprP/XHvK5SIU3+C57xxAt0CgTac6qzO
         w5eSyqVDmt0TKLYjiayXlcz2k9wEPjZBHMKacrw8Mrrmmq4PzJBTkmQPLaFcYYpzqWcz
         6AaOOGy86q+RF09XBvjSyivNIXT8Mk1DnZy+ws4bn3WCrbxE9B1KE/6/ePQvhO0attbB
         gN0SiAhN15K99XoPHNfZIaKp1A3Jk12YGHViyjY+7QTZFGlF9gvOE8qy4/N/56wx2GQo
         iFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700264180; x=1700868980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9qNCEpN9tV4OA/IjVzX3FD26FjmpjuQwgfoGVnG3ls=;
        b=L098r8Ei+G/GldQDFStken7TL0vTvGFajiPilhqZ9Gq7JTN+hLkyFpn5ZSERNz53xf
         LIag1ZPJOAY28uSeKWOxmaYjx2Az6qtThMCJ0YfFrs6ovKkRr0PUGjRTh76miYMlL4Ff
         ZR2CMNYHtWxPek0cpc5dATagE1aAcrYFVxrs9e3IU7Z4K3FHVLYCNlXyrJdRIuqRlSGJ
         tx0rwYkADPnMiGL6z+9fYmPYBZwbo1Tcz7+xxRM1emRNetU3LMlYgl+x4z1o3FJTP+ci
         HnUtQ0sk8y2O7IEHRkMlN+K5mr/18MkyzHOmLGn9AlAERjzT6bGyNLXSxQrg5aeDi8Jg
         6LWg==
X-Gm-Message-State: AOJu0Yx3oZ5fo0dKxrIx1tk8kE3QZMeMmslhte8VClRp8W7E/ol9XLTW
        51bCK548vYOw9st4vhPFwUM=
X-Google-Smtp-Source: AGHT+IEx78fKhIYOg1XKcHZwD81wxiY5Xcft89Ye+RLAYq9c3MhIHYCTdZ3FXyoLD7I/y6tzJIaHTA==
X-Received: by 2002:a05:6a00:1d89:b0:6bf:50df:2df5 with SMTP id z9-20020a056a001d8900b006bf50df2df5mr1267005pfw.13.1700264180517;
        Fri, 17 Nov 2023 15:36:20 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a001b4e00b006c33bf9905fsm1915488pfv.25.2023.11.17.15.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 15:36:20 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 5355B102070AC; Sat, 18 Nov 2023 06:36:17 +0700 (WIB)
Date:   Sat, 18 Nov 2023 06:36:16 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Charalampos Mitrodimas <charmitro@posteo.net>,
        Sebastian Reichel <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        qinyu <qinyu32@huawei.com>, Nick Alcock <nick.alcock@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Ian Molton <spyro@f2s.com>,
        Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>,
        Anton Vorontsov <cbou@mail.ru>
Cc:     Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: Fix indentation and some other warnings
Message-ID: <ZVf48PWBpvKULeXT@archie.me>
References: <20231117230658.65809-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+tJVt8GoTANVf/9m"
Content-Disposition: inline
In-Reply-To: <20231117230658.65809-1-charmitro@posteo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+tJVt8GoTANVf/9m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 11:06:58PM +0000, Charalampos Mitrodimas wrote:
> These were mentioned by checkpatch:
> 	Errors:
> 		(1) code indent should use tabs where possible
> 		(2) switch and case should be at the same indent
> 	Warnings:
> 		(1) quoted string split across lines
> 		(2) Missing a blank line after declarations
>=20
> Based on this comment from "include/linux/module.h", modules with
> multiple authors should use multiple MODULE_AUTHOR() statements.
> 	/*
> 	 * Author(s), use "Name <email>" or just "Name", for multiple
> 	 * authors use multiple MODULE_AUTHOR() statements/lines.
> 	 */
> 	#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)

Shouldn't MODULE_AUTHOR fix be separate patch?

>=20
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
>  drivers/power/supply/power_supply_core.c | 167 ++++++++++++-----------
>  1 file changed, 84 insertions(+), 83 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 73265001dd4b..ecef35ac3b7e 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -861,44 +861,44 @@ const size_t power_supply_battery_info_properties_s=
ize =3D ARRAY_SIZE(power_supply
>  EXPORT_SYMBOL_GPL(power_supply_battery_info_properties_size);
> =20
>  bool power_supply_battery_info_has_prop(struct power_supply_battery_info=
 *info,
> -				        enum power_supply_property psp)
> +					enum power_supply_property psp)

Looks OK.

>  {
>  	if (!info)
>  		return false;
> =20
>  	switch (psp) {
> -		case POWER_SUPPLY_PROP_TECHNOLOGY:
> -			return info->technology !=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> -		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> -			return info->energy_full_design_uwh >=3D 0;
> -		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> -			return info->charge_full_design_uah >=3D 0;
> -		case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> -			return info->voltage_min_design_uv >=3D 0;
> -		case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> -			return info->voltage_max_design_uv >=3D 0;
> -		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> -			return info->precharge_current_ua >=3D 0;
> -		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> -			return info->charge_term_current_ua >=3D 0;
> -		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> -			return info->constant_charge_current_max_ua >=3D 0;
> -		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> -			return info->constant_charge_voltage_max_uv >=3D 0;
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> -			return info->temp_ambient_alert_min > INT_MIN;
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> -			return info->temp_ambient_alert_max < INT_MAX;
> -		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> -			return info->temp_alert_min > INT_MIN;
> -		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> -			return info->temp_alert_max < INT_MAX;
> -		case POWER_SUPPLY_PROP_TEMP_MIN:
> -			return info->temp_min > INT_MIN;
> -		case POWER_SUPPLY_PROP_TEMP_MAX:
> -			return info->temp_max < INT_MAX;
> -		default:
> -			return false;
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		return info->technology !=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> +	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> +		return info->energy_full_design_uwh >=3D 0;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		return info->charge_full_design_uah >=3D 0;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		return info->voltage_min_design_uv >=3D 0;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		return info->voltage_max_design_uv >=3D 0;
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		return info->precharge_current_ua >=3D 0;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		return info->charge_term_current_ua >=3D 0;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return info->constant_charge_current_max_ua >=3D 0;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		return info->constant_charge_voltage_max_uv >=3D 0;
> +	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> +		return info->temp_ambient_alert_min > INT_MIN;
> +	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> +		return info->temp_ambient_alert_max < INT_MAX;
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +		return info->temp_alert_min > INT_MIN;
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		return info->temp_alert_max < INT_MAX;
> +	case POWER_SUPPLY_PROP_TEMP_MIN:
> +		return info->temp_min > INT_MIN;
> +	case POWER_SUPPLY_PROP_TEMP_MAX:
> +		return info->temp_max < INT_MAX;
> +	default:
> +		return false;
>  	}

This one LGTM.

>  }
>  EXPORT_SYMBOL_GPL(power_supply_battery_info_has_prop);
> @@ -914,53 +914,53 @@ int power_supply_battery_info_get_prop(struct power=
_supply_battery_info *info,
>  		return -EINVAL;
> =20
>  	switch (psp) {
> -		case POWER_SUPPLY_PROP_TECHNOLOGY:
> -			val->intval =3D info->technology;
> -			return 0;
> -		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> -			val->intval =3D info->energy_full_design_uwh;
> -			return 0;
> -		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> -			val->intval =3D info->charge_full_design_uah;
> -			return 0;
> -		case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> -			val->intval =3D info->voltage_min_design_uv;
> -			return 0;
> -		case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> -			val->intval =3D info->voltage_max_design_uv;
> -			return 0;
> -		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> -			val->intval =3D info->precharge_current_ua;
> -			return 0;
> -		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> -			val->intval =3D info->charge_term_current_ua;
> -			return 0;
> -		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> -			val->intval =3D info->constant_charge_current_max_ua;
> -			return 0;
> -		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> -			val->intval =3D info->constant_charge_voltage_max_uv;
> -			return 0;
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> -			val->intval =3D info->temp_ambient_alert_min;
> -			return 0;
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> -			val->intval =3D info->temp_ambient_alert_max;
> -			return 0;
> -		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> -			val->intval =3D info->temp_alert_min;
> -			return 0;
> -		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> -			val->intval =3D info->temp_alert_max;
> -			return 0;
> -		case POWER_SUPPLY_PROP_TEMP_MIN:
> -			val->intval =3D info->temp_min;
> -			return 0;
> -		case POWER_SUPPLY_PROP_TEMP_MAX:
> -			val->intval =3D info->temp_max;
> -			return 0;
> -		default:
> -			return -EINVAL;
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D info->technology;
> +		return 0;
> +	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> +		val->intval =3D info->energy_full_design_uwh;
> +		return 0;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		val->intval =3D info->charge_full_design_uah;
> +		return 0;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		val->intval =3D info->voltage_min_design_uv;
> +		return 0;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		val->intval =3D info->voltage_max_design_uv;
> +		return 0;
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		val->intval =3D info->precharge_current_ua;
> +		return 0;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		val->intval =3D info->charge_term_current_ua;
> +		return 0;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		val->intval =3D info->constant_charge_current_max_ua;
> +		return 0;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		val->intval =3D info->constant_charge_voltage_max_uv;
> +		return 0;
> +	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> +		val->intval =3D info->temp_ambient_alert_min;
> +		return 0;
> +	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> +		val->intval =3D info->temp_ambient_alert_max;
> +		return 0;
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +		val->intval =3D info->temp_alert_min;
> +		return 0;
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		val->intval =3D info->temp_alert_max;
> +		return 0;
> +	case POWER_SUPPLY_PROP_TEMP_MIN:
> +		val->intval =3D info->temp_min;
> +		return 0;
> +	case POWER_SUPPLY_PROP_TEMP_MAX:
> +		val->intval =3D info->temp_max;
> +		return 0;
> +	default:
> +		return -EINVAL;

And this one too.

> @@ -1636,6 +1637,6 @@ subsys_initcall(power_supply_class_init);
>  module_exit(power_supply_class_exit);
> =20
>  MODULE_DESCRIPTION("Universal power supply monitor class");
> -MODULE_AUTHOR("Ian Molton <spyro@f2s.com>, "
> -	      "Szabolcs Gyurko, "
> -	      "Anton Vorontsov <cbou@mail.ru>");
> +MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
> +MODULE_AUTHOR("Szabolcs Gyurko");
> +MODULE_AUTHOR("Anton Vorontsov <cbou@mail.ru>");

And also this one.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--+tJVt8GoTANVf/9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVf47QAKCRD2uYlJVVFO
o0etAP9SgY3bzx/cimWhS/4zcERQn9QAUE305M86+AupreQdeAD/Vpi5jdF9ahGN
NYDkY6/YfcM0vAf7sCO8EC3+OJRRcgA=
=MrqQ
-----END PGP SIGNATURE-----

--+tJVt8GoTANVf/9m--
