Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7078FA3C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345982AbjIAIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbjIAIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:51:04 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E010DE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:51:00 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c07778146aso20453215ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 01:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693558260; x=1694163060;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JPBrIi1YcL7e89Gl1EkswK53QZiuLZ5XXe0Xsa1kO4=;
        b=SEOLo+4guZHPBNBbEQ3i9FTDqsV32uPILIwWM+Ui5IjqkarebrbG/n6Hd76TwOIpnk
         twVjxmWcia5JV69XY9YAmD5YY5GLtmZqXj0svCrkQdGYsDJ72hEAFFDkQt7n5ytoJIF3
         Z2GaVYbiymj3mlR/Gm6Z23y/WWNRnrQq85c0YWltwPmru3l+vE33b/wEnvgJ+oIe2Ypm
         4cciQnMMJf9brJHM50sO7RnTmpyytRnD1Y/pIS1WQvkPAHGQXnH6l1otwuzzV5T5NsVv
         +jR12MFKIGDEvWs2xiX/ujk8pzTGdC1ErmcfxA8rXWLq7CsF6fOrVml1f5Hn4CO7Ar73
         +jDg==
X-Gm-Message-State: AOJu0YxMwolcx2wIdlFBKRRF5yxRJ1CeHjGBlXu0zVeIwKbUj9exgTSC
        eaMxOcqDadpQYmwBAE3si+njhvoSuL8WkGWxUKkMyz7qJI3t
X-Google-Smtp-Source: AGHT+IGdMvUwSFkgk8ztcqPBglfZ1o2YcdWxhLDfDrX8aHtAkIJ0r/BBQ2jHGmSJQyONLVqUzaIwY9d05O5hFpXpEbRAURtzXVdx
MIME-Version: 1.0
X-Received: by 2002:a17:902:dad2:b0:1c3:19d6:3585 with SMTP id
 q18-20020a170902dad200b001c319d63585mr214822plx.13.1693558259958; Fri, 01 Sep
 2023 01:50:59 -0700 (PDT)
Date:   Fri, 01 Sep 2023 01:50:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dc85106044842d8@google.com>
Subject: [syzbot] Monthly bluetooth report (Sep 2023)
From:   syzbot <syzbot+list89977501de2dccb36fe7@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 2 new issues were detected and 1 were fixed.
In total, 20 issues are still open and 55 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8940    Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  4685    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<3>  2847    Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<4>  1418    Yes   BUG: sleeping function called from invalid context in hci_cmd_sync_submit
                   https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
<5>  1064    Yes   INFO: task can't die in __lock_sock
                   https://syzkaller.appspot.com/bug?extid=7d51f807c81b190a127d
<6>  224     Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<7>  90      No    possible deadlock in hci_unregister_dev
                   https://syzkaller.appspot.com/bug?extid=c933391d8e4089f1f53e
<8>  65      Yes   KASAN: slab-use-after-free Read in hci_send_acl
                   https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
<9>  57      No    possible deadlock in discov_off
                   https://syzkaller.appspot.com/bug?extid=f047480b1e906b46a3f4
<10> 8       Yes   BUG: sleeping function called from invalid context in __hci_cmd_sync_sk
                   https://syzkaller.appspot.com/bug?extid=c715e1bd8dfbcb1ab176

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
