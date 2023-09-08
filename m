Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9479818D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjIHFbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIHFbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:31:16 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA0319AB;
        Thu,  7 Sep 2023 22:31:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3885UNTH127257;
        Fri, 8 Sep 2023 00:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694151023;
        bh=qVrPkFrOEhubrmH8tnwCvoJfWFB5ux7tpR4S2nXEqEk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=O8qogjNI+5GeFrW0IqJq+yR0xXCGfHsZZZOyCMbxH67W8BDbvwwo/PsdKMuW6v+p/
         +/iTfTruzUIRyHLUX7czCeUduyLg7gLhn3idNgfnmKdL5qZosT5iNF5076cx0aTeFQ
         37yHsCZNT5Qja4ag+PYYfv7TuHmCNFeYCCjQJ82w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3885UNtd011744
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Sep 2023 00:30:23 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 00:30:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 00:30:22 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3885UGXw024265;
        Fri, 8 Sep 2023 00:30:17 -0500
Message-ID: <5600e087-0a87-faef-ba18-53c2f13655d8@ti.com>
Date:   Fri, 8 Sep 2023 11:00:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [EXTERNAL] Re: [RFC PATCH net-next 1/4] net: ti: icssg-prueth:
 Add helper functions to configure FDB
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC:     Simon Horman <horms@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-2-danishanwar@ti.com>
 <edfbaf8e-16df-4a25-8647-79b8730dca08@lunn.ch>
 <0d71caf1-6fc2-9b77-1a72-54a354e89f03@ti.com>
 <07bda9b4-cd82-70b1-34af-7f4bb393e7c2@kernel.org>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <07bda9b4-cd82-70b1-34af-7f4bb393e7c2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/23 17:27, Roger Quadros wrote:
> 
> 
> On 05/09/2023 11:36, MD Danish Anwar wrote:
>> Hi Andrew
>>
>> On 04/09/23 19:32, Andrew Lunn wrote:
>>>> +int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
>>>> +		       struct mgmt_cmd_rsp *rsp)
>>>> +{
>>>> +	struct prueth *prueth = emac->prueth;
>>>> +	int slice = prueth_emac_slice(emac);
>>>> +	int i = 10000;
>>>> +	int addr;
>>>> +
>>>> +	addr = icssg_queue_pop(prueth, slice == 0 ?
>>>> +			       ICSSG_CMD_POP_SLICE0 : ICSSG_CMD_POP_SLICE1);
>>>> +	if (addr < 0)
>>>> +		return addr;
>>>> +
>>>> +	/* First 4 bytes have FW owned buffer linking info which should
>>>> +	 * not be touched
>>>> +	 */
>>>> +	memcpy_toio(prueth->shram.va + addr + 4, cmd, sizeof(*cmd));
>>>> +	icssg_queue_push(prueth, slice == 0 ?
>>>> +			 ICSSG_CMD_PUSH_SLICE0 : ICSSG_CMD_PUSH_SLICE1, addr);
>>>> +	while (i--) {
>>>> +		addr = icssg_queue_pop(prueth, slice == 0 ?
>>>> +				       ICSSG_RSP_POP_SLICE0 : ICSSG_RSP_POP_SLICE1);
>>>> +		if (addr < 0) {
>>>> +			usleep_range(1000, 2000);
>>>> +			continue;
>>>> +		}
>>>
>>> Please try to make use of include/linux/iopoll.h.
>>>
>>
>> I don't think APIs from iopoll.h will be useful here.
>> readl_poll_timeout() periodically polls an address until a condition is
>> met or a timeout occurs. It takes address, condition as argument and
>> store the value read from the address in val.
> 
> You need to use read_poll_timeout() and provide the read function as
> first argument 'op'. The arguments to the read function can be passed as is
> at the end. Please read description of read_poll_timeout()
> 

I was only looking into real/b/w_poll_timeout() as it is mentioned in
iopoll.h to not use read_poll_timeout() directly. Anyways, I will use
read_poll_timeout() here with icssg_pop_queue() as a read API.

>>
>> Here in our use case we need to continuously read the value returned
>> from icssg_queue_pop() and check if that is valid or not. If it's not
>> valid, we keep polling until timeout happens.
>>
>> icssg_queue_pop() does two read operations. It checks if the queue
>> number is valid or not. Then it reads the ICSSG_QUEUE_CNT_OFFSET for
>> that queue, if the value read is zero it returns inval. After that it
>> reads the value from ICSSG_QUEUE_OFFSET of that queue and store it in
>> 'val'. The returned value from icssg_queue_pop() is checked
>> continuously, if it's an error code, we keep polling. If it's a good
>> value then we call icssg_queue_push() with that value. As you can see
>> from the below definition of icssg_queue_pop() we are doing two reads
>> and two checks for error. I don't think this can be achieved by using
>> APIs in iopoll.h. readl_poll_timeout() reads from a single address
>> directly but we don't ave a single address that we can pass to
>> readl_poll_timeout() as an argument as we have to do two reads from two
>> different addresses during each poll.
>>
>> So I don't think we can use iopoll.h here. Please let me know if this
>> looks ok to you or if there is any other way we can use iopoll.h here
>>
>> int icssg_queue_pop(struct prueth *prueth, u8 queue)
>> {
>>     u32 val, cnt;
>>
>>     if (queue >= ICSSG_QUEUES_MAX)
>> 	return -EINVAL;
>>
>>     regmap_read(prueth->miig_rt, ICSSG_QUEUE_CNT_OFFSET + 4*queue,&cnt);
>>     if (!cnt)
>> 	return -EINVAL;
>>
>>     regmap_read(prueth->miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue, &val);
>>
>>     return val;
>> }
>>
>>>> +	if (i <= 0) {
>>>> +		netdev_err(emac->ndev, "Timedout sending HWQ message\n");
>>>> +		return -EINVAL;
>>>
>>> Using iopoll.h will fix this, but -ETIMEDOUT, not -EINVAL.
>>>
>>
>> -ETIMEDOUT is actually a better suited error code here, I will change
>> -EINVAL to -ETIMEDOUT in this if check.
>>
>>>       Andrew
>>>
>>
> 

-- 
Thanks and Regards,
Danish
