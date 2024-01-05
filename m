Return-Path: <linux-kernel+bounces-17349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AE2824C07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FA72871FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC104403;
	Fri,  5 Jan 2024 00:07:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5953C0D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 00:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fd902c677so7531375ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 16:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704413236; x=1705018036;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=hHtTSsEQiB1PJfT1H+LxU3jywEswYG2US+sKrF+TSKaNS61zEt1NGpV56M+H8nGW33
         XYR9HuWX2Lm1F+pB9jEGXg3brRUknSk2+THyn+mLs6bKR+b1wZB8seIiY4j3dV+Y0QS2
         8+SGXvq8fqEAhj0+NEqToaTsNWFL3cNGi5BHrhUC35RkziYNsph9tqDMCG+5+5dbCR9W
         QiAM6giMIKysr7SDoiU1uWoK6jdlKDTkD79DhEvcGLfpU8mpBClAL7U5OIkthsH1w/Rw
         /p0BnfC+qY2kdbNL0M7TFStCvNS4AFEZb3f9YlNcdPqCWIsMrSJWwel7tJP1erMT9HxZ
         TLig==
X-Gm-Message-State: AOJu0YwDBaZoar6IirtzMVZ/WefguixAC5j6V5X49Op2HUPGvr5Uhdxb
	1EdibHOX51IvXWG9/6DSOusT5Hhh1ClbOMmfdo/IxTaOO7EN
X-Google-Smtp-Source: AGHT+IG8XWLl04pnC8v+zbeKvvM9XWF9CjqAwYsPkD2ltAuLqhA4qsL+OXQEDBWqdmTt2aYEJSMATbN7UElsfDu2UI5kUPCgAS0S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8f:b0:35f:c723:1f62 with SMTP id
 w15-20020a056e021c8f00b0035fc7231f62mr149481ill.0.1704413236853; Thu, 04 Jan
 2024 16:07:16 -0800 (PST)
Date: Thu, 04 Jan 2024 16:07:16 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000888720060e27a1cc@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

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

