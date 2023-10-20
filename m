Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD7C7D0828
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376306AbjJTGNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbjJTGNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:13:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952BD49
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:13:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so779623a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697782387; x=1698387187; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8Jo8kQtdwr/29n6pOxg3RoBTRLn0fMv19Msj1RI6qI=;
        b=uEnHpAb6pBjYgr4YMc+L03sK8mE/TfRQfddskcNVI7TpGx+9AoabggBDURoCmjpbuD
         fmH/WoNQNz/9ALkUgKczAGRjs94srK2xix/wh0ggeQcLMMtvT6OUeVFm6Pa5vxvZAiij
         OK3+tertoYtNDHJKvufN0S8/6ICFwBi8g0fdh0OBtN7nNjGQWsiwl2Jtn3kURIEz0SPZ
         ywvfOBffXqhxlh8yDos16oKXHZXZIrONUIO4KAwHysCx1MY+yZZIYzCisx2njC9NthQD
         Zj6Z5HDjKfliwQPZPvUPtM5Th6kX2HYBA2iI8NS4aWHDWJf8c7L4bu5Flpzrdkf/7fO7
         nHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697782387; x=1698387187;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A8Jo8kQtdwr/29n6pOxg3RoBTRLn0fMv19Msj1RI6qI=;
        b=qWR12/uLQLWWhQmTqreAntF5en0Gd92A3Ol/kk8yD9WP/4hitS1Bs4O+0nrDprhlmE
         AdVpCvwOF/zHbxR9R1LZksirq4RFKPkfpZ3Df5mRCup7+VfRp2eMgo5rUgNMV4Zu+/CI
         qIzDER3ifezPupcO2HCuSOrdgtYtSpyZSoHnAbWDpK0++AUPuFIwCdA/vwmuiLpkyETG
         OyGclxGD9jIU1RD55rD9842fx9WeZl4PKBceREaAHHQg/d9VlmzqK/rgzGYP3e9wY8uN
         1UrhdiaePjWR9g2hbtHrdcknVsQ1WmpK5F/Zcp5Hy9KeFy35oNEm9zSYEDDB5KSiGWKm
         fFWA==
X-Gm-Message-State: AOJu0YyZEGTGr+je59LlOzd93d/DAS5krXCphrb+eLx34SY56TeM4fgg
        xCC+sEwBaNDrxjkZHi+BF01TUg==
X-Google-Smtp-Source: AGHT+IHzN3Ek+NPc7G4Fqnzf5fQJixylOoiCOS2RfE8j/V3xDZ55XJS43mnnDDHo+X6KH5JzhuEgfQ==
X-Received: by 2002:a17:907:1c21:b0:9bd:fff1:5796 with SMTP id nc33-20020a1709071c2100b009bdfff15796mr668409ejc.0.1697782386805;
        Thu, 19 Oct 2023 23:13:06 -0700 (PDT)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id bm11-20020a170906c04b00b009a193a5acffsm815060ejb.121.2023.10.19.23.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 23:13:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 20 Oct 2023 08:13:05 +0200
Message-Id: <CWD1MKL68P2V.1QBJXJ0E5U171@fairphone.com>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Heikki Krogerus" <heikki.krogerus@linux.intel.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: typec: add support for PTN36502 redriver
X-Mailer: aerc 0.15.2
References: <20231013-ptn36502-v1-0-98109a430efc@fairphone.com>
 <20231013-ptn36502-v1-2-98109a430efc@fairphone.com>
 <ZS5HAQrUObdhHSdV@kuha.fi.intel.com>
