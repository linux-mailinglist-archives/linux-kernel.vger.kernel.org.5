Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C207DA58E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjJ1HuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 03:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1HuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 03:50:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA99F2;
        Sat, 28 Oct 2023 00:50:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9d10972e63eso109201866b.2;
        Sat, 28 Oct 2023 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698479401; x=1699084201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=akqNd6AmajT1oa1GEPHkrX7xwppUn78i5n2EfXwEt7M=;
        b=TfAVp649dH9bQCtC2m3YmF2H4eOqGseeNBAfqdz6CH03wZFImOfDA33KRmOeEXqq3m
         H9bWL1Adtv4BQdQytmtkv+zDo4pDbuPWYcwvH4vQjPrz7BJGuOALHLOXmb8QXb0rmHVQ
         DXtHMyMcRNS3tMOUHoifQy+YSgOqhZsfROrQh3JRV+Uu8LmATImZXf9IWLJN0CDUH7FI
         PhJ5rcB8MzEuujhTJ0Kp5jF0ln3L+rX6B8feWwFP2MmWRI5IAyBb1UM+LuSU5qNPugcP
         lQlgCJCDBDWrsfW5G3qw6dsMnW2BUhBfF4ICy2VHfbPiBOWsb8SmCkb0HQQPVkRuoIW/
         Ca8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698479401; x=1699084201;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akqNd6AmajT1oa1GEPHkrX7xwppUn78i5n2EfXwEt7M=;
        b=IQlxasuVjGtmD41jD9DYKkBjCwj/W9bS9FmG1PMWxyLdfYIFVlQAoyO4ZXz40dFhjl
         xsDmNL5QRTilYlelgGy8yV3d2mPsrGDcYHB2r/81Cr1MlK5ucrFUNyQHhcMvCUbPCvev
         Wb8gAdlkFZjqDeDoVXFvVvzDz3IPvdNw6OiweC3yYsFP16EWeUBPxtdsOlopQcPa7kY7
         efL4ew16OEHdpmLcPjxN/TpPp7aRGNGze3xT/or3cgW6INoiAiYJwDwWpSZgQMQ/8Eyr
         eDKsjpJFtySWkAyYUPik7u63MYi0FKxEeAQaA1PvqkC4aZ6SsSmiVIk6dQhdqUsL9YUF
         Yb6Q==
X-Gm-Message-State: AOJu0YztL2SXu+X2xHGjeD5F4QKFKPWL6HYtgpIFGRsrUnyWswhjr5oc
        45iemjytAtmYtuOfuchsVIU=
X-Google-Smtp-Source: AGHT+IFKMkdyQrdoUcLDImT9qF4W+vlh42t4vy2rq3pElcsLImWpuPNiOPYqtgtFlH5UkTbu9xU+sg==
X-Received: by 2002:a17:907:3f1a:b0:9be:b41d:4f7e with SMTP id hq26-20020a1709073f1a00b009beb41d4f7emr3959418ejc.17.1698479400844;
        Sat, 28 Oct 2023 00:50:00 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c119:9c00:b47c:4f5f:820f:2966? (dynamic-2a01-0c23-c119-9c00-b47c-4f5f-820f-2966.c23.pool.telefonica.de. [2a01:c23:c119:9c00:b47c:4f5f:820f:2966])
        by smtp.googlemail.com with ESMTPSA id b22-20020a170906491600b009b2d46425absm2341731ejq.85.2023.10.28.00.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 00:50:00 -0700 (PDT)
Message-ID: <8d9a15ac-5d95-4267-bbf2-5820d0a71a4e@gmail.com>
Date:   Sat, 28 Oct 2023 09:50:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] r8169: Coalesce RTL8411b PHY power-down
 recovery programming instructions to reduce spinlock stalls (v2)
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.10.2023 02:51, Mirsad Goran Todorovac wrote:
> On RTL8411b the RX unit gets confused if the PHY is powered-down.
> This was reported in [0] and confirmed by Realtek. Realtek provided
> a sequence to fix the RX unit after PHY wakeup.
> 
v1 and 1/1 aren't needed. And that it's v2 you don't have to add
to the patch title.

