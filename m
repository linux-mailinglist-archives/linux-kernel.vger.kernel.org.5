Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D017B7A39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbjJDIil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241728AbjJDIic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:38:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ED1A6;
        Wed,  4 Oct 2023 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696408708; x=1727944708;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=6y8E0EB2MzU49lwggNFxS1Hy1bmkDF+fHmaKjefXs7Q=;
  b=AK7mYfODU4AKZl8H3h1AatKsKbOLuP8ZQobZBOistBlkhDKaqsN9axrs
   zNID1aBXaayhiZn6g2uHa0Zw0xfLqj1JwAVsvl8MFMjmaV5ODFhBK4ei4
   Ue70LRnSAvnQonb97HWJuG8oW1sZCjdWQFx/bub9dhLHTIi6PpepuU7z0
   h7vEt8rsP2/3RWUa3QehtPjCo7/XU0fWm1EKGIVYnmkKbcEebG0HdQMep
   BdBXlWKrWVhkLYcwK26SeeJzQvpwo/cw0w+mQXzkTDWjnd3soLeJcT5RQ
   L/xQ6fHjXvDET4OsezE6vK1HspRr63MsZFLLAFY0Cks27SHL2z2hi/FTm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="383006481"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="383006481"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 01:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="727926319"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="727926319"
Received: from cyrillet-mobl.ger.corp.intel.com ([10.252.55.203])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 01:38:22 -0700
Date:   Wed, 4 Oct 2023 11:38:20 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Henry Shi <henryshi2018@gmail.com>
cc:     hbshi69@hotmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, hdegoede@redhat.com, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, hb_shi2003@yahoo.com,
        henrys@silicom-usa.com, wenw@silicom-usa.com
Subject: Re: [PATCH] platform/x86: Add Silicom Platform Driver
In-Reply-To: <20231003205439.8251-1-henryshi2018@gmail.com>
Message-ID: <cb786c2d-34bb-d025-6815-4d33457b8ecc@linux.intel.com>
References: <20231003205439.8251-1-henryshi2018@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1259179420-1696407533=:1931"
Content-ID: <d11d2e27-11fa-9f7d-27d4-39f8f9a1d46@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1259179420-1696407533=:1931
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <d452c263-1e3c-e3f9-d999-ad9bc4bba995@linux.intel.com>

On Tue, 3 Oct 2023, Henry Shi wrote:

