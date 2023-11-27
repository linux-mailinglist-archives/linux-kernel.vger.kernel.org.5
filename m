Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FD37FA2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjK0Ofc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjK0OfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:35:08 -0500
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE3D44B7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:33:04 -0800 (PST)
Message-ID: <966f54dd-f083-4a7d-a15a-3a203a21d4ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701095582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vObv6RyITFVrMf1y8I26NGtkSDIHE/K42LLMcUo0st8=;
        b=QdWclXVPugaZ40tkeAmvvLE9DSxL36FaskilcyU5HHprK9FlE8RYXt0eg+0fiQRSH8W4a0
        vCOooQL+lm2ZKJ61RvlWEO59YZfS2LeOl5aCfwqHTM/ng8ujztV9mOaB+1Ip6aHIr3owHZ
        ZFMSMjenjWb8w7TV0NCnZKNu4K08Chw=
Date:   Mon, 27 Nov 2023 22:32:47 +0800
MIME-Version: 1.0
Subject: Re: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
To:     Souradeep Chakrabarti <schakrabarti@microsoft.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Paul Rosswurm <paulros@microsoft.com>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20231121154841.7fc019c8@kernel.org>
 <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/11/27 17:36, Souradeep Chakrabarti 写道:
> 
> 
>> -----Original Message-----
>> From: Jakub Kicinski <kuba@kernel.org>
>> Sent: Wednesday, November 22, 2023 5:19 AM
>> To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
>> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>> pabeni@redhat.com; Long Li <longli@microsoft.com>;
>> sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
>> ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de; linux-
>> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-rdma@vger.kernel.org; Souradeep Chakrabarti
>> <schakrabarti@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>
>> Subject: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on
>> HT cores
>>
>> On Tue, 21 Nov 2023 05:54:37 -0800 Souradeep Chakrabarti wrote:
>>> Existing MANA design assigns IRQ to every CPUs, including sibling
>>> hyper-threads in a core. This causes multiple IRQs to work on same CPU
>>> and may reduce the network performance with RSS.
>>>
>>> Improve the performance by adhering the configuration for RSS, which
>>> assigns IRQ on HT cores.
>>
>> Drivers should not have to carry 120 LoC for something as basic as spreading IRQs.
>> Please take a look at include/linux/topology.h and if there's nothing that fits your
>> needs there - add it. That way other drivers can reuse it.
> Because of the current design idea, it is easier to keep things inside
> the mana driver code here. As the idea of IRQ distribution here is :
> 1)Loop through interrupts to assign CPU
> 2)Find non sibling online CPU from local NUMA and assign the IRQs
> on them.
> 3)If number of IRQs is more than number of non-sibling CPU in that
> NUMA node, then assign on sibling CPU of that node.
> 4)Keep doing it till all the online CPUs are used or no more IRQs.
> 5)If all CPUs in that node are used, goto next NUMA node with CPU.
> Keep doing 2 and 3.

https://static.lwn.net/images/pdf/LDD3/ch10.pdf

Zhu Yanjun

> 6) If all CPUs in all NUMA nodes are used, but still there are IRQs
> then wrap over from first local NUMA node and continue
> doing 2, 3 4 till all IRQs are assigned.

