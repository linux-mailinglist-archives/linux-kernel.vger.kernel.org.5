Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B373798852
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbjIHOMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjIHOMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:12:02 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE3E1BF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:11:57 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-570096d89b1so2582373a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 07:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694182316; x=1694787116;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnzCKZJczahJy+S/JArtFdOPkapnJg+gfjTcqGqp3sU=;
        b=JxOS4sIrf7pIL+Ce0RDuSSXvXL9tWBlxRv0JzMj+p8xzDJuo+U9oLpHyNOz/88I0GP
         SWEDghtBQPEpm7ZRcuAvyZYO2Rp1MLS3DMW9R9SkThBXoJcqrP9/saiwjRKfVMihQ/B6
         MBoHyVX2O4tDnP7Ctkhr5wpFvagbVKRWsJ+t+vLcu7KEgiBamaDt7ZNKUO7asf3wzdEA
         gLMlDEn8hetlZ+z/1UL5Uew0kA+hE4X/WfHZCPVI1d/rCZIAzsuqCpjYhIPo1xVtpCpW
         2pALhDRCFCrKN9x6VPTao0VtpCu1GJU7rgGNd/TeqfEZ8XSNu3mcE4T6G8Yv9OkqPRQ0
         3Pcw==
X-Gm-Message-State: AOJu0YyjqY/KGehKXpfSLBSEcfdzx4dA+JFuQvFoCOdMe0RfY940M9pu
        n5pJsJE+Jy1RAD0vTDj9XLdKIhAZL6m8UIYJQ0YkdI7M4C0Z
X-Google-Smtp-Source: AGHT+IGSgdA4DWeLu66y6OI1b/B+AM6Taex0QSz7cVrPl8pF5e4doG9DA8+Y2RRxWeh7/Pp8DyNc+XgOQ6i0tm8gTJRNl6Jc8CfP
MIME-Version: 1.0
X-Received: by 2002:a65:6e03:0:b0:566:8b4:4f18 with SMTP id
 bd3-20020a656e03000000b0056608b44f18mr486498pgb.5.1694182316684; Fri, 08 Sep
 2023 07:11:56 -0700 (PDT)
Date:   Fri, 08 Sep 2023 07:11:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bc0110604d98f19@google.com>
Subject: [syzbot] Monthly udf report (Sep 2023)
From:   syzbot <syzbot+listde33a415ffbafe5a4f45@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 0 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1372    Yes   WARNING in udf_truncate_extents
                   https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2>  82      Yes   KASAN: use-after-free Write in udf_close_lvid
                   https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
<3>  22      No    WARNING in udf_new_block
                   https://syzkaller.appspot.com/bug?extid=cc717c6c5fee9ed6e41d
<4>  16      Yes   KASAN: use-after-free Read in udf_finalize_lvid
                   https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
<5>  9       Yes   KASAN: use-after-free Read in udf_sync_fs
                   https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
<6>  6       Yes   WARNING in udf_setsize (2)
                   https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<7>  5       Yes   WARNING in __udf_add_aext (2)
                   https://syzkaller.appspot.com/bug?extid=e381e4c52ca8a53c3af7
<8>  4       Yes   KASAN: slab-out-of-bounds Write in udf_adinicb_writepage
                   https://syzkaller.appspot.com/bug?extid=a3db10baf0c0ee459854
<9>  3       Yes   UBSAN: array-index-out-of-bounds in udf_process_sequence
                   https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
<10> 2       Yes   KASAN: slab-use-after-free Read in udf_free_blocks
                   https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
