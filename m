Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1624376E7DF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjHCMHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjHCMHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:07:06 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196623586;
        Thu,  3 Aug 2023 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691064408; x=1722600408;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=/i8vph+Mzb9rekHf6uwy7R3r+IVZ/I6HMserJyLguSI=;
  b=FIK/+WtrxanM4MVGVmq93hKhRIRDGJKojcgPD4GhRF/6puWEsPG+YiZl
   zEn1OPq6xOGp61dUx1CKWMQ7C1IDZFPWY5B5limu4eqxl8ftjG1AMNqlV
   hF0D2LXXknrjfOC4V4W1yD2Cip5/IW1n4jRaeoLx5OxgzeAhcq/V3aw13
   2VnvgR323TXPJKkvp5BcRDqHR6RmOreiA3BRAEY4OxWz+rPCkMI97GdYi
   PuhifE8nw6YNpxJoYPKHrJp+RL76RGPwCCdsGVLh3sweCaBLKXbaSUNLa
   sjhCNC9rHF+tc+vWU2voaKFrDGC7neViSIInixOPWX0aPDalqt4A1SeL2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="354772584"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="354772584"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1060231122"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="1060231122"
Received: from eozturk-mobl.ger.corp.intel.com ([10.249.38.219])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:06:43 -0700
Date:   Thu, 3 Aug 2023 15:06:36 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Huibin Shi <henrys@silicom-usa.com>
cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
In-Reply-To: <PA4PR04MB922224D96319862CF987FE459A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
Message-ID: <58da791d-866c-ce2f-94bb-1feff8506c2@linux.intel.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com> <94cbb7d-68a-765-8bdf-5c8f8e41891@linux.intel.com> <PA4PR04MB922224D96319862CF987FE459A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1115965760-1691063821=:1954"
Content-ID: <7e80c5b4-92ac-8033-f7dd-35c725c5abf2@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1115965760-1691063821=:1954
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <b1a928ed-f05a-3c31-7da-e78bc5dcab43@linux.intel.com>

On Fri, 28 Jul 2023, Huibin Shi wrote:

> Ilpo,
> 
> Thanks for the comments. See my comments below.
> 
> Updated patch will be sent out later after review comments from other reviewer are addressed. 
> 
> Henry
> -----Original Message-----
> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> 
> Sent: Wednesday, July 19, 2023 8:13 AM
> To: Henry Shi <henryshi2018@gmail.com>
> Cc: hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org; jdelvare@suse.com; linux@roeck-us.net; LKML <linux-kernel@vger.kernel.org>; platform-driver-x86@vger.kernel.org; linux-hwmon@vger.kernel.org; hb_shi2003@yahoo.com; Huibin Shi <henrys@silicom-usa.com>; Wen Wang <wenw@silicom-usa.com>
> Subject: Re: [PATCH] Add Silicom Platform Driver
> 
> Caution: This is an external email. Please take care when clicking links or opening attachments.
> 
> 
> On Tue, 18 Jul 2023, Henry Shi wrote:
> 
> > The Silicom platform (silicom-platform) Linux driver for Swisscom 
> > Business Box (Swisscom BB) as well as Cordoba family products is a 
> > software solution designed to facilitate the efficient management and 
> > control of devices through the integration of various Linux 
> > frameworks. This platform driver provides seamless support for device 
> > management via the Linux LED framework, GPIO framework, Hardware 
> > Monitoring (HWMON), and device attributes. The Silicom platform 
> > driver's compatibility with these Linux frameworks allows applications 
> > to access and control Cordoba family devices using existing software 
> > that is compatible with these frameworks. This compatibility 
> > simplifies the development process, reduces dependencies on 
> > proprietary solutions, and promotes interoperability with other 
> > Linux-based systems and software.
> >
> > Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> > ---
> >  drivers/platform/x86/Kconfig            |   12 +
> >  drivers/platform/x86/Makefile           |    1 +
> >  drivers/platform/x86/silicom-platform.c | 1123 
> > +++++++++++++++++++++++
> >  3 files changed, 1136 insertions(+)
> >  create mode 100644 drivers/platform/x86/silicom-platform.c
> >

> > +void lock_io_modules(void)
> > +{
> > +     mutex_lock(&mec_io_mutex);
> > +}
> > +EXPORT_SYMBOL(lock_io_modules);
> > +
> > +void unlock_io_modules(void)
> > +{
> > +     mutex_unlock(&mec_io_mutex);
> > +}
> > +EXPORT_SYMBOL(unlock_io_modules);

