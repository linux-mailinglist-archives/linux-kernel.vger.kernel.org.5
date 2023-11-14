Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA79A7EAE54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjKNKvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjKNKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:51:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EB1187;
        Tue, 14 Nov 2023 02:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699959073; x=1731495073;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lvdhR9cqOOSf9RGNFn4qM3c7dCfoGvtrzOLAaTvuIHQ=;
  b=YHadyKgpL5fSRpsIwVAifvAlfduD6Kz10QdMfbalit9qt0Us/IYwhSCe
   1NIJ5YQhXSv3lxpSk99iSEoZaP2cepqxIuclrufp3vLOUbtJOnBjRdm3R
   YR7JeKWgWAmMQ8IL0Xw5Ca3sgWDQ1CliKumjFMohQcmksOzUSLebCPj+N
   bH+kugP7gN9qOdzDbs9wCVg0yxlm/QDFOneIc09nU5Xi0xf8ctgoX5ITm
   0s8TDL4B8UWPAPLSe79Ub++IH+kGrRvqJcYkAr7mLVHeNLwxxHmlSKaEM
   5wA/JiWyaTT1EyDKJmjNoMIgjbR5C6MR6jGDFwvzTx6c95b5MBROXrJlm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="381029360"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="381029360"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 02:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888219908"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="888219908"
Received: from rauhjoha-mobl2.ger.corp.intel.com ([10.251.217.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 02:51:06 -0800
Date:   Tue, 14 Nov 2023 12:51:04 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Henry Shi <henryshi2018@gmail.com>
cc:     hbshi69@hotmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, Hans de Goede <hdegoede@redhat.com>,
        markgross@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
Subject: Re: [PATCH v12] platform/x86: Add Silicom Platform Driver
In-Reply-To: <20231113210216.30237-1-henryshi2018@gmail.com>
Message-ID: <fdeef06d-ab78-b2d-741d-fc3863f7edb5@linux.intel.com>
References: <20231113210216.30237-1-henryshi2018@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1550574774-1699959070=:1748"
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

--8323329-1550574774-1699959070=:1748
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 13 Nov 2023, Henry Shi wrote:

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



> +#define MEC_DATA_OFFSET(offset) ((MEC_IO_BASE) + 0x04 + offset)

Put parenthesis around offset.

> +static ssize_t uc_version_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	u32 reg;
> +	int uc_version;


> +static int __init silicom_platform_probe(struct platform_device *device)
> +{
> +	int err;
> +	u8 magic, ver;
> +	struct device *hwmon_dev;
> +	const char *name = "Silocom_Fan_Monitor";

There a typo in this string? Also, this doesn't seem to require using 
local variable, you could just put it directly into the call below.

Are you aware that most drivers use all lowercase names (this is not 
universal but seems to be mostly the case)? I guess the name that would 
best follow the usual convention is just "silicom_fan".


Also, try to use reverse xmas tree order for function variable declaration 
lines (that is, put the longest line first). Check the other functions 
yourself besides the two I quoted above.

But no need to go overboard with it if there are internal dependencies in 
the variable initalizations, you may occasionally have to "violate" the 
length based ordering, that's fine.

> +	if (!devm_request_region(&device->dev, MEC_IO_BASE, MEC_IO_LEN, "mec")) {
> +		dev_err(&device->dev, "couldn't reserve MEC io ports\n");
> +		return -EBUSY;
> +	}
> +
> +	/* Sanity check magic number read for EC */
> +	outb(IO_REG_BANK, MEC_ADDR);
> +	magic = inb(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	ver = inb(MEC_DATA_OFFSET(DEFAULT_CHAN_HI));
> +	dev_dbg(&device->dev, "EC magic 0x%02x, version 0x%02x\n", magic, ver);
> +
> +	if (magic != SILICOM_MEC_MAGIC) {
> +		dev_err(&device->dev, "Bad EC magic 0x%02x!\n", magic);
> +		return -ENODEV;
> +	}
> +
> +	err = silicom_mc_leds_register(&device->dev, silicom_led_info);
> +	if (err) {
> +		dev_err(&device->dev, "Failed to register LEDs\n");
> +		return err;
> +	}
> +
> +	err = devm_gpiochip_add_data(&device->dev, silicom_gpiochip,
> +				     silicom_gpio_channels);
> +	if (err) {
> +		dev_err(&device->dev, "Failed to register gpiochip: %d\n", err);
> +		return err;
> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&device->dev, name, NULL,
> +							 &silicom_chip_info, NULL);
> +	err = PTR_ERR_OR_ZERO(hwmon_dev);
> +	if (err) {
> +		dev_err(&device->dev, "Failed to register hwmon_dev: %d\n", err);
> +		return err;
> +	}
> +
> +	return err;
> +}

-- 
 i.

--8323329-1550574774-1699959070=:1748--
