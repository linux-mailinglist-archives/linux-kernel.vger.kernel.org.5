Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB8E7EE585
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjKPQuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345295AbjKPQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:50:11 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93264D57
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:50:08 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc0e3a2b6eso12754015ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153408; x=1700758208;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGEQ+yHoH+iPAkOX48Nm2j3mBBUHJOWHf/O4mRcWIV0=;
        b=AIG7GyHNe9feAgHK2nz946EBbewXnCsugDACd/eUC+OYgWTq+ztKE3LQkHBhOwnEH/
         Za2uypgRcwoqkUiBaXnREY71t1ymfQG3BMFCIHnx8KaQFr2D2J4BVESRMs6UwyLJifev
         CRpdjI9mPPf0lCLn/VPkjGd5LYnIuGQNHCF0C2dAQNJIGVbxhiRzJfX6GTHQ7v6+HEsZ
         GZSylZ2WO9qPP7tBAEkl6OEaWsu2/fYOeNlIyuiOm9JnauY99SVX+vpPAGI+RJxLFdI4
         Ay6/XpIsb2RI9H0l3sF6Sns5fLxUMhIQwIBpY8IldrUfFMB/PuympuwTIdWxf4GZJ2Gg
         vMIA==
X-Gm-Message-State: AOJu0YzJDiiGplMO/qcjS+l7V3n3lwhbudkJrGMP5KWI7zwlau1YoDHQ
        /Cd6L8N8BbIqBg63OWiCmznhrIMxbUduJzIFTw5lUjCwmzB4Avo=
X-Google-Smtp-Source: AGHT+IET44s3LZz9LGDiI651Ur3mGB9QqGM3P63VSkge0TNT08wyesDS5run7jg/uv8PudL2mGJbwP0yCeYuq0Rkg0pGmbd1CMfL
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4d1:b0:1cc:335b:c923 with SMTP id
 o17-20020a170902d4d100b001cc335bc923mr2756464plg.2.1700153408046; Thu, 16 Nov
 2023 08:50:08 -0800 (PST)
Date:   Thu, 16 Nov 2023 08:50:07 -0800
In-Reply-To: <GV1PR10MB6563F8D2678DC24937488D80E8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f354cc060a47cf68@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com

Tested on:

commit:         7475e51b Merge tag 'net-6.7-rc2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17b8635b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=696dc362ad4818c4
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
