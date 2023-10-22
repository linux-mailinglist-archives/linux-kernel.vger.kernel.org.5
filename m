Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880CD7D2571
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjJVSta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:49:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E822DE5;
        Sun, 22 Oct 2023 11:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698000560; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ip/R+um7vbuDF2Opqj34MuPIzLISiAy0wQ84/wsxqsLwMdLo4KzG7VnpUM/QHDxrjS
    xdOWwFSVykEPRwN0zilEPgCeRq4jBmXGIyhxG1tdQ5qZKfG+viuG0ZiNJ/r3VqgvBiDB
    MGEdsw07SPG71ruS4XUAocncRaeo98Lm6ssu1iPq0oLhsViSKfVAUwe1U84Tr2oD6Q1o
    sYX5SjKxOPDLrw2xetbMO+QLY7l2lWA5RDu5xptwtWb0ILXAmDGkgZzNKY/VzAGI7V6H
    xLwwUvcVLpgmEx7TEuDUrArF1dmuRt2JxqbAv1ySdughoo9lKZxBpA5Xyu05Hd7ygSIK
    ltkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698000560;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=fFFFG+QQz6OYpUyny5W+yZg5BK94VXENv9YglvlxvVk=;
    b=PWmJY//b30j0qUvNHfFJvrNsgZJ5SEENlxGyJQSnfPE1DMzfCoCX/1BmYd7VEzkser
    4WBPjvgiknzctnfrtp34uTaPBCe+j1WPtGZeviPxK6zhs2OmZCxp+OkSV4igEtmQFHX0
    FbSKCyK3k+GWQBA5Zq4xLzkdONx3VmwdadG7MY4FXKJwooBwCgc7qWYghwaC4QM5qKH4
    v5eaYMvz1vwgNIWsTrLqusI39JeMmHy7vf7W/FCIe6p2jhgMRoghueha2LzwntF8R6kh
    xCN5J38eGBDENjJL6HJWn+2u1rvtkwCS7FWYU5sDyvTm3oGKH28wLb4TDR/dT/rjimZH
    9DaQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698000560;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=fFFFG+QQz6OYpUyny5W+yZg5BK94VXENv9YglvlxvVk=;
    b=mTK6bWhrPmhafywlPZOPKbDlCT5mOrf5om+foKbMUEpu2SI2E7gf5Njda657HsEB+8
    MSf+ClPjbzNpuzPxAf8d9Wcc8cdYGZhLRuO1fySxq2omEWBIg36eZn1NcgjCEaudCXC2
    IH9bVuhfy8QGgHX1xBzkNK+Zg1Wd2c9/6k8+KUXLAtJ6zAo+9j8/sVJ3MdBsWk8y3RBE
    JhPhF61hhA+PrW4KPQXwqkCwxxd/Q4JSya89j63YWvVPo8V/yquFrk0ONz6jFFkToUUQ
    bb92JmNDuEUCiGF7C2PZEPPKlUFWF8NLf2YU26+V5z1eb3v2/zLHE2U4EhQ4oYwxmnoF
    v9xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698000560;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=fFFFG+QQz6OYpUyny5W+yZg5BK94VXENv9YglvlxvVk=;
    b=h1Lem57PjwxV7x8PhAJqFERTRcotYevCKqMuXMUhFXXpFky4INoYnCwkI4AmZ3yKkp
    5cFhuHnZwO1m5LeMyYCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9MInJKPm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 22 Oct 2023 20:49:19 +0200 (CEST)
