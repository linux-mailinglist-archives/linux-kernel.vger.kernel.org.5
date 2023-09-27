Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90687B0CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjI0Tw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Tw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:52:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480B210E;
        Wed, 27 Sep 2023 12:52:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5346b64f17aso5412001a12.2;
        Wed, 27 Sep 2023 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844373; x=1696449173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wc+6Pva8m1P19DBJr4BoHsvyFNMutn40KqNReBw90uY=;
        b=nek/WvazEpw1GyDBP5bKLsuHqwpD48Xs+fxx/jhDOhbWNkTQ1dhCpLaGflPd74Sy3y
         kOCJm0p3KXGpGhu7uWyU6NCRG4XId8DkZr+qkE3WO7Ans5Q1PiqzLErk0/pkWV/2Kh3l
         GbK9/XP2Rc854WxYwGhYY9sJDX/Nu049CTFjlHbu0tkFUCXwdT4Tbui4tXmdosGbhYbe
         dB217524EAXgSjJdR+wmb9nXq+isc0lck+AxQX96vm2Imzt+U1EBZSImIOuw+akgqpqp
         DyjyOrqZimCVYQrYKdlswQ5pnKf08u3p4d24T0ErWajyp4hXW65UvOBQRaErGT7EUAU3
         T2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844373; x=1696449173;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc+6Pva8m1P19DBJr4BoHsvyFNMutn40KqNReBw90uY=;
        b=m2qmx1m1++EESdqHO+V6oqsucxSDqZT96Vz7+ENVl4vVK0nnQhTuH6B/1Mgt6vwDFu
         hw6u/zI0S2Mc5MoXqD7LuAXKp8yc8OSj6x6REmUwkmgTjw7hdVPImeSOWqyVAy1/lblD
         pspXb/TlwR3EfbE/VzuKYzyjhloWQRt2wGUSWSr88ajhvAOS6grtyaHGaKlYtVlNfI1h
         8X78x6+CMbBMpOl8zlmuj0IzwW9m0XawprIIgYav42EYaI05DL+GUA96m3+7eFJNHTiA
         ZZMkxZbabwfDMEPF7Si3ogiqjnZm0TwataGLKpDSs8GGAsC0Ep3KlzbsCWVv22bbwQE7
         izBA==
X-Gm-Message-State: AOJu0YxtTWCRIj5KRG1mGP94Y91QWEco/Ss/Zt4KN36ROb9qPUv749ON
        thTef8SdqdujVyVdv/ayzh1dC2Q26Kk=
X-Google-Smtp-Source: AGHT+IE8GTMA2qfbByPBiiN7Sg1VCmhjpd0j9f7j7gext3s/1reBOxYq7fELs9WRDvn09kcJ7CAMRA==
X-Received: by 2002:aa7:c392:0:b0:525:7f37:e87a with SMTP id k18-20020aa7c392000000b005257f37e87amr3009449edq.16.1695844372442;
        Wed, 27 Sep 2023 12:52:52 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc05:7f00:a965:a668:57e6:eb52? (dynamic-2a01-0c23-bc05-7f00-a965-a668-57e6-eb52.c23.pool.telefonica.de. [2a01:c23:bc05:7f00:a965:a668:57e6:eb52])
        by smtp.googlemail.com with ESMTPSA id w10-20020aa7dcca000000b005309eb7544fsm8644683edu.45.2023.09.27.12.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 12:52:51 -0700 (PDT)
Message-ID: <0a201a6f-90dd-403c-97d0-94372be1e3e6@gmail.com>
Date:   Wed, 27 Sep 2023 21:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/3] r8169: fix the KCSAN reported data-race in
 rtl_tx() while reading tp->cur_tx
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20230927184158.243575-1-mirsad.todorovac@alu.unizg.hr>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20230927184158.243575-1-mirsad.todorovac@alu.unizg.hr>
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

