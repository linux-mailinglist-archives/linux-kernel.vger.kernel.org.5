Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93CE806B43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377390AbjLFKFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377291AbjLFKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:05:22 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFC7139
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:05:23 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb2b365ecbso6023722fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857122; x=1702461922;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghMzzdDHAkF9x2i09e7XzyXKqmjxV4hj0v4OAT6l1ig=;
        b=DcWAoBhNUavTaK9In/NF0o8RFSbz4aatBEzRG4yX9P/6paaRiX8dD56bwc5N+XDwPL
         ZTWOOyPolpLq/H6Dmiz9Qsz/5ZfC2PILb6qvrP+DG23YfsYJoLmlBYSPmwGJWfPw1ooj
         FAlAXiMDa5omIu7EXMdDgUMItawbzjn+1pSYxNzKXBi2IpvuxKyShnUhhd96saARGs2M
         zDwkRtHSaH6pV5wV4Vy2BiRCJREZXg4E9KQmvXYZp5c+aU8MRz02xDeaSBs3642wKyE5
         Ic5+/PjB7x2ve0ZChSTmb9ibkkv4I0FvXdj0D9iX1j2uy+sYuG2teOfG0/2zoh57VjQ5
         tqGg==
X-Gm-Message-State: AOJu0Yw1zRmiq5n64HdRVJt8H2zrIkhTG/shsBlhGY/ft1L7Pe9K+BTN
        zHeuPveTvma06Eu3X6L8k1x+FK6YAd3Vv16j9Xpj1Ugpxlp+
X-Google-Smtp-Source: AGHT+IESlOtfFmLQIiT46k6wZVD8jMsZ9161jVsumrSdSLaPZzFgXdNY307sZXnjMAgs2S2TVyK0VqXkTE6IYiQCv3llzlpI5WeS
MIME-Version: 1.0
X-Received: by 2002:a05:6871:3427:b0:1e5:bc65:26f2 with SMTP id
 nh39-20020a056871342700b001e5bc6526f2mr731233oac.3.1701857122625; Wed, 06 Dec
 2023 02:05:22 -0800 (PST)
Date:   Wed, 06 Dec 2023 02:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040b1a4060bd47d4b@google.com>
Subject: [syzbot] Monthly hfs report (Dec 2023)
From:   syzbot <syzbot+listd2328e1fb0c2b317ced7@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 38 issues are still open and 11 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6889    Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<2>  6601    Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<3>  4692    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  2510    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<5>  1526    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<6>  849     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<7>  711     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<8>  668     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<9>  550     Yes   general protection fault in hfs_find_init
                   https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2
<10> 540     Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
