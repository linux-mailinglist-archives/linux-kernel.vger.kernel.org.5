Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD27475E578
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjGWWHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWWHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:07:32 -0400
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17A2E5C;
        Sun, 23 Jul 2023 15:07:28 -0700 (PDT)
Date:   Sun, 23 Jul 2023 17:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1690150046;
        bh=Pzhbdmi+Q4cAPO2nJq3dihfzBgR3qM8T9EVB24WXGeE=;
        h=Date:From:To:Subject:Message-ID:References:Mime-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
         Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=Fsi7v8rCqO8VBaD+2fAY45r8W9+Cxydl7tdq66yA5syYPQ4NZYMoRAv89z5wXhx9t
         U9wUtRa+dyfXmFZtcnKbwAQzJkrKaC2LCmrNFdPU3qZRMyG+xVWzdonOJxgBXEW13V
         kuIutoJh/KpEXc3L8xrBwEMJRG445/zcyr7K/n4GBCEnxBWDDXpl2sI9IWdX/SANVY
         xebjc8aa+NdyzdnUgvjEiDUTk6K/EpBi4TFP12XkFD8izbaHgREevuA+z9oWNTevLL
         oRHn7VnGQi//wQvKBLTZu81NPmfxTDKDFzoZFDns/rgu6VM6dmmOWMTK4tJw8zPIOr
         Kba6d6Zv4wyEg==
From:   "Marty E. Plummer" <hanetzer@startmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] hwmon: (pmbus) Add driver fpr Infineon IR35201
Message-ID: <izfbs2b72mmy6hgwugq5pnilon6626up7yp5quta6dd6tnlusx@bkuyfpenkb4f>
References: <20230720115805.1510279-1-hanetzer@startmail.com>
 <b86e19ed-12af-e488-3c21-002be2ad5914@roeck-us.net>
 <axue7wmaxbj7vurapabuwtvqk3br3zt2g373d6ako4m24wzaxf@2uvgmasdd7dk>
 <bf1be356-9e3e-6fd7-0987-03deb593131e@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1be356-9e3e-6fd7-0987-03deb593131e@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:22:47PM -0700, Guenter Roeck wrote:
