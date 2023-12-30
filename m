Return-Path: <linux-kernel+bounces-13368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9716D820414
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84241C20BF8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754F2567;
	Sat, 30 Dec 2023 08:57:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995323AE
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7baec2c5f30so472481439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 00:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703926623; x=1704531423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/2JFH6hFG4yS1PCEphEIs5Vmwkj5XCp92KX5S53m3Y=;
        b=Mqe+xBiFlbqSjvN1wWn64xmMXoy4Z95pfI3zlOc68O2HThYgTFF72z3oZP73Pd93Xg
         yB5xKLf9EQRVeHy25d9HtCPfvTteffq7m3TE203yJvpvsKO3XQzhrbEPmXgpzO/fLjM7
         ureIzXz2MiqxuF3cFJ4UjSofMOeXk1meLig0G8YdUizXJp3XjC2MPV/1EYeDjVUnxciy
         87m7DweBylPhPBzjVRxHj9YpnBkhErfzrC9/sYmDInPOGoMYkcSiV4Lla4A6A7ZwAA0Y
         UkpELNavCSHecV0ZauXw97boB4Fa2/6+LnA/4C7UuvsjCWiZKA70dOaV8fS+v6N9J7n8
         1Ifw==
X-Gm-Message-State: AOJu0Yx4QvUX0PogIDRyDxj8T1WedYCRYzvXcHc/WhVdxBeVIxZEfx2l
	mjwnkZ6oDwHOhuZQJToCfteKMLQbMPG9XiJuh0eaDDkrnVfT
X-Google-Smtp-Source: AGHT+IHE3RytBluQJZTzfU/w+r0z5GPlZQ7PeL0kmyPd9CAFH8rWcUXvTp3SDAYA2zhBSzFOMd1DkbuxrTBUao35A8ZWvc2VvGs2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:e017:0:b0:7ba:e2f0:30b3 with SMTP id
 z23-20020a6be017000000b007bae2f030b3mr328459iog.2.1703926623045; Sat, 30 Dec
 2023 00:57:03 -0800 (PST)
Date: Sat, 30 Dec 2023 00:57:03 -0800
In-Reply-To: <tencent_50A825E08D9F92025DEF5DE4992C4FB00D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017115a060db6559e@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in
 ntfs_listxattr (2)
From: syzbot <syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com

Tested on:

commit:         aafe7ad7 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12128e7ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23ce86eb3d78ef4d
dashboard link: https://syzkaller.appspot.com/bug?extid=65e940cfb8f99a97aca7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b48c9ae80000

Note: testing is done by a robot and is best-effort only.

