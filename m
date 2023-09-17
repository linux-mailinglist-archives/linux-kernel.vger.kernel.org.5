Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21EA7A36BA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbjIQRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjIQRGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:06:03 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF11185;
        Sun, 17 Sep 2023 10:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694970352; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lYMk7pEhvM1xiSHTcFa4Cwuv92EqkLDRkZ/6Rb6etEWLBnbEzbB/I44xDuxOlk8UJh
    0STNatZuvwadMGoKaurvIQ5UnjK+8hi2KK9NKnna9XA5d1KcnLDTMAo2DhTUismzhxbx
    n0vZisNwtnW2LB6mc3njsrwOaVWulMByAvS8bhIOj8ESB72uV54Td8pVyheBQzAliiji
    Y3uhFi2cvPxJXfSDkmKFvfnl4MX98c+6wLKhWFqIpSyp5UnZPt0adiR8CZ5yffpOf7jm
    b5q9ux0suILQL5rB/+T8sY2CGhHAtQ3Z50UkcM6ibA8pgO/CxQd5RB3lqllTyaDFmv6H
    10/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694970352;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=iPwq1HA3fbTWXZIeErTjmAkjtqfkNGYHtHyE2hBeKw0=;
    b=LXfxYlRozKPHokwCX7VtIY0ft5UcHIAlWwZEOo/BTIdTHnTKbxHAehl91N9qvenxSB
    uFwxsQDvNvOyxKjidb0iXvD3HURvCwS5DQ8qkUJxDBJnkjJ6wekn2RcG4I/N0OM26kQV
    F6cO47zJQLWlIyiM3+7tXbzOtHv4vl318vTDO7fH/XWFAA0V2fUBQFGcHZR9UktSEM91
    HaLMRCa83o2ew/KsQudS1oPMJ7XqtZVTB/YyhsBCyqO1Cs/cmUOP6i1p1zTdBVCRYUSg
    dwvhYr/yyaU+5v8gBJcK+HWUJpch/WTj382XowjBp3wHey/v6JxXFLWtsHPQIBuF+LCH
    SFcg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694970352;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=iPwq1HA3fbTWXZIeErTjmAkjtqfkNGYHtHyE2hBeKw0=;
    b=gyDd99MoxoJqXLe4BdNBaXX04LW7OcIsJ9pNuNJvUMXfrIM9G6OYNEhCOd4IfS7e1x
    gQ41j6Hvac7aGy6aVL3NIx1/sd5JZBlfz/ZrZZlAyAr7WrTOzf5lCYaaQB6J4/YhHqw8
    eBwXx1oM0LnJpD4OJCWMkc1aA0E0FKH7HsBSHwW2pOf0CJIIjs8o2TDfAGIdauNqACno
    MzqmoCkbozP91gvG1Ss1rCZ84/HJNKDuy+D8M2DzZPwZ4Gj+gmk/6RI0ewCwnv0qCn/j
    Guc7HUeDW4jqVwnL3f6yqNyNaP28xjcZudj4IKuGDS62CzykRChYzLa6UfTUHMdVVfPr
    wnXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694970352;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=iPwq1HA3fbTWXZIeErTjmAkjtqfkNGYHtHyE2hBeKw0=;
    b=DLAUD2R+A2SdBGKmX8ZuyKxljaLOikJqiC+ao/CLyXnES4uU/as6aCQ3rUx5Id8c1r
    jEk8ubOS4piLD8Yh6jAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8HH5qB8Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 17 Sep 2023 19:05:52 +0200 (CEST)
