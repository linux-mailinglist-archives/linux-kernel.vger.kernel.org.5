Return-Path: <linux-kernel+bounces-7237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EF181A38A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3C5B2755B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7E482D9;
	Wed, 20 Dec 2023 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dtk5bSUS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50F482C9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703087966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFekkLOHfS9CYH1irDgUqE2noE0/6vpj/TYA4n1czRU=;
	b=Dtk5bSUS+X+Ghj4YEu5m/2Qf6J+knKGVrwEWAxr5Z1FO75ZuHuzSH53VGWgvS6V8yjv7zf
	Q+SMdfo6JcsAAw+W4qnbr5NUn6Ld6xPc5tnNxRx2EaX4oTnwqxeXK6c0AsdojX2VkwgODL
	UKVFwfy2zMU5MtJNJ7aEF9pu63cqluY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-EyhpgeHWNSeGZtjFZeLMYA-1; Wed, 20 Dec 2023 10:59:24 -0500
X-MC-Unique: EyhpgeHWNSeGZtjFZeLMYA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dbad18d6d5so488100a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703087964; x=1703692764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFekkLOHfS9CYH1irDgUqE2noE0/6vpj/TYA4n1czRU=;
        b=A/WjSN/Ll8EbpECQT8TVV31vzVyZmZLzd/FSPPfvR8rrV5nlCwbj3Bk6Jz+WZfhS+6
         hxU+WMIGIIJfuM78Z/N76kx2tNT6R9iE4UtoUAUf+5BLa44s078TwlSmdPR8SEv/QYn4
         VtGRM1pi/g9wVLp1F1K98WQoLsi2+Xt5piTVEC5ehgkLKFnez6RtgHgH3T9sAFcfnrAs
         L7GTd56GaCRbN7zqMfvQL8t+DyoZQCLlQyBPx7hRNdCH/7V45shPQ+/hlwMsiifwqXLV
         tOmc9xuIVHYXgrJ01w4na8MANuf3z9raIoFV6rQeRZC26c8+fitwoYKyop9B+QOjHdGA
         zvlQ==
X-Gm-Message-State: AOJu0YyLp2xVhcL0dHQZ/kbsmJQK+Tvw9WTLY0KOLZtZ7g8nbM5rImmy
	psb0O769LGj9/Hlor4ybjZ7oc6/2CDIolA9uzj3gG1x9cAXhnkYJFIkKcjLy1vfAHpGsMLTyOf3
	4Yc2WnBUvbWU0DkXoXoCo41SZ
X-Received: by 2002:a05:6808:3a09:b0:3a7:6213:6897 with SMTP id gr9-20020a0568083a0900b003a762136897mr18486016oib.11.1703087963852;
        Wed, 20 Dec 2023 07:59:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyXE0D9wJpfoVdm7QRffLwuE2S8IrTtR9VN2B+Knu+scUActUZX4vewE4I3XtDRyBzU1hqag==
X-Received: by 2002:a05:6808:3a09:b0:3a7:6213:6897 with SMTP id gr9-20020a0568083a0900b003a762136897mr18486005oib.11.1703087963567;
        Wed, 20 Dec 2023 07:59:23 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id y8-20020ad45308000000b0067f032cf59bsm6251098qvr.27.2023.12.20.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:59:23 -0800 (PST)
Date: Wed, 20 Dec 2023 09:59:20 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH net-next] net: stmmac: dwmac-qcom-ethqos: Add support for
 2.5G SGMII
Message-ID: <wvzhz4fmtheculsiag4t2pn2kaggyle2mzhvawbs4m5isvqjto@lmaonvq3c3e7>
References: <20231218071118.21879-1-quic_snehshah@quicinc.com>
 <4zbf5fmijxnajk7kygcjrcusf6tdnuzsqqboh23nr6f3rb3c4g@qkfofhq7jmv6>
 <8b80ab09-8444-4c3d-83b0-c7dbf5e58658@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b80ab09-8444-4c3d-83b0-c7dbf5e58658@quicinc.com>

