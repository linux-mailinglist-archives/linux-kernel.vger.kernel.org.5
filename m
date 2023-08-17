Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7077F1CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348733AbjHQIHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348748AbjHQIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:07:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12CF2D76;
        Thu, 17 Aug 2023 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692259623; x=1723795623;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zqH/R479KNyQikBtfg36CdkBuRoeOnIW0XVP0VXeiLk=;
  b=CgPmDgFYvs8xzSR4dZ70sJUM9Api6Xv5B5yZO0OIJyAnb/ccEDdvYQU3
   cMN1S8K0U/w0/rhRDY/sML4XhPrndgijDEe5EaVC+BSikS91DrFhJ5VoO
   D9JtnhfIUX8m8LokM2G0NKDKIyK7eansNCuyXwTItanv69MOGguMDFiuK
   mGJE0/0KgGFBXV8fpG0YgRG3V6hWBSWaQwI+tKUGtHUSsziX1ohNhq4ff
   c5rGd/igS6UKyyPAnBrJUZciL+FojDNGUF8TRNakkebCuam+H0/Z77PpQ
   SDERloSuWubAlLCEIWparz8Zjckxzdmc45jkylKvJQHdhgUkjvBIxjEHV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357710317"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="357710317"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:07:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804543869"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="804543869"
Received: from lababeix-mobl1.ger.corp.intel.com ([10.251.212.52])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:06:58 -0700
Date:   Thu, 17 Aug 2023 11:06:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Henry Shi <henryshi2018@gmail.com>
cc:     hbshi69@hotmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, hdegoede@redhat.com, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
Subject: Re: [PATCH] Add Silicom Platform Driver
In-Reply-To: <20230815133759.7690-1-henryshi2018@gmail.com>
Message-ID: <e376de55-5962-875-2c51-928a4fdfcea@linux.intel.com>
References: <20230815133759.7690-1-henryshi2018@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023, Henry Shi wrote:

> The Silicom platform (silicom-platform) Linux driver for Swisscom
> Business Box (Swisscom BB) as well as Cordoba family products is a 
> software solution designed to facilitate the efficient management
> and control of devices through the integration of various Linux
> frameworks. This platform driver provides seamless support for
> device management via the Linux LED framework, GPIO framework,
> Hardware Monitoring (HWMON), and device attributes. The Silicom
> platform driver's compatibility with these Linux frameworks allows
> applications to access and control Cordoba family devices using
> existing software that is compatible with these frameworks. This
> compatibility simplifies the development process, reduces
> dependencies on proprietary solutions, and promotes
> interoperability with other Linux-based systems and software.
> 
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> ---

You should use version the submission (vXX should appear already in the 
subject) and provide the version history in a list (listing version to 
version changes).

