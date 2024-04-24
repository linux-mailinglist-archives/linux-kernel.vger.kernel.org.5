Return-Path: <linux-kernel+bounces-157005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB6F8B0B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703711C223EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE715D5B3;
	Wed, 24 Apr 2024 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM8AjmSY"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D015CD7B;
	Wed, 24 Apr 2024 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966598; cv=none; b=Ka+dqlIz5ZEO7f/tRs+g0Idxriv/JPT0AdeJqS4ZAOB35/PGtMis1waKbsBKZwhMkiQeLHaEMJcuOfej4lijAHXjH04ZrrWXzaVWC3xazY65OqRBpK6H8gh8U4rTV4q49jPA9cZlSh4jrCldUNn2uUBrT8wgidNQUknrpwJ5KxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966598; c=relaxed/simple;
	bh=MouoPKar+X5yIWVQYlP03da96aYzk+t63W2CcZPjafI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJM19kMYQTVPJhnJOCea74bMVDZVEBLs1fU/MsM2xsdy3w7zRoX54u4TjAJ4552tNE0rL6usYMgKgVpamwQljl/Gu/Wng5yCpSh7Lmt4WkFX8Wn5bKiF0fZyYjvNxT1aNA6BOSE0IIbDb06EI3jQmm8dT5Yy8wFHSnesqQRxC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM8AjmSY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so4771810a91.0;
        Wed, 24 Apr 2024 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713966596; x=1714571396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwhsTYLZsnUNQpsQtO3gTMvucJ5x+wdSVZX3hNQvMgk=;
        b=RM8AjmSYtZ/AgbjTTKlUmg1DEDFiH+9AFAeK3yFMlOcrRUAY9RecIf8nZVyJUGmxCX
         p4/KZBHwtbR9Svm1wa5/FdenmGya09a6zyno00geiJz+9nfNbIcEeeOYPcHZiL2Rwwfx
         QyX6SjYsdt9/DRQxGF6KLceXRpUsAzyRlE0m9h/TcgTAuDU5azoUZ7oMhiU64rPWPp1H
         u4bxf408xlpnsEh79Pm47kPXD74+nE8Lf94ztDLhzG1e4ozvVwwviCqjOmq6RWaNruMi
         N4HMVW3s8Ijk2LZk2Zj1+9wTDPpbZB6ZpJkAbs10zKLvPNy26HU/O+LZ3xsss3ea9wEu
         uSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966596; x=1714571396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwhsTYLZsnUNQpsQtO3gTMvucJ5x+wdSVZX3hNQvMgk=;
        b=lkbO1TDnncUr/AGui87wJUzUdu1fpsAmYD2QhFQEG8phpCPQjCGzwUId2qmtyyde+Y
         VDY6JiUwh+YCsZPyRDkf1v+8deOmioi6nz3XoXEswCAxvJmyXu/YdHheEfFDcoQ+zel9
         zGJ9cxRIEaz5TxRPIAtS5Sz6rC7uK31OfVMNY5Wgm0Hl/DBJ4SWt4iUPPLo8SqwcnvLh
         CI+Ur7GSVRZafgpmexISPFw9xF97uGl+qLVE1MuwuZYsovLuiRawgTs3bfEdgCjbjkyW
         t1gLND9OCG644OomQNUQoetVX4HEPbLe+EIMvsXggWnhed1jRZaURFg2RSeHCzu6SIjm
         ePwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlNPHE/+1SJiGNyBM4CR4AH/12M7JFzD0bwQwZjk827LUqAfhC9PLXC1Ls7Lrb5OCXCmJvCiIU2iGpG7reZqletlHC4InG
X-Gm-Message-State: AOJu0Yxx+iewSOltK9Xe4L3W5y+aC9ZLwesEfBvHu2ntG+triXsZjSr2
	Mku5h1GAoBgq4WBwHqTCgGee6go5q4MW/ncj/bv6y33aIL2kTRgI3t+M7A==
