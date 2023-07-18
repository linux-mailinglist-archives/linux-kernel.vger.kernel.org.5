Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7C97578B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGRKAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGRKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:00:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCB5188;
        Tue, 18 Jul 2023 03:00:16 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36I9wkGR021989;
        Tue, 18 Jul 2023 04:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689674326;
        bh=I05cpe/5PNH+nd3/lltH/WL4YOk+fvTtXZQyDgYqHVA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=KAlrUlH00MufWrrkhwith2WtivgjZ453MLQCRnG8HKpdeb0KsZLKOP2WdAxdqC/CS
         xexnzqixR4ZegZljXX2ICTqGwdMFAkh6yiqgbCmEdjlSIIUXTDqXLAA6Wq3OC3Py+E
         zS2+qSIe1axmxD8hfCkITzMKsctsTcn5PWGePFM0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36I9wkaG022008
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Jul 2023 04:58:46 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jul 2023 04:58:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jul 2023 04:58:46 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36I9wePe095601;
        Tue, 18 Jul 2023 04:58:40 -0500
Message-ID: <78c1a348-8dd7-032f-62ce-d0dad360972a@ti.com>
Date:   Tue, 18 Jul 2023 15:28:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v9 2/2] net: ti: icssg-prueth: Add ICSSG
 ethernet driver
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230714094432.1834489-1-danishanwar@ti.com>
 <20230714094432.1834489-3-danishanwar@ti.com>
 <78b82c086c91be61d6a15582a7dc6f52b92f1b3e.camel@redhat.com>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <78b82c086c91be61d6a15582a7dc6f52b92f1b3e.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On 18/07/23 1:52 pm, Paolo Abeni wrote:
> On Fri, 2023-07-14 at 15:14 +0530, MD Danish Anwar wrote:
>> +static int prueth_netdev_init(struct prueth *prueth,
>> +			      struct device_node *eth_node)
>> +{
>> +	int ret, num_tx_chn = PRUETH_MAX_TX_QUEUES;
>> +	struct prueth_emac *emac;
>> +	struct net_device *ndev;
>> +	enum prueth_port port;
>> +	enum prueth_mac mac;
>> +
>> +	port = prueth_node_port(eth_node);
>> +	if (port == PRUETH_PORT_INVALID)
>> +		return -EINVAL;
>> +
>> +	mac = prueth_node_mac(eth_node);
>> +	if (mac == PRUETH_MAC_INVALID)
>> +		return -EINVAL;
>> +
>> +	ndev = alloc_etherdev_mq(sizeof(*emac), num_tx_chn);
>> +	if (!ndev)
>> +		return -ENOMEM;
>> +
>> +	emac = netdev_priv(ndev);
>> +	prueth->emac[mac] = emac;
>> +	emac->prueth = prueth;
>> +	emac->ndev = ndev;
>> +	emac->port_id = port;
>> +	emac->cmd_wq = create_singlethread_workqueue("icssg_cmd_wq");
>> +	if (!emac->cmd_wq) {
>> +		ret = -ENOMEM;
>> +		goto free_ndev;
>> +	}
>> +	INIT_WORK(&emac->rx_mode_work, emac_ndo_set_rx_mode_work);
>> +
>> +	ret = pruss_request_mem_region(prueth->pruss,
>> +				       port == PRUETH_PORT_MII0 ?
>> +				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,
>> +				       &emac->dram);
>> +	if (ret) {
>> +		dev_err(prueth->dev, "unable to get DRAM: %d\n", ret);
>> +		ret = -ENOMEM;
>> +		goto free_wq;
>> +	}
>> +
>> +	emac->tx_ch_num = 1;
>> +
>> +	SET_NETDEV_DEV(ndev, prueth->dev);
>> +	spin_lock_init(&emac->lock);
>> +	mutex_init(&emac->cmd_lock);
>> +
>> +	emac->phy_node = of_parse_phandle(eth_node, "phy-handle", 0);
>> +	if (!emac->phy_node && !of_phy_is_fixed_link(eth_node)) {
>> +		dev_err(prueth->dev, "couldn't find phy-handle\n");
>> +		ret = -ENODEV;
>> +		goto free;
>> +	} else if (of_phy_is_fixed_link(eth_node)) {
>> +		ret = of_phy_register_fixed_link(eth_node);
>> +		if (ret) {
>> +			ret = dev_err_probe(prueth->dev, ret,
>> +					    "failed to register fixed-link phy\n");
>> +			goto free;
>> +		}
>> +
>> +		emac->phy_node = eth_node;
>> +	}
>> +
>> +	ret = of_get_phy_mode(eth_node, &emac->phy_if);
>> +	if (ret) {
>> +		dev_err(prueth->dev, "could not get phy-mode property\n");
>> +		goto free;
>> +	}
>> +
>> +	if (emac->phy_if != PHY_INTERFACE_MODE_MII &&
>> +	    !phy_interface_mode_is_rgmii(emac->phy_if)) {
>> +		dev_err(prueth->dev, "PHY mode unsupported %s\n", phy_modes(emac->phy_if));
>> +		ret = -EINVAL;
>> +		goto free;
>> +	}
>> +
>> +	/* AM65 SR2.0 has TX Internal delay always enabled by hardware
>> +	 * and it is not possible to disable TX Internal delay. The below
>> +	 * switch case block describes how we handle different phy modes
>> +	 * based on hardware restriction.
>> +	 */
>> +	switch (emac->phy_if) {
>> +	case PHY_INTERFACE_MODE_RGMII_ID:
>> +		emac->phy_if = PHY_INTERFACE_MODE_RGMII_RXID;
>> +		break;
>> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>> +		emac->phy_if = PHY_INTERFACE_MODE_RGMII;
>> +		break;
>> +	case PHY_INTERFACE_MODE_RGMII:
>> +	case PHY_INTERFACE_MODE_RGMII_RXID:
>> +		dev_err(prueth->dev, "RGMII mode without TX delay is not supported");
>> +		return -EINVAL;
> 
> At this point ndev prueth->emac[mac] == emac, so the caller will try to
> clean it up via prueth_netdev_exit(), which in turn expects the device
> being fully initialized, while this is not. Notably the napi instance
> has not being registered yet.
> 
> You should 'goto free;' above and possibly move the 'ndev prueth-
>> emac[mac] = emac' assignment at the end of this function.
> 

Sure Paolo. Instead of returning -EINVAL in this switch case, I will do the
below change.

	ret = -EINVAL
	goto free;

Also I will move the 'ndev prueth-> emac[mac] = emac' assignment at the end of
this function.

Please let me know if you have any more comments / suggestions. I will try to
address them and send a next revision.

-- 
Thanks and Regards,
Danish.
