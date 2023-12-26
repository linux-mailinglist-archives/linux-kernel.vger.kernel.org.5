Return-Path: <linux-kernel+bounces-11321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D23981E48B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45ACB21B17
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B91854;
	Tue, 26 Dec 2023 02:28:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92D1847
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fc70bd879so37381085ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 18:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703557682; x=1704162482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sh7Ov9OyxFG0djBJAM+6crfXQlRyjqxqbH+Z1rnPOU=;
        b=r0ig5WNfKvqKG+/CEgaGFTzfcanb8pC1ejd9vg+tvN0RtSWRQgW/EYfZfLa4stYou1
         MMVNt+oA+k/YDf4FdFpXCEs3BFQk1qXFY+vk6Dm6HSMAc5ML8l/rS0twJgpAxukA6Obr
         3eJemTWkYKJqdQ+opVpJG6MSfSO8feKAqJ/S59arQDcAZToFI/BPgENMxbvMRgocL2RL
         6PyR4wv0u2YWucuAj+HPIUUJApRddmumyTdtl9x72Q0u5BHd9EQhx1MlPUZWElsyOitr
         8xeQazSjPmGGMCtruPz/YxNqqDxFIVoBPPhVCD4/Gi09tJiu/aa9qbmocDtLkW2oMgdu
         +5kQ==
X-Gm-Message-State: AOJu0YxJK1JhPPbiV8KRmaco9E9q/hOZ06wBmzg7up1k465zYPcW2UZy
	1El06BK42taKVVOCIaKUyokAM1NMbXyhqK0l0lF0i7eMSr9X
X-Google-Smtp-Source: AGHT+IGBCApHVGL2b4gJYI57Sr1oMd3azGMBis8hc4EVHcHh6ok1SthVx4R9T8edADg1XsdI2xgs4/ZkYe3zCR0lfZbGYpGCneqo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2d:b0:360:e80:1bd6 with SMTP id
 m13-20020a056e021c2d00b003600e801bd6mr37402ilh.1.1703557682635; Mon, 25 Dec
 2023 18:28:02 -0800 (PST)
Date: Mon, 25 Dec 2023 18:28:02 -0800
In-Reply-To: <tencent_70A097B037B44AAA748F77BB66843CD73609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000872ca8060d606ef4@google.com>
Subject: Re: [syzbot] [perf?] WARNING in perf_event_open
From: syzbot <syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com

Tested on:

commit:         441c725e selftests/bpf: Close cgrp fd before calling c..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135a5231e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f565e10f0b1e1fc
dashboard link: https://syzkaller.appspot.com/bug?extid=07144c543a5c002c7305
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13bd1bd6e80000

Note: testing is done by a robot and is best-effort only.

