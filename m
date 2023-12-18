Return-Path: <linux-kernel+bounces-4085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD2D8177C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE411F25486
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EDC49895;
	Mon, 18 Dec 2023 16:43:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0D1E486
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fb151c89bso16573715ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917803; x=1703522603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEnH9DOn7htdFLxlz85xz/DnYEHpLVOwxdzfKYN97ZE=;
        b=qN5ja9F1asihTNyjK5XoZGXjYhoK3v56sYuhzivz1RZXxzIcYYjDs3cuHQZQv6WbQw
         aPRxz6S0YzWz6iNpHIr1sTQFFzQDvgHFqgdj036NrAFPAkTcghbrxDz3zBu8bvV9R8Qe
         ZuJXmV73D4CHx4InHRfr6qZFJUuTfXVtI4osx2bwhB0nmGobH8qkBID+7vVSmwCVHT8+
         gqRaMag7jHt+ujqhfCd6R7yu0nS5yWjuihRJYW48RFpU30JgwQ8BZ5eGlSHgBSq7mt1d
         AhXGtx7DklrxC2I0E7ZOow94sa7bEK1YIhoO16xkqpXMzn9lEELqj3PDwOULJgZtDx0V
         4x3g==
X-Gm-Message-State: AOJu0Yw0PJXkv77R0O4e8AtsXTny6sBDN9YG3vOcON9TmlI9rEclBZxE
	pq+5TNtOvH7ZF02vSE9gm6LpKC9xzf4E7+HLVNgNEeodHclaGio=
X-Google-Smtp-Source: AGHT+IF4wvXEHfOc3ZSuANzi4m1bDvhjZf71Zka5lYRnL4qoOZz98UZyuXVBY4Vn79HA0t8E0W2CAZ+Cjrxd2RVUVEhZVH+Guf8E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:338d:b0:35f:b2f8:6ca3 with SMTP id
 bn13-20020a056e02338d00b0035fb2f86ca3mr250224ilb.2.1702917803210; Mon, 18 Dec
 2023 08:43:23 -0800 (PST)
Date: Mon, 18 Dec 2023 08:43:23 -0800
In-Reply-To: <000000000000ab8015060ad3f9bc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be00ba060ccb7291@google.com>
Subject: Re: [syzbot] go runtime error
From: syzbot <syzbot+b8bbc03ee7bf80fc9f78@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    610a689d2a57 Merge branch 'rtnl-rcu'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12ded821e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df5e944701db1d04
dashboard link: https://syzkaller.appspot.com/bug?extid=b8bbc03ee7bf80fc9f78
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16da084ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1698c13981a/disk-610a689d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21213e55dd47/vmlinux-610a689d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f85e89cca69/bzImage-610a689d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8bbc03ee7bf80fc9f78@syzkaller.appspotmail.com

fatal error: Connection to 10.128.1.63 closed by remote host.


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

