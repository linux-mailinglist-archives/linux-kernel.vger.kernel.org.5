Return-Path: <linux-kernel+bounces-105461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E387DE33
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800A91C210C1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F221CAB9;
	Sun, 17 Mar 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwghZ5oG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F131CA89;
	Sun, 17 Mar 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710691092; cv=none; b=EK4eMpf70l7F5yPccHolal8v06QCXd+sBJgxxmaazD+PG5EsqVjcMtYp0s2zUan3EialilSZrFil0woB5vEpJNge0EXWX9HY52Nyc9OZyuckOBdsFHWbJO4PXbhYFZ1OIrIMakN2zUDzhhXNdxt2taDq5d1+qqt8YSJ9ELKDyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710691092; c=relaxed/simple;
	bh=vZeuYhAh2tVxnc+5ynDwh9Mr5IWsLK3cAo6lXHx8A7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+yEQhIpmeG2E9XoOlmtP1M7jHc+G8bwuUkyRk03fqFN5qToeqttutSvOcjkiMngcJsvm+7b1c9vbwXG6jvmry4+DTsH/U7esdKhl4u+Mz+0rFL2kTH8OI512yGcN3zF3+6MmMj+4Kh4T/gmj6XZX6DZfZwQtbBljyncSWjdDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwghZ5oG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e01c38f98cso341015ad.3;
        Sun, 17 Mar 2024 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710691090; x=1711295890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80/MbfT86UuveNqoUzU/+aC14au60excBnK19OYBXQI=;
        b=UwghZ5oGDJxqPypU/UF2fKg8XpBW8T6knA3NIVi7VJqmtePLC5PG4ORiszcD0YTEhJ
         RnH6ie1vYaFOz153N7lU21VjIkt7ODIJjUND5GGWlIoQncNmgek4DCtO4UQGwMN/+Tx+
         yfQz5Oef59vu2G8JuoygOnfM+u/fzK3EkocdnUw7N9LYS4/bAwpZZnq/3K8z/ArlvNyk
         9oT02Zf4SgLzEOSTcglaaPsR/7VeQ3fJqxkFUuuYZJXjxa/1uJ8dUgjPq89sJELERkr8
         RmO0KDrXxPUZZpDHgaDAi1zpXkZEl8tgpLGK70ky3yJ7RTkSJKRJoyQPv16zorwLijuM
         23Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710691090; x=1711295890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80/MbfT86UuveNqoUzU/+aC14au60excBnK19OYBXQI=;
        b=acFjYfLi7fBUUP4Wt/SS8kxCKY9a0juke3TRWZRMb/nzvi4Tb6vMuX2xrV4J6sME1E
         x1ufUwZLGNnzEN96g9hlGz2LDsn2+je1G9aT6ih98UUCFHKz12xNSsaO7xo3RiBXS9+4
         6tEsDwwyrjrXBV72eUu+6aaOKARIeNcYe4v05FKqaENuOzATW2rnVtLdrSvoCTv7T04N
         vv/OOmKJjNdnLdBHznlmlwZx+TTZCwZl3o/lpcyiw6NlK98QoLHjG17X0R/cPBe2P47l
         6ib+jKOJx8dSqXMLHjgAzKwI9ddK5uvv1kgmjrAnbRcK1E4W+ugsmeNvrpa7s2SAKQW4
         9NCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC+c7pmtj/KORr52Vq01Yj6PAAB3CbaF1GnDgRTpL11jU2JYiWW7vbAz5UxMCNCfUQ4Q/N2QAZgAB9zvyczQO/O1bzLGa3AzDdNfGFc5pq333I7bJApkOPsCUWFXsQqUtRaKeoQLZG
X-Gm-Message-State: AOJu0Yxb9r9nOkfcaT1t61zn3Tai0OeDFaqPjOoQjbk+J/iIYV5EAbfU
	TntFcLmMHLSzRxV4VaoZQlXSluzARG4Vj91Vpr4K77MMxjHijY6CLEJ/9uH9oh3xBhYiINdq3pG
	osFfVJVRvegfoOxfXzw1D9wAhI1k=