Date:   Sun, 17 Sep 2023 19:05:50 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: Re: [PATCH 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZQcx7oQyL6RM06Jt@gerhold.net>
References: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
 <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
 <ZQYUe46/rj8jqNvg@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQYUe46/rj8jqNvg@nixie71>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thanks a lot for your detailed review!

On Sat, Sep 16, 2023 at 03:47:55PM -0500, Jeff LaBundy wrote:
> On Wed, Sep 13, 2023 at 03:25:30PM +0200, Stephan Gerhold wrote:
> > From: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > 
> > Add a simple driver for the Himax HX852x(ES) touch panel controller,
> > with support for multi-touch and capacitive touch keys.
> > 
> > The driver is somewhat based on sample code from Himax. However, that
> > code was so extremely confusing that we spent a significant amount of
> > time just trying to understand the packet format and register commands.
> > In this driver they are described with clean structs and defines rather
> > than lots of magic numbers and offset calculations.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  MAINTAINERS                              |   7 +
> >  drivers/input/touchscreen/Kconfig        |  10 +
> >  drivers/input/touchscreen/Makefile       |   1 +
> >  drivers/input/touchscreen/himax_hx852x.c | 491 +++++++++++++++++++++++++++++++
> >  4 files changed, 509 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 90f13281d297..c551c60b0598 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9331,6 +9331,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
> >  F:	drivers/input/touchscreen/himax_hx83112b.c
> >  
> > +HIMAX HX852X TOUCHSCREEN DRIVER
> > +M:	Stephan Gerhold <stephan@gerhold.net>
> > +L:	linux-input@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml
> > +F:	drivers/input/touchscreen/himax_hx852x.c
> > +
> >  HIPPI
> >  M:	Jes Sorensen <jes@trained-monkey.org>
> >  L:	linux-hippi@sunsite.dk
> > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> > index e3e2324547b9..8e5667ae5dab 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -427,6 +427,16 @@ config TOUCHSCREEN_HIDEEP
> >  	  To compile this driver as a module, choose M here : the
> >  	  module will be called hideep_ts.
> >  
> > +config TOUCHSCREEN_HIMAX_HX852X
> > +	tristate "Himax HX852x(ES) touchscreen"
> > +	depends on I2C
> > +	help
> > +	  Say Y here if you have a Himax HX852x(ES) touchscreen.
> > +	  If unsure, say N.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called himax_hx852x.
> > +
> >  config TOUCHSCREEN_HYCON_HY46XX
> >  	tristate "Hycon hy46xx touchscreen support"
> >  	depends on I2C
> > diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> > index 62bd24f3ac8e..f42a87faa86c 100644
> > --- a/drivers/input/touchscreen/Makefile
> > +++ b/drivers/input/touchscreen/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
> >  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
> > +obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX852X)	+= himax_hx852x.o
> >  obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
> >  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
> >  obj-$(CONFIG_TOUCHSCREEN_ILITEK)	+= ilitek_ts_i2c.o
> > diff --git a/drivers/input/touchscreen/himax_hx852x.c b/drivers/input/touchscreen/himax_hx852x.c
> > new file mode 100644
> > index 000000000000..31616dcfc5ab
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/himax_hx852x.c
> > @@ -0,0 +1,491 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Himax HX852x(ES) Touchscreen Driver
> > + * Copyright (c) 2020-2023 Stephan Gerhold <stephan@gerhold.net>
> > + * Copyright (c) 2020 Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > + *
> > + * Based on the Himax Android Driver Sample Code Ver 0.3 for HMX852xES chipset:
> > + * Copyright (c) 2014 Himax Corporation.
> > + */
> > +
> > +#include <asm/unaligned.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/input/mt.h>
> > +#include <linux/input/touchscreen.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> 
> Please explicitly #include of_device.h.
> 

Ack, thanks!

> > +#include <linux/regulator/consumer.h>
> > +
> > +#define HX852X_COORD_SIZE(fingers)	((fingers) * sizeof(struct hx852x_coord))
> > +#define HX852X_WIDTH_SIZE(fingers)	ALIGN(fingers, 4)
> > +#define HX852X_BUF_SIZE(fingers)	(HX852X_COORD_SIZE(fingers) + \
> > +					 HX852X_WIDTH_SIZE(fingers) + \
> > +					 sizeof(struct hx852x_touch_info))
> > +
> > +#define HX852X_MAX_FINGERS		12
> 
> Well, that's a new one :)
> 

FWIW: I'm not sure if any controller exists that actually supports 12,
but the bits are layed out in a way that it would be possible. :-)

