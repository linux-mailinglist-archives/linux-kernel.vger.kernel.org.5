Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825DD806B41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377374AbjLFKFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377291AbjLFKFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:05:20 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AAE109
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:05:23 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b83ce0d549so8524512b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857122; x=1702461922;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6rmjaHsgPXWG4Xuxsh1smWntvg+cByfLnqTupKT5EA=;
        b=uobLpLgFVz4WPSGLAyyYyEa+JpUtonSYK1lLnaI/Iz1+FZ2oKu+d6A/b1fRdpLUZav
         +J99KUqWKZjUAFL/G8O91mUAcM1v9Ic3KYEIH67K/+Fr2tKDk3gTJnhC8GnaPOONLvV0
         zXrNSulc3oLJ3IH0SbFKksoAGVvOowFsLp7VFf155sTfdsXQbDJEm0gCrzRq87hXw9QP
         KcWYMLbPOnf/fIsLOdcCul2VdfmuJvuqbpq+Ut1QaMJZrCJrQnlWDeR3ig/RGIV5vzQ6
         79E/bhsv0nMBUpoZ1vxMK+mJKtCACQLGpjRZJ4HnkWd3n5Ae1EMfybe1aZT2ymbbRqeX
         E3Pw==
X-Gm-Message-State: AOJu0YxyFC37Dpnxl7vXxckoDjkwJIXv2M/AtUgasIbgsfNqoxiw0Ucd
        +duPgxNeUqD7KCLLi6yy6HJ5C7iA81xhdY4N6+b04aGCbAsZ
X-Google-Smtp-Source: AGHT+IG73u+JgzydSG6pfc0jgczEhDwWz4aPcdkBudUV6970QHjN7xtw+JEz+IrDLsd54whTlMagdlmgtb8hO9I7N7PTvlbyrO1u
MIME-Version: 1.0
X-Received: by 2002:a05:6808:114e:b0:3ae:2024:838b with SMTP id
 u14-20020a056808114e00b003ae2024838bmr685858oiu.1.1701857122422; Wed, 06 Dec
 2023 02:05:22 -0800 (PST)
Date:   Wed, 06 Dec 2023 02:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d94fe060bd47d29@google.com>
Subject: [syzbot] Monthly btrfs report (Dec 2023)
From:   syzbot <syzbot+lista883a5310150c3e9bc11@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 3 new issues were detected and 4 were fixed.
In total, 46 issues are still open and 47 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5725    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  1888    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  373     Yes   WARNING in btrfs_block_rsv_release
                   https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
<4>  295     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<5>  222     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<6>  221     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  209     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
<8>  109     Yes   general protection fault in btrfs_orphan_cleanup
                   https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
<9>  100     Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
<10> 86      Yes   kernel BUG in btrfs_free_tree_block
                   https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
