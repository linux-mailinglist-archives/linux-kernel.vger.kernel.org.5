Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1BA7F3C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbjKVDRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjKVDRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:17:33 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C7B197
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:17:29 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4629eb39d67so258433137.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700623049; x=1701227849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cifHwiL86k/hSfKeSdI4QL5cIbDxkzf2iHBxnZU0xs=;
        b=ZLKszmwU6QBw1hqdNLfa5MjWBHJkGu0KsUUApsy2DKm5SfoQFttU2s5bMtSSRK0YZL
         J8wyABDzig04J2436Wj1JNbBv8SAsMxk0E9Wls/G9EECUnk9iJW5k6AR6mCITv50qGkU
         7ra3JoRKKjMYH0hxBhJ7RIdRxMPhsO4tQ3+AS/VoqDK44XFJNHhxnAoQ7g0rInIml1hy
         xuzhXZi7jY3IvwQ/NUFa3Ydftz5FFLyih1urmTJ5szDQjF5l0O7vyk1l+tgAt8p4uCNl
         kYIEYENSLCY0wKpqp/DsvVV6DN2y4J6VihdaxrYvnm8Kyb0TgoOQyhMct1wEnN9egkO+
         Acag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700623049; x=1701227849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cifHwiL86k/hSfKeSdI4QL5cIbDxkzf2iHBxnZU0xs=;
        b=QP098iJxz/x2w6cUzUI8/gFQoApEzFZFgiWAugY5aqUQRYAtgG67BrCgEun+Qc48OU
         5GzhnXq5PurDrQXQaB0L5e6t9tV1faCeEK5z0Sx6trJorg8ZMdS7LTI7OsxSSxfwh+yd
         VqfEhqvHTjL1J39oYCRBODlHSyFcejrzP+9OxevTqJFgHqxvGULc0DhmRjTc9vbLkOqq
         xRF4/37zEPg2QmSYzIbBb4WW6UXCnsIxZZN6DEVolvOB8EDlqU+nddg4yGF0UhBTnxi1
         Vm+wLVwPlWMzC/km5rMDnxho626YY7EyXV3ARYWeiiVojTfL2Cm3vqUX4vpW7FJc8ng2
         Wm/A==
X-Gm-Message-State: AOJu0YxsC94TwymfnFcs1bqvDKHz7rtRTIL+4fdvidbtyQLoc0TRFQ2s
        PvppWoS4xfTANw8DwbvKyMcRgHRnWAIYM1QEaao=
X-Google-Smtp-Source: AGHT+IHwWKCYdU4EOP3jw3UxRFra14RalBM3o+CJ2ZW9N4I1zCof+WHTL8F6RhxLhxOG7+1rGmy9X48PL2wxhdfnPcc=
X-Received: by 2002:a05:6102:47:b0:462:7c78:ba53 with SMTP id
 k7-20020a056102004700b004627c78ba53mr1343955vsp.16.1700623048669; Tue, 21 Nov
 2023 19:17:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1700502145.git.andreyknvl@google.com> <5cef104d9b842899489b4054fe8d1339a71acee0.1700502145.git.andreyknvl@google.com>
In-Reply-To: <5cef104d9b842899489b4054fe8d1339a71acee0.1700502145.git.andreyknvl@google.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Wed, 22 Nov 2023 12:17:17 +0900
Message-ID: <CAB=+i9Q95W+w=-KC5vexJuqVi60JJ1P8e-_chegiXOUjB7C3DA@mail.gmail.com>
Subject: [BISECTED] Boot hangs when SLUB_DEBUG_ON=y
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 1:08=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Evict alloc/free stack traces from the stack depot for Generic KASAN
> once they are evicted from the quaratine.
>
> For auxiliary stack traces, evict the oldest stack trace once a new one
> is saved (KASAN only keeps references to the last two).
>
> Also evict all saved stack traces on krealloc.
>
> To avoid double-evicting and mis-evicting stack traces (in case KASAN's
> metadata was corrupted), reset KASAN's per-object metadata that stores
> stack depot handles when the object is initialized and when it's evicted
> from the quarantine.
>
> Note that stack_depot_put is no-op if the handle is 0.
>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

I observed boot hangs on a few SLUB configurations.

Having other users of stackdepot might be the cause. After passing
'slub_debug=3D-' which disables SLUB debugging, it boots fine.

compiler version: gcc-11
config: https://download.kerneltesting.org/builds/2023-11-21-f121f2/.config
bisect log: https://download.kerneltesting.org/builds/2023-11-21-f121f2/bis=
ect.log.txt

[dmesg]
(gdb) lx-dmesg
[    0.000000] Linux version 6.7.0-rc1-00136-g0e8b630f3053
(hyeyoo@localhost.localdomain) (gcc (GCC) 11.3.1 20221121 (R3[
0.000000] Command line: console=3DttyS0 root=3D/dev/sda1 nokaslr
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
6.7.0-rc1-00136-g0e8b630f3053 #22
[    0.000000] RIP: 0010:setup_arch+0x500/0x2250
[    0.000000] Code: c6 09 08 00 48 89 c5 48 85 c0 0f 84 58 13 00 00
48 c1 e8 03 48 83 05 be 97 66 00 01 80 3c 18 00 0f3[    0.000000] RSP:
0000:ffffffff86007e00 EFLAGS: 00010046 ORIG_RAX: 0000000000000009
[    0.000000] RAX: 1fffffffffe40088 RBX: dffffc0000000000 RCX: 1ffffffff11=
ed630
[    0.000000] RDX: 0000000000000000 RSI: feec4698e8103000 RDI: ffffffff88f=
6b180
[    0.000000] RBP: ffffffffff200444 R08: 8000000000000163 R09: 1ffffffff11=
ed628
[    0.000000] R10: ffffffff88f7a150 R11: 0000000000000000 R12: 00000000000=
00010
[    0.000000] R13: ffffffffff200450 R14: feec4698e8102444 R15: feec4698e81=
02444
[    0.000000] FS:  0000000000000000(0000) GS:ffffffff88d5b000(0000)
knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffff200444 CR3: 0000000008f0e000 CR4: 00000000000=
000b0
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000]  ? show_regs+0x87/0xa0
[    0.000000]  ? early_fixup_exception+0x130/0x310
[    0.000000]  ? do_early_exception+0x23/0x90
[    0.000000]  ? early_idt_handler_common+0x2f/0x40
[    0.000000]  ? setup_arch+0x500/0x2250
[    0.000000]  ? __pfx_setup_arch+0x10/0x10
[    0.000000]  ? vprintk_default+0x20/0x30
[    0.000000]  ? vprintk+0x4c/0x80
[    0.000000]  ? _printk+0xba/0xf0
[    0.000000]  ? __pfx__printk+0x10/0x10
[    0.000000]  ? init_cgroup_root+0x10f/0x2f0
--Type <RET> for more, q to quit, c to continue without paging--
[    0.000000]  ? cgroup_init_early+0x1e4/0x440
[    0.000000]  ? start_kernel+0xae/0x790
[    0.000000]  ? x86_64_start_reservations+0x28/0x50
[    0.000000]  ? x86_64_start_kernel+0x10e/0x130
[    0.000000]  ? secondary_startup_64_no_verify+0x178/0x17b
[    0.000000]  </TASK>

--
Hyeonggon