> platform/x86: Add Silicom Platform Driver
> 
> Add Silicom platform (silicom-platform) Linux driver for Swisscom
> Business Box (Swisscom BB) as well as Cordoba family products.
> 
> This platform driver provides support for various functions via
> the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
> and device attributes.
> 
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> ---
> 
> Changes from v1 to v2:
> ===========================
> 
> Suggested by Hans de Goede <hdegoede@redhat.com>
> .Use git send-email to submit patch.
> .patch contents should be in message body.
> .Kconfig bit for the driver should be in drivers/platform/x86/Kconfig.
> 
> changes from patch v2 to v3
> ===========================
> 
> changes suggested by Guenter Roeck <groeck7@gmail.com>
> .Removed unnecessary include file linux/thermal.h.
> .Removed EXPORT_SYMBOL for mutex lock/unlock function.
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> .Remove extra new line in code on multiple position.
> .Use table instead of space in code.
> .Uss Linux defined bit operation MACRO define.
> .Removed local variable in rpm_get().
> .Corrected typo in comments.
> .Corrected incorrect indentation.
> .Removed unnecessary comments in silicom_mc_leds_register().
> .Rewrite efuse_status_show() to used defined variable and removed 
> uncessary local variables.
> .Rewrite uc_version_show() to used defined variable and removed 
> uncessary local variables.
> .Removed unused MACRO define: #define CHANNEL_TO_BIT(chan) ((chan) & 0x07).
> .Rewrite powercycle_uc() to used defined variable and removed uncessary 
> local variables.
> .use GENMASK() and use FIELD_GET() instead of bit shift.
> .Added define for constant 0x28 used in  efuse_status_show().
> .Added define for constant 0x0 used in  uc_version_show().
> .Added define for constant 0x0 used in  powercycle_uc().
> .Rearrange functions to avoid uncessary pre-define.
> .Rewrite rpm_get() to used defined variable and removed uncessary 
> local variables.
> .Rewrite temp_get() to used defined variable and removed uncessary 
> local variables.
> .Use FIELD_GET instead of bit shift in temp_get().
> .Used #define for constant variable 0/1.
> 
> Changes suggested by Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> .use "if (!led->subled_info)" instead of
> "if (IS_ERR_OR_NULL(led->subled_info))
> "in silicom_mc_leds_register
> 
> changes from patch v3 to v4
> ===========================
> 
> changes suggested by Guenter Roeck <groeck7@gmail.com>
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Rewrite silicom_mec_led/gpip_set/get() functions to use two newly created
> silicom_mec_port_get()/silicom_mec_port_set() which have common code.
> .Remove duplicate code in silicom_mec_port_get()
> .Rewrite uc_version_show() to use Linux bit operation MACRO, and add
> logic to check un-supported register value.
> .Added "#define MEC_EFUSE_LSB_ADDR 0x28" and "#define
> MEC_POWER_CYCLE_ADDR 0x24"
> .Added "#define MEC_VERSION_MAJOR GENMASK(15, 14)" and "#define
> MEC_VERSION_MINOR GENMASK(13, 8)".
> 
> Changes suggested by Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> .Used a local variable to store "sizeof(struct mc_subled)" in function
> silicom_mc_leds_register().
> 
> change from patch v4 to v5
> ===========================================
> 
> changes suggested by Guenter Roeck <groeck7@gmail.com>:
> .Corrected return value in temp_get() to return 1/10000th degree.
> .Removed local variable struct silicom_fan_control_data *ctl in
> silicom_fan_control_read_fan(),
> removed storing rpm value to ctl variable.
> .Removed local variable struct silicom_fan_control_data *ctl in 
> silicom_fan_control_read_temp(),
> .removed storing rpm value to ctl variable.
> .Changed return string in silicom_fan_control_read_labels() to 
> specific string for Silicom platform driver.
> .Removed silicom_fan_control_data structure.
> .Removed static variable mec_io_base and mec_io_len, and added
> "#define MEC_IO_BASE 0x0800 and #define MEC_IO_LEN 0x8".
> .Removed ".write = NULL" in silicom_fan_control_hwmon_ops
> structure defination.
> .Removed unnecessary function silicom_fan_control_write().
> .Removed unnecessary check for silicom_led_info in function
> silicom_platform_probe.
> .Removed unnecessary local variable "silicom_fan_control_data *ctl"
> in silicom_platform_probe().
> .Clean out driver initialization error handling in
> silicom_platform_init();
> .Add patch version and changelog for patch submission.
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Rename "#define MEC_DATA(offset) to "#define MEC_DATA_OFFSET(offset).
> .Use constant defined in include/linux/units.h instead of a literal.
> .return directly instead of go to err condition when
> platform_device_register_simple() failed.
> .Remove unnecessary check for silicom_led_info and silicom_gpiochip.
> .Use a local variable to how multiple use of array size.
> .Align the arguments to the same column in
> silicom_mec_led_mc_brightness_set.
> .Add patch version and changelog that shows version to version changes
> for patch submission.
> 
> Changes suggested by Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> .Use "sizeof(*led)" instead of "sizeof(struct led_classdev_mc)"
> .Use "if (!led)" instead of "if (IS_ERR_OR_NULL(led))" 
> .Removed unnecessary error message:
> "dev_err(dev, "Failed to alloc led_classdev_mc[%d]:
> %ld\n", i, PTR_ERR(led)).
> 
> change from patch vv5 to v6
> ===========================================
> 
> changes suggested by Guenter Roeck <groeck7@gmail.com>:
> .Removed checkpath warnings. 
> .Resoved dependencies between CONFIG_HWMON and CONFIG_SILICOM_PLATFORM.
> 
> change from patch v6 to v7
> ===========================================
> 
> changes suggested by Hans de Goede <hdegoede@redhat.com>:
> .Usa a proper subsystem prefix for this patch subject:
> Subject: platform/x86: Add Silicom Platform Driver.
> 
> change from patch v7 to v8 (current patch)
> ===========================================
> 
> changes suggested by Hans de Goede <hdegoede@redhat.com>:
> .Chnage commit message of this driver.
> .Adjust location of change log and signed-off-by.
> .Change "config SILICOM_PLATFORM" and help contents location,
> and put it to source "drivers/platform/x86/siemens/Kconfig".
> .Set editor tab to 8 and align the start of extra function
> parameters to directly after (. This should be applied for
> all function.
> .Do not manually create a sysfs dir and register sysfs attribute,
> instead define a platform_driver structure.
> .Move MODULE_DEVICE_TABLE(dmi, silicom_dmi_ids) directly after
> table declaration.
> .Using pr_info() instead of dev_info() in function
> silicom_platform_info_init().
> .Made dmi_check_system() check the first thing to do in
> silicom_platform_init().
> .Instead of separate platform_device creation + driver registration,
> switched to using platform_create_bundle().
> .Removed mutex_destroy(&mec_io_mutex).
> 
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Too many GENMASK() within to code itself, need put them to
> #define. Removed all GENMASK() in c functions.
>
>  drivers/platform/x86/Kconfig            |   14 +
>  drivers/platform/x86/Makefile           |    1 +
>  drivers/platform/x86/silicom-platform.c | 1001 +++++++++++++++++++++++
>  3 files changed, 1016 insertions(+)
>  create mode 100644 drivers/platform/x86/silicom-platform.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..f38fbd97f33d 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1076,6 +1076,20 @@ config INTEL_SCU_IPC_UTIL
>  
>  source "drivers/platform/x86/siemens/Kconfig"
>  
> +config SILICOM_PLATFORM
> +	tristate "Silicom Edge Networking device support"
> +	depends on HWMON
> +	select LEDS_CLASS_MULTICOLOR
> +	help
> +	  This option enables support for the LEDs/GPIO/etc downstream of the
> +	  embedded controller on Silicom "Cordoba" hardware and derivatives.
> +
> +	  This platform driver provides support for various functions via
> +	  the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
> +	  and device attributes.
> +
> +	  If you have a Silicom network appliance, say Y or M here.
> +
>  config WINMATE_FM07_KEYS
>  	tristate "Winmate FM07/FM07P front-panel keys driver"
>  	depends on INPUT
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index b457de5abf7d..07efff8b24f7 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_SERIAL_MULTI_INSTANTIATE)	+= serial-multi-instantiate.o
>  obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
>  obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
>  obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
> +obj-$(CONFIG_SILICOM_PLATFORM)		+= silicom-platform.o
>  obj-$(CONFIG_X86_ANDROID_TABLETS)	+= x86-android-tablets/
>  
>  # Intel uncore drivers
> diff --git a/drivers/platform/x86/silicom-platform.c b/drivers/platform/x86/silicom-platform.c
> new file mode 100644
> index 000000000000..8786d09476f2
> --- /dev/null
> +++ b/drivers/platform/x86/silicom-platform.c
> @@ -0,0 +1,1001 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// silicom-platform.c - Silicom MEC170x platform driver
> +//
> +// Copyright (C) 2023 Henry Shi <henrys@silicom-usa.com>
> +#include <linux/dmi.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/module.h>
> +#include <linux/hwmon.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/units.h>
> +
> +#define MEC_EFUSE_LSB_ADDR 0x28
> +#define MEC_POWER_CYCLE_ADDR 0x24
> +#define MEC_PORT_OFFSET_MASK 0xfc
> +#define MEC_PORT_CHANNEL_MASK 0x7
> +#define MEC_DATA_OFFSET_MASK 0x03
> +#define MEC_GPIO_IN_POS 0x08
> +#define MEC_IO_BASE 0x0800
> +#define MEC_IO_LEN 0x8
> +#define MEC_ADDR ((MEC_IO_BASE) + 0x02)
> +#define MEC_DATA_OFFSET(offset) ((MEC_IO_BASE) + 0x04 + (offset))
> +#define EC_ADDR_LSB MEC_ADDR
> +#define EC_ADDR_MSB ((MEC_IO_BASE) + MEC_DATA_OFFSET_MASK)
> +#define SILICOM_MEC_MAGIC 0x5a
> +#define OFFSET_BIT_TO_CHANNEL(off, bit) ((((off) + 0x014) << 3) | (bit))
> +#define CHANNEL_TO_OFFSET(chan) (((chan) >> 3) - 0x14)
> +#define MEC_VERSION_MAJOR GENMASK(15, 14)
> +#define MEC_VERSION_MINOR GENMASK(13, 8)
> +#define MEC_GET_BITS(high, low, arg) FIELD_GET(GENMASK(high, low), arg)
> +#define IO_REG_BANK 0x0
> +#define DEFAULT_CHAN_LO 0
> +#define DEFAULT_CHAN_HI 0
> +#define DEFAULT_CHAN_LO_T 0xc
> +
> +static DEFINE_MUTEX(mec_io_mutex);
> +static int efuse_status;
> +static int mec_uc_version;
> +static int power_cycle;
> +
> +static const struct hwmon_channel_info *silicom_fan_control_info[] = {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};

