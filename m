Return-Path: <linux-kernel+bounces-26844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFD82E6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CDE2858F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFCF219E5;
	Tue, 16 Jan 2024 01:06:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382A208B0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-360a416bb22so55046835ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705367165; x=1705971965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYK71raMqp7ZcP5x298B8v4PykW3KFYvzrDO5E0K+rM=;
        b=nlGznlWbHLp7HcY44wh30ai5TXk3xRHNADVJx7Uf3TTt6BciW2n1wk6N0Omc/n95Xg
         nPmKkECA7IDmu2uEY0leBM88kGwRxhmPmmPPYA40LMzr2XOAOTuEUv0tfo0khO1ybAMG
         J62aLBRiGSxmQXFJ2b9jyNJjEvT5ApAbY8ofdpezm9KdNHUKgk/lx+xkTTxcystoMKxR
         rZZrHbS432vKP60uEQrzvGJhHXOuA+M54bpgm0Qg9kY1ZnvyFkF/Am+XswuD+CHRYWk1
         keFOW4Yofo+gxxj6PQaAtctdT7CAWDnZiyf4CFfnjbt7IsSENg5xgWkM4+fQ/ihYS1bR
         XnpQ==
X-Gm-Message-State: AOJu0YyEwiNfDaLOpxBrU1p0k2j8CgPKTdxe1IxFN7RPnBS3dbRYnKWk
	WTh++tSUjQZP3/Sfgmv5B4Sz1lM91YuY1t8tNg2GZAFSVVoc
X-Google-Smtp-Source: AGHT+IF9+XDIJQk2HrBcrNSil2jO+KrHAL7qJTEp5045mZGwwARcy8dFfPQU1yDYxnW3r2iiuPrjpzdz5oWTXXmNS7r0DLD9fzvx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd82:0:b0:360:795e:a6b3 with SMTP id
 r2-20020a92cd82000000b00360795ea6b3mr765458ilb.4.1705367165249; Mon, 15 Jan
 2024 17:06:05 -0800 (PST)
Date: Mon, 15 Jan 2024 17:06:05 -0800
In-Reply-To: <tencent_6543A4C44A9773F777A6CCB372437DE97905@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018af0e060f05bce1@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in
 getname_kernel (2)
From: syzbot <syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com

Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13bc50dde80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14343dcde80000

Note: testing is done by a robot and is best-effort only.

