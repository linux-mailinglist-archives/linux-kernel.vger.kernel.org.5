Return-Path: <linux-kernel+bounces-13307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180BE82034A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A519E1F2302A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F26258B;
	Sat, 30 Dec 2023 02:08:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CED2569
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b9648cb909so1021387439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 18:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703902083; x=1704506883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFj0pcB3T8HqnyC3sMZgs0FgK6OYahw1fEolkLdPAck=;
        b=noxWBX0+dTd1uyIGZSxpDpVypy9pqbU3mV1qiD3r6kfGZYObKzZPqS9xujRbMOgFQZ
         GfBwxa2Ve0aS4wKXeYrrCTm2pGV+lzeo2eUvlg6a7WJl53u5DTBKGE3y/rqv81ZmIZKz
         LAqhO8T42+klu8+bEG0knylL7A/fxheBV5I0NX8UCrlzVC3fNcjpevS6S7pmrWF9j7JA
         EY0Q+px1WFkbRgdYvF8GxiCCPp0R5R/gggv/DvxduJKgHV7tCAiYx1LD3XqU9YM7Qq1z
         Ko+OMD7/VIDXnGOC1VPo1zduyXLtP8DeV60WgPojduT0P42GJGRPBVGrNVydRqLFJ5mB
         X80g==
X-Gm-Message-State: AOJu0Yw77Oxs2I7AgK4yA5UBNhoD00G8KXj1Jtj9lhfjlVgNnViYK7HG
	WOzbVuvWLoTeyc8DNm0TMLqy8nEyOFi+FVJ+Gdo5mHBOBskC
X-Google-Smtp-Source: AGHT+IE2AtVuCUiVrmMjr8B+y0WMiAtg95mL8ZxSvBzOlApOY0s1wI11f0MSRyWV786jS5ZqB5fMjBtdMGkBE3yWjqTGpnKaf7nh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b48:b0:360:ba:613d with SMTP id
 f8-20020a056e020b4800b0036000ba613dmr1464832ilu.3.1703902082918; Fri, 29 Dec
 2023 18:08:02 -0800 (PST)
Date: Fri, 29 Dec 2023 18:08:02 -0800
In-Reply-To: <20231230012659.2135-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062705c060db09e22@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel paging request in mmu_notifier_invalidate_range_start
From: syzbot <syzbot+0e7b9b7452ded0356f2d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0e7b9b7452ded0356f2d@syzkaller.appspotmail.com

Tested on:

commit:         f016f754 Merge tag 'gpio-fixes-for-v6.7-rc8' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=115dfc65e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57ef848c54f4cb25
dashboard link: https://syzkaller.appspot.com/bug?extid=0e7b9b7452ded0356f2d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f5f4b1e80000

Note: testing is done by a robot and is best-effort only.

