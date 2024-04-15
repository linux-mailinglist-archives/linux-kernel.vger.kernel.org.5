Return-Path: <linux-kernel+bounces-144508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B44178A4739
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E5AB22A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51A1C680;
	Mon, 15 Apr 2024 03:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFKcCqyj"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B79179AE;
	Mon, 15 Apr 2024 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713150874; cv=none; b=dcpz63KQq+1vzIh3IxjwFwlX+rBE4X1LRp933up0VD7Wx4PkWhmPqCUp7dNf0prZ4rI5Ojfo1ncFHuIwHU7zc1hsWY4ZQ7rmfsld2L71Q+kmXyoo6U+a/0BkvcfCC9gFZyr6jYGn/Cquh7rPA698QGhqLll3+dkgzqNYWK/95Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713150874; c=relaxed/simple;
	bh=lHw0gdEyiCY7Mi3sAPf1DuaLoh7gDBT5neXVCqv7pTY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=twFtjSadjmYAok5oV6BSu0T6b7TeTATwDp+Pn3wh8R9YDkGZfXLKM4FTSMyfpwNXwJ+0mxP/v9Ms//tpT2aIjFVd0C07sJEnu+92Ep/N1MmjMu/GhP1gntjJK3L3eqXlKZ/f+Vu7B5mcs0Ta6JFZW5VrUHiD7ZONehWt2e5H7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFKcCqyj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4715991c32so341546666b.1;
        Sun, 14 Apr 2024 20:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713150870; x=1713755670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O4EQFEyafzgbhZkzPTOOAT0aiBW1/kDcV3Vy9h4f6bA=;
        b=nFKcCqyjIyZqkmPa447wIQSAUMPKm9Zk/Ewkz9Sia54cvKkIay8kru/ae3GcSVc1/U
         5rbG6lUb7IjAT4wiG4j+8z7V0KE/J4VdEBwPLGXkxKPLYJrYbkapOqvKWg0MhKzqCjLq
         XIvoKG2EgjTcNPGvuChYqWncQcN1/oUaj0TDVcVnxUDePnXRQO6ZfOsl1X1Uiq7pFtOE
         FIYFHisFWnuAu6O310DVAdZ8FpvjXmaiRmTiItO4VjVHtNA4Tic4NnfW4qmLEKjg5Jmc
         g6k3xIak6TWM+xvrerHvJzRNZun/bc1HnaziVurHGDvFWSPAX0kpSatwME5jAPCLecza
         IJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713150870; x=1713755670;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4EQFEyafzgbhZkzPTOOAT0aiBW1/kDcV3Vy9h4f6bA=;
        b=k493VXsT8IVbckrqVKxBMNrjJaFGCWwXo3xfiRIXzTSlppcuoYgOyvwg72Mjku/ue2
         FrSiyWvf9cmRjRO+AHoZ6GZZs2vuHfgp8ovtnY/bkFo3ZM492ZqTKPblDtLShgBKLUBH
         Le0KF+Tb18ly3mINDiTr5R6ZtLq3H2bx7XqVeCWFvY6FrTHZOoYpawmP2GTnci7EFNNn
         mUsCnJVBVHmxsbwDcZi+5z0OWZKbcQxaCAT5//cJ7gAG44SlE670Q0oUQJ1H4pqvzqcL
         rlaXB+JpUnsfRZ57RTjPoABbTdamcfyKxOriQnR/plg3mDg3/V6GTbhIIvPSqsYXss2b
         fIDg==
X-Gm-Message-State: AOJu0YyzgmPVmSdzzBmpR1WHGbxmhiWWmqqwgWJGNQ3POp+KpWAnuPhM
	XjmopLV9Vy4QQ8BK3w9pEkMVm7Pg/uLEIl+8yMOjir/DEa8d8wuZoslNcmt0P7MBwuQvwh0gXlR
	5l28rmg/a8gHErGMfvXcwYB0HuMo5wu4G084=
