Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A007984C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbjIHJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIHJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:23:11 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9719B0;
        Fri,  8 Sep 2023 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1694164986; x=1725700986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Egkw+WH5fFJ5kSX2OdPLD5E87Kh/cobubBZXv1R2/WA=;
  b=Tg4QEX0lozi8IrbG0YPf1kVq9T+avVNE3QDcGu6D7iCM61mtQLhQRYhQ
   C1Z8ft7zRSGeDJZdvQmAr6XFBYpnz2WCWt3cH5tGUCGed2FFaKTnmH3oI
   wgP5TeuIrIfvWYNv65UaguqtKRdVlnNMYrWrEi7DlFUq2nrHJ1LqiVhp/
   QzrPzdCYc2AkfRS4wFRfBx0Sy18Jv17i7dKPsR8U/5G4RYuObj6jmWu1t
   GvvdoJTaVnI/0Xce0DZkONd2BngJrCVmA9EV1A6VVRRP2uXNAPPM4fME/
   jlIj2FmJqmcMb2P+vcHjFwqqYBa1njMHIkkZVMwShPupuI3rUd97UbUP7
   g==;
X-IronPort-AV: E=Sophos;i="6.02,236,1688421600"; 
   d="scan'208";a="32852030"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Sep 2023 11:23:04 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 863FF28007F;
        Fri,  8 Sep 2023 11:23:04 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     netdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] net: phy: dp83867: Add support for hardware blinking LEDs
Date:   Fri, 08 Sep 2023 11:23:05 +0200
Message-ID: <2239338.iZASKD2KPV@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230907084731.2181381-1-s.hauer@pengutronix.de>
References: <20230907084731.2181381-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

thanks for the patch.

Am Donnerstag, 7. September 2023, 10:47:31 CEST schrieb Sascha Hauer:
> This implements the led_hw_* hooks to support hardware blinking LEDs on
> the DP83867 phy. The driver supports all LED modes that have a
> corresponding TRIGGER_NETDEV_* define. Error and collision do not have
> a TRIGGER_NETDEV_* define, so these modes are currently not supported.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

This works as intended so far. Unfortunately this driver and the PHY LED=20
framework do not support active-low LEDs (yet).

Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> #TQMa8MxML/MBa=
8Mx

