Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33BF7ACBB7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjIXTvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjIXTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:51:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5D193
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:50:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4051d33af1fso16243905e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695585058; x=1696189858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fgyKxqKA15nbfaH4vMDu01hflBvGs/eg6IGSdQy6Jmg=;
        b=YICS9s8cGplPci++Do1NpU+EWsUwFr37i+tcskMiZqQ8CzHTfXjWSABODQKyI9mfqB
         xxpnqt11FtmcA2Uq5KPE8QxDSJ5qlHtv3nFrtv79DLZWOqqipIcoafFTgpRHvQahA2sy
         l4+EIOC0z4F7C3fd6rKEuy7fJDLCC1+wXFFXwgL54lXdyHQqz8UfOJjLtmCmIWiKluOQ
         Z0NnL9fLZMSAdDx3qjCKIamJwDisu2lNt1PnIiPah/SfkRrYX5E6+OGwwryh22bbv4qE
         Q0EM72Y5cSQmG80Uf+PLuMYLN7gT4mZVaU1v80zqlb1wy6e2JfrFc6q+QsN1GvXAsyMY
         Z2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695585058; x=1696189858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgyKxqKA15nbfaH4vMDu01hflBvGs/eg6IGSdQy6Jmg=;
        b=V9JOC9N0xIaNqV8Lg+L3rZFlVBPH1dysZsgvEdIrskalKi3R6H7YGPQhIuC/wxdzSM
         VnJNdKOzOdaFk409GgVIHPUHSUK6SWVmovbTXm/hhruLM32IdB5DRxffANci5Gnp3cHi
         rsQhcpgYN+s/yZ2Bjy1BLTx3iZbzWM+1aEvyJp52K6/irtmQiiANF9YeKd3dbSn1G4rN
         coLM2gMz8dIF1TOwZQdMm+bhbkuTm34RyZ3roiq7CaB3mvRCKFlFeyds8jLCPKCUntWp
         mS/Nl2oaT7qHfh8cxDOydEwXV4eWiio2CFmq/C6f+I7WB3oGo4UxOwfW8ibVvpXYMKX1
         /YUQ==
X-Gm-Message-State: AOJu0Yz5rHNsvoxGu73F+ph4/LEreZYL1JBxEnCtzziD431LGb8p8rQB
        X/cM6xIbh2vFi6yb1b19M0Y=
X-Google-Smtp-Source: AGHT+IF4ubKUcoW7XeHwG8rJ5kor+/5lTlxu9UUKJEk1dt+QSmfibbPJjVlYjeYfpDhqKv+ebMkVjA==
X-Received: by 2002:a05:600c:3223:b0:3fe:d46a:ef4b with SMTP id r35-20020a05600c322300b003fed46aef4bmr4053775wmp.1.1695585057685;
        Sun, 24 Sep 2023 12:50:57 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm10339959wmc.1.2023.09.24.12.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:50:57 -0700 (PDT)
Date:   Sun, 24 Sep 2023 21:50:55 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8192e: Remove mutex from
 rtllib_softmac_free()
Message-ID: <a5308876bd8fabcb5f8b25d14dbad2c1f68ce59f.1695582999.git.philipp.g.hortmann@gmail.com>
References: <cover.1695582999.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695582999.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commands use the mutex ieee->wx_mutex:
cancel_delayed_work_sync(&ieee->associate_retry_wq)
cancel_delayed_work_sync(&ieee->associate_procedure_wq)
cancel_work_sync(&ieee->wx_sync_scan_wq)
Therefore they cannot be canceled with ieee->wx_mutex locked. As the
work functions are executed time shifted during normal operation of the
driver, proper locking can only be done inside the functions.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

[  261.339100] ======================================================
[  261.339102] WARNING: possible circular locking dependency detected
[  261.339103] 6.6.0-rc1+ #15 Tainted: G         C OE
[  261.339105] ------------------------------------------------------
[  261.339106] rmmod/6566 is trying to acquire lock:
[  261.339109] ffff888113ca8800 ((work_completion)(&(&ieee->associate_procedure_wq)->work)){+.+.}-{0:0}, at: __flush_work+0x4d/0x490
[  261.339118]
               but task is already holding lock:
[  261.339119] ffff888113ca7aa0 (&ieee->wx_mutex){+.+.}-{4:4}, at: rtllib_softmac_free+0x20/0xd0 [rtllib]
[  261.339134]
               which lock already depends on the new lock.

[  261.339136]
               the existing dependency chain (in reverse order) is:
[  261.339137]
               -> #1 (&ieee->wx_mutex){+.+.}-{4:4}:
[  261.339140]        __mutex_lock+0x99/0xce0
[  261.339146]        mutex_lock_nested+0x1b/0x30
[  261.339149]        rtllib_associate_procedure_wq+0x5b/0x4b0 [rtllib]
[  261.339159]        process_scheduled_works+0x308/0x580
[  261.339161]        worker_thread+0x19b/0x360
[  261.339163]        kthread+0x116/0x150
[  261.339166]        ret_from_fork+0x3c/0x60
[  261.339170]        ret_from_fork_asm+0x1b/0x30
[  261.339174]
               -> #0 ((work_completion)(&(&ieee->associate_procedure_wq)->work)){+.+.}-{0:0}:
[  261.339177]        __lock_acquire+0x12e0/0x1de0
[  261.339182]        lock_acquire+0xdc/0x2c0
[  261.339185]        __flush_work+0x6d/0x490
[  261.339187]        __cancel_work_timer+0x137/0x1c0
[  261.339190]        cancel_delayed_work_sync+0x13/0x20
[  261.339192]        rtllib_softmac_free+0x5b/0xd0 [rtllib]
[  261.339201]        free_rtllib+0x27/0x70 [rtllib]
[  261.339209]        _rtl92e_pci_disconnect+0xaf/0x140 [r8192e_pci]
[  261.339217]        pci_device_remove+0x39/0xb0
[  261.339221]        device_remove+0x46/0x70
[  261.339225]        device_release_driver_internal+0xb9/0x140
[  261.339228]        driver_detach+0x4d/0xa0
[  261.339231]        bus_remove_driver+0x6e/0xf0
[  261.339233]        driver_unregister+0x31/0x50
[  261.339236]        pci_unregister_driver+0x40/0x90
[  261.339239]        rtl8192_pci_driver_exit+0x10/0x380 [r8192e_pci]
[  261.339247]        __do_sys_delete_module.isra.0+0x187/0x2f0
[  261.339251]        __x64_sys_delete_module+0x12/0x20
[  261.339254]        do_syscall_64+0x3b/0x90
[  261.339257]        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  261.339261]
               other info that might help us debug this:

[  261.339262]  Possible unsafe locking scenario:

[  261.339263]        CPU0                    CPU1
[  261.339264]        ----                    ----
[  261.339265]   lock(&ieee->wx_mutex);
[  261.339268]                                lock((work_completion)(&(&ieee->associate_procedure_wq)->work));
[  261.339270]                                lock(&ieee->wx_mutex);
[  261.339272]   lock((work_completion)(&(&ieee->associate_procedure_wq)->work));
[  261.339274]
                *** DEADLOCK ***

[  261.339275] 2 locks held by rmmod/6566:
[  261.339277]  #0: ffff8881015d51b0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock+0x2d/0x50
[  261.339283]  #1: ffff888113ca7aa0 (&ieee->wx_mutex){+.+.}-{4:4}, at: rtllib_softmac_free+0x20/0xd0 [rtllib]
[  261.339295]
               stack backtrace:
