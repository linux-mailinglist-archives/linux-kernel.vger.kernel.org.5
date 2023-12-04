Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F202B804232
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjLDXA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjLDXAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:00:23 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2D3C4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:00:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAHuw-00005c-Nb; Mon, 04 Dec 2023 23:59:58 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1rAHuu-00Dc33-RE; Mon, 04 Dec 2023 23:59:56 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAHuu-005IRG-O7; Mon, 04 Dec 2023 23:59:56 +0100
Date:   Mon, 4 Dec 2023 23:59:56 +0100
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
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231204225956.GG981228@pengutronix.de>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 06:10:30PM +0100, Kory Maincent wrote:
> Add a new driver for the PD692x0 I2C Power Sourcing Equipment controller.
> This driver only support i2c communication for now.
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> This driver is based on the patch merged in an immutable branch from Jakub
> repo. It is Tagged at:
> git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git firmware_loader-add-upload-error
> 
> Change in v2:
> - Drop of_match_ptr
> - Follow the "c33" PoE prefix naming change.
> - Remove unused delay_recv variable. Then, remove struct pd692x0_msg_content
>   which is similar to struct pd692x0_msg.
> - Fix a weird sleep loop.
> - Improve pd692x0_recv_msg for better readability.
> - Fix a warning reported by Simon on a pd692x0_fw_write_line call.
> ---
>  MAINTAINERS                  |    1 +
>  drivers/net/pse-pd/Kconfig   |   11 +
>  drivers/net/pse-pd/Makefile  |    1 +
>  drivers/net/pse-pd/pd692x0.c | 1025 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1038 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b746684f3fd3..3cbafca0cdf4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14240,6 +14240,7 @@ M:	Kory Maincent <kory.maincent@bootlin.com>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> +F:	drivers/net/pse-pd/pd692x0.c
>  
>  MICROCHIP POLARFIRE FPGA DRIVERS
>  M:	Conor Dooley <conor.dooley@microchip.com>
> diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
> index 687dec49c1e1..e3a6ba669f20 100644
> --- a/drivers/net/pse-pd/Kconfig
> +++ b/drivers/net/pse-pd/Kconfig
> @@ -20,4 +20,15 @@ config PSE_REGULATOR
>  	  Sourcing Equipment without automatic classification support. For
>  	  example for basic implementation of PoDL (802.3bu) specification.
>  
> +config PSE_PD692X0
> +	tristate "PD692X0 PSE controller"
> +	depends on I2C
> +	select FW_UPLOAD
> +	help
> +	  This module provides support for PD692x0 regulator based Ethernet
> +	  Power Sourcing Equipment.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called pd692x0.
> +
>  endif
> diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
> index 1b8aa4c70f0b..9c12c4a65730 100644
> --- a/drivers/net/pse-pd/Makefile
> +++ b/drivers/net/pse-pd/Makefile
> @@ -4,3 +4,4 @@
>  obj-$(CONFIG_PSE_CONTROLLER) += pse_core.o
>  
>  obj-$(CONFIG_PSE_REGULATOR) += pse_regulator.o
> +obj-$(CONFIG_PSE_PD692X0) += pd692x0.o
> diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> new file mode 100644
> index 000000000000..6d921dfcfb07
> --- /dev/null
> +++ b/drivers/net/pse-pd/pd692x0.c
> @@ -0,0 +1,1025 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for the Microchip PD692X0 PoE PSE Controller driver (I2C bus)
> + *
> + * Copyright (c) 2023 Bootlin, Kory Maincent <kory.maincent@bootlin.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pse-pd/pse.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +
> +#define PD692X0_PSE_NAME "pd692x0_pse"
> +
> +#define PD692X0_MAX_LOGICAL_PORTS	48
> +#define PD692X0_MAX_HW_PORTS	96
> +
> +#define PD69200_BT_PROD_VER	24
> +#define PD69210_BT_PROD_VER	26
> +#define PD69220_BT_PROD_VER	29
> +
> +#define PD692X0_FW_MAJ_VER	3
> +#define PD692X0_FW_MIN_VER	5
> +#define PD692X0_FW_PATCH_VER	5
> +
> +enum pd692x0_fw_state {
> +	PD692X0_FW_UNKNOWN,
> +	PD692X0_FW_OK,
> +	PD692X0_FW_BROKEN,
> +	PD692X0_FW_NEED_UPDATE,
> +	PD692X0_FW_PREPARE,
> +	PD692X0_FW_WRITE,
> +	PD692X0_FW_COMPLETE,
> +};
> +
> +struct pd692x0_msg {
> +	u8 key;
> +	u8 echo;
> +	u8 sub[3];
> +	u8 data[8];
> +	__be16 chksum;
> +} __packed;
> +
> +struct pd692x0_msg_ver {
> +	u8 prod;
> +	u8 maj_sw_ver;
> +	u8 min_sw_ver;
> +	u8 pa_sw_ver;
> +	u8 param;
> +	u8 build;
> +};
> +
> +enum {
> +	PD692X0_KEY_CMD,
> +	PD692X0_KEY_PRG,
> +	PD692X0_KEY_REQ,
> +	PD692X0_KEY_TLM,
> +	PD692X0_KEY_TEST,
> +	PD692X0_KEY_REPORT = 0x52
> +};
> +
> +enum {
> +	PD692X0_MSG_RESET,
> +	PD692X0_MSG_GET_SW_VER,
> +	PD692X0_MSG_SET_TMP_PORT_MATRIX,
> +	PD692X0_MSG_PRG_PORT_MATRIX,
> +	PD692X0_MSG_SET_PORT_PARAM,
> +	PD692X0_MSG_GET_PORT_STATUS,
> +	PD692X0_MSG_DOWNLOAD_CMD,
> +
> +	/* add new message above here */
> +	PD692X0_MSG_CNT
> +};
> +
> +struct pd692x0_priv {
> +	struct i2c_client *client;
> +	struct pse_controller_dev pcdev;
> +
> +	enum pd692x0_fw_state fw_state;
> +	struct fw_upload *fwl;
> +	bool cancel_request;
> +
> +	u8 msg_id;
> +	bool last_cmd_key;
> +	unsigned long last_cmd_key_time;
> +
> +	enum ethtool_c33_pse_admin_state admin_state[PD692X0_MAX_LOGICAL_PORTS];
> +};
> +
> +/* Template list of communication messages. The non-null bytes defined here
> + * constitute the fixed portion of the messages. The remaining bytes will
> + * be configured later within the functions. Refer to the "PD692x0 BT Serial
> + * Communication Protocol User Guide" for comprehensive details on messages
> + * content.
> + */
> +static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
> +	[PD692X0_MSG_RESET] = {
> +		.key = PD692X0_KEY_CMD,
> +		.sub = {0x07, 0x55, 0x00},
> +		.data = {0x55, 0x00, 0x55, 0x4e,
> +			 0x4e, 0x4e, 0x4e, 0x4e},
> +	},
> +	[PD692X0_MSG_GET_SW_VER] = {
> +		.key = PD692X0_KEY_REQ,
> +		.sub = {0x07, 0x1e, 0x21},
> +		.data = {0x4e, 0x4e, 0x4e, 0x4e,
> +			 0x4e, 0x4e, 0x4e, 0x4e},
> +	},
> +	[PD692X0_MSG_SET_TMP_PORT_MATRIX] = {
> +		.key = PD692X0_KEY_CMD,
> +		.sub	 = {0x05, 0x43},
> +		.data = {   0, 0x4e, 0x4e, 0x4e,
> +			 0x4e, 0x4e, 0x4e, 0x4e},
> +	},
> +	[PD692X0_MSG_PRG_PORT_MATRIX] = {
> +		.key = PD692X0_KEY_CMD,
> +		.sub = {0x07, 0x43, 0x4e},
> +		.data = {0x4e, 0x4e, 0x4e, 0x4e,
> +			 0x4e, 0x4e, 0x4e, 0x4e},
> +	},
> +	[PD692X0_MSG_SET_PORT_PARAM] = {
> +		.key = PD692X0_KEY_CMD,
> +		.sub = {0x05, 0xc0},
> +		.data = {   0, 0xff, 0xff, 0xff,
> +			 0x4e, 0x4e, 0x4e, 0x4e},
> +	},
> +	[PD692X0_MSG_GET_PORT_STATUS] = {
> +		.key = PD692X0_KEY_REQ,
> +		.sub = {0x05, 0xc1},
> +		.data = {0x4e, 0x4e, 0x4e, 0x4e,
> +			 0x4e, 0x4e, 0x4e, 0x4e},
> +	},
> +	[PD692X0_MSG_DOWNLOAD_CMD] = {
> +		.key = PD692X0_KEY_PRG,
> +		.sub = {0xff, 0x99, 0x15},
> +		.data = {0x16, 0x16, 0x99, 0x4e,
> +			 0x4e, 0x4e, 0x4e, 0x4e},
> +	},
> +};
> +
> +static u8 pd692x0_build_msg(struct pd692x0_msg *msg, u8 echo)
> +{
> +	u8 *data = (u8 *)msg;
> +	u16 chksum = 0;
> +	int i;
> +
> +	msg->echo = echo++;
> +	if (echo == 0xff)
> +		echo = 0;
> +
> +	for (i = 0; i < sizeof(*msg) - sizeof(msg->chksum); i++)
> +		chksum += data[i];
> +
> +	msg->chksum = cpu_to_be16(chksum);
> +
> +	return echo;
> +}
> +
> +static int pd692x0_send_msg(struct pd692x0_priv *priv, struct pd692x0_msg *msg)
> +{
> +	const struct i2c_client *client = priv->client;
> +	int ret;
> +
> +	if (msg->key == PD692X0_KEY_CMD && priv->last_cmd_key) {
> +		int cmd_msleep;
> +
> +		cmd_msleep = 30 - jiffies_to_msecs(jiffies - priv->last_cmd_key_time);
> +		if (cmd_msleep > 0)
> +			msleep(cmd_msleep);
> +	}
> +
> +	/* Add echo and checksum bytes to the message */
> +	priv->msg_id = pd692x0_build_msg(msg, priv->msg_id);
> +
> +	ret = i2c_master_send(client, (u8 *)msg, sizeof(*msg));
> +	if (ret != sizeof(*msg))
> +		return -EIO;

This overwrites initial error message returned by the i2c_master_send().
		return ret < 0 ? ret : -EIO;

> +	return 0;
> +}
> +
> +static int pd692x0_reset(struct pd692x0_priv *priv)
> +{
> +	const struct i2c_client *client = priv->client;
> +	struct pd692x0_msg msg, buf = {0};
> +	int ret;
> +
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_RESET];
> +	ret = pd692x0_send_msg(priv, &msg);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"Failed to reset the controller (%pe)\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	msleep(30);
> +
> +	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
> +	if (ret != sizeof(buf))
> +		return ret < 0 ? ret : -EIO;
> +
> +	/* Is the reply a successful report message */
> +	if (buf.key != PD692X0_KEY_REPORT || buf.sub[0] || buf.sub[1])
> +		return -EIO;
> +
> +	msleep(300);
> +
> +	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
> +	if (ret != sizeof(buf))
> +		return ret < 0 ? ret : -EIO;
> +
> +	/* Is the boot status without error */
> +	if (buf.key != 0x03 || buf.echo != 0xff || buf.sub[0] & 0x1) {
> +		dev_err(&client->dev, "PSE controller error\n");

May be better to have here a bit more verbose error message. For example
print values which we actually got?

> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pd692x0_try_recv_msg(const struct i2c_client *client,
> +				struct pd692x0_msg *msg,
> +				struct pd692x0_msg *buf)
> +{
> +	msleep(30);

It would be good to have some comments on sleeps. For example is it
based on documentation or on testing. It is related to all seeps in this
driver.

> +
> +	memset(buf, 0, sizeof(*buf));
> +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));

