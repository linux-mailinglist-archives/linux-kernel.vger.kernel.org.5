Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339317D2615
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 23:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjJVVXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 17:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVVXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 17:23:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E0CDD;
        Sun, 22 Oct 2023 14:23:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so385686766b.1;
        Sun, 22 Oct 2023 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698009822; x=1698614622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WkF44mhsA4XbeSLoWQLWk/5m+WP2zhKnLhk+YERJL8E=;
        b=jDPMNDD5ZNGFB2kptAO53QH85TaBmTggPUSWAlW8v65n0TRcLkpGwycCJYkdEWCTx3
         6MZvqJdJs+NEmX0lKexwofD4QFh3gMj4yEbEHQnu/pU7DUEF3VOrpc2ejJuBPsxmRcst
         DlFl4Vj4u3zAPX2LuFcd7/3f0xP6Vhbr/mrcaB7wPt/nZ7ly1ovh+jfOprVKn7a5LJcA
         KwFOLYZYDSOt5B8ZbOYS//6O+Ddvukkfgaecj3pJkMv14tsQ4px12g6/4l6yeJ8f/+Dx
         IGTY4DAkhbCGiSCZ8qqECC0XEX7BwHRQIuv3fkcXvT8UnU9+pGB5kZbDpVnXSw4rZIe9
         Jfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698009822; x=1698614622;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkF44mhsA4XbeSLoWQLWk/5m+WP2zhKnLhk+YERJL8E=;
        b=v+D4L+tIfUmJK8BgsDEhc8oy5jNqTwnR0/yk32Ni/NXh7mHV2zOqCtSMGc5jTPiDvx
         LcF13ymwnhsNrrJEOArdOylW8fOvnI9h/Vc3JM3KAg5c6qTsmg7uEpX4UGs13fJRID9g
         3OnuCqDpn1ww7y/2qG9UuXzkgGVg6oZhM5rBKHcRWZjspO2eHwqW28KsYuuIRfY/6zwk
         7JewounUJmNR2rKkUZUbTK5Y1GVxDXZcx4/22vBwilap+o46nCd9GzFXiJM7iJ0Jveyy
         oVXSLuKb9K1kfkLOpYKNlL4bfJ+dg1Aeo2EMpRP8gZvLfji3gaLM22B+yWeAAh2BLKTa
         q6+g==
X-Gm-Message-State: AOJu0Yw+tqL1bBGRcA3FvjfLPjlV6JRUQRARdILeZkfTuf4o9/OBR+xp
        VNxQVR0BAhTfpVJLHOmVROc=
X-Google-Smtp-Source: AGHT+IEmGUjAGIFruSz2QRFq/5vBPI7Fe1lFKJTvQW8KTw5+G7m2imRoWGJ9ECRyyVuIlV3ZGWoH0g==
X-Received: by 2002:a17:907:a089:b0:9b2:a7db:9662 with SMTP id hu9-20020a170907a08900b009b2a7db9662mr6396146ejc.12.1698009822143;
        Sun, 22 Oct 2023 14:23:42 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc04:7800:102:7f50:233:f136? (dynamic-2a01-0c23-bc04-7800-0102-7f50-0233-f136.c23.pool.telefonica.de. [2a01:c23:bc04:7800:102:7f50:233:f136])
        by smtp.googlemail.com with ESMTPSA id g17-20020a17090613d100b009a1a653770bsm5512582ejc.87.2023.10.22.14.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 14:23:41 -0700 (PDT)
Message-ID: <cf476467-fee1-4c96-ab63-2bbf183faaba@gmail.com>
Date:   Sun, 22 Oct 2023 23:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/3] r8169: fix the KCSAN reported data-race in
 rtl_tx() while reading tp->cur_tx
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20230927184158.243575-1-mirsad.todorovac@alu.unizg.hr>
 <0a201a6f-90dd-403c-97d0-94372be1e3e6@gmail.com>
 <42e14bf6-73a0-400a-966a-09a86ecbeff0@alu.unizg.hr>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <42e14bf6-73a0-400a-966a-09a86ecbeff0@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2023 19:24, Mirsad Todorovac wrote:
> On 9/27/23 21:52, Heiner Kallweit wrote:
>> On 27.09.2023 20:41, Mirsad Goran Todorovac wrote:
>>> KCSAN reported the following data-race:
>>>
>>> ==================================================================
>>> BUG: KCSAN: data-race in rtl8169_poll [r8169] / rtl8169_start_xmit [r8169]
>>>
>>> write (marked) to 0xffff888102474b74 of 4 bytes by task 5358 on cpu 29:
>>> rtl8169_start_xmit (drivers/net/ethernet/realtek/r8169_main.c:4254) r8169
>>> dev_hard_start_xmit (./include/linux/netdevice.h:4889 ./include/linux/netdevice.h:4903 net/core/dev.c:3544 net/core/dev.c:3560)
>>> sch_direct_xmit (net/sched/sch_generic.c:342)
>>> __dev_queue_xmit (net/core/dev.c:3817 net/core/dev.c:4306)
>>> ip_finish_output2 (./include/linux/netdevice.h:3082 ./include/net/neighbour.h:526 ./include/net/neighbour.h:540 net/ipv4/ip_output.c:233)
>>> __ip_finish_output (net/ipv4/ip_output.c:311 net/ipv4/ip_output.c:293)
>>> ip_finish_output (net/ipv4/ip_output.c:328)
>>> ip_output (net/ipv4/ip_output.c:435)
>>> ip_send_skb (./include/net/dst.h:458 net/ipv4/ip_output.c:127 net/ipv4/ip_output.c:1486)
>>> udp_send_skb (net/ipv4/udp.c:963)
>>> udp_sendmsg (net/ipv4/udp.c:1246)
>>> inet_sendmsg (net/ipv4/af_inet.c:840 (discriminator 4))
>>> sock_sendmsg (net/socket.c:730 net/socket.c:753)
>>> __sys_sendto (net/socket.c:2177)
>>> __x64_sys_sendto (net/socket.c:2185)
>>> do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>>> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
>>>
>>> read to 0xffff888102474b74 of 4 bytes by interrupt on cpu 21:
>>> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4397 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
>>> __napi_poll (net/core/dev.c:6527)
>>> net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
>>> __do_softirq (kernel/softirq.c:553)
>>> __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
>>> irq_exit_rcu (kernel/softirq.c:647)
>>> common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
>>> asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
>>> cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
>>> cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
>>> call_cpuidle (kernel/sched/idle.c:135)
>>> do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
>>> cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
>>> start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
>>> secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
>>>
>>> value changed: 0x002f4815 -> 0x002f4816
>>>
>>> Reported by Kernel Concurrency Sanitizer on:
>>> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
>>> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>>> ==================================================================
>>>
>>> The write side of drivers/net/ethernet/realtek/r8169_main.c is:
>>> ==================
>>>     4251         /* rtl_tx needs to see descriptor changes before updated tp->cur_tx */
>>>     4252         smp_wmb();
>>>     4253
>>>   → 4254         WRITE_ONCE(tp->cur_tx, tp->cur_tx + frags + 1);
>>>     4255
>>>     4256         stop_queue = !netif_subqueue_maybe_stop(dev, 0, rtl_tx_slots_avail(tp),
>>>     4257                                                 R8169_TX_STOP_THRS,
>>>     4258                                                 R8169_TX_START_THRS);
>>>
>>> The read side is the function rtl_tx():
>>>
>>>     4355 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>>>     4356                    int budget)
>>>     4357 {
>>>     4358         unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
>>>     4359         struct sk_buff *skb;
>>>     4360
>>>     4361         dirty_tx = tp->dirty_tx;
>>>     4362
>>>     4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
>>>     4364                 unsigned int entry = dirty_tx % NUM_TX_DESC;
>>>     4365                 u32 status;
>>>     4366
>>>     4367                 status = le32_to_cpu(tp->TxDescArray[entry].opts1);
>>>     4368                 if (status & DescOwn)
>>>     4369                         break;
>>>     4370
>>>     4371                 skb = tp->tx_skb[entry].skb;
>>>     4372                 rtl8169_unmap_tx_skb(tp, entry);
>>>     4373
>>>     4374                 if (skb) {
>>>     4375                         pkts_compl++;
>>>     4376                         bytes_compl += skb->len;
>>>     4377                         napi_consume_skb(skb, budget);
>>>     4378                 }
>>>     4379                 dirty_tx++;
>>>     4380         }
>>>     4381
>>>     4382         if (tp->dirty_tx != dirty_tx) {
>>>     4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
>>>     4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
>>>     4385
>>>     4386                 netif_subqueue_completed_wake(dev, 0, pkts_compl, bytes_compl,
>>>     4387                                               rtl_tx_slots_avail(tp),
>>>     4388                                               R8169_TX_START_THRS);
>>>     4389                 /*
>>>     4390                  * 8168 hack: TxPoll requests are lost when the Tx packets are
>>>     4391                  * too close. Let's kick an extra TxPoll request when a burst
>>>     4392                  * of start_xmit activity is detected (if it is not detected,
>>>     4393                  * it is slow enough). -- FR
>>>     4394                  * If skb is NULL then we come here again once a tx irq is
>>>     4395                  * triggered after the last fragment is marked transmitted.
>>>     4396                  */
>>>   → 4397                 if (tp->cur_tx != dirty_tx && skb)
>>>     4398                         rtl8169_doorbell(tp);
>>>     4399         }
>>>     4400 }
>>>
>>> Obviously from the code, an earlier detected data-race for tp->cur_tx was fixed in the
>>> line 4363:
>>>
>>>     4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
>>>
>>> but the same solution is required for protecting the other access to tp->cur_tx:
>>>
>>>   → 4397                 if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
>>>     4398                         rtl8169_doorbell(tp);
>>>
>>> The write in the line 4254 is protected with WRITE_ONCE(), but the read in the line 4397
>>> might have suffered read tearing under some compiler optimisations.
>>>
>>> The fix eliminated the KCSAN data-race report for this bug.
>>>
>>> It is yet to be evaluated what happens if tp->cur_tx changes between the test in line 4363
>>> and line 4397. This test should certainly not be cached by the compiler in some register
>>> for such a long time, while asynchronous writes to tp->cur_tx might have occurred in line
>>> 4254 in the meantime.
> 
>> netif_subqueue_completed_wake() has barriers ensuring that no cached value for tp->cur_tx
>> is used in line 4397. I'm not aware of any reported issues with an obvious link to the
>> potentential issue you describe.
>> I don't have a strong opinion on these patches. They shouldn't hurt, and if they make
>> KCSAN happy, why not.
> 
> Hi, Mr. Kallweit,
> 
> Your words have been taken with great weight and serious concern on my behalf, so I took
> some time to investigate (even after the patches were Ack-ed).
> 
No need to be so formal. I'm just a hobbyist developer who once suddenly
found himself in a maintainer position ;)

