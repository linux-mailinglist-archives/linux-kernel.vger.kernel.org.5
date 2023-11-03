Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73367E0120
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjKCKWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKCKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:22:28 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4345D45
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 03:22:21 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1e990f0629cso2580348fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 03:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699006941; x=1699611741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evs9wew+qCht67yOpbE5P1sRxmRuIhk4CmEZLfcRYVM=;
        b=IL9LkTNiRlCzGOfxrISigKTNArxH1ZuCEF8E5PlSLSQG8pAzl0hgLosSmZlebsf7gu
         5mV7m7e2HnZcUX8ed7+l0ExqzcGZ1X757RoGWe8y2o1GepyLObbv/OVgzKFETHP/xp3i
         ZLkP5kgr82zPD+7CwQLpPRAqc9zj5q++LDWEsI3VsVS1kbJUO1tPcLvF+P04CpmdLSqP
         ePaMl74eeI7wRbxiLjQxmNeVjratxdWDO5Nvus0qun6W+IS/aaVtIBdPKoc8DTmBJf8/
         j+iJvDeMgJKSLc0XMAOprnszB+MKMlBGiHEOa/Eju1xPRoGlHhBYcW4we+dPKY2t74fn
         yDDQ==
X-Gm-Message-State: AOJu0Ywa9DQ/IC1vqEHqCxIEInlwaN541X9z3aWz52hwk5jedcIQNYrs
        4K2ZBwbkvGFiALv8oKfcLxN87tgMoK3p/0n6ymK5Jh2y2yOs
X-Google-Smtp-Source: AGHT+IHDIX4t4ZNzjTwzMJ+WEBrsGKcH+we03fE8VdqP6vuTL2eLamSQ1q6VmV2xFvW7/7qVNbSyPgyhoqinSytqmxtagB35qOp1
MIME-Version: 1.0
X-Received: by 2002:a05:6870:30d:b0:1e9:dabc:9d6 with SMTP id
 m13-20020a056870030d00b001e9dabc09d6mr10017992oaf.1.1699006941325; Fri, 03
 Nov 2023 03:22:21 -0700 (PDT)
Date:   Fri, 03 Nov 2023 03:22:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035708106093ce150@google.com>
Subject: [syzbot] Monthly bluetooth report (Nov 2023)
From:   syzbot <syzbot+list91c187589534856682bd@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 4 new issues were detected and 1 were fixed.
In total, 29 issues are still open and 58 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11654   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  5101    Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  4840    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  2046    Yes   possible deadlock in hci_dev_do_close
                   https://syzkaller.appspot.com/bug?extid=4e3a76c5c505a3f49083
<5>  1266    Yes   KASAN: slab-use-after-free Read in hci_send_acl
                   https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
<6>  573     Yes   possible deadlock in hci_rfkill_set_block
                   https://syzkaller.appspot.com/bug?extid=f93d183bc91522d90de9
<7>  336     Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<8>  139     No    possible deadlock in hci_unregister_dev
                   https://syzkaller.appspot.com/bug?extid=c933391d8e4089f1f53e
<9>  95      No    possible deadlock in discov_off
                   https://syzkaller.appspot.com/bug?extid=f047480b1e906b46a3f4
<10> 65      Yes   memory leak in hci_conn_add (2)
                   https://syzkaller.appspot.com/bug?extid=b6678ec6b1772e54ee6e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
