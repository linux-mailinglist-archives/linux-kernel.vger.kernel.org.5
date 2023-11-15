Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D417EBB60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjKODA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKODAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:00:25 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B79D2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:00:22 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5bd0c909c50so6758656a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700017222; x=1700622022;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2A5LbWNrMvGZ5ypRoNAhL2mlWp9tvnGq8VBlwKDduOk=;
        b=W3fbbX5RlKfNDmhg8wLhc+UlUP9Nli3P9k4zUJvfYFp9nYbW+YYR+p536IFYNqiOFA
         JhMahcw4eUpUjnduvRRVSyyGLNSSON/h9cK6a3Zgpm30N1wsN/xgM9mBl9XSWnnNTNmC
         wfuV6GogvKAmFq710XoEP6a5wvjdhbWzhTUImyqZS97DUwsfT4ln0ADcDfp5Yyz6lJ6L
         zkT0t8UCXJUc9ZFFHfqYSLt0/pMgaJquQu3m79CC37DkHg24zGfiGbEHHHW9sKQLxXt1
         mQPFvNg1p8RUrd4+Et49rr5/+v2RZn4GawvcP+K983Mfm5BbkmJX5PIIgHEZyD6AEGZs
         4L9w==
X-Gm-Message-State: AOJu0Yyq+HP9AxQUBI3iFlsVXUnz3G+g9iNt0Ckcl5FH5L6gC16ub4qD
        4pWJ1LG0Q/xNm6RfwzS+RGuB1GGjtTm2DReac+X3aZiy5/GG0rA=
X-Google-Smtp-Source: AGHT+IF/WUSX0Y9ltSnuf9VuM/FNT7brwx05ClB6cfJTOrlPmooMlcOgLkmpQmy5C3Sk6uyZ+qBL9WRd2RVKgi5S6BjzisCqbtEn
MIME-Version: 1.0
X-Received: by 2002:a63:e254:0:b0:5bd:37e8:fc28 with SMTP id
 y20-20020a63e254000000b005bd37e8fc28mr1094776pgj.11.1700017222157; Tue, 14
 Nov 2023 19:00:22 -0800 (PST)
Date:   Tue, 14 Nov 2023 19:00:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a38a52060a281af5@google.com>
Subject: [syzbot] Monthly mm report (Nov 2023)
From:   syzbot <syzbot+list282472007f650884ff12@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
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

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 9 new issues were detected and 0 were fixed.
In total, 49 issues are still open and 237 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7353    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<2>  616     No    KCSAN: data-race in generic_fillattr / shmem_mknod (2)
                   https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
<3>  575     No    KCSAN: data-race in generic_fillattr / shmem_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=f682b67a78ce05867e78
<4>  272     Yes   BUG: bad usercopy in fpa_set
                   https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
<5>  131     No    KCSAN: data-race in __filemap_remove_folio / folio_mapping (2)
                   https://syzkaller.appspot.com/bug?extid=606f94dfeaaa45124c90
<6>  15      Yes   memory leak in xas_create
                   https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51
<7>  10      Yes   kernel BUG in do_page_mkwrite
                   https://syzkaller.appspot.com/bug?extid=cfba1abcb2cf7b39a320
<8>  4       Yes   INFO: task hung in __unmap_and_move (4)
                   https://syzkaller.appspot.com/bug?extid=b7ad168b779385f8cd58
<9>  2       Yes   BUG: unable to handle kernel paging request in __pte_offset_map_lock
                   https://syzkaller.appspot.com/bug?extid=89edd67979b52675ddec
<10> 1       Yes   general protection fault in unlink_file_vma (2)
                   https://syzkaller.appspot.com/bug?extid=7fbdbd17a5bd6d01bc65

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
