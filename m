Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CFD7880F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbjHYHgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjHYHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:36:21 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E368A1BFA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:36:16 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-44d48168e2cso249436137.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692948976; x=1693553776;
        h=cc:to:subject:message-id:date:from:references:mime-version
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nYtnhfoi77ewuRiAdvSOjm3HoDbdptzItejWQcEXciI=;
        b=lELWVPc7+zwMpS/qGVXKFHF44pr0QGvmzOWquFixmTvYGW6IMmj4QFcsVzUhb+A38z
         t9Y6JWTeKSLA7iAIxtiLz7Xvp537RSJMQuAgTz3gLXCntB8qFKgwa3gce2qM+wAnDhCd
         auCDjYDsZ/pnJyjm3/H8HWE1K2MSv4m/y3GCWy1z3Np2JID2e7oPxy/XSmdJU7kb77Xz
         7QmbMTio2moDfYgO/5y3a1U79rTzTude9haYdhOOchzlyjxu0Bfat3n4IxEchYYXFer3
         +MJlvKd84gCMDZFcuE0jeQmWcZQ3k0bkwddWY/FaPlrZeB5i3lKZ8rUtiLBihMlHDExy
         rVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692948976; x=1693553776;
        h=cc:to:subject:message-id:date:from:references:mime-version
         :in-reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYtnhfoi77ewuRiAdvSOjm3HoDbdptzItejWQcEXciI=;
        b=DA29F1c/YyDFFPNAfhd4C0cIJelI1RZCRuywYqQH/syMu3U4UzdxFtUFcpLmo5IYw3
         Nv3AEE7o+qlA1io8LURrpjL3ksvzkejz0qT+qcx1vpNHHiJVCtZmaAoWK0RQlos15jS0
         JrCYc/kKesDXqlMtM5iQWsI6hmOlaBC8wQvRWpRAhcnHMpvkGQT6qyN2PF+ZuUTq0z4s
         TOFK8HNidMqaFORVEU2aqB3IUDbxffySMgx8aBzF0uhqTbKWHgz2IXL1v4JT+gLpeDt6
         f5/46RSqkOSJVVg+HrVw3rTsEeGJcSb2EJtVQK+0Q9hRsOhXYqcnKp0nwcU9i/fXObZU
         TD1Q==
X-Gm-Message-State: AOJu0YwPiY5zzVokyCP44W/NfQGWVwkvPJHW/CKB9TZT4FaZXAFNfAij
        5k99QR7SBwt57FQeswH8XfSnx041fZx+u4m7RWarkg==
X-Google-Smtp-Source: AGHT+IG+o6NEsH1/mnqYtb7JdyuAGbsoWGIsijGWr0TtFqZzUTNB9/JB+J438+sBUDjWKg3n14ibqJqyvua6rwyc+uU=
X-Received: by 2002:a67:ec57:0:b0:443:6deb:2b4 with SMTP id
 z23-20020a67ec57000000b004436deb02b4mr16407704vso.2.1692948976018; Fri, 25
 Aug 2023 00:36:16 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Aug 2023 00:36:15 -0700
In-Reply-To: <875y54ci86.ffs@tglx>
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx>
From:   brgl@bgdev.pl
Date:   Fri, 25 Aug 2023 00:36:15 -0700
Message-ID: <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 22:12:41 +0200, Thomas Gleixner <tglx@linutronix.de> said:
> On Mon, Aug 14 2023 at 11:36, Bartosz Golaszewski wrote:
>
> Please read and follow the guidelines of the tip tree:
>
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
>

Gah! And I sent a second series about the same time for genirq with a correct
subject line...

>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> When removing the proc entry for a desc that still has active users, we
>> will leak the irqaction entries. Let's remove them in
>> unregister_irq_proc().
>
> How exactly is an interrupt descriptor freed which has still active
> users?
>
> If that happens then the procfs entry leak is the least of your worries.
>

Let's consider the following stack trace