These are unused.

> > +     u32 byte_pos = 0;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Select memory region */
> > +     outb(bank, EC_ADDR_MSB);
> > +     outb(offset, EC_ADDR_LSB);
> > +
> > +     /* Set to 1 for current date from the address */
> > +     outb(1, MEC_DATA(byte_pos));
> 
> Hmm, this is really misleading. MEC_DATA() seems to calculate _an offset_, not data? Name things accordingly.
> 
> Henry: OK, changed the defined to  "#define MEC_DATA(offset) ((mec_io_base) + 0x04 + (offset))"

Not much better, unfortunately. Call it MEC_OFFSET() or MEC_DATA_OFFSET() 
instead of MEC_DATA().

> > +static void silicom_gpio_set(struct gpio_chip *gc, unsigned int 
> > +offset, int value) {
> > +     u8 *channels = gpiochip_get_data(gc);
> > +     int direction = silicom_gpio_get_direction(gc, offset);
> > +     int channel = channels[offset];
> > +     u8 reg;
> > +
> > +     if (direction == GPIO_LINE_DIRECTION_IN)
> > +             return;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Get the dword offset from the channel */
> > +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> > +
> > +     /* Get the current register */
> > +     reg = inb(MEC_DATA((channel >> 3) & 0x03));
> > +     if (value == 0)
> > +             reg &= ~(1 << (channel & 0x7));
> > +     else if (value > 0)
> > +             reg |= 1 << (channel & 0x7);
> > +     else
> > +             pr_err("Invalid GPIO value: %d\n", value);
> > +     outb(reg, MEC_DATA((channel >> 3) & 0x03));
> > +     mutex_unlock(&mec_io_mutex);
> > +}
> > +
> > +static int silicom_gpio_direction_output(struct gpio_chip *gc, 
> > +unsigned int offset, int value) {
> > +     int direction = silicom_gpio_get_direction(gc, offset);
> > +
> > +     if (direction == GPIO_LINE_DIRECTION_IN)
> > +             return -EINVAL;
> > +
> > +     silicom_gpio_set(gc, offset, value);
> > +
> > +     return 0;
> > +}
> > +
> > +static int silicom_gpio_get(struct gpio_chip *gc, unsigned int 
> > +offset) {
> > +     u8 *channels = gpiochip_get_data(gc);
> > +     int channel = channels[offset];
> > +     u8 reg;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Get the dword offset from the channel */
> > +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> > +
> > +     /* Get the current register */
> > +     reg = inb(MEC_DATA((channel >> 3) & 0x03));
> > +     mutex_unlock(&mec_io_mutex);
> > +
> > +     return (reg >> (channel & 0x7)) & 0x01; }

