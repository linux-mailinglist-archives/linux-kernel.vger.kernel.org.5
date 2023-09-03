Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7472790A7A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 03:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjICBfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 21:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjICBfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 21:35:01 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14946F0;
        Sat,  2 Sep 2023 18:34:58 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bcac140aaaso318817a34.2;
        Sat, 02 Sep 2023 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693704897; x=1694309697; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpf5yFQzTKbtGPhibmbGyhNV72VtnMYQrDv0oFg7g8c=;
        b=m2aM7aQSNY3FNhR+a2MLKWFiY+cU/zwkKdZpAhw01nZ9nUMihgCHtkbCagD2AVSDPR
         Vc0L16xIh9gSUH9E/Ur/Qn/IHLFU79KrLfhbx4v56neoi+sEXlfC6dAMDkB0Skl6idSN
         ONDZI8xhuOOnxeiSxKSc5crPwwA3/ECi/60Qj4J9ofopRFHuknhJn2GvqJ6IRTmOk9lk
         VYRZR3LfZSBOexKRpG+a/OodSeLo5beGaKwT+CKXI12EHrITSVzC9jH/ABgvqfkUJg5t
         6lMWeC05KU++B4N2weN+PrlNVdYmq6uPuhVmZaTKRSRW68qf/wFyNcX5P/QT3E5ZiGpD
         D7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693704897; x=1694309697;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vpf5yFQzTKbtGPhibmbGyhNV72VtnMYQrDv0oFg7g8c=;
        b=S9nGDZHEodu5ZFy8S1NWGhyT4q8nEVlac5KNThIHNwhoZ2o9R1AYO0oSxpEXFyVacg
         kKui2YWeZJnIo49wIA3KTI7kCE5PbS1resQ4QJJmLZpORIrk2zAx/rcHmmOJ+Rj1H0m4
         lhpGbTymAJgmbJpmIOaLA4VVYUG9wKEDO30LFJXdXocVfvNwaRDQ4Sdug4rYpDANxDmi
         o+R1QLfyzflo+rarXAHRBVjx57mnI9a7c2KDiif08/UCfOrn2zRFvgjJNNgbp+hf2nRj
         1FBEL6cKgInNmwlZ3SOKzb6oKvuexxJmr/Nld2w3qfhC1SE0klna+29Ju8Atkqr/e7YF
         nRSg==
X-Gm-Message-State: AOJu0YyOegIYG2OB/ZXqtro9LuBgQjKNPxJrN6QojHZbrzKvJxWJ3yHO
        NE+vHxxrYHYM8vggBC0QIZhvbdCUMA0=
X-Google-Smtp-Source: AGHT+IHzoOaQmG3vl2K1g15/1pexbfNCZIRZfA8822XtO9t3wr2uQenHmvz9Q0d8NMNXhVXiVmYltg==
X-Received: by 2002:a05:6808:bc3:b0:3a7:3100:f8b9 with SMTP id o3-20020a0568080bc300b003a73100f8b9mr9340225oik.31.1693704897230;
        Sat, 02 Sep 2023 18:34:57 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001bee782a1desm5149376plg.181.2023.09.02.18.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 18:34:56 -0700 (PDT)
Message-ID: <0e6fc43f-3078-911a-e63d-290c3e6d7b91@gmail.com>
Date:   Sun, 3 Sep 2023 08:34:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ziwei Dai <ziwei.dai@unisoc.com>,
        Hugh Dickins <hughd@google.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RCU <rcu@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I've just made the transition from 6.4.14 to 6.5.1 and my Haswell-EP X99 machine took way longer to boot (55 seconds instead of 16 seconds). The following trace was seen in dmesg which was also not present on 6.4.14 (and might be the cause for the long boot time); this is on bare metal.
> 
> [  +0,000021] CPU: 13 PID: 338 Comm: kworker/13:1 Not tainted 6.5.1-3.1-cachyos-lto #1 c414458bd5e5db6e6f9addca639c3a78811b24e7
> [  +0,000003] Hardware name: LENOVO GAMING TF/X99-TF Gaming, BIOS CX99DE26 10/10/2020
> [  +0,000002] Workqueue: events kfree_rcu_work
> [  +0,000004] RIP: 0010:kvfree_rcu_bulk+0x13b/0x160
> [  +0,000004] Code: 80 04 00 00 80 bf 89 04 00 00 00 75 24 85 c0 75 20 31 f6 ba 02 00 00 00 e8 72 50 bd ff 5b 41 5c 41 5e 41 5f 5d e9 05 df ba ff <0f> 0b e9 54 ff ff ff a9 ff ff ff 7f 74 e5 80 bf 88 04 00 00 >
> [  +0,000002] RSP: 0018:ffff8fe4611cbd90 EFLAGS: 00010206
> [  +0,000002] RAX: 0000000000000048 RBX: ffff8fe8e04f7000 RCX: fffffffffffffffc
> [  +0,000002] RDX: 0000000000000000 RSI: ffff8fe8e04f7000 RDI: ffff8fe9df95cac8
> [  +0,000001] RBP: ffff8fe4611cbe40 R08: 8080808080808080 R09: fefefefefefefeff
> [  +0,000002] R10: 000073746e657665 R11: 8080000000000000 R12: 0000000000000000
> [  +0,000001] R13: ffff8fe4611cbde0 R14: ffff8fe9df95cac8 R15: ffff8fe4611cbdd0
> [  +0,000001] FS:  0000000000000000(0000) GS:ffff8fe9df940000(0000) knlGS:0000000000000000
> [  +0,000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0,000002] CR2: 00007f8287bff008 CR3: 00000005e8f73001 CR4: 00000000001706e0
> [  +0,000001] Call Trace:
> [  +0,000003]  <TASK>
> [  +0,000001]  ? __warn+0x9e/0x160
> [  +0,000004]  ? kvfree_rcu_bulk+0x13b/0x160
> [  +0,000004]  ? report_bug+0x112/0x180
> [  +0,000003]  ? handle_bug+0x3d/0x80
> [  +0,000003]  ? exc_invalid_op+0x16/0x40
> [  +0,000003]  ? asm_exc_invalid_op+0x16/0x20
> [  +0,000005]  ? kvfree_rcu_bulk+0x13b/0x160
> [  +0,000003]  kfree_rcu_work+0xcd/0x200
> [  +0,000005]  process_one_work+0x21a/0x620
> [  +0,000004]  ? wake_up_process+0x1d3/0x1720
> [  +0,000004]  worker_thread+0x12b/0x4c0
> [  +0,000003]  ? compat_get_bitmap+0xa0/0xa0
> [  +0,000003]  kthread+0xf1/0x160
> [  +0,000004]  ? getreg32+0x1e0/0x1e0
> [  +0,000003]  ret_from_fork+0x30/0x40
> [  +0,000005]  ? getreg32+0x1e0/0x1e0
> [  +0,000003]  ret_from_fork_asm+0x11/0x20
> [  +0,000005]  </TASK>
> [  +0,000001] ---[ end trace 0000000000000000 ]---

