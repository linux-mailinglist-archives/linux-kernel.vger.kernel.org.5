Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A37E0051
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjKCKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKCKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:22:28 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2941BD51
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 03:22:22 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b56bf3d7a9so2853616b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 03:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699006941; x=1699611741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vW0KEqPNNJIso/cnw+xQDqj8FClModaPNPhY7C7BkL4=;
        b=oS2oNEktxCoTrYHO0fKwrfoBBVFRFPMTgZrjblH0HaWCwLQuLgXCT1UFSZ0bYWzM8U
         aSyYrJR0rkCjXl3Fl0YER9iqXgjE8aIhcN8amEeyajsA7v5i7VnKMizhCrMPZuaS1Wvs
         Oq6WKp8biUP8z8JddtjIBrT217CQ8y/EF11iZ++MHN+0D0UF6Uw9tYQPSNF0ElWDzJ5M
         iS9YDhpcvxJWHKrBxsVHRcewIlwHou4VFpQ7bsY1Edd8XGxij1Xi4vqyxV/f0tr9J0yl
         R2aX1x3qgPFx+ZYq+X9ClD15coBxCbeF9j1nWb0ZJFBn7gn7Vl+kTor52miswF5nb3uq
         jjQw==
X-Gm-Message-State: AOJu0YznexiDgBdiYIzeGk26GfMyC/LYFnT695r0ar3C1M7JC1dyGUd4
        9/XK7UYWVijhKKOxVY81+4iMFHNJFDrQuosjMn9HhbzlLMIs
X-Google-Smtp-Source: AGHT+IFZK2q6ypq/7RXSMlSaODwy1MIDOUy9zPLACOry0IqFLPjPG9pbj1TDx0sReOPaILHlmM4QOl+/9XSQ6RSEaINVNXWS+TnX
MIME-Version: 1.0
X-Received: by 2002:a05:6808:128a:b0:3ae:5aab:a6f3 with SMTP id
 a10-20020a056808128a00b003ae5aaba6f3mr7785282oiw.5.1699006941543; Fri, 03 Nov
 2023 03:22:21 -0700 (PDT)
Date:   Fri, 03 Nov 2023 03:22:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038c4fa06093ce1d0@google.com>
Subject: [syzbot] Monthly jfs report (Nov 2023)
From:   syzbot <syzbot+list84080861d145927aa825@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 47 issues are still open and 23 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1274    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<2>  1173    Yes   UBSAN: array-index-out-of-bounds in xtInsert
                   https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
<3>  935     Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<4>  767     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<5>  563     Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<6>  419     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<7>  396     Yes   UBSAN: array-index-out-of-bounds in txCommit
                   https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
<8>  269     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<9>  231     Yes   UBSAN: array-index-out-of-bounds in dbAllocBits
                   https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
<10> 224     No    INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
