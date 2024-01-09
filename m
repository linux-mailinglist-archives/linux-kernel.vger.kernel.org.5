Return-Path: <linux-kernel+bounces-21377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A979828E58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CDCB218A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A73D961;
	Tue,  9 Jan 2024 20:04:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2AD3D574
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fc70bd879so25305465ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 12:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704830644; x=1705435444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PkUQkauKqA5Tc/69Ts21dgm2IenD2ZL2Uz4ahbo5n8=;
        b=kN7R/ColynCICq2/mdkHhsPKjYAq3I9alC1q6+kTzhzJ4ZM65u6uwUYChyRZ2Wf0QH
         RxiR6Yj38iep+RfmfTKkS4g70yDAi3Yf2P2sWhFYVnySmRA3B+l9u2AU/BuLfOKMN5Bb
         E95g1x4P1c1sC0b0U3CDlT9Kv18Ql1Tg3tglh7M7gAzbu3oXFPvqjR7t4lZuTW2ingz0
         w7Uunj9qJcQVpllacdxyxAWS94TbuNajIWZ4vzp8BTuMAqVMCZKKQBAjuhvpXOs7AR2b
         CrJeu209b9zCNzp2hT3rYNO/QTxx2iEd2P8x6wip5joXEwD1dHS0a2OM2EzoU7HtolJu
         WZUA==
X-Gm-Message-State: AOJu0YypQN+S7tXQxcADiDZOWbDBnGYBCssur05t0316JCuG7g0s16W8
	JEdNXe7d2QEMzI3392gQ1SEwKiS+likDlEUoFJsSXolUDyHn
X-Google-Smtp-Source: AGHT+IF6+4z2B/MyxbEaj12WXkpRqE3w7ehv/0PEh25BSD3sOMyxjEIxxW2EQn4FhG1dRjHE3FP7Ypsqx3e3wL7kWz7t95v90nQV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:360:6243:433f with SMTP id
 w11-20020a056e021a6b00b003606243433fmr671695ilv.1.1704830643904; Tue, 09 Jan
 2024 12:04:03 -0800 (PST)
Date: Tue, 09 Jan 2024 12:04:03 -0800
In-Reply-To: <20240109193304.7pc27uzwm5dtudk6@skbuf>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eea95a060e88d051@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_changeupper
From: syzbot <syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lixiaoyan@google.com, netdev@vger.kernel.org, 
	olteanv@gmail.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com

Tested on:

commit:         a7fe0881 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f5ed75e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f71e27f13422e1cd
dashboard link: https://syzkaller.appspot.com/bug?extid=d81bcd883824180500c8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125c2bf3e80000

Note: testing is done by a robot and is best-effort only.

