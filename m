Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A5A7DBB4E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjJ3OEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjJ3OEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:04:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40052B7;
        Mon, 30 Oct 2023 07:04:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso7606133a12.3;
        Mon, 30 Oct 2023 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698674642; x=1699279442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5EB3rdOOoDhUyIvhXpN5ETbcGOsHihkW6zcFmlBlHb8=;
        b=LPzy8PjhzRi1zR3kNslX6AL+eBZEnz7y5bwKfh35TwT5TpvaRz56DyV6lQCLDDCBKK
         g7xuD8LPUIqn9XPNKRVInb2kNk8cvVLaAmJMy4J+etWhlJIgoDSAbnUNABWkZ1U8eEFf
         fXLLSGjCOefJu1DMBrL63JCLKvNsCYeTS4dboTkVzV4oPLlwzTOir2MrOb20rIJ9Q+N/
         BKIbkQYM/k+9XTifD1BPBDFC//bOmVeeIC1oC1nbLKHNzKOodgmUSlNeVZ4bE02aMii6
         SZlHfwvMrWfyh89g75Uyk3zECcl264UdRMkSzDhCN4dfxHsmE2PgG5DwvoWE5mt8MvvV
         /+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674642; x=1699279442;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EB3rdOOoDhUyIvhXpN5ETbcGOsHihkW6zcFmlBlHb8=;
        b=I2xH75vREcknCXwygFH5fjEyzH44GnxfF3m/k4itvAtx/X0p9fsJl309llibfliidJ
         joYk0ZCrJBdFuDkxwofiWPvCB0qKs0Qyured0qMYD3RZwwl1Xk4PuNEy84QjLZR2aFEM
         OS0GHzTO7pST4Rke0wBZ7wSq7U4rFpH+Cjg6qpcMMLi8tjqCcmqY124jUi0VgE6aIlN5
         /nAIS9uuZ4D1SC4meJ4ug2q0T6Eb4CNrtqyH0HBIgcCLBT7o90hBlZf2O59VQ6Vror8K
         o8p35NaYtRXOBNqtHpkfcNLIEE97Yi7Hb2hxyORjeJsXdr/dWOk99MLXhxQSvk1EcCLS
         impQ==
X-Gm-Message-State: AOJu0Ywm0zrEQi610IDpVez6Nq5x/03oRYruO9jyPdikG/6aQcpVMARZ
        B3xt8i6VGvCOj4pQnMJSXxQ=
X-Google-Smtp-Source: AGHT+IF5ZltJwgVXIL6WYLmUpba9HED/QyrVZ8bjfnqiAlQMtnG7LcWHEVzJug4N9q7i9SeyPt0LJw==
X-Received: by 2002:a05:6402:1852:b0:53f:1ce2:a3ac with SMTP id v18-20020a056402185200b0053f1ce2a3acmr8006151edy.41.1698674642413;
        Mon, 30 Oct 2023 07:04:02 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc31:8900:5db7:a938:1060:35a3? (dynamic-2a01-0c23-bc31-8900-5db7-a938-1060-35a3.c23.pool.telefonica.de. [2a01:c23:bc31:8900:5db7:a938:1060:35a3])
        by smtp.googlemail.com with ESMTPSA id n27-20020a5099db000000b0053116e45317sm6278564edb.44.2023.10.30.07.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:04:01 -0700 (PDT)
Message-ID: <fd56b4ef-921d-492f-8d92-e50d2facd1d4@gmail.com>
Date:   Mon, 30 Oct 2023 14:45:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] r8169: Coalesce RTL8411b PHY power-down recovery
 programming instructions to reduce spinlock stalls
Content-Language: en-US
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr>
 <376db5ae-1bb0-4682-b132-b9852be3c7aa@gmail.com>
 <23428695-fcff-495b-ac43-07639b4f5d08@alu.unizg.hr>
 <30e15e9a-d82e-4d24-be37-1b9d1534c082@gmail.com>
 <9f99c3a4-2752-464b-b37d-58a4f8041804@alu.unizg.hr>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <9f99c3a4-2752-464b-b37d-58a4f8041804@alu.unizg.hr>
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