> +static void silicom_mec_port_set(int channel, int on)
> +{
> +	u8 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Get the dword offset from the channel */
> +	outb(MEC_GET_BITS(31, 3, channel) & MEC_PORT_OFFSET_MASK, MEC_ADDR);
> +
> +	/* Get the current port settings */
> +	reg = inb(MEC_DATA_OFFSET(MEC_GET_BITS(31, 3, channel) & MEC_DATA_OFFSET_MASK));

Unfortunately this is not how should be done. This ended up just replaced 
one generic name in the code with another.

What I'm after the name shown in the code should tell what the field is
(GOODPREFIX_GOODNAME where the intent becomes obvious because the name
describes what field is extracted).

You should do this in the define blocks:
#define GOODPREFIX_GOODNAME	GENMASK(literalhigh, literallow)

Then here in the code, you do:
	reg = inb(MEC_DATA_OFFSET(FIELD_GET(GOODPREFIX_GOODNAME, channel)));

You have done what is expected with e.g. MEC_VERSION_MAJOR, just do the 
same with all places in the where you previously had GENMASK() in the 
code (currently MEC_GET_BITS() is there, obviously, but it should go 
away and be replaced with FIELD_GET(GOODPREFIX_GOODNAME, ...))).

> +static ssize_t uc_version_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	u32 reg;
> +	int uc_version;
> +
> +	mutex_lock(&mec_io_mutex);
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(DEFAULT_CHAN_LO, EC_ADDR_LSB);
> +
> +	reg = inl(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +	uc_version = MEC_GET_BITS(15, 8, reg);
> +	if (uc_version >= 192)
> +		pr_err("uc version not supported\n");

This is sysfs so it's odd to print pr_err() like that here. If the driver 
does not support those versions at all, the probe should fail. If driver 
is fine but just doesn't know how to interpret such a version, you should 
return -Esomething here.

> +
> +	uc_version = FIELD_GET(MEC_VERSION_MAJOR, reg) * CENTI +

I'd just use 100 literal here as it's not really normal to do SI like 
prefixes with versions but it's up to you what you want to do here.

> +			       FIELD_GET(MEC_VERSION_MINOR, reg);

Align FIELD_GET()s to the same column.

In anycase, the calculation code itself looks better now!

> +
> +	mec_uc_version = uc_version;
> +	return sprintf(buf, "%d\n", mec_uc_version);

You could make mac_uc_version unsigned btw and use %u here.


And please keep the version the subject too so that I don't lose track of 
which version you're posting.

-- 
 i.
--8323329-1259179420-1696407533=:1931--