Date:   Sun, 22 Oct 2023 20:49:13 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: Re: [PATCH v2 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZTVuqW7oU5BmPzTS@gerhold.net>
References: <20230930-hx852x-v2-0-c5821947b225@gerhold.net>
 <20230930-hx852x-v2-2-c5821947b225@gerhold.net>
 <ZTVoiklUJaDn5576@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTVoiklUJaDn5576@nixie71>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thanks a lot for reviewing this again!

On Sun, Oct 22, 2023 at 01:23:06PM -0500, Jeff LaBundy wrote:
> Hi Stephan,
> 
> This looks great, just a few remaining comments.
> 
> On Sat, Sep 30, 2023 at 05:32:01PM +0200, Stephan Gerhold wrote:
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
> >  drivers/input/touchscreen/himax_hx852x.c | 499 +++++++++++++++++++++++++++++++
> >  4 files changed, 517 insertions(+)
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
> > index 000000000000..98a55be7891d
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/himax_hx852x.c
> > @@ -0,0 +1,499 @@
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
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#define HX852X_COORD_SIZE(fingers)	((fingers) * sizeof(struct hx852x_coord))
> > +#define HX852X_WIDTH_SIZE(fingers)	ALIGN(fingers, 4)
> > +#define HX852X_BUF_SIZE(fingers)	(HX852X_COORD_SIZE(fingers) + \
> > +					 HX852X_WIDTH_SIZE(fingers) + \
> > +					 sizeof(struct hx852x_touch_info))
> > +
> > +#define HX852X_MAX_FINGERS		12
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
> > +	struct gpio_desc *reset_gpiod;
> > +	struct regulator_bulk_data supplies[2];
> > +	unsigned int max_fingers;
> > +	unsigned int keycount;
> > +	unsigned int keycodes[HX852X_MAX_KEY_COUNT];
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
> > +
> > +struct hx852x_coord {
> > +	__be16 x;
> > +	__be16 y;
> > +} __packed __aligned(4);
> > +
> > +struct hx852x_touch_info {
> > +	u8 finger_num;
> > +	__le16 finger_pressed;
> > +	u8 padding;
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
> 
> Nit: standard practice is to close all array elements with a trailing comma,
> even the final element, in order to avoid an extra line in the diff (i.e.
> } --> },) if another element is added later. Obviously we wouldn't add more
> elements to this array in the future, but it's best to remain consistent.
> 

Sure, I'll fix this in v3!

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
> > +
> > +static int hx852x_power_on(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	int error;
> > +
> > +	error = regulator_bulk_enable(ARRAY_SIZE(hx->supplies), hx->supplies);
> > +	if (error) {
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
> > +static int hx852x_stop(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	int error;
> > +
> > +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SENSE_OFF);
> > +	if (error) {
> > +		dev_err(dev, "failed to send TS_SENSE_OFF: %d\n", error);
> > +		return error;
> > +	}
> > +	msleep(20);
> > +
> > +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SLEEP_IN);
> > +	if (error) {
> > +		dev_err(dev, "failed to send TS_SLEEP_IN: %d\n", error);
> > +		return error;
> > +	}
> > +	msleep(30);
> > +
> > +	return 0;
> > +}
> > +
> > +static int hx852x_power_off(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	int error;
> > +
> > +	error = regulator_bulk_disable(ARRAY_SIZE(hx->supplies), hx->supplies);
> > +	if (error)
> > +		dev_err(dev, "failed to disable regulators: %d\n", error);
> > +	return error;
> > +}
> > +
> > +static int hx852x_read_config(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	struct hx852x_config conf;
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
> > +		goto err_power_off;
> > +
> > +	error = hx852x_stop(hx);
> > +	if (error)
> > +		goto err_power_off;
> > +
> > +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH,
> > +					  HX852X_SRAM_SWITCH_TEST_MODE);
> > +	if (error)
> > +		goto err_power_off;
> > +
> > +	error = i2c_smbus_write_word_data(hx->client, HX852X_REG_SRAM_ADDR,
> > +					  HX852X_SRAM_ADDR_CONFIG);
> > +	if (error)
> > +		goto err_test_mode;
> > +
> > +	error = hx852x_i2c_read(hx, HX852X_REG_FLASH_RPLACE, &conf, sizeof(conf));
> > +	if (error)
> > +		goto err_test_mode;
> > +
> > +	x_res = be16_to_cpu(conf.x_res);
> > +	y_res = be16_to_cpu(conf.y_res);
> > +	hx->max_fingers = (conf.max_pt & 0xf0) >> 4;
> > +	dev_dbg(dev, "x res: %u, y res: %u, max fingers: %u\n",
> > +		x_res, y_res, hx->max_fingers);
> > +
> > +	if (hx->max_fingers > HX852X_MAX_FINGERS) {
> > +		dev_err(dev, "max supported fingers: %u, found: %u\n",
> > +			HX852X_MAX_FINGERS, hx->max_fingers);
> > +		error = -EINVAL;
> > +		goto err_test_mode;
> > +	}
> > +
> > +	if (x_res && y_res) {
> > +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_X, 0, x_res - 1, 0, 0);
> > +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_Y, 0, y_res - 1, 0, 0);
> > +	}
> > +
> > +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
> > +	if (error)
> > +		goto err_power_off;
> > +
> > +	return hx852x_power_off(hx);
> > +
> > +err_test_mode:
> > +	i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
> > +err_power_off:
> > +	hx852x_power_off(hx);
> > +	return error;
> 
> Your new version is an improvement, but maybe we can remove duplicate
> code by introducing some helper variables:
> 
> 	int error, error2 = 0, error3;
> 
> 	/* ... */
> 
> err_test_mode:
> 	error2 = i2c_smbus_write_byte_data(...);
> 
> err_power_off:
> 	error3 = hx852x_power_off(...);
> 
> 	if (error)
> 		return error;
> 
> 	return error2 ? : error3;
> 
> In this case we achieve our goal of attempting to return the device to a
> safe state in both passing and failing cases. In the event of multiple
> errors, we return the first to occur.
> 

