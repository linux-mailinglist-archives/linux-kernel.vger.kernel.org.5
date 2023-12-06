Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74492806B42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377382AbjLFKFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377346AbjLFKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:05:21 -0500
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED47112
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:05:24 -0800 (PST)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58d5bb052dfso8660047eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857124; x=1702461924;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBFRPreUwMTljyUE1zzowalqFoa0Lex9TFFc13yJQwo=;
        b=NW2dGqmKjvuxymxmjR+OPahpfknqhaY5YTaLRuArq4Fe8rk+p1Fpm6quvdone0V3Li
         hEwQMV6PcGH17anW9k9EPKLzqd/9Dm2n0BI8dNdM1YV5cqDPjvnGglFfyVCGUdLv85ei
         YMtRP1+wAXCqKRBQz0QSNL+JRAe/ucHkWPIj//G9iN+tTVVQpld5w4Hy2J0zjHvjWmiB
         uTozHXWz3+ZUrbBJvNGUmwZmQNnq2ASxSVY8jEhkIaUqngBwypzJeWRRMmEWGI+hF16L
         OAbFzw4pqNExoUZPio+YKtjEaqvkKc3liFlsmCC2aUPH/pMXzsmEhsJzoNA/1TJ92sUA
         E9fw==
X-Gm-Message-State: AOJu0YztgAN79Z1BLg41MEks63qBr2+NJ26g8VT+L8q51MxHNRzX5t1q
        ji6zG8NRYFpR6wAwCqatpYVXo5yp5cXfM9G1KxnQyOIp9/BA
X-Google-Smtp-Source: AGHT+IGSWLFljIvDvOEMbKsUJgYM/g5+b6ijwkBwucrAIBsfqIfwMDBh/3kYSUtW9n1PAeDZFnbLK7qCfSBEQM7Lu0b0A52zv96w
MIME-Version: 1.0
X-Received: by 2002:a05:6870:158f:b0:1fa:f20e:4c0 with SMTP id
 j15-20020a056870158f00b001faf20e04c0mr778975oab.6.1701857122962; Wed, 06 Dec
 2023 02:05:22 -0800 (PST)
Date:   Wed, 06 Dec 2023 02:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045d4c4060bd47dc6@google.com>
Subject: [syzbot] Monthly ntfs report (Dec 2023)
From:   syzbot <syzbot+list46ee6100e7a589a627ec@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ntfs maintainers/developers,

This is a 31-day syzbot report for the ntfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 25 issues are still open and 8 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4839    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  3503    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  1691    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4>  763     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<5>  416     Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<6>  312     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<7>  290     No    possible deadlock in __ntfs_clear_inode
                   https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
<8>  55      Yes   kernel BUG in ntfs_iget
                   https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
<9>  39      Yes   kernel BUG in ntfs_lookup_inode_by_name
                   https://syzkaller.appspot.com/bug?extid=d532380eef771ac0034b
<10> 19      Yes   KASAN: use-after-free Read in ntfs_attr_find (2)
                   https://syzkaller.appspot.com/bug?extid=ef50f8eb00b54feb7ba2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
