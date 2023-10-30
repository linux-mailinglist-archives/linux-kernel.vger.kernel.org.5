Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE097DBB48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjJ3OEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjJ3OEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:04:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA4DC0;
        Mon, 30 Oct 2023 07:04:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d34b2b51a5so192336366b.2;
        Mon, 30 Oct 2023 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698674641; x=1699279441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tqym31TjxbtaWdc4iL62cAqdr3Bt3BI3Pwe8MUfHDAA=;
        b=XVQObYp26zK2wIPPSMMItyKptmFDQXN/8jgaAZizT+3U5fKIUBAaP45kx2450yRjS9
         SamH/zgrFeMDRp7JuuW5/OhttJO6BvqDSYlLoPd2PQbiFoGC2al29twKVF0DzaN2FdSQ
         HLHs+Nyp+8SneEr9GHLYKbHxM+EC0f+H626O78INDHW3JrkIHqw8g/BrMqcF2H2bHvXB
         2cHdLIi3Mw+DzfoI4hQFUOwGoFA121/jj/lIwKQXwjn2IUzcOxmWPFj/nex4USMG4TWA
         fv8JwWB9Iz0Ki2rpNlgy7tT8JJ1uKfr4bJFQsKSrRSoe1RC9QYq5I3eSK0Wk16hIsphv
         gsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674641; x=1699279441;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqym31TjxbtaWdc4iL62cAqdr3Bt3BI3Pwe8MUfHDAA=;
        b=F6891Xw7VLm1EniEregr9tLzVrhoOehX7cbmLhZqHLYV9CMmvQ1vimGAc6UXt/BRFv
         ZAIm9ycFGjIVyblG0ejWDDXggrbNlVroLrz2eo/44zBlhpconeaoWYUdJuy8I1JMGiuI
         KxAoU7USIA4CMZ9s+22Swv/sg4i12eRYCx5JJ0Y78D0+lBowww2cTnL/uNkqtEwwP9JK
         F1heqjGAploSq+Rlig5Q9RFyHtRl/GgkQKtAjk9WMx/Jl6kABlPj+2IJR5CGnZOO1kzj
         +57FoLY6Tx/o9manCqGPY8DrYZop1KlG8R88z2OlGaLqxD4FdLS5h8pP7Vk+ZBXSZbW6
         UWdA==
X-Gm-Message-State: AOJu0YyRMUwdb2MGx301scdFK+Oid6o2swkDeNsp9N3RgspeDZMfT6VL
        mYUPtsQxI0Gq6O8ffdh2KmpmNPdK1qE=
X-Google-Smtp-Source: AGHT+IGEXWDlNqEt/q62H+39ILUjYF0RZE7Et9udug0UMd9IUiZ7Uhf1VAM/oQE94p3dk1uEkxGjHA==
X-Received: by 2002:a17:907:930a:b0:9bd:abb2:d4e0 with SMTP id bu10-20020a170907930a00b009bdabb2d4e0mr7462497ejc.22.1698674640748;
        Mon, 30 Oct 2023 07:04:00 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc31:8900:5db7:a938:1060:35a3? (dynamic-2a01-0c23-bc31-8900-5db7-a938-1060-35a3.c23.pool.telefonica.de. [2a01:c23:bc31:8900:5db7:a938:1060:35a3])
        by smtp.googlemail.com with ESMTPSA id n27-20020a5099db000000b0053116e45317sm6278564edb.44.2023.10.30.07.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:04:00 -0700 (PDT)
