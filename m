Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A47B806C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbjJDNOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242601AbjJDNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:13:58 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A8DD8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:13:54 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6bf0d513257so2555468a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 06:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425234; x=1697030034;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnT9mm81EGurra3sbmIkgyRkR1mbNMjC0mH42Ehxctc=;
        b=oojVTeeE0p9GWNduV23uwR4RBGERw+Rz3Hw41IfFdPsc7vJwzBFYl5v+Y5QuLQPX9t
         dcBI6Wr2+Z48+8uuIHjOcKz1yegMi/lkAyqOEJ+THubiHBU+8mVkpF4epzBQ8V7m6qZ3
         dcaewcz0X66JIZvv1km0+aNYlSfp8EGLk0o5tzHKNZz7MTfXCArjG5LJLlTEAhJwwlDu
         PqXk83Szc+gBibiMaYX924OwloDDU6GvMNMIlfJyFXFu5zHHHxfoO/h52nj5EXcgxslQ
         SQiP0A2sfAUyINDylFOXiJIdNAMhzG+2DboFnPkFBzl1c5vnjn/r0Lnsx++RZU0KsUo4
         edog==
X-Gm-Message-State: AOJu0YwC8rDSGhJjaVhJBk4cqfPir8b2NHp4mM+u9E3a2CubmXmSRMl0
        iUkh2Ri/JhTocx9SfTf1iqX1QW+cyvGNT8m1ySn+dKuh80wt
X-Google-Smtp-Source: AGHT+IGUAofh+8r+Oh0/Def6ijScSV5T+rXKZ1byN0sspuCtt3jKMjaAac5Opyu0n9CfSLMyLrKcuanu0px3GQjZ5OBYLrh7g3u7
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3a18:b0:1dd:39ce:e252 with SMTP id
 du24-20020a0568703a1800b001dd39cee252mr1011367oab.0.1696425234278; Wed, 04
 Oct 2023 06:13:54 -0700 (PDT)
Date:   Wed, 04 Oct 2023 06:13:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a31ca0606e3c7b4@google.com>
Subject: [syzbot] Monthly ntfs report (Oct 2023)
From:   syzbot <syzbot+list840e3c8e5a11b542fa0b@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ntfs maintainers/developers,

This is a 31-day syzbot report for the ntfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 24 issues are still open and 8 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4008    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  3219    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  1420    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4>  638     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<5>  396     Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<6>  232     No    possible deadlock in __ntfs_clear_inode
                   https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
<7>  37      Yes   kernel BUG in ntfs_iget
                   https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
<8>  36      Yes   kernel BUG in ntfs_lookup_inode_by_name
                   https://syzkaller.appspot.com/bug?extid=d532380eef771ac0034b
<9>  15      Yes   KASAN: use-after-free Read in ntfs_attr_find (2)
                   https://syzkaller.appspot.com/bug?extid=ef50f8eb00b54feb7ba2
<10> 13      Yes   KASAN: use-after-free Read in ntfs_lookup_inode_by_name
                   https://syzkaller.appspot.com/bug?extid=3625b78845a725e80f61

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