X-Google-Smtp-Source: AGHT+IFMNUvqGLw7LosLD4a24do3gZIDj3G8fNWvnl2elB7tiI0tAusgkJ/15k13HQ7isk5L2PzBCcsfJg2mNzsJLNA=
X-Received: by 2002:a17:90b:3595:b0:29b:b1f3:c4ab with SMTP id
 mm21-20020a17090b359500b0029bb1f3c4abmr5530953pjb.46.1710691089899; Sun, 17
 Mar 2024 08:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLw8=VM4LxgBsrwTi3HzdvGV7cYJU=4t7MMYTnrDCaDKAQ@mail.gmail.com>
 <cc7eb13f-b61d-4a4c-8c35-394a833d5917@rowland.harvard.edu>
In-Reply-To: <cc7eb13f-b61d-4a4c-8c35-394a833d5917@rowland.harvard.edu>
From: xingwei lee <xrivendell7@gmail.com>
Date: Sun, 17 Mar 2024 23:57:58 +0800
Message-ID: <CABOYnLx1pyG3qjoB9yuRPtDcb3TRbSqTktngXhkPq9UNVd4jLg@mail.gmail.com>
Subject: Re: divide error in alauda_transport
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samsun1006219@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mar 17, 2024, at 23:04, Alan Stern <stern@rowland.harvard.edu> wrote:

On Sun, Mar 17, 2024 at 04:31:01PM +0800, xingwei lee wrote:

Hello I found a bug in latest upstream titled "divide error in
alauda_transport", and maybe is realted with usb.
I comfired in the latest upstream the poc tree can trigger the issue.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

kernel: upstream 9187210eee7d87eea37b45ea93454a88681894a4
config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=1c6662240382da2
with KASAN enabled
compiler: gcc (Debian 12.2.0-14) 12.2.0

divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 PID: 8229 Comm: usb-storage Not tainted 6.8.0-05202-g9187210eee7d #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
RIP: 0010:alauda_read_data drivers/usb/storage/alauda.c:954 [inline]
RIP: 0010:alauda_transport+0xcaf/0x3830 drivers/usb/storage/alauda.c:1184


Can you please test the patch below?

Alan Stern




