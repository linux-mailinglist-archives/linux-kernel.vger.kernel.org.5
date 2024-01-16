Return-Path: <linux-kernel+bounces-27394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FBB82EF3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73ED7B20C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5721BC37;
	Tue, 16 Jan 2024 12:56:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77101BC28
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fffb6fe5bso96871155ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705409765; x=1706014565;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlQR34qrguYGJVcu0GvJoEzs72QBX+M6+BUFeXf3BP4=;
        b=IJYmqNcdNs1alcVo/mkUgH8dDHhtbtpSAR48wlXCIFLAcnRjnxct99UmQ4tBpw8djN
         uXaQ/89505QWfPpfb0fKer/VbHM1THmZD9dYXcgqa+Bprt5qRe5rMHt/ynhbDX5FvSdi
         Do6+oAYMMVfZJ16UpCvK0Q7bD2P4IpdWBVP+atBbfb5X/EQzhCcVxAxa2AFfJIB6eqtA
         RoUhSvq20t8JFZ+Ev3gyMqcmd0KRMXLvUVPRi4Rp43ey0xMcJpDCKldFRm/vE6yyZH2Y
         FgrdIGdLO7YcP9aNdXKPQjy4+pjA5+wEC2ttubK9OPLqeQOmDQe7VZ7HHlegL8LGgdz7
         54CQ==
X-Gm-Message-State: AOJu0YyTrUzeewcfToQLPFfpeuuUqa7nJKT0G+0kiANLoPUY/y0srQGr
	0BvvUpN4sO1KVwostZwBQJnvSalOnr3o0e1f94klzLbNEdjc
X-Google-Smtp-Source: AGHT+IEO/u9xD/0gPeWXAdpkf+MbIHaYBqNE03WNYe+YExLvEESshzxHFDt2VHVn22uz9qakhpUp6UkYRSJXhREernQQJ2vOBJc0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:360:96fd:f542 with SMTP id
 w7-20020a056e021a6700b0036096fdf542mr1065840ilv.1.1705409764965; Tue, 16 Jan
 2024 04:56:04 -0800 (PST)
Date: Tue, 16 Jan 2024 04:56:04 -0800
In-Reply-To: <20240116123314.970-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003cc2fa060f0fa766@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
From: syzbot <syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com

Tested on:

commit:         052d5343 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1599ec2be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=490fc2f9d4ae426c
dashboard link: https://syzkaller.appspot.com/bug?extid=7ec955e36bb239bd720f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107e9733e80000

Note: testing is done by a robot and is best-effort only.

