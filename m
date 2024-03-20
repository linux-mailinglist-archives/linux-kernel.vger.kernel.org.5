Return-Path: <linux-kernel+bounces-108309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7668F8808F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA5E1F2127E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB9BDF41;
	Wed, 20 Mar 2024 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="CYidJrBm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zof0fiAh"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD30AD55;
	Wed, 20 Mar 2024 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897513; cv=none; b=eprMoHL0edij0LqMINaKRrRfq5LAh8WDSzh+JvwElcAvLk6C1QjO6bIpD4vD16nc+C/N5iG1vW2WqphVreT0k9/QHT+0NvrW2fsamKsEOTwmADm5aYwPYEsJKJiTolGHLdUxHPfGl6Z6VgHZp50nGxk+SmNbMoWWP6LZ9DDhRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897513; c=relaxed/simple;
	bh=nJDqdcg97WnILE42dfLUNrr2FqSNkUR5tDc10lHna2M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oKAE+IUsdiAnhcwWMte8Q9OuE7sqCgdHxULnCb4EZfksOF4G+vPAdP8Oy6i5fhLMefZhpC8jZLxyGwVZswB7sTisf3gzKqxYriDJ6G4LZQ83Kz/JOXD9RmMn/kTH+EnUrwaxj0TeLIXEgwyiXx4DZM1UPs5lDcr9n9guo5KmPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=CYidJrBm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zof0fiAh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BBB9811400BE;
	Tue, 19 Mar 2024 21:18:29 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 19 Mar 2024 21:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1710897509;
	 x=1710983909; bh=NKkilPXE7dD9zs5W8ZOOYgwSrS4G1qp6twnPIafRbRQ=; b=
	CYidJrBm13MqJ8cn+WLCFWIlBbC2YHfXOhoXkMJ7RfRscaIXCOgfdNVge1wYbTG8
	YnbvVkvmxz+L19s7XsMvbTzp1cGn9tYP1Si4k0fClVZTS69wgP6wzbho4+I5a03u
	mi5+LYC1p72/E4U7ccVHVSQ8T4iTsepf7sP1M16+72qXhvCVzOrK8DRWRBh6Rkgc
	CnnCPss+sJ9oBI8oXJPp3rAZd8D4hyYozB7cJ6PRX/YsKVTxF27nFYWQgXkx2yTG
	PgHcJstFCp5OytsqqwWJ4iIlKZRH6kegC1hmCOEMSQ5Fw1H7cEOUocnpeLJ6id06
	W1ls5EAw4xJM2CbTERizYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710897509; x=
	1710983909; bh=NKkilPXE7dD9zs5W8ZOOYgwSrS4G1qp6twnPIafRbRQ=; b=Z
	of0fiAhKzGRjsy8jICG1ociejVBLRfKecG/7wvygYNCI3BEXpdMmooPQ3FgmlJFZ
	tItuspN8VV7cOq1DTdybPWjLuJIWsx/RYTWfhKVGLdR8Kx3nf7Qj8n3uXzj0GrN5
	zPmOP24ZZZxPXddJzMbK8tn1XZuMvva2vjOXWBgSdh5P9E+5x4KKO411OzyP0kDK
	cGm0WmsZY7l8Wuhm4nAUemf8nxQ2proQ3V7XmZP/cztLL1N7YcDEIhYHLiAF7YX1
	mrxpJpbIK71X1WR1aoA6reaQR9XyHorfY2dUJQSSj3hXEcff5yaldboeqrpMN+ob
	7smIYFE7RGkHMVn2Th8gw==