On 30.10.2023 14:30, Mirsad Todorovac wrote:
> 
> 
> On 10/30/23 14:17, Heiner Kallweit wrote:
>> On 29.10.2023 05:56, Mirsad Todorovac wrote:
>>>
>>>
>>> On 10/28/23 21:21, Heiner Kallweit wrote:
>>>> On 28.10.2023 13:05, Mirsad Goran Todorovac wrote:
>>>>> On RTL8411b the RX unit gets confused if the PHY is powered-down.
>>>>> This was reported in [0] and confirmed by Realtek. Realtek provided
>>>>> a sequence to fix the RX unit after PHY wakeup.
>>>>>
>>>>> A series of about 130 r8168_mac_ocp_write() calls is performed to
>>>>> program the RTL registers for recovery.
>>>>>
>>>>> r8168_mac_ocp_write() expands to this code:
>>>>>
>>>>>           static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
>>>>>           {
>>>>>                   if (rtl_ocp_reg_failure(reg))
>>>>>                           return;
>>>>>
>>>>>                   RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>>>>>           }
>>>>>
>>>>>           static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
>>>>>           {
>>>>>                   unsigned long flags;
>>>>>
>>>>>                   raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>>>>                   __r8168_mac_ocp_write(tp, reg, data);
>>>>>                   raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>>>>           }
>>>>>
>>>>> Register programming is done through RTL_W32() macro which expands into
>>>>>
>>>>>           #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
>>>>>
>>>>> which is further (on Alpha):
>>>>>
>>>>>           extern inline void writel(u32 b, volatile void __iomem *addr)
>>>>>           {
>>>>>                   mb();
>>>>>                   __raw_writel(b, addr);
>>>>>           }
>>>>>
>>>>> or on i386/x86_64:
>>>>>
>>>>>       #define build_mmio_write(name, size, type, reg, barrier) \
>>>>>       static inline void name(type val, volatile void __iomem *addr) \
>>>>>       { asm volatile("mov" size " %0,%1": :reg (val), \
>>>>>       "m" (*(volatile type __force *)addr) barrier); }
>>>>>
>>>>>       build_mmio_write(writel, "l", unsigned int, "r", :"memory")
>>>>>
>>>>> This obviously involves iat least a compiler barrier.
>>>>>
>>>>> mb() expands into something like this i.e. on x86_64:
>>>>>
>>>>>           #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
>>>>>
>>>>> This means a whole lot of memory bus barriers: for spin_lock_irqsave(),
>>>>> memory barrier, writel(), and spin_unlock_irqrestore().
>>>>>
>>>>> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
>>>>> a LOCK storm that will thunder all of the cores and CPUs on the same memory controller
>>>>> for certain time that locked memory read-modify-write cyclo or I/O takes to finish.
>>>>>
>>>>> In a sequential case of RTL register programming, the writes to RTL registers
>>>>> can be coalesced under a same raw spinlock. This can dramatically decrease the
>>>>> number of bus stalls in a multicore or multi-CPU system:
>>>>>
>>>>>           static void __r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
>>>>>                                                 const struct recover_8411b_info *array)
>>>>>           {
>>>>>                   struct recover_8411b_info const *p = array;
>>>>>
>>>>>                   while (p->reg) {
>>>>>                           if (!rtl_ocp_reg_failure(p->reg))
>>>>>                                   RTL_W32(tp, OCPDR, OCPAR_FLAG | (p->reg << 15) | p->data);
>>>>>                           p++;
>>>>>                   }
>>>>>           }
>>>>>
>>>>>           static void r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
>>>>>                                               const struct recover_8411b_info *array)
>>>>>           {
>>>>>                   unsigned long flags;
>>>>>
>>>>>                   raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>>>>                   __r8168_mac_ocp_write_seq(tp, array);
>>>>>                   raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>>>>           }
>>>>>
>>>>>           static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>>>>           {
>>>>>
>>>>>                   ...
>>>>>
>>>>>                   /* The following Realtek-provided magic fixes an issue with the RX unit
>>>>>                    * getting confused after the PHY having been powered-down.
>>>>>                    */
>>>>>
>>>>>                   static const struct recover_8411b_info init_zero_seq[] = {
>>>>>                           { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 }, { 0xFC2E, 0x0000 },
>>>>>              ...
>>>>>                   };
>>>>>
>>>>>                   static const struct recover_8411b_info recover_seq[] = {
>>>>>                           { 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C }, { 0xF806, 0xE00E },
>>>>>              ...
>>>>>                   };
>>>>>
>>>>>                   static const struct recover_8411b_info final_seq[] = {
>>>>>                           { 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 }, { 0xFC30, 0x02FD },
>>>>>              ...
>>>>>                   };
>>>>>
>>>>>                   r8168_mac_ocp_write_seq(tp, init_zero_seq);
>>>>>                   mdelay(3);
>>>>>                   r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
>>>>>                   r8168_mac_ocp_write_seq(tp, recover_seq);
>>>>>                   r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
>>>>>                   r8168_mac_ocp_write_seq(tp, final_seq);
>>>>>           }
>>>>>
>>>>> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
>>>>> functions that only changed the function names and the ending of the line, so the actual
>>>>> hex data is unchanged.
>>>>>
>>>>> Note that the original reason for the introduction of the commit fe4e8db0392a6
>>>>> was to enable recovery of the RX unit on the RTL8411b which was confused by the
>>>>> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
>>>>
>>>> I still have a problem with this statement as you're saying that the original
>>>> problem still exists. I don't think that's the case.
>>>
>>> I will not disagree about it.
>>>
>>> But we have only reduced the number of spin_lock_irqsave/spin_unlock_irqrestore()
>>> pairs.
>>>
>>> Maybe additionally, on the low level, memory barrier isn't required for each write to
>>> MMIO?
>>>
>> One could argue whether in several places writel_relaxed() could be used.
>> But it's not really worth it, because we're not in a hot path.
> 
> I see. Thank you for your evaluation.
> 
> Using writel_relaxed() sounds clever. It expands to:
> 
>     #define build_mmio_write(name, size, type, reg, barrier) \
>         static inline void name(type val, volatile void __iomem *addr) \
>          { asm volatile("mov" size " %0,%1": :reg (val), \
>                         "m" (*(volatile type __force *)addr) barrier); }
>     build_mmio_write(__writel, "l", unsigned int, "r", )
>     #define writel_relaxed(v, a) __writel(v, a)
> 
> Here "barrier" is an empty string. Really clever. ;-)
> 
> I will not contradict, but the cummulative amount of memory barriers on each MMIO read/write
> in each single one of the drivers could amount to some degrading of overall performance and
> latency in a multicore system.
> 
> As I understood Mr. Jonathan Corbet on LWN, the initiative and trend is to reduce overall
> kernel latency.
> 
Sure, but there's better places to look at first than a rarely used path in a driver.
See e.g. the history of threadad NAPI (and in general the RT Linux developments) or
the optimizations deep in the network stack Eric is working on.

