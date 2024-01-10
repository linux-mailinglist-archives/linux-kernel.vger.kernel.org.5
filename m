Return-Path: <linux-kernel+bounces-22741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B082A260
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0074B268B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC604F204;
	Wed, 10 Jan 2024 20:36:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917C4EB35
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7beebd130aaso182989139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704918987; x=1705523787;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yog6wnWNsmydumSZg/VKYh15G73Pd+ZGVgDdER463ZM=;
        b=bXUM7Y0s0mNPhW0iyk8vussrkVX/3U/rWw1wWHsgn7JEq2vL/dsq22C+mpBxQXIMGd
         Q0NbPbVnF9mFrAH5Nk5JS510oGRV8I9g3RD6b03mSV2Z+s+IGxO6/1ogF6qLby2Hpv52
         d5RPKS4SPDxa7J/tPYb4wGlVbJdn27/vjbSuJeH+c9JLiIB8I2d8Ce4ieGDT288TwcvF
         h8FSJZ5DcUXmjJ5aIncW9+y2ItFqzkBr2/W7NjKKO+wYEDK5pD/IXiKgpZbMcADCdCfT
         UGT+Tg+Dai649sm+Hmxr4xgcCc4M3S0+cGD6XeMHs2cU1jJLeqSgm49z3gCDfCM/O+sH
         Z/tw==
X-Gm-Message-State: AOJu0Yypt+ddvnmwib5q8gMOQgsoVUZ0wGT9viVVuaVNqs9AV8e+fEuw
	vfIB8m3gARP1qu0rtT6smYTsuAx8wlNmf9UWkQaaxblId/Vb
X-Google-Smtp-Source: AGHT+IGey5m6ci9iv/2bvmfJNJrYCEYmvuEpE2dwVSvWvKfiKqWL/CXpNgFkbN1fXaIrJT5ruH6NUK0tIXKwhq4LvHnkQtUqce2s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:191a:b0:46e:3cdf:c9d7 with SMTP id
 p26-20020a056638191a00b0046e3cdfc9d7mr8123jal.2.1704918987058; Wed, 10 Jan
 2024 12:36:27 -0800 (PST)
Date: Wed, 10 Jan 2024 12:36:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009832cf060e9d622f@google.com>
Subject: [syzbot] Monthly udf report (Jan 2024)
From: syzbot <syzbot+listdcb21f43dac3dffd8047@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 1 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2016    Yes   WARNING in udf_truncate_extents
                   https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2>  250     Yes   KMSAN: uninit-value in udf_update_tag
                   https://syzkaller.appspot.com/bug?extid=d31185aa54170f7fc1f5
<3>  144     Yes   KASAN: use-after-free Write in udf_close_lvid
                   https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
<4>  39      Yes   KASAN: use-after-free Read in udf_finalize_lvid
                   https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
<5>  37      Yes   KASAN: use-after-free Read in udf_sync_fs
                   https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
<6>  20      Yes   WARNING in udf_setsize (2)
                   https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<7>  6       Yes   UBSAN: array-index-out-of-bounds in udf_process_sequence
                   https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
<8>  5       Yes   KASAN: slab-out-of-bounds Write in udf_adinicb_writepage
                   https://syzkaller.appspot.com/bug?extid=a3db10baf0c0ee459854
<9>  3       No    WARNING in udf_prealloc_blocks (2)
                   https://syzkaller.appspot.com/bug?extid=cc2b732891efbf755b78
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