X-ME-Sender: <xms:ZTn6ZWBRhXrv-KFQ_GVcHUzcIvZMe8Ndvaqf13v35s96PFbKbJhZXQ>
    <xme:ZTn6ZQgCVn7Sh5swYJqqiZS2jA6fuJuRxA5_jI1nJQaDLruN3t-frERQ3MqT0JVjQ
    2sMY6AjVEQNmGUDg-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpeefuefghfdvueefheeiledvgeefffevgeelhedtvdehgeekteeugedtgeeuhedv
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ZTn6ZZllMtdIuKFKOWYfZuhlPB3r6Yl6byOLB9g0BergJfbb4Z3yPA>
    <xmx:ZTn6ZUwkrIOqrqKZrjVOTgX0ETeMc94GBo8rDqaizk0soepp_ldEyw>
    <xmx:ZTn6ZbSAO1OvPcaRTEBDQ9dJxgbNB2oD8nabf_nryYCkYE0qQfdyVA>
    <xmx:ZTn6ZfYgziQo_lLABkCD-m5LB0IffMaqajF3iKOOQfKSQ53E_11jWg>
    <xmx:ZTn6ZVdvQTg8SaD4ZvFG-BpeRxjN0Mgh7nYiOQ5VU1zfnQ2Ktt-q2w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7ADC12340080; Tue, 19 Mar 2024 21:18:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7276ec7b-9b00-4241-a4eb-a8997daeba5c@app.fastmail.com>
In-Reply-To: <5f853562-cbe0-32d7-2644-d42d2bb9e060@linux.intel.com>
References: <20240310061715.16531-1-luke@ljones.dev>
 <5f853562-cbe0-32d7-2644-d42d2bb9e060@linux.intel.com>
