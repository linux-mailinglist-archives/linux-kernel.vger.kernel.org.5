Return-Path: <linux-kernel+bounces-15520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7BA822D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA031F23C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEFE19447;
	Wed,  3 Jan 2024 12:37:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB218ED9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7baec2c5f30so816652839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 04:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704285424; x=1704890224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvsRMG8n26LNAFfnpUjLeRIf+262RyaNRGP5TZa8W8E=;
        b=rQt2+bUIQywfvGFqbzSptwfRmAMYs1qcyzuVJEwagjrj4qA1N33PCt/mWbKs2a+F4O
         oof0iYfbfAttZKvrJ+sCnxzGF3Vu/0bgi3svYn28KhNiDxaI7HVw26vtOu5Hd3J8rbFA
         RmFG12kUh/lRsZ+MBp6sQAST+YDz/JsWvn8K67c6hUxLxpPsTABMO4k8f6ETc64HFLfk
         ljexUU56qUsaduOp4uT1QxmRACcAfLO3p2WFLOvSVeWwupIPj/b5y69XmT8nVJKkyM7U
         VOOX8GRwiuM1mN+rpd5WZLVBe0D170Kl6IE+EOXrwqOmaPRAoI/nGaWxyE3671pRNUjM
         ue/w==
X-Gm-Message-State: AOJu0YwsAajKUPTGaK0seEQuM91LyiNUptvsRLEXkvB0UOD08nJHTOCs
	0nf7Z0CMoI0w5XEfUoUcR2Uh/q2LVLtEn2fBg/lqgc0a7zCH
X-Google-Smtp-Source: AGHT+IHcjTrHRyt6bBrFesxqrvpW/k+UMfDVp5njmbV/k8zn8Xd2Ism31mYfBRfgv9mpyiRvbhL2B5+uwWS+RgS/AukP9wTv0gQO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6423:b0:7ba:8e6e:25a1 with SMTP id
 gn35-20020a056602642300b007ba8e6e25a1mr857389iob.4.1704285424707; Wed, 03 Jan
 2024 04:37:04 -0800 (PST)
Date: Wed, 03 Jan 2024 04:37:04 -0800
In-Reply-To: <tencent_5292EF864E49B52EDC6EF0CC99A7E4C6C306@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055ee82060e09df0d@google.com>
Subject: Re: [syzbot] [reiserfs?] general protection fault in reiserfs_xattr_set
From: syzbot <syzbot+74dce9511a59ad67a492@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+74dce9511a59ad67a492@syzkaller.appspotmail.com

Tested on:

commit:         453f5db0 Merge tag 'trace-v6.7-rc7' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=110b4145e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7bcb8f62f1e2c3e
dashboard link: https://syzkaller.appspot.com/bug?extid=74dce9511a59ad67a492
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f34145e80000

Note: testing is done by a robot and is best-effort only.

