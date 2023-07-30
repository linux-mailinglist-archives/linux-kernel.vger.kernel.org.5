Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81E76857A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjG3NRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjG3NQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:16:54 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6818910E4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:16:52 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6bc9c98b895so854481a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690723011; x=1691327811;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOM3iSDNU6wCUEYVc/DbHhhkvbgnvTehU0cbOqHMGoI=;
        b=EOreSzEiIMRlJ8TUvWVhiZDR/2Khf6Es5hRccS5tK7uvgwODFsAZ97H4zzvk2Okx8T
         hrvgdzNThTQqJqKnRn2AF7vfo9aYUHxNn3wGYtAhk1++8ldsfEpPwz0981X3GybbMtGE
         6meLkVhE3Tys46eF+brMKC/u/3PmNr3DQsLuKMYNzFwn8b11dQWMaUDYQKhWR7bEp3CO
         glOqUdRsZN2xOA9FYep5YNX7a3PAkE/9B78mMOp5zSSgzzga+vVIN4mn3J0EeH85wIfn
         uG8ByCWauLo4R2gSXdU9FL/JvCQTa+Dxlopr+g0LC5STwCWESojV8Mvxo1Tx1KgDTH18
         fHHQ==
X-Gm-Message-State: ABy/qLad6lmO/SN5oxmVaBmYj9pnW8p/KN4X1a0MmNNvExDrsAn0zCY4
        tg+1YoN5Np8lYyNzgIHQJEbIlUpdNdkTf9Swp/gJTS9cr5dS
X-Google-Smtp-Source: APBJJlGZR1XM2cnJ2arQw8+Xfu/nKRSRyHMzmOAWJ/DJa8HNHHfmYLhVt4ebI1VLIIbO3K263WoSJ2g887dJu1SCyzCO/3yHmGuf
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3a04:b0:1bb:a2ac:15e1 with SMTP id
 du4-20020a0568703a0400b001bba2ac15e1mr9015474oab.5.1690723011384; Sun, 30 Jul
 2023 06:16:51 -0700 (PDT)
Date:   Sun, 30 Jul 2023 06:16:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081d9fe0601b42010@google.com>
Subject: [syzbot] Monthly reiserfs report (Jul 2023)
From:   syzbot <syzbot+listc57d486466055775dfcb@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello reiserfs maintainers/developers,

This is a 31-day syzbot report for the reiserfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/reiserfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 88 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13786   Yes   KASAN: null-ptr-deref Read in do_journal_end (2)
                   https://syzkaller.appspot.com/bug?extid=845cd8e5c47f2a125683
<2>  4069    Yes   possible deadlock in open_xa_dir
                   https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
<3>  2537    No    UBSAN: array-index-out-of-bounds in direntry_create_vi
                   https://syzkaller.appspot.com/bug?extid=e5bb9eb00a5a5ed2a9a2
<4>  1672    No    KASAN: slab-out-of-bounds Read in search_by_key (2)
                   https://syzkaller.appspot.com/bug?extid=b3b14fb9f8a14c5d0267
<5>  1416    Yes   kernel BUG at fs/reiserfs/journal.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6820505ae5978f4f8f2f
<6>  1210    Yes   WARNING in reiserfs_lookup
                   https://syzkaller.appspot.com/bug?extid=392ac209604cc18792e5
<7>  967     Yes   possible deadlock in mnt_want_write_file
                   https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
<8>  294     Yes   possible deadlock in reiserfs_ioctl
                   https://syzkaller.appspot.com/bug?extid=79c303ad05f4041e0dad
<9>  242     Yes   KASAN: out-of-bounds Read in leaf_paste_entries (2)
                   https://syzkaller.appspot.com/bug?extid=38b79774b6c990637f95
<10> 202     Yes   KASAN: use-after-free Read in leaf_paste_in_buffer
                   https://syzkaller.appspot.com/bug?extid=55b82aea13452e3d128f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
