Return-Path: <linux-kernel+bounces-22161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE6829A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8921C21E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C954482CF;
	Wed, 10 Jan 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KRnE8B23"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5347F7D;
	Wed, 10 Jan 2024 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i1zK7gMFEDaJBzPaWdSQA2i995W/0/mK+MVlYIdQoGQ=; b=KRnE8B23fheJEM7RsDSmzMOCZY
	IHtF9KftesJrPhSF/toSxCOyamyOxbn8l55c+5PhLTvXfIZ95yvIBL/Yu7OxLpLtnBQJ3vSsOphnq
	l2QH+aXDPYsj/QDns+n99meY2u8Bx4O/J3vrLoJ8DwQZz5GQkOXwOGYiDbmXYrjqqXD2JGPEftB3i
	E1EUHzXMaO8G5fs2KfEyIEyoBVo6gEmqIGwwJfYeJgBB3/Eb7aTchhrTvq7NOx5yXEHj3NYN2JyKu
	9EwcdYOe8WN8RO7B8jXfx0kfh83Di/1ODgy5kliEhX2iaEwwtc7JAoQz5Fnu506fwpH8JMQdzQJbC
	PabXhyvA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35818)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNXXW-0005Mr-0S;
	Wed, 10 Jan 2024 12:18:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNXXW-0005Ib-Do; Wed, 10 Jan 2024 12:18:34 +0000
Date: Wed, 10 Jan 2024 12:18:34 +0000
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
Subject: Re: [PATCH net-next 18/20] net: ethernet: qualcomm: Add PPE MAC
 support for phylink
Message-ID: <ZZ6LGiSde4hHM+6j@shell.armlinux.org.uk>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110114033.32575-19-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110114033.32575-19-quic_luoj@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 10, 2024 at 07:40:30PM +0800, Luo Jie wrote:
> +static void ppe_phylink_mac_link_up(struct ppe_device *ppe_dev, int port,
> +				    struct phy_device *phy,
> +				    unsigned int mode, phy_interface_t interface,
> +				    int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct phylink_pcs *pcs = ppe_phylink_mac_select_pcs(ppe_dev, port, interface);
> +	struct ppe_uniphy *uniphy = pcs_to_ppe_uniphy(pcs);
> +	struct ppe_port *ppe_port = ppe_port_get(ppe_dev, port);
> +
> +	/* Wait uniphy auto-negotiation completion */
> +	ppe_uniphy_autoneg_complete_check(uniphy, port);

Way too late...

> @@ -352,6 +1230,12 @@ static int ppe_port_maxframe_set(struct ppe_device *ppe_dev,
>  }
>  
>  static struct ppe_device_ops qcom_ppe_ops = {
> +	.phylink_setup = ppe_phylink_setup,
> +	.phylink_destroy = ppe_phylink_destroy,
> +	.phylink_mac_config = ppe_phylink_mac_config,
> +	.phylink_mac_link_up = ppe_phylink_mac_link_up,
> +	.phylink_mac_link_down = ppe_phylink_mac_link_down,
> +	.phylink_mac_select_pcs = ppe_phylink_mac_select_pcs,
>  	.set_maxframe = ppe_port_maxframe_set,
>  };

Why this extra layer of abstraction? If you need separate phylink
operations, why not implement separate phylink_mac_ops structures?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