On 27.09.2023 20:41, Mirsad Goran Todorovac wrote:
> KCSAN reported the following data-race:
> 
> ==================================================================
> BUG: KCSAN: data-race in rtl8169_poll [r8169] / rtl8169_start_xmit [r8169]
> 
> write (marked) to 0xffff888102474b74 of 4 bytes by task 5358 on cpu 29:
> rtl8169_start_xmit (drivers/net/ethernet/realtek/r8169_main.c:4254) r8169
> dev_hard_start_xmit (./include/linux/netdevice.h:4889 ./include/linux/netdevice.h:4903 net/core/dev.c:3544 net/core/dev.c:3560)
> sch_direct_xmit (net/sched/sch_generic.c:342)
> __dev_queue_xmit (net/core/dev.c:3817 net/core/dev.c:4306)
> ip_finish_output2 (./include/linux/netdevice.h:3082 ./include/net/neighbour.h:526 ./include/net/neighbour.h:540 net/ipv4/ip_output.c:233)
> __ip_finish_output (net/ipv4/ip_output.c:311 net/ipv4/ip_output.c:293)
> ip_finish_output (net/ipv4/ip_output.c:328)
> ip_output (net/ipv4/ip_output.c:435)
> ip_send_skb (./include/net/dst.h:458 net/ipv4/ip_output.c:127 net/ipv4/ip_output.c:1486)
> udp_send_skb (net/ipv4/udp.c:963)
> udp_sendmsg (net/ipv4/udp.c:1246)
> inet_sendmsg (net/ipv4/af_inet.c:840 (discriminator 4))
> sock_sendmsg (net/socket.c:730 net/socket.c:753)
> __sys_sendto (net/socket.c:2177)
> __x64_sys_sendto (net/socket.c:2185)
> do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> 
> read to 0xffff888102474b74 of 4 bytes by interrupt on cpu 21:
> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4397 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
> __napi_poll (net/core/dev.c:6527)
> net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
> __do_softirq (kernel/softirq.c:553)
> __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
> irq_exit_rcu (kernel/softirq.c:647)
> common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
> asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
> cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
> cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
> call_cpuidle (kernel/sched/idle.c:135)
> do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
> cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
> start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
> secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
> 
> value changed: 0x002f4815 -> 0x002f4816
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> ==================================================================
> 
> The write side of drivers/net/ethernet/realtek/r8169_main.c is:
> ==================
>    4251         /* rtl_tx needs to see descriptor changes before updated tp->cur_tx */
>    4252         smp_wmb();
>    4253
>  → 4254         WRITE_ONCE(tp->cur_tx, tp->cur_tx + frags + 1);
>    4255
>    4256         stop_queue = !netif_subqueue_maybe_stop(dev, 0, rtl_tx_slots_avail(tp),
>    4257                                                 R8169_TX_STOP_THRS,
>    4258                                                 R8169_TX_START_THRS);
> 
> The read side is the function rtl_tx():
> 
>    4355 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>    4356                    int budget)
>    4357 {
>    4358         unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
>    4359         struct sk_buff *skb;
>    4360
>    4361         dirty_tx = tp->dirty_tx;
>    4362
>    4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
>    4364                 unsigned int entry = dirty_tx % NUM_TX_DESC;
>    4365                 u32 status;
>    4366
>    4367                 status = le32_to_cpu(tp->TxDescArray[entry].opts1);
>    4368                 if (status & DescOwn)
>    4369                         break;
>    4370
>    4371                 skb = tp->tx_skb[entry].skb;
>    4372                 rtl8169_unmap_tx_skb(tp, entry);
>    4373
>    4374                 if (skb) {
>    4375                         pkts_compl++;
>    4376                         bytes_compl += skb->len;
>    4377                         napi_consume_skb(skb, budget);
>    4378                 }
>    4379                 dirty_tx++;
>    4380         }
>    4381
>    4382         if (tp->dirty_tx != dirty_tx) {
>    4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
>    4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
>    4385
>    4386                 netif_subqueue_completed_wake(dev, 0, pkts_compl, bytes_compl,
>    4387                                               rtl_tx_slots_avail(tp),
>    4388                                               R8169_TX_START_THRS);
>    4389                 /*
>    4390                  * 8168 hack: TxPoll requests are lost when the Tx packets are
>    4391                  * too close. Let's kick an extra TxPoll request when a burst
>    4392                  * of start_xmit activity is detected (if it is not detected,
>    4393                  * it is slow enough). -- FR
>    4394                  * If skb is NULL then we come here again once a tx irq is
>    4395                  * triggered after the last fragment is marked transmitted.
>    4396                  */
>  → 4397                 if (tp->cur_tx != dirty_tx && skb)
>    4398                         rtl8169_doorbell(tp);
>    4399         }
>    4400 }
> 
> Obviously from the code, an earlier detected data-race for tp->cur_tx was fixed in the
> line 4363:
> 
>    4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
> 
> but the same solution is required for protecting the other access to tp->cur_tx:
> 
>  → 4397                 if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
>    4398                         rtl8169_doorbell(tp);
> 
> The write in the line 4254 is protected with WRITE_ONCE(), but the read in the line 4397
> might have suffered read tearing under some compiler optimisations.
> 
> The fix eliminated the KCSAN data-race report for this bug.
> 
> It is yet to be evaluated what happens if tp->cur_tx changes between the test in line 4363
> and line 4397. This test should certainly not be cached by the compiler in some register
> for such a long time, while asynchronous writes to tp->cur_tx might have occurred in line
> 4254 in the meantime.
> 

netif_subqueue_completed_wake() has barriers ensuring that no cached value for tp->cur_tx
is used in line 4397. I'm not aware of any reported issues with an obvious link to the
potentential issue you describe.
I don't have a strong opinion on these patches. They shouldn't hurt, and if they make
KCSAN happy, why not.

> Fixes: 94d8a98e6235c ("r8169: reduce number of workaround doorbell rings")
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Marco Elver <elver@google.com>
> Cc: netdev@vger.kernel.org
> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> v1:
>  the initial patch proposal. fixes the KCSAN warning.
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 6351a2dc13bc..281aaa851847 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4394,7 +4394,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>  		 * If skb is NULL then we come here again once a tx irq is
>  		 * triggered after the last fragment is marked transmitted.
>  		 */
> -		if (tp->cur_tx != dirty_tx && skb)
> +		if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
>  			rtl8169_doorbell(tp);
>  	}
>  }

