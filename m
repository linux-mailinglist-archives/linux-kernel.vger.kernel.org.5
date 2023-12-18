Return-Path: <linux-kernel+bounces-3363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725D816B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFF91C22541
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EC917991;
	Mon, 18 Dec 2023 10:47:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5719447
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35f97a33404so25318585ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702896441; x=1703501241;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ayplWo7fKpoAX9jaHUBaIAkRJyVr/04Ikh3SGkSQv6E=;
        b=fv2Zc0gDsMPBQWtduTjuho/ItOKt0esw59l0lank7OO2mf31dBU/MdZCASvfsSABU8
         rKEQu9rhAta4xMOFu1FOVMRSMvob/ZSssYtE36E3uqK/jfZVaQDn3uz0crxBTp29w1Vr
         nYjU7toxVigrhHKGsDZ4SJhz+n1AqdlTs3LzyNX5uiLiDDm3Hk+vBF5QxsxnrYhSJiIw
         ZtAI+O2LFCZPfhNlXVBeHTsLLS6jqrlZLi+RRxzVae8T16LaIOO5SZRKvJOK8ITY1xQk
         yLzMeh+p1Fbe8gdpaxrNMQMkaiknKlg7X6onw4U5MrHQ33LdDt37hSlaKZBV4Th7a7rO
         /iNQ==
X-Gm-Message-State: AOJu0YwkW00OsCcR2vfR25ixHi0QNXzBODfzczNsE2PBb8/FSm9FEKea
	x0muOsKnfvSV2pbOBXaPkqmDoguTsCmv6/+xLUlAm8kQRqPAZ18=
X-Google-Smtp-Source: AGHT+IE0ByqqFJWWJX7zPo/4+R2cRq57Eh2TL5MlBUGGCVkd3vo1dWdj0vX6ywh6HXDeHVxCwDxpy9i9rBFpfOre5pDYHb9uUCHr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba3:b0:35d:680e:1fa2 with SMTP id
 n3-20020a056e021ba300b0035d680e1fa2mr798580ili.5.1702896441734; Mon, 18 Dec
 2023 02:47:21 -0800 (PST)
Date: Mon, 18 Dec 2023 02:47:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fbf7a060cc67998@google.com>
Subject: [syzbot] Monthly mm report (Dec 2023)
From: syzbot <syzbot+list92f4bea061210ca41607@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 2 new issues were detected and 2 were fixed.
In total, 32 issues are still open and 220 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10188   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7356    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  640     No    KCSAN: data-race in generic_fillattr / shmem_mknod (2)
                   https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
<4>  594     No    KCSAN: data-race in generic_fillattr / shmem_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=f682b67a78ce05867e78
<5>  560     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<6>  365     Yes   BUG: bad usercopy in fpa_set
                   https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
<7>  36      Yes   WARNING in __kfence_free (3)
                   https://syzkaller.appspot.com/bug?extid=59f37b0ab4c558a5357c
<8>  27      Yes   INFO: rcu detected stall in sys_openat (3)
                   https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5
<9>  21      Yes   general protection fault in __hugetlb_zap_begin
                   https://syzkaller.appspot.com/bug?extid=ec9435c038e451be48ff
<10> 15      Yes   memory leak in xas_create
                   https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