Index: usb-devel/drivers/usb/storage/alauda.c
===================================================================
--- usb-devel.orig/drivers/usb/storage/alauda.c
+++ usb-devel/drivers/usb/storage/alauda.c
@@ -951,7 +951,6 @@ static int alauda_read_data(struct us_da
unsigned int lba_offset = lba - (zone * uzonesize);
unsigned int pages;
u16 pba;
- alauda_ensure_map_for_zone(us, zone);

/* Not overflowing capacity? */
if (lba >= max_lba) {
@@ -961,6 +960,8 @@ static int alauda_read_data(struct us_da
break;
}

+ alauda_ensure_map_for_zone(us, zone);
+
/* Find number of pages we can read in this block */
pages = min(sectors, blocksize - page);
len = pages << pageshift;


Hi Alan

I apply your patch in my upstream commit
9187210eee7d87eea37b45ea93454a88681894a4

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 115f05a6201a..6eccbadcea78 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -951,7 +951,6 @@ static int alauda_read_data(struct us_data *us,
unsigned long address,
                unsigned int lba_offset = lba - (zone * uzonesize);
                unsigned int pages;
                u16 pba;
-               alauda_ensure_map_for_zone(us, zone);

                /* Not overflowing capacity? */
                if (lba >= max_lba) {
@@ -961,6 +960,8 @@ static int alauda_read_data(struct us_data *us,
unsigned long address,
                        break;
                }

+               alauda_ensure_map_for_zone(us, zone);
+
                /* Find number of pages we can read in this block */
                pages = min(sectors, blocksize - page);
                len = pages << pageshift;

However, the poc still trigger the bug like below:

root@syzkaller:~# ./55a
[  143.702248][   T29] usb 1-1: new high-speed USB device number 2
using dummy_hcd
[  143.941971][   T29] usb 1-1: Using ep0 maxpacket: 8
[  144.062985][   T29] usb 1-1: config 0 interface 0 altsetting 0
endpoint 0xE has invalid maxpacket 6912, setting to 1024
[  144.066725][   T29] usb 1-1: config 0 interface 0 altsetting 0 bulk
endpoint 0xE has invalid maxpacket 1024
[  144.069851][   T29] usb 1-1: config 0 interface 0 altsetting 0
endpoint 0x82 has invalid wMaxPacketSize 0
[  144.073033][   T29] usb 1-1: config 0 interface 0 altsetting 0 bulk
endpoint 0x82 has invalid maxpacket 0
[  144.076132][   T29] usb 1-1: New USB device found, idVendor=07b4,
idProduct=010a, bcdDevice= 1.02
[  144.079142][   T29] usb 1-1: New USB device strings: Mfr=0,
Product=0, SerialNumber=0
[  144.082673][ T4526] systemd-journald[4526]: sd-device: Failed to
chase symlinks in "/sys/dev/char/189:1".
[  144.086529][   T29] usb 1-1: config 0 descriptor??
[  144.103215][ T8204] raw-gadget.0 gadget.0: fail, usb_ep_enable returned -22
[  144.124706][   T29] ums-alauda 1-1:0.0: USB Mass Storage device detected
[  144.153028][   T29] scsi host2: usb-storage 1-1:0.0
[  145.216626][ T1020] scsi 2:0:0:0: Direct-Access     Olympus
MAUSB-10 (Alauda 0102 PQ: 0 ANSI: 0 CCS
[  145.219706][ T1020] scsi 2:0:0:1: Direct-Access     Olympus
MAUSB-10 (Alauda 0102 PQ: 0 ANSI: 0 CCS
[  145.234829][ T1020] sd 2:0:0:0: Attached scsi generic sg2 type 0
[  145.251393][ T1020] sd 2:0:0:1: Attached scsi generic sg3 type 0
[  145.492274][   T73] sd 2:0:0:0: [sdb] Very big device. Trying to
use READ CAPACITY(16).
[  145.932043][   T12] sd 2:0:0:1: [sdc] Very big device. Trying to
use READ CAPACITY(16).
[  145.932844][   T73] sd 2:0:0:0: [sdb] Using 0xffffffff as device size
[  145.935914][   T12] sd 2:0:0:1: [sdc] Using 0xffffffff as device size
[  146.141945][ T8215] divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  146.143565][ T8215] CPU: 1 PID: 8215 Comm: usb-storage Not tainted
6.8.0-05202-g9187210eee7d-dirty #21
[  146.145319][ T8215] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-1.fc38 04/01/2014
[  146.146720][ T8215] RIP: 0010:alauda_transport+0xc65/0x38b0
[  146.147977][ T8215] Code: 84 24 08 01 00 00 00 00 00 00 48 c7 84 24
18 01 00 00 00 00 00 00 48 d3 eb 48 89 d9 85 f6 0f 84 5b 12 00 00 31
d2 41 0f b7 c4 <f7> 74 24 40 66 41 39 dc 41 89 c6 0f 83 08 02 00 00 41
81
[  146.150664][ T8215] RSP: 0018:ffffc9001005fa60 EFLAGS: 00010246
[  146.151539][ T8215] RAX: 0000000000000000 RBX: 0000000000000000
RCX: 0000000000000000
[  146.152672][ T8215] RDX: 0000000000000000 RSI: 0000000000000001
RDI: ffff88802d3d5a00
[  146.153819][ T8215] RBP: 1ffff9200200bf69 R08: 0000000000000001
R09: ffffed1005ed15ad
[  146.154982][ T8215] R10: ffff88802f68b088 R11: ffff88802f68acb8
R12: 0000000000000000
[  146.156122][ T8215] R13: 0000000000000000 R14: 0000000000000000
R15: ffff88802d3d5a00
[  146.157275][ T8215] FS:  0000000000000000(0000)
GS:ffff88823bc00000(0000) knlGS:0000000000000000
[  146.158578][ T8215] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  146.159536][ T8215] CR2: 000055e7fa9c4770 CR3: 000000000c774000
CR4: 0000000000750ef0
[  146.160699][ T8215] PKRU: 55555554
[  146.161232][ T8215] Call Trace:
[  146.161730][ T8215]  <TASK>
[  146.162173][ T8215]  ? die+0x31/0x80
[  146.162718][ T8215]  ? do_trap+0x1b4/0x3c0
[  146.163355][ T8215]  ? alauda_transport+0xc65/0x38b0
[  146.164115][ T8215]  ? do_error_trap+0x9e/0x160
[  146.164788][ T8215]  ? alauda_transport+0xc65/0x38b0
[  146.165542][ T8215]  ? exc_divide_error+0x38/0x50
[  146.166259][ T8215]  ? alauda_transport+0xc65/0x38b0
[  146.167008][ T8215]  ? asm_exc_divide_error+0x1a/0x20
[  146.167782][ T8215]  ? alauda_transport+0xc65/0x38b0
[  146.168546][ T8215]  ? __pfx___lock_acquire+0x10/0x10
[  146.169309][ T8215]  ? __pfx_alauda_transport+0x10/0x10
[  146.170098][ T8215]  ? srso_alias_return_thunk+0x5/0xfbef5
[  146.170909][ T8215]  ? __lock_acquire+0x193f/0x5c00
[  146.171639][ T8215]  usb_stor_invoke_transport+0xea/0x13d0
[  146.172465][ T8215]  ? __pfx_mark_lock+0x10/0x10
[  146.173179][ T8215]  ? __mutex_lock+0x25a/0x1330
[  146.173893][ T8215]  ? __pfx_usb_stor_invoke_transport+0x10/0x10
[  146.174796][ T8215]  ? srso_alias_return_thunk+0x5/0xfbef5
[  146.175640][ T8215]  ? find_held_lock+0x2d/0x110
[  146.176357][ T8215]  ? srso_alias_return_thunk+0x5/0xfbef5
[  146.177172][ T8215]  ? usb_stor_control_thread+0x304/0x980
[  146.178002][ T8215]  ? __pfx_lock_release+0x10/0x10
[  146.178745][ T8215]  ? srso_alias_return_thunk+0x5/0xfbef5
[  146.179581][ T8215]  ? srso_alias_return_thunk+0x5/0xfbef5
[  146.180406][ T8215]  ? mark_held_locks+0x9f/0xe0
[  146.181114][ T8215]  usb_stor_control_thread+0x5d6/0x980
[  146.181928][ T8215]  ? __pfx_usb_stor_control_thread+0x10/0x10
[  146.182784][ T8215]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[  146.183620][ T8215]  ? srso_alias_return_thunk+0x5/0xfbef5
[  146.184438][ T8215]  ? lockdep_hardirqs_on+0x7c/0x100
[  146.185196][ T8215]  ? srso_alias_return_thunk+0x5/0xfbef5
[  146.186007][ T8215]  ? srso_alias_return_thunk+0x5/0xfbef5
[  146.186808][ T8215]  ? __kthread_parkme+0xb5/0x1f0
[  146.187545][ T8215]  ? __pfx_usb_stor_control_thread+0x10/0x10
[  146.188418][ T8215]  kthread+0x2eb/0x3d0
[  146.189202][ T8215]  ? _raw_spin_unlock_irq+0x23/0x50
[  146.189981][ T8215]  ? __pfx_kthread+0x10/0x10
[  146.190712][ T8215]  ret_from_fork+0x2f/0x70
[  146.191387][ T8215]  ? __pfx_kthread+0x10/0x10
[  146.192065][ T8215]  ret_from_fork_asm+0x1a/0x30
[  146.192765][ T8215]  </TASK>
[  146.193222][ T8215] Modules linked in:
[  146.193986][ T8215] ---[ end trace 0000000000000000 ]---
[  146.194815][ T8215] RIP: 0010:alauda_transport+0xc65/0x38b0
[  146.195724][ T8215] Code: 84 24 08 01 00 00 00 00 00 00 48 c7 84 24
18 01 00 00 00 00 00 00 48 d3 eb 48 89 d9 85 f6 0f 84 5b 12 00 00 31
d2 41 0f b7 c4 <f7> 74 24 40 66 41 39 dc 41 89 c6 0f 83 08 02 00 00 41
81
[  146.198822][ T8215] RSP: 0018:ffffc9001005fa60 EFLAGS: 00010246
[  146.199783][ T8215] RAX: 0000000000000000 RBX: 0000000000000000
RCX: 0000000000000000
[  146.200998][ T8215] RDX: 0000000000000000 RSI: 0000000000000001
RDI: ffff88802d3d5a00
[  146.202239][ T8215] RBP: 1ffff9200200bf69 R08: 0000000000000001
R09: ffffed1005ed15ad
[  146.203581][ T8215] R10: ffff88802f68b088 R11: ffff88802f68acb8
R12: 0000000000000000
[  146.204813][ T8215] R13: 0000000000000000 R14: 0000000000000000
R15: ffff88802d3d5a00
[  146.206034][ T8215] FS:  0000000000000000(0000)
GS:ffff88823bd00000(0000) knlGS:0000000000000000
[  146.207351][ T8215] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  146.208325][ T8215] CR2: 000055e7fa9cf2c8 CR3: 0000000027014000
CR4: 0000000000750ef0
[  146.209490][ T8215] PKRU: 55555554
[  146.210032][ T8215] Kernel panic - not syncing: Fatal exception
[  146.211335][ T8215] Kernel Offset: disabled
[  146.212003][ T8215] Rebooting in 86400 seconds..


Best regards
xingwei Lee

