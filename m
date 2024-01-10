Return-Path: <linux-kernel+bounces-22158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732B6829A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C643FB20E62
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380C6481D8;
	Wed, 10 Jan 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BPlam8zE"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E473481CE;
	Wed, 10 Jan 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g6FjsW6gcbXoo05ZiR/fBosPgD4QkGHgrQaNDBsI150=; b=BPlam8zEPkslhcOpMUX+3qp+Qd
	GEVWvYIJ9xXV2E37LMPwaRL/BJglsLq9bWd7iHFzmiI8tCj+ukcAeTgLlIkT+SZo/HP8cz41cPOWA
	kWQ2KPnnQSZiHXKsKGZAPrzgJmM81m0KuOaTgvGqx3o+sVZvYAA0WkeXDXVKk15X8qDIhjIuDAdZl
	kgSYYcK+pd7UACB2sIZmpc5MRxhjFwi9YKI9JolKoB9Ec6qvhjXVEmOoNWcjMnpQOm+VWjJtTiM08
	/xnzxrhSTxHGmQWLvWx/bnCnEg+j6o2OU35h3elunp0+eKiNAKPeVIvTBY92MXcCWBQwufYQDiwe1
	qZqSvexg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56506)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNXP2-0005Lc-2a;
	Wed, 10 Jan 2024 12:09:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNXOy-0005IK-BV; Wed, 10 Jan 2024 12:09:44 +0000
Date: Wed, 10 Jan 2024 12:09:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
	p.zabel@pengutronix.de, shannon.nelson@amd.com,
	anthony.l.nguyen@intel.com, jasowang@redhat.com,
	brett.creeley@amd.com, rrameshbabu@nvidia.com,
	joshua.a.hay@intel.com, arnd@arndb.de, geert+renesas@glider.be,
	neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
	nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
	jacob.e.keller@intel.com, andrew@lunn.ch, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ryazanov.s.a@gmail.com,
	ansuelsmth@gmail.com, quic_kkumarcs@quicinc.com,
	quic_suruchia@quicinc.com, quic_soni@quicinc.com,
	quic_pavir@quicinc.com, quic_souravp@quicinc.com,
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com
Subject: Re: [PATCH net-next 17/20] net: ethernet: qualcomm: Add PPE UNIPHY
 support for phylink
