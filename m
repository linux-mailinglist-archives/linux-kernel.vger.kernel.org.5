Return-Path: <linux-kernel+bounces-13623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD96C82098A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 03:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F16428363A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 02:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0A123D8;
	Sun, 31 Dec 2023 02:15:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88520FB
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 02:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fd46fe86aso97341035ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 18:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703988902; x=1704593702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tzz2GtFrkOgXzeYUvw50nmgvRrC1drHiZnZIOoJ1+A=;
        b=RLIPFPg3vxq5ycHM/uS0i5I2cS4+QDHEXxLLlxKZjKy4MvnDa9Vylww92j/01S5eIb
         YBPszoHvcfoi5ePbKhItEmOmLRalKOx1E7tL8z4CxE9y12XxWepn317LNHvY4kdZUJWS
         4zVjpY551zJrKrDtiVFO/FmEqSEuWZqK1yunhc0Daf+rPLka+YMHmTqtfpCUlDAT7j1u
         LiUHyR8XENKmfHxYN6mG7iB5ASz/cuuNpRLtVIrjxJ3t/CWhbEOiOcfh1KGgPg1DDGyK
         qjT9gdGB1r2JRbWPRXeXOp2jKd3kDmMs2X4fj1EUqKGCVZK7u3EQxyqFdnhRQWJmvQ0R
         lSUw==
X-Gm-Message-State: AOJu0YxZKGZSB9scxWLcREMLVy1a6HKVRi2CrNAkgWO86zXfNcDWNfqQ
	xEEemu36K7XPR+N3ZzY7KBjk6HW0l+WrUeNeM8PutH0uuPh7
X-Google-Smtp-Source: AGHT+IFg5uw64E+lUC8v/SoG8OSTPMpz9C2zyBqhtnLUjBMPGu53G/YEP7dngx/g7COTfbl697mH00Y5jghBZIO5GTdwUMyIqP4B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2191:b0:360:9dc:888b with SMTP id
 j17-20020a056e02219100b0036009dc888bmr1046913ila.0.1703988902743; Sat, 30 Dec
 2023 18:15:02 -0800 (PST)
Date: Sat, 30 Dec 2023 18:15:02 -0800
In-Reply-To: <tencent_72978236184B82740F7673674C3CC3360409@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fd613060dc4d5cd@google.com>
Subject: Re: [syzbot] [kernel?] KMSAN: kernel-infoleak-after-free in
 copy_siginfo_to_user (2)
From: syzbot <syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com

Tested on:

commit:         861deac3 Linux 6.7-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13c1bf11e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=cfc08744435c4cf94a40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13310ef9e80000

Note: testing is done by a robot and is best-effort only.

