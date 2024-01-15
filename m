Return-Path: <linux-kernel+bounces-26432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0A882E08A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0137DB21CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B93D18EA6;
	Mon, 15 Jan 2024 19:17:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E618EA0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fffb6fe5bso90039545ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705346224; x=1705951024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRJQm3WCu0qZMEYzgD+2E6tGaJUFS4vAonRPZHIDhWg=;
        b=EOLNtf/vdR56HT1DXcoP6mDerVvZ2/fefY5n+QnoKMqcCrGaKRNrM+Nvpg/9rZ/I7B
         5iIHnJm4krhZr4i1iTBYDTLQBKxc0+jxpsXjtFZcJezr3gFAJHxDS0nhdosdER7YONTw
         i+kosb+ahxVoNKsy13UbNInq72xy4+o62ZGVppICq4K0MKfglC3y+dhZBOliHpYiS2hc
         XIqiEq/U6HdOrW+fgef1jwtUAG7CrPZDyUwLNCAPsOe/mExXqqTV+Yf3u+U4ije2tM7W
         tJ4HSx1ctZBIFDQO2QMJ/DerCnPkUHoEyTcmV203ZYFwVhuhOyxvBAdCmuNqbM+FtR4n
         wQDw==
X-Gm-Message-State: AOJu0Yw6GJSE0fC8DV3nHDXTkkCefkpjUA4pepfNvYdk4lBvikE+5Yvl
	IL83OPMwusUnyWhOcwWOqpDJFI7d86ZpLK9yaJrxxO7oNYNh
X-Google-Smtp-Source: AGHT+IFvxsWdPC28mrO4Fw38tzncdjJoD9cZXEdbACTcntcOf5VnTxGu37+OkBEcrAobsYqXQ3jm7Y4LxER0mBoJH7KtMa+OtN19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3885:b0:35f:cb88:883e with SMTP id
 cn5-20020a056e02388500b0035fcb88883emr868598ilb.6.1705346224102; Mon, 15 Jan
 2024 11:17:04 -0800 (PST)
Date: Mon, 15 Jan 2024 11:17:04 -0800
In-Reply-To: <20240115120535.850-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8222b060f00db3b@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in f2fs_filemap_fault
From: syzbot <syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com

Tested on:

commit:         052d5343 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=105a1a0be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=490fc2f9d4ae426c
dashboard link: https://syzkaller.appspot.com/bug?extid=763afad57075d3f862f2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a249b9e80000

Note: testing is done by a robot and is best-effort only.

