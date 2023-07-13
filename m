Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5DD75204A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjGMLnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjGMLnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:43:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A82729;
        Thu, 13 Jul 2023 04:42:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DBfJN5124584;
        Thu, 13 Jul 2023 06:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689248479;
        bh=keh++xWg1b9Q+Jv3puQj7Co0CQSwVIN/m9Wclm/2UiM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=kLMvmss+MiFNHp8vwXjwgWyJYBCoiNQy5CVhy6R7/Fup2ydAHlscmQPMaYg+l8bMb
         AIKp9fL1cMMGeNDsjS6sl6IA1wjXbJFO6NppD2466yi12FIM2V0B6+T9o0yPkNP8wM
         SR1lnSkjuj7hOmwI7NbLJIMH+rIuhzrgzzhnQ0no=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DBfJYZ117645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 06:41:19 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 06:41:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 06:41:18 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DBfC1E075726;
        Thu, 13 Jul 2023 06:41:13 -0500
Message-ID: <b6e49136-1bad-8d32-ac6c-f9185dfaa9d3@ti.com>
Date:   Thu, 13 Jul 2023 17:11:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v8 2/2] net: ti:
 icssg-prueth: Add ICSSG ethernet driver
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
CC:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710053550.89160-1-danishanwar@ti.com>
 <20230710053550.89160-3-danishanwar@ti.com> <ZK2VRYwW8DxIZCY2@corigine.com>
 <afbd4c9d-5ff7-e366-f866-6b718907d6fa@ti.com> <ZK+6zVnUSJG5GKd4@corigine.com>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <ZK+6zVnUSJG5GKd4@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 13/07/23 2:20 pm, Simon Horman wrote:
> Hi Anwar,
> 
> On Wed, Jul 12, 2023 at 05:55:57PM +0530, Anwar, Md Danish wrote:
>> Hi Simon
>> On 7/11/2023 11:15 PM, Simon Horman wrote:
>>> On Mon, Jul 10, 2023 at 11:05:50AM +0530, MD Danish Anwar wrote:
>>>> From: Roger Quadros <rogerq@ti.com>
> 
> ...
> 
>>>> +static void icssg_miig_queues_init(struct prueth *prueth, int slice)
>>>> +{
>>>> +	struct regmap *miig_rt = prueth->miig_rt;
>>>> +	void __iomem *smem = prueth->shram.va;
>>>> +	u8 pd[ICSSG_SPECIAL_PD_SIZE];
>>>> +	int queue = 0, i, j;
>>>> +	u32 *pdword;
>>>> +
>>>> +	/* reset hwqueues */
>>>> +	if (slice)
>>>> +		queue = ICSSG_NUM_TX_QUEUES;
>>>> +
>>>> +	for (i = 0; i < ICSSG_NUM_TX_QUEUES; i++) {
>>>> +		regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET, queue);
>>>> +		queue++;
>>>> +	}
>>>> +
>>>> +	queue = slice ? RECYCLE_Q_SLICE1 : RECYCLE_Q_SLICE0;
>>>> +	regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET, queue);
>>>> +
>>>> +	for (i = 0; i < ICSSG_NUM_OTHER_QUEUES; i++) {
>>>> +		regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET,
>>>> +			     hwq_map[slice][i].queue);
>>>> +	}
>>>> +
>>>> +	/* initialize packet descriptors in SMEM */
>>>> +	/* push pakcet descriptors to hwqueues */
>>>> +
>>>> +	pdword = (u32 *)pd;
>>>> +	for (j = 0; j < ICSSG_NUM_OTHER_QUEUES; j++) {
>>>> +		const struct map *mp;
>>>> +		int pd_size, num_pds;
>>>> +		u32 pdaddr;
>>>> +
>>>> +		mp = &hwq_map[slice][j];
>>>> +		if (mp->special) {
>>>> +			pd_size = ICSSG_SPECIAL_PD_SIZE;
>>>> +			num_pds = ICSSG_NUM_SPECIAL_PDS;
>>>> +		} else	{
>>>> +			pd_size = ICSSG_NORMAL_PD_SIZE;
>>>> +			num_pds = ICSSG_NUM_NORMAL_PDS;
>>>> +		}
>>>> +
>>>> +		for (i = 0; i < num_pds; i++) {
>>>> +			memset(pd, 0, pd_size);
>>>> +
>>>> +			pdword[0] &= cpu_to_le32(ICSSG_FLAG_MASK);
>>>> +			pdword[0] |= cpu_to_le32(mp->flags);
>>>
>>> Sparse warns that the endieness of pdword is not le32.
>>
>> I will fix this.
> 
> Thanks.
> 
>>> There are also other sparse warnings added by this patch.
>>> Please look over them.
>>
>> There is one more warning for "expected restricted __le16 [usertype]
>> rx_base_flow got restricted __le32 [usertype]". I will fix this as well.
> 
> I haven't looked carefully through these.
> But for the record, this is what Sparse tells me:
> 

I am working on fixing all these sparse warning. I will send next revision
after fixing these warning.

>   .../icssg_config.c:91:18: warning: symbol 'hwq_map' was not declared. Should it be static?
>   .../icssg_config.c:189:35: warning: invalid assignment: &=
>   .../icssg_config.c:189:35:    left side has type unsigned int
>   .../icssg_config.c:189:35:    right side has type restricted __le32
>   .../icssg_config.c:190:35: warning: invalid assignment: |=
>   .../icssg_config.c:190:35:    left side has type unsigned int
>   .../icssg_config.c:190:35:    right side has type restricted __le32
>   .../icssg_config.c:225:11: warning: incorrect type in assignment (different address spaces)
>   .../icssg_config.c:225:11:    expected struct icssg_r30_cmd *p
>   .../icssg_config.c:225:11:    got void [noderef] __iomem *
>   .../icssg_config.c:228:42: warning: incorrect type in argument 2 (different address spaces)
>   .../icssg_config.c:228:42:    expected void volatile [noderef] __iomem *addr
>   .../icssg_config.c:228:42:    got unsigned int *
>   .../icssg_config.c:237:11: warning: incorrect type in assignment (different address spaces)
>   .../icssg_config.c:237:11:    expected struct icssg_r30_cmd const *p
>   .../icssg_config.c:237:11:    got void [noderef] __iomem *
>   .../icssg_config.c:240:36: warning: incorrect type in argument 1 (different address spaces)
>   .../icssg_config.c:240:36:    expected void const volatile [noderef] __iomem *addr
>   .../icssg_config.c:240:36:    got unsigned int const *
>   .../icssg_config.c:270:19: warning: incorrect type in assignment (different address spaces)
>   .../icssg_config.c:270:19:    expected struct icssg_buffer_pool_cfg *bpool_cfg
>   .../icssg_config.c:270:19:    got void [noderef] __iomem *
>   .../icssg_config.c:289:17: warning: incorrect type in assignment (different address spaces)
>   .../icssg_config.c:289:17:    expected struct icssg_rxq_ctx *rxq_ctx
>   .../icssg_config.c:289:17:    got void [noderef] __iomem *
>   .../icssg_config.c:297:17: warning: incorrect type in assignment (different address spaces)
>   .../icssg_config.c:297:17:    expected struct icssg_rxq_ctx *rxq_ctx
>   .../icssg_config.c:297:17:    got void [noderef] __iomem *
>   .../icssg_config.c:325:38: warning: incorrect type in initializer (different address spaces)
>   .../icssg_config.c:325:38:    expected void *config
>   .../icssg_config.c:325:38:    got void [noderef] __iomem *
>   .../icssg_config.c:332:19: warning: incorrect type in argument 1 (different address spaces)
>   .../icssg_config.c:332:19:    expected void volatile [noderef] __iomem *
>   .../icssg_config.c:332:19:    got void *config
>   .../icssg_config.c:361:32: warning: incorrect type in assignment (different base types)
>   .../icssg_config.c:361:32:    expected restricted __le16 [usertype] rx_base_flow
>   .../icssg_config.c:361:32:    got restricted __le32 [usertype]
>   .../icssg_config.c:406:11: warning: incorrect type in assignment (different address spaces)
>   .../icssg_config.c:406:11:    expected struct icssg_r30_cmd *p
>   .../icssg_config.c:406:11:    got void [noderef] __iomem *
>   .../icssg_config.c:417:61: warning: incorrect type in argument 2 (different address spaces)
>   .../icssg_config.c:417:61:    expected void volatile [noderef] __iomem *addr
>   .../icssg_config.c:417:61:    got unsigned int *
>   .../icssg_prueth.c:1665:9: warning: incorrect type in argument 1 (different address spaces)
>   .../icssg_prueth.c:1665:9:    expected void const *
>   .../icssg_prueth.c:1665:9:    got void [noderef] __iomem *va
>   .../icssg_prueth.c:1665:9: warning: incorrect type in argument 1 (different address spaces)
>   .../icssg_prueth.c:1665:9:    expected void const *
>   .../icssg_prueth.c:1665:9:    got void [noderef] __iomem *va
>   .../icssg_prueth.c:1665:9: warning: incorrect type in argument 1 (different address spaces)
>   .../icssg_prueth.c:1665:9:    expected void *
>   .../icssg_prueth.c:1665:9:    got void [noderef] __iomem *va
> 
>> There is one more sparse warning "warning: symbol 'icssg_ethtool_ops' was
>> not declared. Should it be static?". This should be ignored as no need to
>> change 'icssg_ethtool_ops' to static as this is decalred in icssg_ethtool.c
>> and used in icssg_prueth.c
> 
> I think the preferred approach there would be to declare the symbol
> in a header file that is available to both .c files.
> 

Sure. I will keep the declaration in a icssg_prueth.h.

> ...
> 
>>>> +	prueth->dev = dev;
>>>> +	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
>>>> +	if (!eth_ports_node)
>>>> +		return -ENOENT;
>>>> +
>>>> +	for_each_child_of_node(eth_ports_node, eth_node) {
>>>> +		u32 reg;
>>>> +
>>>> +		if (strcmp(eth_node->name, "port"))
>>>> +			continue;
>>>> +		ret = of_property_read_u32(eth_node, "reg", &reg);
>>>> +		if (ret < 0) {
>>>> +			dev_err(dev, "%pOF error reading port_id %d\n",
>>>> +				eth_node, ret);
>>>> +		}
>>>> +
>>>> +		of_node_get(eth_node);
>>>> +
>>>> +		if (reg == 0) {
>>>> +			eth0_node = eth_node;
>>>> +			if (!of_device_is_available(eth0_node)) {
>>>> +				of_node_put(eth0_node);
>>>> +				eth0_node = NULL;
>>>> +			}
>>>> +		} else if (reg == 1) {
>>>> +			eth1_node = eth_node;
>>>> +			if (!of_device_is_available(eth1_node)) {
>>>> +				of_node_put(eth1_node);
>>>> +				eth1_node = NULL;
>>>> +			}
>>>> +		} else {
>>>> +			dev_err(dev, "port reg should be 0 or 1\n");
>>>
>>> Should this be treated as an error and either return or goto an
>>> unwind path?
>>>
>>
>> I don't think we should error out or return to any goto label here. Here we
>> are checking 'reg' property in all available ports. If reg=0, we assign the
>> node to eth0_node. If reg=1, we assign the node to eth1_node. If the reg is
>> neither 0 nor 1, we will just keep looking through other available ports,
>> instead of returning error. We will eventually look through all available
>> nodes.
>>
>> Once we come out of the for loop, we should at least have one node with reg
>> property being either 0 or 1. If no node had reg as 0 or 1, both eth0_node
>> and eth1_node will be NULL, then we will error out with -ENODEV error by
>> below if check.
>>
>> if (!eth0_node && !eth1_node) {
>> 	dev_err(dev, "neither port0 nor port1 node available\n");
>> 	return -ENODEV;
>> }
> 
> Thanks, that makes sense to me.
> 
>>>> +		}
>>>> +	}
>>>> +
>>>> +	of_node_put(eth_ports_node);
>>>> +
>>>> +	/* At least one node must be present and available else we fail */
>>>> +	if (!eth0_node && !eth1_node) {
>>>
>>> Smatch warns that eth0_node and eth1_node may be uninitialised here.
>>>
>>
>> Sure, I will initialise eth0_node and eth1_node as NULL.
> 
> Thanks.
> 
> ...

I will fix all the sparse and smatch warning and send next revision.

-- 
Thanks and Regards,
Danish.