> > +#define HX852X_MAX_KEY_COUNT		4
> > +#define HX852X_MAX_BUF_SIZE		HX852X_BUF_SIZE(HX852X_MAX_FINGERS)
> > +
> > +#define HX852X_TS_SLEEP_IN		0x80
> > +#define HX852X_TS_SLEEP_OUT		0x81
> > +#define HX852X_TS_SENSE_OFF		0x82
> > +#define HX852X_TS_SENSE_ON		0x83
> > +#define HX852X_READ_ONE_EVENT		0x85
> > +#define HX852X_READ_ALL_EVENTS		0x86
> > +#define HX852X_READ_LATEST_EVENT	0x87
> > +#define HX852X_CLEAR_EVENT_STACK	0x88
> > +
> > +#define HX852X_REG_SRAM_SWITCH		0x8c
> > +#define HX852X_REG_SRAM_ADDR		0x8b
> > +#define HX852X_REG_FLASH_RPLACE		0x5a
> > +
> > +#define HX852X_SRAM_SWITCH_TEST_MODE	0x14
> > +#define HX852X_SRAM_ADDR_CONFIG		0x7000
> > +
> > +struct hx852x {
> > +	struct i2c_client *client;
> > +	struct input_dev *input_dev;
> > +	struct touchscreen_properties props;
> > +
> > +	struct gpio_desc *reset_gpiod;
> > +	struct regulator_bulk_data supplies[2];
> > +
> > +	unsigned int max_fingers;
> > +	unsigned int keycount;
> > +	u32 keycodes[HX852X_MAX_KEY_COUNT];
> 
> Nit: might as well make keycodes 'unsigned int' for consistency; I also do not
> feel the newlines are necessary.
> 

I don't mind having the newlines but also don't mind removing them,
will drop them in v2!

> > +};
> > +
> > +struct hx852x_config {
> > +	u8 rx_num;
> > +	u8 tx_num;
> > +	u8 max_pt;
> > +	u8 padding1[3];
> > +	__be16 x_res;
> > +	__be16 y_res;
> > +	u8 padding2[2];
> > +} __packed __aligned(4);
> 
> What is the reason to include trailing padding in this packed struct? Does the
> controller require the entire register length to be read for some reason?
> 

Given your question I guess "padding" might be the wrong word here.
Basically the driver we based this on reads this config in a
semi-obfuscated way like this:

	char data[12];
	i2c_himax_read(..., data, 12, ...);
	rx_num = data[0];
	/* ... */
	x_res = data[6]*256 + data[7];
	/* ... */

data[10] and data[11] are not used in the vendor code, so we don't know
what is encoded there, if there is something encoded there, if only on
some models or only on some firmware versions.

I would prefer to keep the read/write operations similar to the vendor
driver. Who knows if there are peculiar firmware versions that would
fail if the read size is not correct. And maybe there is actually
interesting data in there?

Maybe "unknown" would be more clear than "padding"?