>  drivers/platform/x86/Kconfig            |   11 +
>  drivers/platform/x86/Makefile           |    1 +
>  drivers/platform/x86/silicom-platform.c | 1053 +++++++++++++++++++++++
>  3 files changed, 1065 insertions(+)
>  create mode 100644 drivers/platform/x86/silicom-platform.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 22052031c719..7680c0dbcd8d 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -188,6 +188,17 @@ config ACER_WMI
>  	  If you have an ACPI-WMI compatible Acer/ Wistron laptop, say Y or M
>  	  here.
>  
> +config SILICOM_PLATFORM
> +	tristate "Silicom Edge Networking device support"
> +	depends on DMI
> +	select LEDS_CLASS_MULTICOLOR
> +	select GPIOLIB
> +	help
> +	  This option enables support for the LEDs/GPIO/etc downstream of the
> +	  embedded controller on Silicom "Cordoba" hardware and derivatives.
> +
> +	  If you have a Silicom network appliance, say Y or M here.
> +
>  source "drivers/platform/x86/amd/Kconfig"
>  
>  config ADV_SWBUTTON
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 2cafe51ec4d8..9355ebbc56ca 100644
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
> index 000000000000..f8d1eb68b105
> --- /dev/null
> +++ b/drivers/platform/x86/silicom-platform.c
> @@ -0,0 +1,1053 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// silicom-platform.c - Silicom MEC170x platform driver
> +//
> +// Copyright (C) 2023 Henry Shi <henrys@silicom-usa.com>
> +
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
> +
> +#define MEC_ADDR ((mec_io_base) + 0x02)
> +#define MEC_DATA(offset) ((mec_io_base) + 0x04 + (offset))
> +#define EC_ADDR_LSB MEC_ADDR
> +#define EC_ADDR_MSB ((mec_io_base) + 0x03)
> +#define SILICOM_MEC_MAGIC 0x5a
> +#define OFFSET_BIT_TO_CHANNEL(off, bit) ((((off) + 0x014) << 3) | (bit))
> +#define CHANNEL_TO_OFFSET(chan) (((chan) >> 3) - 0x14)
> +#define IO_REG_BANK 0
> +#define DEFAULT_CHAN_LO 0
> +#define DEFAULT_CHAN_HI 0
> +
> +static DEFINE_MUTEX(mec_io_mutex);
> +static int mec_io_base, mec_io_len;
> +static struct device *my_dev;
> +static int efuse_status;
> +static int mec_uc_version;
> +static int power_cycle;
> +
> +struct silicom_fan_control_data {
> +	struct   device *hdev;
> +	int      temp;
> +	int      fan_speed;
> +};
> +
> +static const struct hwmon_channel_info *silicom_fan_control_info[] = {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +struct silicom_platform_info {
> +	int io_base;
> +	int io_len;
> +	struct led_classdev_mc *led_info;
> +	struct gpio_chip *gpiochip;
> +	u8 *gpio_channels;
> +	u16 ngpio;
> +};
> +
> +static const char * const plat_0222_gpio_names[] = {
> +	"AUTOM0_SFP_TX_FAULT",
> +	"SLOT2_LED_OUT",
> +	"SIM_M2_SLOT2_B_DET",
> +	"SIM_M2_SLOT2_A_DET",
> +	"SLOT1_LED_OUT",
> +	"SIM_M2_SLOT1_B_DET",
> +	"SIM_M2_SLOT1_A_DET",
> +	"SLOT0_LED_OUT",
> +	"WAN_SFP0_RX_LOS",
> +	"WAN_SFP0_PRSNT_N",
> +	"WAN_SFP0_TX_FAULT",
> +	"AUTOM1_SFP_RX_LOS",
> +	"AUTOM1_SFP_PRSNT_N",
> +	"AUTOM1_SFP_TX_FAULT",
> +	"AUTOM0_SFP_RX_LOS",
> +	"AUTOM0_SFP_PRSNT_N",
> +	"WAN_SFP1_RX_LOS",
> +	"WAN_SFP1_PRSNT_N",
> +	"WAN_SFP1_TX_FAULT",
> +	"SIM_M2_SLOT1_MUX_SEL",
> +	"W_DISABLE_M2_SLOT1_N",
> +	"W_DISABLE_MPCIE_SLOT0_N",
> +	"W_DISABLE_M2_SLOT0_N",
> +	"BT_COMMAND_MODE",
> +	"WAN_SFP1_TX_DISABLE",
> +	"WAN_SFP0_TX_DISABLE",
> +	"AUTOM1_SFP_TX_DISABLE",
> +	"AUTOM0_SFP_TX_DISABLE",
> +	"SIM_M2_SLOT2_MUX_SEL",
> +	"W_DISABLE_M2_SLOT2_N",
> +	"RST_CTL_M2_SLOT_1_N",
> +	"RST_CTL_M2_SLOT_2_N",
> +	"PM_USB_PWR_EN_BOT",
> +	"PM_USB_PWR_EN_TOP",
> +};
> +
> +static u8 plat_0222_gpio_channels[] = {
> +	OFFSET_BIT_TO_CHANNEL(0x00, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 3),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 4),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 5),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 6),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 7),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 3),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 4),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 5),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 6),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 7),
> +	OFFSET_BIT_TO_CHANNEL(0x02, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x02, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x02, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x09, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x09, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x09, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x09, 3),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 3),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 4),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 5),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 6),
> +	OFFSET_BIT_TO_CHANNEL(0x0b, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x0b, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x0b, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x0b, 3),
> +};
> +
> +static struct platform_device *silicom_platform_dev;
> +static struct led_classdev_mc *silicom_led_info __initdata;
> +static struct gpio_chip *silicom_gpiochip __initdata;
> +static u8 *silicom_gpio_channels __initdata;
> +
> +static int silicom_mec_port_get(unsigned int offset)
> +{
> +	u8 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Get the dword offset from the channel */
> +	outb((offset >> 3) & 0xfc, MEC_ADDR);
> +
> +	/* Get the current register */
> +	reg = inb(MEC_DATA((offset >> 3) & 0x03));
> +	mutex_unlock(&mec_io_mutex);
> +
> +	return (reg >> (offset & 0x7)) & 0x01;
> +}
> +
> +static enum led_brightness silicom_mec_led_get(int channel)
> +{
> +	u8 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Get the dword offset of the register for this LED from the channel */
> +	outb((channel >> 3) & 0xfc, MEC_ADDR);
> +	/* Get the current LED settings */
> +	reg = inb(MEC_DATA((channel >> 3) & 0x03));
> +	mutex_unlock(&mec_io_mutex);
> +
> +	/* Outputs are active low */
> +	return silicom_mec_port_get(channel) ? LED_OFF : LED_ON;

Why is code now done twice, first in this function and then it calls 
silicom_mec_port_get() which does the same thing?? Perhaps you forgot to 
remove it from this function while you added the call.

> +}
> +
> +static void silicom_mec_port_set(int channel, int on)
> +{
> +	u8 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Get the dword offset from the channel */
> +	outb((channel >> 3) & 0xfc, MEC_ADDR);
> +	/* Get the current port settings */
> +	reg = inb(MEC_DATA((channel >> 3) & 0x03));
> +	/* Outputs are active low, so clear the bit for on, or set it for off */
> +	if (on)
> +		reg &= ~(1 << (channel & 0x7));
> +	else
> +		reg |= 1 << (channel & 0x7);
> +	/* Write back the updated register */
> +	outb(reg, MEC_DATA((channel >> 3) & 0x03));
> +	mutex_unlock(&mec_io_mutex);
> +}
> +
> +static enum led_brightness silicom_mec_led_mc_brightness_get(struct led_classdev *led_cdev)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
> +	enum led_brightness brightness = LED_OFF;
> +	int i;
> +
> +	for (i = 0; i < mc_cdev->num_colors; i++) {
> +		mc_cdev->subled_info[i].brightness =
> +			silicom_mec_led_get(mc_cdev->subled_info[i].channel);
> +		/* Mark the overall brightness as LED_ON if any of the subleds are on */
> +		if (mc_cdev->subled_info[i].brightness != LED_OFF)
> +			brightness = LED_ON;
> +	}
> +
> +	return brightness;
> +}
> +
> +static void silicom_mec_led_mc_brightness_set(struct led_classdev *led_cdev,
> +											enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
> +	int i;
> +
> +	led_mc_calc_color_components(mc_cdev, brightness);
> +	for (i = 0; i < mc_cdev->num_colors; i++) {
> +		silicom_mec_port_set(mc_cdev->subled_info[i].channel,
> +					mc_cdev->subled_info[i].brightness);

Align the arguments to the same column please.

> +	}
> +}
> +
> +static int silicom_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
> +{
> +	u8 *channels = gpiochip_get_data(gc);
> +
> +	/* Input registers have offsets between [0x00, 0x07] */
> +	if (CHANNEL_TO_OFFSET(channels[offset]) < 0x08)
> +		return GPIO_LINE_DIRECTION_IN;
> +
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int silicom_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
> +{
> +	int direction = silicom_gpio_get_direction(gc, offset);
> +
> +	return direction == GPIO_LINE_DIRECTION_IN ? 0 : -EINVAL;
> +}
> +
> +static void silicom_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
> +{
> +	u8 *channels = gpiochip_get_data(gc);
> +	int direction = silicom_gpio_get_direction(gc, offset);
> +	int channel = channels[offset];
> +
> +	if (direction == GPIO_LINE_DIRECTION_IN)
> +		return;
> +
> +	if (value)
> +		silicom_mec_port_set(channel, 0);
> +	else if (value == 0)
> +		silicom_mec_port_set(channel, 1);
> +	else
> +		pr_err("Wrong argument value: %d\n", value);
> +}
> +
> +static int silicom_gpio_direction_output(struct gpio_chip *gc, unsigned int offset, int value)
> +{
> +	int direction = silicom_gpio_get_direction(gc, offset);
> +
> +	if (direction == GPIO_LINE_DIRECTION_IN)
> +		return -EINVAL;
> +
> +	silicom_gpio_set(gc, offset, value);
> +
> +	return 0;
> +}
> +
> +static int silicom_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	u8 *channels = gpiochip_get_data(gc);
> +	int channel = channels[offset];
> +
> +	return silicom_mec_port_get(channel);
> +}
> +
> +


