Return-Path: <linux-kernel+bounces-9667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04C681C944
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC361F271C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128981774D;
	Fri, 22 Dec 2023 11:37:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E6156D3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7baa66ebd17so17255339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703245024; x=1703849824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y+WM6ogPa0il4nR6wVlfRdkYCR+YSXA03IUxivTtRs=;
        b=Xct+q0HUfyYfN2Nyy1Oj4WdjznN+ZQIgXOMGQoSKBz54GtrBXiPDETu4D4UZg/2qql
         d8asArVRZ9mCmFWPJWw6EAEG8E5r8PE9cbCuk3m0vZ2UvuXCYPSiaHEbcsOy/+1RRvgk
         2MPqwWEHG2l6rrIzt74xvZ5DiCTcGHdDAraOCgkxJJsqBkBvf0aXRwCa/1clddxzkOdM
         EVtOZDj45Be8Of3oucEsYqHrMdD1UvPPvJHYTj1DrFvEfvILUwJU8oVe9oKc2ofGi2Wc
         dJ77lxaj/tr+cpWeyyEBwtaKBAD0XLgQ6rev+N1DT63N4/HstCFUVM8vfkjLxPkGSGWg
         eqUg==
X-Gm-Message-State: AOJu0YxRUD5cZX/a/ZOR9XaiOm7nXFLRY8VLlKpVj2UdAFLEQzzZVy0F
	G46HoIgzIK1mhTrmvbgQzK28NbHus6qKz6ZCdwH+07ooPqXN
X-Google-Smtp-Source: AGHT+IGnF75S5dJCb66ibec/XizUSjimUvMINB8wR05M1DGSTsgotCuB7OAVoBtY02iyQgCfGshwKjIuRxxtwFuw6U2099TzQWuH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1919:b0:46b:46c2:cdc0 with SMTP id
 p25-20020a056638191900b0046b46c2cdc0mr68631jal.2.1703245024587; Fri, 22 Dec
 2023 03:37:04 -0800 (PST)
Date: Fri, 22 Dec 2023 03:37:04 -0800
In-Reply-To: <20231222110713.1245-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7f58a060d17a2cf@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in advance_sched
From: syzbot <syzbot+ec9b5cce58002d184fb6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ec9b5cce58002d184fb6@syzkaller.appspotmail.com

Tested on:

commit:         24e0d2e5 Merge tag 'pinctrl-v6.7-4' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11c4039ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=314e9ad033a7d3a7
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9b5cce58002d184fb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177321c9e80000

Note: testing is done by a robot and is best-effort only.

