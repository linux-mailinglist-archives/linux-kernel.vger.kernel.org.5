Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD3792D01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjIESBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjIESBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:01:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC221BE2;
        Tue,  5 Sep 2023 11:01:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so43106431fa.3;
        Tue, 05 Sep 2023 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693936792; x=1694541592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2qtR38AQqyrhg+wg/AFz93Jqj22E03pBVcrbMpTKjg=;
        b=lFfwCYymd41v/xH2QTOHTUCxX5T0sZ2q3CbX3vHfieNe2mf7GY0IVnpyNe8BoqTwbO
         jfFEIIuByRH+FnPhMDplHz2kWRWMaFidtu0uUl5KaG6Nv3QUeDedevGAGTvFo+7ZJCFO
         ZJFufMC9M1JPcelZoczEjH8wlQlu1Qt9K7BRFQRjCK5Ieb6wCP7TRng2wAb918hPghIy
         JlpXAr3TEDZsobhb2sNUFWrY8JwBKhQlHw+9yXkAPmscfndwUNakf3PjEvV0BKD6Y7+K
         qI/kCjaL/qElLAG+XIgubuvsrZTsqX3ksXAYalBV/bvQLsL/6mNCt0uFCbx1Al2b8H58
         /Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693936792; x=1694541592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2qtR38AQqyrhg+wg/AFz93Jqj22E03pBVcrbMpTKjg=;
        b=a+2agrtnUWeiT44LBjFUcpDqYy8rCej+PyJbDKM0Hcheom9z+GrHl9bDMqKiYtLjHk
         oRUrCW3WoJ0tfcefdGjgvf6uf7a7P5r0xEJ1MHF0WyqVyWrJ3k/+G3k5eZf3srE+eLMl
         jBbeeGq6HScl63NtuoSMZzrvDkC0/YCnoPLf25bBKqimOGeHJHY4xQQfPVMJIOtUAxRE
         S+vWZDYKWNbny0V2LHiYIaxOxEzDeZ+Q1fA0eXLvHKyNIIz1OpDt92HC67GECrcoyBN3
         ImQD8lp66fX+gDc+MlvCqs7mdWmHzaqCoJKBG+wHFczUU9p3h1BP3feZkRWQ7rK0VJz2
         g6zw==
X-Gm-Message-State: AOJu0Yz1FzLhFwVUfNcl6L8O5LdGmS1Bl9ZEiEFmXYSS6evsDmPdaN/v
        kPYm3lMFsdAK0RIGVIV8SyCtTsdyq6I=
X-Google-Smtp-Source: AGHT+IGYh6HYOA90Uyk2anv/if6vtVEw79Uud7KFaJ6l8obrPbGcFE3W4CVXFFS2+HATpXlA8t32Bw==
X-Received: by 2002:a2e:b16e:0:b0:2bd:ddf:8aa6 with SMTP id a14-20020a2eb16e000000b002bd0ddf8aa6mr229918ljm.23.1693932374455;
        Tue, 05 Sep 2023 09:46:14 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id v4-20020a2e9244000000b002bb9a93b67bsm3004787ljg.121.2023.09.05.09.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:46:14 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 5 Sep 2023 18:46:12 +0200
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <ZPdbVO8ySCHLIEGu@pc636>
References: <bb603efb-654f-4686-bad9-0bb5379745c0@paulmck-laptop>
 <CA+FbhJPtmFG2vKNXWr67Tuh-4HUi8n81PmKxwftv9iK1a3On-A@mail.gmail.com>
 <ZPW+KJCIAvFzZHl8@pc636>
 <CA+FbhJPNZ-E3e7WBH_jAvi3Rn-2gV4TVk9S9qmheXkqXw+Sakg@mail.gmail.com>
 <ZPXyUTteVxXtqiEo@pc636>
 <CA+FbhJMr6LzmOpVNkYyiSERAsNEqqvQwQ7SwJK=CmwvV9d2Z-A@mail.gmail.com>
 <ZPYLmm3ih7u95l1a@pc636>
 <ZPYsY2HEjySkq/NR@pc636>
 <CA+FbhJPNK=4s8J5OqOBaDC8EDNQzevQMQ+fwZnfxG92ReabQOA@mail.gmail.com>
 <CA+FbhJMEqLycroz=J6VvC=4OBaJSwz8K+K6Zgki80M-5YdYp6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FbhJMEqLycroz=J6VvC=4OBaJSwz8K+K6Zgki80M-5YdYp6A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> For a comparison, I've attached a journalctl log for my custom 6.4.14 Kernel.
