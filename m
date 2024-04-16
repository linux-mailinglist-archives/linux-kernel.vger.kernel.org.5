Return-Path: <linux-kernel+bounces-146753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 629418A6A59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFA21C20B24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0312AAC7;
	Tue, 16 Apr 2024 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+7NA3Cg"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D6483CCD;
	Tue, 16 Apr 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269400; cv=none; b=dQzyVXJiDN2RNL9PRkE0PP7YwRhdOJmcxngCMlvL0PzDWMNYSABi02ktLDVRqISZ0BYLbGFOvPnMf3IeuGFsgWSz/QB5U8lH4Lli754mkUwAk/SEJwCYuD+6llw2MRBeuz99KFSrVWTvLy7eb4kIglnRV6l9lsbDFar4vqPdwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269400; c=relaxed/simple;
	bh=Uen2rRKFKoG4Sxu6FqqVSKDfaN228vkN/gXhjnxasDQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l4S+EQAGQ/jA5FU8AIbrzxu3/YM3tQHnQwtM9HYHASxSgwMmWFm0z/wFL3Xtkg3oI24h1qQ9FTRn3L4FwXJ3h3NLwOJg/OaosLgFBK11ZzBNBxZz8JyYXXI6P0AhA/jr6ZQyzAYg123RMky9/fQNACJseDMMf50e1Tk8oBW12pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+7NA3Cg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56fd7df9ea9so5016906a12.0;
        Tue, 16 Apr 2024 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713269396; x=1713874196; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/lLyDDdxfjIRk/DKPWfZEfUg5akyK70I6US/ujRYhAk=;
        b=B+7NA3CgVdq1JOFaWFTyfo2beJzBsdTHBlq7VBvVgjupoTAafNFB+BwNUbRTU4wTyn
         18SJKvUSgixbPbUHsWA71evzNP3d7d9mAU+p+d94U8hSmVlzyvtDExm8+hHAOko7DS6N
         1TGbTS2Xn7YihzzQLbCQfnbdE7waltf+KYDwF+hnHiKSfS9db6V+PDYrsc5x/AK9OHtm
         wei/1Gr1QfPByqY5jG+uCkpuaeL4znFoOXQDYOj5pUny23ayPuetAd+TfrxSaPWB2UaL
         SfMMaUReRU83veNSeho1ejT8AOJgp29wSwWNSB8OBQz/GU4AdHy+VLxWVxfRN0Cp/XZt
         SHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269396; x=1713874196;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lLyDDdxfjIRk/DKPWfZEfUg5akyK70I6US/ujRYhAk=;
        b=T6BYJ26pTNi2p8srurxCUR6+DSH/vp+Nd4F2LcoaHkA4FmF/IjKYBpyShe/nbVZZet
         0fTze+LFzWUYTTLCahmP27uCuDsXXIbPIX6kGYvTen5zswxZ3mnQtWlgOXv2U6BG34bR
         WPlEogDZ+0phr5VPMbyTzsTaX7uzjkI7EcJ4rJVJ8f/2JuJ+kKOsTXlexWA3/q+WmFpu
         ytgRdMP1XEZHBOMOgP0tvZ1web0bnMgjX4boCDC0fczm5pmZdrkZmGuNCrXevTQNGvTL
         xYEGv9YUCIcn3/Rh7koFI7ra3leAXPopIguq/icKui2CcAdKP5MxoTamEfkmklu0CxRl
         +Z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2DNTSKxXHlOI8bL6puyw2zg8oHFSwMtBrOIDmbyQlo4AdtwakZWy9TEBOOFNiIgQwLnn6yRUnJ4NM9ZoFPLkdPqCfXVo8
X-Gm-Message-State: AOJu0Yze7lJAniF7zNgns8aDaUDyMfgHP5vhcuIbtLv7wvxePys1IH8e
	ecp8Iy/ec98DRrZltRQx95lD5+OlXY+9kCjBmh0pS4x/JnuKHwiBbyppx4LhZ1guH943sqKd6CP
	AeMAwYmMfOLONmaiV+OjrwAyRQZfpxnKdLLXIZdm/
X-Google-Smtp-Source: AGHT+IGJkH+WvN9Tq4w9FrgndS0RzhjW7g8+1wfSzjVF1i6XPgJ0QqwJUNz6U6CtUfR3jknTFQdZNAyXG4v50zrsuiI=
X-Received: by 2002:a17:906:c358:b0:a52:42e4:96e5 with SMTP id
 ci24-20020a170906c35800b00a5242e496e5mr5872060ejb.6.1713269396241; Tue, 16
 Apr 2024 05:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 16 Apr 2024 20:09:44 +0800
Message-ID: <CAEkJfYOnsLLiCrtgOpq2Upr+_W0dViYVHU8YdjJOi-mxD8H9oQ@mail.gmail.com>
Subject: [PATCH net v3] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, j.vosburgh@gmail.com, 
	Hangbin Liu <liuhangbin@gmail.com>, Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, 
	kuba@kernel.org, andy@greyhouse.net, davem@davemloft.net
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

v2
According to Jay and Hangbin's opinion, remove target address in
netdev_err message since target is not initialized in error path and
will not provide useful information.

v3
According to Hangbin's opinion, change Fixes tag from 4fb0ef585eb2
("bonding: convert arp_ip_target to use the new option API") to
f9de11a16594 ("bonding: add ip checks when store ip target").

Fixes: f9de11a16594 ("bonding: add ip checks when store ip target")
Signed-off-by: Yue Sun <samsun1006219@gmail.com>
---
 drivers/net/bonding/bond_options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_options.c
b/drivers/net/bonding/bond_options.c
index 4cdbc7e084f4..8f3fb91897b3 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1214,9 +1214,9 @@ static int bond_option_arp_ip_targets_set(struct
bonding *bond,
     __be32 target;

     if (newval->string) {
-        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
-            netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
-                   &target);
+        if (!(strlen(newval->string)) ||
+            !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
+            netdev_err(bond->dev, "invalid ARP target I4 specified\n");
             return ret;
         }
         if (newval->string[0] == '+')
-- 
2.34.1