> ---
>  drivers/net/phy/dp83867.c | 137 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>=20
> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index e397e7d642d92..5f08f9d38bd7a 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -159,6 +159,23 @@
>  #define DP83867_LED_DRV_EN(x)	BIT((x) * 4)
>  #define DP83867_LED_DRV_VAL(x)	BIT((x) * 4 + 1)
>=20
> +#define DP83867_LED_FN(idx, val)	(((val) & 0xf) << ((idx) * 4))
> +#define DP83867_LED_FN_MASK(idx)	(0xf << ((idx) * 4))
> +#define DP83867_LED_FN_RX_ERR		0xe /* Receive Error */
> +#define DP83867_LED_FN_RX_TX_ERR	0xd /* Receive Error or Transmit=20
Error */
> +#define DP83867_LED_FN_LINK_RX_TX	0xb /* Link established, blink for rx=
=20
or
> tx activity */ +#define DP83867_LED_FN_FULL_DUPLEX	0xa /* Full=20
duplex */
> +#define DP83867_LED_FN_LINK_100_1000_BT	0x9 /* 100/1000BT link=20
established
> */ +#define DP83867_LED_FN_LINK_10_100_BT	0x8 /* 10/100BT link=20
established
> */ +#define DP83867_LED_FN_LINK_10_BT	0x7 /* 10BT link established */
> +#define DP83867_LED_FN_LINK_100_BTX	0x6 /* 100 BTX link established */
> +#define DP83867_LED_FN_LINK_1000_BT	0x5 /* 1000 BT link established */
> +#define DP83867_LED_FN_COLLISION	0x4 /* Collision detected */
> +#define DP83867_LED_FN_RX		0x3 /* Receive activity */
> +#define DP83867_LED_FN_TX		0x2 /* Transmit activity */
> +#define DP83867_LED_FN_RX_TX		0x1 /* Receive or Transmit=20
activity */
> +#define DP83867_LED_FN_LINK		0x0 /* Link established */
> +
>  enum {
>  	DP83867_PORT_MIRROING_KEEP,
>  	DP83867_PORT_MIRROING_EN,
> @@ -1018,6 +1035,123 @@ dp83867_led_brightness_set(struct phy_device
> *phydev, val);
>  }
>=20
> +static int dp83867_led_mode(u8 index, unsigned long rules)
> +{
> +	if (index >=3D DP83867_LED_COUNT)
> +		return -EINVAL;
> +
> +	switch (rules) {
> +	case BIT(TRIGGER_NETDEV_LINK):
> +		return DP83867_LED_FN_LINK;
> +	case BIT(TRIGGER_NETDEV_LINK_10):
> +		return DP83867_LED_FN_LINK_10_BT;
> +	case BIT(TRIGGER_NETDEV_LINK_100):
> +		return DP83867_LED_FN_LINK_100_BTX;
> +	case BIT(TRIGGER_NETDEV_FULL_DUPLEX):
> +		return DP83867_LED_FN_FULL_DUPLEX;
> +	case BIT(TRIGGER_NETDEV_TX):
> +		return DP83867_LED_FN_TX;
> +	case BIT(TRIGGER_NETDEV_RX):
> +		return DP83867_LED_FN_RX;
> +	case BIT(TRIGGER_NETDEV_LINK_1000):
> +		return DP83867_LED_FN_LINK_1000_BT;
> +	case BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
> +		return DP83867_LED_FN_RX_TX;
> +	case BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK_1000):
> +		return DP83867_LED_FN_LINK_100_1000_BT;
> +	case BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK_100):
> +		return DP83867_LED_FN_LINK_10_100_BT;
> +	case BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) |
> BIT(TRIGGER_NETDEV_RX): +		return DP83867_LED_FN_LINK_RX_TX;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int dp83867_led_hw_is_supported(struct phy_device *phydev, u8 ind=
ex,
> +				       unsigned long rules)
> +{
> +	int ret;
> +
> +	ret =3D dp83867_led_mode(index, rules);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int dp83867_led_hw_control_set(struct phy_device *phydev, u8 inde=
x,
> +				      unsigned long rules)
> +{
> +	int mode, ret;
> +
> +	mode =3D dp83867_led_mode(index, rules);
> +	if (mode < 0)
> +		return mode;
> +
> +	ret =3D phy_modify(phydev, DP83867_LEDCR1, DP83867_LED_FN_MASK(index),
> +			 DP83867_LED_FN(index, mode));
> +	if (ret)
> +		return ret;
> +
> +	return phy_modify(phydev, DP83867_LEDCR2, DP83867_LED_DRV_EN(index),=20
0);
> +}
> +
> +static int dp83867_led_hw_control_get(struct phy_device *phydev, u8 inde=
x,
> +				      unsigned long *rules)
> +{
> +	int val;
> +
> +	val =3D phy_read(phydev, DP83867_LEDCR1);
> +	if (val < 0)
> +		return val;
> +
> +	val &=3D DP83867_LED_FN_MASK(index);
> +	val >>=3D index * 4;
> +
> +	switch (val) {
> +	case DP83867_LED_FN_LINK:
> +		*rules =3D BIT(TRIGGER_NETDEV_LINK);
> +		break;
> +	case DP83867_LED_FN_LINK_10_BT:
> +		*rules =3D BIT(TRIGGER_NETDEV_LINK_10);
> +		break;
> +	case DP83867_LED_FN_LINK_100_BTX:
> +		*rules =3D BIT(TRIGGER_NETDEV_LINK_100);
> +		break;
> +	case DP83867_LED_FN_FULL_DUPLEX:
> +		*rules =3D BIT(TRIGGER_NETDEV_FULL_DUPLEX);
> +		break;
> +	case DP83867_LED_FN_TX:
> +		*rules =3D BIT(TRIGGER_NETDEV_TX);
> +		break;
> +	case DP83867_LED_FN_RX:
> +		*rules =3D BIT(TRIGGER_NETDEV_RX);
> +		break;
> +	case DP83867_LED_FN_LINK_1000_BT:
> +		*rules =3D BIT(TRIGGER_NETDEV_LINK_1000);
> +		break;
> +	case DP83867_LED_FN_RX_TX:
> +		*rules =3D BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
> +		break;
> +	case DP83867_LED_FN_LINK_100_1000_BT:
> +		*rules =3D BIT(TRIGGER_NETDEV_LINK_100) |=20
BIT(TRIGGER_NETDEV_LINK_1000);
> +		break;
> +	case DP83867_LED_FN_LINK_10_100_BT:
> +		*rules =3D BIT(TRIGGER_NETDEV_LINK_10) |=20
BIT(TRIGGER_NETDEV_LINK_100);
> +		break;
> +	case DP83867_LED_FN_LINK_RX_TX:
> +		*rules =3D BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX)=20
|
> +			 BIT(TRIGGER_NETDEV_RX);
> +		break;
> +	default:
> +		*rules =3D 0;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct phy_driver dp83867_driver[] =3D {
>  	{
>  		.phy_id		=3D DP83867_PHY_ID,
> @@ -1047,6 +1181,9 @@ static struct phy_driver dp83867_driver[] =3D {
>  		.set_loopback	=3D dp83867_loopback,
>=20
>  		.led_brightness_set =3D dp83867_led_brightness_set,
> +		.led_hw_is_supported =3D dp83867_led_hw_is_supported,
> +		.led_hw_control_set =3D dp83867_led_hw_control_set,
> +		.led_hw_control_get =3D dp83867_led_hw_control_get,
>  	},
>  };
>  module_phy_driver(dp83867_driver);


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


