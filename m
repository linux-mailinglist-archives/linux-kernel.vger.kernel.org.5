Return-Path: <linux-kernel+bounces-25471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FFB82D0C7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27673282013
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87E85228;
	Sun, 14 Jan 2024 13:43:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42513FE0
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fc70bd879so63914505ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 05:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705239784; x=1705844584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjA9NqzawmaS/3nEtDF48BsDD+cFNWsitCCxUTooQ78=;
        b=ix1Iqv7KP95EI96SZwS5fe5wKmvXN8urzb2jUcDpd64a5/2G20XZ88WABT3whWt+XN
         nFwyi/rTLpN5LSWrLxEB4BvmCuM2IHlC3meJoEDWhqaD5ZbYdbcLMasrdLKgoFLHvfO2
         xxIalo+ULd6kzMXpfllctnqHGq9PmJySgmqQuTM05qlPhLFErtYyh7MJ42jQu4zXKO1D
         JliewIp3eCoQ58+wvYZaBy0R+srrRuhBx0KGcSUEptViOGIX0bob6n2Ain1Uyt1Bi/D+
         ZjdU9y6BvhNUl7mFtRAHsCScSarBhLy/z01mcbjtUFp3XTEcRiRfm3X+mLLCGDCqrmlU
         b6BA==
X-Gm-Message-State: AOJu0Yw+JJPos3h3Nk76DytJ8xDSG8rD4lVdRkYkjqI1rqTP4TMzzSD0
	Ik9eLjH4oYTl2AyKjqlJbjxzpniBSA7eUaamiJU9q5SqBhH6
X-Google-Smtp-Source: AGHT+IG9jgfyBX3yhCEW4q/QVjn+eQox3Y1EMySJDX/BNCJYG0IuP+zRs8LrCPsmnu5JFbIBH+s4WtjylwqyG3QRiNnv/dFAajsD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:35f:e976:32b1 with SMTP id
 z7-20020a056e0217c700b0035fe97632b1mr699432ilu.0.1705239784091; Sun, 14 Jan
 2024 05:43:04 -0800 (PST)
Date: Sun, 14 Jan 2024 05:43:04 -0800
In-Reply-To: <20240114124745.773-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000967859060ee81367@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in ni_readpage_cmpr
From: syzbot <syzbot+9877b6999a2554291c7d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9877b6999a2554291c7d@syzkaller.appspotmail.com

Tested on:

commit:         052d5343 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15ae8135e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd9cd6563b562315
dashboard link: https://syzkaller.appspot.com/bug?extid=9877b6999a2554291c7d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

