Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF07EFEE9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjKRKg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:36:27 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F53D75
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 02:36:19 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 7FB44240105
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 11:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1700303777; bh=NX9gCi73wwTwdwKip7o7APQwlao0YIT5W8yeNUhkgck=;
        h=Mime-Version:Content-Transfer-Encoding:Date:From:To:Cc:Subject:
         Message-Id:From;
        b=oLWhOnzJU5LxXKLAETBkTbP7vrjooCWKW2qk/pLuBRAPQPhwHzpOAw0JFQujy++0H
         DtpkIRZqz/Vebs8uPCogAEp1YICgAM0pAs9QbUJFQpqBLGhlWmK0bV4fFVs9cOm7PD
         n0eVWOR+9bIN9RWNTjHKJncmGhGzYGMAS4kC89z1TLy86VqbAtmTYb/tGAjQvZbtBI
         8YzN0uSGk16cefMw5hO0KVt37tRgSPdNkXeyFYK+53TziHQw0nvqaOG7sGdFZaZMgK
         GjvqevLJkTBSuJPo6Kucbjs0lBOOEUpjnSXgoZfEBWRu6iBR4ix6jZqj+oFOVEMiK1
         G+wkDcdmiYOhw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SXVYV2hG0z6twV;
        Sat, 18 Nov 2023 11:36:14 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 18 Nov 2023 10:36:16 +0000
From:   "Charalampos Mitrodimas" <charmitro@posteo.net>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "qinyu" <qinyu32@huawei.com>,
        "Nick Alcock" <nick.alcock@oracle.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Andreas Kemnade" <andreas@kemnade.info>,
        "Ian Molton" <spyro@f2s.com>,
        "Szabolcs Gyurko" <szabolcs.gyurko@tlt.hu>,
        "Anton Vorontsov" <cbou@mail.ru>
Cc:     "Linux Power Management" <linux-pm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: Fix indentation and some other warnings
Message-Id: <CX1VDFVCGNKO.3JX5QY0LZQ51B@beast>
References: <20231117230658.65809-1-charmitro@posteo.net>
 <ZVf48PWBpvKULeXT@archie.me>
In-Reply-To: <ZVf48PWBpvKULeXT@archie.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On Sat Nov 18, 2023 at 1:36 AM EET, Bagas Sanjaya wrote:
> On Fri, Nov 17, 2023 at 11:06:58PM +0000, Charalampos Mitrodimas wrote:
> > These were mentioned by checkpatch:
> > 	Errors:
> > 		(1) code indent should use tabs where possible
> > 		(2) switch and case should be at the same indent
> > 	Warnings:
> > 		(1) quoted string split across lines
> > 		(2) Missing a blank line after declarations
> >=20
> > Based on this comment from "include/linux/module.h", modules with
> > multiple authors should use multiple MODULE_AUTHOR() statements.
> > 	/*
> > 	 * Author(s), use "Name <email>" or just "Name", for multiple
> > 	 * authors use multiple MODULE_AUTHOR() statements/lines.
> > 	 */
> > 	#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)
>
> Shouldn't MODULE_AUTHOR fix be separate patch?

Sorry, I should have mentioned in the commit that the warnings "quoted
string split across lines" pertained to the MODULE_AUTHOR line.=20

In the commit message I'm just clarifying why I used multiple
MODULE_AUTHOR statements.

Should I send a v2 patch with a revised commit description?