> 
1. I tried to apply your patches on stable 6.5.1 kernel. All of them can be
applied except of one. Its name is 0001-ms178.patch and it produces below
rejects:

<snip>
    arch/alpha/kernel/syscalls/syscall.tbl.rej
    arch/arm/tools/syscall.tbl.rej
    arch/arm64/include/asm/unistd.h.rej
    arch/arm64/include/asm/unistd32.h.rej
    arch/ia64/kernel/syscalls/syscall.tbl.rej
    arch/m68k/kernel/syscalls/syscall.tbl.rej
    arch/microblaze/kernel/syscalls/syscall.tbl.rej
    arch/mips/kernel/syscalls/syscall_n32.tbl.rej
    arch/mips/kernel/syscalls/syscall_n64.tbl.rej
    arch/mips/kernel/syscalls/syscall_o32.tbl.rej
    arch/parisc/kernel/syscalls/syscall.tbl.rej
    arch/powerpc/kernel/syscalls/syscall.tbl.rej
    arch/s390/kernel/syscalls/syscall.tbl.rej
    arch/sh/kernel/syscalls/syscall.tbl.rej
    arch/sparc/kernel/syscalls/syscall.tbl.rej
    arch/x86/entry/syscalls/syscall_32.tbl.rej
    arch/x86/entry/syscalls/syscall_64.tbl.rej
    arch/xtensa/kernel/syscalls/syscall.tbl.rej
    include/uapi/asm-generic/unistd.h.rej
<snip>

But let's skip that part.

2. One of patches also modifies the kernel/rcu/tree.c file:

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1449cb69a0e0..fbc20c6cdbeb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2810,6 +2810,7 @@ struct kfree_rcu_cpu_work {

 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
+ * @gp_snap: The GP snapshot recorded at the last scheduling of monitor work.
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
  * @head_gp_snap: Snapshot of RCU state for objects placed to "@head"
  * @bulk_head: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
@@ -2849,6 +2850,7 @@ struct kfree_rcu_cpu {
        struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
        raw_spinlock_t lock;
        struct delayed_work monitor_work;
+       unsigned long gp_snap;
        bool initialized;

        struct delayed_work page_cache_work;
@@ -3095,6 +3097,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
                        mod_delayed_work(system_wq, &krcp->monitor_work, delay);
                return;
        }
+       krcp->gp_snap = get_state_synchronize_rcu();
        queue_delayed_work(system_wq, &krcp->monitor_work, delay);
 }

@@ -3187,7 +3190,10 @@ static void kfree_rcu_monitor(struct work_struct *work)
                        // be that the work is in the pending state when
                        // channels have been detached following by each
                        // other.
-                       queue_rcu_work(system_wq, &krwp->rcu_work);
+                       if (poll_state_synchronize_rcu(krcp->gp_snap))
+                               queue_work(system_wq, &krwp->rcu_work.work);
+                       else
+                               queue_rcu_work(system_wq, &krwp->rcu_work);
                }
        }
<snip>

i do not understand where you got this patch and what a reason behind of
applying is.

3. Could you please remove that patch(revert it) and try one more time?

4. When i apply all your patches i see that you modify:

urezki@pc638:~/data/raid0/coding/linux-stable.git$ git st | wc -l
455
urezki@pc638:~/data/raid0/coding/linux-stable.git$

455 files. The delta is huge. It touches arch, mm, rcu, drivers, crypto,
include/linux/ generic headers, init, kernel, lib, net, etc parts.

So as a result we have:

<snip>
    451 files changed, 34218 insertions(+), 5576 deletions(-)
<snip>

--
Uladzislau Rezki
