Return-Path: <linux-kernel+bounces-128847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C59896072
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79761286D00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D191598FA;
	Wed,  3 Apr 2024 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="DvxBkf/f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDHPrJ/G"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99B128834;
	Wed,  3 Apr 2024 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712102405; cv=none; b=MAOOfx45E3e4Od55inc6RpFqQl4jI7WUHXkWgeKOHwtC6C61L5eBBDK/K3uqfxIFj3oHGaLzEKEODUx5BuZ3MsD7gmWoNvj4wb34/jgHwOlVDkGOXuLrC9+99JQC4Pjpo7AyGp/ZlzlYY1Z4eFPujCjrs73zf7642nIXumkJALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712102405; c=relaxed/simple;
	bh=Hhfu9C73oFmm/w3srusIJkiJNowvoC0Hp7ee/TnjQhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAvZsY50mXC5niQt+qisGePT0/9cRzQdpachUsxhrWdYmetelqhOupkl2rZ1FZIAC3T8zIWo18xVNQ0sU/FrHSy3KFnhkt+YgC20SgPoy9Vw8iZnNsyk+2sc5+ip9Rr49SKGrc4AdZnn3LY17eLFHb5Nde/wQ26RWUhjvIgrEbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=DvxBkf/f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDHPrJ/G; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 6D9C05C00C1;
	Tue,  2 Apr 2024 20:00:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 20:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712102401;
	 x=1712188801; bh=qRAbW7N3RJcWQ4A9HYO5MxkoOLmaR2tWR4elSn0t2Tg=; b=
	DvxBkf/ftTMhUyA4C51WFuV/1zwxzC0Mnt9OOzFMYEAX2a4hCLbpew+DVnyDoN1D
	uphrFuFGyraDQxIfIlM1JBBdX0nc+wVD5Jz3n8IwRNjg035mYo4eb3femwtB/lG1
	AE0evfkXlF5yfTFGASyALUVNGzH+nISOl1uNOJ+sKmouQXYVcqCS86tNQMOYzXz9
	WU/VzIB2sqlRaZEbi3teH/tFgjtXKJIXq3XXFSYomVKwaAB3pL9lQ10z42EJ1mhb
	w7WkNF69ypsN3amxOzhHv+ILwryQkSmhFRgjW9zBgXUwOfaQzfTFbztyslwUCi+q
	Zw0n0fkNEgtTDQ/SkDvO+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712102401; x=
	1712188801; bh=qRAbW7N3RJcWQ4A9HYO5MxkoOLmaR2tWR4elSn0t2Tg=; b=T
	DHPrJ/G4Yi63+pX6uvkp6+OGsUAEivgExTfPUm7tECh96zDK6jH8m2mja+Qqhrmm
	BnAwSM4p2U6GnAkpCZNHFHizIwkocDynK53CScZ6jhdycGU1I8VJxBldUzWDPZLh
	ADPFjTYTS2MwOFZMZWVg3BeDsTCqSQQ+fv5lNqz2S4LQ19wyyJXJZB4cIVTdtjv5
	OtS3/3I3ID9gmVeleWgNBWxAyA8msHsFpVDJXbNGqgR2N1+Ekae09AyW3LOWVWs/
	3+PQya2UvNEMqHGSoIXH/63wfPOA7eZJ2OkjCEXPy5aB1W9zuFPi13wLiFPghtPn
	p5t/S7N6MGGmdAel5Npjg==
X-ME-Sender: <xms:AJwMZhTCmuV1LzcBFXVsYRb64J-izZbWhhQRv82mk5_laENGLG-YQA>
    <xme:AJwMZqy2qFfMn1Y9-zdpHCeZORQpsuxQ0kgurykifhvYjFg7GCyea6iXZQ8gleozy
    I6lVV_J90axj_wDV10>