> +static ssize_t efuse_status_show(struct device *dev, struct device_attribute *attr,
> +								char *buf)
> +{
> +	u32 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Select memory region */
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(0x28, EC_ADDR_LSB);

That 0x28 is some HW offset right? It should be named to what is found at 
that address with a define. Fiven the function name, perhaps something 
along the lines of #define MEC_EFUSE_STATUS	0x28

> +
> +	/* Get current data from the address */
> +	reg = inl(MEC_DATA(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +
> +	efuse_status = reg & 0x1;
> +
> +	return sprintf(buf, "%d\n", efuse_status);
> +}
> +
> +static ssize_t uc_version_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	u32 reg;
> +	int uc_version;
> +
> +	mutex_lock(&mec_io_mutex);
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(0x0, EC_ADDR_LSB);

Named define for 0x0.

> +
> +	reg = inl(MEC_DATA(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +	uc_version = FIELD_GET(GENMASK(15, 8), reg);

In general, it's more useful to have #define with name for GENMASK() like 
this, but see below...

> +	if (uc_version >= 64 && uc_version < 128) {
> +		uc_version &= ~(1 << 6);
> +		uc_version = 100 + uc_version;
> +	} else if (uc_version >= 128 && uc_version < 192) {
> +		uc_version &= ~(1 << 7);
> +		uc_version = 200 + uc_version;
> +	}

I see you probably missed what I tried to say earlier. Does this version 
field have two distinct fields? How about this:

#define	MEC_VERSION_MAJOR	GENMASK(15, 14)
#define MEC_VERSION_MINOR	GENMASK(13, 8)

	uc_version = FIELD_GET(MEC_VERSION_MAJOR, reg) * 100 +
		     FIELD_GET(MEC_VERSION_MINOR, reg);

...you might want to add something for >= 192 values (or accept they'll be 
in 300..3xx range if that's okay, I don't know the internals of this 
fields so I cannot tell which is preferred here).

I think the results are identical to what the above code does but doesn't
require any if()s (sans >= 192 that might need additional check).

> +	mec_uc_version = uc_version;
> +	return sprintf(buf, "%d\n", mec_uc_version);
> +}
> +
> +static ssize_t power_cycle_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	return sprintf(buf, "%d\n", power_cycle);
> +}
> +
> +static void powercycle_uc(void)
> +{
> +	mutex_lock(&mec_io_mutex);
> +	/* Select memory region */
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(0x24, EC_ADDR_LSB);

Named define for 0x24.

-- 
 i.


