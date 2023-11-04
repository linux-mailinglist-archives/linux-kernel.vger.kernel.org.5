Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD27E116A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 23:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjKDWhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 18:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKDWhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 18:37:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38D2BE;
        Sat,  4 Nov 2023 15:37:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9becde9ea7bso869761366b.0;
        Sat, 04 Nov 2023 15:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699137450; x=1699742250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZNqSh0oQPHdZhDWkKPMlHLzYAHqkWnwVYhh285BWZA=;
        b=GLkact6u9rTSSpLsa5qfLizAi2OK5950KPxJfU/1+v9abWbBRPoOJ2168GlymrI/0R
         lfrtCEMEZjpTDkhSsGTNmSqK1YeSLm57CbFb7HOxorVuqpL1G7Y5ycylcw3FlCSqbstY
         pa7+qEoPr/lvfymI/kCf9pOz2Qck+SR6jh4Bg1sFY4h/yHwBMf7NYFDxEKzXRzGsvW+r
         pXi1ZanWLVUQk1lRZP16MWd3W+Ub3qMWVQrCpE84GtSwGeEifI4Y9F/RNLU5mcY6dS5c
         51GFTPwvM897nuCR5eyViMNLhG26gbzdXEq5kA5dQDAc34c3lipk0vknWhlM8Qkkganj
         Z/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699137450; x=1699742250;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZNqSh0oQPHdZhDWkKPMlHLzYAHqkWnwVYhh285BWZA=;
        b=KagY2JTfWAC83TKn4paIQxn1XN+m0tokgUmmylS8O9TnpnocAdK0+Y5dO8BQYNy2U4
         ccdRy0lOr5AXofiteCl3AAOCVYlklNoPzlpdTsjK5jMi/60gkL1F8N9snTr+bRsJ29Ur
         dduA+oVkbdyg1Q5x+2JxwjvP0DHefx2K6s3SaW7stfaflVAJXLT4pT0r1AxANqHmbEg2
         6k2bnpUmzesecHirhh/xcYRpp2SGKdW6f7AGrMs2lnD7NjVfeZ7RwTUK3RyREW6ZXwoG
         GCjYfUF1tcx4gxuM2YS8Dd3BgeEPyKb2tGpAb14fA0CBRbCEY9JWGQ3ngQqknhNCP1Yr
         Q+Lg==
X-Gm-Message-State: AOJu0YyCan+MLVVd9kHslDziq6lSL3U+E13PuN6laDfk2RyKBwmfw84v
        QoDwCLlTHMi9yHkaBddCg0s=
X-Google-Smtp-Source: AGHT+IHAAP8xncAigtBI7WwcxrWJC0PX62tYR+biNNTEYdTSIyE7g9dYgC6eCND70oeT6Z3cWvdNDg==
X-Received: by 2002:a17:907:3e14:b0:9dd:e124:4b39 with SMTP id hp20-20020a1709073e1400b009dde1244b39mr2778950ejc.10.1699137450304;
        Sat, 04 Nov 2023 15:37:30 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7795:6000:e95b:b2da:b58e:f826? (dynamic-2a01-0c22-7795-6000-e95b-b2da-b58e-f826.c22.pool.telefonica.de. [2a01:c22:7795:6000:e95b:b2da:b58e:f826])
        by smtp.googlemail.com with ESMTPSA id gu3-20020a170906f28300b009cd1fca4d68sm2392877ejb.5.2023.11.04.15.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 15:37:29 -0700 (PDT)
