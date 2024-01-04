Return-Path: <linux-kernel+bounces-16749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3966824346
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70003281A31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4C0224E3;
	Thu,  4 Jan 2024 14:07:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A7224D1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35ffb5723e9so3063895ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377223; x=1704982023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwuboY6FyFiKDs82tpZyy576XtNf8N//DNMnjf1JlFE=;
        b=qcV5xhqNqnQnD4V0Fi2oLIxyCxd11iZa2w8qh/K6ZHqJ7F3gA6Gu8Q1KA7H0oluKrP
         VGbECqYMk0NVAboo1ByAz3sQIk6zoWHj24gEp9x9hdrCLuou/7/FpYoJIYYhxmATIETh
         vcMK6ZyZjTXPa9z5a6SV452vJ8GIaxHGluw7M08eVt+Hu+HDZBJY3dzh8iOkqQC/vOZI
         AIV7vMbtcG5EHH2Qvay/jBV967PXrs0nwJT9f1cPQSY7KIKNSNMiViswlIJI1bhZkDhu
         mPLlGvIzFKr1W4N57hJ781zDfemHZuJ+mf3ZwjxcFYABg8HiyIEjwP4QCq2/fZsfhiU7
         GqhQ==
X-Gm-Message-State: AOJu0Yz9As/hfGu8rY0G05Wy7Zft7+/ZY5/KqdbkEcicO44mty7GUv9W
	Gup4pqwOpgzyrrv5malymXvqNARQHpBv/e973L6jm50frmu0
X-Google-Smtp-Source: AGHT+IHe1abxsr/kFy6rqPSTL2+Jk+6QTNU0avasac4TrZsNBfEfSVGRGlgz78mYZJUrP15A3k6yA274Z+6cMuDUlGzUUYjo9wc0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:35f:b715:ed36 with SMTP id
 m2-20020a056e021c2200b0035fb715ed36mr101147ilh.5.1704377223765; Thu, 04 Jan
 2024 06:07:03 -0800 (PST)
Date: Thu, 04 Jan 2024 06:07:03 -0800
In-Reply-To: <tencent_E286962837EA4A84759D77A766423C3D3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc692c060e1f3e06@google.com>
Subject: Re: [syzbot] [fs?] [trace?] BUG: unable to handle kernel paging
 request in tracefs_apply_options
From: syzbot <syzbot+f8a023e0c6beabe2371a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f8a023e0c6beabe2371a@syzkaller.appspotmail.com

Tested on:

commit:         453f5db0 Merge tag 'trace-v6.7-rc7' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12992036e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=f8a023e0c6beabe2371a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c2fef9e80000

Note: testing is done by a robot and is best-effort only.

