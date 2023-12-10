Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E722780BA12
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjLJKFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjLJKFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:05:17 -0500
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307C1115
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 02:05:23 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d8770b512dso3747453a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 02:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702202722; x=1702807522;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKXFc2v7t4kCPe8Iesh8qQND7OzFTIcop0B/KSdXasE=;
        b=eFByWxQpk6NV8WqOoLLC0rJiV9GSn5ERqaiPHduuw4q/bM4++nOOMp0gtYkox1rBo9
         B90og917l0truDWwwCIK6jud5gsBipjua6gL34jToSh9Bi21gHv141Wm3WStn0O/DV80
         7W0LxOEM96HAhpHSZYFyA8BIbUmUnO9VSaU5ZoIWBmmcjtO8X6nCtXvbvZIAUr6LaALl
         pVT9ayXFgX4j8MUaQSuN2QD+34XwUtxfSgtZVh+sF+NgLVAQ+Zs566Q3aVACTeI9zqlI
         FPB23h1gFjUJrU1nriwoPo4kdrrqTIoDFewN2fjb+1J7ww+JQXUd5Kib1vlJi+lMMP3q
         E8pw==
X-Gm-Message-State: AOJu0YzpfrTOajxOs4kg8wNBNrZRags2zSCkpSo7wU/3WT8uUp4LBAqn
        YYuA9tgJ1vJAdtl5wZL7+hf08od9IiNC2r9jWggqhsbGQY3O
X-Google-Smtp-Source: AGHT+IF3qDImtqdycyGXN44w/tJpzNdjGEYlzQeJZKDWqiMw1vFKoS5HQnUnTIZ/28zH/2VGVNvWbF/e0jMYVfkJJJfj3oBV+Py7
MIME-Version: 1.0
X-Received: by 2002:a05:6870:96a1:b0:1e1:2ebc:b636 with SMTP id
 o33-20020a05687096a100b001e12ebcb636mr3312255oaq.4.1702202722216; Sun, 10 Dec
 2023 02:05:22 -0800 (PST)
Date:   Sun, 10 Dec 2023 02:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097ef5d060c24f422@google.com>
Subject: [syzbot] Monthly ext4 report (Dec 2023)
From:   syzbot <syzbot+list52026f6b95687b491ce2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 8 new issues were detected and 0 were fixed.
In total, 61 issues are still open and 115 have been fixed so far.
There are also 2 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  51616   Yes   possible deadlock in console_flush_all (2)
                   https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
<2>  6748    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<3>  546     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<4>  247     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<5>  152     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<6>  115     Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<7>  47      No    KASAN: slab-use-after-free Read in check_igot_inode
                   https://syzkaller.appspot.com/bug?extid=741810aea4ac24243b2f
<8>  32      Yes   kernel BUG in ext4_write_inline_data_end
                   https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
<9>  16      Yes   possible deadlock in ext4_xattr_inode_iget (2)
                   https://syzkaller.appspot.com/bug?extid=352d78bd60c8e9d6ecdc
<10> 13      Yes   kernel BUG in ext4_enable_quotas
                   https://syzkaller.appspot.com/bug?extid=693985588d7a5e439483

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
