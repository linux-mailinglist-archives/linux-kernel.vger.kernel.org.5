Return-Path: <linux-kernel+bounces-7895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8237B81AED0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE19B1C22912
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA84F15E9B;
	Thu, 21 Dec 2023 06:35:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320FE15AC5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fce5a5d3cso5927935ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703140503; x=1703745303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOB2xyfv3gPTGCHBOVv3ydZYN0fASqgWCX/nV/93oCg=;
        b=IXC9Y0iMJm9IK85I1gygfd8kxECWTjwyQZ98/0XZrGfM0Id7UQBD22c7hjWD/Df4tl
         xPzpZUc3W1H81kaL0Iu7qCBlHix4YyDA6AzuHtwjeMsk4j0qawtb7DkQ29VqNpBdL9qO
         XP/7qbxuTZ0d9rFk3cLPqMDfdDKQm5fNIEAW6gZDU27X0B0VFOH4fMRzWcXIHqTQR/nA
         Iv2frJktad+t658L74lSx5y4XsP3quJL8k8PhU8YSesBZromJ72ex4qbPA44g7BNFSJ7
         HJugF2rsUBypWsyA4Cyh0jk8Hp+Zhux158oAiSWYADNAtI9Akxe9Yf5cdwOHYpmbV4SP
         CDeQ==
X-Gm-Message-State: AOJu0YwB6gWhLoiCnxDUXqq3kjRK8NuHsQfwHWgcHZfSAN1Zi8gpooCV
	FrvVRXOVniHGUFijl8oegCXCvivp0b1wxS+KPUTyUtRwvCaOeDg=
X-Google-Smtp-Source: AGHT+IFwRy6s+63Gv8edU1yvZUZFuVwAr5ohZmW2fUHVkN0/l7wu9nZhniyZ0NJtAKOSi25Joxhc+M0+2wyZvvpo7NYUAaw9m3oQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c569:0:b0:35f:a0ff:de13 with SMTP id
 b9-20020a92c569000000b0035fa0ffde13mr1129674ilj.3.1703140503468; Wed, 20 Dec
 2023 22:35:03 -0800 (PST)
Date: Wed, 20 Dec 2023 22:35:03 -0800
In-Reply-To: <20231221061105.1471131-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b64208060cff4cad@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_write_inode
From: syzbot <syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5341 } 2673 jiffies s: 2901 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         f9ff5644 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1555014ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bf08f50e8fff9ad
dashboard link: https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1056bb4ee80000