Date: Wed, 20 Mar 2024 14:18:09 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
 "Hans de Goede" <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: support toggling POST sound
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, 20 Mar 2024, at 6:48 AM, Ilpo J=C3=A4rvinen wrote:
> On Sun, 10 Mar 2024, Luke D. Jones wrote:
>=20
> > Add support for toggling the BIOS POST sound on some ASUS laptops.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  .../ABI/testing/sysfs-platform-asus-wmi       |  7 +++
> >  drivers/platform/x86/asus-wmi.c               | 54 ++++++++++++++++=
+++
> >  include/linux/platform_data/x86/asus-wmi.h    |  3 ++
> >  3 files changed, 64 insertions(+)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Doc=
umentation/ABI/testing/sysfs-platform-asus-wmi
> > index e32b4f0ae15f..f3c53b7453f0 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > @@ -194,3 +194,10 @@ Contact: "Luke Jones" <luke@ljones.dev>
> >  Description:
> >  Set the target temperature limit of the Nvidia dGPU:
> >  * min=3D75, max=3D87
> > +
> > +What: /sys/devices/platform/<platform>/boot_sound
> > +Date: Jun 2023
> > +KernelVersion: 6.9
> > +Contact: "Luke Jones" <luke@ljones.dev>
> > +Description:
> > + Set if the BIOS POST sound is played on boot.
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index ca8c73c15fcc..26084e9846a1 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -297,6 +297,7 @@ struct asus_wmi {
> >  // The RSOC controls the maximum charging percentage.
> >  bool battery_rsoc_available;
> > =20
> > + bool boot_sound_available;
> >  bool panel_overdrive_available;
> >  bool mini_led_mode_available;
> >  u32 mini_led_dev_id;
> > @@ -2106,6 +2107,55 @@ static ssize_t panel_od_store(struct device *=
dev,
> >  }
> >  static DEVICE_ATTR_RW(panel_od);
> > =20
> > +/* Bootup sound ***************************************************=
************/
> > +
> > +static ssize_t boot_sound_show(struct device *dev,
> > +      struct device_attribute *attr, char *buf)
> > +{
> > + struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > + int result;
> > +
> > + result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_BOOT_=
SOUND);
> > + if (result < 0)
> > + return result;
> > +
> > + return sysfs_emit(buf, "%d\n", result);
> > +}
> > +
> > +static ssize_t boot_sound_store(struct device *dev,
> > +       struct device_attribute *attr,
> > +       const char *buf, size_t count)
> > +{
> > + int result, err;
> > + u32 snd;
> > +
> > + struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > +
> > + result =3D kstrtou32(buf, 10, &snd);
> > + if (result)
> > + return result;
> > +
> > + if (snd > 1)
> > + return -EINVAL;
>=20
> Why not just use kstrtobool()?

Consistency with other methods mostly. Plus the possibility that asus mi=
ght do something like add different sounds. I'll change it if a revert b=
ack to kstrtou32 later doesn't break things.

>=20
> > +
> > + err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_BOOT_SOUND, snd, &res=
ult);
> > +
> > + if (err) {
>=20
> Don't leave empty lines between the call and its error handling.

Got it, thanks.
If there is nothing else I'll submit new version.

>=20
> --=20
> i.
>=20
> > + pr_warn("Failed to set boot sound: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (result > 1) {
> > + pr_warn("Failed to set panel boot sound (result): 0x%x\n", result);
> > + return -EIO;
> > + }
> > +
> > + sysfs_notify(&asus->platform_device->dev.kobj, NULL, "boot_sound");
> > +
> > + return count;
> > +}
> > +static DEVICE_ATTR_RW(boot_sound);
> > +
> >  /* Mini-LED mode **************************************************=
************/
> >  static ssize_t mini_led_mode_show(struct device *dev,
> >     struct device_attribute *attr, char *buf)
> > @@ -4196,6 +4246,7 @@ static struct attribute *platform_attributes[]=
 =3D {
> >  &dev_attr_ppt_platform_sppt.attr,
> >  &dev_attr_nv_dynamic_boost.attr,
> >  &dev_attr_nv_temp_target.attr,
> > + &dev_attr_boot_sound.attr,
> >  &dev_attr_panel_od.attr,
> >  &dev_attr_mini_led_mode.attr,
> >  &dev_attr_available_mini_led_mode.attr,
> > @@ -4248,6 +4299,8 @@ static umode_t asus_sysfs_is_visible(struct ko=
bject *kobj,
> >  ok =3D asus->nv_dyn_boost_available;
> >  else if (attr =3D=3D &dev_attr_nv_temp_target.attr)
> >  ok =3D asus->nv_temp_tgt_available;
> > + else if (attr =3D=3D &dev_attr_boot_sound.attr)
> > + ok =3D asus->boot_sound_available;
> >  else if (attr =3D=3D &dev_attr_panel_od.attr)
> >  ok =3D asus->panel_overdrive_available;
> >  else if (attr =3D=3D &dev_attr_mini_led_mode.attr)
> > @@ -4519,6 +4572,7 @@ static int asus_wmi_add(struct platform_device=
 *pdev)
> >  asus->ppt_plat_sppt_available =3D asus_wmi_dev_is_present(asus, ASU=
S_WMI_DEVID_PPT_PLAT_SPPT);
> >  asus->nv_dyn_boost_available =3D asus_wmi_dev_is_present(asus, ASUS=
_WMI_DEVID_NV_DYN_BOOST);
> >  asus->nv_temp_tgt_available =3D asus_wmi_dev_is_present(asus, ASUS_=
WMI_DEVID_NV_THERM_TARGET);
> > + asus->boot_sound_available =3D asus_wmi_dev_is_present(asus, ASUS_=
WMI_DEVID_BOOT_SOUND);
> >  asus->panel_overdrive_available =3D asus_wmi_dev_is_present(asus, A=
SUS_WMI_DEVID_PANEL_OD);
> >  asus->ally_mcu_usb_switch =3D acpi_has_method(NULL, ASUS_USB0_PWR_E=
C0_CSEE)
> >  && dmi_match(DMI_BOARD_NAME, "RC71L");
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/li=
nux/platform_data/x86/asus-wmi.h
> > index 3e9a01467c67..3eb5cd6773ad 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -137,6 +137,9 @@
> >  /* TUF laptop RGB power/state */
> >  #define ASUS_WMI_DEVID_TUF_RGB_STATE 0x00100057
> > =20
> > +/* Bootup sound control */
> > +#define ASUS_WMI_DEVID_BOOT_SOUND 0x00130022
> > +
> >  /* DSTS masks */
> >  #define ASUS_WMI_DSTS_STATUS_BIT 0x00000001
> >  #define ASUS_WMI_DSTS_UNKNOWN_BIT 0x00000002
> >=20
>=20