> The question is whether we deal with a data-race or a false positive reported by KCSAN.
> 
> I can indeed independently confirm that netif_subqueue_completed_wake() eventually expands to
> call to:
> 
> include/net/netdev_queues.h:
> ==============================================
> /* Variant of netdev_tx_completed_queue() which guarantees smp_mb() if
>  * @bytes != 0, regardless of kernel config.
>  */
> static inline void
> netdev_txq_completed_mb(struct netdev_queue *dev_queue,
>             unsigned int pkts, unsigned int bytes)
> {
>     if (IS_ENABLED(CONFIG_BQL))
>         netdev_tx_completed_queue(dev_queue, pkts, bytes);
>     else if (bytes)
>         smp_mb();
> }
> 
> Obviously, smp_mb() is here.
> 
> On my __x86_64__ it expands to an ugly hack:
> 
>         #define smp_mb()  asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")
> 
> Thus far I concur with your findings.
> 
> But I see also Mr. Elver's point:
> 
> 1. With the reference to: [1] https://www.kernel.org/doc/html/v6.2/core-api/wrappers/memory-barriers.html
> compiler can do some "smart" optimisations that only work on single core, single threaded use.
> 
> What comes to mind is that "struct rtl8169_private" and its members might not be on the same cache line
> with the pointer struct rtl8169_private *tp.
> 
> By the exposed matter in [1], READ_ONCE() provides a way to explain to the compiler that tp->cur_tx can
> be concurrently modified by the other thread/core.
> 
> To be honest, I haven't caught a network card error or a driver bug either, but only the KCSAN complaint.
> 
> It would seem prudent to protect all the variables with the concurrent accesses from several cores/threads
> or devices through DMA with (READ|WRITE)_ONCE.
> 
r8169 driver supports one queue only. NAPI softirq guarantees that calls to rtl8169_poll
are serialized. Threaded NAPI may be a different story, however I'm not aware of any bug
report related to threaded NAPI.

