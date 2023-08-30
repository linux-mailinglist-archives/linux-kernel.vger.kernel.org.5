Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCECE78DD6F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243875AbjH3SuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244207AbjH3MpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:45:06 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF88185
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:45:02 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bf707f526bso58057685ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693399502; x=1694004302;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jt3l9FGOI3Y5tt5qjFm1J8GEZChx9Hp7h/Vbc/JsQ3E=;
        b=hq2lKuJI/YLyTiQzi9dTFQ/wChmykqXCvgs6nQQp+heifx6sTmGYujbieP0bpz99fQ
         cUHBXFrhPEvCUxSwCv5w3Q5vhQDpJpLknRbS4/Ctyx8DjA1pAcW2PWNKP94z7SAYdKn+
         rc2jZapkFRabZnRgYs2zbRwfWgxLa1wYKXg3q1mzCwfvrUN0nEmotAYom394FpSWJKkG
         Ph22hHgME+c+la1wQp/zNc4xmvzXGuEWio3guOsBdBHH19ai39/TQJYpxTk4P/9k4S6n
         +NjWRWoVjQi3C0AthvyeiUJrELGZJhWclnWWLBpqVTtv3Ru7X54ZmgWpyrj3Vx6f2UWN
         ul7g==
X-Gm-Message-State: AOJu0YxMSSVWTkTWC0SYaiNImK/FoJiCLEcyDLQWRLaFMvWquXODU2PW
        /Njm+8Nhd5LdEvCcCLL9rI2t1jdwxocMUcVFsv08tO4o9mHP
X-Google-Smtp-Source: AGHT+IF+BZ7YLC7iad66BUKll9riZuoAtEuwnKIWiTyEBoJRJpmCovwoB1+N8tFGqnTgUi6y3R9KLMCmbW1zGWpjn7BI9GeuhISD
MIME-Version: 1.0
X-Received: by 2002:a17:902:db08:b0:1bb:b74c:88fa with SMTP id
 m8-20020a170902db0800b001bbb74c88famr618138plx.6.1693399502045; Wed, 30 Aug
 2023 05:45:02 -0700 (PDT)
Date:   Wed, 30 Aug 2023 05:45:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c849190604234b66@google.com>
Subject: [syzbot] Monthly ntfs3 report (Aug 2023)
From:   syzbot <syzbot+list2fdacf96ea1991346bcd@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 1 new issues were detected and 0 were fixed.
In total, 57 issues are still open and 24 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5004    Yes   UBSAN: shift-out-of-bounds in ntfs_fill_super (2)
                   https://syzkaller.appspot.com/bug?extid=478c1bf0e6bf4a8f3a04
<2>  3598    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<3>  1912    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1564    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1281    Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<6>  1260    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<7>  780     No    possible deadlock in ntfs_mark_rec_free
                   https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
<8>  537     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<9>  512     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<10> 455     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
