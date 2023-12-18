Return-Path: <linux-kernel+bounces-4068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FD881778C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB53B222AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180394FF7B;
	Mon, 18 Dec 2023 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvsYD/nh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A84FF86
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702917070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gyklUaQH9+w5u3EWbqqNdNPWrEzxqS/e6qwVBUpXKmQ=;
	b=BvsYD/nhiEY6EyXgK1hhE6SZ3J/nyRX3n6zu/TBLC62nsdEpUTqsVAxNypw1IAPhmeBiNc
	v9JyfkhwDb9uc4+jS2rXUXxzlCfA8atl5d2+a0SFJQBH5RcsKOtZVkoS23Qz2xABhFqZYU
	92AwwYKpWimGybQLbncz5l/sgP6GBVk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-LHu776C4NSq6cfrbn2BSqA-1; Mon, 18 Dec 2023 11:31:08 -0500
X-MC-Unique: LHu776C4NSq6cfrbn2BSqA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67f4a0c8fb2so10707216d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917068; x=1703521868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyklUaQH9+w5u3EWbqqNdNPWrEzxqS/e6qwVBUpXKmQ=;
        b=wGtzNW3fjY/SsI9juMeH7zHA4x5suPA38GZ8ZLF69j6Ey3zvP6qDmcIdPzNroT0kYZ
         nhlKsIP86mEuHtwqu3cMJegB6UgfBASj71itAH/RePphOd8stQcu62wNe33TZJcZ5o52
         w/1APL3ZYyG67xbMc3z0e/0Jl+Lox73Y2h0rLRTZ/ZNfDtTtfktq4QXNriMsVPHgIF+/
         khzk1MVPyKXfwKvyuFgjyRivKkDYYoeyu/UKGLrom+J1g+eZhPHEYwALLrI8a7Neleof
         t17X2lvKw23x4tESc4KKQMiQCWiGwtfsHSw65bsUEKG/43t0b0zT7sZZL8fNNpK+tp/i
         d2ww==
X-Gm-Message-State: AOJu0YyTvTgVZ4g2GZFw1nnSrygoCgYAmA4G/93+qfkNpGpEtBCGfL4E
	UWhzad8UWcBfRrlWpPuCljjZvVGyISeNakuaXKeHqosQP1nK4ybRazMZ7lhcggVyEr+qBx0Kg9o
	LLXSdA5tlAYQoErVyOgSMvbM7
X-Received: by 2002:a05:6214:2262:b0:67f:4c0:59f0 with SMTP id gs2-20020a056214226200b0067f04c059f0mr13283879qvb.77.1702917068352;
        Mon, 18 Dec 2023 08:31:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYtPAkjW+suWvwLO6oqUyWkHoZlf2OBTm+xBUTH5nyvhqcUjD5pspfwg2Sp3Pu/DNpwnTBEA==
X-Received: by 2002:a05:6214:2262:b0:67f:4c0:59f0 with SMTP id gs2-20020a056214226200b0067f04c059f0mr13283848qvb.77.1702917068034;
        Mon, 18 Dec 2023 08:31:08 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id bu19-20020ad455f3000000b0067f46605191sm1019502qvb.56.2023.12.18.08.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:31:07 -0800 (PST)
Date: Mon, 18 Dec 2023 10:31:04 -0600
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
Message-ID: <pdoedu3n7rdl6ifrfyugoa7pbjougqj4cg6mxyerhu5udf4e2h@unjqgqjt7odi>
References: <20231218071118.21879-1-quic_snehshah@quicinc.com>
 <4zbf5fmijxnajk7kygcjrcusf6tdnuzsqqboh23nr6f3rb3c4g@qkfofhq7jmv6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4zbf5fmijxnajk7kygcjrcusf6tdnuzsqqboh23nr6f3rb3c4g@qkfofhq7jmv6>

