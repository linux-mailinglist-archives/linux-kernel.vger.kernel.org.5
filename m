Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815597E420B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjKGOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:47:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64FA11B;
        Tue,  7 Nov 2023 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699368453; x=1730904453;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=sT5tAxf6CBPW1atcuunDNs1cdrZElj1Vg7o3NAek2FY=;
  b=i2eweWes6W3JCVNXz6/KPUWIFpo5GcNaVtbTikO0IErKiPei4nIbiBST
   NZNkhkNdmPZY4qQABbQErHLFDjaLAldE96/JeRUKLA6B9BwG55ZyXKJIn
   GaWmGYUiW3HZ3+aApRVmyZVO0k96qj2CK7WqDqNEH+gtDcx6aEp/K08Wn
   i4GBkN4X3bLqBQt/8PeJV0aMOmIeQBT2BQFgSUjxriJSZNHA2OmO7FUDP
   e0wnT9jaMPxKz76NRGYLSJqWQs3ViFw/0/0PNZh7jmob7fnpy+ItzitnU
   THM6Gvi05welWv66dEkIOW9nPlEQL1S7x7PPDIBKkPX0JvQYckCKd2CED
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456005944"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="456005944"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:47:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="4013432"
Received: from pathanas-mobl1.ger.corp.intel.com ([10.252.37.194])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:47:05 -0800
Date:   Tue, 7 Nov 2023 16:47:02 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Henry Shi <henryshi2018@gmail.com>
cc:     hbshi69@hotmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, Hans de Goede <hdegoede@redhat.com>,
        markgross@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
Subject: Re: [PATCH v11] platform/x86: Add Silicom Platform Driver
In-Reply-To: <20231106220709.25229-1-henryshi2018@gmail.com>
Message-ID: <ed1aeecf-ecc4-ad39-5af-f8a24ffba459@linux.intel.com>
References: <20231106220709.25229-1-henryshi2018@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1084432088-1699368138=:1851"
Content-ID: <7a4c418b-d6a5-57c3-bf46-92aba40e464@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1084432088-1699368138=:1851
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <4fdc79e-d8ab-f7e3-2f31-bbb9b7f1f31@linux.intel.com>

On Mon, 6 Nov 2023, Henry Shi wrote:

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
> change from patch v10 to v11 (current patch)
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

Thanks, seems almost there now, a few editorial things below.


> +#include <linux/dmi.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/hwmon.h>

The usual convention is to put the subdir headers separately:

#include <linux/dmi.h>
#include <linux/hwmon.h>
[... more include files under linux/ ...]
#include <linux/units.h>

#include <linux/gpio/driver.h>

> +#define MEC_POWER_CYCLE_ADDR 0x24
> +#define MEC_EFUSE_LSB_ADDR   0x28
> +#define MEC_GPIO_IN_POS      0x08
> +#define MEC_IO_BASE          0x0800
> +#define MEC_IO_LEN           0x8
> +#define IO_REG_BANK          0x0
> +#define DEFAULT_CHAN_LO      0
> +#define DEFAULT_CHAN_HI      0
> +#define DEFAULT_CHAN_LO_T    0xc
> +#define MEC_ADDR             (MEC_IO_BASE + 0x02)
> +#define EC_ADDR_LSB          MEC_ADDR
> +#define SILICOM_MEC_MAGIC    0x5a
> +
> +#define MEC_PORT_CHANNEL_MASK GENMASK(2, 0)
> +#define MEC_PORT_DWORD_OFFSET GENMASK(31, 3)
> +#define MEC_DATA_OFFSET_MASK  GENMASK(1, 0)
> +#define MEC_PORT_OFFSET_MASK  GENMASK(7, 2)

Newline here

> +#define MEC_TEMP_LOC          GENMASK(31, 16)
> +#define MEC_VERSION_LOC       GENMASK(15, 8)
> +#define MEC_VERSION_MAJOR     GENMASK(15, 14)
> +#define MEC_VERSION_MINOR     GENMASK(13, 8)

Newline here

> +#define EC_ADDR_MSB           (MEC_IO_BASE + 0x3)
> +#define MEC_DATA_OFFSET(offset) (MEC_IO_BASE + 0x04 + offset)

Newline here

> +#define OFFSET_BIT_TO_CHANNEL(off, bit) (((off + 0x014) << 3) | bit)
> +#define CHANNEL_TO_OFFSET(chan) ((chan >> 3) - 0x14)

Please use () around all macro arguments to be on the safe side, so
the last one becomes:

#define CHANNEL_TO_OFFSET(chan) (((chan) >> 3) - 0x14)

(Please do this for all your macros, if I counted correctly, there are 3 
of such macros with unprotected arguments currently).

> +static int silicom_mec_port_get(unsigned int offset)
> +{
> +	u8 reg;
> +	unsigned short mec_data_addr;
> +	unsigned short mec_port_addr;
> +
> +	mec_data_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, offset) & MEC_DATA_OFFSET_MASK;
> +	mec_port_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, offset) & MEC_PORT_OFFSET_MASK;

Newline here since you're starting a critical section.

> +	mutex_lock(&mec_io_mutex);
> +	/* Get the dword offset from the channel */

This comment is out of place, perhaps it isn't really needed at all.

> +	outb(mec_port_addr, MEC_ADDR);
> +	/* Get the current register */

This comment too is pretty obvious from the code so it should be dropped.

> +	reg = inb(MEC_DATA_OFFSET(mec_data_addr));
> +	mutex_unlock(&mec_io_mutex);
> +
> +	return (reg >> (offset & MEC_PORT_CHANNEL_MASK)) & 0x01;

FIELD_GET(MEC_PORT_CHANNEL_MASK, offset)

This function is much easier to read now!

> +}
> +
> +static enum led_brightness silicom_mec_led_get(int channel)
> +{
> +	/* Outputs are active low */
> +	return silicom_mec_port_get(channel) ? LED_OFF : LED_ON;
> +}
> +
> +static void silicom_mec_port_set(int channel, int on)
> +{
> +	u8 reg;
> +	unsigned short mec_data_addr;
> +	unsigned short mec_port_addr;
> +
> +	mec_data_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, channel) & MEC_DATA_OFFSET_MASK;
> +	mec_port_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, channel) & MEC_PORT_OFFSET_MASK;

Newline due to start of critical section.

> +	mutex_lock(&mec_io_mutex);
> +	/* Get the dword offset from the channel */

Same comment related feedback applies to here too.

> +	outb(mec_port_addr, MEC_ADDR);
> +	/* Get the current port settings */
> +	reg = inb(MEC_DATA_OFFSET(mec_data_addr));
> +	/* Outputs are active low, so clear the bit for on, or set it for off */

This is useful comment and should not be dropped.

> +	if (on)
> +		reg &= ~(1 << (channel & MEC_PORT_CHANNEL_MASK));
> +	else
> +		reg |= 1 << (channel & MEC_PORT_CHANNEL_MASK);
> +	/* Write back the updated register */

Extremely obvious thing, just drop this comment.

> +	outb(reg, MEC_DATA_OFFSET(mec_data_addr));
> +	mutex_unlock(&mec_io_mutex);
> +}


> +static u32 rpm_get(void)
> +{
> +	u32 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Select memory region */
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(DEFAULT_CHAN_LO_T, EC_ADDR_LSB);
> +	/* Get current data from the address */

This is again a comment which is not very useful and should just dropped
(check if you have similar ones, I won't mark more of them in this reply).

> +	reg = inw(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +
> +	return reg;
> +}


-- 
 i.
--8323329-1084432088-1699368138=:1851--
