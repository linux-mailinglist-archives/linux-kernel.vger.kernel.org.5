Return-Path: <linux-kernel+bounces-129123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0080896554
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A74A283F68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B923548FF;
	Wed,  3 Apr 2024 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcvNWVzf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB759B61;
	Wed,  3 Apr 2024 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127980; cv=none; b=VZ9LOzJdA78zuoj/utq9bidKjNmQjgar8UFRgVZDbIKyAmCOVffwgW+9GVvZGVNn2p7A4naeoZ/f2UjJacbsh3mRA/zFZsmax10tdfXShoCHLxPF7mOT0dUHOs32c7AOFrHalrkZETpC1akkhwq9MqswlI10GG92V2DZ4y58pBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127980; c=relaxed/simple;
	bh=/MxgVfDUVgRb+s66Jx7hWB5C8Sq2uAQNn/d7MnoZ2y8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S1Y6NqF6FDWIih3hIR/lFZ4WgG33k2t6V7xKS5i+g/j+l6UdWKj/n0ZZjj+3H2pdn7QWg6dZP/tYREgOgZTwtSZ/VZ3INZDXYCIl/GmjSnSfe2midzQKHlJNUnle99kWePmTi0ELMSRrYDZFbaM+O5AKzxl2YmdtphBdnHX5i9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcvNWVzf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712127979; x=1743663979;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/MxgVfDUVgRb+s66Jx7hWB5C8Sq2uAQNn/d7MnoZ2y8=;
  b=NcvNWVzf74L461xloQ5DwYxKibPXTuHWyjQKBpaQGe91Hq3d1q0/IIgz
   uYVBgcvKaePNWngKbdzoOCs2+AR0tqljxfDrOPoEnbVkWe9U7kC/M0t6R
   MYFOlat+gXnpWenZdnTw5wTes7SrD8MRvNTJITYJM1PZxfobtllHCo7td
   oBKUaKsxqPN0FYPi0SONnPOp1FA6zrCL+XolS9lS6YeM4m1voGBduWaWi
   h5qpXeIMEOcIPqv0bXc6HmpCqJefPAmfycE8kL7NyPiWgWOkQHrZcJ//z
   bD+Ys4oUex8rk/MQPa5bpftfeE8gslwKCTbe+IfC7KU3hJxh0Y5QRgszv
   A==;
X-CSE-ConnectionGUID: /lS9qLxaSk2cOsgTA++agw==
X-CSE-MsgGUID: MBTudAqYSRK4dd5PuPcrBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7498663"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7498663"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 00:06:18 -0700
X-CSE-ConnectionGUID: kQ441IM1RAyw65pTmu7oKA==
X-CSE-MsgGUID: jFJEPC7TS0eqhUAgvsyjpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18427205"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.24])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 00:06:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 3 Apr 2024 10:06:11 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] platform/x86: asus-wmi: add support for 2024 ROG
 Mini-LED
In-Reply-To: <20240403002917.2870959-2-luke@ljones.dev>
Message-ID: <60dc1e89-ea67-3215-8e39-e71e97c49df8@linux.intel.com>
References: <20240403002917.2870959-1-luke@ljones.dev> <20240403002917.2870959-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1537023240-1712127971=:1449"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1537023240-1712127971=:1449
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 3 Apr 2024, Luke D. Jones wrote:

> Support the 2024 mini-led backlight and adjust the related functions
> to select the relevant dev-id. Also add `available_mini_led_mode` to the
> platform sysfs since the available mini-led levels can be different.
>=20
> signed-off-by: Luke D. Jones <luke@ljones.dev>

A few small things still below, but in general this is now in much better=
=20
shape!

> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++
>  drivers/platform/x86/asus-wmi.c               | 94 +++++++++++++++++--
>  include/linux/platform_data/x86/asus-wmi.h    |  1 +
>  3 files changed, 93 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Document=
ation/ABI/testing/sysfs-platform-asus-wmi
> index 8a7e25bde085..ef1ac1a20a71 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -126,6 +126,14 @@ Description:
>  =09=09Change the mini-LED mode:
>  =09=09=09* 0 - Single-zone,
>  =09=09=09* 1 - Multi-zone
> +=09=09=09* 2 - Multi-zone strong (available on newer generation mini-led=
)
> +
> +What:=09=09/sys/devices/platform/<platform>/available_mini_led_mode
> +Date:=09=09Apr 2024
> +KernelVersion:=096.10
> +Contact:=09"Luke Jones" <luke@ljones.dev>
> +Description:
> +=09=09List the available mini-led modes.
> =20
>  What:=09=09/sys/devices/platform/<platform>/ppt_pl1_spl
>  Date:=09=09Jun 2023
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index 3f07bbf809ef..588c099103de 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -126,6 +126,17 @@ module_param(fnlock_default, bool, 0444);
>  #define ASUS_SCREENPAD_BRIGHT_MAX 255
>  #define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
> =20
> +#define ASUS_MINI_LED_MODE_MASK=09=090x03
> +/* Standard modes for devices with only on/off */
> +#define ASUS_MINI_LED_OFF=09=090x00
> +#define ASUS_MINI_LED_ON=09=090x01
> +/* New mode on some devices, define here to clarify remapping later */
> +#define ASUS_MINI_LED_STRONG_MODE=090x02
> +/* New modes for devices with 3 mini-led mode types */
> +#define ASUS_MINI_LED_2024_WEAK=09=090x00
> +#define ASUS_MINI_LED_2024_STRONG=090x01
> +#define ASUS_MINI_LED_2024_OFF=09=090x02
> +
>  /* Controls the power state of the USB0 hub on ROG Ally which input is o=
n */
>  #define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
>  /* 300ms so far seems to produce a reliable result on AC and battery */
> @@ -288,7 +299,7 @@ struct asus_wmi {
>  =09bool battery_rsoc_available;
> =20
>  =09bool panel_overdrive_available;
> -=09bool mini_led_mode_available;
> +=09u32 mini_led_dev_id;
> =20
>  =09struct hotplug_slot hotplug_slot;
>  =09struct mutex hotplug_lock;
> @@ -2108,13 +2119,33 @@ static ssize_t mini_led_mode_show(struct device *=
dev,
>  =09=09=09=09   struct device_attribute *attr, char *buf)
>  {
>  =09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> -=09int result;
> +=09int err;
> +=09u32 value;

reverse xmas order.

> =20
> -=09result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED=
_MODE);
> -=09if (result < 0)
> -=09=09return result;
> +=09err =3D asus_wmi_get_devstate(asus, asus->mini_led_dev_id, &value);
> +=09if (err < 0)
> +=09=09return err;
> +=09value =3D value & ASUS_MINI_LED_MODE_MASK;
> =20
> -=09return sysfs_emit(buf, "%d\n", result);
> +=09/*
> +=09 * Remap the mode values to match previous generation mini-led. The l=
ast gen
> +=09 * WMI 0 =3D=3D off, while on this version WMI 2 =3D=3Doff (flipped).
> +=09 */
> +=09if (asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +=09=09switch (value) {
> +=09=09case ASUS_MINI_LED_2024_WEAK:
> +=09=09=09value =3D ASUS_MINI_LED_ON;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_2024_STRONG:
> +=09=09=09value =3D ASUS_MINI_LED_STRONG_MODE;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_2024_OFF:
> +=09=09=09value =3D ASUS_MINI_LED_OFF;
> +=09=09=09break;
> +=09=09}
> +=09}
> +
> +=09return sysfs_emit(buf, "%d\n", value);
>  }
> =20
>  static ssize_t mini_led_mode_store(struct device *dev,
> @@ -2130,11 +2161,30 @@ static ssize_t mini_led_mode_store(struct device =
*dev,
>  =09if (result)
>  =09=09return result;
> =20
> -=09if (mode > 1)
> +=09if (mode > 1 && asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_=
MODE)
> +=09=09return -EINVAL;
> +=09if (mode > 2 && asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_=
MODE2)

These literals should use the new defines I think.

With those small things fixed,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

>  =09=09return -EINVAL;
> =20
> -=09err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_MINI_LED_MODE, mode, &re=
sult);
> +=09/*
> +=09 * Remap the mode values so expected behaviour is the same as the las=
t
> +=09 * generation of mini-LED with 0 =3D=3D off, 1 =3D=3D on.
> +=09 */
> +=09if (asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +=09=09switch (mode) {
> +=09=09case ASUS_MINI_LED_OFF:
> +=09=09=09mode =3D ASUS_MINI_LED_2024_OFF;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_ON:
> +=09=09=09mode =3D ASUS_MINI_LED_2024_WEAK;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_STRONG_MODE:
> +=09=09=09mode =3D ASUS_MINI_LED_2024_STRONG;
> +=09=09=09break;
> +=09=09}
> +=09}
> =20
> +=09err =3D asus_wmi_set_devstate(asus->mini_led_dev_id, mode, &result);
>  =09if (err) {
>  =09=09pr_warn("Failed to set mini-LED: %d\n", err);
>  =09=09return err;
> @@ -2151,6 +2201,23 @@ static ssize_t mini_led_mode_store(struct device *=
dev,
>  }
>  static DEVICE_ATTR_RW(mini_led_mode);
> =20
> +static ssize_t available_mini_led_mode_show(struct device *dev,
> +=09=09=09=09  struct device_attribute *attr, char *buf)
> +{
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +
> +=09switch (asus->mini_led_dev_id) {
> +=09case ASUS_WMI_DEVID_MINI_LED_MODE:
> +=09=09return sysfs_emit(buf, "0 1\n");
> +=09case ASUS_WMI_DEVID_MINI_LED_MODE2:
> +=09=09return sysfs_emit(buf, "0 1 2\n");
> +=09}
> +
> +=09return sysfs_emit(buf, "0\n");
> +}
> +
> +static DEVICE_ATTR_RO(available_mini_led_mode);
> +
>  /* Quirks **************************************************************=
*******/
> =20
>  static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
> @@ -4139,6 +4206,7 @@ static struct attribute *platform_attributes[] =3D =
{
>  =09&dev_attr_nv_temp_target.attr,
>  =09&dev_attr_panel_od.attr,
>  =09&dev_attr_mini_led_mode.attr,
> +=09&dev_attr_available_mini_led_mode.attr,
>  =09NULL
>  };
> =20
> @@ -4191,7 +4259,9 @@ static umode_t asus_sysfs_is_visible(struct kobject=
 *kobj,
>  =09else if (attr =3D=3D &dev_attr_panel_od.attr)
>  =09=09ok =3D asus->panel_overdrive_available;
>  =09else if (attr =3D=3D &dev_attr_mini_led_mode.attr)
> -=09=09ok =3D asus->mini_led_mode_available;
> +=09=09ok =3D asus->mini_led_dev_id !=3D 0;
> +=09else if (attr =3D=3D &dev_attr_available_mini_led_mode.attr)
> +=09=09ok =3D asus->mini_led_dev_id !=3D 0;
> =20
>  =09if (devid !=3D -1)
>  =09=09ok =3D !(asus_wmi_get_devstate_simple(asus, devid) < 0);
> @@ -4444,10 +4514,14 @@ static int asus_wmi_add(struct platform_device *p=
dev)
>  =09asus->nv_dyn_boost_available =3D asus_wmi_dev_is_present(asus, ASUS_W=
MI_DEVID_NV_DYN_BOOST);
>  =09asus->nv_temp_tgt_available =3D asus_wmi_dev_is_present(asus, ASUS_WM=
I_DEVID_NV_THERM_TARGET);
>  =09asus->panel_overdrive_available =3D asus_wmi_dev_is_present(asus, ASU=
S_WMI_DEVID_PANEL_OD);
> -=09asus->mini_led_mode_available =3D asus_wmi_dev_is_present(asus, ASUS_=
WMI_DEVID_MINI_LED_MODE);
>  =09asus->ally_mcu_usb_switch =3D acpi_has_method(NULL, ASUS_USB0_PWR_EC0=
_CSEE)
>  =09=09=09=09=09=09&& dmi_match(DMI_BOARD_NAME, "RC71L");
> =20
> +=09if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
> +=09=09asus->mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
> +=09else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE2)=
)
> +=09=09asus->mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE2;
> +
>  =09err =3D fan_boost_mode_check_present(asus);
>  =09if (err)
>  =09=09goto fail_fan_boost_mode;
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/p=
latform_data/x86/asus-wmi.h
> index ab1c7deff118..9cadce10ad9a 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -71,6 +71,7 @@
>  #define ASUS_WMI_DEVID_LID_FLIP=09=090x00060062
>  #define ASUS_WMI_DEVID_LID_FLIP_ROG=090x00060077
>  #define ASUS_WMI_DEVID_MINI_LED_MODE=090x0005001E
> +#define ASUS_WMI_DEVID_MINI_LED_MODE2=090x0005002E
> =20
>  /* Storage */
>  #define ASUS_WMI_DEVID_CARDREADER=090x00080013
>=20
--8323328-1537023240-1712127971=:1449--