X-Google-Smtp-Source: AGHT+IFEJAw3gteyOgCigI4HVi5QkUInRC3VACf+vMdl3oxlxOPCiOCFxVlBBRDga8OOCaDPbAIMlA==
X-Received: by 2002:a17:90a:a417:b0:2ab:d82e:1afb with SMTP id y23-20020a17090aa41700b002abd82e1afbmr2721321pjp.16.1713966596319;
        Wed, 24 Apr 2024 06:49:56 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id ck16-20020a17090afe1000b002a2f6da006csm11273223pjb.52.2024.04.24.06.49.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:49:55 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sam Sun <samsun1006219@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	syzkaller-bugs@googlegroups.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH V2] workqueue: Fix divide error in wq_update_node_max_active()
Date: Wed, 24 Apr 2024 21:51:54 +0800
Message-Id: <20240424135155.1339671-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <CAEkJfYPGS1_4JqvpSo0=FM0S1ytB8CEbyreLTtWpR900dUZymw@mail.gmail.com>
References: <CAEkJfYPGS1_4JqvpSo0=FM0S1ytB8CEbyreLTtWpR900dUZymw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Yue Sun and xingwei lee reported a divide error bug in
wq_update_node_max_active():

divide error: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 6.9.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:wq_update_node_max_active+0x369/0x6b0 kernel/workqueue.c:1605
Code: 24 bf 00 00 00 80 44 89 fe e8 83 27 33 00 41 83 fc ff 75 0d 41
81 ff 00 00 00 80 0f 84 68 01 00 00 e8 fb 22 33 00 44 89 f8 99 <41> f7
fc 89 c5 89 c7 44 89 ee e8 a8 24 33 00 89 ef 8b 5c 24 04 89
RSP: 0018:ffffc9000018fbb0 EFLAGS: 00010293
RAX: 00000000000000ff RBX: 0000000000000001 RCX: ffff888100ada500
RDX: 0000000000000000 RSI: 00000000000000ff RDI: 0000000080000000
RBP: 0000000000000001 R08: ffffffff815b1fcd R09: 1ffff1100364ad72
R10: dffffc0000000000 R11: ffffed100364ad73 R12: 0000000000000000
R13: 0000000000000100 R14: 0000000000000000 R15: 00000000000000ff
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb8c06ca6f8 CR3: 000000010d6c6000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 workqueue_offline_cpu+0x56f/0x600 kernel/workqueue.c:6525
 cpuhp_invoke_callback+0x4e1/0x870 kernel/cpu.c:194
 cpuhp_thread_fun+0x411/0x7d0 kernel/cpu.c:1092
 smpboot_thread_fn+0x544/0xa10 kernel/smpboot.c:164
 kthread+0x2ed/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

After analysis, it happens when all of the CPUs in a workqueue's affinity
get offine.

The problem can be easily reproduced by:

 # echo 8 > /sys/devices/virtual/workqueue/<any-wq-name>/cpumask
 # echo 0 > /sys/devices/system/cpu/cpu3/online

Use the default max_actives for nodes when all of the CPUs in the
workqueue's affinity get offline to fix the problem.

Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Link: https://lore.kernel.org/lkml/CAEkJfYPGS1_4JqvpSo0=FM0S1ytB8CEbyreLTtWpR900dUZymw@mail.gmail.com/
Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Cc: stable@vger.kernel.org
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
Changed from v1:
	when total_cpus==0, use the default values for max_active
	instead of forcing total_cpus>=1
[v1]: https://lore.kernel.org/lkml/20240423124548.1253842-1-jiangshanlai@gmail.com/

 kernel/workqueue.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0066c8f6c154..0105e3c82df4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1594,6 +1594,15 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 	if (off_cpu >= 0)
 		total_cpus--;
 
+	/* If all CPUs of the wq get offline, use the default values */
+	if (unlikely(!total_cpus)) {
+		for_each_node(node)
+			wq_node_nr_active(wq, node)->max = min_active;
+
+		wq_node_nr_active(wq, NUMA_NO_NODE)->max = max_active;
+		return;
+	}
+
 	for_each_node(node) {
 		int node_cpus;
 
-- 
2.19.1.6.gb485710b


