Return-Path: <linux-kernel+bounces-14425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E82821CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB461C2031E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEFC134DD;
	Tue,  2 Jan 2024 13:36:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BC12E61
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35ff5a2fb06so102719615ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704202587; x=1704807387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQDx8ihcPKO+A1LQq9lBiIrWnZPzFKNw4YHTLJ2gqCM=;
        b=sdbdU8K88/rJCiKP6vsJ55Fd9EZS2Ax/HEKT7ELp9MsZPbAraqAzw1p93fG48cGzyh
         EvxVDpNcKPeIPEKk654HqXvzLVspsIvmVaKRUzmeqy5eOR5i1zs/gqK0kBWRvYxtkLgr
         Q+9bfa2vw1UeCAOsIo9CTP8sCUMKVmTkb81oiGYUim4UwLshsrl5ZfmssDuclH9eri7Z
         gRfCssD4RZB/rfqnvz1irMwjpsTa29MjYpcO/z50NcADRnhpPFfDJ1pLGlRFZAhaXX3t
         bEcsq/5ho90KfBFAEvhriHwv546/rz1msP3xI6W1MoqrLR65E2RcQE1PGiHUet+VlzFI
         r6xA==
X-Gm-Message-State: AOJu0YxfCE60Z105OOWKoDZ8eInK/MsNUY1+nvUbAi/rzyHtyV79Re9f
	tvTMCNo3FR2mB4tTqAAjnxFDNKu1wNFW0jahyZkvb8WZlhdv
X-Google-Smtp-Source: AGHT+IHRrLGfk7SofeveRJrU3nPffiFbYPxfX2Y+0DwLZyMWhxyZwoNEQdHQRQR5yFTeLaHClNpaJjZfb9lw3PnuXdDL3SWphLKg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154e:b0:35f:f683:f769 with SMTP id
 j14-20020a056e02154e00b0035ff683f769mr2541033ilu.5.1704202587586; Tue, 02 Jan
 2024 05:36:27 -0800 (PST)
Date: Tue, 02 Jan 2024 05:36:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbc946060df695ea@google.com>
Subject: [syzbot] Monthly dri report (Jan 2024)
From: syzbot <syzbot+list680700f3ccca9aabd1af@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 4 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 375     Yes   WARNING in drm_wait_one_vblank
                  https://syzkaller.appspot.com/bug?extid=6f7fe2dbc479dca0ed17
<2> 147     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3> 143     Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<4> 94      Yes   inconsistent lock state in sync_timeline_debug_remove
                  https://syzkaller.appspot.com/bug?extid=7dcd254b8987a29f6450
<5> 54      Yes   inconsistent lock state in sync_info_debugfs_show
                  https://syzkaller.appspot.com/bug?extid=007bfe0f3330f6e1e7d1
<6> 9       Yes   kernel BUG in vmf_insert_pfn_prot (2)
                  https://syzkaller.appspot.com/bug?extid=398e17b61dab22cc56bc
<7> 6       Yes   WARNING in drm_gem_prime_fd_to_handle
                  https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<8> 5       Yes   divide error in drm_mode_vrefresh
                  https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
<9> 1       Yes   divide error in drm_mode_debug_printmodeline
                  https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

