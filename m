Return-Path: <linux-kernel+bounces-155201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518568AE6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC9BB2437B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDB313774D;
	Tue, 23 Apr 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeHOkbYa"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B9135A49;
	Tue, 23 Apr 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876232; cv=none; b=Vao4XBKNJ9Yrby5FFFOxosyh1rod1rr0m8kPr1wgLLEz/gTm1tZ17ualihVrJvg8+eLEM7WRHTphqtccVOjerUa38CFwy0LwJ124wjyyP5XubWZ9C2kAktTKSuIXb5uQE09fkq1MS7iDDkamMbN1uoaglxxfFjZ5cKw+Qvb+3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876232; c=relaxed/simple;
	bh=UqX36Rw3qePOUwgzw6Vl6gVKugCmL8qWLR7mLwh1MB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aOo8YEe69435BIJ67EqVr0ZOevHLQVvkJj4zLFv8HVBQ6IbhYCmYCIoWitwhMjcH9alRIa0M3EK/Xz1lE+wEWAFOTjUlsWBPy9CawjkOXixoB4Dj1yOeah/9gRSHqSYmogmId222+iItNi6mPX7uqezY5FOGbbEnq3iLdzUEiRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeHOkbYa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so5518944b3a.2;
        Tue, 23 Apr 2024 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713876229; x=1714481029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAmDMmdGnxQmR0z1NAQwsph4bonNjMMuYk2l5OWpTbg=;
        b=XeHOkbYav5/jcOdm4rO+2uGVmf34w27wtOHneo7Gnxl8JQNuJmwZ0m/m9ih7aKzL7U
         luEfNN35EnAvkjH5042nqJObk8Qj2wtCx5HYk4ZMJsnX/QUa0AsL+Z+/riOyoJPra9XO
         yKlh/69JxrcZwzlBkNKDBQOejGsreo5aQRlkeG2RO1aeCtQXpPThfPxRPISOYgjukny3
         Sw8uUL3wKlj4K0pikhiQ1eLuC+NKZkrkVJKRNlETfWWimNGx936uEjmEaoq39j8eCPRW
         fx8YCh2ZT5xRzgzkzEzMoy5fRVZwC6vGtjfeIf4xVScMF+aouUmER0qNZrtM8DwWTEOI
         qfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713876229; x=1714481029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAmDMmdGnxQmR0z1NAQwsph4bonNjMMuYk2l5OWpTbg=;
        b=FuWPFdeDRgudpDC2lmaDhIG0SrsfrKFC08JiPwZoxNu4XN/lPBAOC6bIotZg+1cBSe
         JBBm3859lj4C7LZDyVybv1mZ97+hMjW9Obheup4B8bmV5QDQmufOL50AQ/TFmSM/gRtn
         D0kk5YVuYyZfq6UbcyFinSSJ3eDAN8Xb7VYe3PahCLyRuJA+6z6048ZC9vjb3ntHrLLU
         w4WmPIhQ4O88kOm5bvRQFtK2UqOxmw5j6RAx3qFRzzP8eGCdjAcZkQ9O7TGX7rKtfczn
         gfalNYUQVyuDyqNvuPyDuh0xODFDxnGXETDkq1eCTdzj+/iRAl+nLIPqX1luPVK0F8Q7
         Y3cA==
X-Forwarded-Encrypted: i=1; AJvYcCX05I6F/dBcEZ8hioUI7oRlLeM5LRK6MHdot/iYHF685uYHNLA5isnHrHU7mVBffKvryUmpkmv7wiZozbzweNNsbwGFhNcj
X-Gm-Message-State: AOJu0YytjDCW2NOKYlm8Exg9LdOZ/frgVshinUer+OMJHOS0ZH1N+VOF
	VHLQ1dMrLB6AZcuYGypbnaMv4fVz61uXIzx5uDl17SSN0/OxiLCaJqXhLg==
X-Google-Smtp-Source: AGHT+IE90tOOtpdCjfOiuVbpeoLVuBgz8v7qGhSBEytsn3VfBx8E98GvWWexnSxUsBf4U6KHSmUCtA==
X-Received: by 2002:a05:6a20:96c9:b0:1aa:9595:4261 with SMTP id hq9-20020a056a2096c900b001aa95954261mr13620672pzc.22.1713876229107;
        Tue, 23 Apr 2024 05:43:49 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id a15-20020aa780cf000000b006f0830a298dsm9517060pfn.156.2024.04.23.05.43.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:43:48 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sam Sun <samsun1006219@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	syzkaller-bugs@googlegroups.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Fix divide error in wq_update_node_max_active()
Date: Tue, 23 Apr 2024 20:45:48 +0800
Message-Id: <20240423124548.1253842-1-jiangshanlai@gmail.com>
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

Force the calculation of total_cpus which is used to be the divisor to
be at least 1 to fix the problem.

Link: https://lore.kernel.org/lkml/CAEkJfYPGS1_4JqvpSo0=FM0S1ytB8CEbyreLTtWpR900dUZymw@mail.gmail.com/
Cc: stable@vger.kernel.org
Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0066c8f6c154..b31cd7faeb9f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1591,7 +1591,7 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 		off_cpu = -1;
 
 	total_cpus = cpumask_weight_and(effective, cpu_online_mask);
-	if (off_cpu >= 0)
+	if (off_cpu >= 0 && total_cpus > 1)
 		total_cpus--;
 
 	for_each_node(node) {
-- 
2.19.1.6.gb485710b