Message-ID: <34e2d832-a1ed-4a9f-a38c-4ab8b1ee72f0@gmail.com>
Date:   Mon, 30 Oct 2023 14:39:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] r8169: Add r8169_mac_ocp_(write|modify)_seq
 helpers to reduce spinlock contention
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.10.2023 19:35, Mirsad Goran Todorovac wrote:
> A pair of new helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq()
> are introduced.
> 
At first one more formal remark: series is missing a cover letter

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
> 		      u32 data)
>     {
> 	if (rtl_ocp_reg_failure(reg))
> 	    return;
> 
> 	RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>     }
> 
>     static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
> 		    u32 data)
>     {
> 	unsigned long flags;
> 
> 	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
> 	__r8168_mac_ocp_write(tp, reg, data);
> 	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
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
> 	mb();
> 	__raw_writel(b, addr);
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
> 	...
> 
> 	/* The following Realtek-provided magic fixes an issue with the RX unit
> 	 * getting confused after the PHY having been powered-down.
> 	 */
> 
> 	static const struct recover_8411b_info init_zero_seq[] = {
> 	    { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
> 	    ...
> 	};
> 
> 	...
> 
> 	r8168_mac_ocp_write_seq(tp, init_zero_seq);
> 
> 	...
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
The motivation for the original change isn't relevant here.
In general I'd prefer a shorter commit message that comes to the point immediately.


> Fixes: fe4e8db0392a6 ("r8169: fix issue with confused RX unit after PHY power-down on RTL8411b")
> Fixes: 91c8643578a21 ("r8169: use spinlock to protect mac ocp register access")
> Fixes: d6c36cbc5e533 ("r8169: Use a raw_spinlock_t for the register locks.")

Please submit the patches as net-next material and remove the Fixes tags as there's no
evidence of any actual issue. See stable submission criteria:
https://www.kernel.org/doc/html/next/process/stable-kernel-rules.html#:~:text=It%20or%20an%20equivalent%20fix,%2Fprocess%2Fsubmitting%2Dpatches.

No "This could be a problem..." type of things like a "theoretical race condition",
unless an explanation of how the bug can be exploited is also provided. See

> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
> Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> v5:
>  added unlocked primitives to allow mac ocs modify grouping
>  applied coalescing of mac ocp writes/modifies for 8168ep and 8117
>  some formatting fixes to please checkpatch.pl
> 
> v4:
>  fixed complaints as advised by Heiner and checkpatch.pl
>  split the patch into five sections to be more easily manipulated and reviewed
>  introduced r8168_mac_ocp_write_seq()
>  applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B
> 
> v3:
>  removed register/mask pair array sentinels, so using ARRAY_SIZE().
>  avoided duplication of RTL_W32() call code as advised by Heiner.
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 71 +++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 361b90007148..da1f5d1b4fd5 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -888,7 +888,7 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
>  		(RTL_R32(tp, GPHY_OCP) & 0xffff) : -ETIMEDOUT;
>  }
>  
> -static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
> +static inline void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)

No inline declarations please, let the compiler decide.

>  {
>  	if (rtl_ocp_reg_failure(reg))
>  		return;
> @@ -905,7 +905,7 @@ static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
>  	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>  }
>  
> -static u16 __r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
> +static inline u16 __r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
>  {
>  	if (rtl_ocp_reg_failure(reg))
>  		return 0;
> @@ -927,18 +927,79 @@ static u16 r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
>  	return val;
>  }
>  
> +static inline void __r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
> +					  u16 set)
> +{
> +	u16 data;
> +
> +	data = __r8168_mac_ocp_read(tp, reg);
> +	__r8168_mac_ocp_write(tp, reg, (data & ~mask) | set);
> +}
> +
>  static void r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
>  				 u16 set)
>  {
>  	unsigned long flags;
> -	u16 data;
>  
>  	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
> -	data = __r8168_mac_ocp_read(tp, reg);
> -	__r8168_mac_ocp_write(tp, reg, (data & ~mask) | set);
> +	__r8168_mac_ocp_modify(tp, reg, mask, set);
>  	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>  }
>  
> +struct e_info_regdata {

What does the e prefix stand for? Maybe macocp_info_write and
macocp_info_modify would be better names and more in line with
e.g. struct ephy_info.

> +	u32	reg;
> +	u32	data;
> +};
> +
> +struct e_info_regmaskset {
> +	u32	reg;
> +	u16	mask;
> +	u16	set;
> +};
> +
> +static void __r8168_mac_ocp_write_seqlen(struct rtl8169_private *tp,
> +					 const struct e_info_regdata *array, int len)
> +{
> +	struct e_info_regdata const *p;
> +
> +	for (p = array; len--; p++)
> +		__r8168_mac_ocp_write(tp, p->reg, p->data);
> +}
> +
> +static void r8168_mac_ocp_write_seqlen(struct rtl8169_private *tp,
> +				       const struct e_info_regdata *array, int len)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
> +	__r8168_mac_ocp_write_seqlen(tp, array, len);
> +	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
> +}
> +
> +static void __r8168_mac_ocp_modify_seqlen(struct rtl8169_private *tp,
> +					  const struct e_info_regmaskset *array, int len)
> +{
> +	struct e_info_regmaskset const *p;
> +
> +	for (p = array; len--; p++)
> +		__r8168_mac_ocp_modify(tp, p->reg, p->mask, p->set);
> +}
> +
> +static void r8168_mac_ocp_modify_seqlen(struct rtl8169_private *tp,
> +					const struct e_info_regmaskset *array, int len)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
> +	__r8168_mac_ocp_modify_seqlen(tp, array, len);
> +	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
> +}
> +
> +#define r8168_mac_ocp_write_seq(tp, a) r8168_mac_ocp_write_seqlen(tp, a, ARRAY_SIZE(a))
> +#define r8168_mac_ocp_modify_seq(tp, a) r8168_mac_ocp_modify_seqlen(tp, a, ARRAY_SIZE(a))
> +#define __r8168_mac_ocp_write_seq(tp, a) __r8168_mac_ocp_write_seqlen(tp, a, ARRAY_SIZE(a))
> +#define __r8168_mac_ocp_modify_seq(tp, a) __r8168_mac_ocp_modify_seqlen(tp, a, ARRAY_SIZE(a))
> +
>  /* Work around a hw issue with RTL8168g PHY, the quirk disables
>   * PHY MCU interrupts before PHY power-down.
>   */