> Thanks,
> Mirsad
> 
>>> If it still uses a LOCK addl $0, m32/m64, then it still creates 130 instances of all core
>>> bus locks for this NIC reset after the lost PHY? I'm just thinking, this is nothing
>>> authoritative ...
>>>
>>>>> into a series of about 500+ memory bus locks, most waiting for the main memory read,
>>>>> modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
>>>>> the programming sequence to reach RTL NIC registers.
>>>>>
>>>>> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
>>>>>
>>>>> Fixes: fe4e8db0392a6 ("r8169: fix issue with confused RX unit after PHY power-down on RTL8411b")
>>>>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>>>>> Cc: Marco Elver <elver@google.com>
>>>>> Cc: nic_swsd@realtek.com
>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>>> Cc: netdev@vger.kernel.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
>>>>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>>> ---
>>>>> v3:
>>>>>    removed register/mask pair array sentinels, so using ARRAY_SIZE().
>>>>>    avoided duplication of RTL_W32() call code as advised by Heiner.
>>>>>
>>>>>    drivers/net/ethernet/realtek/r8169_main.c | 198 ++++++++--------------
>>>>>    1 file changed, 72 insertions(+), 126 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>>> index 361b90007148..3b28bec7098b 100644
>>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>>> @@ -939,6 +939,32 @@ static void r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
>>>>>        raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>>>>    }
>>>>>    +struct e_info_regmask_pair {
>>>>> +    u32    reg;
>>>>> +    u32    data;
>>>>> +};
>>>>> +
>>>>> +static void __r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
>>>>> +                      const struct e_info_regmask_pair *array, int len)
>>>>> +{
>>>>> +    struct e_info_regmask_pair const *p;
>>>>> +
>>>>> +    for (p = array; len--; p++)
>>>>> +        __r8168_mac_ocp_write(tp, p->reg, p->data);
>>>>> +}
>>>>> +
>>>>> +static void _r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
>>>>> +                     const struct e_info_regmask_pair *array, int len)
>>>>> +{
>>>>> +    unsigned long flags;
>>>>> +
>>>>> +    raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>>>> +    __r8168_mac_ocp_write_seq(tp, array, len);
>>>>> +    raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>>>> +}
>>>>> +
>>>>> +#define r8168_mac_ocp_write_seq(tp, a) _r8168_mac_ocp_write_seq(tp, a, ARRAY_SIZE(a))
>>>>> +
>>>>>    /* Work around a hw issue with RTL8168g PHY, the quirk disables
>>>>>     * PHY MCU interrupts before PHY power-down.
>>>>>     */
>>>>> @@ -3107,138 +3133,58 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>>>>        /* The following Realtek-provided magic fixes an issue with the RX unit
>>>>>         * getting confused after the PHY having been powered-down.
>>>>>         */
>>>>> -    r8168_mac_ocp_write(tp, 0xFC28, 0x0000);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC2A, 0x0000);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC2C, 0x0000);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC2E, 0x0000);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC30, 0x0000);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC32, 0x0000);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC34, 0x0000);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC36, 0x0000);
>>>>> +
>>>>> +    static const struct e_info_regmask_pair init_zero_seq[] = {
>>>>> +        { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 }, { 0xFC2E, 0x0000 },
>>>>> +        { 0xFC30, 0x0000 }, { 0xFC32, 0x0000 }, { 0xFC34, 0x0000 }, { 0xFC36, 0x0000 },
>>>>> +    };
>>>>> +
>>>> Don't mix code and variable declarations. Did you run checkpatch?
>>>> I think it would complain here.
>>>
>>> Thank you for the warning, I will fix it.
>>>
>>> As I said to Mr. Greg, I will do the required number of iterations to fix this issue.
>>>
>>> I will add checkpatch to my routine handling of my submitted patches.
>>>
>>> Thanks,
>>> Mirsad
>>>
>>>>> +    static const struct e_info_regmask_pair recover_seq[] = {
>>>>> +        { 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C }, { 0xF806, 0xE00E },
>>>>> +        { 0xF808, 0xE027 }, { 0xF80A, 0xE04F }, { 0xF80C, 0xE05E }, { 0xF80E, 0xE065 },
>>>>> +        { 0xF810, 0xC602 }, { 0xF812, 0xBE00 }, { 0xF814, 0x0000 }, { 0xF816, 0xC502 },
>>>>> +        { 0xF818, 0xBD00 }, { 0xF81A, 0x074C }, { 0xF81C, 0xC302 }, { 0xF81E, 0xBB00 },
>>>>> +        { 0xF820, 0x080A }, { 0xF822, 0x6420 }, { 0xF824, 0x48C2 }, { 0xF826, 0x8C20 },
>>>>> +        { 0xF828, 0xC516 }, { 0xF82A, 0x64A4 }, { 0xF82C, 0x49C0 }, { 0xF82E, 0xF009 },
>>>>> +        { 0xF830, 0x74A2 }, { 0xF832, 0x8CA5 }, { 0xF834, 0x74A0 }, { 0xF836, 0xC50E },
>>>>> +        { 0xF838, 0x9CA2 }, { 0xF83A, 0x1C11 }, { 0xF83C, 0x9CA0 }, { 0xF83E, 0xE006 },
>>>>> +        { 0xF840, 0x74F8 }, { 0xF842, 0x48C4 }, { 0xF844, 0x8CF8 }, { 0xF846, 0xC404 },
>>>>> +        { 0xF848, 0xBC00 }, { 0xF84A, 0xC403 }, { 0xF84C, 0xBC00 }, { 0xF84E, 0x0BF2 },
>>>>> +        { 0xF850, 0x0C0A }, { 0xF852, 0xE434 }, { 0xF854, 0xD3C0 }, { 0xF856, 0x49D9 },
>>>>> +        { 0xF858, 0xF01F }, { 0xF85A, 0xC526 }, { 0xF85C, 0x64A5 }, { 0xF85E, 0x1400 },
>>>>> +        { 0xF860, 0xF007 }, { 0xF862, 0x0C01 }, { 0xF864, 0x8CA5 }, { 0xF866, 0x1C15 },
>>>>> +        { 0xF868, 0xC51B }, { 0xF86A, 0x9CA0 }, { 0xF86C, 0xE013 }, { 0xF86E, 0xC519 },
>>>>> +        { 0xF870, 0x74A0 }, { 0xF872, 0x48C4 }, { 0xF874, 0x8CA0 }, { 0xF876, 0xC516 },
>>>>> +        { 0xF878, 0x74A4 }, { 0xF87A, 0x48C8 }, { 0xF87C, 0x48CA }, { 0xF87E, 0x9CA4 },
>>>>> +        { 0xF880, 0xC512 }, { 0xF882, 0x1B00 }, { 0xF884, 0x9BA0 }, { 0xF886, 0x1B1C },
>>>>> +        { 0xF888, 0x483F }, { 0xF88A, 0x9BA2 }, { 0xF88C, 0x1B04 }, { 0xF88E, 0xC508 },
>>>>> +        { 0xF890, 0x9BA0 }, { 0xF892, 0xC505 }, { 0xF894, 0xBD00 }, { 0xF896, 0xC502 },
>>>>> +        { 0xF898, 0xBD00 }, { 0xF89A, 0x0300 }, { 0xF89C, 0x051E }, { 0xF89E, 0xE434 },
>>>>> +        { 0xF8A0, 0xE018 }, { 0xF8A2, 0xE092 }, { 0xF8A4, 0xDE20 }, { 0xF8A6, 0xD3C0 },
>>>>> +        { 0xF8A8, 0xC50F }, { 0xF8AA, 0x76A4 }, { 0xF8AC, 0x49E3 }, { 0xF8AE, 0xF007 },
>>>>> +        { 0xF8B0, 0x49C0 }, { 0xF8B2, 0xF103 }, { 0xF8B4, 0xC607 }, { 0xF8B6, 0xBE00 },
>>>>> +        { 0xF8B8, 0xC606 }, { 0xF8BA, 0xBE00 }, { 0xF8BC, 0xC602 }, { 0xF8BE, 0xBE00 },
>>>>> +        { 0xF8C0, 0x0C4C }, { 0xF8C2, 0x0C28 }, { 0xF8C4, 0x0C2C }, { 0xF8C6, 0xDC00 },
>>>>> +        { 0xF8C8, 0xC707 }, { 0xF8CA, 0x1D00 }, { 0xF8CC, 0x8DE2 }, { 0xF8CE, 0x48C1 },
>>>>> +        { 0xF8D0, 0xC502 }, { 0xF8D2, 0xBD00 }, { 0xF8D4, 0x00AA }, { 0xF8D6, 0xE0C0 },
>>>>> +        { 0xF8D8, 0xC502 }, { 0xF8DA, 0xBD00 }, { 0xF8DC, 0x0132 },
>>>>> +    };
>>>>> +
>>>>> +    static const struct e_info_regmask_pair final_seq[] = {
>>>>> +        { 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 }, { 0xFC30, 0x02FD },
>>>>> +        { 0xFC32, 0x0C25 }, { 0xFC34, 0x00A9 }, { 0xFC36, 0x012D },
>>>>> +    };
>>>>> +
>>>>> +    r8168_mac_ocp_write_seq(tp, init_zero_seq);
>>>>>        mdelay(3);
>>>>>        r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
>>>>>    -    r8168_mac_ocp_write(tp, 0xF800, 0xE008);
>>>>> -    r8168_mac_ocp_write(tp, 0xF802, 0xE00A);
>>>>> -    r8168_mac_ocp_write(tp, 0xF804, 0xE00C);
>>>>> -    r8168_mac_ocp_write(tp, 0xF806, 0xE00E);
>>>>> -    r8168_mac_ocp_write(tp, 0xF808, 0xE027);
>>>>> -    r8168_mac_ocp_write(tp, 0xF80A, 0xE04F);
>>>>> -    r8168_mac_ocp_write(tp, 0xF80C, 0xE05E);
>>>>> -    r8168_mac_ocp_write(tp, 0xF80E, 0xE065);
>>>>> -    r8168_mac_ocp_write(tp, 0xF810, 0xC602);
>>>>> -    r8168_mac_ocp_write(tp, 0xF812, 0xBE00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF814, 0x0000);
>>>>> -    r8168_mac_ocp_write(tp, 0xF816, 0xC502);
>>>>> -    r8168_mac_ocp_write(tp, 0xF818, 0xBD00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF81A, 0x074C);
>>>>> -    r8168_mac_ocp_write(tp, 0xF81C, 0xC302);
>>>>> -    r8168_mac_ocp_write(tp, 0xF81E, 0xBB00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF820, 0x080A);
>>>>> -    r8168_mac_ocp_write(tp, 0xF822, 0x6420);
>>>>> -    r8168_mac_ocp_write(tp, 0xF824, 0x48C2);
>>>>> -    r8168_mac_ocp_write(tp, 0xF826, 0x8C20);
>>>>> -    r8168_mac_ocp_write(tp, 0xF828, 0xC516);
>>>>> -    r8168_mac_ocp_write(tp, 0xF82A, 0x64A4);
>>>>> -    r8168_mac_ocp_write(tp, 0xF82C, 0x49C0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF82E, 0xF009);
>>>>> -    r8168_mac_ocp_write(tp, 0xF830, 0x74A2);
>>>>> -    r8168_mac_ocp_write(tp, 0xF832, 0x8CA5);
>>>>> -    r8168_mac_ocp_write(tp, 0xF834, 0x74A0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF836, 0xC50E);
>>>>> -    r8168_mac_ocp_write(tp, 0xF838, 0x9CA2);
>>>>> -    r8168_mac_ocp_write(tp, 0xF83A, 0x1C11);
>>>>> -    r8168_mac_ocp_write(tp, 0xF83C, 0x9CA0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF83E, 0xE006);
>>>>> -    r8168_mac_ocp_write(tp, 0xF840, 0x74F8);
>>>>> -    r8168_mac_ocp_write(tp, 0xF842, 0x48C4);
>>>>> -    r8168_mac_ocp_write(tp, 0xF844, 0x8CF8);
>>>>> -    r8168_mac_ocp_write(tp, 0xF846, 0xC404);
>>>>> -    r8168_mac_ocp_write(tp, 0xF848, 0xBC00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF84A, 0xC403);
>>>>> -    r8168_mac_ocp_write(tp, 0xF84C, 0xBC00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF84E, 0x0BF2);
>>>>> -    r8168_mac_ocp_write(tp, 0xF850, 0x0C0A);
>>>>> -    r8168_mac_ocp_write(tp, 0xF852, 0xE434);
>>>>> -    r8168_mac_ocp_write(tp, 0xF854, 0xD3C0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF856, 0x49D9);
>>>>> -    r8168_mac_ocp_write(tp, 0xF858, 0xF01F);
>>>>> -    r8168_mac_ocp_write(tp, 0xF85A, 0xC526);
>>>>> -    r8168_mac_ocp_write(tp, 0xF85C, 0x64A5);
>>>>> -    r8168_mac_ocp_write(tp, 0xF85E, 0x1400);
>>>>> -    r8168_mac_ocp_write(tp, 0xF860, 0xF007);
>>>>> -    r8168_mac_ocp_write(tp, 0xF862, 0x0C01);
>>>>> -    r8168_mac_ocp_write(tp, 0xF864, 0x8CA5);
>>>>> -    r8168_mac_ocp_write(tp, 0xF866, 0x1C15);
>>>>> -    r8168_mac_ocp_write(tp, 0xF868, 0xC51B);
>>>>> -    r8168_mac_ocp_write(tp, 0xF86A, 0x9CA0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF86C, 0xE013);
>>>>> -    r8168_mac_ocp_write(tp, 0xF86E, 0xC519);
>>>>> -    r8168_mac_ocp_write(tp, 0xF870, 0x74A0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF872, 0x48C4);
>>>>> -    r8168_mac_ocp_write(tp, 0xF874, 0x8CA0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF876, 0xC516);
>>>>> -    r8168_mac_ocp_write(tp, 0xF878, 0x74A4);
>>>>> -    r8168_mac_ocp_write(tp, 0xF87A, 0x48C8);
>>>>> -    r8168_mac_ocp_write(tp, 0xF87C, 0x48CA);
>>>>> -    r8168_mac_ocp_write(tp, 0xF87E, 0x9CA4);
>>>>> -    r8168_mac_ocp_write(tp, 0xF880, 0xC512);
>>>>> -    r8168_mac_ocp_write(tp, 0xF882, 0x1B00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF884, 0x9BA0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF886, 0x1B1C);
>>>>> -    r8168_mac_ocp_write(tp, 0xF888, 0x483F);
>>>>> -    r8168_mac_ocp_write(tp, 0xF88A, 0x9BA2);
>>>>> -    r8168_mac_ocp_write(tp, 0xF88C, 0x1B04);
>>>>> -    r8168_mac_ocp_write(tp, 0xF88E, 0xC508);
>>>>> -    r8168_mac_ocp_write(tp, 0xF890, 0x9BA0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF892, 0xC505);
>>>>> -    r8168_mac_ocp_write(tp, 0xF894, 0xBD00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF896, 0xC502);
>>>>> -    r8168_mac_ocp_write(tp, 0xF898, 0xBD00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF89A, 0x0300);
>>>>> -    r8168_mac_ocp_write(tp, 0xF89C, 0x051E);
>>>>> -    r8168_mac_ocp_write(tp, 0xF89E, 0xE434);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8A0, 0xE018);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8A2, 0xE092);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8A4, 0xDE20);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8A6, 0xD3C0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8A8, 0xC50F);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8AA, 0x76A4);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8AC, 0x49E3);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8AE, 0xF007);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8B0, 0x49C0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8B2, 0xF103);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8B4, 0xC607);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8B6, 0xBE00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8B8, 0xC606);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8BA, 0xBE00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8BC, 0xC602);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8BE, 0xBE00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8C0, 0x0C4C);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8C2, 0x0C28);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8C4, 0x0C2C);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8C6, 0xDC00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8C8, 0xC707);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8CA, 0x1D00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8CC, 0x8DE2);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8CE, 0x48C1);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8D0, 0xC502);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8D2, 0xBD00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8D4, 0x00AA);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8D6, 0xE0C0);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8D8, 0xC502);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8DA, 0xBD00);
>>>>> -    r8168_mac_ocp_write(tp, 0xF8DC, 0x0132);
>>>>> +    r8168_mac_ocp_write_seq(tp, recover_seq);
>>>>>          r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
>>>>>    -    r8168_mac_ocp_write(tp, 0xFC2A, 0x0743);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC2C, 0x0801);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC2E, 0x0BE9);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC30, 0x02FD);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC32, 0x0C25);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC34, 0x00A9);
>>>>> -    r8168_mac_ocp_write(tp, 0xFC36, 0x012D);
>>>>> +    r8168_mac_ocp_write_seq(tp, final_seq);
>>>>> +
>>>>>    }
>>>>>      static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)

