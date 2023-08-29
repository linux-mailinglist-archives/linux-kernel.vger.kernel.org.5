Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC978CD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbjH2TxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjH2Tw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:52:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C51139
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:52:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0db66af1bso25778755ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693338773; x=1693943573; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bflQmhTCgSgZryUNaNla89LTj5Q7+WSGXPZw3K4WHC4=;
        b=f2KuDs4BNBD+CzBaFg+vF9xDAWdLZnk6NVAsqfFHQZO8Ln/W3pG00QYzKgsTn1njwF
         Jdzf2M4+gdYsUvByJ0KeVJ9HS5WKc6giiS/3C0OxIW24grNU80qreKS5fT1VIdjkSTKo
         RzMce7qTvxVN9wIW2k5kQ7E1fNPr5Lxo6chccA/xPqHqYmdjD1EHOZCCKUXl4dfgfPYp
         sB8b3VGuMY5C91o0QgNRbk151UWAE5La0cnULQcnZb2yRoo+QZCy4oVk0V2V4Br92/03
         qgNv2jnyAaNtWYAcRZrwyO6vQ8IqPDYP760RYmIQgTgJahryG5CWrYzZKW9j8FeA6iW1
         kG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693338773; x=1693943573;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bflQmhTCgSgZryUNaNla89LTj5Q7+WSGXPZw3K4WHC4=;
        b=XxRNoKeg/ECZacabdJ7YSm8xf4g0ya1LjnOL2gSilHtBF+A+fxBbBmx29BU0XWiJDu
         dOBI6ayDt4IGQBf935XzbaVYo4Uf/VGEhNkig1q70kD3fNKoduVkXicWVJm+Oli/63AH
         eZUeZpsHxmNtiGKOKXC4FmsHrjcHB+gkEm9h1DGKmSrAc1nbXyugUwKuXWEh5GpnYg2B
         ycClyXGoTvM6NZcCkT7VuVenb22rMl1xg2A1uDQmV6wc1iQmwGeVJ8zzR4Enm6AlMS4d
         cqoMqwEaVj6yWB4YwnaAk7gEDk8tbHimAVMsyOyAZGsNkadBBnQ2nVkjqFJQGeQp0X/B
         wXmw==
X-Gm-Message-State: AOJu0YyqjNqqVhdmy1ExKJI6wRD/aLj3/v917lARzg5AaA0inyuCDZ8y
        59SdMnjOnzbm1TgV0GKB2W2c0C3CRM0=
X-Google-Smtp-Source: AGHT+IGu2o/2x5S++tveolLnqG0661PCR6JBp73Xz4JYnlK5USI3JJheKYe/Z5TZflpeDcGomBo0zA==
X-Received: by 2002:a17:902:e54d:b0:1bf:1:a4a8 with SMTP id n13-20020a170902e54d00b001bf0001a4a8mr179364plf.25.1693338773483;
        Tue, 29 Aug 2023 12:52:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f05])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b001befe0ac506sm9732006plg.175.2023.08.29.12.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:52:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Aug 2023 09:52:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 1/1] workqueue: fix data race with the pwq->stats[]
 increment
Message-ID: <ZO5Mk4a_LylG2AdM@slm.duckdns.org>
References: <20230826145102.5962-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230826145102.5962-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 04:51:03PM +0200, Mirsad Goran Todorovac wrote:
> KCSAN has discovered a data race in kernel/workqueue.c:2598:
> 
> [ 1863.554079] ==================================================================
> [ 1863.554118] BUG: KCSAN: data-race in process_one_work / process_one_work
> 
> [ 1863.554142] write to 0xffff963d99d79998 of 8 bytes by task 5394 on cpu 27:
> [ 1863.554154] process_one_work (kernel/workqueue.c:2598)
> [ 1863.554166] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
> [ 1863.554177] kthread (kernel/kthread.c:389)
> [ 1863.554186] ret_from_fork (arch/x86/kernel/process.c:145)
> [ 1863.554197] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
> 
> [ 1863.554213] read to 0xffff963d99d79998 of 8 bytes by task 5450 on cpu 12:
> [ 1863.554224] process_one_work (kernel/workqueue.c:2598)
> [ 1863.554235] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
> [ 1863.554247] kthread (kernel/kthread.c:389)
> [ 1863.554255] ret_from_fork (arch/x86/kernel/process.c:145)
> [ 1863.554266] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
> 
> [ 1863.554280] value changed: 0x0000000000001766 -> 0x000000000000176a
> 
> [ 1863.554295] Reported by Kernel Concurrency Sanitizer on:
> [ 1863.554303] CPU: 12 PID: 5450 Comm: kworker/u64:1 Tainted: G             L     6.5.0-rc6+ #44
> [ 1863.554314] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> [ 1863.554322] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
> [ 1863.554941] ==================================================================
> 
>     lockdep_invariant_state(true);
> →   pwq->stats[PWQ_STAT_STARTED]++;
>     trace_workqueue_execute_start(work);
>     worker->current_func(work);
> 
> Moving pwq->stats[PWQ_STAT_STARTED]++; before the line
> 
>     raw_spin_unlock_irq(&pool->lock);
> 
> resolves the data race without performance penalty.
> 
> KCSAN detected at least one additional data race:
> 
> [  157.834751] ==================================================================
> [  157.834770] BUG: KCSAN: data-race in process_one_work / process_one_work
> 
> [  157.834793] write to 0xffff9934453f77a0 of 8 bytes by task 468 on cpu 29:
> [  157.834804] process_one_work (/home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2606) 
> [  157.834815] worker_thread (/home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:292 /home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2752) 
> [  157.834826] kthread (/home/marvin/linux/kernel/linux_torvalds/kernel/kthread.c:389) 
> [  157.834834] ret_from_fork (/home/marvin/linux/kernel/linux_torvalds/arch/x86/kernel/process.c:145) 
> [  157.834845] ret_from_fork_asm (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:312) 
> 
> [  157.834859] read to 0xffff9934453f77a0 of 8 bytes by task 214 on cpu 7:
> [  157.834868] process_one_work (/home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2606) 
> [  157.834879] worker_thread (/home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:292 /home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2752) 
> [  157.834890] kthread (/home/marvin/linux/kernel/linux_torvalds/kernel/kthread.c:389) 
> [  157.834897] ret_from_fork (/home/marvin/linux/kernel/linux_torvalds/arch/x86/kernel/process.c:145) 
> [  157.834907] ret_from_fork_asm (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:312) 
> 
> [  157.834920] value changed: 0x000000000000052a -> 0x0000000000000532
> 
> [  157.834933] Reported by Kernel Concurrency Sanitizer on:
> [  157.834941] CPU: 7 PID: 214 Comm: kworker/u64:2 Tainted: G             L     6.5.0-rc7-kcsan-00169-g81eaf55a60fc #4
> [  157.834951] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> [  157.834958] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
> [  157.835567] ==================================================================
> 
> in code:
> 
>         trace_workqueue_execute_end(work, worker->current_func);
> →       pwq->stats[PWQ_STAT_COMPLETED]++;
>         lock_map_release(&lockdep_map);
>         lock_map_release(&pwq->wq->lockdep_map);
> 
> which needs to be resolved separately.
> 
> Fixes: 725e8ec59c56c ("workqueue: Add pwq->stats[] and a monitoring script")
> Cc: Tejun Heo <tj@kernel.org>
> Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Link: https://lore.kernel.org/lkml/20230818194448.29672-1-mirsad.todorovac@alu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Applied to wq/for-6.6.

Thanks.

-- 
tejun
