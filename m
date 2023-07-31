Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4DD768AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjGaE6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaE6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:58:08 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C07319C;
        Sun, 30 Jul 2023 21:58:06 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V4viEh127545;
        Sun, 30 Jul 2023 23:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690779464;
        bh=1Qlnu8KrG8HrUMi5RjI1swKLx9zRLOB4JSNqxVsnACQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=q3gtbPs79yVec19Ke5EPjOXZQtHEzF8JhOZOGCNdWFLP5YFB6Nuq0VIjlvsn5s8Su
         vRTtYlCOHcC9cSC9vLDSIpA+1KLwJ1BB7jqW5OFSxN/pogEd8Vb/WracL1ptLCP2dM
         8qj+/m5yX5ElnlVwue4QSuJD/6JoqXxLM7xfsMF0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V4viKD027504
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Jul 2023 23:57:44 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 30
 Jul 2023 23:57:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 30 Jul 2023 23:57:44 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V4vcW2101825;
        Sun, 30 Jul 2023 23:57:38 -0500
Message-ID: <ddb8233c-ad3b-ef2a-36c0-5986d0f1696c@ti.com>
Date:   Mon, 31 Jul 2023 10:27:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v12 06/10] net: ti: icssg-prueth: Add ICSSG
 ethernet driver
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

Sure, I will drop this if condition.

>> +drop_free_descs:
>> +	prueth_xmit_free(tx_chn, first_desc);
>> +drop_stop_q:
>> +	netif_tx_stop_queue(netif_txq);
> 
> Do not stop the queue on DMA errors. If the queue is empty nothing
> will wake it up. Queue should only be stopped based on occupancy.
> 

Sure, I will try to make sure we only stop queue based on occupancy.

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
