Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072097FA9CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjK0THe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0THc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:07:32 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B9AD5F;
        Mon, 27 Nov 2023 11:07:38 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67a0d865738so22666106d6.1;
        Mon, 27 Nov 2023 11:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701112057; x=1701716857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLe8zyLFZgO8E8/Xnv13NYYU8sH315XPm4/jwQIsx+4=;
        b=PZzWwV2oj9t4f9gXMxV7ANLZhWB9ZWl45Dw4IGuT1sw6Ff922vh4TNet81EiZTvmjs
         9ichYeqbgqX3q9jpA8qVXtJTom+b5a+sxzj42O7XCajJvjDezMv8fzMDEzBrG4F74q9h
         oX23YPD5fHN9K3AuE7Lj2PDjfgE7ahBrrsm77p0DYx4eb9fbsCcSejuSQeaq1jpX/q0u
         iY6bTUkxCPCZe06V08Lc+3+GUX021pOrRjJ3FpGZsIgbhbB8YEO1/R8sYuL1fjHLKHQO
         V1fd7VOAZui36p7nCVTHGkLLX46hLR+OP4HkdvRzqoT56OCJ2NIhFlyUMiRRVoHpyzR/
         mUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701112057; x=1701716857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLe8zyLFZgO8E8/Xnv13NYYU8sH315XPm4/jwQIsx+4=;
        b=cuY59jxMt5wtBP49AU41b5T3OfDGg6rHQQT154pM9F8ZJ/qcEsjMNLwRFliCOOVFz1
         uCal7davnBOJFfHErXyFF1VTpKtYgPYXUdH48K0OW2OYzDJ8udQWplYwchBfSKoM8PO5
         COrO66wa/3aj6Hwa6QB58o0uFfLZcWQH5hacHSQy5lgjDFKQ3oCCsasSDPxCodfWCwcc
         qFdbzBoxy2YAgnSKVuPLhCbfj1wfOAYUY9TJx0FsrgYSlx5EeBRzC6V2dJpcpHXScPiO
         Tsrao4NHvMxu9XUZZygxEZsgFX/CkYo8kVOzHw/6nDxYWRaNFC4e9ZHTQma3l7nzIoUC
         w5jg==
X-Gm-Message-State: AOJu0YzmMaobueepDMngR/VjCi3GqdmxNKdm06pNUUUKQ0fD89ZLGF8D
        6UpYuScn5MiKAtBPVQIWIp0=
X-Google-Smtp-Source: AGHT+IEyqrTPi4tcihQ0aoHUT5WqvQaE8Tn+OoHt+F0iQ9j+N9Jc8CvmwCHU5aTxqcYjik3V7Ca4CQ==
X-Received: by 2002:ad4:5b8b:0:b0:67a:1d5c:5486 with SMTP id 11-20020ad45b8b000000b0067a1d5c5486mr13406845qvp.36.1701112057624;
        Mon, 27 Nov 2023 11:07:37 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ph3-20020a0562144a4300b0067a4b5f4269sm752417qvb.141.2023.11.27.11.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 11:07:36 -0800 (PST)
Message-ID: <44a4e759-02fc-4015-90a8-c41eb7cb3dc1@gmail.com>
Date:   Mon, 27 Nov 2023 11:07:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Content-Language: en-US
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 01:36, Souradeep Chakrabarti wrote:
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
> 6) If all CPUs in all NUMA nodes are used, but still there are IRQs
> then wrap over from first local NUMA node and continue
> doing 2, 3 4 till all IRQs are assigned.

You are describing the logic of what is done by the driver which is not 
responding to Jakub's comment. His request is to consider coming up with 
at least a somewhat usable and generic helper for other drivers to use.

This also begs the obvious question: why is all of this in the kernel in 
the first place? What could not be accomplished by an initramfs/ramdisk 
with minimal user-space responsible for parsing the system node(s) 
topology and CPU and assign interrupts accordingly?

We all like when things "automagically" work but this is conflating 
mechanism (supporting interrupt affinities) with policy (assigning 
affinities based upon work load) and that never flies really well.
-- 
Florian

