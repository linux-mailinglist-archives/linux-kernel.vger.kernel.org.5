Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43C804937
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344226AbjLEFMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjLEFMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:12:36 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85ECE;
        Mon,  4 Dec 2023 21:12:41 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B55CM09093592;
        Mon, 4 Dec 2023 23:12:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701753142;
        bh=0A6QOgLi7WtkHW5ZuVLDo3tJJa1jINJ9fG5kLANsTAA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=zG4kbJzcI53kU3CXYb3aXSGzf+DvT0hNy75ybUvWrhocZaBS03p+DU3TorEwUK+Ai
         azcTQ/eI6bGUslyb6KrV0bgUHOfSNQt5tF6Hqrlgp7OUY+BpF8Y0YvGAU7GyAWxckY
         AbpGTlZYFLq1UDQbIngA5rozJ94RRLZX0y2mpY/U=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B55CMYD092166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Dec 2023 23:12:22 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 23:12:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 23:12:21 -0600
Received: from [172.24.227.247] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B55CGXj033095;
        Mon, 4 Dec 2023 23:12:17 -0600
Message-ID: <bcafa1d8-1e19-6599-f5b2-16be3671bd19@ti.com>
Date:   Tue, 5 Dec 2023 10:42:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 3/5] PCI: j721e: Add per platform maximum lane
 settings
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <vigneshr@ti.com>, <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <danishanwar@ti.com>,
        <srk@ti.com>, <nm@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20231128054402.2155183-1-s-vadapalli@ti.com>
 <20231128054402.2155183-4-s-vadapalli@ti.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20231128054402.2155183-4-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 11:14 AM, Siddharth Vadapalli wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> Various platforms have different maximum amount of lanes that can be
> selected. Add max_lanes to struct j721e_pcie to allow for detection of this
> which is needed to calculate the needed bitmask size for the possible lane
> count.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 2c87e7728a65..63c758b14314 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -47,8 +47,6 @@ enum link_status {
>  
>  #define GENERATION_SEL_MASK		GENMASK(1, 0)
>  
> -#define MAX_LANES			2
> -
>  struct j721e_pcie {
>  	struct cdns_pcie	*cdns_pcie;
>  	struct clk		*refclk;
> @@ -71,6 +69,7 @@ struct j721e_pcie_data {
>  	unsigned int		quirk_disable_flr:1;
>  	u32			linkdown_irq_regfield;
>  	unsigned int		byte_access_allowed:1;
> +	unsigned int		max_lanes;
>  };
>  
>  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
> @@ -290,11 +289,13 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
>  	.quirk_retrain_flag = true,
>  	.byte_access_allowed = false,
>  	.linkdown_irq_regfield = LINK_DOWN,
> +	.max_lanes = 2,
>  };
>  
>  static const struct j721e_pcie_data j721e_pcie_ep_data = {
>  	.mode = PCI_MODE_EP,
>  	.linkdown_irq_regfield = LINK_DOWN,
> +	.max_lanes = 2,
>  };
>  
>  static const struct j721e_pcie_data j7200_pcie_rc_data = {
> @@ -302,23 +303,27 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
>  	.quirk_detect_quiet_flag = true,
>  	.linkdown_irq_regfield = J7200_LINK_DOWN,
>  	.byte_access_allowed = true,
> +	.max_lanes = 2,
>  };
>  
>  static const struct j721e_pcie_data j7200_pcie_ep_data = {
>  	.mode = PCI_MODE_EP,
>  	.quirk_detect_quiet_flag = true,
>  	.quirk_disable_flr = true,
> +	.max_lanes = 2,
>  };
>  
>  static const struct j721e_pcie_data am64_pcie_rc_data = {
>  	.mode = PCI_MODE_RC,
>  	.linkdown_irq_regfield = J7200_LINK_DOWN,
>  	.byte_access_allowed = true,
> +	.max_lanes = 1,
>  };
>  
>  static const struct j721e_pcie_data am64_pcie_ep_data = {
>  	.mode = PCI_MODE_EP,
>  	.linkdown_irq_regfield = J7200_LINK_DOWN,
> +	.max_lanes = 1,
>  };
>  
>  static const struct of_device_id of_j721e_pcie_match[] = {
> @@ -432,8 +437,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	pcie->user_cfg_base = base;
>  
>  	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
> -	if (ret || num_lanes > MAX_LANES)
> +	if (ret || num_lanes > data->max_lanes) {
> +		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
>  		num_lanes = 1;
> +	}
>  	pcie->num_lanes = num_lanes;
>  
>  	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
