Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2128803304
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjLDMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjLDMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:38:18 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F913106
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:38:24 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58d5657b6bbso6119636eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693503; x=1702298303;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3vC9DKCks31qlZTLEOBhiTQthQAnOeHRO8hvXnpMao=;
        b=cSnBArcm/snzPQEzr9KgXSA6E5j2gw47bKumdYkxGhjvlXHOkP3qUB5xQ4lix10Bss
         wCOQv8NB9g5EfCoB/Yjxuod2szOdtx3Yx7DOlKVJ+rKiQH+/VPiYaBA+kw4HGiBMwWLP
         voLf9Tr1HbZjiCAkLj1qAP0yZlE5M+GUkBbfqnaayxscBsBIz8N/73eAdvCw2RL1bzPL
         zvA3lTw22WUK2kemse4WVZMTevHlJmjDOZleGlHLYnRzWYK4AUED2XS4Rxr9jyCQs4pA
         BnsG+rN660uPlsny36w+OtPOccHuaAg461tLv8zp21CQSFHRXx3KJjH+UMFlUfUZOop9
         0rug==
X-Gm-Message-State: AOJu0YwFwBPQ58YK3JmIdHNCmISS9EigaUDZOuI+WwHtKuy9yqbG1AjZ
        4QQG7j0iq1xpu0si2ESPKjea0+rAgBBsHm+prS+Qal4myqIj
X-Google-Smtp-Source: AGHT+IESeNWC3Bgx3X6azwZbL3Ppc+gmrsehq+ZGEfKcbxjlmKt1DBtS1guViyUXax/NYtTEmFF/thOINVngKT4GFkzVR9CWhWIs
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d60c:b0:1fa:da34:99d9 with SMTP id
 a12-20020a056870d60c00b001fada3499d9mr2934304oaq.5.1701693503574; Mon, 04 Dec
 2023 04:38:23 -0800 (PST)
Date:   Mon, 04 Dec 2023 04:38:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc17fb060bae647b@google.com>
Subject: [syzbot] Monthly jfs report (Dec 2023)
From:   syzbot <syzbot+list36f1468762da119bb5f8@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

During the period, 0 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1436    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<2>  1187    Yes   UBSAN: array-index-out-of-bounds in xtInsert
                   https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
<3>  1102    Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<4>  859     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<5>  441     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<6>  304     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<7>  232     Yes   UBSAN: array-index-out-of-bounds in dbAllocBits
                   https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
<8>  219     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<9>  169     Yes   KASAN: null-ptr-deref Read in drop_buffers (2)
                   https://syzkaller.appspot.com/bug?extid=d285c6d0b23c6033d520
<10> 110     Yes   KASAN: use-after-free Read in diFree
                   https://syzkaller.appspot.com/bug?extid=1964c915c8c3913b3d7a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
