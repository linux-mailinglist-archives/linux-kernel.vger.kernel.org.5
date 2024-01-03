Return-Path: <linux-kernel+bounces-15481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC210822C91
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5744E1F2149C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B126E18EB4;
	Wed,  3 Jan 2024 11:58:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FE18EA7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ff23275b8so93095865ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 03:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704283085; x=1704887885;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtZbclCYakM5zq/UNkScpTyYXCCkb+CXRRk/waEJnC8=;
        b=qDgpZoDSehG47RRrd3swMO681CjuvVP+ZICuT87P7hui/GlvHiF0WeNSG+tyVMQCYu
         NUai2CTybTh4w2IVL2JHgIc61WnkTmQzyyDKHQngkQLpL2uDtpyEq7A4hfrwPvBn08ZI
         I+4jsPq8z5qztWkwfEXP/ivhcMrRA1iqy8Ow8gzIMXrpmVS4ZYZ8iDS7G5wS3s0qwYie
         M3xK0ZPYLh8F/EolZFnmiMLgF8+hOnWoKH3EfXZeihPNHrkdLfzN3iobaYMWLpEmXA2o
         G5wtq/jdfugcKuWTChsmGPQD2a5Ad6Pxsk3PJVymhz2nESDjetzduqUMYPCNezkMpi44
         JpoA==
X-Gm-Message-State: AOJu0YxDC3qjzT4p4ewlyqlLflccO6E8gSH2nxcunrJMn0uTMfGY1gWG
	l9sdtE3K6/UyYyaJGlB2koJSOgfemZNULaYJ0/yGP03WrY6e
X-Google-Smtp-Source: AGHT+IEW4lFeIeL3KaYdOxGt6RDhn4fN1yVkJPhGYgbhr3DrQDDRL5oKsyRGhoKBYQDmI1ofnhfA1dNaY6/CfRoGssFckOL2VR5h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:35f:eb20:3599 with SMTP id
 s7-20020a056e021a0700b0035feb203599mr2007297ild.2.1704283085223; Wed, 03 Jan
 2024 03:58:05 -0800 (PST)
Date: Wed, 03 Jan 2024 03:58:05 -0800
In-Reply-To: <tencent_F3421B852547BA53BB2433EE9E461BBF4B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4425a060e0953ef@google.com>
Subject: Re: [syzbot] [wireless?] WARNING: suspicious RCU usage in __cfg80211_bss_update
From: syzbot <syzbot+864a269c27ee06b58374@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+864a269c27ee06b58374@syzkaller.appspotmail.com

Tested on:

commit:         954fb2d2 Merge branch 'remove-retired-tc-uapi'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=172b1455e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=864a269c27ee06b58374
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13efebc9e80000

Note: testing is done by a robot and is best-effort only.

