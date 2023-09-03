Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7446F790DC7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbjICTgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjICTgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:36:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3433494;
        Sun,  3 Sep 2023 12:36:37 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-565e387000fso546895a12.2;
        Sun, 03 Sep 2023 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693769796; x=1694374596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMEaTvKTdDHAf4IJHbgYJXOOgkTV7S3eq652Wg9xVeI=;
        b=okkDaECY7hh9COeuL/GFRst5HQx7NzReMKsIHUquDEx0O/I6fnzXCNP9goDfD1zMdd
         65TdIvAFGBtOZqrJOuv+D5bZHzA9FvozhTf/XOj2CbWyHjs+kIwnMWF5xLAYdJh19flU
         55SV/XhtDy0YHhIjqzE6cugmMpZMbSDqIIWmSyP+FVZMQMjtSxvHUhXwP+r7Xos88EcI
         U/8dAMjMCkBY6cVdBGx+peV8YJSdYSVksIUlZfidYCrd6MBIS5fWddiNaSeDYxsp26tY
         JWRrp+KU+xZ6VAULlAxMpC+8B1LyCVKZSPzRKn+n+U33W92au2LemlnaGas53PMxPqD3
         0eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693769796; x=1694374596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMEaTvKTdDHAf4IJHbgYJXOOgkTV7S3eq652Wg9xVeI=;
        b=k+hkM3unRWkr0EzyqQhx9B7vnVj9ndtGh4mY8LGYtKmYsQCDou/T7Qkrax1MBFqzVo
         paN7MrJLpXELZ097nJffaaMmTCWunYBLMomBkmt1WwDOZYyBVP+/ACW0GFubxgmCin61
         egFsOenc+a96+2SycmKMFFGqzRMCRwk3oaoSoWnHIKpuQxI0tfRl3970OQxWUF/xzcyI
         yF3Tja+QZ5x3fN0kQe59HcKimkz8Ed3oid9ZW5EH7gkHSxQ12RofgIB2Fy3bX1qzMV1U
         0xGOUwuMPTu86vIuj9wc1JwUv0kHEWJ53Qyg+dBlCal1diEm4dSiZWnA1aCx0MrJaCOK
         2JVA==
X-Gm-Message-State: AOJu0YzR1pOuoHb+qnOWraz/XerPDQPPdWnQdckeVRmiIiotZaNx6PKb
        cZgo4v7sxxPnnRT+VwNcC4A=
X-Google-Smtp-Source: AGHT+IEB7A/E1IPBTNVWipyTO7T8cTi7DKLHlxC2R7cYmhZL8QIZdL1FRDRhtfGvTs2b71N0zSNa6Q==
X-Received: by 2002:a17:90a:c283:b0:26d:1d0:4f8c with SMTP id f3-20020a17090ac28300b0026d01d04f8cmr7857027pjt.9.1693769796471;
        Sun, 03 Sep 2023 12:36:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b00268b439a0cbsm6155467pjb.23.2023.09.03.12.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 12:36:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 3 Sep 2023 12:36:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Helge Deller <deller@gmx.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] lockdep: Fix static memory detection even more
