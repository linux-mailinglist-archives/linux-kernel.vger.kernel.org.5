Return-Path: <linux-kernel+bounces-10279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63281D212
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74185B22680
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87015BD;
	Sat, 23 Dec 2023 04:05:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF541370
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fc8389a58so24023525ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 20:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703304304; x=1703909104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgkqyIPTwUfZQIgbFrL2XfsxK1c5xluneazDPVhgfd0=;
        b=P+G/NBv/sDBf81zr3DvciQcKxHbcbolvH+khpdD23Z1iMajyZ+bfxEUwbj8yOg5Qk0
         sI7KCELlwj7hnms1JyNx/oiGYopMR+wwtKejCRYLK2yANTj8pfanZrwZ03MHxSolyy9N
         A7rKYlqpBA3VowCe7Ysx6dXIAROo3YBA5H/30oNFcte/qhtOGc5S2xn68p8buwwXOR4N
         2kXWrLRoxdUMByscH3FqRwQWQPwO8uUvIFBXAthcb7ATzHpsBmOSMH2CZ0m5pcgV+iej
         bQAKftMTUwNfdR4bI0MukhYyX5qpk7n+0FW4gNLNZwNyXp+XYIztKpQXv9ZcbTpYwLsv
         jDJA==
X-Gm-Message-State: AOJu0YwG72ejnJ4M7GI3ZvY2P8Ir6LcS0EanVS/oVA1tJqyF8P+yl+oq
	27FqG556ZObqlwKVcWOaqEBlFCt6KCbZZwzu02fasvdB9CdU
X-Google-Smtp-Source: AGHT+IHpkHpecAXIV34IOPmHnLSWUtgW6ymcugZU1BaIOoOLxK0ooYS8Os39qo6psNf9Sw7tqDEGQuh/kBr4r/En9NtQDnK/zgYA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:35f:d4dc:1b1e with SMTP id
 i12-20020a056e021d0c00b0035fd4dc1b1emr355736ila.5.1703304304560; Fri, 22 Dec
 2023 20:05:04 -0800 (PST)
Date: Fri, 22 Dec 2023 20:05:04 -0800
In-Reply-To: <tencent_8FCF968DD725F80DE712085DC4DDAD993B07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000049187060d2570de@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING: kmalloc bug in ntfs_load_attr_list
From: syzbot <syzbot+f987ceaddc6bcc334cde@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f987ceaddc6bcc334cde@syzkaller.appspotmail.com

Tested on:

commit:         9a6b294a afs: Fix use-after-free due to get/remove rac..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12708809e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=f987ceaddc6bcc334cde
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d6b376e80000

Note: testing is done by a robot and is best-effort only.

