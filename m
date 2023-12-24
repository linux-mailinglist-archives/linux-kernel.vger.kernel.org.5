Return-Path: <linux-kernel+bounces-10679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFA481D89F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9CD1F218F7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E3920F5;
	Sun, 24 Dec 2023 09:37:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2B61C16
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7aacf63b9so192887739f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 01:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703410624; x=1704015424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+LC9FYci2Zpvun7Mme5i4TSuf6KRqmZtDZbDvVd1r4=;
        b=lbVLe58NsO+raJ0vfyadnoD/tLjSSwyHPpkBitGt+XghSxEcRGYvqoNj1MJtDXJNPX
         tnPPx5Ve7TgqzJx4uJTPnoO0wH0geJpr7qNVchXfeYhiYo+htATmkCHCtXWNAc1/cBjR
         5qTI9wQ2LaUSLk+R6/4F8YjyMDOfcUBpyTEzXfFulsj8N+zOoWoEFsP2d4e9LgMM0YMw
         QTIumABQ41EsuqiNBI7ZGKdKtFkV5MEwDyzs23acNDSiLTqU8sRyScDn5k66PuufB29g
         xRtAG0OFVFtWcaalfVqwbtM9TP7DdIjouO7XbSi7YiwU3Ie9zGvBrN1XomjsaR8x5XXe
         gjIA==
X-Gm-Message-State: AOJu0Ywh6wlekajiJllLdAWSnYk5fjTNn5DPqmX4wmCt5CEMndJYhwDf
	ugVMJydBmkV6jxs8oQiXPvwXO+SKplz6U3+kiO0fUBp4erU8
X-Google-Smtp-Source: AGHT+IH+XeUQHc/Xvd+2T3xrf0wPfIcMhCiiFhHwXVY9X1l0Xm7AanFF43frG7ES0dpEfg7IliHULYpnQO88pBNFaFVEgErWQCqh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:c745:0:b0:7ba:b9fe:9338 with SMTP id
 g5-20020a5ec745000000b007bab9fe9338mr30444iop.2.1703410624203; Sun, 24 Dec
 2023 01:37:04 -0800 (PST)
Date: Sun, 24 Dec 2023 01:37:04 -0800
In-Reply-To: <tencent_DECFB60DE7258B8DBB121FDDC75DCF191707@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000299791060d3e31d1@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in lock_two_nondirectories
From: syzbot <syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com

Tested on:

commit:         a39b6ac3 Linux 6.7-rc5
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156be7a5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852
dashboard link: https://syzkaller.appspot.com/bug?extid=2c4a3b922a860084cc7f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c773d6e80000

Note: testing is done by a robot and is best-effort only.

