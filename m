Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238127E12BB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 10:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjKEJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 04:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 04:21:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C6DBD;
        Sun,  5 Nov 2023 01:21:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54394328f65so5689040a12.3;
        Sun, 05 Nov 2023 01:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699176060; x=1699780860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hlO7ys9Qou7ui8p5xc3vIP0H7SQPuo1hSpR7/yYVFA=;
        b=Io4dXxeTcLn8+QoRtbvibyCybc9ggX4rNDIxvL/5zAFtq0nbcrd7Gd3P+RlZwfEWnE
         haVVoNFKCpPLMcuHwS3yiAss8Sy40Ynn43HhW5thsMx+co/T9fjONA3wIj2feKUc9G6Q
         e+6mjGTEG0bwKjT7izLgqol/f5wo3Y4n96MAOWL5ftrCGk1evKYHyG7LZG5gUvKavc3l
         29emFzv7YCLyhYFHjn+W0kV3idHcvjnhRPbcnG5Unbj7o79HQSiLsCmYx8L2pzL6zkYc
         Qffpek+WomQW673HEseauAipwI1nkHhfLv4OQ0IjIjhJOGrih83rj3yDtqp9ESILyeoM
         vmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699176060; x=1699780860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hlO7ys9Qou7ui8p5xc3vIP0H7SQPuo1hSpR7/yYVFA=;
        b=kP/vSLWRi6IwbDKCsOyT27sa8+j6xCsIpmSoGM4gawtZWGAIV91+D8irE/0GKSKEMA
         eYiBoDlsg3G1Gz4drnNFH8AqKXumJnMU2ThjgbrrDsIryHq08JDbxLbVGKfWoRemXnNx
         A8Io/+kWtcQbiJQcIjrIiwG6S3QwU2Gn3F2EFl5lA8BjaDQXKEbThvylyzZkAAMTDpz9
         u2/isyGIB2C1vHQgbuIPJ0+gLq4fEfxuId2q/KVu0Rax7cwhWO8ivgrnKqBs3N9OVSJp
         eZRlktsloiMmU8U1qth0JRY6Yj0DCgEJ7uEDHOupcoMkzFZ6aJZZ8IwZxwJpAldp9Lt/
         1dDg==
X-Gm-Message-State: AOJu0Yz4k28Ccm9Inc/8bMXR/GhEC1RdbWVR0b9QH4X1m4QhmdLQHwUP
        oRTSKhpYdT36O/bm0iSd4bg=
X-Google-Smtp-Source: AGHT+IEAdOfl0s5Rzt+1xNvncnZYeaD16CSAEocb8Xx7i2/+x5Cm9JpioZVE7NeToEZrlDtlkJTX0g==
X-Received: by 2002:a50:9e81:0:b0:532:bed7:d0dd with SMTP id a1-20020a509e81000000b00532bed7d0ddmr22453430edf.5.1699176059373;
        Sun, 05 Nov 2023 01:20:59 -0800 (PST)
Received: from ?IPV6:2a01:c22:73fa:b000:61d3:217:b797:5587? (dynamic-2a01-0c22-73fa-b000-61d3-0217-b797-5587.c22.pool.telefonica.de. [2a01:c22:73fa:b000:61d3:217:b797:5587])
        by smtp.googlemail.com with ESMTPSA id g23-20020a50d5d7000000b0053eb9af1e15sm3140313edj.77.2023.11.05.01.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 01:20:58 -0800 (PST)
Message-ID: <716b3dc3-231e-4fd2-b892-707c0d636d00@gmail.com>
Date:   Sun, 5 Nov 2023 10:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/5] Coalesce mac ocp write/modify calls to
 reduce spinlock contention
Content-Language: en-US
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com
References: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
 <da4409f3-d509-413b-8433-f222acbbb1be@gmail.com>
 <edee64f4-442d-4670-a91b-e5b83117dd40@alu.unizg.hr>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <edee64f4-442d-4670-a91b-e5b83117dd40@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.11.2023 01:15, Mirsad Todorovac wrote:
> 
> 
> On 11/4/23 23:37, Heiner Kallweit wrote:
>> On 04.11.2023 23:15, Mirsad Goran Todorovac wrote:
>>> The motivation for these helpers was the locking overhead of 130 consecutive
>>> r8168_mac_ocp_write() calls in the RTL8411b reset after the NIC gets confused
>>> if the PHY is powered-down.
>>>
>>> To quote Heiner:
>>>
>>>      On RTL8411b the RX unit gets confused if the PHY is powered-down.
>>>      This was reported in [0] and confirmed by Realtek. Realtek provided
>>>      a sequence to fix the RX unit after PHY wakeup.
>>>
>>> A series of about 130 r8168_mac_ocp_write() calls is performed to program the
>>> RTL registers for recovery, each doing an expensive spin_lock_irqsave() and
>>> spin_unlock_irqrestore().
>>>
>>> Each mac ocp write is made of:
>>>
>>>      static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>>>                        u32 data)
>>>      {
>>>          if (rtl_ocp_reg_failure(reg))
>>>              return;
>>>
>>>          RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>>>      }
>>>
>>>      static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>>>                      u32 data)
>>>      {
>>>          unsigned long flags;
>>>
>>>          raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>>          __r8168_mac_ocp_write(tp, reg, data);
>>>          raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>>      }
>>>
>>> Register programming is done through RTL_W32() macro which expands into
>>>
>>>      #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
>>>
>>> which is further (on Alpha):
>>>
>>>      extern inline void writel(u32 b, volatile void __iomem *addr)
>>>      {
>>>          mb();
>>>          __raw_writel(b, addr);
>>>      }
>>>
>>> or on i386/x86_64:
>>>
>>>      #define build_mmio_write(name, size, type, reg, barrier) \
>>>      static inline void name(type val, volatile void __iomem *addr) \
>>>      { asm volatile("mov" size " %0,%1": :reg (val), \
>>>      "m" (*(volatile type __force *)addr) barrier); }
>>>
>>>      build_mmio_write(writel, "l", unsigned int, "r", :"memory")
>>>
>>> This obviously involves iat least a compiler barrier.
>>>
>>> mb() expands into something like this i.e. on x86_64:
>>>
>>>      #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
>>>
>>> This means a whole lot of memory bus stalls: for spin_lock_irqsave(),
>>> memory barrier, writel(), and spin_unlock_irqrestore().
>>>
>>> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
>>> a lock storm that will stall all of the cores and CPUs on the same memory controller
>>> for certain time I/O takes to finish.
>>>
>>> In a sequential case of RTL register programming, the writes to RTL registers
>>> can be coalesced under a same raw spinlock. This can dramatically decrease the
>>> number of bus stalls in a multicore or multi-CPU system.
>>>
>>> Macro helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq() are
>>> provided to reduce lock contention:
>>>
>>>      static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>>      {
>>>
>>>          ...
>>>
>>>          /* The following Realtek-provided magic fixes an issue with the RX unit
>>>           * getting confused after the PHY having been powered-down.
>>>           */
>>>
>>>          static const struct recover_8411b_info init_zero_seq[] = {
>>>              { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
>>>              ...
>>>          };
>>>
>>>          ...
>>>
>>>          r8168_mac_ocp_write_seq(tp, init_zero_seq);
>>>
>>>          ...
>>>
>>>      }
>>>
>>> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
>>> functions that only changed the function names and the ending of the line, so the actual
>>> hex data is unchanged.
>>>
>>> To repeat, the reason for the introduction of the original commit
>>> was to enable recovery of the RX unit on the RTL8411b which was confused by the
>>> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
>>> into a series of about 500+ memory bus locks, most waiting for the main memory read,
>>> modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
>>> the programming sequence to reach RTL NIC registers.
>>>
>>> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
>>>
>>> v6:
>>>   proceeded according to Jacob Keller's suggestions by creating a cover page and reducing
>>>   the text within the commits. Applying to the net-next tree as Heiner Kallweit requested.
>>>
>>> v5:
>>>   attempted some new optimisations, which were rejected, but not all and not completely.
>>>
>>> v4:
>>>   fixed complaints as advised by Heiner and checkpatch.pl.
>>>   split the patch into five sections to be more easily manipulated and reviewed
>>>   introduced r8168_mac_ocp_write_seq()
>>>   applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B
>>>
>>> v3:
>>>   removed register/mask pair array sentinels, so using ARRAY_SIZE().
>>>   avoided duplication of RTL_W32() call code as advised by Heiner.
>>>
>>> Mirsad Goran Todorovac (5):
>>>    r8169: Coalesce r8169_mac_ocp_write/modify calls to reduce spinlock
>>>      stalls
>>>    r8169: Coalesce RTL8411b PHY power-down recovery calls to reduce
>>>      spinlock stalls
>>>    r8169: Coalesce mac ocp write and modify for 8168H start to reduce
>>>      spinlocks
>>>    r8169: Coalesce mac ocp commands for 8125 and 8125B start to reduce
>>>      spinlock contention
>>>    r8169: Coalesce mac ocp commands for rtl_hw_init_8125 to reduce
>>>      spinlocks
>>>
>>>   drivers/net/ethernet/realtek/r8169_main.c | 304 +++++++++++-----------
>>>   1 file changed, 150 insertions(+), 154 deletions(-)
>>>
> 
> Hi, Mr. Kallweit,
> 
> So good to hear so soon from you. I'm encouraged that you are positive about improving
> the speed and reducing the size of the Realtek drivers.
> 
>> You still write:
>> "a lock storm that will stall all of the cores and CPUs on the same memory controller"
>> even though you were informed that that's not the case.
> 
> I was not convinced. There is no such thing as a free lunch, and there is no locking
> without affecting other cores, or locking would not make sense.
> 
>> There's no actual problem, therefore your Fixes tags are incorrect.
> 
> Mea culpa - my mistake, I will fix that in the next version.
> 
>> Also net-next is closed at the moment.
> 
> There is no problem with that, as these are only optimisation fixes, not zero day
> exploits. I am a patient person.
> 
>> In patches 3-5 I see no benefit. And I have doubts whether the small benefit in
>> patch 2 is worth adding all the helpers in patch 1.
> 
> I merely followed and mimed driver style from the constructions like this one:
> 
>         static const struct ephy_info e_info_8168e_1[] = {
>                 { 0x00, 0x0200, 0x0100 },
>                 { 0x00, 0x0000, 0x0004 },
>                 { 0x06, 0x0002, 0x0001 },
>                 { 0x06, 0x0000, 0x0030 },
>                 { 0x07, 0x0000, 0x2000 },
>                 { 0x00, 0x0000, 0x0020 },
>                 { 0x03, 0x5800, 0x2000 },
>                 { 0x03, 0x0000, 0x0001 },
>                 { 0x01, 0x0800, 0x1000 },
>                 { 0x07, 0x0000, 0x4000 },
>                 { 0x1e, 0x0000, 0x2000 },
>                 { 0x19, 0xffff, 0xfe6c },
>                 { 0x0a, 0x0000, 0x0040 }
>         };
> 
>         rtl_set_def_aspm_entry_latency(tp);
> 
>         rtl_ephy_init(tp, e_info_8168e_1);
> 
> Here you did not think that introducing an array reduced code readability.
> 
> My ideal is a lockless driver using RCU, and you seem to prefer lock/unlock
> on each RTL_W32() write. I am convinced that a driver with less
> raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() pairs would scale better
> with more NICs and more cores.
> 
Then please focus on hot paths where it actually could make a difference,
and provide numbers instead of a purely theoretical discussion.

> You said nothing to convinced me otherwise.
> 
> But I am merely defending my point, this by no means implies disrespect or overlooking
> your contribution to the source as a coder and a a maintainer.
> 
> Realtek NICs are known as cheap NIC for motherboards, but they are becoming more ubiquitous,
> and it is logical to use less locking, as locking is expensive. "barrier" in writev()
> guarantees sequential orders of write, and locking and unlocking on each read/modify/write
> is unnecessary overhead, IMHO.
> 
> As the conclusion, I would like to emphasise that improving lock contention for the code
> is by no means a personal attack on the maintainer or a breach of the Code of Conduct.
> 
> If you are so much against the changes which Mr. Jacob Keller from Intel reviewed,
> maybe we can cool emotions and start thinking rationally.
> 
> Additionally, I would like to "inline" many functions, as I think that call/return
> sequences with stack frame generation /destruction are more expensive than inlining the
> small one liners.
> 

Mainline standard is to let the compiler decide on inlining.

> But I will certainly respect your opinion on the matter as a maintainer.
> 
> What I realise that I might be optimising the cold paths of the code, but from your emails
> it seems like nothing is worth optimising in this driver, and with all due respect Sir,
> I think that is dead wrong.
> 

Nobody ever said that, and if you look at the history of the driver you'll see a lot of
optimizations that have been added over time. Ideally an optimization improves both:
performance and code readability
Code readability is important for maintainability and weighs higher for me than a minor
performance optimization in a code path that is very rarely used.

> Of course, I am tempted to comply to the authority as a kernel newbie, but I was reminded
> in the spirit that this is exactly what the guys in Chernobyl did while maintaining the
> reactor that malfunctioned: they did not dare to question the authority telling them that
> everything is alright.
> 
> Have a nice evening, and please do not take these words as a breach of the Code or a
> personal attack. I believe we are on the same side, and that is making this driver better.
> 
> The Linux kernel developer community was my last hope that this human race has a force
> to improve the mankind and make it worth surviving.
> 
> But sometimes it is more honourable to go down with the ship and preserve the honour.
> 
> Best regards,
> Mirsad Todorovac