> On 7/20/23 11:35, Marty E. Plummer wrote:
> > On Thu, Jul 20, 2023 at 07:00:39AM -0700, Guenter Roeck wrote:
> > > 
> > Maybe.On 7/20/23 04:58, Marty E. Plummer wrote:
> > > > The IR35201 is a dual-loop digital multi-phase buck controller designed for CPU voltage regulation.
> > > > 
> > > > Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> > > > ---
> > > >    Documentation/hwmon/index.rst   |  1 +
> > > >    Documentation/hwmon/ir35201.rst | 63 +++++++++++++++++++++++
> > > >    drivers/hwmon/pmbus/Kconfig     |  9 ++++
> > > >    drivers/hwmon/pmbus/Makefile    |  1 +
> > > >    drivers/hwmon/pmbus/ir35201.c   | 89 +++++++++++++++++++++++++++++++++
> > > >    5 files changed, 163 insertions(+)
> > > >    create mode 100644 Documentation/hwmon/ir35201.rst
> > > >    create mode 100644 drivers/hwmon/pmbus/ir35201.c
> > > > 
> > > > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > > > index 042e1cf9501b..5b44a268de0d 100644
> > > > --- a/Documentation/hwmon/index.rst
> > > > +++ b/Documentation/hwmon/index.rst
> > > > @@ -87,6 +87,7 @@ Hardware Monitoring Kernel Drivers
> > > >       ina3221
> > > >       inspur-ipsps1
> > > >       intel-m10-bmc-hwmon
> > > > +   ir35201
> > > >       ir35221
> > > >       ir38064
> > > >       ir36021
> > > > diff --git a/Documentation/hwmon/ir35201.rst b/Documentation/hwmon/ir35201.rst
> > > > new file mode 100644
> > > > index 000000000000..6ca34d4b02a3
> > > > --- /dev/null
> > > > +++ b/Documentation/hwmon/ir35201.rst
> > > > @@ -0,0 +1,63 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +Kernel driver ir35201
> > > > +=====================
> > > > +
> > > > +Supported chips:
> > > > +
> > > > +  * Infineon IR35201
> > > > +
> > > > +    Prefix: ir35201
> > > > +    Addresses scanned: -
> > > > +
> > > > +    Datasheet: Publicly available at the Infineon website
> > > > +      https://www.infineon.com/dgdl/Infineon-IR35201MTRPBF-DS-v01_00-EN.pdf?fileId=5546d462576f347501579c95d19772b5
> > > > +
> > > > +Authors:
> > > > +      - Marty E. Plummer <hanetzer@startmail.com>
> > > > +
> > > > +Description
> > > > +-----------
> > > > +
> > > > +The IR35201 is a dual-loop digital multi-phase buck controller designed for
> > > > +CPU voltage regulation.
> > > > +
> > > > +Usage Notes
> > > > +-----------
> > > > +
> > > > +This driver does not probe for PMBus devices. You will have to instantiate
> > > > +devices explicitly.
> > > > +
> > > > +Sysfs attributes
> > > > +----------------
> > > > +
> > > > +======================= ===========================
> > > > +curr1_label             "iin"
> > > > +curr1_input             Measured input current
> > > > +curr1_alarm             Input fault alarm
> > > > +
> > > > +curr2_label             "iout1"
> > > > +curr2_input             Measured output current
> > > > +curr2_alarm             Output over-current alarm
> > > > +
> > > > +in1_label               "vin"
> > > > +in1_input               Measured input voltage
> > > > +in1_alarm               Input under-voltage alarm
> > > > +
> > > > +in2_label               "vout1"
> > > > +in2_input               Measured output voltage
> > > > +in2_alarm               Output over-voltage alarm
> > > > +
> > > > +power1_label            "pin"
> > > > +power1_input            Measured input power
> > > > +power1_alarm            Input under-voltage alarm
> > > > +
> > > > +power2_label            "pout1"
> > > > +power2_input            Measured output power
> > > > +
> > > > +temp1_input             Measured temperature
> > > > +temp1_alarm             Temperature alarm
> > > > +
> > > > +temp2_input             Measured other loop temperature
> > > > +temp2_alarm             Temperature alarm
> > > > +======================= ===========================
> > > > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > > > index 270b6336b76d..7180823b15bb 100644
> > > > --- a/drivers/hwmon/pmbus/Kconfig
> > > > +++ b/drivers/hwmon/pmbus/Kconfig
> > > > @@ -123,6 +123,15 @@ config SENSORS_INSPUR_IPSPS
> > > >    	  This driver can also be built as a module. If so, the module will
> > > >    	  be called inspur-ipsps.
> > > > +config SENSORS_IR35201
> > > > +	tristate "Infineon IR35201"
> > > > +	help
> > > > +	  If you say yes here you get hardware monitoring support for the
> > > > +	  Infineon IR35201 controller.
> > > > +
> > > > +	  This driver can also be built as a module. If so, the module will
> > > > +	  be called ir35201.
> > > > +
> > > >    config SENSORS_IR35221
> > > >    	tristate "Infineon IR35221"
> > > >    	help
> > > > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> > > > index 84ee960a6c2d..40729dd14e7a 100644
> > > > --- a/drivers/hwmon/pmbus/Makefile
> > > > +++ b/drivers/hwmon/pmbus/Makefile
> > > > @@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_FSP_3Y)	+= fsp-3y.o
> > > >    obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
> > > >    obj-$(CONFIG_SENSORS_DPS920AB)	+= dps920ab.o
> > > >    obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
> > > > +obj-$(CONFIG_SENSORS_IR35201)	+= ir35201.o
> > > >    obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
> > > >    obj-$(CONFIG_SENSORS_IR36021)	+= ir36021.o
> > > >    obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
> > > > diff --git a/drivers/hwmon/pmbus/ir35201.c b/drivers/hwmon/pmbus/ir35201.c
> > > > new file mode 100644
> > > > index 000000000000..77f77057175a
> > > > --- /dev/null
> > > > +++ b/drivers/hwmon/pmbus/ir35201.c
> > > > @@ -0,0 +1,89 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Hardware monitoring driver for Infineon IR35201
> > > > + */
> > > > +
> > > > +#include <linux/err.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include "pmbus.h"
> > > > +
> > > > +static struct pmbus_driver_info ir35201_info = {
> > > > +	.pages = 1,
> > > > +	.format[PSC_VOLTAGE_IN] = linear,
> > > > +	.format[PSC_VOLTAGE_OUT] = linear,
> > > > +	.format[PSC_CURRENT_IN] = linear,
> > > > +	.format[PSC_CURRENT_OUT] = linear,
> > > > +	.format[PSC_POWER] = linear,
> > > > +	.format[PSC_TEMPERATURE] = linear,
> > > > +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
> > > > +		| PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT
> > > > +		| PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
> > > > +		| PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> > > > +		| PMBUS_HAVE_STATUS_TEMP,
> > > 
> > > Several supported status registers are missing.
> > > 
> > Maybe. Did the best I could with this and another datasheet (ir36* iirc)
> > open at the same time and both source files open for comparison, and the
> > output from sensors with this patch, with allowances for variations
> > in temps, matches more or less what HWINFO64 outputs on a windows pe
> > based build of hiren's boot cd.
> 
> STATUS_INPUT, STATUS_IOUT, and STATUS_VOUT are supported according
> to the datasheet. Do you have reason to believe that this is incorrect ?
> If so, I would want to see a comment in the driver explaining that the
> datasheet is wrong and doesn't support those registers.
> 
> > > > +};
> > > > +
> > > > +static int ir35201_probe(struct i2c_client *client)
> > > > +{
> > > > +	u8 buf[I2C_SMBUS_BLOCK_MAX];
> > > > +	int ret;
> > > > +
> > > > +	if (!i2c_check_functionality(client->adapter,
> > > > +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> > > > +					 | I2C_FUNC_SMBUS_READ_WORD_DATA
> > > > +					 | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> > > > +		return -ENODEV;
> > > > +
> > > > +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
> > > > +		return ret;
> > > > +	}
> > > > +	if (ret != 2 || strncmp(buf, "IR", strlen("IR"))) {
> > > > +		dev_err(&client->dev, "MFR_ID unrecognized\n");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > 
> > > Did you actually test this ? Datasheet says it is "ASCII 52 49" which
> > > would make it "RI" like IR35221, not "IR". Problem though is that it
> > > seems like the register is writeable via some USER programming,
> > > making it unreliable.
> > > 
> > Yes, I did. And strangely enough, it reads 'backwards' or so, relative
> > to the 35221. I almost sent this along without removing the debugging
> > pr_infos I had in this area to check that. drove me bonkers a bit.
> > > > +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&client->dev, "Failed to read PMBUS_MFR_MODEL\n");
> > > > +		return ret;
> > > > +	}
> > > > +	if (ret != 1 || buf[0] != 0x50) {
> > > > +		dev_err(&client->dev, "MFR_MODEL unrecognized\n");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > 
> > > The datasheet suggests that PMBUS_MFR_ID and PMBUS_MFR_MODEL can differ based
> > > on some USER register programming. I would suggest to read IC_DEVICE_ID instead
> > > and compare against that (which s supposed to be 0x4d).
> > > 
> > Somehow I missed that, but it was on my 'to-check' list. I think the
> > issue may have arose from my datasheet comparison, as the ir36* doesn't
> > have such a register listed.
> 
> Different series, probably different microcontroller and different microcode.
> 
> > > On a higher level, I don't see anything special in this chip. Would it be possible
> > > to just add it to pmbus.c ? Something like
> > > 
> > > 	{"ir35201", (kernel_ulong_t)&pmbus_info_one},
> > > 
> > Honestly, I was wondering about folding this and the other very similar
> > IR3* chips into one driver. Should be doable? But I guess this approach
> > works as well; in fact, during my investigation phase I stuck the pmbus
> > driver onto the correct i2c address to get an easy way to read stuff
> > from the chip (tbh I'm surprised that this far along in linux we don't
> > have anything other than pmbus_peek to poke for info; maybe i2c-tools
> > can do it but I can't seem to make it work like I'd expect).
> 
> This isn't about "doable". We don't want to add new drivers just for fun
> and/or "because it works as well". A new driver should only be added if
> needed. It was done, for example, for IR35221 because that chip has
> non-standard registers which we want to have supported.
> 
> Unless I am missing something, IR35201 only supports standard commands.
> So the question is: Is the new driver really needed ? It appears you are
> saying that, no, it isn't needed. Add the chip to pmbus.c as I suggested above.
> If and only if that doesn't work we can talk about a new driver.
> 
Binding the pmbus subdriver (I guess you could call it that) for the
"adp4000", which shares the same pmbus_device_info struct you suggested
results in sensible output in lm_sensors. I'll whip up a new patch and
send it in.
> Thanks,
> Guenter
> 
