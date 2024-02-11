Return-Path: <linux-kernel+bounces-60901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04CC850AC1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A60B20550
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01AB5D46F;
	Sun, 11 Feb 2024 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUQTJ88r"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AEE5B5D5;
	Sun, 11 Feb 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707674415; cv=none; b=brxA63VUG2SVHvd4VHjebfWJIznG+h7lomjqqozUfFKs5VCptZGK78LCBfx4ITyV19n1GZichubZSSbOCrgWJFhW48fBjjLZ3IPAx5r6I1Rocv14MBWZy1d0HL+zxdsoi08cf5GpFZupwsaWcSJk2Mq+p5VNNqRdSkNAXYK0cGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707674415; c=relaxed/simple;
	bh=pvcGgUXdHve+G4Yvyfh2CN1TrTbUhd3SLudRc0qKFOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7zRifEZjpWQXa5z2vIvIzchPb+qk04KUNNppfowaf16zGqcw9AApp+WZWt3x7A0i+IZDgpjEbBMXdg9M20jU/PbsTlsFWXwjVVCcxx/68WArDY83UlHfEJDd58hjTNhJCUQXil+47rW1oxwU+csgV43rvZ9sRXVAiJ5fDuypg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUQTJ88r; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0d799b55cso31320621fa.0;
        Sun, 11 Feb 2024 10:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707674412; x=1708279212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecmyzfj+EomPnTaSfXxezcBKBjA1e6/qD20Cc9Zb224=;
        b=PUQTJ88rZ913vr0i2Y7og6mMNZiA8xd6ROtgZLhJTEAdcfmI4yVBwx85scSjJ6j5vO
         holyVWPkQzbzy69nUHWdxbaCmlD9yA0RGXvYXY1XDp/GTsOpe2kjcny8816el7VDqDMq
         DitNcMPyFNNA7PX1jFbIWJzpGyIR0A3fRWEIxa+ZClY5MjRgXl4wWGWbfThujHSeZMCv
         YWtuHkneXlqQkIZJrxazTlR0cPn4SaUv4w+r9Nnrh7Nca3g+fH1lazm0fiC8O19hyWMo
         /oH/lIDW7ZyADLVV+v9ml+XdFPXClBZyozeoQg28zyYTW7GZF1m+Jl4V/Wjehus/2EMN
         uv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707674412; x=1708279212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ecmyzfj+EomPnTaSfXxezcBKBjA1e6/qD20Cc9Zb224=;
        b=BbOdHfPeyZlK5SqXhwY0OI1tNiz8/fG8aARFOXz+lv+QzTgpw7gzjcrT2D9Me5ycot
         TvGaRuZ0SoViINWopv39c0m1q+VFbDGrCXNL+qZI9Wh0HKKBXTORoVklaZFILbc6V/Pp
         /rf7qYE6hraUcMw+DNngc5hNpRG01twx0Jzk+Zzh4TXQvHJZTSnwBo2vd9QziumEt+zC
         rwvVhqipITo42WoKdo9Xgulshvh8I+KHQ0Oi+kVnLKLncDF1dkp1taDkMfcFxX9ucj7A
         CQzM529PKWEL7ssOhcp5lnLpLc4Tl5XT4j/k9LQPgbtqjZSJAGc0p4MSSx8i45LxN00X
         Qu+Q==
X-Gm-Message-State: AOJu0YyoQwBpix0SE6VPCMSTYI42b5VxeJLqq60tz9xT5IpNcelng/NK
	yJ9vSOzW7GBJTkl7pme5MxMrjwjF6F5qd0kWbtpELbOE0PvQQnNE
X-Google-Smtp-Source: AGHT+IEE3Z2F59ZI5h7AW33ZOYPnhoMa61h5mnnNCfw4YrVnVOWf9fwUZcVg7fppAqplGLf40B6eug==
X-Received: by 2002:ac2:47f4:0:b0:511:86ce:3920 with SMTP id b20-20020ac247f4000000b0051186ce3920mr2055363lfp.7.1707674411763;
        Sun, 11 Feb 2024 10:00:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnFD9BvD09P7B9u4UIv3iZGASFkPgHRS9acr+nZnWEZRTM4t8cUGBzqe3sto4zXzxKUDl7WDitQL7G4yLbKvJBS+nAvh7q29tDGNKhkmsVMPm4UuvBy0XhNFhdXwyDjGMed6xcEWb4kE/kZbgkiExlobN9OZv0/cJMoxjLfnS5qZr0XzYkt0D03zlwIn+c/9IPH0oWKQzLbivqnxeHIw==
Received: from betty.fdsoft.se (213-67-237-183-no99.tbcn.telia.com. [213.67.237.183])
        by smtp.gmail.com with ESMTPSA id n19-20020a0565120ad300b0051184aa32f7sm457160lfu.288.2024.02.11.10.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 10:00:11 -0800 (PST)
Received: from ester.fdsoft.se ([192.168.1.2])
	by betty.fdsoft.se with esmtp (Exim 4.97.1)
	(envelope-from <frej.drejhammar@gmail.com>)
	id 1rZE7e-000000006AT-3v8O;
	Sun, 11 Feb 2024 19:00:10 +0100