i2c level errors are ignored.

> +	if (buf->key)
> +		return 1;
> +
> +	msleep(100);
> +
> +	memset(buf, 0, sizeof(*buf));
> +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));

same here. i2c level errors are ignored.

> +	if (buf->key)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/* Implementation of I2C communication, specifically addressing scenarios
> + * involving communication loss. Refer to the "Synchronization During
> + * Communication Loss" section in the Communication Protocol document for
> + * further details.
> + */
> +static int pd692x0_recv_msg(struct pd692x0_priv *priv,
> +			    struct pd692x0_msg *msg,
> +			    struct pd692x0_msg *buf)
> +{
> +	const struct i2c_client *client = priv->client;
> +	int ret;
> +
> +	ret = pd692x0_try_recv_msg(client, msg, buf);
> +	if (ret)
> +		goto out_success;
> +
> +	dev_warn(&client->dev,
> +		 "Communication lost, rtnl is locked until communication is back!");
> +
> +	ret = pd692x0_send_msg(priv, msg);
> +	if (ret)
> +		return ret;
> +
> +	ret = pd692x0_try_recv_msg(client, msg, buf);
> +	if (ret)
> +		goto out_success;
> +
> +	msleep(10000);
> +
> +	ret = pd692x0_send_msg(priv, msg);
> +	if (ret)
> +		return ret;
> +
> +	ret = pd692x0_try_recv_msg(client, msg, buf);
> +	if (ret)
> +		goto out_success;
> +
> +	return pd692x0_reset(priv);
> +
> +out_success:
> +	if (msg->key == PD692X0_KEY_CMD) {
> +		priv->last_cmd_key = true;
> +		priv->last_cmd_key_time = jiffies;
> +	} else {
> +		priv->last_cmd_key = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pd692x0_sendrecv_msg(struct pd692x0_priv *priv,
> +				struct pd692x0_msg *msg,
> +				struct pd692x0_msg *buf)
> +{
> +	struct device *dev = &priv->client->dev;
> +	int ret;
> +
> +	ret = pd692x0_send_msg(priv, msg);
> +	if (ret)
> +		return ret;
> +
> +	ret = pd692x0_recv_msg(priv, msg, buf);
> +	if (ret)
> +		return ret;
> +
> +	if (msg->echo != buf->echo) {
> +		dev_err(dev, "Wrong match in message ID\n");
> +		return -EIO;
> +	}
> +
> +	/* If the reply is a report message is it successful */
> +	if (buf->key == PD692X0_KEY_REPORT &&
> +	    (buf->sub[0] || buf->sub[1])) {
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct pd692x0_priv *to_pd692x0_priv(struct pse_controller_dev *pcdev)
> +{
> +	return container_of(pcdev, struct pd692x0_priv, pcdev);
> +}
> +
> +static int pd692x0_fw_unavailable(struct pd692x0_priv *priv)
> +{
> +	switch (priv->fw_state) {
> +	case PD692X0_FW_OK:
> +		return 0;
> +	case PD692X0_FW_PREPARE:
> +	case PD692X0_FW_WRITE:
> +	case PD692X0_FW_COMPLETE:
> +		dev_err(&priv->client->dev, "Firmware update in progress!\n");
> +		return -EBUSY;
> +	case PD692X0_FW_BROKEN:
> +	case PD692X0_FW_NEED_UPDATE:
> +	default:
> +		dev_err(&priv->client->dev,
> +			"Firmware issue. Please update it!\n");

It will be better to export this messages to the user space with
NL_SET_ERR_MSG().

> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int pd692x0_ethtool_set_config(struct pse_controller_dev *pcdev,
> +				      unsigned long id,
> +				      struct netlink_ext_ack *extack,
> +				      const struct pse_control_config *config)
> +{
> +	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
> +	struct pd692x0_msg msg, buf = {0};
> +	int ret;
> +
> +	ret = pd692x0_fw_unavailable(priv);
> +	if (ret)
> +		return ret;
> +
> +	if (priv->admin_state[id] == config->c33_admin_control)
> +		return 0;
> +
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
> +	switch (config->c33_admin_control) {
> +	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
> +		msg.data[0] = 0x1;
> +		break;
> +	case ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED:
> +		msg.data[0] = 0x0;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	msg.sub[2] = id;
> +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->admin_state[id] = config->c33_admin_control;
> +
> +	return 0;
> +}
> +
> +static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
> +				      unsigned long id,
> +				      struct netlink_ext_ack *extack,
> +				      struct pse_control_status *status)
> +{
> +	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
> +	struct pd692x0_msg msg, buf = {0};
> +	int ret;
> +
> +	ret = pd692x0_fw_unavailable(priv);
> +	if (ret)
> +		return ret;
> +
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_STATUS];
> +	msg.sub[2] = id;
> +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Compare Port Status (Communication Protocol Document par. 7.1) */
> +	if ((buf.sub[0] & 0xf0) == 0x80 || (buf.sub[0] & 0xf0) == 0x90)
> +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
> +	else if (buf.sub[0] == 0x1b || buf.sub[0] == 0x22)
> +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING;
> +	else if (buf.sub[0] == 0x12)
> +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_FAULT;
> +	else
> +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
> +
> +	if (buf.sub[1])
> +		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
> +	else
> +		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
> +
> +	priv->admin_state[id] = status->c33_admin_state;
> +
> +	return 0;
> +}
> +
> +static struct pd692x0_msg_ver pd692x0_get_sw_version(struct pd692x0_priv *priv)
> +{
> +	struct device *dev = &priv->client->dev;
> +	struct pd692x0_msg msg, buf = {0};
> +	struct pd692x0_msg_ver ver = {0};
> +	int ret;
> +
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_SW_VER];
> +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get PSE version (%pe)\n", ERR_PTR(ret));
> +		return ver;
> +	}
> +
> +	/* Extract version from the message */
> +	ver.prod = buf.sub[2];
> +	ver.maj_sw_ver = (buf.data[0] << 8 | buf.data[1]) / 100;
> +	ver.min_sw_ver = ((buf.data[0] << 8 | buf.data[1]) / 10) % 10;
> +	ver.pa_sw_ver = (buf.data[0] << 8 | buf.data[1]) % 10;
> +	ver.param = buf.data[2];
> +	ver.build = buf.data[3];
> +
> +	return ver;
> +}
> +
> +static const struct pse_controller_ops pd692x0_ops = {
> +	.ethtool_get_status = pd692x0_ethtool_get_status,
> +	.ethtool_set_config = pd692x0_ethtool_set_config,
> +};
> +
> +struct matrix {
> +	u8 hw_port_a;
> +	u8 hw_port_b;
> +};
> +
> +static int
> +pd692x0_set_ports_matrix(struct pd692x0_priv *priv,
> +			 const struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS])
> +{
> +	struct pd692x0_msg msg, buf;
> +	int ret, i;
> +
> +	/* Write temporary Matrix */
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_TMP_PORT_MATRIX];
> +	for (i = 0; i < PD692X0_MAX_LOGICAL_PORTS; i++) {
> +		msg.sub[2] = i;
> +		msg.data[0] = port_matrix[i].hw_port_a;
> +		msg.data[1] = port_matrix[i].hw_port_b;
> +
> +		ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Program Matrix */
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_PRG_PORT_MATRIX];
> +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int
> +pd692x0_get_of_matrix(struct device *dev,
> +		      struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS])
> +{
> +	u32 val[PD692X0_MAX_LOGICAL_PORTS * 3];
> +	int ret, i, ports_matrix_size;
> +
> +	ports_matrix_size = device_property_count_u32(dev, "ports-matrix");
> +	if (ports_matrix_size <= 0)
> +		return -EINVAL;
> +	if (ports_matrix_size % 3 ||
> +	    ports_matrix_size > PD692X0_MAX_LOGICAL_PORTS * 3) {
> +		dev_err(dev, "Not valid ports-matrix property size: %d\n",
> +			ports_matrix_size);
> +		return -EINVAL;
> +	}
> +
> +	ret = device_property_read_u32_array(dev, "ports-matrix", val,
> +					     ports_matrix_size);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Init Matrix */
> +	for (i = 0; i < PD692X0_MAX_LOGICAL_PORTS; i++) {
> +		port_matrix[i].hw_port_a = 0xff;
> +		port_matrix[i].hw_port_b = 0xff;
> +	}
> +
> +	/* Update with values from DT */
> +	for (i = 0; i < ports_matrix_size; i += 3) {
> +		unsigned int logical_port;
> +
> +		if (val[i] >= PD692X0_MAX_LOGICAL_PORTS) {
> +			dev_err(dev, "Not valid ports-matrix property\n");
> +			return -EINVAL;
> +		}
> +		logical_port = val[i];
> +
> +		if (val[i + 1] < PD692X0_MAX_HW_PORTS)
> +			port_matrix[logical_port].hw_port_a = val[i + 1];
> +
> +		if (val[i + 2] < PD692X0_MAX_HW_PORTS)
> +			port_matrix[logical_port].hw_port_b = val[i + 2];
> +	}
> +
> +	return 0;
> +}
> +
> +static int pd692x0_update_matrix(struct pd692x0_priv *priv)
> +{
> +	struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS];
> +	struct device *dev = &priv->client->dev;
> +	int ret;
> +
> +	ret = pd692x0_get_of_matrix(dev, port_matrix);
> +	if (ret < 0) {
> +		dev_warn(dev,
> +			 "Unable to parse port-matrix, saved matrix will be used\n");
> +		return 0;
> +	}
> +
> +	ret = pd692x0_set_ports_matrix(priv, port_matrix);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +#define PD692X0_FW_LINE_MAX_SZ 0xff
> +static int pd692x0_fw_get_next_line(const u8 *data,
> +				    char *line, size_t size)
> +{
> +	size_t line_size;
> +	int i;
> +
> +	line_size = min_t(size_t, size, (size_t)PD692X0_FW_LINE_MAX_SZ);
> +
> +	memset(line, 0, PD692X0_FW_LINE_MAX_SZ);
> +	for (i = 0; i < line_size - 1; i++) {
> +		if (*data == '\r' && *(data + 1) == '\n') {
> +			line[i] = '\r';
> +			line[i + 1] = '\n';
> +			return i + 2;
> +		}
> +		line[i] = *data;
> +		data++;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum fw_upload_err
> +pd692x0_fw_recv_resp(const struct i2c_client *client, unsigned long ms_timeout,
> +		     const char *msg_ok, unsigned int msg_size)
> +{
> +	/* Maximum controller response size */
> +	char fw_msg_buf[5] = {0};
> +	unsigned long timeout;
> +	int ret;
> +
> +	if (msg_size > sizeof(fw_msg_buf))
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	/* Read until we get something */
> +	timeout = msecs_to_jiffies(ms_timeout) + jiffies;
> +	while (true) {
> +		if (time_is_before_jiffies(timeout))
> +			return FW_UPLOAD_ERR_TIMEOUT;
> +
> +		ret = i2c_master_recv(client, fw_msg_buf, 1);
> +		if (ret < 0 || *fw_msg_buf == 0) {
> +			usleep_range(1000, 2000);
> +			continue;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +	/* Read remaining characters */
> +	ret = i2c_master_recv(client, fw_msg_buf + 1, msg_size - 1);
> +	if (!strncmp(fw_msg_buf, msg_ok, msg_size)) {

I assume, testing ret is still better error handling.

> +		return FW_UPLOAD_ERR_NONE;
> +	} else {
> +		dev_err(&client->dev,
> +			"Wrong FW download process answer (%*pE)\n",
> +			msg_size, fw_msg_buf);

Here we can have two different error types, i2c error store in ret and
wrong response.

> +		return FW_UPLOAD_ERR_HW_ERROR;
> +	}
> +}
> +
> +static int pd692x0_fw_write_line(const struct i2c_client *client,
> +				 const char line[PD692X0_FW_LINE_MAX_SZ],
> +				 const bool last_line)
> +{
> +	int ret;
> +
> +	while (*line != 0) {
> +		ret = i2c_master_send(client, line, 1);
> +		if (ret < 0)
> +			return FW_UPLOAD_ERR_RW_ERROR;
> +		line++;
> +	}
> +
> +	if (last_line) {
> +		ret = pd692x0_fw_recv_resp(client, 100, "TP\r\n",
> +					   sizeof("TP\r\n") - 1);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = pd692x0_fw_recv_resp(client, 100, "T*\r\n",
> +					   sizeof("T*\r\n") - 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static enum fw_upload_err pd692x0_fw_reset(const struct i2c_client *client)
> +{
> +	const struct pd692x0_msg zero = {0};
> +	struct pd692x0_msg buf = {0};
> +	unsigned long timeout;
> +	char cmd[] = "RST";
> +	int ret;
> +
> +	ret = i2c_master_send(client, cmd, strlen(cmd));
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to reset the controller (%pe)\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	timeout = msecs_to_jiffies(10000) + jiffies;
> +	while (true) {
> +		if (time_is_before_jiffies(timeout))
> +			return FW_UPLOAD_ERR_TIMEOUT;
> +
> +		ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
> +		if (ret < 0 ||
> +		    !memcmp(&buf, &zero, sizeof(buf)))
> +			usleep_range(1000, 2000);
> +		else
> +			break;
> +	}
> +
> +	/* Is the reply a successful report message */
> +	if (buf.key != PD692X0_KEY_TLM || buf.echo != 0xff ||
> +	    buf.sub[0] & 0x01) {
> +		dev_err(&client->dev, "PSE controller error\n");
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +	}
> +
> +	/* Is the firmware operational */
> +	if (buf.sub[0] & 0x02) {
> +		dev_err(&client->dev,
> +			"PSE firmware error. Please update it.\n");
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +	}
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static enum fw_upload_err pd692x0_fw_prepare(struct fw_upload *fwl,
> +					     const u8 *data, u32 size)
> +{
> +	struct pd692x0_priv *priv = fwl->dd_handle;
> +	const struct i2c_client *client = priv->client;
> +	enum pd692x0_fw_state last_fw_state;
> +	int ret;
> +
> +	priv->cancel_request = false;
> +	last_fw_state = priv->fw_state;
> +
> +	priv->fw_state = PD692X0_FW_PREPARE;
> +
> +	/* Enter program mode */
> +	if (last_fw_state == PD692X0_FW_BROKEN) {
> +		const char *msg = "ENTR";
> +		const char *c;
> +
> +		c = msg;
> +		do {
> +			ret = i2c_master_send(client, c, 1);
> +			if (ret < 0)
> +				return FW_UPLOAD_ERR_RW_ERROR;
> +			if (*(c + 1))
> +				usleep_range(10000, 20000);
> +		} while (*(++c));
> +	} else {
> +		struct pd692x0_msg msg, buf;
> +
> +		msg = pd692x0_msg_template_list[PD692X0_MSG_DOWNLOAD_CMD];
> +		ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"Failed to enter programming mode (%pe)\n",
> +				ERR_PTR(ret));
> +			return FW_UPLOAD_ERR_RW_ERROR;
> +		}
> +	}
> +
> +	ret = pd692x0_fw_recv_resp(client, 100, "TPE\r\n", sizeof("TPE\r\n") - 1);
> +	if (ret)
> +		goto err_out;
> +
> +	if (priv->cancel_request) {
> +		ret = FW_UPLOAD_ERR_CANCELED;
> +		goto err_out;
> +	}
> +
> +	return FW_UPLOAD_ERR_NONE;
> +
> +err_out:
> +	pd692x0_fw_reset(priv->client);
> +	priv->fw_state = last_fw_state;
> +	return ret;
> +}
> +
> +static enum fw_upload_err pd692x0_fw_write(struct fw_upload *fwl,
> +					   const u8 *data, u32 offset,
> +					   u32 size, u32 *written)
> +{
> +	struct pd692x0_priv *priv = fwl->dd_handle;
> +	char line[PD692X0_FW_LINE_MAX_SZ];
> +	const struct i2c_client *client;
> +	int ret, i;
> +	char cmd;
> +
> +	client = priv->client;
> +	priv->fw_state = PD692X0_FW_WRITE;
> +
> +	/* Erase */
> +	cmd = 'E';
> +	ret = i2c_master_send(client, &cmd, 1);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to boot programming mode (%pe)\n",
> +			ERR_PTR(ret));
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	}
> +
> +	ret = pd692x0_fw_recv_resp(client, 100, "TOE\r\n", sizeof("TOE\r\n") - 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = pd692x0_fw_recv_resp(client, 5000, "TE\r\n", sizeof("TE\r\n") - 1);
> +	if (ret)
> +		dev_warn(&client->dev,
> +			 "Failed to erase internal memory, however still try to write Firmware\n");
> +
> +	ret = pd692x0_fw_recv_resp(client, 100, "TPE\r\n", sizeof("TPE\r\n") - 1);
> +	if (ret)
> +		dev_warn(&client->dev,
> +			 "Failed to erase internal memory, however still try to write Firmware\n");
> +
> +	if (priv->cancel_request)
> +		return FW_UPLOAD_ERR_CANCELED;
> +
> +	/* Program */
> +	cmd = 'P';
> +	ret = i2c_master_send(client, &cmd, sizeof(char));
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to boot programming mode (%pe)\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret = pd692x0_fw_recv_resp(client, 100, "TOP\r\n", sizeof("TOP\r\n") - 1);
> +	if (ret)
> +		return ret;
> +
> +	i = 0;
> +	while (i < size) {
> +		ret = pd692x0_fw_get_next_line(data, line, size - i);
> +		if (!ret) {
> +			ret = FW_UPLOAD_ERR_FW_INVALID;
> +			goto err;
> +		}
> +
> +		i += ret;
> +		data += ret;
> +		if (line[0] == 'S' && line[1] == '0') {
> +			continue;
> +		} else if (line[0] == 'S' && line[1] == '7') {
> +			ret = pd692x0_fw_write_line(client, line, true);
> +			if (ret)
> +				goto err;
> +		} else {
> +			ret = pd692x0_fw_write_line(client, line, false);
> +			if (ret)
> +				goto err;
> +		}
> +
> +		if (priv->cancel_request) {
> +			ret = FW_UPLOAD_ERR_CANCELED;
> +			goto err;
> +		}
> +	}
> +	*written = i;
> +
> +	msleep(400);
> +
> +	return FW_UPLOAD_ERR_NONE;
> +
> +err:
> +	strscpy_pad(line, "S7\r\n", sizeof(line));
> +	pd692x0_fw_write_line(client, line, true);
> +	return ret;
> +}
> +
> +static enum fw_upload_err pd692x0_fw_poll_complete(struct fw_upload *fwl)
> +{
> +	struct pd692x0_priv *priv = fwl->dd_handle;
> +	const struct i2c_client *client = priv->client;
> +	struct pd692x0_msg_ver ver;
> +	int ret;
> +
> +	priv->fw_state = PD692X0_FW_COMPLETE;
> +
> +	ret = pd692x0_fw_reset(client);
> +	if (ret)
> +		return ret;
> +
> +	ver = pd692x0_get_sw_version(priv);
> +	if (ver.maj_sw_ver != PD692X0_FW_MAJ_VER) {
> +		dev_err(&client->dev,
> +			"Too old firmware version. Please update it\n");
> +		priv->fw_state = PD692X0_FW_NEED_UPDATE;
> +		return FW_UPLOAD_ERR_FW_INVALID;
> +	}
> +
> +	ret = pd692x0_update_matrix(priv);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error configuring ports matrix (%pe)\n",
> +			ERR_PTR(ret));
> +		priv->fw_state = PD692X0_FW_NEED_UPDATE;
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +	}
> +
> +	priv->fw_state = PD692X0_FW_OK;
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static void pd692x0_fw_cancel(struct fw_upload *fwl)
> +{
> +	struct pd692x0_priv *priv = fwl->dd_handle;
> +
> +	priv->cancel_request = true;
> +}
> +
> +static void pd692x0_fw_cleanup(struct fw_upload *fwl)
> +{
> +	struct pd692x0_priv *priv = fwl->dd_handle;
> +
> +	switch (priv->fw_state) {
> +	case PD692X0_FW_WRITE:
> +		pd692x0_fw_reset(priv->client);
> +		fallthrough;
> +	case PD692X0_FW_COMPLETE:
> +		priv->fw_state = PD692X0_FW_BROKEN;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static const struct fw_upload_ops pd692x0_fw_ops = {
> +	.prepare = pd692x0_fw_prepare,
> +	.write = pd692x0_fw_write,
> +	.poll_complete = pd692x0_fw_poll_complete,
> +	.cancel = pd692x0_fw_cancel,
> +	.cleanup = pd692x0_fw_cleanup,
> +};
> +
> +static int pd692x0_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct pd692x0_msg buf = {0};
> +	struct pd692x0_msg_ver ver;
> +	struct pd692x0_priv *priv;
> +	struct fw_upload *fwl;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(dev, "i2c check functionality failed\n");
> +		return -ENXIO;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->client = client;
> +	i2c_set_clientdata(client, priv);
> +
> +	priv->pcdev.owner = THIS_MODULE;
> +	priv->pcdev.ops = &pd692x0_ops;
> +	priv->pcdev.dev = dev;
> +	priv->pcdev.types = PSE_C33;
> +	priv->pcdev.of_pse_n_cells = 1;
> +	priv->pcdev.nr_lines = PD692X0_MAX_LOGICAL_PORTS;
> +	ret = devm_pse_controller_register(dev, &priv->pcdev);
> +	if (ret) {
> +		return dev_err_probe(dev, ret,
> +				     "failed to register PSE controller\n");
> +	}
> +
> +	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
> +				       &pd692x0_fw_ops, priv);
> +	if (IS_ERR(fwl)) {
> +		dev_err(dev, "Failed to register to the Firmware Upload API\n");
> +		ret = PTR_ERR(fwl);
> +		return ret;
> +	}
> +	priv->fwl = fwl;
> +
> +	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
> +	if (ret != sizeof(buf)) {
> +		dev_err(dev, "Failed to get device status\n");
> +		ret = -EIO;

Overwritten error value.

> +		goto err_fw_unregister;
> +	}
> +
> +	if (buf.key != 0x03 || buf.echo != 0xff || buf.sub[0] & 0x01) {
> +		dev_err(dev, "PSE controller error\n");

There is same pattern detection on other place. It will be to move it to
a separate function and add some comments.

> +		ret = -EIO;
> +		goto err_fw_unregister;
> +	}
> +
> +	if (buf.sub[0] & 0x02) {

Is it possible to replace most of this magic numbers?

> +		dev_err(dev, "PSE firmware error. Please update it.\n");

I assume, the message is saying that firmware image is corrupt and
should be overwritten? "update" feels more like, there is old firmware
version and should be replaced with a new one :)

> +		priv->fw_state = PD692X0_FW_BROKEN;
> +		return 0;
> +	}
> +
> +	ver = pd692x0_get_sw_version(priv);
> +	dev_info(&client->dev, "Software version %d.%02d.%d.%d\n", ver.prod,
> +		 ver.maj_sw_ver, ver.min_sw_ver, ver.pa_sw_ver);
> +
> +	if (ver.maj_sw_ver != PD692X0_FW_MAJ_VER) {
> +		dev_err(dev, "Too old firmware version. Please update it\n");
> +		priv->fw_state = PD692X0_FW_NEED_UPDATE;
> +		return 0;
> +	}
> +
> +	ret = pd692x0_update_matrix(priv);
> +	if (ret < 0) {
> +		dev_err(dev, "Error configuring ports matrix (%pe)\n",
> +			ERR_PTR(ret));
> +		goto err_fw_unregister;
> +	}
> +
> +	priv->fw_state = PD692X0_FW_OK;
> +	return 0;
> +
> +err_fw_unregister:
> +	firmware_upload_unregister(priv->fwl);
> +	return ret;
> +}
> +
> +static void pd692x0_i2c_remove(struct i2c_client *client)
> +{
> +	struct pd692x0_priv *priv = i2c_get_clientdata(client);
> +
> +	firmware_upload_unregister(priv->fwl);
> +}
> +
> +static const struct i2c_device_id pd692x0_id[] = {
> +	{ PD692X0_PSE_NAME, 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, pd692x0_id);
> +
> +static const struct of_device_id pd692x0_of_match[] = {
> +	{ .compatible = "microchip,pd69200", },
> +	{ .compatible = "microchip,pd69210", },
> +	{ .compatible = "microchip,pd69220", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, pd692x0_of_match);
> +
> +static struct i2c_driver pd692x0_driver = {
> +	.probe		= pd692x0_i2c_probe,
> +	.remove		= pd692x0_i2c_remove,
> +	.id_table	= pd692x0_id,
> +	.driver		= {
> +		.name		= PD692X0_PSE_NAME,
> +		.of_match_table = pd692x0_of_match,
> +	},
> +};
> +module_i2c_driver(pd692x0_driver);
> +
> +MODULE_AUTHOR("Kory Maincent <kory.maincent@bootlin.com>");
> +MODULE_DESCRIPTION("Microchip PD692x0 PoE PSE Controller driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.25.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
