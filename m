Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D407F1272
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjKTLup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjKTLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:50:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355E4A2;
        Mon, 20 Nov 2023 03:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700481039; x=1732017039;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=oBkACJFBAcK9OqiEf2DYrpzv/8CX0QOtfH8zNw3tMvM=;
  b=EONwfw8WSc8mNEw/7A4UMJa4YyQWcreBOqvo7xySv/uVWvGZ2BpbsTZ8
   E4uujdbQxjjtt23jd6sjbOUiFGm4ZbYYqmxjcSf6kTpLfoKD7BG3I2MSD
   LSW6S4gsw32pLABOm8wfL3q07JnrAa8trVqgb8Xr6Qa6EYB3nWvOHr3ov
   d9Cge7Ic0uZdpLY+wioZzup9IXe52/kuL1tP1D4JfwsIcX/cKaLIhRBQG
   0VSEJQUkWRG3PGUMykxMp9SWhvvRonm+bvQgtOnjGQs+CLxG1dauI0yCT
   5woordfSUaxAageQHs55HZYVUIIlYcqBUtU06vEj1qvpR9NG8hwJmh5y8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394452241"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394452241"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:50:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1097728986"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="1097728986"
Received: from akeren-mobl.ger.corp.intel.com ([10.252.40.26])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:50:31 -0800
Date:   Mon, 20 Nov 2023 13:50:29 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Henry Shi <henryshi2018@gmail.com>
cc:     hbshi69@hotmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, Hans de Goede <hdegoede@redhat.com>,
        markgross@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
Subject: Re: [PATCH v13] platform/x86: Add Silicom Platform Driver
In-Reply-To: <20231118163214.27937-1-henryshi2018@gmail.com>
Message-ID: <17e30d-4477-2fed-3ea6-e6dbad98644@linux.intel.com>
References: <20231118163214.27937-1-henryshi2018@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1990332968-1700479674=:2032"
Content-ID: <fd4e9596-11b3-ae1f-e4bb-635beb509a91@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1990332968-1700479674=:2032
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <36753e40-fb82-7e26-a0a7-78ae7daa407a@linux.intel.com>

On Sat, 18 Nov 2023, Henry Shi wrote:

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
> change from patch v7 to v8
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
> change from patch v8 to v9
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Just do the same (like MEC_VERSION_MAJOR) with all places in the where
> you previously had GENMASK() in the code (currently MEC_GET_BITS()
> is there, obviously, but it should go away and be replaced with
> FIELD_GET(GOODPREFIX_GOODNAME, ...))).
> .This is sysfs so it's odd to print pr_err() like that here. If the driver
> does not support those versions at all, the probe should fail. If driver is
> fine but just doesn't know how to interpret such a version, you should
> return -Esomething here. Driver returns -EINVAL here.
> .Replace CENTI with 100
> .Align FIELD_GET()s to the same column for line 661.
> .Change variables efuse_status, mec_uc_version, power_cycle to unsigned
> int from int.
> 
> changes suggested by Hans de Goede <hdegoede@redhat.com>:
> .Please add a Documentation/ABI/testing/sysfs-platform-silicom
> file to document driver specific the sysfs attributes of this driver.
> .Like with the Kconfig part, group this together with the other industrial
> PC drivers we have at the end of the Makefile after Siemens
> Simatic Industrial PCs.
> 
> change from patch v9 to v10
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Added missing newline in kernel document file.
> .Changed the order #define to make sure they are in increasing order.
> .Removed printing in init function silicom_platform_info_init();
> .Changed #define name MEC_PREFIX_HIGH_BYTES to MEC_TEMPERATURE.
> .Removed dev_err(dev, "Failed to register[%d]: %d\n", i, err)
> in function silicom_mc_leds_register() before ruturn err.
> .Changed %du to %u in function power_cycle_store(...).
> .Chnaged sprintf() to sysfs_emit().
> .Changed start point for multi-line comments.
> .Added empty line to seperate #define.
> .Remove parenthesis around MEC_IO_BASE.
> .Changed #define EC_ADDR_MSB (MEC_IO_BASE + 0x3), use
> a constant value instead of MEC_DATA_OFFSET_MASK.
> .Changed define name MEC_PREFIX_NAME to MEC_PORT_LOC.
> .Changed define MEC_PREFIX_HIGH_BYTES to MEC_TEMP_LOC.
> .Removed "PREFIX" from define name, changed
> MEC_PREFIX_SEC_BYTE to MEC_VERSION_LOC.
> 
> change from patch v10 to v11
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Don't print anything when userspace gives an invalid value,
> just return -EINVAL in function power_cycle_store().
> .The includes should be in alphabethical order.
> .Just make the calculation once and store into a local variable
> in function silicom_mec_port_set().
> .Use GENMASK for MEC_PORT_OFFSET_MASK, MEC_PORT_CHANNEL_MASK,
> MEC_DATA_OFFSET_MASK.
> .Rename MEC_PORT_LOC to MEC_PORT_DWORD_OFFSET.
> .Add local variable to function silicom_mec_port_set() and
> silicom_mec_port_get() to make the code less heavy to read.
> .Allgned defines start from same column mostly.
> .Kernel test robot WARNING sys/devices/platform/silicom-platform/hwmon/hwmon1/
> is defined 4 times.
> 
> change from patch v11 to v12
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> Several editorial things:
> .Put the subdir headers separately.
> .Add more new line in define section.
> .Use () around all macro arguments to be on the safe side.
> .Add new line and remove comment in function silicom_mec_port_get().
> .Add new line and remove comment in function silicom_mec_port_set().
> .Remove unnecessary comment in function temp_get(), rpm_get().
> 
> change from patch v12 to v13 (current)
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Put parenthesis in #define MEC_DATA_OFFSET(offset).
> .Remove unnecessary local variable *name and correct typo.
> .Use lower case for driver name.
> .Use reverse xmas tree order for function variables.
> 
> Changes suggested by Randy Dunlap <rdunlap@infradead.org>:
> .Added "depends on GPIOLIB" in Kconfig.
> .Added default value for power_cycle file.
> .Added scale of temperature returned by temp1_input.
> .Correct editorlal issue in sysfs-platform-silicom.
> .Removed extra parenthesis around MEC_IO_BASE.
> .More indentation in silicom_mec_led_mc_brightness_set().
> 
> .Kernel test robot WARNING: unmet direct dependencies detected for
> LEDS_CLASS_MULTICOLOR.