> > +
> > +struct hx852x_coord {
> > +	__be16 x;
> > +	__be16 y;
> > +} __packed __aligned(4);
> > +
> > +struct hx852x_touch_info {
> > +	u8 finger_num;
> > +	__le16 finger_pressed;
> 
> It's interesting that most registers/packets use big endian (e.g. x_res) while
> only this uses little endian. Is that expected?
> 

Yes, it's really like that. If you look closely the __le16 is also the
only 16-bit number that isn't aligned properly. I guess for the
"protocol designers" this fields was maybe not a 16-bit number but two
separate fields. No idea what they were thinking.

> > +	u8 padding;
> 
> Same question with regard to trailing padding.
> 

I think the same answer as above applies here. Additionally here, the
packet format seems to be intentionally 4-byte/32-bit aligned (see
comment in hx852x_handle_events()) so I would say it makes sense to also
read an aligned size from the controller.

> > +} __packed __aligned(4);
> > +
> > +static int hx852x_i2c_read(struct hx852x *hx, u8 cmd, void *data, u16 len)
> > +{
> > +	struct i2c_client *client = hx->client;
> > +	int ret;
> > +
> > +	struct i2c_msg msg[] = {
> > +		{
> > +			.addr = client->addr,
> > +			.flags = 0,
> > +			.len = 1,
> > +			.buf = &cmd,
> > +		},
> > +		{
> > +			.addr = client->addr,
> > +			.flags = I2C_M_RD,
> > +			.len = len,
> > +			.buf = data,
> > +		}
> > +	};
> > +
> > +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> > +	if (ret != ARRAY_SIZE(msg)) {
> > +		dev_err(&client->dev, "failed to read %#x: %d\n", cmd, ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> This function does not appear to be doing anything unique (e.g. retry loop to
> deal with special HW condition, etc.), so I do not see any reason to open-code
> a standard write-then-read operation.
> 
> Can i2c_smbus API simply replace this function,

As far as I know the SMBus standard and API is limited to reading a
maximum of 32 bytes (I2C_SMBUS_BLOCK_MAX). With >= 6 fingers the touch
packet sizes will exceed that.

> or better yet, can this driver
> simply use regmap? In fact, that is what the other mainline Himax driver uses.

Regmap could maybe work, but I think it does not really fit. The I2C
interface here does not provide a consistent register map. Problem is,
for regmap_config we would need to define "reg_bits" and "val_bits".
This does not really exist here: The commands are usually sent without
any arguments, sometimes with a single byte (HX852X_REG_SRAM_SWITCH) and
sometimes with a word (HX852X_REG_SRAM_ADDR). There isn't a specific
register set with values here but more like random "commands".

Since SMBus doesn't allow reading more than 32 bytes and regmap does not
fit I think this custom but fairly standard routine is necessary. :/

> 
> > +
> > +static int hx852x_power_on(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	int error;
> > +
> > +	error = regulator_bulk_enable(ARRAY_SIZE(hx->supplies), hx->supplies);
> > +	if (error < 0) {
> 
> Nit: if (error) as you have done elsewhere.
> 

Thanks, will fix this.

> > +		dev_err(dev, "failed to enable regulators: %d\n", error);
> > +		return error;
> > +	}
> > +
> > +	gpiod_set_value_cansleep(hx->reset_gpiod, 1);
> > +	msleep(20);
> > +	gpiod_set_value_cansleep(hx->reset_gpiod, 0);
> > +	msleep(20);
> > +
> > +	return 0;
> > +}
> > +
> > +static int hx852x_start(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	int error;
> > +
> > +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SLEEP_OUT);
> > +	if (error) {
> > +		dev_err(dev, "failed to send TS_SLEEP_OUT: %d\n", error);
> > +		return error;
> > +	}
> > +	msleep(30);
> > +
> > +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SENSE_ON);
> > +	if (error) {
> > +		dev_err(dev, "failed to send TS_SENSE_ON: %d\n", error);
> > +		return error;
> > +	}
> > +	msleep(20);
> > +
> > +	return 0;
> > +}
> > +
> > +static void hx852x_stop(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	int error;
> > +
> > +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SENSE_OFF);
> > +	if (error)
> > +		dev_err(dev, "failed to send TS_SENSE_OFF: %d\n", error);
> 
> Granted the function is of void type, should we not still return if there
> is an error?
> 
> Actually, I would still keep this function as an int for future re-use, even
> though hx852x_input_close() simply ignores the value. This way, the return
> value can be propagated to the return value of hx852x_suspend() and elsewhere.
> 
> > +
> > +	msleep(20);
> > +
> > +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SLEEP_IN);
> > +	if (error)
> > +		dev_err(dev, "failed to send TS_SLEEP_IN: %d\n", error);
> 
> Same here; no need to sleep following a register write that seemingly did
> not happen.
> 
> > +
> > +	msleep(30);
> > +}
> > +
> > +static void hx852x_power_off(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	int error;
> > +
> > +	error = regulator_bulk_disable(ARRAY_SIZE(hx->supplies), hx->supplies);
> > +	if (error)
> > +		dev_err(dev, "failed to disable regulators: %d\n", error);
> > +}
> 
> Same comment with regard to function type; it's nice for internal helpers
> to be of type int, even if the core callback using it is void.
> 
> > +
> > +static int hx852x_read_config(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	struct hx852x_config conf = {0};
> 
> No need to initialize.
> 
> > +	int x_res, y_res;
> > +	int error;
> > +
> > +	error = hx852x_power_on(hx);
> > +	if (error)
> > +		return error;
> > +
> > +	/* Sensing must be turned on briefly to load the config */
> > +	error = hx852x_start(hx);
> > +	if (error)
> > +		goto power_off;
> > +
> > +	hx852x_stop(hx);
> 
> See my earlier comment about promoting this function's type to int.
> 
> > +
> > +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH,
> > +					  HX852X_SRAM_SWITCH_TEST_MODE);
> > +	if (error)
> > +		goto power_off;
> > +
> > +	error = i2c_smbus_write_word_data(hx->client, HX852X_REG_SRAM_ADDR,
> > +					  HX852X_SRAM_ADDR_CONFIG);
> > +	if (error)
> > +		goto exit_test_mode;
> > +
> > +	error = hx852x_i2c_read(hx, HX852X_REG_FLASH_RPLACE, &conf, sizeof(conf));
> > +	if (error)
> > +		goto exit_test_mode;
> > +
> > +	x_res = be16_to_cpu(conf.x_res);
> > +	y_res = be16_to_cpu(conf.y_res);
> > +	hx->max_fingers = (conf.max_pt & 0xf0) >> 4;
> > +	dev_dbg(dev, "x res: %d, y res: %d, max fingers: %d\n",
> > +		x_res, y_res, hx->max_fingers);
> > +
> > +	if (hx->max_fingers > HX852X_MAX_FINGERS) {
> > +		dev_err(dev, "max supported fingers: %d, found: %d\n",
> > +			HX852X_MAX_FINGERS, hx->max_fingers);
> > +		error = -EINVAL;
> > +		goto exit_test_mode;
> > +	}
> > +
> > +	if (x_res && y_res) {
> > +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_X, 0, x_res - 1, 0, 0);
> > +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_Y, 0, y_res - 1, 0, 0);
> > +	}
> > +
> > +exit_test_mode:
> > +	i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
> 
> Nit: it would still be nice to preserve as many return values as possible, perhaps
> as follows:
> 
> +exit_test_mode:
> 	error = i2c_smbus_write_byte_data(...) ? : error;
> 
> > +power_off:
> > +	hx852x_power_off(hx);
> > +	return error;
> 
> Similarly, with hx852x_power_off() being promoted to int as suggested above,
> this could be:
> 
> 	return hx852x_power_off(...) ? : error;
> 
> There are other idiomatic ways to do the same thing based on your preference.
> Another (perhaps more clear) option would be to move some of these test mode
> functions into a helper, which would also avoid some goto statements.
> 

