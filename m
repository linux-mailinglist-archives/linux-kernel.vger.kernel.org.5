Return-Path: <linux-kernel+bounces-11317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA1081E47F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B919B21B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CB71859;
	Tue, 26 Dec 2023 02:07:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A51847
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35f766cf0f6so37045915ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 18:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703556424; x=1704161224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N51vKuzDsrBBMlIRIygPrtQr3QXeDCsXCvdazkWkxzI=;
        b=mdMNlQ+9rCJ3aeibAXoOpq4wBWBsQ9DCENMeRWmpXsAA+yB6sEb7ZEFXiQ13T6o4W1
         DNe99Yrm+fuHDhW2q8W1GbFLRwm2qnAYOQ6G7uOJtXfMPqxemROt/scWsfTMIUAMQa0Z
         Idd1YQ9ykxJs0g3sgd5LzPJwLzPhMwp5kSjPw5rbnveayHppIktf0b9m99DgyQFnMW7i
         Rz9yAivXVBSNdIk0LX4EKNWIiFacW1qCVmOwu/hGMPwrjRxu4oUiywVcQ/sVeusZwJnS
         vvauKGd2QVHrtPtiznnQrOhX+M8LQU2JkZ8cnOZlswAdydC0HPQOlZB/BKARz0lzRUQa
         loQA==
X-Gm-Message-State: AOJu0YwPyPQsWkmAxNLrZVoGoswMh+L7qqH6pxdFy/7DOX1fOe93UxSp
	nC10BEkzIgQ3bsm4AYHwwahQ28fA+v/iZVJG0lJhB+hb4ggy
X-Google-Smtp-Source: AGHT+IHeMI4UBorhlSOLVjWJhbfzvNS8ao7KCFhrJx3HqSDYuhx0qkEMe47OENauYR7mw1GZ6kTKx4d4ooMf1sYkkqgwlnWkOeek
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:360:290:902d with SMTP id
 f12-20020a056e020b4c00b003600290902dmr343200ilu.3.1703556424579; Mon, 25 Dec
 2023 18:07:04 -0800 (PST)
Date: Mon, 25 Dec 2023 18:07:04 -0800
In-Reply-To: <tencent_58740777F766DE3C91376296D4363A4A8A09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ac281060d60230d@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: slab-out-of-bounds Read in
 search_by_key (2)
From: syzbot <syzbot+b3b14fb9f8a14c5d0267@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b3b14fb9f8a14c5d0267@syzkaller.appspotmail.com

Tested on:

commit:         861deac3 Linux 6.7-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=125a5231e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=b3b14fb9f8a14c5d0267
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147f47e9e80000

Note: testing is done by a robot and is best-effort only.

