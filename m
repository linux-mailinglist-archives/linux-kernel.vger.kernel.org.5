Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60C280F9F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377532AbjLLWC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjLLWC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:02:26 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C94B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:02:32 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d9feae8dfdso5707764a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702418552; x=1703023352;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hdGj1T+YGUCPpxRju91bMft5LMiNJIh6i9fW42p70I=;
        b=WhnjkNekipNvM2vtZ9j44npmrCFIwQyiDbJsL9D6kVr/8EgtMlitiPE/JvbQooaOct
         +onMyyAKbwk/Fr7hUocwz864Cgobj8HrZsLAT4C9KQbYhzvW05JAw02UDeHKhDRwwLqC
         JC0az3F9i9TkZpUIDlKTE+2R5cOIGaeVcyqotNgsLD7dMPfg7KD5bYqOYYu8kGMgDG88
         IgzETMLKQAJK7CACSPAWTTVgU/n96jNW37SwCAJpDAuuaxb+VKLPMsu7sLW8F1PAqw4K
         nyBWwYW/wv/v7L5osDhAXCrRqc/lLNd8tJOPWS5K1n21qI9R7fXklRFyhkFXYbTXmbUC
         1pag==
X-Gm-Message-State: AOJu0YygqD0rQ8niHTf4ekA0zb0B5oxHNCDrOBxNnATXieNaz0kkQpDF
        7zD4rq6NnHRrRunKVlHzWDFTfSroCfzdqSI6/nLosn91ASFO
X-Google-Smtp-Source: AGHT+IGWzzK2DONy86FSYfM7rroV/aF9VC3y8B3L2PLihakl9b0pbKQ0Uv+y+fuK1z3gK45URHuOvpg2UNqytDQ0aa59k8lpCXHB
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4487:b0:6d9:f71c:eaa7 with SMTP id
 r7-20020a056830448700b006d9f71ceaa7mr6107216otv.5.1702418551886; Tue, 12 Dec
 2023 14:02:31 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:02:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b58e0060c573578@google.com>
Subject: [syzbot] Monthly fs report (Dec 2023)
From:   syzbot <syzbot+list7486a5e050207f65aa7d@syzkaller.appspotmail.com>
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

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 10 new issues were detected and 1 were fixed.
In total, 93 issues are still open and 329 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  400     Yes   BUG: sleeping function called from invalid context in bdev_getblk
                   https://syzkaller.appspot.com/bug?extid=51c61e2b1259fcd64071
<2>  359     Yes   BUG: sleeping function called from invalid context in __bread_gfp
                   https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
<3>  261     No    KASAN: slab-use-after-free Read in __ext4_iget
                   https://syzkaller.appspot.com/bug?extid=5407ecf3112f882d2ef3
<4>  178     Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<5>  54      Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<6>  44      Yes   INFO: rcu detected stall in sys_clock_adjtime
                   https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190
<7>  42      Yes   UBSAN: shift-out-of-bounds in minix_statfs
                   https://syzkaller.appspot.com/bug?extid=5ad0824204c7bf9b67f2
<8>  25      Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<9>  11      Yes   KASAN: use-after-free Read in sysv_new_block
                   https://syzkaller.appspot.com/bug?extid=eda782c229b243c648e9
<10> 9       Yes   UBSAN: shift-out-of-bounds in befs_check_sb
                   https://syzkaller.appspot.com/bug?extid=fc26c366038b54261e53

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
