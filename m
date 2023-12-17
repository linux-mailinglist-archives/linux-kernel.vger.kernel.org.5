Return-Path: <linux-kernel+bounces-2481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B4815DB9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC861F22271
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA00E17FF;
	Sun, 17 Dec 2023 06:09:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9015D4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7139b04eeso262434339f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 22:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702793345; x=1703398145;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKsOT6BiA/k+wQHy37UQb3Pwc/fXw+kYz1lX8d/XdKo=;
        b=UdEbEPtE6HN4nDMoVfH55PLMW8EQemUaBDWosQvNUQlLc+qzVf9QF6aoHqaXoQudGy
         baMx+YudE++fqUbnaGnQlSW/Wn4GVOtl2/yu0uGh3inLki+o0BRydHDX4YNbp3Lse9lH
         nNZs6cvacDRUdH1HFka35ltQHA/RG0vwJxhKjqtEOr7v8UEWqjLGCTIjyeUPAdOlmZtg
         IJL3uY5vfmoC6w9AtTcAt24055gIO69N8tSO7tG2A6v2pHJwWLCRnnsJxbIk0IsZkb9P
         wQerYJ+CWtaPGNFl1E0AjqdwSnprthiHcfuaLHA+LsgX0/3w8ERjk/Pt8DKicxxGkHFU
         WpnA==
X-Gm-Message-State: AOJu0YyVKmaoTsEESVwx61uX/gPtVu/Gdl4nFI04fUmUJ5osgg7jerBN
	6JaSD1P2E+j6vq21wByTmmXlWHAYuAUhX+MzXPCRY+PapWnC
X-Google-Smtp-Source: AGHT+IGGThWWKuvATGvwpp+qGbtMU2qLtIhTA4GWDArlxDVvehfH52vsJZB619wJU+Gci1rmlKBsoNzioDTlBxrpgDMOhFJ1TigJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1926:b0:469:1d65:d4f6 with SMTP id
 p38-20020a056638192600b004691d65d4f6mr437828jal.2.1702793344893; Sat, 16 Dec
 2023 22:09:04 -0800 (PST)
Date: Sat, 16 Dec 2023 22:09:04 -0800
In-Reply-To: <tencent_5BC6CF6C79EE6E5C2E016F209494EBF2EF0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072cca0060cae7869@google.com>
Subject: Re: [syzbot] [reiserfs?] [squashfs?] BUG: Dentry still in use in unmount
From: syzbot <syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com

Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17c50eaee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=8608bb4553edb8c78f41
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16559206e80000

Note: testing is done by a robot and is best-effort only.

