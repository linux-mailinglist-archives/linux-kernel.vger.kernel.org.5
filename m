Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F467E86DC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344717AbjKKAUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjKKAUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:20:08 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8398C4212
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:20:05 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45dadc5bf51so1155013137.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699662004; x=1700266804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiLyu8Jad+xuEzlGvDNOLZJnruEW/vsNXZTwPbmXtIA=;
        b=cmjYZPk+AXZKHEuNf+jPHe8yM4OpgYe58ND6BXRkXgE4tQSoIPVsyReIGlxIWvMejO
         w/ILgTqcgYUaamt5+ZQCpBW5j4FNGs4q3RCYZvSWPurMqLOv4KvuKahwEXqxxp4+33Rb
         L6p+kgtntoY6D1+AJXAHk2C8Bx2ugx9FjMjR2P+gB/QDW+2uDueB+xRNLaPzDPeACAKE
         4xYzDZnQKxva6LlqcdvUsBbXqYDX+DFl8WJGc+v49ycjrzRIfyTnw0Ju++5HhJd9ZPDU
         eFNu48PTedjTM+oImxVBX5wuKD2m9uN/47IzsYkEW5s8NLtrRaZOBUc929sgYaSKM2OO
         EUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699662004; x=1700266804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiLyu8Jad+xuEzlGvDNOLZJnruEW/vsNXZTwPbmXtIA=;
        b=bFRZ1RLdRKhg8QdfHJxsseDlZVhpqeLGO/0B3vf8n+ww6OeLyMWxoa+UqoH/yc6paQ
         L1JEd/p+Iv6xDptQjZkF4IPnr2FnIN3GHQ4K5EuOtO31bhJ9UKuaIsxWZOuOBAu3H0GY
         85MWYRmjwuW+zOxlAk0epWBkBPKon1UlpsIcaRJpywrQIp3Z06QB4IgqlyDNm8Xm+ibu
         Fq1fzeWWgOi5ODzj1Irl4Pk7eQrr+wAUlSXDCgTHx7oh1demnYsAYcxXbjYBDdmeRQ9S
         cYATMaVId4sPXfe9KPClDSADeI9IGCmq7r2EohUMjRuxu8QFvDZc6W3PO0ZO0499SNC7
         TZBA==
X-Gm-Message-State: AOJu0Yx4YM9FgjpCYihHTKgurIH1Q2AI3mXTpBTGKegk/QlKd+pg/TJJ
        m7UWBrJH3kuCKnqOaxsjTkqWFp5n0TRMcUlhNbA=
X-Google-Smtp-Source: AGHT+IEJjDviy7RflK9oVh4TAx9wToxuF5Hht08onsebFhZvg/X8xZVsbGSGIX9hjcY7M2ctA5V9gjzrq1REwZJCNFY=
X-Received: by 2002:a05:6102:209e:b0:461:da:544 with SMTP id
 h30-20020a056102209e00b0046100da0544mr78194vsr.15.1699662004494; Fri, 10 Nov
 2023 16:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20230425222446.170486-1-jim.cromie@gmail.com> <ZEwBcOdV1br94T5N@arm.com>
In-Reply-To: <ZEwBcOdV1br94T5N@arm.com>
From:   jim.cromie@gmail.com
Date:   Fri, 10 Nov 2023 17:19:38 -0700
Message-ID: <CAJfuBxwdrL=4nKntHF69PkJ=tzHvECh4Ro6EFZamtwJgnN_SKQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] kmemleak report format changes
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 11:25=E2=80=AFAM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Tue, Apr 25, 2023 at 04:24:43PM -0600, Jim Cromie wrote:
> > If format changes are not /sys/** ABI violating, heres 3 minor ones:
> >
> > 1st strips "age <increasing>" from output.  This makes the output
> > idempotent; unchanging until a new leak is reported.
> >
> > 2nd adds the backtrace.checksum to the "backtrace:" line.  This lets a
> > user see repeats without actually reading the whole backtrace.  So now
> > the backtrace line looks like this:
> >
> >   backtrace (ck 603070071):  # also see below
> >
> > Q: should ck be spelled crc ? it feels more communicative.
>
> These all would make sense (and 'crc' sounds better) if they were done
> from the start. I know there are test scripts out there parsing the
> kmemleak sysfs file. I can't tell whether these changes would break
> them.
>
> Cc'ing Dmitry, I think syzbot was regularly checking kmemleak (not sure
> it still does).
>

I took a look at syzkaller repo, found kmemleak parsing in
executor/common_linux.h
in static void check_leaks(char** frames, int nframes)

this parse just counts occurrences of "unreferenced object",
it does not expect to find "age" nor would it (apparently) choke on
"crc" being added.


There are also a few kmemleak refs in several github repos
3 have updates since 2020.

perf-monitor  has 2 forks, both have the same minor compile
warning-turned-error.
umemleak makes mention of kmemleak, but it has no code, just a readme.

QED: there are no kmemleak parsers in public github repos that would
break with these changes

While there may be parsers on the dark-web,
ISTM none could be relying upon "age" in any meaningful way.
and none are likely to choke because "(crc: <foo>)"
was added to the stack trace display.

If these patches spend some time in purgatory (in linux-next or
linux-eventually)
perhaps the remaining risks can be discounted ?








> > NB: with ck exposed, it becomes possible to do a "selective clear",
> > something like:
> >
> >   echo drop 603070071 > /sys/kernel/debug/kmemleak
> >
> > The 3rd patch takes __init off of kmemleak_test_init().  This fixes a
> > bare-pointer in the 2nd line of the backtrace below, which previously
> > looked like:
> >
> >     [<00000000ef738764>] 0xffffffffc02350a2
> >
> > NB: this happens still/again, after rmmod kmemleak-test.
> >
> > unreferenced object 0xffff888005d9ca40 (size 32):
> >   comm "modprobe", pid 412, jiffies 4294703300
> >   hex dump (first 32 bytes):
> >     00 cd d9 05 80 88 ff ff 40 cf d9 05 80 88 ff ff  ........@.......
> >     14 a7 c4 f6 7d f9 87 10 00 00 00 00 00 00 00 00  ....}...........
> >   backtrace (ck 1354775490):
> >     [<000000002c474f61>] kmalloc_trace+0x26/0x90
> >     [<00000000b26599c1>] kmemleak_test_init+0x58/0x2d0 [kmemleak_test]
> >     [<0000000044d13990>] do_one_initcall+0x43/0x210
> >     [<00000000131bc505>] do_init_module+0x4a/0x210
> >     [<00000000b2902890>] __do_sys_finit_module+0x93/0xf0
> >     [<00000000673fdce2>] do_syscall_64+0x34/0x80
> >     [<00000000357a2d80>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> --
> Catalin
