Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B9880C4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjLKJkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbjLKJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:40:24 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28986124
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:40:30 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fafa54d079so5937476fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287629; x=1702892429;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uky11+aNDc+QYZAWQ7fwQ7PnybsCU/zwUrto1XuRqCc=;
        b=hXi/9tLEE5+ZGEdzIPtt/4rYmX3U9qEjrPxBc5eZMh6FxLRE6lFJGEOdZuUkb3u0Ql
         wWN8PHDe0orpCaQ+th3qgVR3oHJNgJa6C8JUu+qScXVXEcfsGYgoGEbPQj+dEwrkj/0p
         BqH0hx61SpIq5rZ7hzYm/kh3HcT+J6SVd75wD+esp9makT7PVbC+vTodnQfA4iXc2kSw
         UH7+xqsWLTZNj2R/kI9cvi1lRBjMlXvOFY4L/YRvrIqlOjNEPPIaVmJl/uv8UruI7c8r
         NSW+5kD4GfgoXQbneyyQaIa7kEyB2iD9pu4thr5Ud2k4quSCeytqiaWxKHTM/hznWhsC
         Z14Q==
X-Gm-Message-State: AOJu0YwvrjZLuG8gCurBpFvci1dS7yg55nNmJX83Z9C+UpDFGAIMKvu3
        uwLCCeKsAcgD3eHoUoEeDrKhdwtPmLU4jvcvPwZgnALdTmXE
X-Google-Smtp-Source: AGHT+IGsLNvcxptaNUTo2ZDDJm+o5H641fl+aEobGi2k+J9gs+6ClTuFcyoQnK+hvmCm6JbNrn8I5XVrcf6zXs9K2nLLTIch28mB
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b004:b0:1fb:fed:9b65 with SMTP id
 y4-20020a056870b00400b001fb0fed9b65mr4955051oae.5.1702287629488; Mon, 11 Dec
 2023 01:40:29 -0800 (PST)
Date:   Mon, 11 Dec 2023 01:40:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076184d060c38b9a1@google.com>
Subject: [syzbot] Monthly udf report (Dec 2023)
From:   syzbot <syzbot+list168cda8ecef61d5bf93b@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 1 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1923    Yes   WARNING in udf_truncate_extents
                   https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2>  117     Yes   KASAN: use-after-free Write in udf_close_lvid
                   https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
<3>  32      Yes   KASAN: use-after-free Read in udf_sync_fs
                   https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
<4>  29      Yes   KASAN: use-after-free Read in udf_finalize_lvid
                   https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
<5>  29      Yes   WARNING in udf_new_block
                   https://syzkaller.appspot.com/bug?extid=cc717c6c5fee9ed6e41d
<6>  17      Yes   WARNING in udf_setsize (2)
                   https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<7>  6       Yes   UBSAN: array-index-out-of-bounds in udf_process_sequence
                   https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
<8>  5       Yes   KASAN: slab-out-of-bounds Write in udf_adinicb_writepage
                   https://syzkaller.appspot.com/bug?extid=a3db10baf0c0ee459854
<9>  2       Yes   KASAN: slab-use-after-free Read in udf_free_blocks
                   https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd
<10> 2       No    WARNING in udf_prealloc_blocks (2)
                   https://syzkaller.appspot.com/bug?extid=cc2b732891efbf755b78

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