> > +static void silicom_mec_led_set(int channel, int on) {
> > +     u8 reg;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Get the dword offset from the channel */
> > +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> > +     /* Get the current LED settings */
> > +     reg = inb(MEC_DATA((channel >> 3) & 0x03));
> > +
> > +     /* Outputs are active low, so clear the bit for on, or set it for off */
> > +     if (on)
> > +             reg &= ~(1 << (channel & 0x7));
> > +     else
> > +             reg |= 1 << (channel & 0x7);
> > +
> > +     /* Write back the updated register */
> > +     outb(reg, MEC_DATA((channel >> 3) & 0x03));
> > +
> > +     mutex_unlock(&mec_io_mutex);
> 
> There's an identical code block in silicom_gpio_set(). Why not simply 
> call this from silicom_gpio_set()? 
> 
> Henry: these two block of date are different: silicom_mec_led_set(xxx, 
> int on), argument on, when on is 1, it means turn on LED; 0 means turn 
> off LED. For  silicom_gpio_set(), the argument value, which is really 
> the 0 or 1 bit value that passed to reg. 

The necessary conversion (and checks) can be made before/when calling the 
function from another. The code is so identical that I don't buy it 
cannot be done (I've diff'ed those functions against each other so I know 
for sure!).

> > +}
> > +
> > +static void silicom_mec_led_mc_brightness_set(struct led_classdev *led_cdev,
> > +                                           enum led_brightness 
> > +brightness) {
> > +     struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
> > +     int i;
> > +
> > +     led_mc_calc_color_components(mc_cdev, brightness);
> > +
> > +     for (i = 0; i < mc_cdev->num_colors; i++) {
> > +             silicom_mec_led_set(mc_cdev->subled_info[i].channel,
> > +                                 mc_cdev->subled_info[i].brightness);
> > +     }
> > +}
> > +
> > +static enum led_brightness silicom_mec_led_get(int channel) {
> > +     u8 reg;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Get the dword offset of the register for this LED from the channel */
> > +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> > +     /* Get the current LED settings */
> > +     reg = inb(MEC_DATA((channel >> 3) & 0x03));
> > +     mutex_unlock(&mec_io_mutex);
> > +
> > +     /* Outputs are active low */
> > +     return reg & (1 << (channel & 0x7)) ? LED_OFF : LED_ON;
> 
> Looks identical to a part of silicom_gpio_get(). Perhaps it should call this function??
> 
> Henry: some of the code block of these two functions are similar. But 
> function return types are different. Gpio has status of 0 or 1, but LED 
> has status of LED_OFF and LED_ON. 

The same comment as above for the set. I think the return types can be 
converted in the calling function before returning.

> > +static int __init silicom_platform_info_init(const struct 
> > +dmi_system_id *id) {
> > +     struct silicom_platform_info *info = id->driver_data;
> > +
> > +     dev_info(&silicom_platform_dev->dev, "Detected %s\n", 
> > + id->ident);
> > +
> > +     mec_io_base = info->io_base;
> > +     mec_io_len = info->io_len;
> > +     silicom_led_info = info->led_info;
> > +     silicom_gpio_channels = info->gpio_channels;
> > +     silicom_gpiochip = info->gpiochip;
> > +     if (silicom_gpiochip)
> 
> How can this be NULL?
> 
> Henry: in case something wrong with info->gpiochip

But how can that occur? Both struct defining silicom_platform_info provide
a non-NULL value. There's no need for such safety construct which cannot 
be every true within the kernel code.

> > +static int __init silicom_platform_init(void) {
> > +     struct device *dev;
> > +     int err;
> > +
> > +     /* register a platform device to act as the parent for LEDS, etc. */
> > +     silicom_platform_dev = platform_device_register_simple("silicom-platform", -1, NULL, 0);
> > +     if (IS_ERR(silicom_platform_dev)) {
> > +             err = PTR_ERR(silicom_platform_dev);
> > +             pr_err("failed to register silicom-platform device: %d\n", err);
> > +             goto silicom_init_register_err;

Instead of goto, return directly as there's nothing to rollback:

return err;

> > +     }
> > +     dev = &silicom_platform_dev->dev;
> > +
> > +     err = dmi_check_system(silicom_dmi_ids);
> > +     if (err == 0) {
> > +             dev_err(dev, "No DMI match for this platform\n");
> > +             err = -ENODEV;
> > +             goto silicom_init_probe_err;
> > +     }
> > +
> > +     /* Directly probe the platform driver in init since this isn't a
> > +      * hotpluggable device.  That means we don't need to register a driver
> > +      * that needs to wait around in memory on the chance a matching device
> > +      * would get added.  Instead run once in __init so that we can free all
> > +      * those resources when the __init region is wiped
> > +      */
> > +     err = platform_driver_probe(&silicom_platform_driver, silicom_platform_probe);
> > +     if (err) {
> > +             dev_err(dev, "Failed to probe platform driver %d\n", err);
> > +             goto silicom_init_probe_err;
> > +     }
> > +
> > +     return 0;
> > +
> > +silicom_init_probe_err:
> > +     if (silicom_platform_dev) {
> 
> How can this by NULL?
> 
> Henry: if function platform_device_register_simple() failed to regiseter, silicom_platform_dev will be NULL,

Ah, sorry. I should have mentioned that that branch should return error 
instead rather than gotoing here.

> > +             platform_device_unregister(silicom_platform_dev);
> > +             silicom_platform_dev = NULL;
> 
> Seems unnecessary.
> 
> Henry: It is need. I saw when registering device failed, the driver crashes.

From which access of silicom_platform_dev??

> > +     }
> > +     if (my_dev_ctl.my_dev) {
> > +             root_device_unregister(my_dev_ctl.my_dev);
> > +             my_dev_ctl.my_dev = NULL;
> 
> Ditto.
> 
> Henry: It is need. I saw when registering device failed, the driver crashes.

Ah, I didn't notice it before but this should be properly arranged into 
reverse order such that goto xx can target the correct amount of rollback 
(in reverse order than init). Add xx labels as necessary for each 
rollback step you need to jump to.

> > +     }
> > +
> > +silicom_init_register_err:
> > +     return err;
> > +}


-- 
 i.
--8323329-1115965760-1691063821=:1954--
