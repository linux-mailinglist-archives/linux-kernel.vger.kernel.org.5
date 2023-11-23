Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0A7F5FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345394AbjKWNMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345417AbjKWNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:12:18 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C0DD53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:12:24 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc41aed6a5so9239705ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700745144; x=1701349944;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=co7D42Ew5PGNmMxvrOV+FDBuWMAk5mUqDhu2FPib/N4=;
        b=tFKI4za+yYfeM/CCqQ/MkbY7kWaoQc4vw1RB6EgR40+PShtLyOIbDxl600bwmlDUoG
         DwVmPOsO+VkJocz3pxtygpGERKjpbdTMWjaZzZLSAs54NcBMiqHiM3IAk4FKP5uV0A29
         uk6+qlqqRgnBtLc1PclouKfiV1bvNQwHMkR3tK3WLQSnGT0KhKj3j1gj0hZsQJ2ZJwNZ
         qH3o4QNvDxV4OlFX6nZnUssPVCLAf/iPqjdI6CR2TTZQNdi05+XQgznkRSEgWkYVXkw8
         zHlDQ3Qo1XBzgwY10UP8xkFjpel7Tm+Yl2+RzH3pfmFB3GmXpkPepkqPfzal6SFRdQFW
         OIvw==
X-Gm-Message-State: AOJu0YzsI6AFTYd6wd8EKG68vrFtdKX2ntkMHSzogxJUKnn6goFh87gh
        2u4iueDNBNltZLiwTd5qqH8dYIOS8EvSTcJofRCAgiF6WvN5BFM=
X-Google-Smtp-Source: AGHT+IFMINqJutKKVx9TByRIfYTcp2ud8KINy4P+SflmG9AERMT9n5eJb9gN7HblNG4JEj5KkkarTNiWjCChXvYC/2gHnJHUfcXH
MIME-Version: 1.0
X-Received: by 2002:a17:902:f154:b0:1cf:8be1:4160 with SMTP id
 d20-20020a170902f15400b001cf8be14160mr360107plb.5.1700745144039; Thu, 23 Nov
 2023 05:12:24 -0800 (PST)
Date:   Thu, 23 Nov 2023 05:12:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029fce7060ad196ad@google.com>
Subject: [syzbot] Monthly net report (Nov 2023)
From:   syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 5 new issues were detected and 13 were fixed.
In total, 77 issues are still open and 1358 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3878    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<2>  892     Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e
<3>  860     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<4>  590     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<5>  390     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<6>  373     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<7>  249     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce
<8>  240     Yes   BUG: corrupted list in p9_fd_cancelled (2)
                   https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6
<9>  172     No    INFO: task hung in linkwatch_event (3)
                   https://syzkaller.appspot.com/bug?extid=d4b2f8282f84f54e87a1
<10> 154     Yes   WARNING in print_bfs_bug (2)
                   https://syzkaller.appspot.com/bug?extid=630f83b42d801d922b8b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
