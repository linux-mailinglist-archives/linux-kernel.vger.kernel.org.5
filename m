Return-Path: <linux-kernel+bounces-2292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 689E5815A99
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF8B1C219BF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642AC30D10;
	Sat, 16 Dec 2023 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tv5Il2gL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5731728;
	Sat, 16 Dec 2023 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FHjww8/JwxqxsdngrNpGSnmmTqKJPwi9ZbW08puInak=; b=tv5Il2gL1C6mALplFJ6c1DXf//
	h6AVYnapE5sTimAMquEf+yv4USmN58k4jF3KtOT7PCIIZGbG88KlHM8Z8ly06olorQU5VeOCtdUcL
	Yem92xDcwLs9nI2hvnJ5qNiYvk0mEgnvycqc7rwNqPwCQLCEKWKJbFriQUyS9N37Ju20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEYI6-0036tz-LE; Sat, 16 Dec 2023 18:17:30 +0100
Date: Sat, 16 Dec 2023 18:17:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, corbet@lwn.net, p.zabel@pengutronix.de,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <b5ff9f69-e341-4846-bc5a-ebe636b7a71a@lunn.ch>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <bdfba8a7-9197-4aae-a7f9-6075a375f60b@linaro.org>
 <c3391e33-e770-4c61-855e-d90e82b95f75@quicinc.com>
 <4cb2bd57-f3d3-49f9-9c02-a922fd270572@lunn.ch>
 <ed0dd288-be8a-4161-a19f-2d4d2d17b3ec@quicinc.com>
 <ZXxXzm8hP68KrXYs@shell.armlinux.org.uk>
 <3a40570b-40bf-4609-b1f4-a0a6974accea@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a40570b-40bf-4609-b1f4-a0a6974accea@quicinc.com>

> Yes, Russell, i will add an example in the DT doc in the next patch set.
> The following is the device node used for the current qca8084 PHY
> code design.

If you look at Christians work, this would be expressed differently:

> mdio: mdio@90000 {
>     ethernet-phy-package@1 {
> 
>         compatible = "qca,qca8084-package";
> 
>         qcom,phy-work-mode = <2>;
>         clocks = <&qca8k_nsscc NSS_CC_APB_BRIDGE_CLK>,
>                <&qca8k_nsscc NSS_CC_AHB_CLK>,
>                <&qca8k_nsscc NSS_CC_SEC_CTRL_AHB_CLK>,
>                <&qca8k_nsscc NSS_CC_TLMM_CLK>,
>                <&qca8k_nsscc NSS_CC_TLMM_AHB_CLK>,
>                <&qca8k_nsscc NSS_CC_CNOC_AHB_CLK>,
>                <&qca8k_nsscc NSS_CC_MDIO_AHB_CLK>,
>                <&qca8k_nsscc NSS_CC_MDIO_MASTER_AHB_CLK>,
>                <&qca8k_nsscc NSS_CC_SRDS0_SYS_CLK>,
>                <&qca8k_nsscc NSS_CC_SRDS1_SYS_CLK>;
>         clock-names = "apb_bridge",
>                 "ahb",
>                 "sec_ctrl_ahb",
>                 "tlmm",
>                 "tlmm_ahb",
>                 "cnoc_ahb",
>                 "mdio_ahb",
>                 "mdio_master_ahb",
>                 "srds0_sys",
>                 "srds1_sys";
>         resets = <&qca8k_nsscc NSS_CC_SRDS0_SYS_ARES>,
>                <&qca8k_nsscc NSS_CC_SRDS1_SYS_ARES>,
>                <&qca8k_nsscc NSS_CC_DSP_ARES>;
>         reset-names = "srds0_sys",
>                       "srds1_sys";
>

All the properties above are common to the package as a whole.

Then follow the four individual PHYs, and the properties which are
specific to each one.

> 
>         ethernet-phy@0 {
>             compatible = "ethernet-phy-id004d.d180";
>             reg = <0>;
>             clocks = <qca8k_nsscc NSS_CC_GEPHY0_SYS_CLK>,
>             clock-names = <"gephy_sys">;
>             resets = <&qca8k_nsscc NSS_CC_GEPHY0_SYS_ARES>,
>                      <&qca8k_nsscc NSS_CC_GEPHY0_ARES>;
>             reset-names = "gephy_sys", "gephy_soft";
>         };
>     
>     
>         ethernet-phy@1 {
>             compatible = "ethernet-phy-id004d.d180";
>             reg = <1>;
>             clocks = <qca8k_nsscc NSS_CC_GEPHY1_SYS_CLK>,
>             clock-names = <"gephy_sys">;
>             resets = <&qca8k_nsscc NSS_CC_GEPHY1_SYS_ARES>,
>                      <&qca8k_nsscc NSS_CC_GEPHY1_ARES>;
>             reset-names = "gephy_sys", "gephy_soft";
>     
>         };
>     
>         ethernet-phy@2 {
>             compatible = "ethernet-phy-id004d.d180";
>             reg = <2>;
>             clocks = <qca8k_nsscc NSS_CC_GEPHY2_SYS_CLK>,
>             clock-names = <"gephy_sys">;
>             resets = <&qca8k_nsscc NSS_CC_GEPHY2_SYS_ARES>,
>                      <&qca8k_nsscc NSS_CC_GEPHY2_ARES>;
>             reset-names = "gephy_sys", "gephy_soft";
>     
>         };
>     
>         ethernet-phy@3 {
>             compatible = "ethernet-phy-id004d.d180";
>             reg = <3>;
>             clocks = <qca8k_nsscc NSS_CC_GEPHY3_SYS_CLK>,
>             clock-names = <"gephy_sys">;
>             reset-names = "gephy_sys", "gephy_soft";
>         };
> };

	Andrew

