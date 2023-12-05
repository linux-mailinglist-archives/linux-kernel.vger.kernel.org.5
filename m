Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C116B804A86
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbjLEGpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjLEGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:45:35 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65003FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:45:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAPBQ-00018I-Tp; Tue, 05 Dec 2023 07:45:28 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1rAPBP-00DgU8-Ok; Tue, 05 Dec 2023 07:45:27 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAPBP-005LHf-LT; Tue, 05 Dec 2023 07:45:27 +0100
Date:   Tue, 5 Dec 2023 07:45:27 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231205064527.GJ981228@pengutronix.de>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
 <20231204225956.GG981228@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231204225956.GG981228@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC regulator devs here too.

On Mon, Dec 04, 2023 at 11:59:56PM +0100, Oleksij Rempel wrote:
> On Fri, Dec 01, 2023 at 06:10:30PM +0100, Kory Maincent wrote:
> > Add a new driver for the PD692x0 I2C Power Sourcing Equipment controller.
> > This driver only support i2c communication for now.
> > 
> > Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> > 
> > This driver is based on the patch merged in an immutable branch from Jakub
> > repo. It is Tagged at:
> > git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git firmware_loader-add-upload-error
> > 
> > Change in v2:
> > - Drop of_match_ptr
> > - Follow the "c33" PoE prefix naming change.
> > - Remove unused delay_recv variable. Then, remove struct pd692x0_msg_content
> >   which is similar to struct pd692x0_msg.
> > - Fix a weird sleep loop.
> > - Improve pd692x0_recv_msg for better readability.
> > - Fix a warning reported by Simon on a pd692x0_fw_write_line call.
> > ---
> >  MAINTAINERS                  |    1 +
> >  drivers/net/pse-pd/Kconfig   |   11 +
> >  drivers/net/pse-pd/Makefile  |    1 +
> >  drivers/net/pse-pd/pd692x0.c | 1025 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 1038 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b746684f3fd3..3cbafca0cdf4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14240,6 +14240,7 @@ M:	Kory Maincent <kory.maincent@bootlin.com>
> >  L:	netdev@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> > +F:	drivers/net/pse-pd/pd692x0.c
> >  
> >  MICROCHIP POLARFIRE FPGA DRIVERS
> >  M:	Conor Dooley <conor.dooley@microchip.com>
> > diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
> > index 687dec49c1e1..e3a6ba669f20 100644
> > --- a/drivers/net/pse-pd/Kconfig
> > +++ b/drivers/net/pse-pd/Kconfig
> > @@ -20,4 +20,15 @@ config PSE_REGULATOR
> >  	  Sourcing Equipment without automatic classification support. For
> >  	  example for basic implementation of PoDL (802.3bu) specification.
> >  
> > +config PSE_PD692X0
> > +	tristate "PD692X0 PSE controller"
> > +	depends on I2C
> > +	select FW_UPLOAD
> > +	help
> > +	  This module provides support for PD692x0 regulator based Ethernet
> > +	  Power Sourcing Equipment.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called pd692x0.
> > +
> >  endif
> > diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
> > index 1b8aa4c70f0b..9c12c4a65730 100644
> > --- a/drivers/net/pse-pd/Makefile
> > +++ b/drivers/net/pse-pd/Makefile
> > @@ -4,3 +4,4 @@
> >  obj-$(CONFIG_PSE_CONTROLLER) += pse_core.o
> >  
> >  obj-$(CONFIG_PSE_REGULATOR) += pse_regulator.o
> > +obj-$(CONFIG_PSE_PD692X0) += pd692x0.o
> > diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> > new file mode 100644
> > index 000000000000..6d921dfcfb07
> > --- /dev/null
> > +++ b/drivers/net/pse-pd/pd692x0.c
> > @@ -0,0 +1,1025 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Driver for the Microchip PD692X0 PoE PSE Controller driver (I2C bus)
> > + *
> > + * Copyright (c) 2023 Bootlin, Kory Maincent <kory.maincent@bootlin.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pse-pd/pse.h>
> > +#include <linux/i2c.h>
> > +#include <linux/delay.h>
> > +#include <linux/firmware.h>
> > +
> > +#define PD692X0_PSE_NAME "pd692x0_pse"
> > +
> > +#define PD692X0_MAX_LOGICAL_PORTS	48
> > +#define PD692X0_MAX_HW_PORTS	96
> > +
> > +#define PD69200_BT_PROD_VER	24
> > +#define PD69210_BT_PROD_VER	26
> > +#define PD69220_BT_PROD_VER	29
> > +
> > +#define PD692X0_FW_MAJ_VER	3
> > +#define PD692X0_FW_MIN_VER	5
> > +#define PD692X0_FW_PATCH_VER	5
> > +
> > +enum pd692x0_fw_state {
> > +	PD692X0_FW_UNKNOWN,
> > +	PD692X0_FW_OK,
> > +	PD692X0_FW_BROKEN,
> > +	PD692X0_FW_NEED_UPDATE,
> > +	PD692X0_FW_PREPARE,
> > +	PD692X0_FW_WRITE,
> > +	PD692X0_FW_COMPLETE,
> > +};
> > +
> > +struct pd692x0_msg {
> > +	u8 key;
> > +	u8 echo;
> > +	u8 sub[3];
> > +	u8 data[8];
> > +	__be16 chksum;
> > +} __packed;
> > +
> > +struct pd692x0_msg_ver {
> > +	u8 prod;
> > +	u8 maj_sw_ver;
> > +	u8 min_sw_ver;
> > +	u8 pa_sw_ver;
> > +	u8 param;
> > +	u8 build;
> > +};
> > +
> > +enum {
> > +	PD692X0_KEY_CMD,
> > +	PD692X0_KEY_PRG,
> > +	PD692X0_KEY_REQ,
> > +	PD692X0_KEY_TLM,
> > +	PD692X0_KEY_TEST,
> > +	PD692X0_KEY_REPORT = 0x52
> > +};
> > +
> > +enum {
> > +	PD692X0_MSG_RESET,
> > +	PD692X0_MSG_GET_SW_VER,
> > +	PD692X0_MSG_SET_TMP_PORT_MATRIX,
> > +	PD692X0_MSG_PRG_PORT_MATRIX,
> > +	PD692X0_MSG_SET_PORT_PARAM,
> > +	PD692X0_MSG_GET_PORT_STATUS,
> > +	PD692X0_MSG_DOWNLOAD_CMD,
> > +
> > +	/* add new message above here */
> > +	PD692X0_MSG_CNT
> > +};
> > +
> > +struct pd692x0_priv {
> > +	struct i2c_client *client;
> > +	struct pse_controller_dev pcdev;
> > +
> > +	enum pd692x0_fw_state fw_state;
> > +	struct fw_upload *fwl;
> > +	bool cancel_request;
> > +
> > +	u8 msg_id;
> > +	bool last_cmd_key;
> > +	unsigned long last_cmd_key_time;
> > +
> > +	enum ethtool_c33_pse_admin_state admin_state[PD692X0_MAX_LOGICAL_PORTS];
> > +};
> > +
> > +/* Template list of communication messages. The non-null bytes defined here
> > + * constitute the fixed portion of the messages. The remaining bytes will
> > + * be configured later within the functions. Refer to the "PD692x0 BT Serial
> > + * Communication Protocol User Guide" for comprehensive details on messages
> > + * content.
> > + */
> > +static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
> > +	[PD692X0_MSG_RESET] = {
> > +		.key = PD692X0_KEY_CMD,
> > +		.sub = {0x07, 0x55, 0x00},
> > +		.data = {0x55, 0x00, 0x55, 0x4e,
> > +			 0x4e, 0x4e, 0x4e, 0x4e},
> > +	},
> > +	[PD692X0_MSG_GET_SW_VER] = {
> > +		.key = PD692X0_KEY_REQ,
> > +		.sub = {0x07, 0x1e, 0x21},
> > +		.data = {0x4e, 0x4e, 0x4e, 0x4e,
> > +			 0x4e, 0x4e, 0x4e, 0x4e},
> > +	},
> > +	[PD692X0_MSG_SET_TMP_PORT_MATRIX] = {
> > +		.key = PD692X0_KEY_CMD,
> > +		.sub	 = {0x05, 0x43},
> > +		.data = {   0, 0x4e, 0x4e, 0x4e,
> > +			 0x4e, 0x4e, 0x4e, 0x4e},
> > +	},
> > +	[PD692X0_MSG_PRG_PORT_MATRIX] = {
> > +		.key = PD692X0_KEY_CMD,
> > +		.sub = {0x07, 0x43, 0x4e},
> > +		.data = {0x4e, 0x4e, 0x4e, 0x4e,
> > +			 0x4e, 0x4e, 0x4e, 0x4e},
> > +	},
> > +	[PD692X0_MSG_SET_PORT_PARAM] = {
> > +		.key = PD692X0_KEY_CMD,
> > +		.sub = {0x05, 0xc0},
> > +		.data = {   0, 0xff, 0xff, 0xff,
> > +			 0x4e, 0x4e, 0x4e, 0x4e},
> > +	},
> > +	[PD692X0_MSG_GET_PORT_STATUS] = {
> > +		.key = PD692X0_KEY_REQ,
> > +		.sub = {0x05, 0xc1},
> > +		.data = {0x4e, 0x4e, 0x4e, 0x4e,
> > +			 0x4e, 0x4e, 0x4e, 0x4e},
> > +	},
> > +	[PD692X0_MSG_DOWNLOAD_CMD] = {
> > +		.key = PD692X0_KEY_PRG,
> > +		.sub = {0xff, 0x99, 0x15},
> > +		.data = {0x16, 0x16, 0x99, 0x4e,
> > +			 0x4e, 0x4e, 0x4e, 0x4e},
> > +	},
> > +};
> > +
> > +static u8 pd692x0_build_msg(struct pd692x0_msg *msg, u8 echo)
> > +{
> > +	u8 *data = (u8 *)msg;
> > +	u16 chksum = 0;
> > +	int i;
> > +
> > +	msg->echo = echo++;
> > +	if (echo == 0xff)
> > +		echo = 0;
> > +
> > +	for (i = 0; i < sizeof(*msg) - sizeof(msg->chksum); i++)
> > +		chksum += data[i];
> > +
> > +	msg->chksum = cpu_to_be16(chksum);
> > +
> > +	return echo;
> > +}
> > +
> > +static int pd692x0_send_msg(struct pd692x0_priv *priv, struct pd692x0_msg *msg)
> > +{
> > +	const struct i2c_client *client = priv->client;
> > +	int ret;
> > +
> > +	if (msg->key == PD692X0_KEY_CMD && priv->last_cmd_key) {
> > +		int cmd_msleep;
> > +
> > +		cmd_msleep = 30 - jiffies_to_msecs(jiffies - priv->last_cmd_key_time);
> > +		if (cmd_msleep > 0)
> > +			msleep(cmd_msleep);
> > +	}
> > +
> > +	/* Add echo and checksum bytes to the message */
> > +	priv->msg_id = pd692x0_build_msg(msg, priv->msg_id);
> > +
> > +	ret = i2c_master_send(client, (u8 *)msg, sizeof(*msg));
> > +	if (ret != sizeof(*msg))
> > +		return -EIO;
> 
> This overwrites initial error message returned by the i2c_master_send().
> 		return ret < 0 ? ret : -EIO;
> 
> > +	return 0;
> > +}
> > +
> > +static int pd692x0_reset(struct pd692x0_priv *priv)
> > +{
> > +	const struct i2c_client *client = priv->client;
> > +	struct pd692x0_msg msg, buf = {0};
> > +	int ret;
> > +
> > +	msg = pd692x0_msg_template_list[PD692X0_MSG_RESET];
> > +	ret = pd692x0_send_msg(priv, &msg);
> > +	if (ret) {
> > +		dev_err(&client->dev,
> > +			"Failed to reset the controller (%pe)\n", ERR_PTR(ret));
> > +		return ret;
> > +	}
> > +
> > +	msleep(30);
> > +
> > +	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
> > +	if (ret != sizeof(buf))
> > +		return ret < 0 ? ret : -EIO;
> > +
> > +	/* Is the reply a successful report message */
> > +	if (buf.key != PD692X0_KEY_REPORT || buf.sub[0] || buf.sub[1])
> > +		return -EIO;
> > +
> > +	msleep(300);
> > +
> > +	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
> > +	if (ret != sizeof(buf))
> > +		return ret < 0 ? ret : -EIO;
> > +
> > +	/* Is the boot status without error */
> > +	if (buf.key != 0x03 || buf.echo != 0xff || buf.sub[0] & 0x1) {
> > +		dev_err(&client->dev, "PSE controller error\n");
> 
> May be better to have here a bit more verbose error message. For example
> print values which we actually got?
> 
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int pd692x0_try_recv_msg(const struct i2c_client *client,
> > +				struct pd692x0_msg *msg,
> > +				struct pd692x0_msg *buf)
> > +{
> > +	msleep(30);
> 
> It would be good to have some comments on sleeps. For example is it
> based on documentation or on testing. It is related to all seeps in this
> driver.
> 
> > +
> > +	memset(buf, 0, sizeof(*buf));
> > +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
> 
> i2c level errors are ignored.
> 
> > +	if (buf->key)
> > +		return 1;
> > +
> > +	msleep(100);
> > +
> > +	memset(buf, 0, sizeof(*buf));
> > +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
> 
> same here. i2c level errors are ignored.
> 
> > +	if (buf->key)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +/* Implementation of I2C communication, specifically addressing scenarios
> > + * involving communication loss. Refer to the "Synchronization During
> > + * Communication Loss" section in the Communication Protocol document for
> > + * further details.
> > + */
> > +static int pd692x0_recv_msg(struct pd692x0_priv *priv,
> > +			    struct pd692x0_msg *msg,
> > +			    struct pd692x0_msg *buf)
> > +{
> > +	const struct i2c_client *client = priv->client;
> > +	int ret;
> > +
> > +	ret = pd692x0_try_recv_msg(client, msg, buf);
> > +	if (ret)
> > +		goto out_success;
> > +
> > +	dev_warn(&client->dev,
> > +		 "Communication lost, rtnl is locked until communication is back!");
> > +
> > +	ret = pd692x0_send_msg(priv, msg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pd692x0_try_recv_msg(client, msg, buf);
> > +	if (ret)
> > +		goto out_success;
> > +
> > +	msleep(10000);
> > +
> > +	ret = pd692x0_send_msg(priv, msg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pd692x0_try_recv_msg(client, msg, buf);
> > +	if (ret)
> > +		goto out_success;
> > +
> > +	return pd692x0_reset(priv);
> > +
> > +out_success:
> > +	if (msg->key == PD692X0_KEY_CMD) {
> > +		priv->last_cmd_key = true;
> > +		priv->last_cmd_key_time = jiffies;
> > +	} else {
> > +		priv->last_cmd_key = false;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int pd692x0_sendrecv_msg(struct pd692x0_priv *priv,
> > +				struct pd692x0_msg *msg,
> > +				struct pd692x0_msg *buf)
> > +{
> > +	struct device *dev = &priv->client->dev;
> > +	int ret;
> > +
> > +	ret = pd692x0_send_msg(priv, msg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pd692x0_recv_msg(priv, msg, buf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (msg->echo != buf->echo) {
> > +		dev_err(dev, "Wrong match in message ID\n");
> > +		return -EIO;
> > +	}
> > +
> > +	/* If the reply is a report message is it successful */
> > +	if (buf->key == PD692X0_KEY_REPORT &&
> > +	    (buf->sub[0] || buf->sub[1])) {
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct pd692x0_priv *to_pd692x0_priv(struct pse_controller_dev *pcdev)
> > +{
> > +	return container_of(pcdev, struct pd692x0_priv, pcdev);
> > +}
> > +
> > +static int pd692x0_fw_unavailable(struct pd692x0_priv *priv)
> > +{
> > +	switch (priv->fw_state) {
> > +	case PD692X0_FW_OK:
> > +		return 0;
> > +	case PD692X0_FW_PREPARE:
> > +	case PD692X0_FW_WRITE:
> > +	case PD692X0_FW_COMPLETE:
> > +		dev_err(&priv->client->dev, "Firmware update in progress!\n");
> > +		return -EBUSY;
> > +	case PD692X0_FW_BROKEN:
> > +	case PD692X0_FW_NEED_UPDATE:
> > +	default:
> > +		dev_err(&priv->client->dev,
> > +			"Firmware issue. Please update it!\n");
> 
> It will be better to export this messages to the user space with
> NL_SET_ERR_MSG().
> 
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int pd692x0_ethtool_set_config(struct pse_controller_dev *pcdev,
> > +				      unsigned long id,
> > +				      struct netlink_ext_ack *extack,
> > +				      const struct pse_control_config *config)
> > +{
> > +	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
> > +	struct pd692x0_msg msg, buf = {0};
> > +	int ret;
> > +
> > +	ret = pd692x0_fw_unavailable(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (priv->admin_state[id] == config->c33_admin_control)
> > +		return 0;
> > +
> > +	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
> > +	switch (config->c33_admin_control) {
> > +	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
> > +		msg.data[0] = 0x1;
> > +		break;
> > +	case ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED:
> > +		msg.data[0] = 0x0;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	msg.sub[2] = id;
> > +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	priv->admin_state[id] = config->c33_admin_control;
> > +
> > +	return 0;
> > +}
> > +
> > +static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
> > +				      unsigned long id,
> > +				      struct netlink_ext_ack *extack,
> > +				      struct pse_control_status *status)
> > +{
> > +	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
> > +	struct pd692x0_msg msg, buf = {0};
> > +	int ret;
> > +
> > +	ret = pd692x0_fw_unavailable(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_STATUS];
> > +	msg.sub[2] = id;
> > +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Compare Port Status (Communication Protocol Document par. 7.1) */
> > +	if ((buf.sub[0] & 0xf0) == 0x80 || (buf.sub[0] & 0xf0) == 0x90)
> > +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
> > +	else if (buf.sub[0] == 0x1b || buf.sub[0] == 0x22)
> > +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING;
> > +	else if (buf.sub[0] == 0x12)
> > +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_FAULT;
> > +	else
> > +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
> > +
> > +	if (buf.sub[1])
> > +		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
> > +	else
> > +		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
> > +
> > +	priv->admin_state[id] = status->c33_admin_state;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct pd692x0_msg_ver pd692x0_get_sw_version(struct pd692x0_priv *priv)
> > +{
> > +	struct device *dev = &priv->client->dev;
> > +	struct pd692x0_msg msg, buf = {0};
> > +	struct pd692x0_msg_ver ver = {0};
> > +	int ret;
> > +
> > +	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_SW_VER];
> > +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to get PSE version (%pe)\n", ERR_PTR(ret));
> > +		return ver;
> > +	}
> > +
> > +	/* Extract version from the message */
> > +	ver.prod = buf.sub[2];
> > +	ver.maj_sw_ver = (buf.data[0] << 8 | buf.data[1]) / 100;
> > +	ver.min_sw_ver = ((buf.data[0] << 8 | buf.data[1]) / 10) % 10;
> > +	ver.pa_sw_ver = (buf.data[0] << 8 | buf.data[1]) % 10;
> > +	ver.param = buf.data[2];
> > +	ver.build = buf.data[3];
> > +
> > +	return ver;
> > +}
> > +
> > +static const struct pse_controller_ops pd692x0_ops = {
> > +	.ethtool_get_status = pd692x0_ethtool_get_status,
> > +	.ethtool_set_config = pd692x0_ethtool_set_config,
> > +};
> > +
> > +struct matrix {
> > +	u8 hw_port_a;
> > +	u8 hw_port_b;
> > +};
> > +
> > +static int
> > +pd692x0_set_ports_matrix(struct pd692x0_priv *priv,
> > +			 const struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS])
> > +{
> > +	struct pd692x0_msg msg, buf;
> > +	int ret, i;

I assume port-matrix should be completely reworked as I suggested in the
DT review. Except of the topology, each port seems to be a regulator.
Even if we do not have direct influence on each regulator state, we have
information about current state of them and will be able to represent regulator
three to get more diagnostic information.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
