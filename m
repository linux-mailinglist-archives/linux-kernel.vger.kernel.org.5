Return-Path: <linux-kernel+bounces-159634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4508B315F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95EDB22949
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844213C3E2;
	Fri, 26 Apr 2024 07:31:50 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43BF13C3D8;
	Fri, 26 Apr 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116709; cv=none; b=WWmY9h3eJjT0kqc+tE9JQRKZ3/NcFTBBoqR+1cCfmHPcLsNc5pK8OxgQ988VfkH6Qn2KjtXtGDw5rsI0WQO+zYUptZj1MqbQTYMRLlkGPly3y+y0dFXlQXzT9yGVsmnfIdugA1gImAUvgPSp8z22z157cS3Btkrk7w8B2eHh49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116709; c=relaxed/simple;
	bh=arm16OE1aEkyielXnTt8S6Z5w9WGGU1YvZT0ZLzbOlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fj02qz7Fp9gQc6dAxcR6R4qBCL69Icpy5o8qU+wE6DO31rbgFPy4cLrWEDBlhswSCRAQ00tLFXNnG089u2k0LhaNEmI8twJy3VNdXSenNexIqqYtQaOFm7Sxbyr60BV0N4calRBEs8SO7D4h2rzTLYgxrwOgtQ+ZF12WQdARI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78f05e56cb3so103595085a.1;
        Fri, 26 Apr 2024 00:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714116707; x=1714721507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js1Pv8vfnMaLMM7MbQ4TiLj+PkDnYq1Su5z0iwdQFdo=;
        b=ee2Cg57qEsF0ysgb18NJwD2FOEHxbwQtGv3BxiiouRRLGfZkYjTx15uZraW1mFclvd
         mcsP7Y2zqdvRT050hqKvgDbS11YLMETx9jdBPYFkd8xPveYxWeuCDre4TeMzMjEq71oy
         j+jih545uY0VlS/LBcCGYTWfU3zVhvV4PE9pyTjdPqhIKm3TMorc+iyh3bp7U+PmgxP5
         2qB+S5EcumS5cH8+yHMOSVrX346+PsYYzqbZtkamBNBhzrNUSAkSpct9DLv4wUkWxqem
         mFhOsnG2YP3ivRul10mfDN96fGtRGyEvCF7c7DT6ITmyU8ikZDDVkAkc1JNxvwe137Hw
         O+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9bwfBP9HKknaPUWlUxW6xYT7kabc/ejr06oaUQ2qQ81ksSo+8Iqa7/sTV1aiVRT+AgXhuXSQe9YUfzCqOLk9WA+PNXorElZBnBEJ7unxq3lv15E5x51EBYGOX1EZdugjmWbycHGqCfNt9lH8X
X-Gm-Message-State: AOJu0YzDMGy3boyN79wyGHe79Smh4ci0QYXpJ+QCTZCuA03+SSY0AxTx
	QwwVSAbQrZ7lAGN+CeJ37bjzjnPbTdvOvVqMjxTGE8xS5AwoWHLb
X-Google-Smtp-Source: AGHT+IE5yBB8KPANOHMhvbo6WgvbehUynJnjFjSIH9mC5zsZInrCsztj48v+nRg17h9ZbfdrIk5Dyw==
X-Received: by 2002:a05:620a:d8c:b0:790:865b:5b5c with SMTP id q12-20020a05620a0d8c00b00790865b5b5cmr2670505qkl.54.1714116706618;
        Fri, 26 Apr 2024 00:31:46 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id yf9-20020a05620a3bc900b0078efe9e1f50sm7710181qkn.82.2024.04.26.00.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 00:31:46 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: iam@sung-woo.kim
Cc: daveti@purdue.edu,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_send_cmd
Date: Fri, 26 Apr 2024 03:31:42 -0400
Message-Id: <20240426073142.363876-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426072006.358802-1-iam@sung-woo.kim>
References: <20240426072006.358802-1-iam@sung-woo.kim>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrong call trace was attached. The correct one is below.
Sorry!

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in l2cap_connect+0xa67/0x11a0 net/bluetooth/l2cap_core.c:4260
Read of size 8 at addr ffff88810bf040a0 by task kworker/u3:1/311