X-Google-Smtp-Source: AGHT+IHlGaESNILMFofR/Zg0+l3dFM0T+xlNWgwdqSRE503ObGRCL3qe3HZc/dQYg1JOWA51ZS1UHqFE1Z5UKW+Po7s=
X-Received: by 2002:a17:906:6a09:b0:a52:2c4f:7831 with SMTP id
 qw9-20020a1709066a0900b00a522c4f7831mr7038807ejc.4.1713150870233; Sun, 14 Apr
 2024 20:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Mon, 15 Apr 2024 11:14:18 +0800
Message-ID: <CAEkJfYNguDt47=KnEUX7tLwx_46ggBx3Oh3-3dAcZxqndL_OWQ@mail.gmail.com>
Subject: [PATCH] drivers: scsi: fix shift-out-of-bounds in sg_build_indirect
To: linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, xrivendell7@gmail.com, 
	Bart Van Assche <bvanassche@acm.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

The get_order(0) is undefined. If scatter_elem_sz is equal or below
zero, the order returned will be 52, so that PAGE_SHIFT + order is 64,
which is larger than 32 bits int range, causing shift-out-of bound.
scatter_elem_sz equals or below zero is not allowed in the
sg_build_indirect().

UBSAN: shift-out-of-bounds in /home/sy/linux-original/drivers/scsi/sg.c:1902:13
shift exponent 64 is too large for 32-bit type 'int'
CPU: 1 PID: 8078 Comm: syz-executor748 Not tainted 6.7.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x24b/0x430 lib/ubsan.c:387
 sg_build_indirect.cold+0x1b/0x20 drivers/scsi/sg.c:1902
 sg_build_reserve+0xc4/0x180 drivers/scsi/sg.c:2012
 sg_add_sfp drivers/scsi/sg.c:2194 [inline]
 sg_open+0xde4/0x1810 drivers/scsi/sg.c:350
 chrdev_open+0x269/0x770 fs/char_dev.c:414
 do_dentry_open+0x6d3/0x18d0 fs/open.c:948
 do_open fs/namei.c:3622 [inline]
 path_openat+0x1e1e/0x26d0 fs/namei.c:3779
 do_filp_open+0x1c9/0x410 fs/namei.c:3809
 do_sys_openat2+0x160/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x140/0x1f0 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
---[ end trace ]---

Fix it by setting the minimum num to PAGE_SIZE, and change the type of
scatter_elem_sz to uint.

Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported by: xingwei lee <xrivendell7@gmail.com>
Signed-off-by: Yue Sun <samsun1006219@gmail.com>
---
 drivers/scsi/sg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 9d7b7db75e4b..6199481be585 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1586,7 +1586,7 @@ sg_remove_device(struct device *cl_dev, struct
class_interface *cl_intf)
     kref_put(&sdp->d_ref, sg_device_destroy);
 }

-module_param_named(scatter_elem_sz, scatter_elem_sz, int, S_IRUGO | S_IWUSR);
+module_param_named(scatter_elem_sz, scatter_elem_sz, uint, S_IRUGO | S_IWUSR);
 module_param_named(def_reserved_size, def_reserved_size, int,
            S_IRUGO | S_IWUSR);
 module_param_named(allow_dio, sg_allow_dio, int, S_IRUGO | S_IWUSR);
@@ -1837,7 +1837,7 @@ sg_build_indirect(Sg_scatter_hold * schp, Sg_fd
* sfp, int buff_size)
     if (mx_sc_elems < 0)
         return mx_sc_elems;    /* most likely -ENOMEM */

-    num = scatter_elem_sz;
+    num = max(scatter_elem_sz, PAGE_SIZE);
     if (unlikely(num != scatter_elem_sz_prev)) {
         if (num < PAGE_SIZE) {
             scatter_elem_sz = PAGE_SIZE;
-- 
2.34.1