Message-ID: <da4409f3-d509-413b-8433-f222acbbb1be@gmail.com>
Date:   Sat, 4 Nov 2023 23:37:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/5] Coalesce mac ocp write/modify calls to
 reduce spinlock contention
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com
References: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 04.11.2023 23:15, Mirsad Goran Todorovac wrote:
> The motivation for these helpers was the locking overhead of 130 consecutive
> r8168_mac_ocp_write() calls in the RTL8411b reset after the NIC gets confused
> if the PHY is powered-down.
> 
> To quote Heiner:
> 
>     On RTL8411b the RX unit gets confused if the PHY is powered-down.
>     This was reported in [0] and confirmed by Realtek. Realtek provided
>     a sequence to fix the RX unit after PHY wakeup.
> 
> A series of about 130 r8168_mac_ocp_write() calls is performed to program the
> RTL registers for recovery, each doing an expensive spin_lock_irqsave() and
> spin_unlock_irqrestore().
> 
> Each mac ocp write is made of:
> 
>     static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>                       u32 data)
>     {
>         if (rtl_ocp_reg_failure(reg))
>             return;
> 
>         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>     }
> 
>     static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>                     u32 data)
>     {
>         unsigned long flags;
> 
>         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>         __r8168_mac_ocp_write(tp, reg, data);
>         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>     }
> 
> Register programming is done through RTL_W32() macro which expands into
> 
>     #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
> 
> which is further (on Alpha):
> 
>     extern inline void writel(u32 b, volatile void __iomem *addr)
>     {
>         mb();
>         __raw_writel(b, addr);
>     }
> 
> or on i386/x86_64:
> 
>     #define build_mmio_write(name, size, type, reg, barrier) \
>     static inline void name(type val, volatile void __iomem *addr) \
>     { asm volatile("mov" size " %0,%1": :reg (val), \
>     "m" (*(volatile type __force *)addr) barrier); }
> 
>     build_mmio_write(writel, "l", unsigned int, "r", :"memory")
> 
> This obviously involves iat least a compiler barrier.
> 
> mb() expands into something like this i.e. on x86_64:
> 
>     #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
> 
> This means a whole lot of memory bus stalls: for spin_lock_irqsave(),
> memory barrier, writel(), and spin_unlock_irqrestore().
> 
> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
> a lock storm that will stall all of the cores and CPUs on the same memory controller
> for certain time I/O takes to finish.
> 
> In a sequential case of RTL register programming, the writes to RTL registers
> can be coalesced under a same raw spinlock. This can dramatically decrease the
> number of bus stalls in a multicore or multi-CPU system.
> 
> Macro helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq() are
> provided to reduce lock contention:
> 
>     static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>     {
> 
>         ...
> 
>         /* The following Realtek-provided magic fixes an issue with the RX unit
>          * getting confused after the PHY having been powered-down.
>          */
> 
>         static const struct recover_8411b_info init_zero_seq[] = {
>             { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
>             ...
>         };
> 
>         ...
> 
>         r8168_mac_ocp_write_seq(tp, init_zero_seq);
> 
>         ...
> 
>     }
> 
> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
> functions that only changed the function names and the ending of the line, so the actual
> hex data is unchanged.
> 
> To repeat, the reason for the introduction of the original commit
> was to enable recovery of the RX unit on the RTL8411b which was confused by the
> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
> into a series of about 500+ memory bus locks, most waiting for the main memory read,
> modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
> the programming sequence to reach RTL NIC registers.
> 
> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
> 
> v6:
>  proceeded according to Jacob Keller's suggestions by creating a cover page and reducing
>  the text within the commits. Applying to the net-next tree as Heiner Kallweit requested.
> 
> v5:
>  attempted some new optimisations, which were rejected, but not all and not completely.
> 
> v4:
>  fixed complaints as advised by Heiner and checkpatch.pl.
>  split the patch into five sections to be more easily manipulated and reviewed
>  introduced r8168_mac_ocp_write_seq()
>  applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B
> 
> v3:
>  removed register/mask pair array sentinels, so using ARRAY_SIZE().
>  avoided duplication of RTL_W32() call code as advised by Heiner.
> 
> Mirsad Goran Todorovac (5):
>   r8169: Coalesce r8169_mac_ocp_write/modify calls to reduce spinlock
>     stalls
>   r8169: Coalesce RTL8411b PHY power-down recovery calls to reduce
>     spinlock stalls
>   r8169: Coalesce mac ocp write and modify for 8168H start to reduce
>     spinlocks
>   r8169: Coalesce mac ocp commands for 8125 and 8125B start to reduce
>     spinlock contention
>   r8169: Coalesce mac ocp commands for rtl_hw_init_8125 to reduce
>     spinlocks
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 304 +++++++++++-----------
>  1 file changed, 150 insertions(+), 154 deletions(-)
> 

You still write:
"a lock storm that will stall all of the cores and CPUs on the same memory controller"
even though you were informed that that's not the case.
There's no actual problem, therefore your Fixes tags are incorrect.
Also net-next is closed at the moment.
In patches 3-5 I see no benefit. And I have doubts whether the small benefit in
patch 2 is worth adding all the helpers in patch 1.