Later, the reporter came up with another trace:

> I just saw a patch from Hugh Dickins on the LKML (https://www.spinics.net/lists/kernel/msg4919906.html) and indeed, with my self-compiled 6.5.1 Kernel, the trace is now downgraded to a warning (see below). However, the slow boot still remains and also my games won't load up due to missing a rendering device. But that might be a different issue.
> 
> 
> [  +0,000227] ------------[ cut here ]------------
> [  +0,000002] WARNING: CPU: 21 PID: 345 at kernel/rcu/tree.c:2952 kvfree_rcu_bulk+0x13b/0x160
> [  +0,000011] Modules linked in: pkcs8_key_parser crypto_user fuse loop zram bpf_preload ip_tables x_tables ext4 crc32c_generic mbcache crc16 jbd2 usbhid amdgpu mfd_core drm_buddy drm_suballoc_helper crc32c_i>
> [  +0,000027] CPU: 21 PID: 345 Comm: kworker/21:1 Not tainted 6.5.1-3.1-cachyos-lto #1 de6495663682da00bbe0d80bdc163dd768b25681
> [  +0,000004] Hardware name: LENOVO GAMING TF/X99-TF Gaming, BIOS CX99DE26 10/10/2020
> [  +0,000002] Workqueue: events kfree_rcu_work
> [  +0,000006] RIP: 0010:kvfree_rcu_bulk+0x13b/0x160
> [  +0,000006] Code: 80 04 00 00 80 bf 89 04 00 00 00 75 24 85 c0 75 20 31 f6 ba 02 00 00 00 e8 52 50 bd ff 5b 41 5c 41 5e 41 5f 5d e9 e5 de ba ff <0f> 0b e9 54 ff ff ff a9 ff ff ff 7f 74 e5 80 bf 88 04 00 00 >
> [  +0,000003] RSP: 0018:ffff8df57a5ffd90 EFLAGS: 00010206
> [  +0,000003] RAX: 0000000000000020 RBX: ffff8df44cb40000 RCX: fffffffffffffffc
> [  +0,000003] RDX: 0000000000000000 RSI: ffff8df44cb40000 RDI: ffff8df91fb5cac8
> [  +0,000002] RBP: ffff8df57a5ffe40 R08: 8080808080808080 R09: fefefefefefefeff
> [  +0,000002] R10: 000073746e657665 R11: 8080000000000000 R12: 0000000000000000
> [  +0,000002] R13: ffff8df57a5ffde0 R14: ffff8df91fb5cac8 R15: ffff8df57a5ffdd0
> [  +0,000002] FS:  0000000000000000(0000) GS:ffff8df91fb40000(0000) knlGS:0000000000000000
> [  +0,000003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0,000002] CR2: 000055fe51d3f700 CR3: 000000065de7d002 CR4: 00000000001706e0
> [  +0,000002] Call Trace:
> [  +0,000003]  <TASK>
> [  +0,000002]  ? __warn+0x9e/0x160
> [  +0,000006]  ? kvfree_rcu_bulk+0x13b/0x160
> [  +0,000005]  ? report_bug+0x112/0x180
> [  +0,000005]  ? handle_bug+0x3d/0x80
> [  +0,000005]  ? exc_invalid_op+0x16/0x40
> [  +0,000003]  ? asm_exc_invalid_op+0x16/0x20
> [  +0,000007]  ? kvfree_rcu_bulk+0x13b/0x160
> [  +0,000006]  kfree_rcu_work+0xcd/0x200
> [  +0,000006]  process_one_work+0x21a/0x620
> [  +0,000006]  ? wake_up_process+0x1d3/0x1720
> [  +0,000005]  worker_thread+0x12b/0x4c0
> [  +0,000005]  ? compat_get_bitmap+0xa0/0xa0
> [  +0,000004]  kthread+0xf1/0x160
> [  +0,000006]  ? getreg32+0x1e0/0x1e0
> [  +0,000004]  ret_from_fork+0x30/0x40
> [  +0,000007]  ? getreg32+0x1e0/0x1e0
> [  +0,000003]  ret_from_fork_asm+0x11/0x20
> [  +0,000009]  </TASK>
> [  +0,000001] ---[ end trace 0000000000000000 ]---

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217864

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217864

-- 
An old man doll... just what I always wanted! - Clara