X-ME-Received: <xmr:AJwMZm2n5GxE-hNmtiNGEL5h0yAOSLFM-m24VnhH4v5ouIdl-j6WLoDGfnIXLtzDYGXZYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    ephfeugfegvdeitdefgeevvdelgedutdejueefkeffieevueduhedtueektdffjeeunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:AJwMZpCjJu-7bNzhYKUeY9yvf5XJeoQ7MT38PdUSvTUQVGm7JLzAcg>
    <xmx:AZwMZqjIam_Mk9hyfo1TvSEgqzW0Cq5OVs03b60qUz6EBCnl3tz8Sg>
    <xmx:AZwMZtr7hIw2dIDm1suBGNILhMFReqcqVmGGRqeY1vsy_AfFxmqsbw>
    <xmx:AZwMZlipevpRPBT10BQ6CuhLQWX87OSg9sJMcTzXSm2HMNYzoM4I1g>
    <xmx:AZwMZsa_YWwb5vaAVCPFFZIP8lxE103L9niEZUYROMuU8qnK4T2sGUB2f5Sf>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 19:59:59 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v2 1/9] platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
Date: Wed, 03 Apr 2024 12:59:54 +1300
Message-ID: <8012476.IbC2pHGDlb@fedora>
In-Reply-To: <d1ec4c78-0b1e-28ec-7324-806b29ed77c9@linux.intel.com>
References:
 <20240402022607.34625-1-luke@ljones.dev>
 <20240402022607.34625-2-luke@ljones.dev>
 <d1ec4c78-0b1e-28ec-7324-806b29ed77c9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 2 April 2024 11:43:25=E2=80=AFPM NZDT Ilpo J=C3=A4rvinen wrote:
> On Tue, 2 Apr 2024, Luke D. Jones wrote:
> > Support the 2024 mini-led backlight and adjust the related functions
> > to select the relevant dev-id. Also add `available_mini_led_mode` to the
> > platform sysfs since the available mini-led levels can be different.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >=20
> >  .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++
> >  drivers/platform/x86/asus-wmi.c               | 80 ++++++++++++++++---
> >  include/linux/platform_data/x86/asus-wmi.h    |  1 +
> >  3 files changed, 78 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > b/Documentation/ABI/testing/sysfs-platform-asus-wmi index
> > 8a7e25bde085..ef1ac1a20a71 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> >=20
> > @@ -126,6 +126,14 @@ Description:
> >  		Change the mini-LED mode:
> >  			* 0 - Single-zone,
> >  			* 1 - Multi-zone
> >=20
> > +			* 2 - Multi-zone strong (available on newer=20
generation mini-led)
> > +
> > +What:		/sys/devices/platform/<platform>/available_mini_led_mode
> > +Date:		Apr 2024
> > +KernelVersion:	6.10
> > +Contact:	"Luke Jones" <luke@ljones.dev>
> > +Description:
> > +		List the available mini-led modes.
> >=20
> >  What:		/sys/devices/platform/<platform>/ppt_pl1_spl
> >  Date:		Jun 2023
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c
> > b/drivers/platform/x86/asus-wmi.c index 3f07bbf809ef..2330f02ff76f 1006=
44
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -288,7 +288,7 @@ struct asus_wmi {
> >=20
> >  	bool battery_rsoc_available;
> >  =09
> >  	bool panel_overdrive_available;
> >=20
> > -	bool mini_led_mode_available;
> > +	u32 mini_led_dev_id;
> >=20
> >  	struct hotplug_slot hotplug_slot;
> >  	struct mutex hotplug_lock;
> >=20
> > @@ -2108,13 +2108,30 @@ static ssize_t mini_led_mode_show(struct device
> > *dev,>=20
> >  				   struct device_attribute *attr,=20
char *buf)
> > =20
> >  {
> > =20
> >  	struct asus_wmi *asus =3D dev_get_drvdata(dev);
> >=20
> > -	int result;
> > +	u32 value;
> >=20
> > -	result =3D asus_wmi_get_devstate_simple(asus,
> > ASUS_WMI_DEVID_MINI_LED_MODE); -	if (result < 0)
> > -		return result;
> > +	asus_wmi_get_devstate(asus, asus->mini_led_dev_id, &value);
>=20
> Error handling missing.

I omitted it because other uses of this function also ignore it. Might need=
 to=20
do another patch to add handling everywhere else.

=46or now I will add here, and later in the week fix the other cases.

>=20
> > +	value =3D value & 0x03; // only 3 modes on 2024 version
>=20
> Add #define XX GENMASK(1, 0) for this.

Done. I should have done so before, I know.
There are also spots where a mask is explicitly 0xFFFF while there is a def=
ine=20
for that also. Maybe another patch to do here?

>=20
> > -	return sysfs_emit(buf, "%d\n", result);
> > +	/* Remap the mode values to match previous generation mini-led.
> > +	 * Some BIOSes return -19 instead of 2, which is "mini-LED off",=20
this
> > +	 * appears to be a  BIOS bug.
>=20
> Is this comment still 100% valid now or should it be removed completely?
> There's no handling for -19 in ASUS_WMI_DEVID_MINI_LED_MODE2 block?
>=20
> There's also a double space in the comment.

Yay, adhd coding :)
Done.

>=20
> > +	 */
> > +	if (asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2) {
> > +		switch (value) {
> > +		case 0:
> > +			value =3D 1;
> > +			break;
> > +		case 1:
> > +			value =3D 2;
> > +			break;
> > +		case 2:
> > +			value =3D 0;
>=20
> Add break here too.

Wasn't sure it needed it due to being last statement? In either case, done.

>=20
> These literals 0-2 should be named with #defines as it would make the code
> readable, current way of the mapping between literal numbers
> unintelligible magic.

Honestly with the block below it reversing them I thought it was easier. I'=
ll=20
try and come up with some decent define names.

>=20
> > +		}
> > +	} else if (value < 0) {
>=20
> This will never be true because value is u32 and also because of & 0x03
> even if you'd change the type.
>=20
> I don't quite follow what you're trying to do here. Why this only applies
> to cases !=3D ASUS_WMI_DEVID_MINI_LED_MODE2?

Ah.. yes I'll write that comment much better, and the defines hopefully help

>=20
> > +		return value;
> > +	}
> > +	return sysfs_emit(buf, "%d\n", value);
> >=20
> >  }
> > =20
> >  static ssize_t mini_led_mode_store(struct device *dev,
> >=20
> > @@ -2130,11 +2147,28 @@ static ssize_t mini_led_mode_store(struct device
> > *dev,>=20
> >  	if (result)
> >  =09
> >  		return result;
> >=20
> > -	if (mode > 1)
> > +	if (mode > 1 && asus->mini_led_dev_id =3D=3D=20
ASUS_WMI_DEVID_MINI_LED_MODE)
> >=20
> >  		return -EINVAL;
> >=20
> > +	if (mode > 2 && asus->mini_led_dev_id =3D=3D=20
ASUS_WMI_DEVID_MINI_LED_MODE2)
> > +		return -EINVAL;
> > +	/*
> > +	 * Remap the mode values so expected behaviour is the same as the=20
last
> > +	 * generation of mini-LED
>=20
> Missing .

Done

I think everything is in good shape now. Thank you so much for your thoroug=
h=20
reviews.

>=20
> > +	 */
> > +	if (asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2) {
> > +		switch (mode) {
> > +		case 0:
> > +			mode =3D 2;
> > +			break;
> > +		case 1:
> > +			mode =3D 0;
> > +			break;
> > +		case 2:
> > +			mode =3D 1;
> > +		}
> > +	}
> >=20
> > -	err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_MINI_LED_MODE, mode,
> > &result);
> > -
> > +	err =3D asus_wmi_set_devstate(asus->mini_led_dev_id, mode, &result);
> >=20
> >  	if (err) {
> >  =09
> >  		pr_warn("Failed to set mini-LED: %d\n", err);
> >  		return err;
> >=20
> > @@ -2151,6 +2185,23 @@ static ssize_t mini_led_mode_store(struct device
> > *dev,>=20
> >  }
> >  static DEVICE_ATTR_RW(mini_led_mode);
> >=20
> > +static ssize_t available_mini_led_mode_show(struct device *dev,
> > +				  struct device_attribute *attr,=20
char *buf)
> > +{
> > +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > +
> > +	switch (asus->mini_led_dev_id) {
> > +	case ASUS_WMI_DEVID_MINI_LED_MODE:
> > +		return sysfs_emit(buf, "0 1\n");
> > +	case ASUS_WMI_DEVID_MINI_LED_MODE2:
> > +		return sysfs_emit(buf, "0 1 2\n");
> > +	}
> > +
> > +	return sysfs_emit(buf, "0\n");
> > +}
> > +
> > +static DEVICE_ATTR_RO(available_mini_led_mode);
> > +
> >=20
> >  /* Quirks
> >  *********************************************************************/
> > =20
> >  static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
> >=20
> > @@ -4139,6 +4190,7 @@ static struct attribute *platform_attributes[] =
=3D {
> >=20
> >  	&dev_attr_nv_temp_target.attr,
> >  	&dev_attr_panel_od.attr,
> >  	&dev_attr_mini_led_mode.attr,
> >=20
> > +	&dev_attr_available_mini_led_mode.attr,
> >=20
> >  	NULL
> > =20
> >  };
> >=20
> > @@ -4191,7 +4243,9 @@ static umode_t asus_sysfs_is_visible(struct kobje=
ct
> > *kobj,>=20
> >  	else if (attr =3D=3D &dev_attr_panel_od.attr)
> >  =09
> >  		ok =3D asus->panel_overdrive_available;
> >  =09
> >  	else if (attr =3D=3D &dev_attr_mini_led_mode.attr)
> >=20
> > -		ok =3D asus->mini_led_mode_available;
> > +		ok =3D asus->mini_led_dev_id !=3D 0;
> > +	else if (attr =3D=3D &dev_attr_available_mini_led_mode.attr)
> > +		ok =3D asus->mini_led_dev_id !=3D 0;
> >=20
> >  	if (devid !=3D -1)
> >  =09
> >  		ok =3D !(asus_wmi_get_devstate_simple(asus, devid) < 0);
> >=20
> > @@ -4444,10 +4498,14 @@ static int asus_wmi_add(struct platform_device
> > *pdev)>=20
> >  	asus->nv_dyn_boost_available =3D asus_wmi_dev_is_present(asus,
> >  	ASUS_WMI_DEVID_NV_DYN_BOOST); asus->nv_temp_tgt_available =3D
> >  	asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
> >  	asus->panel_overdrive_available =3D asus_wmi_dev_is_present(asus,
> >  	ASUS_WMI_DEVID_PANEL_OD);>=20
> > -	asus->mini_led_mode_available =3D asus_wmi_dev_is_present(asus,
> > ASUS_WMI_DEVID_MINI_LED_MODE);>=20
> >  	asus->ally_mcu_usb_switch =3D acpi_has_method(NULL,
> >  	ASUS_USB0_PWR_EC0_CSEE)
> >  =09
> >  						&&=20
dmi_match(DMI_BOARD_NAME, "RC71L");
> >=20
> > +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
> > +		asus->mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
> > +	else if (asus_wmi_dev_is_present(asus,=20
ASUS_WMI_DEVID_MINI_LED_MODE2))
> > +		asus->mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE2;
> > +
> >=20
> >  	err =3D fan_boost_mode_check_present(asus);
> >  	if (err)
> >  =09
> >  		goto fail_fan_boost_mode;
> >=20
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h
> > b/include/linux/platform_data/x86/asus-wmi.h index
> > ab1c7deff118..9cadce10ad9a 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -71,6 +71,7 @@
> >=20
> >  #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
> >  #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
> >  #define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
> >=20
> > +#define ASUS_WMI_DEVID_MINI_LED_MODE2	0x0005002E
> >=20
> >  /* Storage */
> >  #define ASUS_WMI_DEVID_CARDREADER	0x00080013





