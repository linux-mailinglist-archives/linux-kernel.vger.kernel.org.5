Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FD376949F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGaLUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjGaLUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:20:46 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82803BF;
        Mon, 31 Jul 2023 04:20:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36VBK6Ae086420;
        Mon, 31 Jul 2023 06:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690802406;
        bh=DRmU+9mTrUabLH+VCeLGv4Z0gxwz7F1zcQ3OZ35YsgA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Vp9Zz/fgAzRbYmLuCDAdWtF1jmFZFd2kDmxDrw+WTZMkPInrisUTzAfhLBSeivcXU
         y073YwQBhBkbTAama17zzLAexpgJFs6OjPwpTJVFNWdqP/sCJ8Z91v/4EU4GUxYrKg
         zXFYIoLqcaxXfCXjKXey0FR0T1t4K2FiV4bKUEY4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36VBK68f117143
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 06:20:06 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 06:20:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 06:20:06 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36VBJxtJ062506;
        Mon, 31 Jul 2023 06:20:00 -0500
Message-ID: <8790da4f-1378-410c-f637-f85ca4d34604@ti.com>
Date:   Mon, 31 Jul 2023 16:49:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 06/10] net: ti: icssg-prueth: Add ICSSG ethernet
 driver
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230727112827.3977534-1-danishanwar@ti.com>
 <20230727112827.3977534-7-danishanwar@ti.com>
 <20230728172419.702b4ac0@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230728172419.702b4ac0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On 29/07/23 5:54 am, Jakub Kicinski wrote:
> On Thu, 27 Jul 2023 16:58:23 +0530 MD Danish Anwar wrote:
>> +static int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>> +				    int budget)
>> +{
>> +	struct net_device *ndev = emac->ndev;
>> +	struct cppi5_host_desc_t *desc_tx;
>> +	struct netdev_queue *netif_txq;
>> +	struct prueth_tx_chn *tx_chn;
>> +	unsigned int total_bytes = 0;
>> +	struct sk_buff *skb;
>> +	dma_addr_t desc_dma;
>> +	int res, num_tx = 0;
>> +	void **swdata;
>> +
>> +	tx_chn = &emac->tx_chns[chn];
>> +
>> +	while (budget) {
>> +		res = k3_udma_glue_pop_tx_chn(tx_chn->tx_chn, &desc_dma);
>> +		if (res == -ENODATA)
>> +			break;
> 
> You shouldn't limit the number of serviced packets to budget for Tx
> NAPI.
> 
> https://docs.kernel.org/next/networking/napi.html#driver-api

Sure, I will remove budget from here, instead will service packets in
while(true) {} loop.
> 
>> +	skb->dev = ndev;
>> +	if (!netif_running(skb->dev)) {
>> +		dev_kfree_skb_any(skb);
>> +		return 0;
>> +	}
> 
> why do you check if the interface is running?
> If a packet arrives, it means the interface is running..
> 
>> +drop_free_descs:
>> +	prueth_xmit_free(tx_chn, first_desc);
>> +drop_stop_q:
>> +	netif_tx_stop_queue(netif_txq);
> 
> Do not stop the queue on DMA errors. If the queue is empty nothing
> will wake it up. Queue should only be stopped based on occupancy.

There are five error handling cases in xmit().

1. DMA Mapping the linear buffer -- If we fail to map dma, we will return
NETDEV_TX_OK and goto drop_free_skb which will free the skb and drop the packet.

2. Allocating descriptor for linear buffer -- If we fail to allocate descriptor
this means it is a occupancy issue and we will goto drop_stop_q_busy which will
stop queue and return NETDEV_TX_BUSY.

3. Allocating descriptor when skb is fragmented. -- If we fail to allocate
descriptor when skb is fragmented, we will goto drop_stop_q which will stop the
queue, free the descriptor, free the skb, drop the packet and return NETDEV_TX_OK.

4. DMA mapping for fragment. -- If DMA mapping for fragment fails, we will go
to drop_free_descs which will free the descriptor, free the skb, drop the
packet and return NETDEV_TX_OK.

5. Tx push failed. -- If tx push fails we will goto drop_free_descs which will
free the descriptor, free the skb, drop the packet and return.

We will only stop queue in case 2 and 3 where we failed to allocate descriptor.
In case 1, 4 and 5 we are encountering dma mapping error, so for these cases we
will not stop the queue.

Below will be my goto labels.

drop_stop_q:
	netif_tx_stop_queue(netif_txq);

drop_free_descs:
	prueth_xmit_free(tx_chn, first_desc);

drop_free_skb:
	dev_kfree_skb_any(skb);

	/* error */
	ndev->stats.tx_dropped++;
	netdev_err(ndev, "tx: error: %d\n", ret);

	return ret;

drop_stop_q_busy:
	netif_tx_stop_queue(netif_txq);
	return NETDEV_TX_BUSY;

Please let me know if this looks OK or if you have any comment on this.

> 
>> +	dev_kfree_skb_any(skb);
>> +
>> +	/* error */
>> +	ndev->stats.tx_dropped++;
>> +	netdev_err(ndev, "tx: error: %d\n", ret);
>> +
>> +	return ret;

-- 
Thanks and Regards,
Danish.
