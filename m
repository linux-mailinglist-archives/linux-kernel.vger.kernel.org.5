Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5D7E0A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjKCUs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKCUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:48:27 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B80D53
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:48:24 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ce37a2b2e9so3183341a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 13:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699044504; x=1699649304;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYI7n3mLYM40cy95YfSnPmk+FiWhPpVvFYPVeIDOOxo=;
        b=hnH3FFGsYsJw3tEZtc/n05zYVS+S6QCoSbv+UYq3PZFkdOfkRs721uCAz1nF5ANtPN
         B6JJZD4frQuTjWT0hwOqFnb0l9vAj5UC/KhUDZV0FJY0tGmLYW0NEmJks3hc42XrRqIK
         dORPHANRXD6jOPXbj9bvLQqcZyohPgYHt67VgN6IRXODY0uOoKfywzfJYaZbl4XYzDv8
         hXZl9yzXqxbBLdscEAXxj9a+VFb6AUdmgaeaAMzOXAsKa8F7OGmkeiLOq4sy/AUacDMN
         6troybv7UgilySN0APfXkhZdbZxhJksrsawxF+7myRYGjfxtLZLxtmd7ViSMB+RiIXmB
         riRw==
X-Gm-Message-State: AOJu0YxTb45PKLS69Mx9BlNQPkIFNqPcUK1JdtjLfazw20RHIQBwjaV6
        +JgqWx9h5AFM3AbgfuEXQczyJGx/NgMEiDFIr3StGuJkg5srQss=
X-Google-Smtp-Source: AGHT+IGyIWMHQ/zphzXyDcZk+20Zoe4Op6VCSDwF0dOdH62NQphlgHA+dNlSlM98pmJm55H3wmWvGlyyDlkXcPcti/mf4ktGFXDF
MIME-Version: 1.0
X-Received: by 2002:a9d:6c93:0:b0:6b8:6f61:5f61 with SMTP id
 c19-20020a9d6c93000000b006b86f615f61mr6098580otr.6.1699044504280; Fri, 03 Nov
 2023 13:48:24 -0700 (PDT)
Date:   Fri, 03 Nov 2023 13:48:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022a5d8060945a0fd@google.com>
Subject: [syzbot] Monthly usb report (Nov 2023)
From:   syzbot <syzbot+listbdb465433a25244527e1@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 2 new issues were detected and 3 were fixed.
In total, 65 issues are still open and 331 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2721    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                   https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<2>  2144    Yes   KASAN: slab-use-after-free Read in pvr2_context_set_notify
                   https://syzkaller.appspot.com/bug?extid=621409285c4156a009b3
<3>  944     Yes   WARNING in implement
                   https://syzkaller.appspot.com/bug?extid=38e7237add3712479d65
<4>  819     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<5>  368     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
<6>  364     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<7>  304     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<8>  239     Yes   INFO: task hung in netdev_run_todo (2)
                   https://syzkaller.appspot.com/bug?extid=9d77543f47951a63d5c1
<9>  222     No    INFO: task hung in hub_event (3)
                   https://syzkaller.appspot.com/bug?extid=a7edecbf389d11a369d4
<10> 138     Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