Message-ID: <ZZ6JCIQSimPy0TVY@shell.armlinux.org.uk>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110114033.32575-18-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110114033.32575-18-quic_luoj@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 10, 2024 at 07:40:29PM +0800, Luo Jie wrote:
> +static int clk_uniphy_set_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long parent_rate)
> +{
> +	struct clk_uniphy *uniphy = to_clk_uniphy(hw);
> +
> +	if (rate != UNIPHY_CLK_RATE_125M && rate != UNIPHY_CLK_RATE_312P5M)
> +		return -1;

Sigh. I get very annoyed off by stuff like this. It's lazy programming,
and makes me wonder why I should be bothered to spend time reviewing if
the programmer can't be bothered to pay attention to details. It makes
me wonder what else is done lazily in the patch.

-1 is -EPERM "Operation not permitted". This is highly likely not an
appropriate error code for this code.

> +int ppe_uniphy_autoneg_complete_check(struct ppe_uniphy *uniphy, int port)
> +{
> +	u32 reg, val;
> +	int channel, ret;
> +
> +	if (uniphy->interface == PHY_INTERFACE_MODE_USXGMII ||
> +	    uniphy->interface == PHY_INTERFACE_MODE_QUSGMII) {
> +		/* Only uniphy0 may have multi channels */
> +		channel = (uniphy->index == 0) ? (port - 1) : 0;
> +		reg = (channel == 0) ? VR_MII_AN_INTR_STS_ADDR :
> +		       VR_MII_AN_INTR_STS_CHANNEL_ADDR(channel);
> +
> +		/* Wait auto negotiation complete */
> +		ret = read_poll_timeout(ppe_uniphy_read, val,
> +					(val & CL37_ANCMPLT_INTR),
> +					1000, 100000, true,
> +					uniphy, reg);
> +		if (ret) {
> +			dev_err(uniphy->ppe_dev->dev,
> +				"uniphy %d auto negotiation timeout\n", uniphy->index);
> +			return ret;
> +		}
> +
> +		/* Clear auto negotiation complete interrupt */
> +		ppe_uniphy_mask(uniphy, reg, CL37_ANCMPLT_INTR, 0);
> +	}
> +
> +	return 0;
> +}

Why is this necessary? Why is it callable outside this file? Shouldn't
this be done in the .pcs_get_state method? If negotiation hasn't
completed (and negotiation is being used) then .pcs_get_state should not
report that the link is up.

> +
> +int ppe_uniphy_speed_set(struct ppe_uniphy *uniphy, int port, int speed)
> +{
> +	u32 reg, val;
> +	int channel;
> +
> +	if (uniphy->interface == PHY_INTERFACE_MODE_USXGMII ||
> +	    uniphy->interface == PHY_INTERFACE_MODE_QUSGMII) {
> +		/* Only uniphy0 may have multiple channels */
> +		channel = (uniphy->index == 0) ? (port - 1) : 0;
> +
> +		reg = (channel == 0) ? SR_MII_CTRL_ADDR :
> +		       SR_MII_CTRL_CHANNEL_ADDR(channel);
> +
> +		switch (speed) {
> +		case SPEED_100:
> +			val = USXGMII_SPEED_100;
> +			break;
> +		case SPEED_1000:
> +			val = USXGMII_SPEED_1000;
> +			break;
> +		case SPEED_2500:
> +			val = USXGMII_SPEED_2500;
> +			break;
> +		case SPEED_5000:
> +			val = USXGMII_SPEED_5000;
> +			break;
> +		case SPEED_10000:
> +			val = USXGMII_SPEED_10000;
> +			break;
> +		case SPEED_10:
> +			val = USXGMII_SPEED_10;
> +			break;
> +		default:
> +			val = 0;
> +			break;
> +		}
> +
> +		ppe_uniphy_mask(uniphy, reg, USXGMII_SPEED_MASK, val);
> +	}
> +
> +	return 0;
> +}
> +
> +int ppe_uniphy_duplex_set(struct ppe_uniphy *uniphy, int port, int duplex)
> +{
> +	u32 reg;
> +	int channel;
> +
> +	if (uniphy->interface == PHY_INTERFACE_MODE_USXGMII &&
> +	    uniphy->interface == PHY_INTERFACE_MODE_QUSGMII) {
> +		/* Only uniphy0 may have multiple channels */
> +		channel = (uniphy->index == 0) ? (port - 1) : 0;
> +
> +		reg = (channel == 0) ? SR_MII_CTRL_ADDR :
> +		       SR_MII_CTRL_CHANNEL_ADDR(channel);
> +
> +		ppe_uniphy_mask(uniphy, reg, USXGMII_DUPLEX_FULL,
> +				(duplex == DUPLEX_FULL) ? USXGMII_DUPLEX_FULL : 0);
> +	}
> +
> +	return 0;
> +}

What calls the above two functions? Surely this should be called from
the .pcs_link_up method? I would also imagine that you call each of
these consecutively. So why not modify the register in one go rather
than piecemeal like this. I'm not a fan of one-function-to-control-one-
parameter-in-a-register style when it results in more register accesses
than are really necessary.

> +static void ppe_pcs_get_state(struct phylink_pcs *pcs,
> +			      struct phylink_link_state *state)
> +{
> +	struct ppe_uniphy *uniphy = pcs_to_ppe_uniphy(pcs);
> +	u32 val;
> +
> +	switch (state->interface) {
> +	case PHY_INTERFACE_MODE_10GBASER:
> +		val = ppe_uniphy_read(uniphy, SR_XS_PCS_KR_STS1_ADDR);
> +		state->link = (val & SR_XS_PCS_KR_STS1_PLU) ? 1 : 0;

Unnecessary tenary operation.

		state->link = !!(val & SR_XS_PCS_KR_STS1_PLU);

> +		state->duplex = DUPLEX_FULL;
> +		state->speed = SPEED_10000;
> +		state->pause |= (MLO_PAUSE_RX | MLO_PAUSE_TX);

Excessive parens.

> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		val = ppe_uniphy_read(uniphy, UNIPHY_CHANNEL0_INPUT_OUTPUT_6_ADDR);
> +		state->link = (val & NEWADDEDFROMHERE_CH0_LINK_MAC) ? 1 : 0;

Ditto.

> +		state->duplex = DUPLEX_FULL;
> +		state->speed = SPEED_2500;
> +		state->pause |= (MLO_PAUSE_RX | MLO_PAUSE_TX);

Ditto.

> +		break;
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_SGMII:
> +		val = ppe_uniphy_read(uniphy, UNIPHY_CHANNEL0_INPUT_OUTPUT_6_ADDR);
> +		state->link = (val & NEWADDEDFROMHERE_CH0_LINK_MAC) ? 1 : 0;
> +		state->duplex = (val & NEWADDEDFROMHERE_CH0_DUPLEX_MODE_MAC) ?
> +			DUPLEX_FULL : DUPLEX_HALF;
> +		if (FIELD_GET(NEWADDEDFROMHERE_CH0_SPEED_MODE_MAC, val) == UNIPHY_SPEED_10M)
> +			state->speed = SPEED_10;
> +		else if (FIELD_GET(NEWADDEDFROMHERE_CH0_SPEED_MODE_MAC, val) == UNIPHY_SPEED_100M)
> +			state->speed = SPEED_100;
> +		else if (FIELD_GET(NEWADDEDFROMHERE_CH0_SPEED_MODE_MAC, val) == UNIPHY_SPEED_1000M)
> +			state->speed = SPEED_1000;

Looks like a switch(FIELD_GET(NEWADDEDFROMHERE_CH0_SPEED_MODE_MAC, val)
would be better here. Also "NEWADDEDFROMHERE" ?

> +		state->pause |= (MLO_PAUSE_RX | MLO_PAUSE_TX);

Ditto.

As you make no differentiation between 1000base-X and SGMII, I question
whether your hardware supports 1000base-X. I seem to recall in previous
discussions that it doesn't. So, that means it doesn't support the
inband negotiation word format for 1000base-X. Thus, 1000base-X should
not be included in any of these switch statements, and 1000base-X won't
be usable.

> +/* [register] UNIPHY_MODE_CTRL */
> +#define UNIPHY_MODE_CTRL_ADDR				0x46c
> +#define NEWADDEDFROMHERE_CH0_AUTONEG_MODE		BIT(0)
> +#define NEWADDEDFROMHERE_CH1_CH0_SGMII			BIT(1)
> +#define NEWADDEDFROMHERE_CH4_CH1_0_SGMII		BIT(2)
> +#define NEWADDEDFROMHERE_SGMII_EVEN_LOW			BIT(3)
> +#define NEWADDEDFROMHERE_CH0_MODE_CTRL_25M		GENMASK(6, 4)
> +#define NEWADDEDFROMHERE_CH0_QSGMII_SGMII		BIT(8)
> +#define NEWADDEDFROMHERE_CH0_PSGMII_QSGMII		BIT(9)
> +#define NEWADDEDFROMHERE_SG_MODE			BIT(10)
> +#define NEWADDEDFROMHERE_SGPLUS_MODE			BIT(11)
> +#define NEWADDEDFROMHERE_XPCS_MODE			BIT(12)
> +#define NEWADDEDFROMHERE_USXG_EN			BIT(13)
> +#define NEWADDEDFROMHERE_SW_V17_V18			BIT(15)

Again, why "NEWADDEDFROMHERE" ?

> +/* [register] VR_XS_PCS_EEE_MCTRL0 */
> +#define VR_XS_PCS_EEE_MCTRL0_ADDR			0x38006
> +#define LTX_EN						BIT(0)
> +#define LRX_EN						BIT(1)
> +#define SIGN_BIT					BIT(6)

"SIGN_BIT" is likely too generic a name.

> +#define MULT_FACT_100NS					GENMASK(11, 8)
> +
> +/* [register] VR_XS_PCS_KR_CTRL */
> +#define VR_XS_PCS_KR_CTRL_ADDR	0x38007
> +#define USXG_MODE					GENMASK(12, 10)
> +#define QUXGMII_MODE					(FIELD_PREP(USXG_MODE, 0x5))
> +
> +/* [register] VR_XS_PCS_EEE_TXTIMER */
> +#define VR_XS_PCS_EEE_TXTIMER_ADDR			0x38008
> +#define TSL_RES						GENMASK(5, 0)
> +#define T1U_RES						GENMASK(7, 6)
> +#define TWL_RES						GENMASK(12, 8)
> +#define UNIPHY_XPCS_TSL_TIMER				(FIELD_PREP(TSL_RES, 0xa))
> +#define UNIPHY_XPCS_T1U_TIMER				(FIELD_PREP(TSL_RES, 0x3))
> +#define UNIPHY_XPCS_TWL_TIMER				(FIELD_PREP(TSL_RES, 0x16))
> +
> +/* [register] VR_XS_PCS_EEE_RXTIMER  */
> +#define VR_XS_PCS_EEE_RXTIMER_ADDR			0x38009
> +#define RES_100U					GENMASK(7, 0)
> +#define TWR_RES						GENMASK(13, 8)
> +#define UNIPHY_XPCS_100US_TIMER				(FIELD_PREP(RES_100U, 0xc8))
> +#define UNIPHY_XPCS_TWR_TIMER				(FIELD_PREP(RES_100U, 0x1c))
> +
> +/* [register] VR_XS_PCS_DIG_STS */
> +#define VR_XS_PCS_DIG_STS_ADDR				0x3800a
> +#define AM_COUNT					GENMASK(14, 0)
> +#define QUXGMII_AM_COUNT				(FIELD_PREP(AM_COUNT, 0x6018))
> +
> +/* [register] VR_XS_PCS_EEE_MCTRL1 */
> +#define VR_XS_PCS_EEE_MCTRL1_ADDR			0x3800b
> +#define TRN_LPI						BIT(0)
> +#define TRN_RXLPI					BIT(8)
> +
> +/* [register] VR_MII_1_DIG_CTRL1 */
> +#define VR_MII_DIG_CTRL1_CHANNEL1_ADDR			0x1a8000
> +#define VR_MII_DIG_CTRL1_CHANNEL2_ADDR			0x1b8000
> +#define VR_MII_DIG_CTRL1_CHANNEL3_ADDR			0x1c8000
> +#define VR_MII_DIG_CTRL1_CHANNEL_ADDR(x)		(0x1a8000 + 0x10000 * ((x) - 1))
> +#define CHANNEL_USRA_RST				BIT(5)
> +
> +/* [register] VR_MII_AN_CTRL */
> +#define VR_MII_AN_CTRL_ADDR				0x1f8001
> +#define VR_MII_AN_CTRL_CHANNEL1_ADDR			0x1a8001
> +#define VR_MII_AN_CTRL_CHANNEL2_ADDR			0x1b8001
> +#define VR_MII_AN_CTRL_CHANNEL3_ADDR			0x1c8001
> +#define VR_MII_AN_CTRL_CHANNEL_ADDR(x)			(0x1a8001 + 0x10000 * ((x) - 1))
> +#define MII_AN_INTR_EN					BIT(0)
> +#define MII_CTRL					BIT(8)

Too generic a name.

> +
> +/* [register] VR_MII_AN_INTR_STS */
> +#define VR_MII_AN_INTR_STS_ADDR				0x1f8002
> +#define VR_MII_AN_INTR_STS_CHANNEL1_ADDR		0x1a8002
> +#define VR_MII_AN_INTR_STS_CHANNEL2_ADDR		0x1b8002
> +#define VR_MII_AN_INTR_STS_CHANNEL3_ADDR		0x1c8002
> +#define VR_MII_AN_INTR_STS_CHANNEL_ADDR(x)		(0x1a8002 + 0x10000 * ((x) - 1))
> +#define CL37_ANCMPLT_INTR				BIT(0)
> +
> +/* [register] VR_XAUI_MODE_CTRL */
> +#define VR_XAUI_MODE_CTRL_ADDR				0x1f8004
> +#define VR_XAUI_MODE_CTRL_CHANNEL1_ADDR			0x1a8004
> +#define VR_XAUI_MODE_CTRL_CHANNEL2_ADDR			0x1b8004
> +#define VR_XAUI_MODE_CTRL_CHANNEL3_ADDR			0x1c8004
> +#define VR_XAUI_MODE_CTRL_CHANNEL_ADDR(x)		(0x1a8004 + 0x10000 * ((x) - 1))
> +#define IPG_CHECK					BIT(0)
> +
> +/* [register] SR_MII_CTRL */
> +#define SR_MII_CTRL_ADDR				0x1f0000
> +#define SR_MII_CTRL_CHANNEL1_ADDR			0x1a0000
> +#define SR_MII_CTRL_CHANNEL2_ADDR			0x1b0000
> +#define SR_MII_CTRL_CHANNEL3_ADDR			0x1c0000
> +#define SR_MII_CTRL_CHANNEL_ADDR(x)			(0x1a0000 + 0x10000 * ((x) - 1))


> +#define AN_ENABLE					BIT(12)

Looks like MDIO_AN_CTRL1_ENABLE

> +#define USXGMII_DUPLEX_FULL				BIT(8)
> +#define USXGMII_SPEED_MASK				(BIT(13) | BIT(6) | BIT(5))
> +#define USXGMII_SPEED_10000				(BIT(13) | BIT(6))
> +#define USXGMII_SPEED_5000				(BIT(13) | BIT(5))
> +#define USXGMII_SPEED_2500				BIT(5)
> +#define USXGMII_SPEED_1000				BIT(6)
> +#define USXGMII_SPEED_100				BIT(13)
> +#define USXGMII_SPEED_10				0

Looks rather like the standard IEEE 802.3 definitions except for the
2.5G and 5G speeds. Probably worth a comment stating that they're
slightly different.

> +
> +/* PPE UNIPHY data type */
> +struct ppe_uniphy {
> +	void __iomem *base;
> +	struct ppe_device *ppe_dev;
> +	unsigned int index;
> +	phy_interface_t interface;
> +	struct phylink_pcs pcs;
> +};
> +
> +#define pcs_to_ppe_uniphy(_pcs)				container_of(_pcs, struct ppe_uniphy, pcs)

As this should only be used in the .c file, I suggest making this a
static function in the .c file. There should be no requirement to use
it outside of the .c file.

> +
> +struct ppe_uniphy *ppe_uniphy_setup(struct platform_device *pdev);
> +
> +int ppe_uniphy_speed_set(struct ppe_uniphy *uniphy,
> +			 int port, int speed);
> +
> +int ppe_uniphy_duplex_set(struct ppe_uniphy *uniphy,
> +			  int port, int duplex);
> +
> +int ppe_uniphy_adapter_reset(struct ppe_uniphy *uniphy,
> +			     int port);
> +
> +int ppe_uniphy_autoneg_complete_check(struct ppe_uniphy *uniphy,
> +				      int port);
> +
> +int ppe_uniphy_port_gcc_clock_en_set(struct ppe_uniphy *uniphy,
> +				     int port, bool enable);
> +
> +#endif /* _PPE_UNIPHY_H_ */
> diff --git a/include/linux/soc/qcom/ppe.h b/include/linux/soc/qcom/ppe.h
> index 268109c823ad..d3cb18df33fa 100644
> --- a/include/linux/soc/qcom/ppe.h
> +++ b/include/linux/soc/qcom/ppe.h
> @@ -20,6 +20,7 @@ struct ppe_device {
>  	struct dentry *debugfs_root;
>  	bool is_ppe_probed;
>  	void *ppe_priv;
> +	void *uniphy;

Not struct ppe_uniphy *uniphy? You can declare the struct before use
via:

struct ppe_uniphy;

so you don't need to include ppe_uniphy.h in this header.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