> A series of about 130 r8168_mac_ocp_write() calls is performed to
> program the RTL registers for recovery.
> 
> Each call looks like this:
> 
>         static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
>         {
>                 if (rtl_ocp_reg_failure(reg))
>                         return;
> 
>                 RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>         }
> 
>         static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
>         {
>                 unsigned long flags;
> 
>                 raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>                 __r8168_mac_ocp_write(tp, reg, data);
>                 raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>         }
> 
> Register programming is done through RTL_W32() macro which expands into
> 
>         #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
> 
> which is further:
> 
>         extern inline void writel(u32 b, volatile void __iomem *addr)
>         {
>                 mb();
>                 __raw_writel(b, addr);
>         }
> 
> mb() expands into this on x86_64:
> 
>         #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
> 
> This means a whole lot of memory bus stalls: for spin_lock_irqsave(),
> memory barrier, writel(), and spin_unlock_irqrestore().
> 
> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
> a lock storm that will stall all of the cores and CPUs on the same memory controller
> for certain time I/O takes to finish.
> 
Do you have a system with this NIC version and/or are you aware of any
actual issue?

> In a sequential case of RTL register programming, the writes to RTL registers
> can be coalesced under a same raw spinlock. This can dramatically decrease the
> number of bus stalls in a multicore or multi-CPU system:
> 
>         static void __r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
>                                               const struct recover_8411b_info *array)
>         {
>                 struct recover_8411b_info const *p = array;
> 
>                 while (p->reg) {
>                         if (!rtl_ocp_reg_failure(p->reg))
>                                 RTL_W32(tp, OCPDR, OCPAR_FLAG | (p->reg << 15) | p->data);
>                         p++;
>                 }
>         }
> 
>         static void r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
>                                             const struct recover_8411b_info *array)
>         {
>                 unsigned long flags;
> 
>                 raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>                 __r8168_mac_ocp_write_seq(tp, array);
>                 raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>         }
> 
>         static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>         {
> 
>                 ...
> 
>                 /* The following Realtek-provided magic fixes an issue with the RX unit
>                  * getting confused after the PHY having been powered-down.
>                  */
> 
>                 static const struct recover_8411b_info init_zero_seq[] = {
>                         { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 }, { 0xFC2E, 0x0000 },
>                         { 0xFC30, 0x0000 }, { 0xFC32, 0x0000 }, { 0xFC34, 0x0000 }, { 0xFC36, 0x0000 },
>                         { 0x0000, 0x0000 },
>                 };
> 
>                 static const struct recover_8411b_info recover_seq[] = {
>                         { 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C }, { 0xF806, 0xE00E },
>                         { 0xF808, 0xE027 }, { 0xF80A, 0xE04F }, { 0xF80C, 0xE05E }, { 0xF80E, 0xE065 },
>                         { 0xF810, 0xC602 }, { 0xF812, 0xBE00 }, { 0xF814, 0x0000 }, { 0xF816, 0xC502 },
>                         { 0xF818, 0xBD00 }, { 0xF81A, 0x074C }, { 0xF81C, 0xC302 }, { 0xF81E, 0xBB00 },
>                         { 0xF820, 0x080A }, { 0xF822, 0x6420 }, { 0xF824, 0x48C2 }, { 0xF826, 0x8C20 },
>                         { 0xF828, 0xC516 }, { 0xF82A, 0x64A4 }, { 0xF82C, 0x49C0 }, { 0xF82E, 0xF009 },
>                         { 0xF830, 0x74A2 }, { 0xF832, 0x8CA5 }, { 0xF834, 0x74A0 }, { 0xF836, 0xC50E },
>                         { 0xF838, 0x9CA2 }, { 0xF83A, 0x1C11 }, { 0xF83C, 0x9CA0 }, { 0xF83E, 0xE006 },
>                         { 0xF840, 0x74F8 }, { 0xF842, 0x48C4 }, { 0xF844, 0x8CF8 }, { 0xF846, 0xC404 },
>                         { 0xF848, 0xBC00 }, { 0xF84A, 0xC403 }, { 0xF84C, 0xBC00 }, { 0xF84E, 0x0BF2 },
>                         { 0xF850, 0x0C0A }, { 0xF852, 0xE434 }, { 0xF854, 0xD3C0 }, { 0xF856, 0x49D9 },
>                         { 0xF858, 0xF01F }, { 0xF85A, 0xC526 }, { 0xF85C, 0x64A5 }, { 0xF85E, 0x1400 },
>                         { 0xF860, 0xF007 }, { 0xF862, 0x0C01 }, { 0xF864, 0x8CA5 }, { 0xF866, 0x1C15 },
>                         { 0xF868, 0xC51B }, { 0xF86A, 0x9CA0 }, { 0xF86C, 0xE013 }, { 0xF86E, 0xC519 },
>                         { 0xF870, 0x74A0 }, { 0xF872, 0x48C4 }, { 0xF874, 0x8CA0 }, { 0xF876, 0xC516 },
>                         { 0xF878, 0x74A4 }, { 0xF87A, 0x48C8 }, { 0xF87C, 0x48CA }, { 0xF87E, 0x9CA4 },
>                         { 0xF880, 0xC512 }, { 0xF882, 0x1B00 }, { 0xF884, 0x9BA0 }, { 0xF886, 0x1B1C },
>                         { 0xF888, 0x483F }, { 0xF88A, 0x9BA2 }, { 0xF88C, 0x1B04 }, { 0xF88E, 0xC508 },
>                         { 0xF890, 0x9BA0 }, { 0xF892, 0xC505 }, { 0xF894, 0xBD00 }, { 0xF896, 0xC502 },
>                         { 0xF898, 0xBD00 }, { 0xF89A, 0x0300 }, { 0xF89C, 0x051E }, { 0xF89E, 0xE434 },
>                         { 0xF8A0, 0xE018 }, { 0xF8A2, 0xE092 }, { 0xF8A4, 0xDE20 }, { 0xF8A6, 0xD3C0 },
>                         { 0xF8A8, 0xC50F }, { 0xF8AA, 0x76A4 }, { 0xF8AC, 0x49E3 }, { 0xF8AE, 0xF007 },
>                         { 0xF8B0, 0x49C0 }, { 0xF8B2, 0xF103 }, { 0xF8B4, 0xC607 }, { 0xF8B6, 0xBE00 },
>                         { 0xF8B8, 0xC606 }, { 0xF8BA, 0xBE00 }, { 0xF8BC, 0xC602 }, { 0xF8BE, 0xBE00 },
>                         { 0xF8C0, 0x0C4C }, { 0xF8C2, 0x0C28 }, { 0xF8C4, 0x0C2C }, { 0xF8C6, 0xDC00 },
>                         { 0xF8C8, 0xC707 }, { 0xF8CA, 0x1D00 }, { 0xF8CC, 0x8DE2 }, { 0xF8CE, 0x48C1 },
>                         { 0xF8D0, 0xC502 }, { 0xF8D2, 0xBD00 }, { 0xF8D4, 0x00AA }, { 0xF8D6, 0xE0C0 },
>                         { 0xF8D8, 0xC502 }, { 0xF8DA, 0xBD00 }, { 0xF8DC, 0x0132 },
>                         { 0x0000, 0x0000 },
>                 };
> 
>                 static const struct recover_8411b_info final_seq[] = {
>                         { 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 }, { 0xFC30, 0x02FD },
>                         { 0xFC32, 0x0C25 }, { 0xFC34, 0x00A9 }, { 0xFC36, 0x012D },
>                         { 0x0000, 0x0000 },
>                 };
> 
>                 r8168_mac_ocp_write_seq(tp, init_zero_seq);
>                 mdelay(3);
>                 r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
>                 r8168_mac_ocp_write_seq(tp, recover_seq);
>                 r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
>                 r8168_mac_ocp_write_seq(tp, final_seq);
>         }
> 
Putting the whole code sequence in the commit description isn't benefitial IMO.

> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
> functions that only changed the function names and the ending of the line, so the actual
> hex data is unchanged.
> 
> Note that the original reason for the introduction of the commit fe4e8db0392a6
> was to enable recovery of the RX unit on the RTL8411b which was confused by the
> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem

You state "amplifies the problem" which means that the original problem
isn't solved. Is this what you want to say and is there evidence?
Or did you mean that the original problem was replaced with a different problem?

> into a series of about 500+ memory bus locks, most waiting for the main memory read,
> modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
> the programming sequence to reach RTL NIC registers.
> 
> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
> 
> Fixes: fe4e8db0392a6 ("r8169: fix issue with confused RX unit after PHY power-down on RTL8411b")
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 200 ++++++++--------------
>  1 file changed, 74 insertions(+), 126 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 361b90007148..c0a1f08f7667 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3085,6 +3085,31 @@ static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
>  	rtl_ephy_init(tp, e_info_8168g_2);
>  }
>  
> +struct recover_8411b_info {
> +	u32	reg;
> +	u32	data;
> +};
> +
> +static void __r8168_mac_ocp_write_seq(struct rtl8169_private *tp, const struct recover_8411b_info *array)
> +{
> +	struct recover_8411b_info const *p = array;
> +
> +	while (p->reg) {
> +		if (!rtl_ocp_reg_failure(p->reg))
> +			RTL_W32(tp, OCPDR, OCPAR_FLAG | (p->reg << 15) | p->data);

Better use __r8168_mac_ocp_write() here. Duplicating the code of
this function adds unnecessary complexity.

> +		p++;
> +	}
> +}
> +
> +static void r8168_mac_ocp_write_seq(struct rtl8169_private *tp, const struct recover_8411b_info *array)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
> +	__r8168_mac_ocp_write_seq(tp, array);
> +	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
> +}
> +