>
> >=20
> > Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> > ---
> >  drivers/power/supply/power_supply_core.c | 167 ++++++++++++-----------
> >  1 file changed, 84 insertions(+), 83 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index 73265001dd4b..ecef35ac3b7e 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -861,44 +861,44 @@ const size_t power_supply_battery_info_properties=
_size =3D ARRAY_SIZE(power_supply
> >  EXPORT_SYMBOL_GPL(power_supply_battery_info_properties_size);
> > =20
> >  bool power_supply_battery_info_has_prop(struct power_supply_battery_in=
fo *info,
> > -				        enum power_supply_property psp)
> > +					enum power_supply_property psp)
>
> Looks OK.
>
> >  {
> >  	if (!info)
> >  		return false;
> > =20
> >  	switch (psp) {
> > -		case POWER_SUPPLY_PROP_TECHNOLOGY:
> > -			return info->technology !=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> > -		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> > -			return info->energy_full_design_uwh >=3D 0;
> > -		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> > -			return info->charge_full_design_uah >=3D 0;
> > -		case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> > -			return info->voltage_min_design_uv >=3D 0;
> > -		case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> > -			return info->voltage_max_design_uv >=3D 0;
> > -		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> > -			return info->precharge_current_ua >=3D 0;
> > -		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> > -			return info->charge_term_current_ua >=3D 0;
> > -		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> > -			return info->constant_charge_current_max_ua >=3D 0;
> > -		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> > -			return info->constant_charge_voltage_max_uv >=3D 0;
> > -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> > -			return info->temp_ambient_alert_min > INT_MIN;
> > -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> > -			return info->temp_ambient_alert_max < INT_MAX;
> > -		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> > -			return info->temp_alert_min > INT_MIN;
> > -		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> > -			return info->temp_alert_max < INT_MAX;
> > -		case POWER_SUPPLY_PROP_TEMP_MIN:
> > -			return info->temp_min > INT_MIN;
> > -		case POWER_SUPPLY_PROP_TEMP_MAX:
> > -			return info->temp_max < INT_MAX;
> > -		default:
> > -			return false;
> > +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> > +		return info->technology !=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> > +	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> > +		return info->energy_full_design_uwh >=3D 0;
> > +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> > +		return info->charge_full_design_uah >=3D 0;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> > +		return info->voltage_min_design_uv >=3D 0;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> > +		return info->voltage_max_design_uv >=3D 0;
> > +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> > +		return info->precharge_current_ua >=3D 0;
> > +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> > +		return info->charge_term_current_ua >=3D 0;
> > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> > +		return info->constant_charge_current_max_ua >=3D 0;
> > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> > +		return info->constant_charge_voltage_max_uv >=3D 0;
> > +	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> > +		return info->temp_ambient_alert_min > INT_MIN;
> > +	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> > +		return info->temp_ambient_alert_max < INT_MAX;
> > +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> > +		return info->temp_alert_min > INT_MIN;
> > +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> > +		return info->temp_alert_max < INT_MAX;
> > +	case POWER_SUPPLY_PROP_TEMP_MIN:
> > +		return info->temp_min > INT_MIN;
> > +	case POWER_SUPPLY_PROP_TEMP_MAX:
> > +		return info->temp_max < INT_MAX;
> > +	default:
> > +		return false;
> >  	}
>
> This one LGTM.
>
> >  }
> >  EXPORT_SYMBOL_GPL(power_supply_battery_info_has_prop);
> > @@ -914,53 +914,53 @@ int power_supply_battery_info_get_prop(struct pow=
er_supply_battery_info *info,
> >  		return -EINVAL;
> > =20
> >  	switch (psp) {
> > -		case POWER_SUPPLY_PROP_TECHNOLOGY:
> > -			val->intval =3D info->technology;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> > -			val->intval =3D info->energy_full_design_uwh;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> > -			val->intval =3D info->charge_full_design_uah;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> > -			val->intval =3D info->voltage_min_design_uv;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> > -			val->intval =3D info->voltage_max_design_uv;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> > -			val->intval =3D info->precharge_current_ua;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> > -			val->intval =3D info->charge_term_current_ua;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> > -			val->intval =3D info->constant_charge_current_max_ua;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> > -			val->intval =3D info->constant_charge_voltage_max_uv;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> > -			val->intval =3D info->temp_ambient_alert_min;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> > -			val->intval =3D info->temp_ambient_alert_max;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> > -			val->intval =3D info->temp_alert_min;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> > -			val->intval =3D info->temp_alert_max;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_TEMP_MIN:
> > -			val->intval =3D info->temp_min;
> > -			return 0;
> > -		case POWER_SUPPLY_PROP_TEMP_MAX:
> > -			val->intval =3D info->temp_max;
> > -			return 0;
> > -		default:
> > -			return -EINVAL;
> > +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> > +		val->intval =3D info->technology;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> > +		val->intval =3D info->energy_full_design_uwh;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> > +		val->intval =3D info->charge_full_design_uah;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> > +		val->intval =3D info->voltage_min_design_uv;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> > +		val->intval =3D info->voltage_max_design_uv;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> > +		val->intval =3D info->precharge_current_ua;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> > +		val->intval =3D info->charge_term_current_ua;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> > +		val->intval =3D info->constant_charge_current_max_ua;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> > +		val->intval =3D info->constant_charge_voltage_max_uv;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> > +		val->intval =3D info->temp_ambient_alert_min;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> > +		val->intval =3D info->temp_ambient_alert_max;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> > +		val->intval =3D info->temp_alert_min;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> > +		val->intval =3D info->temp_alert_max;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_TEMP_MIN:
> > +		val->intval =3D info->temp_min;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_TEMP_MAX:
> > +		val->intval =3D info->temp_max;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
>
> And this one too.
>
> > @@ -1636,6 +1637,6 @@ subsys_initcall(power_supply_class_init);
> >  module_exit(power_supply_class_exit);
> > =20
> >  MODULE_DESCRIPTION("Universal power supply monitor class");
> > -MODULE_AUTHOR("Ian Molton <spyro@f2s.com>, "
> > -	      "Szabolcs Gyurko, "
> > -	      "Anton Vorontsov <cbou@mail.ru>");
> > +MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
> > +MODULE_AUTHOR("Szabolcs Gyurko");
> > +MODULE_AUTHOR("Anton Vorontsov <cbou@mail.ru>");
>
> And also this one.
>
> Thanks.
>
> --=20
> An old man doll... just what I always wanted! - Clara

Thanks