On Wed, Dec 20, 2023 at 01:02:45PM +0530, Sneh Shah wrote:
> 
> 
> On 12/18/2023 9:50 PM, Andrew Halaney wrote:
> > On Mon, Dec 18, 2023 at 12:41:18PM +0530, Sneh Shah wrote:
> >> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
> >> mode for 1G/100M/10M speed.
> >> Added changes to configure serdes phy and mac based on link speed.
> >>
> >> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> >> ---
> >>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 31 +++++++++++++++++--
> >>  1 file changed, 29 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> >> index d3bf42d0fceb..b3a28dc19161 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> >> @@ -21,6 +21,7 @@
> >>  #define RGMII_IO_MACRO_CONFIG2		0x1C
> >>  #define RGMII_IO_MACRO_DEBUG1		0x20
> >>  #define EMAC_SYSTEM_LOW_POWER_DEBUG	0x28
> >> +#define ETHQOS_MAC_AN_CTRL		0xE0
> >>  
> >>  /* RGMII_IO_MACRO_CONFIG fields */
> >>  #define RGMII_CONFIG_FUNC_CLK_EN		BIT(30)
> >> @@ -78,6 +79,10 @@
> >>  #define ETHQOS_MAC_CTRL_SPEED_MODE		BIT(14)
> >>  #define ETHQOS_MAC_CTRL_PORT_SEL		BIT(15)
> >>  
> >> +/*ETHQOS_MAC_AN_CTRL bits */
> >> +#define ETHQOS_MAC_AN_CTRL_RAN			BIT(9)
> >> +#define ETHQOS_MAC_AN_CTRL_ANE			BIT(12)
> >> +
> > 
> > nit: space please add a space before ETHQOS_MAC_AN_CTRL
> > 
> will take care of this in next patch
> 
> >>  struct ethqos_emac_por {
> >>  	unsigned int offset;
> >>  	unsigned int value;
> >> @@ -109,6 +114,7 @@ struct qcom_ethqos {
> >>  	unsigned int num_por;
> >>  	bool rgmii_config_loopback_en;
> >>  	bool has_emac_ge_3;
> >> +	unsigned int serdes_speed;

Another nit as I look closer: I think this should be grouped by phy_mode
etc just for readability.

> >>  };
> >>  
> >>  static int rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
> >> @@ -600,27 +606,47 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
> >>  
> >>  static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
> >>  {
> >> -	int val;
> >> -
> >> +	int val, mac_an_value;
> >>  	val = readl(ethqos->mac_base + MAC_CTRL_REG);
> >> +	mac_an_value = readl(ethqos->mac_base + ETHQOS_MAC_AN_CTRL);
> >>  
> >>  	switch (ethqos->speed) {
> >> +	case SPEED_2500:
> >> +		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
> >> +		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> >> +			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> >> +			      RGMII_IO_MACRO_CONFIG2);
> >> +		if (ethqos->serdes_speed != SPEED_2500)
> >> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> >> +		mac_an_value &= ~ETHQOS_MAC_AN_CTRL_ANE;
> >> +		break;
> >>  	case SPEED_1000:
> >>  		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
> >>  		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> >>  			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> >>  			      RGMII_IO_MACRO_CONFIG2);
> >> +		if (ethqos->serdes_speed != SPEED_1000)
> >> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> >> +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
> >>  		break;
> >>  	case SPEED_100:
> >>  		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
> >> +		if (ethqos->serdes_speed != SPEED_1000)
> >> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> >> +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
> >>  		break;
> >>  	case SPEED_10:
> >>  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
> >>  		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
> >> +		if (ethqos->serdes_speed != SPEED_1000)
> >> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> >> +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
> >>  		break;
> >>  	}
> >>  
> >>  	writel(val, ethqos->mac_base + MAC_CTRL_REG);
> >> +	writel(mac_an_value, ethqos->mac_base + ETHQOS_MAC_AN_CTRL);
> >> +	ethqos->serdes_speed = ethqos->speed;
> > 
> > I see these bits are generic and there's some functions in stmmac_pcs.h
> > that muck with these...
> > 
> > Could you help me understand if this really should be Qualcomm specific,
> > or if this is something that should be considered for the more core bits
> > of the driver? I feel in either case we should take advantage of the
> > common definitions in that file if possible.
> > 
> we do have function dwmac_ctrl_ane in core driver which updates same registers. However, it does not have the option to reset ANE bit, it can only set bits. For SPEED_2500 we need to reset ANE bit. Hence I am adding it here. Not sure if we can extend dwmac_ctrl_ane function to reset bits as well.

I'd evaluate if you can update that function to clear the ANE bit when
the ane boolean is false. From the usage I see I feel that makes sense,
but correct me if you think I'm wrong.
At the very least let's use the defines from there, and possibly add a
new function if clearing is not acceptable in dwmac_ctrl_ane().

Stepping back, I was asking in general is the need to muck with ANE here
is a Qualcomm specific problem, or is that a generic thing that should be
handled in the core (and the phy_set_speed() bit stay here)? i.e. would
any dwmac5 based IP need to do something like this for SPEED_2500?

> >>  
> >>  	return val;
> >>  }
> >> @@ -789,6 +815,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
> >>  				     "Failed to get serdes phy\n");
> >>  
> >>  	ethqos->speed = SPEED_1000;
> >> +	ethqos->serdes_speed = SPEED_1000;
> >>  	ethqos_update_link_clk(ethqos, SPEED_1000);
> >>  	ethqos_set_func_clk_en(ethqos);
> >>  
> >> -- 
> >> 2.17.1
> >>
> > 
> 


