Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96580863B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjLGJ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjLGJ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:56:15 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A024122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:56:21 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b88ab557e5so1380064b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701942980; x=1702547780;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScwbojD04F2at3hLMumIFTXdjPyNKsTIy2RhBT11T1o=;
        b=rHNlT0yhFT+vNe9W2Si+n0Ys1wLnXiiRCratZwBShQMvzX/xi2GX9sVj+6lb6GIGnI
         d+2LvsuOaS1/Hra8JPX71+DbSpYVA6CCx/Oa1pSeRAbyp8YcDR2EzU3t5HP/gIiRiYvy
         otQ4102nO6+Q7Lc+2N74mdSbf3SsQZfOB3263jSVbo5rljpJDEmosza04dVN7Z1PhdCg
         X/98Bn+QD+FIJP7BbmjUDUp65R9dwWf8onDTeI6cdCW2n3AQCQvIjdaw4lh375YA0gvG
         mtyX2agyE71xRkQc2PJhFdVXICtZs0d7jhqDPlKZBCKDfYz2EcuMe+F91imTpJeK3OQo
         rdPA==
X-Gm-Message-State: AOJu0Yzts0ldR/7UCr5TOoNBc/23vGvnqZp9LCtMrMOAv12xH0xDDUws
        B8ziEtizm+c6RVVvUz7J0ua5s2G9+Ptl6kUs8UBcwFnPaTU2
X-Google-Smtp-Source: AGHT+IE2CB85UZCMHKfz8FuIzMEfBv2d88hnYymoGoXVFebV0bh8KsWkEDw4SOmC5VaO0teGgmDorKGoPqlnKVgBtLwTm6W0EtlU
MIME-Version: 1.0
X-Received: by 2002:a05:6808:200c:b0:3b8:5dc1:3177 with SMTP id
 q12-20020a056808200c00b003b85dc13177mr2212198oiw.1.1701942980419; Thu, 07 Dec
 2023 01:56:20 -0800 (PST)
Date:   Thu, 07 Dec 2023 01:56:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6a5df060be87a45@google.com>
Subject: [syzbot] Monthly gfs2 report (Dec 2023)
From:   syzbot <syzbot+list7414194430be1506e979@syzkaller.appspotmail.com>
To:     gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 22 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4739    Yes   WARNING in __folio_mark_dirty (2)
                   https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2>  3678    Yes   WARNING in folio_account_dirtied
                   https://syzkaller.appspot.com/bug?extid=8d1d62bfb63d6a480be1
<3>  668     Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4>  55      Yes   WARNING in gfs2_check_blk_type
                   https://syzkaller.appspot.com/bug?extid=092b28923eb79e0f3c41
<5>  37      Yes   general protection fault in gfs2_dump_glock (2)
                   https://syzkaller.appspot.com/bug?extid=427fed3295e9a7e887f2
<6>  9       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rgrp_dump
                   https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
<7>  9       Yes   INFO: task hung in write_cache_pages (3)
                   https://syzkaller.appspot.com/bug?extid=4fcffdd85e518af6f129
<8>  5       Yes   WARNING in gfs2_ri_update
                   https://syzkaller.appspot.com/bug?extid=f8bc4176e51e87e0928f
<9>  4       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rindex_update
                   https://syzkaller.appspot.com/bug?extid=2b32df23ff6b5b307565
<10> 2       Yes   memory leak in gfs2_trans_begin
                   https://syzkaller.appspot.com/bug?extid=45a7939b6f493f374ee1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