From: Frej Drejhammar <frej.drejhammar@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: Frej Drejhammar <frej.drejhammar@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: comedi_8255: Correct error in subdevice initialization
Date: Sun, 11 Feb 2024 18:58:22 +0100
Message-ID: <20240211175822.1357-1-frej.drejhammar@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refactoring done in commit 5c57b1ccecc7 ("comedi: comedi_8255: Rework
subdevice initialization functions") to the initialization of the io
field of struct subdev_8255_private broke all cards using the
drivers/comedi/drivers/comedi_8255.c module.

Prior to 5c57b1ccecc7, __subdev_8255_init() initialized the io field
in the newly allocated struct subdev_8255_private to the non-NULL
callback given to the function, otherwise it used a flag parameter to
select between subdev_8255_mmio and subdev_8255_io. The refactoring
removed that logic and the flag, as subdev_8255_mm_init() and
subdev_8255_io_init() now explicitly pass subdev_8255_mmio and
subdev_8255_io respectively to __subdev_8255_init(), only
__subdev_8255_init() never sets spriv->io to the supplied
callback. That spriv->io is NULL leads to a later BUG:

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: 0010 [#1] SMP PTI
CPU: 1 PID: 1210 Comm: systemd-udevd Not tainted 6.7.3-x86_64 #1
Hardware name: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffa3f1c02d7b78 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff91f847aefd00 RCX: 000000000000009b
RDX: 0000000000000003 RSI: 0000000000000001 RDI: ffff91f840f6fc00
RBP: ffff91f840f6fc00 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 000000000000005f R12: 0000000000000000
R13: 0000000000000000 R14: ffffffffc0102498 R15: ffff91f847ce6ba8
FS:  00007f72f4e8f500(0000) GS:ffff91f8d5c80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000010540e000 CR4: 00000000000406f0
Call Trace:
 <TASK>
 ? __die_body+0x15/0x57
 ? page_fault_oops+0x2ef/0x33c
 ? insert_vmap_area.constprop.0+0xb6/0xd5
 ? alloc_vmap_area+0x529/0x5ee
 ? exc_page_fault+0x15a/0x489
 ? asm_exc_page_fault+0x22/0x30
 __subdev_8255_init+0x79/0x8d [comedi_8255]
 pci_8255_auto_attach+0x11a/0x139 [8255_pci]
 comedi_auto_config+0xac/0x117 [comedi]
 ? __pfx___driver_attach+0x10/0x10
 pci_device_probe+0x88/0xf9
 really_probe+0x101/0x248
 __driver_probe_device+0xbb/0xed
 driver_probe_device+0x1a/0x72
 __driver_attach+0xd4/0xed
 bus_for_each_dev+0x76/0xb8
 bus_add_driver+0xbe/0x1be
 driver_register+0x9a/0xd8
 comedi_pci_driver_register+0x28/0x48 [comedi_pci]
 ? __pfx_pci_8255_driver_init+0x10/0x10 [8255_pci]
 do_one_initcall+0x72/0x183
 do_init_module+0x5b/0x1e8
 init_module_from_file+0x86/0xac
 __do_sys_finit_module+0x151/0x218
 do_syscall_64+0x72/0xdb
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7f72f50a0cb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 71 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd47e512d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000562dd06ae070 RCX: 00007f72f50a0cb9
RDX: 0000000000000000 RSI: 00007f72f52d32df RDI: 000000000000000e
RBP: 0000000000000000 R08: 00007f72f5168b20 R09: 0000000000000000
R10: 0000000000000050 R11: 0000000000000246 R12: 00007f72f52d32df
R13: 0000000000020000 R14: 0000562dd06785c0 R15: 0000562dcfd0e9a8
 </TASK>
Modules linked in: 8255_pci(+) comedi_8255 comedi_pci comedi intel_gtt e100(+) acpi_cpufreq rtc_cmos usbhid
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffa3f1c02d7b78 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff91f847aefd00 RCX: 000000000000009b
RDX: 0000000000000003 RSI: 0000000000000001 RDI: ffff91f840f6fc00
RBP: ffff91f840f6fc00 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 000000000000005f R12: 0000000000000000
R13: 0000000000000000 R14: ffffffffc0102498 R15: ffff91f847ce6ba8
FS:  00007f72f4e8f500(0000) GS:ffff91f8d5c80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000010540e000 CR4: 00000000000406f0

This patch simply corrects the above mistake by initializing spriv->io
to the given io callback.

Fixes: 5c57b1ccecc7 ("comedi: comedi_8255: Rework subdevice initialization functions")
Signed-off-by: Frej Drejhammar <frej.drejhammar@gmail.com>
Cc: <stable@vger.kernel.org>
---
 drivers/comedi/drivers/comedi_8255.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/comedi/drivers/comedi_8255.c b/drivers/comedi/drivers/comedi_8255.c
index e4974b508328..a933ef53845a 100644
--- a/drivers/comedi/drivers/comedi_8255.c
+++ b/drivers/comedi/drivers/comedi_8255.c
@@ -159,6 +159,7 @@ static int __subdev_8255_init(struct comedi_device *dev,
 		return -ENOMEM;
 
 	spriv->context = context;
+	spriv->io      = io;
 
 	s->type		= COMEDI_SUBD_DIO;
 	s->subdev_flags	= SDF_READABLE | SDF_WRITABLE;
-- 
2.43.0


