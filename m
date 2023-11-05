Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FE7E1389
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 14:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjKENHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 08:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjKENHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 08:07:31 -0500
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C59CFA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 05:07:27 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d3215956a3so4608510a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 05:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699189646; x=1699794446;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vf0m/1w91K7wqWz8i917mDYQ56Coz6Ok3jfzXrbIlps=;
        b=I5+N0rSzOrhcUseDDZzgS/1EMtp1jRTp8/baBEojLK3nwSj2nXtaAcIT2rw6bY7+QC
         5HEui13KJlyc5HF3sfv/hWayQz67F4LDbBwXdTgBEiSNLELfvFGRE+nKxW9aNIobb+DD
         dVsVBV6XybRCSXXhsW9Y6DKrChie42PSmtFQxJqfhcYMuwhDznzVvp+sgliufkOO+5sf
         lKzNEpt/x6SOMKbLHT2F0K82UQskb/wpUpL2G5lN8uQ4ktp0x2Dd9p6AIxTtAkPimck2
         e+teh6oGYYEvhzuFnVhtfLVsVqKaexsGVpZySD5O/MOdNrlNVQCzcG93q9b+MoKPzuhI
         BC0w==
X-Gm-Message-State: AOJu0YzJ2YvuwUzs6OYU9uBscbZe6SrQ2I9xRgBdGPBexiL8TMyz0btI
        vE086EvxQmzixwc1R2pVSLfHDc14MbeW9D52R4ZSwCIBjx0e
X-Google-Smtp-Source: AGHT+IHR5chTSEPM/wdeHF2mkoAGBTrl226/EeUv/UNjbvsm/v7U5f4oL/wwKyQYLKuE4X3jp2Rys9DONs95tTcLfXMW4yf/nb4q
MIME-Version: 1.0
X-Received: by 2002:a9d:6f13:0:b0:6d3:1579:bd09 with SMTP id
 n19-20020a9d6f13000000b006d31579bd09mr4012112otq.6.1699189646799; Sun, 05 Nov
 2023 05:07:26 -0800 (PST)
Date:   Sun, 05 Nov 2023 05:07:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004db7b60609676b7d@google.com>
Subject: [syzbot] Monthly ntfs report (Nov 2023)
From:   syzbot <syzbot+list49093097bc63b09eea22@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ntfs maintainers/developers,

This is a 31-day syzbot report for the ntfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 26 issues are still open and 8 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4415    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  3381    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  1553    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4>  691     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<5>  408     Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<6>  311     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<7>  253     No    possible deadlock in __ntfs_clear_inode
                   https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
<8>  81      Yes   INFO: rcu detected stall in sys_mount (6)
                   https://syzkaller.appspot.com/bug?extid=ee7d095f44a683a195f8
<9>  41      Yes   kernel BUG in ntfs_iget
                   https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
<10> 36      Yes   kernel BUG in ntfs_lookup_inode_by_name
                   https://syzkaller.appspot.com/bug?extid=d532380eef771ac0034b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
