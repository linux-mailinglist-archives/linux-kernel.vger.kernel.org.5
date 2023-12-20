Return-Path: <linux-kernel+bounces-6835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE280819E47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E57285542
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2E621A09;
	Wed, 20 Dec 2023 11:41:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B003219EE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fc4376ceeso13356385ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703072471; x=1703677271;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZWvcvFWT3P94ESec92OyEYUrt6Ss1wkXtTKq4rDYxM=;
        b=eWrFwmoaDpOgXkZqTRki8UezrnFJKrFraT2lXjg2Ox9pFqI2HcarbHP3o3TSAWi0Dz
         urVRzFyO6KM1inkld6WPnIusdP/1B129w90W4xGvBDeA4mja26x4CNHAer2xnboqlu5n
         us1hWWJ1PitDkTzq6O58gw5JCJMAj7T6rrGXdRCtxC7GP9O0ERMihkM/aF4eNdc2i7an
         C9/iMX1v8j3KQn0RyD6MH5/xbcSSbXEE/Vy8HOcEm7GlUhoWOdCJsLPdc+a3CLRxsGF2
         HcTokPh9kClvqt2I5eBZN39KsQihIJ4GH4cPA7lHdBZ7h35OzBmSSBS7kF1o2oVnqsqa
         oxaw==
X-Gm-Message-State: AOJu0YyN1bj8O7fRD2/S/sfheRpoGxuu8mh0Y8tGn3EB/YB4FW1kanY3
	XNLhz1l2ySyMbgxrhhAgR4A1SI+OreRk6zSSHjbx7TZt31Ah
X-Google-Smtp-Source: AGHT+IE19RIDA8rceZNYE3OLPKGLd85fED/iwIB9sfne/rp8fCvDjEJpyKLGSD0MG8Ds1QeX4ZBjL/dllhWrP8WcEKStgSvPvqXO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bab:b0:35f:ce83:9590 with SMTP id
 n11-20020a056e021bab00b0035fce839590mr27397ili.1.1703072471625; Wed, 20 Dec
 2023 03:41:11 -0800 (PST)
Date: Wed, 20 Dec 2023 03:41:11 -0800
In-Reply-To: <0000000000003ee3610599d20096@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2bbd0060cef75c4@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __media_entity_remove_links
From: syzbot <syzbot+0b0095300dfeb8a83dc8@syzkaller.appspotmail.com>
To: andreyknvl@google.com, laurent.pinchart@ideasonboard.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, mchehab@kernel.org, nogikh@google.com, 
	sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
media: uvcvideo: Avoid cyclic entity chains due to malformed USB descriptors

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=0b0095300dfeb8a83dc8

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