Right, this would work as well. Personally I think my solution is
slightly easier to read though. In your version my eyes somewhat
"stumble" over the multiple "error" variables and then about the purpose
of the "? : " construction. This is probably highly subjective. :-)

Do you mind if keep this as-is? I don't have a strong opinion about
this, but a slight preference for my current solution.

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
> > +		dev_err_ratelimited(&hx->client->dev, "failed to handle events: %d\n", error);
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
> 
> With negative return values of device_property_count_u32() squashed in this
> way, there is no way to warn the developer that the array is invalid. The
> error message associated with device_property_read_u32_array() below is
> essentially dead code, because the latter is a wrapper around the former,
> and any syntax error that causes one to fail will cause the other to fail.
> 
> Since device_property_count_u32() returns -EINVAL in case of a missing array,
> we can do the following. Note there is no need to explicitly set hx->keycount
> to zero in case no keys are specified, since the hx structure is correctly
> allocated using devm_kzalloc().
> 
> 	int count;
> 
> 	count = device_property_count_u32(...);
> 	if (count == -EINVAL) {
> 		return 0;
> 	} else if (count < 0) {
> 		dev_err(...);
> 		return count;
> 	} else if (count > HX852X_MAX_KEY_COUNT) {
> 		dev_err(...);
> 		return -EINVAL;
> 	}
> 
> 	hx->keycount = count;
> 
> 	error = device_property_read_u32_array(...);
> 	if (error)
> 		dev_err(...);
> 
> 	return error;
> 

Ah right, thanks for spotting this! Will use this in v3.

> > +
> > +	if (hx->keycount > HX852X_MAX_KEY_COUNT) {
> > +		dev_err(dev, "max supported keys: %u, found: %u\n",
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
> > +		dev_err(dev, "not all required i2c functionality supported\n");
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
> > +	if (error)
> > +		return dev_err_probe(dev, error, "failed to get regulators\n");
> > +
> > +	hx->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(hx->reset_gpiod))
> > +		return dev_err_probe(dev, PTR_ERR(hx->reset_gpiod),
> > +				     "failed to get reset gpio\n");
> > +
> > +	error = devm_request_threaded_irq(dev, client->irq, NULL, hx852x_interrupt,
> > +					  IRQF_ONESHOT | IRQF_NO_AUTOEN, NULL, hx);
> > +	if (error)
> > +		return dev_err_probe(dev, error, "failed to request irq %d", client->irq);
> > +
> > +	error = hx852x_read_config(hx);
> > +	if (error)
> > +		return error;
> > +
> > +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_X);
> > +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_Y);
> > +	input_set_abs_params(hx->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> > +
> > +	touchscreen_parse_properties(hx->input_dev, true, &hx->props);
> > +	error = hx852x_parse_properties(hx);
> > +	if (error)
> > +		return error;
> > +
> > +	hx->input_dev->keycode = hx->keycodes;
> > +	hx->input_dev->keycodemax = hx->keycount;
> > +	hx->input_dev->keycodesize = sizeof(hx->keycodes[0]);
> > +	for (i = 0; i < hx->keycount; i++)
> > +		input_set_capability(hx->input_dev, EV_KEY, hx->keycodes[i]);
> > +
> > +	error = input_mt_init_slots(hx->input_dev, hx->max_fingers,
> > +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> > +	if (error)
> > +		return dev_err_probe(dev, error, "failed to init MT slots\n");
> > +
> > +	error = input_register_device(hx->input_dev);
> > +	if (error)
> > +		return dev_err_probe(dev, error, "failed to register input device\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int hx852x_suspend(struct device *dev)
> > +{
> > +	struct hx852x *hx = dev_get_drvdata(dev);
> 
> 	int error = 0;
> 
> > +
> > +	mutex_lock(&hx->input_dev->mutex);
> > +	if (input_device_enabled(hx->input_dev))
> > +		hx852x_stop(hx);
> 
> 		error = hx852x_stop(...);
> 
> > +	mutex_unlock(&hx->input_dev->mutex);
> > +
> > +	return 0;
> 
> 	return error;
> 

Oops. I meant to change this in v2 but forgot it apparently.
Will fix fix this in v3 as well!

I'll wait for your reply regarding the error handling in
hx852x_read_config(), in case you have a strong opinion about that. :)

Thanks!
Stephan