Maybe sooner or later we use this in other places too. So we should:
- put it before any usage of r8168_mac_ocp_write()
- remove references to RTL8411b



>  static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>  {
>  	static const struct ephy_info e_info_8411_2[] = {
> @@ -3107,138 +3132,61 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>  	/* The following Realtek-provided magic fixes an issue with the RX unit
>  	 * getting confused after the PHY having been powered-down.
>  	 */
> -	r8168_mac_ocp_write(tp, 0xFC28, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xFC2A, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xFC2C, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xFC2E, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xFC30, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xFC32, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xFC34, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xFC36, 0x0000);
> +
> +	static const struct recover_8411b_info init_zero_seq[] = {
> +		{ 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 }, { 0xFC2E, 0x0000 },
> +		{ 0xFC30, 0x0000 }, { 0xFC32, 0x0000 }, { 0xFC34, 0x0000 }, { 0xFC36, 0x0000 },
> +		{ 0x0000, 0x0000 },

The sentinel can be simply written as {}

> +	};
> +
> +	static const struct recover_8411b_info recover_seq[] = {
> +		{ 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C }, { 0xF806, 0xE00E },
> +		{ 0xF808, 0xE027 }, { 0xF80A, 0xE04F }, { 0xF80C, 0xE05E }, { 0xF80E, 0xE065 },
> +		{ 0xF810, 0xC602 }, { 0xF812, 0xBE00 }, { 0xF814, 0x0000 }, { 0xF816, 0xC502 },
> +		{ 0xF818, 0xBD00 }, { 0xF81A, 0x074C }, { 0xF81C, 0xC302 }, { 0xF81E, 0xBB00 },
> +		{ 0xF820, 0x080A }, { 0xF822, 0x6420 }, { 0xF824, 0x48C2 }, { 0xF826, 0x8C20 },
> +		{ 0xF828, 0xC516 }, { 0xF82A, 0x64A4 }, { 0xF82C, 0x49C0 }, { 0xF82E, 0xF009 },
> +		{ 0xF830, 0x74A2 }, { 0xF832, 0x8CA5 }, { 0xF834, 0x74A0 }, { 0xF836, 0xC50E },
> +		{ 0xF838, 0x9CA2 }, { 0xF83A, 0x1C11 }, { 0xF83C, 0x9CA0 }, { 0xF83E, 0xE006 },
> +		{ 0xF840, 0x74F8 }, { 0xF842, 0x48C4 }, { 0xF844, 0x8CF8 }, { 0xF846, 0xC404 },
> +		{ 0xF848, 0xBC00 }, { 0xF84A, 0xC403 }, { 0xF84C, 0xBC00 }, { 0xF84E, 0x0BF2 },
> +		{ 0xF850, 0x0C0A }, { 0xF852, 0xE434 }, { 0xF854, 0xD3C0 }, { 0xF856, 0x49D9 },
> +		{ 0xF858, 0xF01F }, { 0xF85A, 0xC526 }, { 0xF85C, 0x64A5 }, { 0xF85E, 0x1400 },
> +		{ 0xF860, 0xF007 }, { 0xF862, 0x0C01 }, { 0xF864, 0x8CA5 }, { 0xF866, 0x1C15 },
> +		{ 0xF868, 0xC51B }, { 0xF86A, 0x9CA0 }, { 0xF86C, 0xE013 }, { 0xF86E, 0xC519 },
> +		{ 0xF870, 0x74A0 }, { 0xF872, 0x48C4 }, { 0xF874, 0x8CA0 }, { 0xF876, 0xC516 },
> +		{ 0xF878, 0x74A4 }, { 0xF87A, 0x48C8 }, { 0xF87C, 0x48CA }, { 0xF87E, 0x9CA4 },
> +		{ 0xF880, 0xC512 }, { 0xF882, 0x1B00 }, { 0xF884, 0x9BA0 }, { 0xF886, 0x1B1C },
> +		{ 0xF888, 0x483F }, { 0xF88A, 0x9BA2 }, { 0xF88C, 0x1B04 }, { 0xF88E, 0xC508 },
> +		{ 0xF890, 0x9BA0 }, { 0xF892, 0xC505 }, { 0xF894, 0xBD00 }, { 0xF896, 0xC502 },
> +		{ 0xF898, 0xBD00 }, { 0xF89A, 0x0300 }, { 0xF89C, 0x051E }, { 0xF89E, 0xE434 },
> +		{ 0xF8A0, 0xE018 }, { 0xF8A2, 0xE092 }, { 0xF8A4, 0xDE20 }, { 0xF8A6, 0xD3C0 },
> +		{ 0xF8A8, 0xC50F }, { 0xF8AA, 0x76A4 }, { 0xF8AC, 0x49E3 }, { 0xF8AE, 0xF007 },
> +		{ 0xF8B0, 0x49C0 }, { 0xF8B2, 0xF103 }, { 0xF8B4, 0xC607 }, { 0xF8B6, 0xBE00 },
> +		{ 0xF8B8, 0xC606 }, { 0xF8BA, 0xBE00 }, { 0xF8BC, 0xC602 }, { 0xF8BE, 0xBE00 },
> +		{ 0xF8C0, 0x0C4C }, { 0xF8C2, 0x0C28 }, { 0xF8C4, 0x0C2C }, { 0xF8C6, 0xDC00 },
> +		{ 0xF8C8, 0xC707 }, { 0xF8CA, 0x1D00 }, { 0xF8CC, 0x8DE2 }, { 0xF8CE, 0x48C1 },
> +		{ 0xF8D0, 0xC502 }, { 0xF8D2, 0xBD00 }, { 0xF8D4, 0x00AA }, { 0xF8D6, 0xE0C0 },
> +		{ 0xF8D8, 0xC502 }, { 0xF8DA, 0xBD00 }, { 0xF8DC, 0x0132 },
> +		{ 0x0000, 0x0000 },
> +	};
> +
> +	static const struct recover_8411b_info final_seq[] = {
> +		{ 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 }, { 0xFC30, 0x02FD },
> +		{ 0xFC32, 0x0C25 }, { 0xFC34, 0x00A9 }, { 0xFC36, 0x012D },
> +		{ 0x0000, 0x0000 },
> +	};
> +
> +	r8168_mac_ocp_write_seq(tp, init_zero_seq);
>  	mdelay(3);
>  	r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
>  
> -	r8168_mac_ocp_write(tp, 0xF800, 0xE008);
> -	r8168_mac_ocp_write(tp, 0xF802, 0xE00A);
> -	r8168_mac_ocp_write(tp, 0xF804, 0xE00C);
> -	r8168_mac_ocp_write(tp, 0xF806, 0xE00E);
> -	r8168_mac_ocp_write(tp, 0xF808, 0xE027);
> -	r8168_mac_ocp_write(tp, 0xF80A, 0xE04F);
> -	r8168_mac_ocp_write(tp, 0xF80C, 0xE05E);
> -	r8168_mac_ocp_write(tp, 0xF80E, 0xE065);
> -	r8168_mac_ocp_write(tp, 0xF810, 0xC602);
> -	r8168_mac_ocp_write(tp, 0xF812, 0xBE00);
> -	r8168_mac_ocp_write(tp, 0xF814, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xF816, 0xC502);
> -	r8168_mac_ocp_write(tp, 0xF818, 0xBD00);
> -	r8168_mac_ocp_write(tp, 0xF81A, 0x074C);
> -	r8168_mac_ocp_write(tp, 0xF81C, 0xC302);
> -	r8168_mac_ocp_write(tp, 0xF81E, 0xBB00);
> -	r8168_mac_ocp_write(tp, 0xF820, 0x080A);
> -	r8168_mac_ocp_write(tp, 0xF822, 0x6420);
> -	r8168_mac_ocp_write(tp, 0xF824, 0x48C2);
> -	r8168_mac_ocp_write(tp, 0xF826, 0x8C20);
> -	r8168_mac_ocp_write(tp, 0xF828, 0xC516);
> -	r8168_mac_ocp_write(tp, 0xF82A, 0x64A4);
> -	r8168_mac_ocp_write(tp, 0xF82C, 0x49C0);
> -	r8168_mac_ocp_write(tp, 0xF82E, 0xF009);
> -	r8168_mac_ocp_write(tp, 0xF830, 0x74A2);
> -	r8168_mac_ocp_write(tp, 0xF832, 0x8CA5);
> -	r8168_mac_ocp_write(tp, 0xF834, 0x74A0);
> -	r8168_mac_ocp_write(tp, 0xF836, 0xC50E);
> -	r8168_mac_ocp_write(tp, 0xF838, 0x9CA2);
> -	r8168_mac_ocp_write(tp, 0xF83A, 0x1C11);
> -	r8168_mac_ocp_write(tp, 0xF83C, 0x9CA0);
> -	r8168_mac_ocp_write(tp, 0xF83E, 0xE006);
> -	r8168_mac_ocp_write(tp, 0xF840, 0x74F8);
> -	r8168_mac_ocp_write(tp, 0xF842, 0x48C4);
> -	r8168_mac_ocp_write(tp, 0xF844, 0x8CF8);
> -	r8168_mac_ocp_write(tp, 0xF846, 0xC404);
> -	r8168_mac_ocp_write(tp, 0xF848, 0xBC00);
> -	r8168_mac_ocp_write(tp, 0xF84A, 0xC403);
> -	r8168_mac_ocp_write(tp, 0xF84C, 0xBC00);
> -	r8168_mac_ocp_write(tp, 0xF84E, 0x0BF2);
> -	r8168_mac_ocp_write(tp, 0xF850, 0x0C0A);
> -	r8168_mac_ocp_write(tp, 0xF852, 0xE434);
> -	r8168_mac_ocp_write(tp, 0xF854, 0xD3C0);
> -	r8168_mac_ocp_write(tp, 0xF856, 0x49D9);
> -	r8168_mac_ocp_write(tp, 0xF858, 0xF01F);
> -	r8168_mac_ocp_write(tp, 0xF85A, 0xC526);
> -	r8168_mac_ocp_write(tp, 0xF85C, 0x64A5);
> -	r8168_mac_ocp_write(tp, 0xF85E, 0x1400);
> -	r8168_mac_ocp_write(tp, 0xF860, 0xF007);
> -	r8168_mac_ocp_write(tp, 0xF862, 0x0C01);
> -	r8168_mac_ocp_write(tp, 0xF864, 0x8CA5);
> -	r8168_mac_ocp_write(tp, 0xF866, 0x1C15);
> -	r8168_mac_ocp_write(tp, 0xF868, 0xC51B);
> -	r8168_mac_ocp_write(tp, 0xF86A, 0x9CA0);
> -	r8168_mac_ocp_write(tp, 0xF86C, 0xE013);
> -	r8168_mac_ocp_write(tp, 0xF86E, 0xC519);
> -	r8168_mac_ocp_write(tp, 0xF870, 0x74A0);
> -	r8168_mac_ocp_write(tp, 0xF872, 0x48C4);
> -	r8168_mac_ocp_write(tp, 0xF874, 0x8CA0);
> -	r8168_mac_ocp_write(tp, 0xF876, 0xC516);
> -	r8168_mac_ocp_write(tp, 0xF878, 0x74A4);
> -	r8168_mac_ocp_write(tp, 0xF87A, 0x48C8);
> -	r8168_mac_ocp_write(tp, 0xF87C, 0x48CA);
> -	r8168_mac_ocp_write(tp, 0xF87E, 0x9CA4);
> -	r8168_mac_ocp_write(tp, 0xF880, 0xC512);
> -	r8168_mac_ocp_write(tp, 0xF882, 0x1B00);
> -	r8168_mac_ocp_write(tp, 0xF884, 0x9BA0);
> -	r8168_mac_ocp_write(tp, 0xF886, 0x1B1C);
> -	r8168_mac_ocp_write(tp, 0xF888, 0x483F);
> -	r8168_mac_ocp_write(tp, 0xF88A, 0x9BA2);
> -	r8168_mac_ocp_write(tp, 0xF88C, 0x1B04);
> -	r8168_mac_ocp_write(tp, 0xF88E, 0xC508);
> -	r8168_mac_ocp_write(tp, 0xF890, 0x9BA0);
> -	r8168_mac_ocp_write(tp, 0xF892, 0xC505);
> -	r8168_mac_ocp_write(tp, 0xF894, 0xBD00);
> -	r8168_mac_ocp_write(tp, 0xF896, 0xC502);
> -	r8168_mac_ocp_write(tp, 0xF898, 0xBD00);
> -	r8168_mac_ocp_write(tp, 0xF89A, 0x0300);
> -	r8168_mac_ocp_write(tp, 0xF89C, 0x051E);
> -	r8168_mac_ocp_write(tp, 0xF89E, 0xE434);
> -	r8168_mac_ocp_write(tp, 0xF8A0, 0xE018);
> -	r8168_mac_ocp_write(tp, 0xF8A2, 0xE092);
> -	r8168_mac_ocp_write(tp, 0xF8A4, 0xDE20);
> -	r8168_mac_ocp_write(tp, 0xF8A6, 0xD3C0);
> -	r8168_mac_ocp_write(tp, 0xF8A8, 0xC50F);
> -	r8168_mac_ocp_write(tp, 0xF8AA, 0x76A4);
> -	r8168_mac_ocp_write(tp, 0xF8AC, 0x49E3);
> -	r8168_mac_ocp_write(tp, 0xF8AE, 0xF007);
> -	r8168_mac_ocp_write(tp, 0xF8B0, 0x49C0);
> -	r8168_mac_ocp_write(tp, 0xF8B2, 0xF103);
> -	r8168_mac_ocp_write(tp, 0xF8B4, 0xC607);
> -	r8168_mac_ocp_write(tp, 0xF8B6, 0xBE00);
> -	r8168_mac_ocp_write(tp, 0xF8B8, 0xC606);
> -	r8168_mac_ocp_write(tp, 0xF8BA, 0xBE00);
> -	r8168_mac_ocp_write(tp, 0xF8BC, 0xC602);
> -	r8168_mac_ocp_write(tp, 0xF8BE, 0xBE00);
> -	r8168_mac_ocp_write(tp, 0xF8C0, 0x0C4C);
> -	r8168_mac_ocp_write(tp, 0xF8C2, 0x0C28);
> -	r8168_mac_ocp_write(tp, 0xF8C4, 0x0C2C);
> -	r8168_mac_ocp_write(tp, 0xF8C6, 0xDC00);
> -	r8168_mac_ocp_write(tp, 0xF8C8, 0xC707);
> -	r8168_mac_ocp_write(tp, 0xF8CA, 0x1D00);
> -	r8168_mac_ocp_write(tp, 0xF8CC, 0x8DE2);
> -	r8168_mac_ocp_write(tp, 0xF8CE, 0x48C1);
> -	r8168_mac_ocp_write(tp, 0xF8D0, 0xC502);
> -	r8168_mac_ocp_write(tp, 0xF8D2, 0xBD00);
> -	r8168_mac_ocp_write(tp, 0xF8D4, 0x00AA);
> -	r8168_mac_ocp_write(tp, 0xF8D6, 0xE0C0);
> -	r8168_mac_ocp_write(tp, 0xF8D8, 0xC502);
> -	r8168_mac_ocp_write(tp, 0xF8DA, 0xBD00);
> -	r8168_mac_ocp_write(tp, 0xF8DC, 0x0132);
> +	r8168_mac_ocp_write_seq(tp, recover_seq);
>  
>  	r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
>  
> -	r8168_mac_ocp_write(tp, 0xFC2A, 0x0743);
> -	r8168_mac_ocp_write(tp, 0xFC2C, 0x0801);
> -	r8168_mac_ocp_write(tp, 0xFC2E, 0x0BE9);
> -	r8168_mac_ocp_write(tp, 0xFC30, 0x02FD);
> -	r8168_mac_ocp_write(tp, 0xFC32, 0x0C25);
> -	r8168_mac_ocp_write(tp, 0xFC34, 0x00A9);
> -	r8168_mac_ocp_write(tp, 0xFC36, 0x012D);
> +	r8168_mac_ocp_write_seq(tp, final_seq);
> +
>  }
>  
>  static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)

