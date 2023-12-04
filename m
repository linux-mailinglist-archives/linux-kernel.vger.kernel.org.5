Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57020803326
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbjLDMjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344100AbjLDMjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:39:19 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6B8114
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:39:25 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fae4875e0eso3525198fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693564; x=1702298364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSnnQNh5WsqK5z5WWJftrXTfG+C0jshNuJ+tMybyKVg=;
        b=nrdQpABjCcAKjiSR8Eluu5NCkI2fkYuz28xAMbE8IrTaOEnQww2GXy6yI5GrO9m+ct
         v1IO8ukbhgdS3h+YqpWnp65I3K9vnTHl74pVK1mduHQn365uqNUhD3zMk0Mei5caR20b
         WyVu6u8ENLQ1zFDWdWEQp/5Kn5MAnjOftbtI3KX53h2TM8xH0nXdIOxL2QvPHw8+PbhS
         yXMaduSLkGm/KCy2VoeXS7BY3Udb7vv1StNspCF+NZkdjwIO2R39kX2TyvPeB7TawVjn
         N1hpYlbi4YoULN8Cfi6WuQSOAtW4va11cqxlM9doZ1Fxae1GSbd4x8eIab4gA+xrXmJN
         4fEw==
X-Gm-Message-State: AOJu0YzKcudmH/mcM40AOVgtH+JBmAsChT1X5+pXqPI8p1S2SWj8Rcvf
        bgVP67HjufSBpkoGZ8t00CjqEXIl8WpDgIAOCcNCZ3DX1EHI
X-Google-Smtp-Source: AGHT+IHzUw5cIBVtAPz0Qy7spUe6NDHHqOfmbJm4fHrshgLhYydewJpCA6OzMMUGSSzrDLI/o5fEo1+swXo8bd5wYJGhvwsL8pv5
MIME-Version: 1.0
X-Received: by 2002:a05:6870:910f:b0:1fa:e851:720b with SMTP id
 o15-20020a056870910f00b001fae851720bmr2720878oae.8.1701693564794; Mon, 04 Dec
 2023 04:39:24 -0800 (PST)
Date:   Mon, 04 Dec 2023 04:39:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000724223060bae6880@google.com>
Subject: [syzbot] Monthly reiserfs report (Dec 2023)
From:   syzbot <syzbot+list6d707ca0e4ce5e990ff3@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
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

During the period, 5 new issues were detected and 0 were fixed.
In total, 88 issues are still open and 17 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  40685   Yes   KASAN: null-ptr-deref Read in do_journal_end (2)
                   https://syzkaller.appspot.com/bug?extid=845cd8e5c47f2a125683
<2>  6321    Yes   possible deadlock in open_xa_dir
                   https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
<3>  2995    No    KASAN: slab-out-of-bounds Read in search_by_key (2)
                   https://syzkaller.appspot.com/bug?extid=b3b14fb9f8a14c5d0267
<4>  1621    Yes   kernel BUG at fs/reiserfs/journal.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6820505ae5978f4f8f2f
<5>  1388    Yes   possible deadlock in mnt_want_write_file
                   https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
<6>  1246    Yes   WARNING in reiserfs_lookup
                   https://syzkaller.appspot.com/bug?extid=392ac209604cc18792e5
<7>  967     No    KMSAN: uninit-value in reiserfs_new_inode (2)
                   https://syzkaller.appspot.com/bug?extid=6450929faa7a97cd42d1
<8>  402     Yes   possible deadlock in reiserfs_ioctl
                   https://syzkaller.appspot.com/bug?extid=79c303ad05f4041e0dad
<9>  380     Yes   WARNING in journal_end
                   https://syzkaller.appspot.com/bug?extid=d43f346675e449548021
<10> 349     Yes   possible deadlock in reiserfs_dirty_inode
                   https://syzkaller.appspot.com/bug?extid=c319bb5b1014113a92cf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
