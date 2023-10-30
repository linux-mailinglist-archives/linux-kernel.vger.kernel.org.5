Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853E57DBCF4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjJ3PyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjJ3PyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:54:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B327D9;
        Mon, 30 Oct 2023 08:54:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c41e95efcbso657495766b.3;
        Mon, 30 Oct 2023 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698681239; x=1699286039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fx1X+bV01LoP9GbP6scmfW8BqGyk+WJyMw4q05yKCxs=;
        b=f4Dq/MEibXix4HZSEt1ydpgXe05iZCN1xJ6peJVD1gIbd3/kseB1z8tqu/bhCx2K/T
         qYjlqHpnyx7KRuiKEGqPIQ1pVk3H/eN9xQwgB9Yn15L5NRQ6LNn+mBDLzRJqtTi7zM78
         8DALoL+r9a2mQwqKf67/rwKisTHzv7hoeEXyBKKxsd74ZmveDKnzCgWIMhBG0IuEi117
         QpdOPtU+TORVgoaZzGE3RWBKRqVi2u+mMiRXNinn43jOr3sB+Zk6dAkSH6pJkE7icT7b
         /C3LjybVReJPGgsNO9MCwGXRFBKVNH7bf/ZkPUXtFRy6IyUww65igeVTwGvo9oQmHUjs
         ojhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698681239; x=1699286039;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx1X+bV01LoP9GbP6scmfW8BqGyk+WJyMw4q05yKCxs=;
        b=DdWAtMIguXXPBg+fZLtpOSLmAl4oIUa3Q1HzGn5MJh/zauoVH8wqvcNo5BZ+YIXVG/
         gkF6dCjpuOxK5xZTf0zZcCeaQYEvr0wtViKxWzq3PS0A7I7rZAQNM7T66Y3DkYWs/ab2
         USHq5STks46wfOxwHAn4r7sviqxReEluhA7ws7lUb+lKMHfVob4ZbiXxQJT9IjAn0LSI
         s6bf5djAvSum8CH/L0TUVKZJgMEiwe7niWcZ/8CE21jP3wqTtVR2782Cgn1MJRzRE/KZ
         Ki1iduD6eXWTkwuXdFSaHuIqxn3KDkmZ3twfFeVlWSi7oF5lN6V23qO26/dbk4EGe7QU
         yRhg==
X-Gm-Message-State: AOJu0YyIZ1b4dylUlSQp4ams8/qifHmi78il6oBex/JUvwfkhI2d6Vrd
        ZemmbsrAgCixZFt0SHn+KRY=
X-Google-Smtp-Source: AGHT+IEsa4UZ5qcno/Q5fO3q/J/8+9fx+4022HhoofcWDr79fGGIwiaQTQ8rKy3rhHGSTAMu8tJOLw==
X-Received: by 2002:a17:906:2492:b0:9d2:8aca:183b with SMTP id e18-20020a170906249200b009d28aca183bmr3132830ejb.32.1698681239193;
        Mon, 30 Oct 2023 08:53:59 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc31:8900:5db7:a938:1060:35a3? (dynamic-2a01-0c23-bc31-8900-5db7-a938-1060-35a3.c23.pool.telefonica.de. [2a01:c23:bc31:8900:5db7:a938:1060:35a3])
        by smtp.googlemail.com with ESMTPSA id o15-20020a1709062e8f00b009c70b392051sm6193775eji.100.2023.10.30.08.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:53:58 -0700 (PDT)
Message-ID: <0fbd7463-a29e-4a64-8bc4-8a94fc379519@gmail.com>
Date:   Mon, 30 Oct 2023 16:53:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] r8169: Coalesce mac ocp write and modify for 8125
 and 8125B start to reduce spinlocks
Content-Language: en-US
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
 <20231029183600.451694-6-mirsad.todorovac@alu.unizg.hr>
 <7fd8c40d-5209-4f7c-8c69-5138d0eb0bc5@gmail.com>
 <e9cb3842-3492-4b85-b7ad-77605a5836c3@alu.unizg.hr>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <e9cb3842-3492-4b85-b7ad-77605a5836c3@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.2023 16:02, Mirsad Todorovac wrote:
> 
> 
> On 10/30/23 15:02, Heiner Kallweit wrote:
>> On 29.10.2023 19:36, Mirsad Goran Todorovac wrote:
>>> Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
>>> the startup of 8125 and 8125B involve implicit spin_lock_irqsave() and
>>> spin_unlock_irqrestore() on each invocation.
>>>
>>> Coalesced with the corresponding helpers r8168_mac_ocp_write_seq() and
>>> r8168_mac_ocp_modify_seq() into sequential write or modidy with a sinqle
>>> pair of spin_lock_irqsave() and spin_unlock_irqrestore(), these calls
>>> reduce overall lock contention.
>>>
>>> Fixes: f1bce4ad2f1ce ("r8169: add support for RTL8125")
>>> Fixes: 0439297be9511 ("r8169: add support for RTL8125B")
>>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>>> Cc: Marco Elver <elver@google.com>
>>> Cc: nic_swsd@realtek.com
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: netdev@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
>>> Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
>>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>>> ---
>>> v5:
>>>   added unlocked primitives to allow mac ocs modify grouping
>>>   applied coalescing of mac ocp writes/modifies for 8168ep and 8117
>>>   some formatting fixes to please checkpatch.pl
>>>
>>> v4:
>>>   fixed complaints as advised by Heiner and checkpatch.pl
>>>   split the patch into five sections to be more easily manipulated and reviewed
>>>   introduced r8168_mac_ocp_write_seq()
>>>   applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B
>>>
>>> v3:
>>>   removed register/mask pair array sentinels, so using ARRAY_SIZE().
>>>   avoided duplication of RTL_W32() call code as advised by Heiner.
>>>
>>>   drivers/net/ethernet/realtek/r8169_main.c | 75 +++++++++++++----------
>>>   1 file changed, 44 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 50fbacb05953..0778cd0ba2e0 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -3553,6 +3553,28 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
>>>     static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>>>   {
>>> +    static const struct e_info_regmaskset e_info_8125_common_1[] = {
>>> +        { 0xd3e2, 0x0fff, 0x03a9 },
>>> +        { 0xd3e4, 0x00ff, 0x0000 },
>>> +        { 0xe860, 0x0000, 0x0080 },
>>> +    };
>>> +
>>> +    static const struct e_info_regmaskset e_info_8125_common_2[] = {
>>> +        { 0xc0b4, 0x0000, 0x000c },
>>> +        { 0xeb6a, 0x00ff, 0x0033 },
>>> +        { 0xeb50, 0x03e0, 0x0040 },
>>> +        { 0xe056, 0x00f0, 0x0030 },
>>> +        { 0xe040, 0x1000, 0x0000 },
>>> +        { 0xea1c, 0x0003, 0x0001 },
>>> +        { 0xe0c0, 0x4f0f, 0x4403 },
>>> +        { 0xe052, 0x0080, 0x0068 },
>>> +        { 0xd430, 0x0fff, 0x047f },
>>> +        { 0xea1c, 0x0004, 0x0000 },
>>> +        { 0xeb54, 0x0000, 0x0001 },
>>> +    };
>>> +
>>> +    unsigned long flags;
>>> +
>>>       rtl_pcie_state_l2l3_disable(tp);
>>>         RTL_W16(tp, 0x382, 0x221b);
>>> @@ -3560,47 +3582,38 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>>>       RTL_W16(tp, 0x4800, 0);
>>>         /* disable UPS */
>>> -    r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
>>> +
>>> +    raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>> +    __r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
>>>         RTL_W8(tp, Config1, RTL_R8(tp, Config1) & ~0x10);
>>>   -    r8168_mac_ocp_write(tp, 0xc140, 0xffff);
>>> -    r8168_mac_ocp_write(tp, 0xc142, 0xffff);
>>> +    __r8168_mac_ocp_write(tp, 0xc140, 0xffff);
>>> +    __r8168_mac_ocp_write(tp, 0xc142, 0xffff);
>>>   -    r8168_mac_ocp_modify(tp, 0xd3e2, 0x0fff, 0x03a9);
>>> -    r8168_mac_ocp_modify(tp, 0xd3e4, 0x00ff, 0x0000);
>>> -    r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
>>> +    __r8168_mac_ocp_modify_seq(tp, e_info_8125_common_1);
>>>         /* disable new tx descriptor format */
>>> -    r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
>>> +    __r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
>>>   -    if (tp->mac_version == RTL_GIGA_MAC_VER_63)
>>> -        r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
>>> -    else
>>> -        r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
>>> +    if (tp->mac_version == RTL_GIGA_MAC_VER_63) {
>>> +        __r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
>>> +        __r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0000);
>>> +    } else {
>>> +        __r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
>>> +        __r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0020);
>>> +    }
>>> +
>>> +    __r8168_mac_ocp_modify_seq(tp, e_info_8125_common_2);
>>> +    raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>>   -    if (tp->mac_version == RTL_GIGA_MAC_VER_63)
>>> -        r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0000);
>>> -    else
>>> -        r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0020);
>>> -
>>> -    r8168_mac_ocp_modify(tp, 0xc0b4, 0x0000, 0x000c);
>>> -    r8168_mac_ocp_modify(tp, 0xeb6a, 0x00ff, 0x0033);
>>> -    r8168_mac_ocp_modify(tp, 0xeb50, 0x03e0, 0x0040);
>>> -    r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
>>> -    r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
>>> -    r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
>>> -    r8168_mac_ocp_modify(tp, 0xe0c0, 0x4f0f, 0x4403);
>>> -    r8168_mac_ocp_modify(tp, 0xe052, 0x0080, 0x0068);
>>> -    r8168_mac_ocp_modify(tp, 0xd430, 0x0fff, 0x047f);
>>> -
>>> -    r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
>>> -    r8168_mac_ocp_modify(tp, 0xeb54, 0x0000, 0x0001);
> 
> [1] I think we have a candidate for a squeeze here in this driver.
> 
>>>       udelay(1);
>>> -    r8168_mac_ocp_modify(tp, 0xeb54, 0x0001, 0x0000);
>>> -    RTL_W16(tp, 0x1880, RTL_R16(tp, 0x1880) & ~0x0030);
>>>   -    r8168_mac_ocp_write(tp, 0xe098, 0xc302);
>>> +    raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>> +    __r8168_mac_ocp_modify(tp, 0xeb54, 0x0001, 0x0000);
>>> +    RTL_W16(tp, 0x1880, RTL_R16(tp, 0x1880) & ~0x0030);
>>> +    __r8168_mac_ocp_write(tp, 0xe098, 0xc302);
>>> +    raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>>         rtl_loop_wait_low(tp, &rtl_mac_ocp_e00e_cond, 1000, 10);
>>>   
>>
>> All this manual locking and unlocking makes the code harder
>> to read and more error-prone. Maybe, as a rule of thumb:
>> If you can replace a block with more than 10 mac ocp ops,
>> then fine with me
> As I worked with another German developer, Mr. Frank Heckenbach from the GNU Pascal project,
> I know that Germans are pedantic and reliable :-)
> 
> If this rtl_hw_start_8125_common() is called only once, then maybe every memory bus cycle
> isn't worth saving, and then maybe the additional complexity isn't worth adding (but it
> was fun doing, and it works with my NIC).
> 
> AFAIK, a spin_lock_irqsave()/spin_unlock_irqrestore() isn't a free lunch as you know, and I read
> from the manuals that on modern CPUs a locked ADD $0, -128(%esp) or something takes about 50
> clock cycles, in which all cores have to wait.
> 
> Doing that in storm of 10 lock/unlock pairs amounts to 500 cycles or 125 ns in the best case
> on a 4 GHz CPU.
> 
> But I trust that you as the maintainer have the big picture and greater insight in the actual hw.
> 
Big picture: maybe, as I've been working on r8169 for about 5 yrs
Greater insight in the actual hw: not really, because Realtek doesn't publish datasheets and
errata information. I just know the history of a lot of needed quirks in r8169, and I can recall
what we tried to improve and had to roll back because users had problems.
Most famous example is ASPM L1 + sub-state support. ASPM with r8169-driven NIC versions has a
long history of users facing slow network connectivity / tx timeouts / complete NIC stalls.
And it's still not solved with the newest NIC versions. But maybe not only Realtek is to blame.
Basically every consumer mainboard comes with a Realtek NIC, chipset issues and BIOS bugs
contribute to the mess.

> Elon Musk said that the greatest error in engineering is optimising stuff that never should
> have been written.
> 
> As I like my RTL 8125b NIC to be fast (TM), I am not giving up on it.
> 
Does this mean that you're not achieving the 2500Mbps line rate with r8169 as-is?

> Just recalled that you mentioned that it supports RSS. Is it feasible to add it to the r8169
> driver?
> 
Feasible: definitely, as you "just" have to take the RSS-related code from r8125 and adjust it
to meet mainline code quality criteria
Question is which actual benefit it brings, and whether it's worth the additional complexity.
As a starting point you could compare performance KPI's when using r8169 vs. r8125.

> It is OK for me that we have a formal and less formal mode of communication and switch between
> them.
> 
> Thank you for all your quick reviews, much obliged, thank you for partially accepting the patches,
> but I think I need to sleep over it before submitting a new version.
> 
> Regards,
> Mirsad Todorovac