> Especially since I don't see where the callback added in drivers/net/ethernet/realtek/r8169_main.c:5277
> is called from:
> 
>          netif_napi_add(dev, &tp->napi, rtl8169_poll);
> 
> I am not trying to be an arbiter nor an authority on the rtl8169 driver, which would obviously be you.
> 
> However, I feel compelled by something to review all the accesses to tp->cur_tx, tp->cur_tx and other
> structure members against concurrent access, and systematically. With your permission, of course.
> 
> I would appreciate your mentoring on the task if you are interested.
> 
> Mainly, I figured out that in:
> 
> 4575 static int rtl8169_poll(struct napi_struct *napi, int budget)
> 4576 {
> 4577         struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
> 4578         struct net_device *dev = tp->dev;
> 4579         int work_done;
> 4580
> 4581         rtl_tx(dev, tp, budget);
> 4582
> 4583         work_done = rtl_rx(dev, tp, budget);
> 4584
> 4585         if (work_done < budget && napi_complete_done(napi, work_done))
> 4586                 rtl_irq_enable(tp);
> 4587
> 4588         return work_done;
> 4589 }
> 
> rtl_tx() and rtl_rx() are called in sequence. Is it possible to imagine doing it in parallel?
> 
Adding a separated TX NAPI is possible, question is whether it's worth the
effort. Look for users of netif_napi_add_tx() to get an idea of separated TX NAPI.
I once experimented with it in context of r8169 and didn't really find a benefit.

> Can the Realtek NIC hardware support that at all and which generations can?
> 
Well, major issue with Realtek HW is that there's no public datasheets.
Only source of information is their out-of-tree drivers (r8168, r8101, r8125).

With regard to RSS: r8125 supports it, r8168 not.

> (Of course, Ethernet might be full-duplex, but PCI Express line might not be.)
> 
> [2] https://www.rambus.com/blogs/pci-express-4/ Full-duplex PCI 4.0 specs.
> 
> Thank you.
> 
> Best regards,
> Mirsad Todorovac
> 
>>> Fixes: 94d8a98e6235c ("r8169: reduce number of workaround doorbell rings")
>>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>>> Cc: nic_swsd@realtek.com
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Marco Elver <elver@google.com>
>>> Cc: netdev@vger.kernel.org
>>> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
>>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>>> ---
>>> v1:
>>>   the initial patch proposal. fixes the KCSAN warning.
>>>
>>>   drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 6351a2dc13bc..281aaa851847 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -4394,7 +4394,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>>>            * If skb is NULL then we come here again once a tx irq is
>>>            * triggered after the last fragment is marked transmitted.
>>>            */
>>> -        if (tp->cur_tx != dirty_tx && skb)
>>> +        if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
>>>               rtl8169_doorbell(tp);
>>>       }
>>>   }

