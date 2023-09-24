Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFF87ACBB8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjIXTvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjIXTvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:51:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F371B4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:51:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4056ce55e6fso6045425e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695585064; x=1696189864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MuoEl24Ovx/D9LBO4Mnd3G/eYK2lcTJZM4N+OjhdEbs=;
        b=eOsQYaNgJyH6y+6Orc/0437So4eZ+kqDqIw8G144zexiIs6WVISQKP+LMSzQDRg5rr
         Tfvwt+ZhBA03LALYIv5sEQsJdsW0Rgeh54mJBLEe0Iza7lvEdxrRU6eCgk9S4kCqtHEJ
         OZpdkOJrioAAAyfrTeJODo0DxvGBklw1VImlIC4Y4Ck0cMBGvUzjgKEmmy2ZkL/I4HPG
         ArqD3TegPy3pUYGFPB4Qmc7q09MCOAbi610/hPGwzAAgDBXHRR82bLJnx4Vui1leKQa7
         JwaaPUtpyKacMHadk1Pyz4SucIxs/7LVR7C/eEYHLe1/QnlpkvNvH40pfOnIYnUkZeNv
         5FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695585064; x=1696189864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuoEl24Ovx/D9LBO4Mnd3G/eYK2lcTJZM4N+OjhdEbs=;
        b=HnZjhPEY1GQb26rHUkXyv8e21ILvUS+pirnGtCgzhR0s10d6+JFL2xIBnXzabu4JoN
         LBp/PUsl580fVqpj3ALmmuPcr6oQZW9QQiqtfvIT8nWSafUW9uDct2vtIga21zgOu2fw
         8YPNlZsRtwWVL0FMxfuhHw98UiHMkT4kKHfCletB/bnv5eHUt4u0GDFVSPYHtsAbSQpa
         3F2hUZITuE958gzbMic7Jj6YrV/O9ZXitGC5X/L0LXoBwOwR8zDYtOaa7ZPJD//lx4ZF
         nNQQCaLOrxDxLtzU3fw/oFjUFTlcgOwFylrHby3ndpVF8fpgV+xJYkDHcbq03Z3JlQnk
         rnsA==
X-Gm-Message-State: AOJu0Yz/8jYIa/uezBm3Xv9qdoLpJRvnpeWJhiw63Wb1qGVIjHHpy9Jy
        CLA+oizysAom6aZTM9cSTq8=
X-Google-Smtp-Source: AGHT+IF1E7ErfqL9YGtl4LgTBaLYsAWhhedR+2y9IEVUvgBe6nn5ZYsDVwx3Mt+o2CxXRyM7aabrFA==
X-Received: by 2002:a7b:c456:0:b0:404:72f9:d59a with SMTP id l22-20020a7bc456000000b0040472f9d59amr4358161wmi.0.1695585063719;
        Sun, 24 Sep 2023 12:51:03 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id y23-20020a05600c365700b004052093a8f6sm10326495wmq.25.2023.09.24.12.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:51:03 -0700 (PDT)
Date:   Sun, 24 Sep 2023 21:51:02 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: rtl8192e: Unlock mutex for one line in
 rtllib_stop_protocol()
Message-ID: <ffe60e8f6e29197f331e239ab38154da97c743be.1695582999.git.philipp.g.hortmann@gmail.com>
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

The following command uses the mutex ieee->wx_mutex:
cancel_delayed_work_sync(&ieee->associate_retry_wq)
Therefore it cannot be canceled with ieee->wx_mutex locked.
rtllib_stop_protocol() is always called with ieee->wx_mutex locked so
according line can be unlocked.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
[  848.458088] ======================================================
[  848.458089] WARNING: possible circular locking dependency detected
[  848.458091] 6.6.0-rc1+ #15 Tainted: G         C OE
[  848.458102] ------------------------------------------------------
[  848.458103] kworker/0:9/346 is trying to acquire lock:
[  848.458104] ffff88817dc37aa0 (&ieee->wx_mutex){+.+.}-{4:4}, at: rtllib_associate_retry_wq+0x2d/0xb0 [rtllib]
[  848.458121]
               but task is already holding lock:
[  848.458122] ffffc900017cfe38 ((work_completion)(&(&ieee->associate_retry_wq)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x27f/0x580
[  848.458129]
               which lock already depends on the new lock.

[  848.458130]
               the existing dependency chain (in reverse order) is:
[  848.458131]
               -> #1 ((work_completion)(&(&ieee->associate_retry_wq)->work)){+.+.}-{0:0}:
[  848.458134]        __flush_work+0x6d/0x490
[  848.458137]        __cancel_work_timer+0x137/0x1c0
[  848.458140]        cancel_delayed_work_sync+0x13/0x20
[  848.458142]        rtllib_stop_protocol.part.0+0x49/0x120 [rtllib]
[  848.458151]        rtllib_stop_protocol+0x1c/0x30 [rtllib]
[  848.458159]        rtllib_wx_set_essid+0x12a/0x150 [rtllib]
[  848.458167]        _rtl92e_wx_set_essid+0x4e/0xa0 [r8192e_pci]
[  848.458176]        ioctl_standard_iw_point+0x2e6/0x390
[  848.458180]        ioctl_standard_call+0xaa/0xe0
[  848.458183]        wireless_process_ioctl+0x149/0x170
[  848.458185]        wext_handle_ioctl+0x9e/0x100
[  848.458188]        sock_ioctl+0x203/0x340
[  848.458192]        __x64_sys_ioctl+0x98/0xd0
[  848.458195]        do_syscall_64+0x3b/0x90
[  848.458198]        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  848.458202]
               -> #0 (&ieee->wx_mutex){+.+.}-{4:4}:
[  848.458206]        __lock_acquire+0x12e0/0x1de0
[  848.458209]        lock_acquire+0xdc/0x2c0
[  848.458212]        __mutex_lock+0x99/0xce0
[  848.458216]        mutex_lock_nested+0x1b/0x30
[  848.458219]        rtllib_associate_retry_wq+0x2d/0xb0 [rtllib]
[  848.458227]        process_scheduled_works+0x308/0x580
[  848.458229]        worker_thread+0x19b/0x360
[  848.458231]        kthread+0x116/0x150
[  848.458234]        ret_from_fork+0x3c/0x60
[  848.458237]        ret_from_fork_asm+0x1b/0x30
[  848.458242]
               other info that might help us debug this:

[  848.458243]  Possible unsafe locking scenario:

[  848.458244]        CPU0                    CPU1
[  848.458245]        ----                    ----
[  848.458246]   lock((work_completion)(&(&ieee->associate_retry_wq)->work));
[  848.458248]                                lock(&ieee->wx_mutex);
[  848.458250]                                lock((work_completion)(&(&ieee->associate_retry_wq)->work));
[  848.458252]   lock(&ieee->wx_mutex);
[  848.458254]
                *** DEADLOCK ***

[  848.458255] 2 locks held by kworker/0:9/346:
[  848.458257]  #0: ffff88810004f148 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x27f/0x580
[  848.458262]  #1: ffffc900017cfe38 ((work_completion)(&(&ieee->associate_retry_wq)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x27f/0x580
[  848.458266]
               stack backtrace:
[  848.458268] CPU: 0 PID: 346 Comm: kworker/0:9 Tainted: G         C OE      6.6.0-rc1+ #15
[  848.458270] Hardware name: FUJITSU ESPRIMO P710/D3161-A1, BIOS V4.6.5.3 R1.16.0 for D3161-A1x 10/29/2012
[  848.458272] Workqueue: events rtllib_associate_retry_wq [rtllib]
[  848.458281] Call Trace:
[  848.458283]  <TASK>
[  848.458285]  dump_stack_lvl+0x5c/0xa0
[  848.458288]  dump_stack+0x10/0x20
[  848.458291]  print_circular_bug.isra.0+0x300/0x440
[  848.458295]  check_noncircular+0x136/0x150
[  848.458298]  ? ret_from_fork_asm+0x1b/0x30
[  848.458302]  ? __kernel_text_address+0x12/0x40
[  848.458305]  __lock_acquire+0x12e0/0x1de0
[  848.458311]  lock_acquire+0xdc/0x2c0
[  848.458314]  ? rtllib_associate_retry_wq+0x2d/0xb0 [rtllib]
[  848.458324]  __mutex_lock+0x99/0xce0
[  848.458327]  ? rtllib_associate_retry_wq+0x2d/0xb0 [rtllib]
[  848.458336]  ? rtllib_associate_retry_wq+0x2d/0xb0 [rtllib]
[  848.458344]  ? __this_cpu_preempt_check+0x13/0x20
[  848.458348]  mutex_lock_nested+0x1b/0x30
[  848.458351]  ? mutex_lock_nested+0x1b/0x30
[  848.458354]  rtllib_associate_retry_wq+0x2d/0xb0 [rtllib]
[  848.458363]  process_scheduled_works+0x308/0x580
[  848.458368]  ? __pfx_worker_thread+0x10/0x10
[  848.458370]  worker_thread+0x19b/0x360
[  848.458373]  ? __pfx_worker_thread+0x10/0x10
[  848.458375]  kthread+0x116/0x150
[  848.458378]  ? __pfx_kthread+0x10/0x10
[  848.458381]  ret_from_fork+0x3c/0x60
[  848.458384]  ? __pfx_kthread+0x10/0x10
[  848.458387]  ret_from_fork_asm+0x1b/0x30
[  848.458392]  </TASK>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index c874468d075c..72d0225dfdf1 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2307,7 +2307,9 @@ void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown)
 	}
 
 	del_timer_sync(&ieee->associate_timer);
+	mutex_unlock(&ieee->wx_mutex);
 	cancel_delayed_work_sync(&ieee->associate_retry_wq);
+	mutex_lock(&ieee->wx_mutex);
 	cancel_delayed_work_sync(&ieee->link_change_wq);
 	rtllib_stop_scan(ieee);
 
-- 
2.42.0

