Return-Path: <linux-kernel+bounces-45728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB688434B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC9D1F24CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242716435;
	Wed, 31 Jan 2024 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewzcVNPB"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299EC14AAA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706673776; cv=none; b=glWJpTX7UURgx09ewabTV4RIZdn/NiApdZyv2uJTDXStiNPTfgKegSfyMxl1eYuLxNgrQTIGft4ZP79b1/vUdOmUEO3qOeyfJGqE5/2RWIIMXx4aUxY0T5Xlgfl24C8oVGArNsl2+6C1JRyUfaOZWhJUFOQM9WLILU4wLut2wL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706673776; c=relaxed/simple;
	bh=UdryQvb4hI+k+WFR7xg0p3kAUNTYa4aoiI2qmInb794=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJg52NzGS5fry7lH98+HkEh7/uC7XoOkQq+0wxo+FVBHBpqJsCuGq1b36XxeKe2oMk+clsQngd833gvWv99hl//dqQZdS9LG8OUPRecfYa324ah43IiBlrvcP2gWRuT0taNYMFqoI5DP2YneAxpK6+lcs8K0FBg2odUDJ2WbYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewzcVNPB; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3637d43496fso8106495ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706673774; x=1707278574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3BeKx7mjuQR3c7EzQDX3ZCzxJONDzxnGQCh2Im3zuw=;
        b=ewzcVNPBZEOkdZ3x4us9lCzmiSX2M3lhqb5ke1HjF7rmyaVAHsbz3Ncsd20GXaDXCX
         8JCBrmxxHxKGr5g+14N+yIbja9puW33VIRjfALY6BrubyiXAPfmhuHV1/K3yK9dIviVt
         WqhHP9N0jlHU5LCAHz4fkiQnRpZAjnEJTzYLREAwLGBCiodYS6KkHSwzIPHqS91G/nxd
         E/FPJHnk2QhOrWTR8xL2GqYnsvJKFiHE4fsyYyHOBE2zVR/XzS0l7KBh5i6oMzzf+crk
         L8nwYUlvGZfuWd6H4z1T7I9P3QftFasX1QHSTN71xREoYZxtkTy+Tb4Zf18G3zTAbpUs
         8zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706673774; x=1707278574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3BeKx7mjuQR3c7EzQDX3ZCzxJONDzxnGQCh2Im3zuw=;
        b=vhtyHrFLIHLWuDzM92TGxGClvZo/jNh3LO9aYNNY8N6WUfW1uStAvhG1SD1kBdldsS
         MX3IJ36luNOAIOK2iR6/aKU7sMRo7kjoZse2/ptRNG7W8v6ljTUUWENv+irLFTMM/7eG
         ORFW9XvSSKPJ88arAT48xikXyo5IgLyO8HSBxM1ntCOrfG5rLc/ufvKipwQPFFsXCM0t
         fDzHNfgQ+JVZorsLxkJWuhrl8swCVt6JloX/WvXsD6vfXyPFi1b2QsyPNbAdQnEb0DmV
         UuU96wZ9Z53Wo/9gm6fSoi/1KykSCFQzqQEaIr9NJSEUSezoaEmEiS/Mt774sn4umBY8
         hV3g==
X-Gm-Message-State: AOJu0Yx3KkvkIX9NAsKoyQ0ZiQp4hbA7w2fTD6sPUEGGQiSXL3UAW/J2
	HE/pn4l9LI5dZoS2Vq3gbPIieNINsQDQ85CTSUewGGmrQ1CZXU2TPlC/MIExY2M=
X-Google-Smtp-Source: AGHT+IFztBebihYQeqwewtEs0Qm3CSTKljAICf9E32HklrRAC9ktgCboXtcwB+M3FXiB0iwladH5bw==
X-Received: by 2002:a05:6e02:1807:b0:363:7d3c:7d34 with SMTP id a7-20020a056e02180700b003637d3c7d34mr802554ilv.5.1706673773991;
        Tue, 30 Jan 2024 20:02:53 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id g128-20020a636b86000000b005dab535fac2sm2335972pgc.90.2024.01.30.20.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 20:02:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jan 2024 18:02:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com, kernel-team@meta.com
