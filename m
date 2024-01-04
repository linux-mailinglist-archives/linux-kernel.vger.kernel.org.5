Return-Path: <linux-kernel+bounces-16650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 437EF8241EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D9CB23E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5774E2231F;
	Thu,  4 Jan 2024 12:38:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32581219EC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3601c1b80d3so2222485ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704371900; x=1704976700;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29vKqyfc3rV9TWRt2Gj1PJyuGORtA41yInRUncgp5D8=;
        b=o7YX0TN+lW4exGspogEUHy+a5HB+i7cjZXS1D/enFg0dVwdl0FKBVuGsKC5afRMoOX
         qknjxNNShqLG0mNzXJxF6oxxhjy43aTXKHkwJ5UqNIqFGIP/cf4+wVaIGUgCIKXAXjDS
         t3RZyoY80uN9eWZ/SY7LoXfDMM1/0jnJxT6aJw/SLBt7LaiE8K444UqJ8LNp3pU3kJN6
         rDXArHNmWXEoT+XiFGGlh/DJLMFLPLX6C4IHoU1wDvbU/vlvwRF9ZmiUIWb6yEdC38UL
         RCOwpOmB/Cyw4tID6Bi7eEeaJewo8qCzszDvDX8sgddecNVjcJzLUMtkORHWw/APtYyt
         mnoA==
X-Gm-Message-State: AOJu0Yx9z4Q9oq3lT6SVFQYHhhylCGyS9PGpXyalt8f85Nq6Vl6GafCo
	eRQt++98ISqmze51sdWGbdLmgv5+cLqv/3g7scttZavzpJ/W
X-Google-Smtp-Source: AGHT+IEUP00O8rJlVEPYvBOluunoX69MB19JiSdhuk1kONVA0rztCerYPwFQ5phiJB+3V2K+y5sss4t+z+WJIyyZ0jG5yB84LSgJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0f:b0:35f:bea3:c041 with SMTP id
 i15-20020a056e021b0f00b0035fbea3c041mr71618ilv.4.1704371900477; Thu, 04 Jan
 2024 04:38:20 -0800 (PST)
Date: Thu, 04 Jan 2024 04:38:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b17b66060e1e0151@google.com>
Subject: [syzbot] Monthly jfs report (Jan 2024)
From: syzbot <syzbot+list79e3e44e965579bc0c82@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 39 issues are still open and 21 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1579    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<2>  1247    Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<3>  930     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<4>  567     Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<5>  479     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<6>  331     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<7>  239     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<8>  234     Yes   UBSAN: array-index-out-of-bounds in dbAllocBits
                   https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
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