Thanks for your suggestions regarding the error handling / return codes.
For v2 I will play with the different options you gave and look which
one feels best. :-)

> > +}
> > +
> > +static int hx852x_handle_events(struct hx852x *hx)
> > +{
> > +	/*
> > +	 * The event packets have variable size, depending on the amount of
> > +	 * supported fingers (hx->max_fingers). They are laid out as follows:
> > +	 *  - struct hx852x_coord[hx->max_fingers]: Coordinates for each finger
> > +	 *  - u8[ALIGN(hx->max_fingers, 4)]: Touch width for each finger
> > +	 *      with padding for 32-bit alignment
> > +	 *  - struct hx852x_touch_info
> > +	 *
> > +	 * Load everything into a 32-bit aligned buffer so the coordinates
> > +	 * can be assigned directly, without using get_unaligned_*().
> > +	 */
> > +	u8 buf[HX852X_MAX_BUF_SIZE] __aligned(4);
> > +	struct hx852x_coord *coord = (struct hx852x_coord *)buf;
> > +	u8 *width = &buf[HX852X_COORD_SIZE(hx->max_fingers)];
> > +	struct hx852x_touch_info *info = (struct hx852x_touch_info *)
> > +		&width[HX852X_WIDTH_SIZE(hx->max_fingers)];
> > +	unsigned long finger_pressed, key_pressed;
> 
> It seems these only need to be u16.
> 

Right. However, unsigned long is necessary for using it with
for_each_set_bit(), which wants a pointer to an unsigned long.
I can change it for key_pressed though.

> > +	unsigned int i, x, y, w;
> > +	int error;
> > +
> > +	error = hx852x_i2c_read(hx, HX852X_READ_ALL_EVENTS, buf,
> > +				HX852X_BUF_SIZE(hx->max_fingers));
> > +	if (error)
> > +		return error;
> > +
> > +	finger_pressed = get_unaligned_le16(&info->finger_pressed);
> > +	key_pressed = finger_pressed >> HX852X_MAX_FINGERS;
> > +
> > +	/* All bits are set when no touch is detected */
> > +	if (info->finger_num == 0xff || !(info->finger_num & 0x0f))
> > +		finger_pressed = 0;
> > +	if (key_pressed == 0xf)
> > +		key_pressed = 0;
> > +
> > +	for_each_set_bit(i, &finger_pressed, hx->max_fingers) {
> > +		x = be16_to_cpu(coord[i].x);
> > +		y = be16_to_cpu(coord[i].y);
> > +		w = width[i];
> > +
> > +		input_mt_slot(hx->input_dev, i);
> > +		input_mt_report_slot_state(hx->input_dev, MT_TOOL_FINGER, 1);
> > +		touchscreen_report_pos(hx->input_dev, &hx->props, x, y, true);
> > +		input_report_abs(hx->input_dev, ABS_MT_TOUCH_MAJOR, w);
> > +	}
> > +	input_mt_sync_frame(hx->input_dev);
> > +
> > +	for (i = 0; i < hx->keycount; i++)
> > +		input_report_key(hx->input_dev, hx->keycodes[i], key_pressed & BIT(i));
> > +
> > +	input_sync(hx->input_dev);
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t hx852x_interrupt(int irq, void *ptr)
> > +{
> > +	struct hx852x *hx = ptr;
> > +	int error;
> > +
> > +	error = hx852x_handle_events(hx);
> > +	if (error) {
> > +		dev_err(&hx->client->dev, "failed to handle events: %d\n", error);
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int hx852x_input_open(struct input_dev *dev)
> > +{
> > +	struct hx852x *hx = input_get_drvdata(dev);
> > +	int error;
> > +
> > +	error = hx852x_power_on(hx);
> > +	if (error)
> > +		return error;
> > +
> > +	error = hx852x_start(hx);
> > +	if (error) {
> > +		hx852x_power_off(hx);
> > +		return error;
> > +	}
> > +
> > +	enable_irq(hx->client->irq);
> > +	return 0;
> > +}
> > +
> > +static void hx852x_input_close(struct input_dev *dev)
> > +{
> > +	struct hx852x *hx = input_get_drvdata(dev);
> > +
> > +	hx852x_stop(hx);
> > +	disable_irq(hx->client->irq);
> > +	hx852x_power_off(hx);
> > +}
> > +
> > +static int hx852x_parse_properties(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	int error;
> > +
> > +	hx->keycount = device_property_count_u32(dev, "linux,keycodes");
> > +	if (hx->keycount <= 0) {
> > +		hx->keycount = 0;
> > +		return 0;
> > +	}
> > +
> > +	if (hx->keycount > HX852X_MAX_KEY_COUNT) {
> > +		dev_err(dev, "max supported keys: %d, found: %d\n",
> 
> Nit: these should both be printed as %u.
> 

Right, thanks!

> > +			HX852X_MAX_KEY_COUNT, hx->keycount);
> > +		return -EINVAL;
> > +	}
> > +
> > +	error = device_property_read_u32_array(dev, "linux,keycodes",
> > +					       hx->keycodes, hx->keycount);
> > +	if (error)
> > +		dev_err(dev, "failed to read linux,keycodes: %d\n", error);
> > +
> > +	return error;
> > +}
> > +
> > +static int hx852x_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct hx852x *hx;
> > +	int error, i;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> > +				     I2C_FUNC_SMBUS_WRITE_BYTE |
> > +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> > +				     I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
> > +		dev_err(dev, "not all i2c functionality supported\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	hx = devm_kzalloc(dev, sizeof(*hx), GFP_KERNEL);
> > +	if (!hx)
> > +		return -ENOMEM;
> > +
> > +	hx->client = client;
> > +	hx->input_dev = devm_input_allocate_device(dev);
> > +	if (!hx->input_dev)
> > +		return -ENOMEM;
> > +
> > +	hx->input_dev->name = "Himax HX852x";
> > +	hx->input_dev->id.bustype = BUS_I2C;
> > +	hx->input_dev->open = hx852x_input_open;
> > +	hx->input_dev->close = hx852x_input_close;
> > +
> > +	i2c_set_clientdata(client, hx);
> > +	input_set_drvdata(hx->input_dev, hx);
> > +
> > +	hx->supplies[0].supply = "vcca";
> > +	hx->supplies[1].supply = "vccd";
> > +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(hx->supplies), hx->supplies);
> > +	if (error < 0)
> > +		return dev_err_probe(dev, error, "failed to get regulators");
> > +
> > +	hx->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(hx->reset_gpiod))
> > +		return dev_err_probe(dev, error, "failed to get reset gpio");
> 
> Can the reset GPIO be optional?
> 

I'm afraid I have no idea if the controller needs this or not. Would it
be better to keep it required until someone confirms otherwise or have
it optional for the other way around?

Thanks!
Stephan