> +What:          /sys/devices/platform/silicom-platform/power_cycle
> +Date:          November 2023
> +KernelVersion: 6.7
> +Contact:       Henry Shi <henrys@silicom-usa.com>
> +               This file allow user to power cycle the platform.
> +               default value is 0; when set to 1, it powers down

Thanks for the update.

You missed Randy's comments here. So please capitalize the first letter in 
the sentence.

> +               the platform, wait 5 seconds, then power on the

wait -> waits
power -> powers

> +               device. It returns to default value after power cycle.

to default value -> to 0

What actually sets power_cycle variable back to 0? I couldn't find such 
code.

Also, writing 1 and then 0 to sysfs power_cycle causes reads to return 
garbage unrelated to the whether there's power cycling currently going on 
or not.

I think you should first parse the string to local variable in 
power_cycle_store(), after checking it's okay take the mutex, and only 
then update power_cycle variable.

> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..676d89d96646 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1076,6 +1076,23 @@ config INTEL_SCU_IPC_UTIL
>  
>  source "drivers/platform/x86/siemens/Kconfig"
>  
> +config SILICOM_PLATFORM
> +	tristate "Silicom Edge Networking device support"
> +	depends on HWMON
> +	depends on GPIOLIB
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	select LEDS_CLASS_MULTICOLOR

I think this should be just
	depends on LEDS_CLASS_MULTICOLOR
...like the other uses of it.

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

> +#define EC_ADDR_MSB           ((MEC_IO_BASE) + 0x3)

You forgot to remove the parenthesis from here.


> +static int __init silicom_platform_init(void)
> +{
> +	if (!dmi_check_system(silicom_dmi_ids)) {
> +		pr_err("No DMI match for this platform\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Create and register a platform device.
> +	 * Directly probe the platform driver in init since this isn't a
> +	 * hotpluggable device.  That means we don't need to register a driver
> +	 * that needs to wait around in memory on the chance a matching device
> +	 * would get added.  Instead run once in __init so that we can free all
> +	 * those resources when the __init region is wiped
> +	 */

I'm skeptical this comment has any useful content. IMO, it could be 
dropped.

> +	silicom_platform_dev = platform_create_bundle(&silicom_platform_driver,
> +						      silicom_platform_probe,
> +						      NULL, 0, NULL, 0);
> +
> +	return PTR_ERR_OR_ZERO(silicom_platform_dev);
> +}


-- 
 i.
--8323329-1990332968-1700479674=:2032--