------------[ cut here ]------------
remove_proc_entry: removing non-empty directory 'irq/30', leaking at
least 'reset'
WARNING: CPU: 5 PID: 261 at fs/proc/generic.c:717 remove_proc_entry+0x27a/0x290
Modules linked in: gpio_sim gpio_consumer cfg80211 parport_pc parport
nfsd sch_fq_codel fuse cons
CPU: 5 PID: 261 Comm: test.sh Not tainted
6.5.0-rc7-next-20230825-yocto-standard+ #125
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.16.2-0-gea1b7a073390-prebuilt.qem4
RIP: 0010:remove_proc_entry+0x27a/0x290
Code: bd a0 00 00 00 e8 46 30 ee ff 49 8b 95 a0 00 00 00 4d 89 f8 4c
89 f1 48 c7 c6 40 2d b4 bc 0
RSP: 0018:ffffc90000e5f530 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 1ffff920001cbea6 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffffbaf38a18 RDI: ffffffffbe1c40a0
RBP: ffffc90000e5f5d8 R08: 0000000000000001 R09: ffffed100dad4eb9
R10: ffff88806d6a75cb R11: 0000000000000001 R12: ffff88800b086100
R13: ffff888001a20200 R14: ffff88800b0861ac R15: ffff88800b0869ac
FS:  00007f66796fe740(0000) GS:ffff88806d680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055eb5b851090 CR3: 000000000b182000 CR4: 00000000001506e0
Call Trace:
 <TASK>
 ? show_regs+0x65/0x70
 ? __warn+0xa1/0x1c0
 ? remove_proc_entry+0x27a/0x290
 ? report_bug+0x202/0x230
 ? handle_bug+0x79/0xa0
 ? exc_invalid_op+0x18/0x50
 ? asm_exc_invalid_op+0x1b/0x20
 ? preempt_count_sub+0x18/0xc0
 ? remove_proc_entry+0x27a/0x290
 ? __pfx_remove_proc_entry+0x10/0x10
 ? mtree_load+0x3b9/0x460
 unregister_irq_proc+0x16f/0x1b0
 ? __pfx_unregister_irq_proc+0x10/0x10
 ? __kmem_cache_free+0x183/0x250
 free_desc+0x92/0x160
 ? __pfx_free_desc+0x10/0x10
 ? __kasan_check_write+0x14/0x20
 ? mutex_lock+0x86/0xe0
 ? __pfx_mutex_lock+0x10/0x10
 ? __kasan_check_write+0x14/0x20
 ? mutex_unlock+0x81/0xd0
 ? __pfx_mutex_unlock+0x10/0x10
 irq_free_descs+0x4c/0x70
 irq_dispose_mapping+0x93/0x1f0
 gpio_sim_dispose_mappings+0xd9/0x140 [gpio_sim]
 ? __pfx_gpio_sim_dispose_mappings+0x10/0x10 [gpio_sim]
 ? __kmem_cache_free+0x183/0x250
 ? __pfx_gpio_sim_dispose_mappings+0x10/0x10 [gpio_sim]
 devm_action_release+0x2d/0x40
 release_nodes+0x8f/0x170
 devres_release_all+0xef/0x140
 ? __pfx_devres_release_all+0x10/0x10
 ? dev_pm_domain_detach+0x20/0x60
 device_unbind_cleanup+0x14/0xd0
 device_release_driver_internal+0x2af/0x300
 device_release_driver+0x12/0x20
 bus_remove_device+0x12d/0x180
 device_del+0x277/0x720
 ? __pfx_device_del+0x10/0x10
 ? __kasan_check_write+0x14/0x20
 platform_device_del.part.0+0x1e/0xe0
 platform_device_unregister+0x20/0x40
 gpio_sim_device_config_live_store+0x3a4/0xa10 [gpio_sim]
 ? __kasan_check_write+0x14/0x20
 ? copyin+0x40/0x60
 ? __pfx_gpio_sim_device_config_live_store+0x10/0x10 [gpio_sim]
 ? preempt_count_sub+0x18/0xc0
 ? down_read+0xc6/0x200
 ? __pfx_down_read+0x10/0x10
 ? __pfx_mutex_lock+0x10/0x10
 ? __pfx_locks_remove_posix+0x10/0x10
 ? __pfx_gpio_sim_device_config_live_store+0x10/0x10 [gpio_sim]
 configfs_write_iter+0x16a/0x1f0 [configfs]
 vfs_write+0x408/0x750
 ? __pfx_vfs_write+0x10/0x10
 ksys_write+0xd9/0x180
 ? __pfx_ksys_write+0x10/0x10
 ? debug_smp_processor_id+0x17/0x20
 __x64_sys_write+0x42/0x50
 do_syscall_64+0x43/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7f66797f21a4
Code: 15 79 7c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f
00 f3 0f 1e fa 80 3d 3d 0c 8
RSP: 002b:00007fffa35ef228 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f66797f21a4
RDX: 0000000000000002 RSI: 000055eb5b864240 RDI: 0000000000000001
RBP: 00007f66798cb5a0 R08: 0000000000000000 R09: 0000000000000000
R10: 000055eb5b864080 R11: 0000000000000202 R12: 0000000000000002
R13: 000055eb5b864240 R14: 0000000000000002 R15: 00007f66798cb7a0
 </TASK>
---[ end trace 0000000000000000 ]---

Here a GPIO device - that is also an irq chip - is unbound (this is a testing
module unbound during a test-case but it can be anything else, like an I2C
expander for which the driver is unloaded) while some users called
request_irq() on its interrupts (this is orthogonal to gpiod_get() and doesn't
take a reference to the module, so nothing is stopping us from unloading it)
and didn't call free_irq() before the device went down (they don't have to,
they can't know about the unbinding).

The irq chip disposes of all mappings held by its domain and then tears down
the domain. This looks fine from the interrupt subsystem point of view. The
mappings are gone, so there's nothing in the maple tree, when the users
eventually do call free_irq(), they look up the mapping, get a NULL and return.

KASAN doesn't report any bugs, kmemleak doesn't show any other leaks, the only
problem here seems to be the procfs leak which this patch addresses, unless I'm
missing something - my knowledge of this part is limited.

I hope it makes sense, if it does, I can resend the patch with a more detailed
message.

Bartosz

> Thanks,
>
>         tglx
>
>
>
