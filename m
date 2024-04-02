Return-Path: <linux-kernel+bounces-128831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57CA89602B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291AC2862CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E451E531;
	Tue,  2 Apr 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="c9CPifCG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MaevhlRD"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA84045008;
	Tue,  2 Apr 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100614; cv=none; b=hdDRw+on5uVfgJ/WwgjSgnEZhfuPv72SdqS2+WbDucPOSNA6IOyzrnGwrqngkcJKxU3lyYzyy+xHgRvi8rYI45/hI34RnVdvcxarnSSpL+0I1kOZvRHyLp+SMrZp9rVF/CxZOcALCyJpcvJjd9QVzwUCRCaN4JTA3kNb/fly+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100614; c=relaxed/simple;
	bh=cFSfbfbs/FxtWhmNg4PvI3AYQoSaWqEX17A1nJklR/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNeCavXkySKFhE5pd8UcDN5lM1GNmvlUSKZdSa3/h3b4tiulbfwX+gY9+qi9VmGv5uE8aXcBhDyJnoiYjR8xlRh0gAJi1OozdhDWSSEBI0ANDrDe2iVpvvBXw1025Q+D56Jw4EcoTcS4PpD8Ba78gOGdbmrEN8JHURj6L5a7eos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=c9CPifCG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MaevhlRD; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7387D18000AD;
	Tue,  2 Apr 2024 19:30:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 19:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712100609;
	 x=1712187009; bh=qd2C6+m9JTrL/24cDYciB5SBNyUCz9EdnJ+XcRcM3oQ=; b=
	c9CPifCGQtG6QwzP+cWQ1vlZFT3pqnkykmJbtaorG+nZev+yBK0evWNo28DXdeIX
	1Rur2yVaT5H+CFUSff/7j38eP7ge7lFvMH8J5rwZK/eeKe8yE2qAELT5GzDIPqnn
	HXMbk9VdCrk92NavxxEQb/iLxN3Xc48AWP9cDKjVpMAx8w2/pj0yjBeoR0GTpf/O
	Mh5gIVxP5HCcvUMcqlguSTOihurqwZvT0KBiPP2wRrHXzWL9aneVswys0hl7oeiV
	NARzOOHlif10t3Mxx/zHERmdGbK+VWgbDTdZxUNmEewClMhp+PkJ9Ya5nP0S47iu
	EUPun4aEL8yC9Nw/pw78ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712100609; x=
	1712187009; bh=qd2C6+m9JTrL/24cDYciB5SBNyUCz9EdnJ+XcRcM3oQ=; b=M
	aevhlRD9pAayxRWPFdbIQmtxjWrEj8TpOJBvRLp+fTwEMmCtb8uyBq2CEiH5yL1a
	TCxI2k4CP7/zGoVj5TVvuoRScRehUbbccmCGLQavoIDpr3yeyETVoPFF935XvVUC
	Kxsjg8DUM2emzZITIw2yfUcJLHIL8+YaLS67rhkpnfblbULNuIVB9s1YXL96Si3y
	58EGyKIs/kkgcUNyDUKFkFlXGVUQqJ5e4nN5yaXVHGJZ2eGmFn5DLes9kjOlRcN2
	38qvyfuXc49mNfJaWu+W4JKdbxoe9quHMqEl63v91OwjqrinrFXM4CHoAh4qgJ4N
	zXhDewiVCZ1Svvih1HjdQ==
X-ME-Sender: <xms:AZUMZt4VhDVPukWekfSsdTms5POgWQt9NVCsebqMRWvWooNZ_abQ9g>
    <xme:AZUMZq7fgGkQdvxIAaUTJufzPxWmVpkfRUzi9A1yP8F2IPu34vLZKD0eXym66LblC
    D82u9PxPdyO2XmmSSw>
