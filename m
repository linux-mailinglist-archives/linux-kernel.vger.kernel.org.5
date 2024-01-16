Return-Path: <linux-kernel+bounces-27481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FA382F0D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307C8B22405
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE861BF35;
	Tue, 16 Jan 2024 14:51:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591861BF30
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf2a5cd631so405525539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 06:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705416664; x=1706021464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3nfj2QnO5thAqpj9k1US67cffhxYSl12LmfTRkOHtE=;
        b=qFvk9NiS3KHAXoaL/Hmf+EqJY7kP4OOfqiENMBIlmWLat/VYzMn39sMG7QgD9Glw5c
         8epFEk2w/dJwurEtHArkq2mPjeu9TuV7W7kY5UbPauXS2o8NZBLm9G/+VFf9I6nkxnOg
         vEsDTiboB6BXYMXHCAr3xnSw78Cdzjc5hVo5ftjH0f9SHCFdH3pmwzcnohmBfPW+zu2A
         tjZrcV0ElXc8/HXtdoGMhnzxspXJqkTJs5YrEs4ZDV5GKUtLAUiFOCO+6gZQ1Y5uz9HJ
         evgZgKNK8lQ/916rHAVGM3IGgH4TWFer48KLLDPIi1BCRo7VBjjXjqeUH+lM+mC9MKs1
         iSSQ==
X-Gm-Message-State: AOJu0Yys2Z20++I7uEGeM+htczkU8lc1iNr6YqApYvWp7PFQPTYn2odq
	N74ypxdjjQZ2TLdt9TVSBT0FVIE6e7K3xzrAfXDVxuSQz+Vl
X-Google-Smtp-Source: AGHT+IHvRAEZVWhekiBIfafZS4y+aPybq3Jd5Q2FI8PE3sxGY+J2T2vUouEz97EmoC40rzmAZqSsztuu7ivQy7WJqsVfVxzCZYFH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:360:7783:b60 with SMTP id
 v12-20020a056e02164c00b0036077830b60mr1089212ilu.6.1705416664513; Tue, 16 Jan
 2024 06:51:04 -0800 (PST)
Date: Tue, 16 Jan 2024 06:51:04 -0800
In-Reply-To: <tencent_CBECC6CDB07A5A6C182C156DAC9490EB160A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b82a3060f114263@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
From: syzbot <syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com

Tested on:

commit:         3e7aeb78 Merge tag 'net-next-6.8' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16bd716de80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e557b1c0a57d2c0
dashboard link: https://syzkaller.appspot.com/bug?extid=7ec955e36bb239bd720f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e1ff47e80000

Note: testing is done by a robot and is best-effort only.

