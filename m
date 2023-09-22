Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF30B7AB7D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjIVRj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVRjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:39:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DE399;
        Fri, 22 Sep 2023 10:39:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso42609651fa.1;
        Fri, 22 Sep 2023 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695404357; x=1696009157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e24HGdj2Uon0LsdaYdO2OIQsW2zcfDSusxrX6GljOgE=;
        b=Wp9Rh+A5ZRgOgu1Ra1BRivFRANw4tgBbYlySCAp5Mz/4aCVZrDBoSaCrcOkomvNKen
         oUgIhMM5xet/pVvLCC/hSWb69pd6ubD+b57uT9HrDFHu2P9ixOVjsspmiJmhNebFzPs9
         6Cfz6KGLGz9uw/KkyKYTxX99UVCqdaTWfV59Kx7e+Zg+qYmD54rXe2FfP96YjbkAamE2
         ifkhXAsex156cB2PkWeT9FrWrQ/Qtr0hPAeFvVU8VWXjbPyscHs7cM8t+lR10+B7FlsC
         zlsxzmM0hwyErJIH9kPTQy2vEy9TIVj1un2gqQYh98cvI9xkTMsZRki1dHPOZ7JMMp/X
         vjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404357; x=1696009157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e24HGdj2Uon0LsdaYdO2OIQsW2zcfDSusxrX6GljOgE=;
        b=PIcR5rdV1/lSud4asvHRzr5+OUZXgjVRue0gnLZ/885rzb3e6u/lL+rh1/J8ERKVW+
         6hR6EXqeqHkWQmRDTkLBKfC1F807XFjJb86renohYoqTCigXLNn9a+ai4vQdjcYZFSun
         SplKC0dC8yiuh2EjUfHTR7HLtN4Mc0onWwc7og0ZoSgyVpRJTDxIg1keOLAfxLDp9j49
         XgtqlftS0dc1LngF1W3H9WD4ZAz7SfUR1HNW9OgLeVlJGVoBWFDiHhkdzcv1OraMXOba
         ae56Xuhs/4z7UasogIvEIVa/UDwtIeAJ2xhCCbJ3xW4TRqlXY0Wwwyohe5hr3B5+HE58
         ukew==
X-Gm-Message-State: AOJu0Yx1k3mS9ydtD4s0wjR79MtH6GJnk1hrG4H93/z/mlnImq+yHL/p
        ngYetYD0V4Zn2WdtDKN7kHgh3i5ModhlyTdO9FM=
X-Google-Smtp-Source: AGHT+IH8SG+yX2k1KDUkXQPUsWefqpA9OdLqOmJgo+IZcS1F+i0I8GjxS/NnelH7uiNtfc45GXc+QSVNrkrCLZDzD38=
X-Received: by 2002:a05:6512:3148:b0:504:3c1f:cbd1 with SMTP id
 s8-20020a056512314800b005043c1fcbd1mr220785lfi.12.1695404356701; Fri, 22 Sep
 2023 10:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000090d6a00605eb5de9@google.com> <20230922102825.061c67b4418190426fdc68f2@linux-foundation.org>
In-Reply-To: <20230922102825.061c67b4418190426fdc68f2@linux-foundation.org>
From:   Nikita Bune <w1s2d5@gmail.com>
Date:   Fri, 22 Sep 2023 19:39:05 +0200
Message-ID: <CABNemfqP+=-ttkMwLWTQfoio9yQvHS+yBe6n7CJ0jBoWpF907g@mail.gmail.com>
Subject: Re: [syzbot] [mm?] linux-next test error: WARNING in page_add_anon_rmap
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+6ccbcd15a17f3e1cde38@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
7fc7222d9680


On Fri, 22 Sept 2023 at 19:28, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 21 Sep 2023 21:51:45 -0700 syzbot <syzbot+6ccbcd15a17f3e1cde38@syzkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7fc7222d9680 Add linux-next specific files for 20230918
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13acae54680000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=79253779bcbe3130
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6ccbcd15a17f3e1cde38
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/82da18e596ba/disk-7fc7222d.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/4e71084ae5e0/vmlinux-7fc7222d.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/f412e76b12e4/bzImage-7fc7222d.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+6ccbcd15a17f3e1cde38@syzkaller.appspotmail.com
> >
> >  destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
> >  debug_vm_pgtable+0x1d79/0x3df0 mm/debug_vm_pgtable.c:1408
> >  do_one_initcall+0x11c/0x640 init/main.c:1232
> >  do_initcall_level init/main.c:1294 [inline]
> >  do_initcalls init/main.c:1310 [inline]
> >  do_basic_setup init/main.c:1329 [inline]
> >  kernel_init_freeable+0x5c2/0x8f0 init/main.c:1547
> >  kernel_init+0x1c/0x2a0 init/main.c:1437
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5053 at mm/rmap.c:1252 page_add_anon_rmap+0xc33/0x1a70 mm/rmap.c:1252
>
> Thanks, this should be addressed by
> https://lkml.kernel.org/r/d8e5a093-2e22-c14b-7e64-6da280398d9f@redhat.com
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20230922102825.061c67b4418190426fdc68f2%40linux-foundation.org.
