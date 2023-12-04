Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2825A803302
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjLDMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjLDMiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:38:17 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9100C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:38:23 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d8541e6cafso3467614a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693503; x=1702298303;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9ex8njANx8xLMq+LleaHJO8Je9o1d+q9WnLUOEn/Fw=;
        b=Xh6cHb8q34fyQxWMsS2GdwsfIEMeR/ORtreQDE0ZEZYiKtMiHnEF+ZmddjFsWGn0UA
         9oOACthUXjyDqgSD/gQYrfnzU/blN+NzyAluNsJPNdNEt0xCdPalL+WTlp/Q8fMWgaZD
         VcxljiNPeeicq78P8Bh85iVkols3p69Gv3/N9oPj0KvpVyy3gCgS/IRbyA5TMsUUumyb
         hjLvOxOh/uO4dCKwvs+akqBBvW9S8xtdbIk7XaFJqpCHvhS8BWQi7E5VPiZWunPehx+m
         kjEL+XKQUEsdABHgq7wYe5AOOXqgsM5TLxUnktxaTFb1yrqPDzI/84NQzR7GXTFEDEVu
         V9Vw==
X-Gm-Message-State: AOJu0YxK2QkBzfzAAF/mXRPVHV/wWCl1g3bY14hdxX+e4/KKqvxCKGNl
        xt54iH5eIffRwMPOzeePgSuhHz870T2h1iy6PJ+DkqUHgQMW
X-Google-Smtp-Source: AGHT+IG4BnF6V3c1ra8kAveWVvbkMgZSTspVOuvZHNgnZzmDtNlqZOCBTlmHxRBZRU8peH0UXacGlKmq5DshwDWlwbGTz7Q3+kZw
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4682:b0:6d9:adfe:36ce with SMTP id
 ay2-20020a056830468200b006d9adfe36cemr51380otb.3.1701693503288; Mon, 04 Dec
 2023 04:38:23 -0800 (PST)
Date:   Mon, 04 Dec 2023 04:38:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7bcce060bae642f@google.com>
Subject: [syzbot] Monthly bluetooth report (Dec 2023)
From:   syzbot <syzbot+list5592d5c09aec7961e337@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
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

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 6 new issues were detected and 0 were fixed.
In total, 35 issues are still open and 58 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  14730   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  7414    Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  4858    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  4864    Yes   possible deadlock in hci_dev_do_close
                   https://syzkaller.appspot.com/bug?extid=4e3a76c5c505a3f49083
<5>  2074    Yes   possible deadlock in hci_rfkill_set_block
                   https://syzkaller.appspot.com/bug?extid=f93d183bc91522d90de9
<6>  1321    Yes   KASAN: slab-use-after-free Read in hci_send_acl
                   https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
<7>  421     Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<8>  170     No    possible deadlock in hci_unregister_dev
                   https://syzkaller.appspot.com/bug?extid=c933391d8e4089f1f53e
<9>  120     No    possible deadlock in discov_off
                   https://syzkaller.appspot.com/bug?extid=f047480b1e906b46a3f4
<10> 61      Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
