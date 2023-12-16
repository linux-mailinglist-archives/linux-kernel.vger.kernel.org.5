Return-Path: <linux-kernel+bounces-2119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3552981581B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA9DB24608
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5190134C4;
	Sat, 16 Dec 2023 07:01:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE9D11187
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7a772c238so136207739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702710066; x=1703314866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2symkoABZo9KBUb95detvKFvty4ZqZmJTKfJJWUeVe4=;
        b=gpwbUBW/TIeaADRjfZkhkVv+6sP6G03Ump70hpf1q0qhvKHLvIzinbR8jNkAI5rp/C
         XqOHp2yiyo4tTXHBwUlCBDdj8kZ7237K43OcB51hdIU+7fcS0k+/56LZN7Kw6EdAoK4Z
         azKv0YNuQ7cU9PaxZ8k7aU626CAFVXlN7U8MslS8UFmhWp6yLyYl7WIB+2ps4utizyEV
         iJu6yfnJiYhjRd9zvtLQNAu7ia7qWCbdBSjfxp9pf/p+Yc/4lBt3TcdgYRhWI/34rE1e
         K40cILmwJR+wHrqn450ApnZfVPaXwSZUPfTlCDU5ot/4Zn2VneGInzuv2unomtBT4tKW
         eiVA==
X-Gm-Message-State: AOJu0Yx6x3S9e12LEW6A+CTs1a3BV5zRQWHkAzCxe4/LlKS4xiqC8HX4
	mYBoudSCCFgu9i8sSSSnaJlPDnq4Qc/Jy+bx6y+apv3/syre
X-Google-Smtp-Source: AGHT+IFDTQZKM8MkHiZbvf0PQPwG878U6Op6VjeV1G7vEM2O82OXpfqWxu9PwWziMfQLTHa6denV+V1mAwM2FEohUxsiGZldDCox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1445:b0:469:2635:fd19 with SMTP id
 l5-20020a056638144500b004692635fd19mr526208jad.0.1702710066544; Fri, 15 Dec
 2023 23:01:06 -0800 (PST)
Date: Fri, 15 Dec 2023 23:01:06 -0800
In-Reply-To: <ZX07SsSqIQ2TYwEi@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac07c2060c9b1453@google.com>
Subject: Re: [syzbot] [block?] general protection fault in bio_first_folio
From: syzbot <syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com

Tested on:

commit:         abb240f7 Add linux-next specific files for 20231212
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13d005c6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc2485c21b49ddc4
dashboard link: https://syzkaller.appspot.com/bug?extid=8b23309d5788a79d3eea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d24771e80000

Note: testing is done by a robot and is best-effort only.

