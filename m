Return-Path: <linux-kernel+bounces-21658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD39D82927F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5141E1F26C35
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F1623B1;
	Wed, 10 Jan 2024 02:48:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CF1109
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bc32b1426dso316237139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 18:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704854884; x=1705459684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEeVDtVddv0PxLvFAi9UnRKATTmWAtEehDqq1Yp7SnE=;
        b=b9iTDQ2WHf+gyxDg7cSFPta+aCK63AXDzNTv4mXqFmmetUE3YxwZsV5xxuZZiQMwHj
         aJsFT3nrFZoyS16o/t4VnsisZ7T4xypoaf/eq5UuR/fMnXBa3MBH4RGD+w2yPVZDGMuM
         A+IZs55oaFl/4xAr8wGCHfZ8rihYPNrszXynTSjMNvhBvltuVYGMkT+Aa7zrLTTw73pz
         IHlaqjwCr2J1w9ssqauyYpJC+S6D2+0S1lqFrQnICWh5PtgXuTzDfm3eyQo4w1vyCwTQ
         gi88CspQqasAxtvGpFuypHzRMnPv2Nz5gyYIH/VuIeTSuBIeI57LfBg5W2TkB06zadFE
         bzow==
X-Gm-Message-State: AOJu0Yz73NrN0j955GvzPc3O7nCSB5s8VAbvFzdTWQW4LozirWHYghTD
	6CI0b+fRAAjs389dK6o7zA2tsqxoum4086eiC63eYVl/qKJF
X-Google-Smtp-Source: AGHT+IEkeu9JGS6xvjP6wgdKdedVJjZ4ammyklqsugJoSg8fgM6u9sAD0qeb9zKRb4JrEgRCFdps7Z6g22eDY71tuHTK1hgpnxML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3782:b0:46e:36d0:1afe with SMTP id
 w2-20020a056638378200b0046e36d01afemr19364jal.0.1704854884057; Tue, 09 Jan
 2024 18:48:04 -0800 (PST)
Date: Tue, 09 Jan 2024 18:48:04 -0800
In-Reply-To: <tencent_509697EE36004A2A752176B767163CE13709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c20d33060e8e75cb@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_lookup
From: syzbot <syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com

Tested on:

commit:         861deac3 Linux 6.7-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=153ea171e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1464c233e80000

Note: testing is done by a robot and is best-effort only.

