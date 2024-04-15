Return-Path: <linux-kernel+bounces-144520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8E8A4753
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD85B1C2125A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197481CAAF;
	Mon, 15 Apr 2024 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOTVlNb0"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982A14F6C;
	Mon, 15 Apr 2024 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713152446; cv=none; b=mlQEJdb8ENbELRTHKHBBq01z72/hVluQm1Cy582FiVKfCyMf/U3e0qDeas37SyYeQY0SEDKndvpRFgalDOilvgQYB1mlga223+l8SMyDTzIM28yqExRgYvEtuQSc8AZKPo4VO4mwowDimtUGwmU9jL4h92M+oP972iZDOEo9TZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713152446; c=relaxed/simple;
	bh=uoiSB04cS6tScx9gjDFtZSP6QmmDYX9fKUEfSLp0Bn8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ss/lvvDHBR0hGJYzE5cy6UtDz9aqQoGCG0jJiuzi/K6X6mqZYmMveE1bvsA7Qv0lK8N3ijVuWvsFzOwQqBbfJbJ0+W6Fi0d+UYpjY2pudZjj2gjWe6eMRCVMkODeEDAtTbC0zOQQe4mdDSGz8mBkXdvuJquhol+YM0RWpaGobtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOTVlNb0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51a7dc45easo289846466b.2;
        Sun, 14 Apr 2024 20:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713152443; x=1713757243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3VeyPBiF8j0H2LvGyy81ta84iw2Bubo2d/NBOWM4ciY=;
        b=hOTVlNb0y579VajfMAJH2uNjWC6uF0koruNkIPxnE1/jSWRr35VAHm7IMyN4vCsol0
         NsnI/wIDMpuBrp6rRe0DqT+qB7GgaHxi445gglHf+Y9P1IMtPVaTGEVepGh6hJoVDwAD
         Cesthbf10TO2WLPaJpxHo5tyt87Au71sr3+zS96GW5kYCoxdweEsP5kVmL+PzwC1oLoZ
         878nLzIke0C/ZLb4ASY1TvYsXAt+nORQE8NQRLSMqZXBUZRPAPe79zdnDLRl+1bKyxH3
         zgea4hJhg1aKpzqic0r2nS6lwTBBjgVmffqr7lrirK97LwfX9nkhKY6Q7QdSNVycQV7W
         lrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713152443; x=1713757243;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VeyPBiF8j0H2LvGyy81ta84iw2Bubo2d/NBOWM4ciY=;
        b=G5WEKd8Ez0lpNpiBLKdT2OjreVY32aaO0ZB/r9bbeJaChV7w8n3CmqXjIvRtJSMSkY
         lasGRZVmeSIclqka4gek2Vf4IUnSH35hXsUlJEH8ajdcGhh1o1nmndvBqBNA2JR2Q3yv
         uKgrsz4GNRMyAbQbYv8ZjTJSc7r5+KHkLRSa8dDKifwp8FF42uI4o8IYAbVzSM08czkm
         N3cQnyC8t3lfAnp0ELfTN4ZjqOLvneY0AIInzV1/YMBSbduxcS9BS4Ffr9igps0LwMo1
         BxZNzGl491ZFZHymtX7ghJn3fRHxpf+MsGq8bUyF+BwLlWOSgdJqdK0tlY7ooPyItmiK
         SxjA==
X-Gm-Message-State: AOJu0Yxl4M2+xWj6u+3LP0LzJYM4H/Dx+z0wciFrOSMtOpoP81fjzWo/
	MP26iNjOz0qwhOp4qWnhwx3NDZLG4140m9JF2j+vfZLoVVgCSDLr3Ozxmw8Ltbia6QHrf1Kkm1n
	egLn9Ll8P5h/0Z2UfGB65NNuabXcCdiJ1uOA=
X-Google-Smtp-Source: AGHT+IFzJOiZsOExEQ/bFKy+OR9/lWZur+EoNHFuZcIlWzQcRpMT4Y1Jep6kZI81q77qVjqXkORGEqBNZO78d8Si0uc=
X-Received: by 2002:a17:906:7804:b0:a51:b463:6b41 with SMTP id
 u4-20020a170906780400b00a51b4636b41mr5489878ejm.61.1713152442640; Sun, 14 Apr
 2024 20:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Mon, 15 Apr 2024 11:40:31 +0800
Message-ID: <CAEkJfYPYF-nNB2oiXfXwjPG0VVB2Bd8Q8kAq+74J=R+4HkngWw@mail.gmail.com>
Subject: [PATCH net v1] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net, 
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

In function bond_option_arp_ip_targets_set(), if newval->string is an
empty string, newval->string+1 will point to the byte after the
string, causing an out-of-bound read.

BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc1/0x5e0 mm/kasan/report.c:475
 kasan_report+0xbe/0xf0 mm/kasan/report.c:588
 strlen+0x7d/0xa0 lib/string.c:418
 __fortify_strlen include/linux/fortify-string.h:210 [inline]
 in4_pton+0xa3/0x3f0 net/core/utils.c:130
 bond_option_arp_ip_targets_set+0xc2/0x910
drivers/net/bonding/bond_options.c:1201
 __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
 __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
 bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
 bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:156
 dev_attr_store+0x54/0x80 drivers/base/core.c:2366
 sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x96a/0xd80 fs/read_write.c:584
 ksys_write+0x122/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
---[ end trace ]---

Fix it by adding a check of string length before using it.

Reported-by: Yue Sun <samsun1006219@gmail.com>
Signed-off-by: Yue Sun <samsun1006219@gmail.com>
---
 drivers/net/bonding/bond_options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_options.c
b/drivers/net/bonding/bond_options.c
index 4cdbc7e084f4..db8d99ca1de0 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1214,7 +1214,8 @@ static int bond_option_arp_ip_targets_set(struct
bonding *bond,
     __be32 target;

     if (newval->string) {
-        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
+        if (!(strlen(newval->string)) ||
+            !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
             netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
                    &target);
             return ret;
-- 
2.34.1