CPU: 0 PID: 311 Comm: kworker/u3:1 Not tainted 6.8.0+ #61
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x85/0xb0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x18f/0x560 mm/kasan/report.c:488
 kasan_report+0xd7/0x110 mm/kasan/report.c:601
 kasan_check_range+0x262/0x2f0 mm/kasan/generic.c:189
 __kasan_check_read+0x15/0x20 mm/kasan/shadow.c:31
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 l2cap_connect+0xa67/0x11a0 net/bluetooth/l2cap_core.c:4260
 l2cap_bredr_sig_cmd+0x17fe/0x9a70
 l2cap_sig_channel net/bluetooth/l2cap_core.c:6539 [inline]
 l2cap_recv_frame+0x82e/0x86a0 net/bluetooth/l2cap_core.c:7818
 l2cap_recv_acldata+0x379/0xbe0 net/bluetooth/l2cap_core.c:8536
 hci_acldata_packet net/bluetooth/hci_core.c:3876 [inline]
 hci_rx_work+0x64b/0xcb0 net/bluetooth/hci_core.c:4111
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 311:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_alloc_info+0x3c/0x50 mm/kasan/generic.c:575
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xa2/0xc0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1c9/0x390 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 l2cap_chan_create+0x59/0xc80 net/bluetooth/l2cap_core.c:466
 l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1849 [inline]
 l2cap_sock_new_connection_cb+0x14d/0x2a0 net/bluetooth/l2cap_sock.c:1457
 l2cap_connect+0x329/0x11a0 net/bluetooth/l2cap_core.c:4176
 l2cap_bredr_sig_cmd+0x17fe/0x9a70
 l2cap_sig_channel net/bluetooth/l2cap_core.c:6539 [inline]
 l2cap_recv_frame+0x82e/0x86a0 net/bluetooth/l2cap_core.c:7818
 l2cap_recv_acldata+0x379/0xbe0 net/bluetooth/l2cap_core.c:8536
 hci_acldata_packet net/bluetooth/hci_core.c:3876 [inline]
 hci_rx_work+0x64b/0xcb0 net/bluetooth/hci_core.c:4111
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

Freed by task 66:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x44/0x50 mm/kasan/generic.c:589
 poison_slab_object+0x11a/0x190 mm/kasan/common.c:240
 __kasan_slab_free+0x3b/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x106/0x2e0 mm/slub.c:4409
 l2cap_chan_destroy net/bluetooth/l2cap_core.c:509 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_chan_put+0x1e7/0x2b0 net/bluetooth/l2cap_core.c:533
 l2cap_conn_del+0x38e/0x5f0 net/bluetooth/l2cap_core.c:1929
 l2cap_connect_cfm+0xc2/0x11e0 net/bluetooth/l2cap_core.c:8254
 hci_connect_cfm include/net/bluetooth/hci_core.h:1986 [inline]
 hci_conn_failed+0x202/0x370 net/bluetooth/hci_conn.c:1289
 hci_abort_conn_sync+0x913/0xae0 net/bluetooth/hci_sync.c:5359
 abort_conn_sync+0xda/0x110 net/bluetooth/hci_conn.c:2988
 hci_cmd_sync_work+0x20d/0x3e0 net/bluetooth/hci_sync.c:306
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
 worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
 kthread+0x2a9/0x340 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff88810bf04000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 160 bytes inside of
 freed 1024-byte region [ffff88810bf04000, ffff88810bf04400)

The buggy address belongs to the physical page:
page:00000000567b7faa refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10bf04
head:00000000567b7faa order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: 0xffffffff()
raw: 0017ffffc0000840 ffff888100041dc0 0000000000000000 0000000000000001
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810bf03f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810bf04000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88810bf04080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88810bf04100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810bf04180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

