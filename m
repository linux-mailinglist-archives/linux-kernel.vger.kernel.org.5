Return-Path: <linux-kernel+bounces-13314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31910820362
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4ED284558
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903098BE3;
	Sat, 30 Dec 2023 02:47:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676B8801
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7fa6cba91so931764039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 18:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703904428; x=1704509228;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TW7HpXr9RKBb+45tL/y2cT+vTD7JBGylkbMMZe3PIYw=;
        b=JAvtNvmQebkrOnjqOPCdAc8LC8fPdO58AiSZRgfxcFx7jsIasgFF2bmjZ3ZTtx+eWL
         222gZ5HFJ8CGOAGiJNYKLN+SM/Vhu8DqgUlFa6bGJN48e066BfaZFQHd7bDKJgsri1ZT
         JqmRY9zHCiGLWPAdqRHGRIgoSRgG0DKQcZYXWJiFU6b5aE5XvreoECHLwlfZVlH+95YX
         VPczuRBmlV2eNT24E/z+TsdViTqS8vOzEyrWCqr4pKga9/+5k4hyGXoH4IfhTxrqguEc
         zcOM3jt4g4hZF1WyniTHWxCzhj8sgFprsWGUBEVNg8FDpdTwVQ8JZoIxCWRxXLjUQQ2E
         hK/g==
X-Gm-Message-State: AOJu0YzJh+Al50NuYWVSYHOeiMpSqFMjPWeh5gCYwPVGSZC1gkK8CKem
	AScSBsYhxsMLVsl4bW7Igkg99jh2RpzXIKAhU5eJP3akKE6z
X-Google-Smtp-Source: AGHT+IFQbUAnB88P5TZreRrU9DVuisOCQBUTYqnvBJMz8gyMYFxp9HjqqTl+uHV5XYcVALzDWAiBbRse6SjM31DUEFNhTEok7a8b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4414:b0:46d:4cc6:81e1 with SMTP id
 bp20-20020a056638441400b0046d4cc681e1mr155645jab.4.1703904428063; Fri, 29 Dec
 2023 18:47:08 -0800 (PST)
Date: Fri, 29 Dec 2023 18:47:07 -0800
In-Reply-To: <20231230015923.2190-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a80e9060db12a11@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_prime_destroy_file_private (2)
From: syzbot <syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com

Tested on:

commit:         f016f754 Merge tag 'gpio-fixes-for-v6.7-rc8' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1413189ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7bcb8f62f1e2c3e
dashboard link: https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14912036e80000

Note: testing is done by a robot and is best-effort only.

