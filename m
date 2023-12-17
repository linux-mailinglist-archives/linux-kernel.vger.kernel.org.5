Return-Path: <linux-kernel+bounces-2590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2E815F2C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C538428308C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C2444367;
	Sun, 17 Dec 2023 13:08:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADC44360
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b764f195f7so307467639f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 05:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702818483; x=1703423283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdyv9Xwi2jo6ydXa4suryWSiTcveYA05ELpBHtL2nqY=;
        b=r3kS3b7WhB8aQ6Uag2Pw+1l7o+AoU+v4rPIufQYDT7XTMmcdkgqt/RI9lZ40OdM97k
         pWIqhWLFgASbI84Ps6qyf3i8vbA2djJQZR/ZmxvyjtzMf0/qUvwOflQ65zp8D2AJ3fki
         WmN9jOcat2+2uF8KNuc0PbQakxGe1nMOSJGfcBb1STuEVgwjYyIGRLowVDuaKw9M5n2h
         gu+ia5NVzXcCWCvzMVllUOFpLFkQxyPk7gCVUkqoaJdJfbVlddsLGRsCbH5FcSwYRIrB
         9NMCpmj84KL9+44WquAPzHiC+HSNbRQ4YZ/fCKej+3Su7y7OrsylSuAaeMpklYngE3eq
         ctYA==
X-Gm-Message-State: AOJu0Yy92kwGq/6V3IxUzn6Tc3wTJLLF83j6dR6Zsyly1kR5CqgUWpqG
	eG2EFO5rgodEU0EnSnaBC/uihFdsDsL0qgMwbQidVqtQJYLo
X-Google-Smtp-Source: AGHT+IECl1tQIL3Vglu4Nqg7zZ4e9lXlmZW4mf8eoNcHSN4umy0/ZEIJgrtav+dRj1VMANvUU3i0ocYCTdbG1aCb8MnpsGyfaoRU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1445:b0:468:ea74:9e02 with SMTP id
 l5-20020a056638144500b00468ea749e02mr764285jad.0.1702818483665; Sun, 17 Dec
 2023 05:08:03 -0800 (PST)
Date: Sun, 17 Dec 2023 05:08:03 -0800
In-Reply-To: <c9fe11ab-ee9e-40e9-80e5-0255d188eb4c@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5ffde060cb45200@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From: syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To: code@siddh.me, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         3a3af3ae Merge branch 'skb-coalescing-page_pool'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=179b9d3ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5829188f6c40a71
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f80556e80000

Note: testing is done by a robot and is best-effort only.