X-ME-Received: <xmr:AZUMZkfpncRXk5Wm4bJdFlkV1_uXAQ1AFYlkaEvxPR7MuSbznGMbMvEmWyUAaQCZCmHoVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    ephfeugfegvdeitdefgeevvdelgedutdejueefkeffieevueduhedtueektdffjeeunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:AZUMZmKJKXvhAv5f4hTxFJNWNUNLtBSaWe80Ab2iN1iV7UbrEcEp1Q>
    <xmx:AZUMZhJPuaBP1nLl5vHDuycgVPLvavJYqvHRC6gNxjCsD73QlwVomQ>
    <xmx:AZUMZvxyb-07T6xpQAs1SmLU5PpfGxjSCajbYUJCzkfXgkRTMAy8pw>
    <xmx:AZUMZtLurzQKGa8elXV61DOaZul5_zECoe66sX7H1yAUdcFB7lyLNg>
    <xmx:AZUMZvhcmskKm2MVYygu9WxiZwNl822ZO9S3lX8009FXDBuQdpx5Bpyk>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 19:30:07 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v2 8/9] platform/x86: asus-wmi: Add support for MCU powersave
Date: Wed, 03 Apr 2024 12:30:05 +1300
Message-ID: <24071185.4csPzL39Zc@fedora>
In-Reply-To: <71426f4c-a44a-cf87-7045-b3f2b3fc240e@linux.intel.com>
References:
 <20240402022607.34625-1-luke@ljones.dev>
 <20240402022607.34625-9-luke@ljones.dev>
 <71426f4c-a44a-cf87-7045-b3f2b3fc240e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, 3 April 2024 12:01:15=E2=80=AFAM NZDT Ilpo J=C3=A4rvinen wrot=
e:
> On Tue, 2 Apr 2024, Luke D. Jones wrote:
> > Add support for an MCU powersave WMI call. This is intended to set the
> > MCU in to a low-power mode when sleeping. This mode can cut sleep power
> > use by around half.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>=20
> Hi,
>=20
> I fail to follow the logic of the patch here. This patch makes it
> configurable which is not bad in itself but what is the reason why a user
> would not always want to cut sleep power usage down? So this sounds like a
> feature that the user wants always enabled if available.
>=20
> So what are the downsides of enabling it if it's supported?

Honestly, I'm not sure. Previously it was a source of issues but with recen=
t=20
bios and more work in the various gaming-handheld distros it's much less of=
 a=20
problem. The issue before was that the MCU would appear every second suspen=
d=20
due to the suspend sequence being more parallel compared to windows being=20
sequential - the acpi calls related to this would "unplug" the USB devices=
=20
that are related to the n-key (keyboard, same internal dev as laptops) and =
not=20
complete it before suspend. And then on resume it was unreliable.

I worked around this by calling the unplug very early, and trying to "plug"=
=20
super early also so that subsystems wouldn't notice the absence of the devi=
ce=20
and create new devices + paths on add. Most of the requirement for that cam=
e=20
from some userspace programs unable to handle the unplug/plug part, but als=
o=20
bad device state occurring.

But now with the forced wait for the device to finish its task, and then th=
e=20
forced wait before letting it add itself back everything is fine - although=
 it=20
does mean everything sees a device properly unplugged and plugged.

All of the above is to say that the "powersave" function was also part of t=
he=20
issue as delayed things further and we couldn't add the device back before=
=20
subsystems noticed.

Distros like bazzite and chimeraOS are now using this patch, and I'd like t=
o=20
leave it to them to set a default for now. If it turns out everything is=20
indeed safe as houses then we can adjust the kernel default.

A side-note I think is that because there is a forced wait time due to unab=
le=20
to use the right acpi path, the old excuse of "but users might want the dev=
ice=20
to wake faster by turning off powersave" doesn't really apply now.

I will discuss with the main stakeholders, but for now can we accept as is?=
 If=20
changes are required we'll get them done before the merge window.