[  261.339296] CPU: 1 PID: 6566 Comm: rmmod Tainted: G         C OE      6.6.0-rc1+ #15
[  261.339299] Hardware name: FUJITSU ESPRIMO P710/D3161-A1, BIOS V4.6.5.3 R1.16.0 for D3161-A1x 10/29/2012
[  261.339301] Call Trace:
[  261.339302]  <TASK>
[  261.339304]  dump_stack_lvl+0x5c/0xa0
[  261.339309]  dump_stack+0x10/0x20
[  261.339311]  print_circular_bug.isra.0+0x300/0x440
[  261.339316]  check_noncircular+0x136/0x150
[  261.339319]  ? register_lock_class+0x4c/0x460
[  261.339322]  ? __bfs+0x110/0x250
[  261.339326]  __lock_acquire+0x12e0/0x1de0
[  261.339330]  ? hugetlb_init+0x5b2/0x720
[  261.339335]  lock_acquire+0xdc/0x2c0
[  261.339339]  ? __flush_work+0x4d/0x490
[  261.339342]  ? __this_cpu_preempt_check+0x13/0x20
[  261.339345]  ? lock_release+0x14f/0x380
[  261.339349]  __flush_work+0x6d/0x490
[  261.339352]  ? __flush_work+0x4d/0x490
[  261.339354]  ? lock_timer_base+0x72/0xa0
[  261.339357]  ? __this_cpu_preempt_check+0x13/0x20
[  261.339359]  ? lock_acquired+0xef/0x3b0
[  261.339362]  ? sched_clock_noinstr+0x9/0x10
[  261.339367]  ? __cancel_work_timer+0x10d/0x1c0
[  261.339369]  ? __this_cpu_preempt_check+0x13/0x20
[  261.339373]  __cancel_work_timer+0x137/0x1c0
[  261.339377]  cancel_delayed_work_sync+0x13/0x20
[  261.339380]  rtllib_softmac_free+0x5b/0xd0 [rtllib]
[  261.339389]  free_rtllib+0x27/0x70 [rtllib]
[  261.339397]  _rtl92e_pci_disconnect+0xaf/0x140 [r8192e_pci]
[  261.339406]  pci_device_remove+0x39/0xb0
[  261.339410]  device_remove+0x46/0x70
[  261.339413]  device_release_driver_internal+0xb9/0x140
[  261.339417]  driver_detach+0x4d/0xa0
[  261.339420]  bus_remove_driver+0x6e/0xf0
[  261.339424]  driver_unregister+0x31/0x50
[  261.339427]  pci_unregister_driver+0x40/0x90
[  261.339431]  rtl8192_pci_driver_exit+0x10/0x380 [r8192e_pci]
[  261.339439]  __do_sys_delete_module.isra.0+0x187/0x2f0
[  261.339442]  ? syscall_enter_from_user_mode+0x21/0x60
[  261.339446]  ? lockdep_hardirqs_on+0x86/0x110
[  261.339450]  __x64_sys_delete_module+0x12/0x20
[  261.339454]  do_syscall_64+0x3b/0x90
[  261.339457]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  261.339461] RIP: 0033:0x7f3b2132da6b
[  261.339464] Code: 73 01 c3 48 8b 0d 25 c4 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f5 c3 0c 00 f7 d8 64 89 01 48
[  261.339466] RSP: 002b:00007ffea140e858 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  261.339469] RAX: ffffffffffffffda RBX: 00005637c0086770 RCX: 00007f3b2132da6b
[  261.339471] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005637c00867d8
[  261.339473] RBP: 00007ffea140e8b8 R08: 0000000000000000 R09: 0000000000000000
[  261.339474] R10: 00007f3b213a9ac0 R11: 0000000000000206 R12: 00007ffea140ea90
[  261.339476] R13: 00007ffea140f7c0 R14: 00005637c00862a0 R15: 00005637c0086770
[  261.339480]  </TASK>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index d3468b646ca8..c874468d075c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2461,7 +2461,6 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 
 void rtllib_softmac_free(struct rtllib_device *ieee)
 {
-	mutex_lock(&ieee->wx_mutex);
 	del_timer_sync(&ieee->associate_timer);
 
 	cancel_delayed_work_sync(&ieee->associate_retry_wq);
@@ -2477,7 +2476,6 @@ void rtllib_softmac_free(struct rtllib_device *ieee)
 
 	kfree(ieee->dot11d_info);
 	ieee->dot11d_info = NULL;
-	mutex_unlock(&ieee->wx_mutex);
 }
 
 static inline struct sk_buff *
-- 
2.42.0