On Mon, Dec 18, 2023 at 10:20:03AM -0600, Andrew Halaney wrote:
> On Mon, Dec 18, 2023 at 12:41:18PM +0530, Sneh Shah wrote:
> > Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
> > mode for 1G/100M/10M speed.
> > Added changes to configure serdes phy and mac based on link speed.
> > 
> > Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> > ---
> >  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 31 +++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > index d3bf42d0fceb..b3a28dc19161 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > @@ -21,6 +21,7 @@
> >  #define RGMII_IO_MACRO_CONFIG2		0x1C
> >  #define RGMII_IO_MACRO_DEBUG1		0x20
> >  #define EMAC_SYSTEM_LOW_POWER_DEBUG	0x28
> > +#define ETHQOS_MAC_AN_CTRL		0xE0
> >  
> >  /* RGMII_IO_MACRO_CONFIG fields */
> >  #define RGMII_CONFIG_FUNC_CLK_EN		BIT(30)
> > @@ -78,6 +79,10 @@
> >  #define ETHQOS_MAC_CTRL_SPEED_MODE		BIT(14)
> >  #define ETHQOS_MAC_CTRL_PORT_SEL		BIT(15)
> >  
> > +/*ETHQOS_MAC_AN_CTRL bits */
> > +#define ETHQOS_MAC_AN_CTRL_RAN			BIT(9)
> > +#define ETHQOS_MAC_AN_CTRL_ANE			BIT(12)
> > +
> 
> nit: space please add a space before ETHQOS_MAC_AN_CTRL
> 
> >  struct ethqos_emac_por {
> >  	unsigned int offset;
> >  	unsigned int value;
> > @@ -109,6 +114,7 @@ struct qcom_ethqos {
> >  	unsigned int num_por;
> >  	bool rgmii_config_loopback_en;
> >  	bool has_emac_ge_3;
> > +	unsigned int serdes_speed;
> >  };
> >  
> >  static int rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
> > @@ -600,27 +606,47 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
> >  
> >  static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
> >  {
> > -	int val;
> > -
> > +	int val, mac_an_value;
> >  	val = readl(ethqos->mac_base + MAC_CTRL_REG);
> > +	mac_an_value = readl(ethqos->mac_base + ETHQOS_MAC_AN_CTRL);
> >  
> >  	switch (ethqos->speed) {
> > +	case SPEED_2500:
> > +		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
> > +		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> > +			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> > +			      RGMII_IO_MACRO_CONFIG2);
> > +		if (ethqos->serdes_speed != SPEED_2500)
> > +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);

Also, please capture the return value here and propagate the error as
appropriate.

> > +		mac_an_value &= ~ETHQOS_MAC_AN_CTRL_ANE;
> > +		break;
> >  	case SPEED_1000:
> >  		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
> >  		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> >  			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> >  			      RGMII_IO_MACRO_CONFIG2);
> > +		if (ethqos->serdes_speed != SPEED_1000)
> > +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> > +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
> >  		break;
> >  	case SPEED_100:
> >  		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
> > +		if (ethqos->serdes_speed != SPEED_1000)
> > +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> > +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
> >  		break;
> >  	case SPEED_10:
> >  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
> >  		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
> > +		if (ethqos->serdes_speed != SPEED_1000)
> > +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> > +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
> >  		break;
> >  	}
> >  
> >  	writel(val, ethqos->mac_base + MAC_CTRL_REG);
> > +	writel(mac_an_value, ethqos->mac_base + ETHQOS_MAC_AN_CTRL);
> > +	ethqos->serdes_speed = ethqos->speed;
> 
> I see these bits are generic and there's some functions in stmmac_pcs.h
> that muck with these...
> 
> Could you help me understand if this really should be Qualcomm specific,
> or if this is something that should be considered for the more core bits
> of the driver? I feel in either case we should take advantage of the
> common definitions in that file if possible.
> 
> >  
> >  	return val;
> >  }
> > @@ -789,6 +815,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
> >  				     "Failed to get serdes phy\n");
> >  
> >  	ethqos->speed = SPEED_1000;
> > +	ethqos->serdes_speed = SPEED_1000;
> >  	ethqos_update_link_clk(ethqos, SPEED_1000);
> >  	ethqos_set_func_clk_en(ethqos);
> >  
> > -- 
> > 2.17.1
> > 