In-Reply-To: <ZS5HAQrUObdhHSdV@kuha.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Oct 17, 2023 at 10:34 AM CEST, Heikki Krogerus wrote:
> Hi,
>
> On Fri, Oct 13, 2023 at 04:24:48PM +0200, Luca Weiss wrote:
> > Add a driver for the NXP PTN36502 Type-C USB 3.1 Gen 1 and DisplayPort
> > v1.2 combo redriver.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>
> Looks OK to me, but couple of nitpicks below. With those fixed:
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> > ---
> >  drivers/usb/typec/mux/Kconfig    |  10 +
> >  drivers/usb/typec/mux/Makefile   |   1 +
> >  drivers/usb/typec/mux/ptn36502.c | 421 +++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 432 insertions(+)
> >=20
> > diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kcon=
fig
> > index 65da61150ba7..816b9bd08355 100644
> > --- a/drivers/usb/typec/mux/Kconfig
> > +++ b/drivers/usb/typec/mux/Kconfig
> > @@ -46,4 +46,14 @@ config TYPEC_MUX_NB7VPQ904M
> >  	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
> >  	  redriver chip found on some devices with a Type-C port.
> > =20
> > +config TYPEC_MUX_PTN36502
> > +	tristate "NXP PTN36502 Type-C redriver driver"
> > +	depends on I2C
> > +	depends on DRM || DRM=3Dn
> > +	select DRM_PANEL_BRIDGE if DRM
> > +	select REGMAP_I2C
> > +	help
> > +	  Say Y or M if your system has a NXP PTN36502 Type-C redriver chip
> > +	  found on some devices with a Type-C port.
> > +
> >  endmenu
> > diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Mak=
efile
> > index 76196096ef41..9d6a5557b0bd 100644
> > --- a/drivers/usb/typec/mux/Makefile
> > +++ b/drivers/usb/typec/mux/Makefile
> > @@ -5,3 +5,4 @@ obj-$(CONFIG_TYPEC_MUX_GPIO_SBU)	+=3D gpio-sbu-mux.o
> >  obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+=3D pi3usb30532.o
> >  obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+=3D intel_pmc_mux.o
> >  obj-$(CONFIG_TYPEC_MUX_NB7VPQ904M)	+=3D nb7vpq904m.o
> > +obj-$(CONFIG_TYPEC_MUX_PTN36502)	+=3D ptn36502.o
> > diff --git a/drivers/usb/typec/mux/ptn36502.c b/drivers/usb/typec/mux/p=
tn36502.c
> > new file mode 100644
> > index 000000000000..91684a856f3a
> > --- /dev/null
> > +++ b/drivers/usb/typec/mux/ptn36502.c
> > @@ -0,0 +1,421 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * NXP PTN36502 Type-C driver
> > + *
> > + * Copyright (C) 2023 Luca Weiss <luca.weiss@fairphone.com>
> > + *
> > + * Based on NB7VPQ904M driver:
> > + * Copyright (C) 2023 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > + */
> > +
> > +#include <drm/drm_bridge.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/usb/typec_dp.h>
> > +#include <linux/usb/typec_mux.h>
> > +#include <linux/usb/typec_retimer.h>
> > +
> > +#define PTN36502_CHIP_ID_REG				0x00
> > +#define PTN36502_CHIP_ID				0x02
> > +
> > +#define PTN36502_CHIP_REVISION_REG			0x01
> > +#define PTN36502_CHIP_REVISION_BASE(val)		FIELD_GET(GENMASK(7, 4), (va=
l))
> > +#define PTN36502_CHIP_REVISION_METAL(val)		FIELD_GET(GENMASK(3, 0), (v=
al))
> > +
> > +#define PTN36502_DP_LINK_CTRL_REG			0x06
> > +#define PTN36502_DP_LINK_CTRL_LANES_2			(2 << 2)
> > +#define PTN36502_DP_LINK_CTRL_LANES_4			(3 << 2)
> > +#define PTN36502_DP_LINK_CTRL_LINK_RATE_5_4GBPS		(2 << 0)
> > +
> > +/* Registers for lane 0 (0x07) to lane 3 (0x0a) have the same layout *=
/
> > +#define PTN36502_DP_LANE_CTRL_REG(n)			(0x07 + (n))
> > +#define PTN36502_DP_LANE_CTRL_RX_GAIN_3DB		(2<<4)
> > +#define PTN36502_DP_LANE_CTRL_TX_SWING_800MVPPD		(2<<2)
> > +#define PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_3_5DB	(1<<0)
> > +
> > +#define PTN36502_MODE_CTRL1_REG				0x0b
> > +#define PTN36502_MODE_CTRL1_PLUG_ORIENT_REVERSE		(1<<5)
> > +#define PTN36502_MODE_CTRL1_AUX_CROSSBAR_SW_ON		(1<<3)
> > +#define PTN36502_MODE_CTRL1_MODE_OFF			(0<<0)
> > +#define PTN36502_MODE_CTRL1_MODE_USB_ONLY		(1<<0)
> > +#define PTN36502_MODE_CTRL1_MODE_USB_DP			(2<<0)
> > +#define PTN36502_MODE_CTRL1_MODE_DP			(3<<0)
> > +
> > +#define PTN36502_DEVICE_CTRL_REG			0x0d
> > +#define PTN36502_DEVICE_CTRL_AUX_MONITORING_EN		(1<<7)
>
> You have couple of different styles here. Please try to always use
> BIT() and GENMASK() macros when possible. At the very least put spaces
> around << and >>.

Hi Heikki,

I was wondering when writing that whether GENMASK was actually proper
use for values you write to registers, when not actually used as a
bitmask.

Since the datasheet refers to e.g. with TX_SWING_800MVPPD (2<<2) that
you write a '2' to the correct bits of this register. But when using
BIT(3) kind of hides this relationship if someone refers back to the
datasheet. Or same with "3<<2" -> GENMASK(3, 2) or whatever.

Let me know what you think.

Regards
Luca

>
> > +struct ptn36502 {
> > +	struct i2c_client *client;
> > +	struct regulator *vdd18_supply;
> > +	struct regmap *regmap;
> > +	struct typec_switch_dev *sw;
> > +	struct typec_retimer *retimer;
> > +
> > +	struct typec_switch *typec_switch;
> > +
> > +	struct drm_bridge bridge;
> > +
> > +	struct mutex lock; /* protect non-concurrent retimer & switch */
> > +
> > +	enum typec_orientation orientation;
> > +	unsigned long mode;
> > +	unsigned int svid;
> > +};
> > +
> > +static int ptn36502_set(struct ptn36502 *ptn)
> > +{
> > +	bool reverse =3D (ptn->orientation =3D=3D TYPEC_ORIENTATION_REVERSE);
> > +	unsigned int ctrl1_val =3D 0;
> > +	unsigned int lane_ctrl_val =3D 0;
> > +	unsigned int link_ctrl_val =3D 0;
> > +
> > +	switch (ptn->mode) {
> > +	case TYPEC_STATE_SAFE:
> > +		/* Deep power saving state */
> > +		regmap_write(ptn->regmap, PTN36502_MODE_CTRL1_REG,
> > +			     PTN36502_MODE_CTRL1_MODE_OFF);
> > +		return 0;
> > +
> > +	case TYPEC_STATE_USB:
> > +		/*
> > +		 * Normal Orientation (CC1)
> > +		 * A -> USB RX
> > +		 * B -> USB TX
> > +		 * C -> X
> > +		 * D -> X
> > +		 * Flipped Orientation (CC2)
> > +		 * A -> X
> > +		 * B -> X
> > +		 * C -> USB TX
> > +		 * D -> USB RX
> > +		 */
> > +
> > +		/* USB 3.1 Gen 1 only */
> > +		ctrl1_val =3D PTN36502_MODE_CTRL1_MODE_USB_ONLY;
> > +		if (reverse)
> > +			ctrl1_val |=3D PTN36502_MODE_CTRL1_PLUG_ORIENT_REVERSE;
> > +
> > +		regmap_write(ptn->regmap, PTN36502_MODE_CTRL1_REG, ctrl1_val);
> > +		return 0;
> > +
> > +	default:
> > +		if (ptn->svid !=3D USB_TYPEC_DP_SID)
> > +			return -EINVAL;
> > +
> > +		break;
> > +	}
> > +
> > +	/* DP Altmode Setup */
> > +
> > +	switch (ptn->mode) {
> > +	case TYPEC_DP_STATE_C:
> > +	case TYPEC_DP_STATE_E:
> > +		/*
> > +		 * Normal Orientation (CC1)
> > +		 * A -> DP3
> > +		 * B -> DP2
> > +		 * C -> DP1
> > +		 * D -> DP0
> > +		 * Flipped Orientation (CC2)
> > +		 * A -> DP0
> > +		 * B -> DP1
> > +		 * C -> DP2
> > +		 * D -> DP3
> > +		 */
> > +
> > +		/* 4-lane DP */
> > +		ctrl1_val |=3D PTN36502_MODE_CTRL1_MODE_DP;
> > +		link_ctrl_val |=3D PTN36502_DP_LINK_CTRL_LANES_4;
> > +		break;
> > +
> > +	case TYPEC_DP_STATE_D:
> > +	case TYPEC_DP_STATE_F: /* State F is deprecated */
> > +		/*
> > +		 * Normal Orientation (CC1)
> > +		 * A -> USB RX
> > +		 * B -> USB TX
> > +		 * C -> DP1
> > +		 * D -> DP0
> > +		 * Flipped Orientation (CC2)
> > +		 * A -> DP0
> > +		 * B -> DP1
> > +		 * C -> USB TX
> > +		 * D -> USB RX
> > +		 */
> > +
> > +		/* USB 3.1 Gen 1 and 2-lane DP */
> > +		ctrl1_val |=3D PTN36502_MODE_CTRL1_MODE_USB_DP;
> > +		link_ctrl_val |=3D PTN36502_DP_LINK_CTRL_LANES_2;
> > +		break;
> > +
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	/* Enable AUX monitoring */
> > +	regmap_write(ptn->regmap, PTN36502_DEVICE_CTRL_REG,
> > +		     PTN36502_DEVICE_CTRL_AUX_MONITORING_EN);
> > +
> > +	/* Enable AUX switch path */
> > +	ctrl1_val |=3D PTN36502_MODE_CTRL1_AUX_CROSSBAR_SW_ON;
> > +	if (reverse)
> > +		ctrl1_val |=3D PTN36502_MODE_CTRL1_PLUG_ORIENT_REVERSE;
> > +	regmap_write(ptn->regmap, PTN36502_MODE_CTRL1_REG, ctrl1_val);
> > +
> > +	/* DP Link rate: 5.4 Gbps (HBR2) */
> > +	link_ctrl_val |=3D PTN36502_DP_LINK_CTRL_LINK_RATE_5_4GBPS;
> > +	regmap_write(ptn->regmap, PTN36502_DP_LINK_CTRL_REG, link_ctrl_val);
> > +
> > +	/*
> > +	 * For all lanes:
> > +	 * - Rx equivalization gain: 3 dB
> > +	 * - TX output swing control: 800 mVppd
> > +	 * - Pre-emphasis control: 3.5 dB
> > +	 */
> > +	lane_ctrl_val =3D PTN36502_DP_LANE_CTRL_RX_GAIN_3DB |
> > +			PTN36502_DP_LANE_CTRL_TX_SWING_800MVPPD |
> > +			PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_3_5DB;
> > +	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(0), lane_ctrl_val=
);
> > +	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(1), lane_ctrl_val=
);
> > +	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(2), lane_ctrl_val=
);
> > +	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(3), lane_ctrl_val=
);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ptn36502_sw_set(struct typec_switch_dev *sw, enum typec_ori=
entation orientation)
> > +{
> > +	struct ptn36502 *ptn =3D typec_switch_get_drvdata(sw);
> > +	int ret;
> > +
> > +	ret =3D typec_switch_set(ptn->typec_switch, orientation);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&ptn->lock);
> > +
> > +	if (ptn->orientation !=3D orientation) {
> > +		ptn->orientation =3D orientation;
> > +
> > +		ret =3D ptn36502_set(ptn);
> > +	}
> > +
> > +	mutex_unlock(&ptn->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ptn36502_retimer_set(struct typec_retimer *retimer, struct =
typec_retimer_state *state)
> > +{
> > +	struct ptn36502 *ptn =3D typec_retimer_get_drvdata(retimer);
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&ptn->lock);
> > +
> > +	if (ptn->mode !=3D state->mode) {
> > +		ptn->mode =3D state->mode;
> > +
> > +		if (state->alt)
> > +			ptn->svid =3D state->alt->svid;
> > +		else
> > +			ptn->svid =3D 0; // No SVID
> > +
> > +		ret =3D ptn36502_set(ptn);
> > +	}
> > +
> > +	mutex_unlock(&ptn->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ptn36502_detect(struct ptn36502 *ptn)
> > +{
> > +	struct device *dev =3D &ptn->client->dev;
> > +	unsigned int reg_val;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(ptn->regmap, PTN36502_CHIP_ID_REG,
> > +			  &reg_val);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to read chip ID\n");
> > +
> > +	if (reg_val !=3D PTN36502_CHIP_ID)
> > +		return dev_err_probe(dev, -ENODEV, "Unexpected chip ID: %x\n", reg_v=
al);
> > +
> > +	ret =3D regmap_read(ptn->regmap, PTN36502_CHIP_REVISION_REG,
> > +			  &reg_val);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to read chip revision\n");
> > +
> > +	dev_dbg(dev, "Chip revision: base layer version %lx, metal layer vers=
ion %lx\n",
> > +		PTN36502_CHIP_REVISION_BASE(reg_val),
> > +		PTN36502_CHIP_REVISION_METAL(reg_val));
> > +
> > +	return 0;
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
> > +static int ptn36502_bridge_attach(struct drm_bridge *bridge,
> > +				    enum drm_bridge_attach_flags flags)
>
> I applied this patch and realised that that's not correctly aligned.
> There are couple of extra spaces.
>
> > +{
> > +	struct ptn36502 *ptn =3D container_of(bridge, struct ptn36502, bridge=
);
> > +	struct drm_bridge *next_bridge;
> > +
> > +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> > +		return -EINVAL;
> > +
> > +	next_bridge =3D devm_drm_of_get_bridge(&ptn->client->dev, ptn->client=
->dev.of_node, 0, 0);
> > +	if (IS_ERR(next_bridge)) {
> > +		dev_err(&ptn->client->dev, "failed to acquire drm_bridge: %pe\n", ne=
xt_bridge);
> > +		return PTR_ERR(next_bridge);
> > +	}
> > +
> > +	return drm_bridge_attach(bridge->encoder, next_bridge, bridge,
> > +				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> > +}
> > +
> > +static const struct drm_bridge_funcs ptn36502_bridge_funcs =3D {
> > +	.attach	=3D ptn36502_bridge_attach,
> > +};
> > +
> > +static int ptn36502_register_bridge(struct ptn36502 *ptn)
> > +{
> > +	ptn->bridge.funcs =3D &ptn36502_bridge_funcs;
> > +	ptn->bridge.of_node =3D ptn->client->dev.of_node;
> > +
> > +	return devm_drm_bridge_add(&ptn->client->dev, &ptn->bridge);
> > +}
> > +#else
> > +static int ptn36502_register_bridge(struct ptn36502 *ptn)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static const struct regmap_config ptn36502_regmap =3D {
> > +	.max_register =3D 0x0d,
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +};
> > +
> > +static int ptn36502_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev =3D &client->dev;
> > +	struct typec_switch_desc sw_desc =3D { };
> > +	struct typec_retimer_desc retimer_desc =3D { };
> > +	struct ptn36502 *ptn;
> > +	int ret;
> > +
> > +	ptn =3D devm_kzalloc(dev, sizeof(*ptn), GFP_KERNEL);
> > +	if (!ptn)
> > +		return -ENOMEM;
> > +
> > +	ptn->client =3D client;
> > +
> > +	ptn->regmap =3D devm_regmap_init_i2c(client, &ptn36502_regmap);
> > +	if (IS_ERR(ptn->regmap)) {
> > +		dev_err(&client->dev, "Failed to allocate register map\n");
> > +		return PTR_ERR(ptn->regmap);
> > +	}
> > +
> > +	ptn->mode =3D TYPEC_STATE_SAFE;
> > +	ptn->orientation =3D TYPEC_ORIENTATION_NONE;
> > +
> > +	mutex_init(&ptn->lock);
> > +
> > +	ptn->vdd18_supply =3D devm_regulator_get_optional(dev, "vdd18");
> > +	if (IS_ERR(ptn->vdd18_supply))
> > +		return PTR_ERR(ptn->vdd18_supply);
> > +
> > +	ptn->typec_switch =3D fwnode_typec_switch_get(dev->fwnode);
> > +	if (IS_ERR(ptn->typec_switch))
> > +		return dev_err_probe(dev, PTR_ERR(ptn->typec_switch),
> > +				     "Failed to acquire orientation-switch\n");
> > +
> > +	ret =3D regulator_enable(ptn->vdd18_supply);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable vdd18\n");
> > +
> > +	ret =3D ptn36502_detect(ptn);
> > +	if (ret)
> > +		goto err_disable_regulator;
> > +
> > +	ret =3D ptn36502_register_bridge(ptn);
> > +	if (ret)
> > +		goto err_disable_regulator;
> > +
> > +	sw_desc.drvdata =3D ptn;
> > +	sw_desc.fwnode =3D dev->fwnode;
> > +	sw_desc.set =3D ptn36502_sw_set;
> > +
> > +	ptn->sw =3D typec_switch_register(dev, &sw_desc);
> > +	if (IS_ERR(ptn->sw)) {
> > +		ret =3D dev_err_probe(dev, PTR_ERR(ptn->sw),
> > +				    "Failed to register typec switch\n");
> > +		goto err_disable_regulator;
> > +	}
> > +
> > +	retimer_desc.drvdata =3D ptn;
> > +	retimer_desc.fwnode =3D dev->fwnode;
> > +	retimer_desc.set =3D ptn36502_retimer_set;
> > +
> > +	ptn->retimer =3D typec_retimer_register(dev, &retimer_desc);
> > +	if (IS_ERR(ptn->retimer)) {
> > +		ret =3D dev_err_probe(dev, PTR_ERR(ptn->retimer),
> > +				    "Failed to register typec retimer\n");
> > +		goto err_switch_unregister;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_switch_unregister:
> > +	typec_switch_unregister(ptn->sw);
> > +
> > +err_disable_regulator:
> > +	regulator_disable(ptn->vdd18_supply);
> > +
> > +	return ret;
> > +}
> > +
> > +static void ptn36502_remove(struct i2c_client *client)
> > +{
> > +	struct ptn36502 *ptn =3D i2c_get_clientdata(client);
> > +
> > +	typec_retimer_unregister(ptn->retimer);
> > +	typec_switch_unregister(ptn->sw);
> > +
> > +	regulator_disable(ptn->vdd18_supply);
> > +}
> > +
> > +static const struct i2c_device_id ptn36502_table[] =3D {
> > +	{ "ptn36502" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ptn36502_table);
> > +
> > +static const struct of_device_id ptn36502_of_table[] =3D {
> > +	{ .compatible =3D "nxp,ptn36502" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ptn36502_of_table);
> > +
> > +static struct i2c_driver ptn36502_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "ptn36502",
> > +		.of_match_table =3D ptn36502_of_table,
> > +	},
> > +	.probe		=3D ptn36502_probe,
> > +	.remove		=3D ptn36502_remove,
> > +	.id_table	=3D ptn36502_table,
> > +};
> > +module_i2c_driver(ptn36502_driver);
> > +
> > +MODULE_AUTHOR("Luca Weiss <luca.weiss@fairphone.com>");
> > +MODULE_DESCRIPTION("NXP PTN36502 Type-C driver");
> > +MODULE_LICENSE("GPL");
>
> thanks,

