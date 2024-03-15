Return-Path: <linux-kernel+bounces-104010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3387C7DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B771F22B37
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3ADDD2;
	Fri, 15 Mar 2024 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eha8fU1C"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF844DDAA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472401; cv=none; b=eXILAKhulLV8R1u2hSj3wR41LqsTJvpYYuPrixxafuiJCtlYbD88YOh8UWCYZw54B85/Dt2upyuzoSo/KLxyw95cQizTD3LgyZaEp/bnBktFdyKafx0gr20M0U2GoWV11ORIrVt117bb4npgzGc50hvkSdObbdHdy2qOaQ4Zl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472401; c=relaxed/simple;
	bh=atU9+Hb2g+MtQEJwv8Yw6+mwV2ZugG9XKzWib7/laHA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QgyBtcGHxqohlS7M8y7hdKwtldDS5AQ3oI/osf1oZPMmPGrUwLRUPL9okl0wWxk4E+dHT6G9W1ku1fh2JJtkSQEmAiYaXVtmSRPYhi1Du6c0azkBbkJCvxnVtIw1l3j0FQOIHHJtCQnZe/T2Bw7n3gpcsrymSPsHi4F6cjtdm7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eha8fU1C; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-221a9e5484aso1128839fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710472399; x=1711077199; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wywwcAsaS7LVgiNNv8iuYk1eDAmZe8iY7r2JJQuK2cc=;
        b=Eha8fU1CRmczADtkutFdP7vhxl+MhvLF6lsY17f/+NAX2niUdAi18H6uCSGqierxIO
         B3W2STHM7wkK0mkG8ehVDN8w6BySQ9Hc/JaEtr+NUADWtjXR4N+0di/is4kcNrwADkGg
         WjjDclxcXPpZndpvY65beZrk2ZokIR8Ti8wpWVE75VGNPs09HbdINn492M4Evk/1xQ19
         Gg0avkc58HpWb94DI5Hj3gkjJPAOzjC32RKa72SCO4sZo/Rjg9alEcvrFVRR1m8vEDQg
         MCJ9+KO/NIeZ4vyeu/zTOKiVlmMzw02PQaLU+nd9b9wbbvOSqIW8siawjGYPFZUcJNBV
         IOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710472399; x=1711077199;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wywwcAsaS7LVgiNNv8iuYk1eDAmZe8iY7r2JJQuK2cc=;
        b=ivKYYXoo/MBbxFobqGgBqzQTm7jImtCAaSMMgHiILFpChYXkkmA7W0rHVa4I056SLI
         SfcI731paO+jHPalikbUxwVRJdLTS8NmKvhm8HjK4gkdgLhD+MoskzZqgXnCFxMxvj9i
         vQeeLxMHNdZF2vS4iAYc93SewXcdnr4+ik4Y2d0qPWxy2DxDKiuvEm9OWCV1n2utVffc
         bf5kqroRnOEwfZhxP9s3H6oRpG2GT61UjN7lvgUWLaHo8ni6IF4W9dH1jLF4ucsGC/Sh
         Zilw9+NENytHtuhsDDdfNSh/VJ56u1DXD2T93n6Inx/YwKEa0y/Mh2d0sSmZ4P7SOsA8
         IA5w==
X-Gm-Message-State: AOJu0YwxyYOvimmyAXQqGoONqcuszKaMPtkRfkK/1gt7t6+FPz6tm8tg
	ozkeQIT7YDO6qB5L8YyIO34GEOg+jLVwq6Gx+OuCnf5NEMBC8ei0
X-Google-Smtp-Source: AGHT+IFYn10tTFICeo82hwo+eZnNfJIhVE1PdUe56DNcsVEriMjV1dAynZ/yYlxUnFMsZ0v31hKmDw==
X-Received: by 2002:a05:6870:c0d0:b0:220:a138:f59f with SMTP id e16-20020a056870c0d000b00220a138f59fmr3578538oad.31.1710472398912;
        Thu, 14 Mar 2024 20:13:18 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id o2-20020a62cd02000000b006e6b52eb59asm2385392pfg.126.2024.03.14.20.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 20:13:18 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: tglx@linutronix.de,
	liujingfeng@qianxin.com,
	qiang.zhang1211@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] posix-timers: fix the pccontext memleak in posix_clock_open()
Date: Fri, 15 Mar 2024 11:13:10 +0800
Message-Id: <20240315031310.21749-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently, if the posix_clock structure's->ops.open return error in
posix_clock_open(), the pccontext object is not released, this commit
therefore invoke kfree() to released it.

unreferenced object 0xffff8881065327c0 (size 16):
  comm "syz-executor.7", pid 8994, jiffies 4295144661 (age 17.222s)
  hex dump (first 16 bytes):
    00 20 79 01 81 88 ff ff 00 00 00 00 00 00 00 00  . y.............
  backtrace:
    [<00000000fba736c4>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<00000000fba736c4>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<00000000fba736c4>] slab_alloc_node mm/slub.c:3478 [inline]
    [<00000000fba736c4>] __kmem_cache_alloc_node+0x1ee/0x250 mm/slub.c:3517
    [<00000000f8fcb419>] kmalloc_trace+0x22/0xc0 mm/slab_common.c:1098
    [<00000000afc910b4>] kmalloc include/linux/slab.h:600 [inline]
    [<00000000afc910b4>] kzalloc include/linux/slab.h:721 [inline]
    [<00000000afc910b4>] posix_clock_open+0xd3/0x250 kernel/time/posix-clock.c:126
    [<00000000b1a43627>] chrdev_open+0x24b/0x6a0 fs/char_dev.c:414
    [<00000000364febd5>] do_dentry_open+0x630/0x1580 fs/open.c:948
    [<00000000ac62c8f4>] do_open fs/namei.c:3622 [inline]
    [<00000000ac62c8f4>] path_openat+0x13f1/0x1c30 fs/namei.c:3779
    [<0000000087bfc1bc>] do_filp_open+0x1c5/0x410 fs/namei.c:3809
    [<0000000044db899a>] do_sys_openat2+0x139/0x190 fs/open.c:1437
    [<00000000ee967f42>] do_sys_open fs/open.c:1452 [inline]
    [<00000000ee967f42>] __do_sys_openat fs/open.c:1468 [inline]
    [<00000000ee967f42>] __se_sys_openat fs/open.c:1463 [inline]
    [<00000000ee967f42>] __x64_sys_openat+0x13d/0x1f0 fs/open.c:1463
    [<000000004fad64b5>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<000000004fad64b5>] do_syscall_64+0x3e/0xf0 arch/x86/entry/common.c:83
    [<00000000c2701c13>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

Reported-by: Liujingfeng <liujingfeng@qianxin.com>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/time/posix-clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 9de66bbbb3d1..68990dd66956 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -137,6 +137,9 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 
 	if (!err) {
 		get_device(clk->dev);
+	} else {
+		kfree(pccontext);
+		fp->private_data = NULL;
 	}
 out:
 	up_read(&clk->rwsem);
-- 
2.17.1


