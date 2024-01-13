Return-Path: <linux-kernel+bounces-25176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B73082C916
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A57C1C2299E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D870E18E0F;
	Sat, 13 Jan 2024 02:14:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91617C8B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7beebd130aaso427369839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705112043; x=1705716843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHYbvCt1dFms4F8qbSw1Ojutr2wHReSKQ/LxxsmFLWk=;
        b=G51y/4+BlK06bQBm0oQdeEvq8Gj64qZxmG5VMoUM4NkjgHGWy14btCaq1Y8z2Hchxw
         zWMFKZvKc/qqXjnUy0Oo8tSkGbymG2UFktNo9suHtzl+zQOioT3HMtrxPCcazJx/06Ar
         klsfzJ/AEMxEC4+SxDdNpJrKfSV4dwBNOZCXoPrT2vQrD8B/aEexP9ZB0tfOxBvD2emV
         TnU3EgrsObPfVxsnPkaHQyOCPXfDJRsYt7davNIWPcZVcTaAxIGE2HP3mcGTJSNybhjG
         vco7eV7PlZdyMnn/3u7TX02FMazrHkBJaObdBOaQGKKUE/OTMEzGhB/gEY2W9/+ghTPT
         MrRg==
X-Gm-Message-State: AOJu0YxDFdipcQ/Irmn7CHZsTjwXBQWd6UZdyZw5JSnkrQHUB9TU2j+I
	fUiEKz1XWDS4aeVGDkavrn/HIVtop0rkjQQLNLheJNuwpd+s
X-Google-Smtp-Source: AGHT+IFZ9D6C5lYntwSK9hgYr1AGnAl2xBuvBeb0yDcDWtMY+sDaaSFYVivN/UGLORpGEfoKKkRIlrgjE9IE1FBnl+tH/siyvgd+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:360:e6b:bc4a with SMTP id
 y13-20020a056e02178d00b003600e6bbc4amr161467ilu.2.1705112043380; Fri, 12 Jan
 2024 18:14:03 -0800 (PST)
Date: Fri, 12 Jan 2024 18:14:03 -0800
In-Reply-To: <20240113015011.581-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5e984060eca55cc@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in kill_f2fs_super
From: syzbot <syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com

Tested on:

commit:         23a80d46 Merge tag 'rcu.release.v6.8' of https://githu..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12d219f5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=490fc2f9d4ae426c
dashboard link: https://syzkaller.appspot.com/bug?extid=8f477ac014ff5b32d81f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151461cde80000

Note: testing is done by a robot and is best-effort only.

