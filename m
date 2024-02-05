Return-Path: <linux-kernel+bounces-53067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2ED84A041
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8794D1F23235
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625DF40C0C;
	Mon,  5 Feb 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Pd31Y6GF"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDFE3CF5F;
	Mon,  5 Feb 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152976; cv=none; b=Nw/CmI8w4QGxBmMl6lOL0KIKu2C5pQxF2sDoBvy4Gk50A6wkL0B0Dp+ngoK0nOgnjHgx1w8zK2noyXTjpjUAHDWdXM7yvcmw3j7ENopNzRhVeNwO3FhzCJPuEs4TSFxA8YHCMSFWUDhde5gmWdHbV6MxL9TDd3eyytGi7EfvKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152976; c=relaxed/simple;
	bh=Etuxorh5D8osWskvYtjw4GyEg+E+zdVcbBbHVvbeEE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2hhVQAbu0q1Gsz1PKw1+YwMBe1AaYoqbejfPMK38qDu+E/uE2pitDbVqXzmqSJZIQErYKM4+OsNtZeaY14eLIto00bLdR1IOnATK4X3QwbCmt9douHr6w70bD5vvnlFJx7bfL03ErX0auEOcOu1h/rZIckY9mA5VsJXZ371IBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Pd31Y6GF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
	:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=HAkMMksYxsR3ntfGjZzFjduREp8jHxmje/+tXuNs4cU=; b=Pd31Y6GFCYNVBx94WiZpYMaD1A
	BnjuIw0NPghM9IjgcyaHUg58B43swrlZifEDiFxJFz0fs6b++1N/O9uJWVzYJgDMEqtuinxyb+Ooz
	z1Xabe+QjYGTIP/tdraiggR4DXjltj78YVX3wPDt1JXYMU8LPowS81w6ur/vSmIrs4moVPsvi3zj3
	aF0NalsesQIQ6HL9/F+Rvtr/njZds+Zwz/7qRUAvWar4aTPv0MVCLYlr2u2H5N4UyoU5BuEZESzzS
	fkEQArqtQAtjG3aDNCKr8CO+/mjvHDi7s3jsM2TgPS8HogmNCisHLHEHNkyoZ1FXrsM1PTQRUZa8i
	do2KZgaA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1rX2CI-005TBA-1P;
	Mon, 05 Feb 2024 16:51:54 +0000
Date: Mon, 5 Feb 2024 16:51:54 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@roeck-us.net, heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 4/4] usb: typec: tcpci: add support to set connector
 orientation
Message-ID: <ZcESKqRTsGNZMMX1@gallifrey>
References: <20240205164316.805408-1-m.felsch@pengutronix.de>
 <20240205164316.805408-5-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240205164316.805408-5-m.felsch@pengutronix.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 16:50:37 up 33 days, 19:40,  1 user,  load average: 0.01, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Marco Felsch (m.felsch@pengutronix.de) wrote:
> This add the support to set the optional connector orientation bit which
> is part of the optional CONFIG_STANDARD_OUTPUT register 0x18 [1]. This
> allows system designers to connect the tcpc orientation pin directly to
> the 2:1 ss-mux.
> 
> [1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 43 ++++++++++++++++++++++++++++++++++
>  include/linux/usb/tcpci.h      |  8 +++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 7118551827f6..7ce9d4923bc7 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -67,6 +67,18 @@ static int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)
>  	return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u16));
>  }
>  
> +static bool tcpci_check_std_output_cap(struct regmap *regmap, u8 mask)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(regmap, TCPC_STD_OUTPUT_CAP, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (reg & mask) == mask;
> +}
> +
>  static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -301,6 +313,27 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
>  			   TCPC_TCPC_CTRL_ORIENTATION : 0);
>  }
>  
> +static int tcpci_set_orientation(struct tcpc_dev *tcpc,
> +				 enum typec_orientation orientation)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> +	unsigned int reg;
> +
> +	switch (orientation) {
> +	case TYPEC_ORIENTATION_NONE:
> +		/* We can't put a single output into high impedance */

Is that intended to be a fallthrough? If so I guess it needs
marking as such with a
                fallthrough;

Dave

> +	case TYPEC_ORIENTATION_NORMAL:
> +		reg = TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL;
> +		break;
> +	case TYPEC_ORIENTATION_REVERSE:
> +		reg = TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED;
> +		break;
> +	}
> +
> +	return regmap_update_bits(tcpci->regmap, TCPC_CONFIG_STD_OUTPUT,
> +				  TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK, reg);
> +}
> +
>  static void tcpci_set_partner_usb_comm_capable(struct tcpc_dev *tcpc, bool capable)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -808,6 +841,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  	if (tcpci->data->vbus_vsafe0v)
>  		tcpci->tcpc.is_vbus_vsafe0v = tcpci_is_vbus_vsafe0v;
>  
> +	if (tcpci->data->set_orientation)
> +		tcpci->tcpc.set_orientation = tcpci_set_orientation;
> +
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
>  		return ERR_PTR(err);
> @@ -851,6 +887,13 @@ static int tcpci_probe(struct i2c_client *client)
>  	if (err < 0)
>  		return err;
>  
> +	err = tcpci_check_std_output_cap(chip->data.regmap,
> +					 TCPC_STD_OUTPUT_CAP_ORIENTATION);
> +	if (err < 0)
> +		return err;
> +
> +	chip->data.set_orientation = err;
> +
>  	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
>  	if (IS_ERR(chip->tcpci))
>  		return PTR_ERR(chip->tcpci);
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 467e8045e9f8..f2bfb4250366 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -47,6 +47,9 @@
>  #define TCPC_SINK_FAST_ROLE_SWAP	BIT(0)
>  
>  #define TCPC_CONFIG_STD_OUTPUT		0x18
> +#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK		BIT(0)
> +#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL	0
> +#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED	1
>  
>  #define TCPC_TCPC_CTRL			0x19
>  #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
> @@ -127,6 +130,7 @@
>  #define TCPC_DEV_CAP_2			0x26
>  #define TCPC_STD_INPUT_CAP		0x28
>  #define TCPC_STD_OUTPUT_CAP		0x29
> +#define TCPC_STD_OUTPUT_CAP_ORIENTATION	BIT(0)
>  
>  #define TCPC_MSG_HDR_INFO		0x2e
>  #define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
> @@ -198,12 +202,16 @@ struct tcpci;
>   *		Chip level drivers are expected to check for contaminant and call
>   *		tcpm_clean_port when the port is clean to put the port back into
>   *		toggling state.
> + * @set_orientation:
> + *		Optional; Enable setting the connector orientation
> + *		CONFIG_STANDARD_OUTPUT (0x18) bit0.
>   */
>  struct tcpci_data {
>  	struct regmap *regmap;
>  	unsigned char TX_BUF_BYTE_x_hidden:1;
>  	unsigned char auto_discharge_disconnect:1;
>  	unsigned char vbus_vsafe0v:1;
> +	unsigned char set_orientation:1;
>  
>  	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>  	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> -- 
> 2.39.2
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