Subject: Re: [PATCH v4 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Message-ID: <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>
References: <20240125170628.2017784-1-tj@kernel.org>
 <20240125170628.2017784-10-tj@kernel.org>
 <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
 <ZbfrEx9nnkr0FnZE@slm.duckdns.org>
 <CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>
 <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>

Hello,

Thanks for the report. Can you please test whether the following patch fixes
the problem?

----- 8< -----
From: Tejun Heo <tj@kernel.org>
Subject: workqueue: Fix crash due to premature NUMA topology access on some archs

System workqueues are allocated early during boot from
workqueue_init_early(). While allocating unbound workqueues,
wq_update_node_max_active() is invoked from apply_workqueue_attrs() and
accesses NUMA topology information - cpumask_of_node() and cpu_to_node().

At this point, topology information is not initialized yet and on arm and
some other archs, it leads to an oops like the following:

  Unable to handle kernel paging request at virtual address ffff0002100296e0
  Mem abort info:
     ESR = 0x0000000096000005
     EC = 0x25: DABT (current EL), IL = 32 bits
     SET = 0, FnV = 0
     EA = 0, S1PTW = 0
     FSC = 0x05: level 1 translation fault
  Data abort info:
     ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
     CM = 0, WnR = 0, TnD = 0, TagAccess = 0
     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
  swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000000255a000
  [ffff0002100296e0] pgd=18000001ffff7003, p4d=18000001ffff7003, 
  pud=0000000000000000
  Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-next-20240130+ #14392
  Hardware name: Hardkernel ODROID-M1 (DT)
  pstate: 600000c9 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : wq_update_node_max_active+0x50/0x1fc
  lr : wq_update_node_max_active+0x1f0/0x1fc
  ...
  Call trace:
    wq_update_node_max_active+0x50/0x1fc
    apply_wqattrs_commit+0xf0/0x114
    apply_workqueue_attrs_locked+0x58/0xa0
    alloc_workqueue+0x5ac/0x774
    workqueue_init_early+0x460/0x540
    start_kernel+0x258/0x684
    __primary_switched+0xb8/0xc0
  Code: 9100a273 35000d01 53067f00 d0016dc1 (f8607a60)
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Attempted to kill the idle task!
  ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Fix it by initializing wq->node_nr_active[].max to WQ_DFL_MIN_ACTIVE on
allocation and making wq_update_node_max_active() noop until
workqueue_init_topology(). Note that workqueue_init_topology() invokes
wq_update_node_max_active() on all unbound workqueues, so the end result is
still the same.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: http://lkml.kernel.org/r/91eacde0-df99-4d5c-a980-91046f66e612@samsung.com
Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
---
 kernel/workqueue.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9221a4c57ae1..a65081ec6780 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -386,6 +386,8 @@ static const char *wq_affn_names[WQ_AFFN_NR_TYPES] = {
 	[WQ_AFFN_SYSTEM]		= "system",
 };
 
+static bool wq_topo_initialized = false;
+
 /*
  * Per-cpu work items which run for longer than the following threshold are
  * automatically considered CPU intensive and excluded from concurrency
@@ -1510,6 +1512,9 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 
 	lockdep_assert_held(&wq->mutex);
 
+	if (!wq_topo_initialized)
+		return;
+
 	if (!cpumask_test_cpu(off_cpu, effective))
 		off_cpu = -1;
 
@@ -4356,6 +4361,7 @@ static void free_node_nr_active(struct wq_node_nr_active **nna_ar)
 
 static void init_node_nr_active(struct wq_node_nr_active *nna)
 {
+	nna->max = WQ_DFL_MIN_ACTIVE;
 	atomic_set(&nna->nr, 0);
 	raw_spin_lock_init(&nna->lock);
 	INIT_LIST_HEAD(&nna->pending_pwqs);
@@ -7400,6 +7406,8 @@ void __init workqueue_init_topology(void)
 	init_pod_type(&wq_pod_types[WQ_AFFN_CACHE], cpus_share_cache);
 	init_pod_type(&wq_pod_types[WQ_AFFN_NUMA], cpus_share_numa);
 
+	wq_topo_initialized = true;
+
 	mutex_lock(&wq_pool_mutex);
 
 	/*