Message-ID: <b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net>
References: <ZNep5EcYskP9HtGD@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNep5EcYskP9HtGD@p100>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 12, 2023 at 05:48:52PM +0200, Helge Deller wrote:
> On the parisc architecture, lockdep reports for all static objects which
> are in the __initdata section (e.g. "setup_done" in devtmpfs,
> "kthreadd_done" in init/main.c) this warning:
> 
> 	INFO: trying to register non-static key.
> 
> The warning itself is wrong, because those objects are in the __initdata
> section, but the section itself is on parisc outside of range from
> _stext to _end, which is why the static_obj() functions returns a wrong
> answer.
> 
> While fixing this issue, I noticed that the whole existing check can
> be simplified a lot.
> Instead of checking against the _stext and _end symbols (which include
> code areas too) just check for the .data and .bss segments (since we check a
> data object). This can be done with the existing is_kernel_core_data()
> macro.
> 
> In addition objects in the __initdata section can be checked with
> init_section_contains().
> 
> This partly reverts and simplifies commit bac59d18c701 ("x86/setup: Fix static
> memory detection").
> 
> Tested on x86-64 and parisc.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: bac59d18c701 ("x86/setup: Fix static memory detection")

On loongarch, this patch results in the following backtrace.

EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
EFI stub: Exiting boot services
[    0.000000] INFO: trying to register non-static key.
[    0.000000] The code is fine but needs lockdep annotation, or maybe
[    0.000000] you didn't initialize this object before use?
[    0.000000] turning off the locking correctness validator.
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0+ #1
[    0.000000] Stack : 0000000000000000 0000000000000000 9000000000223d6c 9000000001df0000
[    0.000000]         9000000001df39a0 9000000001df39a8 0000000000000000 0000000000000000
[    0.000000]         9000000001df39a8 0000000000000001 0000000000000000 900000000154b910
[    0.000000]         fffffffffffffffe 9000000001df39a8 0000000000000000 0000000000000000
[    0.000000]         0000000000000001 0000000000000003 0000000000000010 0000000000000030
[    0.000000]         0000000000000063 0000000000000001 0000000000000000 0000000000000000
[    0.000000]         0000000000000000 0000000000000000 9000000001c60650 9000000001e12000
[    0.000000]         0000000000000000 9000000001560bc0 0000000000000000 9000000002ee6000
[    0.000000]         0000000000000000 0000000000000000 9000000000223d84 0000000000000000
[    0.000000]         00000000000000b0 0000000000000004 0000000000000000 0000000000000800
[    0.000000]         ...
[    0.000000] Call Trace:
[    0.000000] [<9000000000223d84>] show_stack+0x5c/0x180
[    0.000000] [<900000000153e0b4>] dump_stack_lvl+0x88/0xd0
[    0.000000] [<90000000002bc548>] register_lock_class+0x768/0x770
[    0.000000] [<90000000002bc710>] __lock_acquire+0xb0/0x2a18
[    0.000000] [<90000000002bba1c>] lock_acquire+0x11c/0x328
[    0.000000] [<9000000000b34a60>] __debug_object_init+0x60/0x244
[    0.000000] [<9000000000337f94>] init_cgroup_housekeeping+0xe8/0x144
[    0.000000] [<900000000033e364>] init_cgroup_root+0x38/0xa0
[    0.000000] [<90000000017801ac>] cgroup_init_early+0x44/0x16c
[    0.000000] [<9000000001770758>] start_kernel+0x50/0x624
[    0.000000] [<90000000015410b4>] kernel_entry+0xb4/0xc4

Reverting it fixes the problem. Bisect log attached.

This is also seen in v6.5.y and v6.4.y since the patch has been applied
to those branches.

Guenter

---
# bad: [99d99825fc075fd24b60cc9cf0fb1e20b9c16b0f] Merge tag 'nfs-for-6.6-1' of git://git.linux-nfs.org/projects/anna/linux-nfs
# good: [1c59d383390f970b891b503b7f79b63a02db2ec5] Merge tag 'linux-kselftest-nolibc-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect start '99d99825fc07' '1c59d383390f'
# bad: [53ea7f624fb91074c2f9458832ed74975ee5d64c] Merge tag 'xfs-6.6-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect bad 53ea7f624fb91074c2f9458832ed74975ee5d64c
# good: [aa05346dad4b37d068cf9144f0a1236757816886] Merge branch 'iep-drver-timestamping-support'
git bisect good aa05346dad4b37d068cf9144f0a1236757816886
# good: [651a00bc56403161351090a9d7ddbd7095975324] Merge tag 'slab-for-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
git bisect good 651a00bc56403161351090a9d7ddbd7095975324
# good: [b96a3e9142fdf346b05b20e867b4f0dfca119e96] Merge tag 'mm-stable-2023-08-28-18-26' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good b96a3e9142fdf346b05b20e867b4f0dfca119e96
# bad: [3d3dfeb3aec7b612d266d500c82054f1fded4980] Merge tag 'for-6.6/block-2023-08-28' of git://git.kernel.dk/linux
git bisect bad 3d3dfeb3aec7b612d266d500c82054f1fded4980
# bad: [c1b7fcf3f6d94c2c3528bf77054bf174a5ef63d7] Merge tag 'for-6.6/io_uring-2023-08-28' of git://git.kernel.dk/linux
git bisect bad c1b7fcf3f6d94c2c3528bf77054bf174a5ef63d7
# bad: [dce8f8ed1de1d9d6d27c5ccd202ce4ec163b100c] document while_each_thread(), change first_tid() to use for_each_thread()
git bisect bad dce8f8ed1de1d9d6d27c5ccd202ce4ec163b100c
# good: [02d7f74a04b1299ab2a0a9095f0e2d5aa3aed553] lib/bch.c: use bitrev instead of internal logic
git bisect good 02d7f74a04b1299ab2a0a9095f0e2d5aa3aed553
# good: [79939c4a79bc643d399bd3fdd0f87100ea6b4362] scripts/gdb/slab: add slab support
git bisect good 79939c4a79bc643d399bd3fdd0f87100ea6b4362
# bad: [5ffd2c37cb7a53d52099e5ed1fd7ccbc9e358791] kill do_each_thread()
git bisect bad 5ffd2c37cb7a53d52099e5ed1fd7ccbc9e358791
# good: [665536092355f17f0e2ea291eec70f9787dccd32] lib/vsprintf: declare no_hash_pointers in sprintf.h
git bisect good 665536092355f17f0e2ea291eec70f9787dccd32
# bad: [ef815d2cba782e96b9aad9483523d474ed41c62a] treewide: drop CONFIG_EMBEDDED
git bisect bad ef815d2cba782e96b9aad9483523d474ed41c62a
# bad: [0a6b58c5cd0dfd7961e725212f0fc8dfc5d96195] lockdep: fix static memory detection even more
git bisect bad 0a6b58c5cd0dfd7961e725212f0fc8dfc5d96195
# first bad commit: [0a6b58c5cd0dfd7961e725212f0fc8dfc5d96195] lockdep: fix static memory detection even more

