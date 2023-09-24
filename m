Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF27ACBB9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjIXTvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjIXTvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:51:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6698192
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:51:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4051d33af1fso16244285e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695585072; x=1696189872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUJX0MEQvJ9Hzjkm/aaLCTeCHcG6yXlD+39vf+OkQMg=;
        b=XZTWUGKXo/3zfSO1mzx8QHpAj64crEC2cnHemIhTehSSeh9up+h4lvYv7XODG3KonK
         mmLeLowos9C6oNDyWy4ztzaxECH5j+c90UlKtSi8zC9bGybqp6307xl7BAjbnu1/gKUh
         ua/HkWp3RXbM5SA5cfgqCI5JVxgBaHGWwQy833CMBOV7kEd1Ejny/iJ/ABbZmZAcNB50
         eY9PeekiGhS/9Hz8T4i5GreJlP7le2neJZx6Da4FwyuGBq9HorZzzqC5wFNj0M0GYOqI
         M9UslhsRtrp9+1KYyBLudr0Np/UvtQtfIAPE6mL1bN9OOtEeWQL8eGo/4FdFT8Lasc+j
         DDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695585072; x=1696189872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUJX0MEQvJ9Hzjkm/aaLCTeCHcG6yXlD+39vf+OkQMg=;
        b=B5fXPtdMNtM+II6cz3zuHT6HIYno/h/7UhRDMCC3jqvd9w9eTRIcUE2+D4+8GVeo0L
         FIDXtm+zeYjNzZ04w0aX01iix5YkbVfFyoYMqv0LKEKMDvSmjMKrTRkqI59Dkk7DLXqd
         YtMYkwuUbrFauDtnZ6OZqRIoFwRskn4XVlN04jECh5+LSGOtA/C3eYIbUeZ9ZbM9Qxm/
         HiNk5HuxeWnJySYWQgUtegMeBggQkb//plVKX76+reHo3IJqNeCBTxOdzEni+N54rgfA
         SH8vmRLXRYVnWYVM3Ys3sHXbEYDX93tk2ZgPHgpSaq1qw4HE7UyXINAQ2dEXUCmIf5CA
         ZPZQ==
X-Gm-Message-State: AOJu0Yx/afgeImiRig48oJsWkNHRH2WLK2O4x/o5Vlr/v35hKdqA8gHe
        7wJJ88ifqsl8dccY1aoqhNg=
X-Google-Smtp-Source: AGHT+IFZXcJOWEv+NQQLucVmAtV1sYd3SNhlPW1VeiZTP67QvFa7U2ebZUmDVZYSOoR4hd9japr05w==
X-Received: by 2002:a05:600c:4a12:b0:404:75cc:62e6 with SMTP id c18-20020a05600c4a1200b0040475cc62e6mr4036096wmp.3.1695585071781;
        Sun, 24 Sep 2023 12:51:11 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c308a00b003fee8793911sm6984929wmn.44.2023.09.24.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:51:11 -0700 (PDT)
Date:   Sun, 24 Sep 2023 21:51:10 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8192e: Resolve circular locking with
 rx_pkt_pending_timer
Message-ID: <08ff2088b0264bef60142ca35f7198dd8afa963c.1695582999.git.philipp.g.hortmann@gmail.com>
References: <cover.1695582999.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695582999.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve circular locking from reorder_spinlock with rx_pkt_pending_timer.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
[ 4743.466837] ======================================================
[ 4743.466838] WARNING: possible circular locking dependency detected
[ 4743.466840] 6.6.0-rc1+ #15 Tainted: G         C OE
[ 4743.466842] ------------------------------------------------------
[ 4743.466843] Renderer/12378 is trying to acquire lock:
[ 4743.466845] ffff8882142f34d0 ((&rxts->rx_pkt_pending_timer)){+.-.}-{0:0}, at: __timer_delete_sync+0x31/0xc0
[ 4743.466857]
               but task is already holding lock:
[ 4743.466858] ffff8882142f0d48 (&ieee->reorder_spinlock){..-.}-{3:3}, at: rtllib_rx+0x1885/0x2280 [rtllib]
[ 4743.466873]
               which lock already depends on the new lock.

[ 4743.466875]
               the existing dependency chain (in reverse order) is:
[ 4743.466876]
               -> #1 (&ieee->reorder_spinlock){..-.}-{3:3}:
[ 4743.466880]        _raw_spin_lock_irqsave+0x53/0xa0
[ 4743.466884]        RxPktPendingTimeout+0x4b/0x220 [rtllib]
[ 4743.466894]        call_timer_fn+0xab/0x230
[ 4743.466897]        run_timer_softirq+0x4b2/0x570
[ 4743.466900]        __do_softirq+0xca/0x3b7
[ 4743.466903]        irq_exit_rcu+0xa0/0xe0
[ 4743.466907]        sysvec_apic_timer_interrupt+0xb0/0xd0
[ 4743.466910]        asm_sysvec_apic_timer_interrupt+0x1b/0x20
[ 4743.466913]        cpuidle_enter_state+0xfa/0x500
[ 4743.466916]        cpuidle_enter+0x2e/0x50
[ 4743.466919]        call_cpuidle+0x23/0x50
[ 4743.466922]        do_idle+0x21c/0x280
[ 4743.466924]        cpu_startup_entry+0x20/0x30
[ 4743.466926]        start_secondary+0x11a/0x140
[ 4743.466929]        secondary_startup_64_no_verify+0x17d/0x18b
[ 4743.466933]
               -> #0 ((&rxts->rx_pkt_pending_timer)){+.-.}-{0:0}:
[ 4743.466936]        __lock_acquire+0x12e0/0x1de0
[ 4743.466941]        lock_acquire+0xdc/0x2c0
[ 4743.466944]        __timer_delete_sync+0x52/0xc0
[ 4743.466947]        timer_delete_sync+0x10/0x20
[ 4743.466949]        rtllib_rx+0x1ab2/0x2280 [rtllib]
[ 4743.466958]        _rtl92e_irq_rx_tasklet+0x2d5/0x410 [r8192e_pci]
[ 4743.466967]        tasklet_action_common.isra.0+0x10a/0x290
[ 4743.466970]        tasklet_action+0x2d/0x40
[ 4743.466973]        __do_softirq+0xca/0x3b7
[ 4743.466976]        irq_exit_rcu+0xa0/0xe0
[ 4743.466979]        common_interrupt+0xc6/0xe0
[ 4743.466982]        asm_common_interrupt+0x27/0x40
[ 4743.466984]        preempt_count_add+0x13/0xc0
[ 4743.466988]        ww_mutex_lock_interruptible+0x3c/0x110
[ 4743.466992]        i915_gem_madvise_ioctl+0xe9/0x480 [i915]
[ 4743.467126]        drm_ioctl_kernel+0xc0/0x150 [drm]
[ 4743.467178]        drm_ioctl+0x2a9/0x510 [drm]
[ 4743.467216]        __x64_sys_ioctl+0x98/0xd0
[ 4743.467220]        do_syscall_64+0x3b/0x90
[ 4743.467223]        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 4743.467228]
               other info that might help us debug this:

[ 4743.467229]  Possible unsafe locking scenario:

[ 4743.467230]        CPU0                    CPU1
[ 4743.467231]        ----                    ----
[ 4743.467233]   lock(&ieee->reorder_spinlock);
[ 4743.467235]                                lock((&rxts->rx_pkt_pending_timer));
[ 4743.467237]                                lock(&ieee->reorder_spinlock);
[ 4743.467240]   lock((&rxts->rx_pkt_pending_timer));
[ 4743.467242]
                *** DEADLOCK ***

[ 4743.467243] 1 lock held by Renderer/12378:
[ 4743.467245]  #0: ffff8882142f0d48 (&ieee->reorder_spinlock){..-.}-{3:3}, at: rtllib_rx+0x1885/0x2280 [rtllib]
[ 4743.467258]
               stack backtrace:
[ 4743.467259] CPU: 2 PID: 12378 Comm: Renderer Tainted: G         C OE      6.6.0-rc1+ #15
[ 4743.467262] Hardware name: FUJITSU ESPRIMO P710/D3161-A1, BIOS V4.6.5.3 R1.16.0 for D3161-A1x 10/29/2012
[ 4743.467264] Call Trace:
[ 4743.467266]  <IRQ>
[ 4743.467268]  dump_stack_lvl+0x5c/0xa0
[ 4743.467272]  dump_stack+0x10/0x20
[ 4743.467275]  print_circular_bug.isra.0+0x300/0x440
[ 4743.467280]  check_noncircular+0x136/0x150
[ 4743.467284]  ? __lock_acquire+0x654/0x1de0
[ 4743.467289]  __lock_acquire+0x12e0/0x1de0
[ 4743.467295]  lock_acquire+0xdc/0x2c0
[ 4743.467298]  ? __timer_delete_sync+0x31/0xc0
[ 4743.467303]  ? rtllib_rx+0x1885/0x2280 [rtllib]
[ 4743.467311]  ? __this_cpu_preempt_check+0x13/0x20
[ 4743.467314]  ? lock_acquired+0xef/0x3b0
[ 4743.467318]  __timer_delete_sync+0x52/0xc0
[ 4743.467321]  ? __timer_delete_sync+0x31/0xc0
[ 4743.467324]  timer_delete_sync+0x10/0x20
[ 4743.467327]  rtllib_rx+0x1ab2/0x2280 [rtllib]
[ 4743.467335]  ? kmalloc_reserve+0x69/0x100
[ 4743.467342]  _rtl92e_irq_rx_tasklet+0x2d5/0x410 [r8192e_pci]
[ 4743.467351]  ? lockdep_hardirqs_on+0x86/0x110
[ 4743.467357]  tasklet_action_common.isra.0+0x10a/0x290
[ 4743.467361]  tasklet_action+0x2d/0x40
[ 4743.467364]  __do_softirq+0xca/0x3b7
[ 4743.467369]  irq_exit_rcu+0xa0/0xe0
[ 4743.467372]  common_interrupt+0xc6/0xe0
[ 4743.467375]  </IRQ>
[ 4743.467376]  <TASK>
[ 4743.467378]  asm_common_interrupt+0x27/0x40
[ 4743.467380] RIP: 0010:preempt_count_add+0x13/0xc0
[ 4743.467384] Code: 9d ec 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 8b 15 2c 58 ed 02 65 01 3d b5 de 2d 74 <48> 89 e5 53 89 fb 85 d2 75 11 65 8b 05 a4 de 2d 74 0f b6 c0 3d f4
[ 4743.467386] RSP: 0018:ffffc9000d293c80 EFLAGS: 00000282
[ 4743.467389] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888117520000
[ 4743.467391] RDX: 0000000000000000 RSI: ffffffff8d51376a RDI: 0000000000000001
[ 4743.467392] RBP: ffffc9000d293d40 R08: 000004506ca6e7cf R09: ffff88805bfcbd98
[ 4743.467394] R10: ffffc9000d293d58 R11: ffff8880336b80d8 R12: ffff88801ec7d640
[ 4743.467395] R13: ffff8880336b8000 R14: ffff888104828000 R15: 0000000000000000
[ 4743.467401]  ? __ww_mutex_lock.constprop.0+0xa1/0x13e0
[ 4743.467405]  ? __this_cpu_preempt_check+0x13/0x20
[ 4743.467407]  ? lock_is_held_type+0xf3/0x150
[ 4743.467411]  ? i915_gem_madvise_ioctl+0xe9/0x480 [i915]
[ 4743.467529]  ww_mutex_lock_interruptible+0x3c/0x110
[ 4743.467533]  ? ww_mutex_lock_interruptible+0x3c/0x110
[ 4743.467537]  i915_gem_madvise_ioctl+0xe9/0x480 [i915]
[ 4743.467649]  ? __pfx_i915_gem_madvise_ioctl+0x10/0x10 [i915]
[ 4743.467760]  drm_ioctl_kernel+0xc0/0x150 [drm]
[ 4743.467805]  ? __might_fault+0x7b/0x90
[ 4743.467809]  drm_ioctl+0x2a9/0x510 [drm]
[ 4743.467846]  ? __pfx_i915_gem_madvise_ioctl+0x10/0x10 [i915]
[ 4743.467962]  ? __fget_files+0xce/0x190
[ 4743.467968]  __x64_sys_ioctl+0x98/0xd0
[ 4743.467984]  do_syscall_64+0x3b/0x90
[ 4743.467987]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 4743.467992] RIP: 0033:0x7f01d2dcf3ab
[ 4743.467994] Code: 0f 1e fa 48 8b 05 e5 7a 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b5 7a 0d 00 f7 d8 64 89 01 48
[ 4743.467997] RSP: 002b:00007f01badfce58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 4743.467999] RAX: ffffffffffffffda RBX: 00007f01badfcec4 RCX: 00007f01d2dcf3ab
[ 4743.468001] RDX: 00007f01badfcec4 RSI: 00000000c00c6466 RDI: 0000000000000024
[ 4743.468002] RBP: 00000000c00c6466 R08: 00007f01bb1fd048 R09: 0000000000000103
[ 4743.468004] R10: 00007ffd919ca080 R11: 0000000000000246 R12: 00007f01744a5e20
[ 4743.468006] R13: 0000000000000024 R14: 00007f01744a5e98 R15: 00007f01bb1fd000
[ 4743.468010]  </TASK>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 456dd05e291d..a7b6f837024d 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -693,8 +693,10 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 	 * Rx buffering.
 	 */
 	if (index > 0) {
+		spin_unlock_irqrestore(&ieee->reorder_spinlock, flags);
 		if (timer_pending(&ts->rx_pkt_pending_timer))
 			del_timer_sync(&ts->rx_pkt_pending_timer);
+		spin_lock_irqsave(&ieee->reorder_spinlock, flags);
 		ts->rx_timeout_indicate_seq = 0xffff;
 
 		if (index > REORDER_WIN_SIZE) {
@@ -712,8 +714,10 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 	if (bPktInBuf && ts->rx_timeout_indicate_seq == 0xffff) {
 		netdev_dbg(ieee->dev, "%s(): SET rx timeout timer\n", __func__);
 		ts->rx_timeout_indicate_seq = ts->rx_indicate_seq;
+		spin_unlock_irqrestore(&ieee->reorder_spinlock, flags);
 		mod_timer(&ts->rx_pkt_pending_timer, jiffies +
 			  msecs_to_jiffies(ht_info->rx_reorder_pending_time));
+		spin_lock_irqsave(&ieee->reorder_spinlock, flags);
 	}
 	spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 }
-- 
2.42.0

