Return-Path: <linux-kernel+bounces-12933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377D981FCDA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A4C1F24A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9013023AF;
	Fri, 29 Dec 2023 03:40:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0317EF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7fdde8b58so915588339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 19:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703821214; x=1704426014;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=sK+y7rcwxSk7xjONKnNIGJaIXREzLH2qG0rwCNnMAnZG8cTggol5oGfqAiudzgx3Ky
         1Srf955uQMjlCdlYpE9v/U6WWyz6iu1TRoWgcrNUoIwVeoeqcHCNzhDeijX6lQshzqKe
         aWMCm2Gm0z41zDMiqVrlcFCphoV6dtKJXkf/gcFJIlgm1HWijxoN+8/9s7YpftSEdKws
         H78XCFOZSi7BrjzMHNluZ2mSZBATD19VTaGtO4j7yb7NahD5BDvnPDoU9Z75qiha/GqJ
         1indEDUudscjrzgemc7DEPn5g52bjiehFt9HLUyfuVzw0om1EtgkMVxVA/qhoMYzTpsg
         t/Pw==
X-Gm-Message-State: AOJu0Yz7cVfmuEwxB+qX6nrPcr+A2/mX/vfR22gq45ZmojP7bMg6HWFA
	G12YRxDeL38P/A6t8TC25462yylZ3fV/e40eBZkh8HPvaSO5
X-Google-Smtp-Source: AGHT+IEkAGjwi+IkyhqrzNDOTpnjqIEIdvqSb/HQ56k/Ws0Mj7r3H0FCFiYVeWjl4P/gSUkbHvnRxME/4WghGDJY9dzzc5Q4cfEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2708:b0:46b:719a:62d0 with SMTP id
 m8-20020a056638270800b0046b719a62d0mr434473jav.5.1703821214020; Thu, 28 Dec
 2023 19:40:14 -0800 (PST)
Date: Thu, 28 Dec 2023 19:40:14 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038f8c3060d9dca3d@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