>=20
> > ---
> >=20
> >  .../ABI/testing/sysfs-platform-asus-wmi       | 11 +++-
> >  drivers/platform/x86/asus-wmi.c               | 50 +++++++++++++++++++
> >  2 files changed, 60 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > b/Documentation/ABI/testing/sysfs-platform-asus-wmi index
> > 41b92e53e88a..28144371a0f1 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > @@ -202,4 +202,13 @@ Contact:	"Luke Jones" <luke@ljones.dev>
> >=20
> >  Description:
> >  		Set if the BIOS POST sound is played on boot.
> >  	=09
> >  			* 0 - False,
> >=20
> > -			* 1 - True
> > \ No newline at end of file
> > +			* 1 - True
> > +
> > +What:		/sys/devices/platform/<platform>/mcu_powersave
> > +Date:		Apr 2024
> > +KernelVersion:	6.10
> > +Contact:	"Luke Jones" <luke@ljones.dev>
> > +Description:
> > +		Set if the MCU can go in to low-power mode on system=20
sleep
> > +			* 0 - False,
> > +			* 1 - True
> > diff --git a/drivers/platform/x86/asus-wmi.c
> > b/drivers/platform/x86/asus-wmi.c index ddf568ef8c5e..cf872eed0986 1006=
44
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -1292,6 +1292,53 @@ static ssize_t nv_temp_target_show(struct device
> > *dev,>=20
> >  }
> >  static DEVICE_ATTR_RW(nv_temp_target);
> >=20
> > +/* Ally MCU Powersave
> > ********************************************************/ +static ssize=
_t
> > mcu_powersave_show(struct device *dev,
> > +				   struct device_attribute *attr,=20
char *buf)
> > +{
> > +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > +	int result;
> > +
> > +	result =3D asus_wmi_get_devstate_simple(asus,
> > ASUS_WMI_DEVID_MCU_POWERSAVE); +	if (result < 0)
> > +		return result;
> > +
> > +	return sysfs_emit(buf, "%d\n", result);
> > +}
> > +
> > +static ssize_t mcu_powersave_store(struct device *dev,
> > +				    struct device_attribute *attr,
> > +				    const char *buf, size_t count)
> > +{
> > +	int result, err;
> > +	u32 enable;
> > +
> > +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > +
> > +	result =3D kstrtou32(buf, 10, &enable);
> > +	if (result)
> > +		return result;
> > +
> > +	if (enable > 1)
> > +		return -EINVAL;
> > +
> > +	err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, enable,
> > &result); +	if (err) {
> > +		pr_warn("Failed to set MCU powersave: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	if (result > 1) {
> > +		pr_warn("Failed to set MCU powersave (result): 0x%x\n",=20
result);
> > +		return -EIO;
> > +	}
> > +
> > +	sysfs_notify(&asus->platform_device->dev.kobj, NULL,=20
"mcu_powersave");
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(mcu_powersave);
> > +
> >=20
> >  /* Battery
> >  ********************************************************************/
> > =20
> >  /* The battery maximum charging percentage */
> >=20
> > @@ -4299,6 +4346,7 @@ static struct attribute *platform_attributes[] =
=3D {
> >=20
> >  	&dev_attr_ppt_platform_sppt.attr,
> >  	&dev_attr_nv_dynamic_boost.attr,
> >  	&dev_attr_nv_temp_target.attr,
> >=20
> > +	&dev_attr_mcu_powersave.attr,
> >=20
> >  	&dev_attr_boot_sound.attr,
> >  	&dev_attr_panel_od.attr,
> >  	&dev_attr_mini_led_mode.attr,
> >=20
> > @@ -4352,6 +4400,8 @@ static umode_t asus_sysfs_is_visible(struct kobje=
ct
> > *kobj,>=20
> >  		devid =3D ASUS_WMI_DEVID_NV_DYN_BOOST;
> >  =09
> >  	else if (attr =3D=3D &dev_attr_nv_temp_target.attr)
> >  =09
> >  		devid =3D ASUS_WMI_DEVID_NV_THERM_TARGET;
> >=20
> > +	else if (attr =3D=3D &dev_attr_mcu_powersave.attr)
> > +		devid =3D ASUS_WMI_DEVID_MCU_POWERSAVE;
> >=20
> >  	else if (attr =3D=3D &dev_attr_boot_sound.attr)
> >  =09
> >  		devid =3D ASUS_WMI_DEVID_BOOT_SOUND;
> >  =09
> >  	else if (attr =3D=3D &dev_attr_panel_od.attr)




