Return-Path: <linux-kernel+bounces-45767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E980843608
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C5D1F26CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE613D575;
	Wed, 31 Jan 2024 05:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJP1/CVT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED163D54C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706678733; cv=none; b=aX30ovJngxvcYEUPk6OChT+Q6g2usQrUsijx07sAR1DTn0mntppp+iNAoxKj5yICg9/kWwBSWiaW66QJmNqNvwopfOa5NzTByHVMQTDT0x3nZrkic3jZAkszxIRC7D+oQZJ1RLxwe7nXjRSvwecH4fHU4rQrbRwB3zRnHdw3uMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706678733; c=relaxed/simple;
	bh=KrJkwg/Yk/VDDPMR1EDcBt7+8G59kzjP1vjjfPRVmeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJcEnSs9wmsNb5+8z5Iy7dIWjla2SNKVBVjSqEzG9W/ltJfRh8aKZolj67P9qDcpcbcAG4wKVEg9Yzr8qc3WnRoTAxD4NW6eDjBH8LDlQqfAA+2GuxboqPh4DsQ48FvfPYXQBQ4r6W8q2VKnXWgRHcrl5loe2gFgSSu2NTamm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJP1/CVT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d9198034acso6825435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706678730; x=1707283530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTXpXgtPeeVhrdOdhIk8nNLkr9CBMpKYwR4zxmHgbns=;
        b=aJP1/CVTW0zo/ZusLP0CkYBM4zFijXTGq41iAYBDnH0MKW0QbcuKEEEBdnK+vwVnyT
         0mOPlwLNKjwEOnnctuasU2Fhm4AuKLn2LdYHR8Hy5UsSHEEUFZBNZlCzGPkEYJShstab
         Ye0Bpf2lA0e3FVIShcFhsM285b8a9GrsF9ukavkWki120a3it3aCIISuAYQ4HCwrmJpm
         OgRQLEueT0GSxvOIjkJBDndcXAaO8b8yuxulfzHdRbJLOz8MhbL3jq6ftHt0dz8CrzY4
         TrOqTlFl0/O/6LNBBR+SPlXyiIBqSjRUTHBm7Q7j9fCfIuuI+iKqrIRykC7zla/GEevh
         wBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706678730; x=1707283530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTXpXgtPeeVhrdOdhIk8nNLkr9CBMpKYwR4zxmHgbns=;
        b=uvD8+8Cr+3mNgb49kIdSmvP5REoebf6cwoaPDyTtpbsEuzbCYOZcpUve5+xtxu1BCi
         qfSo1gTjUwMjQpqepFOIwm6rgzlVycbYWsCTdovnQTeaVpu00qxgCb126hQ7q1CwmrUo
         7nw47p3jqCUY8H6XdH/VCLSuDYsM3xtuveoaOWPNafYOmIFJ3WUKcFWIVL3nAE2u97c0
         3bcuyoeR6v0KUJFN+TPNncnovGNC0GLOsDf8eIOw9UONvYhtz+cX0jhuel2QlpPLTsD8
         v4m0YNL7fwdrLctqR3rlw2PEqIE3bZqwVnJ+rXMJy2SjmYcRQrpiIUOXoT34ICsv8wjq
         W0+w==
X-Gm-Message-State: AOJu0Yz7XYiMUtrV5Q3yNjD1oa2t98tLrRTL3VBM5HQ/ALeeq6HENpc8
	qJZo4hc2tSPJshtf3SAO0JXyvrymF5W0owmG4joClLUvVJf10aLJX61XMkn9QkY=
X-Google-Smtp-Source: AGHT+IGDwO3DEwqMO6tJLZPp3eo4iJSo/rCt8hdwQh9YYLJIFWCo7Wq4ZYcP57iDlxj6DLBPbz4w1Q==
X-Received: by 2002:a17:903:234c:b0:1d8:f4d4:9aa4 with SMTP id c12-20020a170903234c00b001d8f4d49aa4mr864053plh.16.1706678730273;
        Tue, 30 Jan 2024 21:25:30 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id mi3-20020a170902fcc300b001d8ef6eea72sm4027355plb.209.2024.01.30.21.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 21:25:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jan 2024 19:25:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com, kernel-team@meta.com
Subject: [PATCH wq/for-6.9] workqueue: Avoid premature init of
 wq->node_nr_active[].max
Message-ID: <ZbnZyEKH99TIyPGx@slm.duckdns.org>
References: <20240125170628.2017784-1-tj@kernel.org>
 <20240125170628.2017784-10-tj@kernel.org>
 <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
 <ZbfrEx9nnkr0FnZE@slm.duckdns.org>
 <CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>
 <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
 <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>

From 28596c7850a72ee82dc33758f81b71b4e8954c73 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 30 Jan 2024 19:06:43 -1000

System workqueues are allocated early during boot from
workqueue_init_early(). While allocating unbound workqueues,
wq_update_node_max_active() is invoked from apply_workqueue_attrs() and
accesses NUMA topology to initialize wq->node_nr_active[].max.

However, topology information may not be set up at this point.
wq_update_node_max_active() is explicitly invoked from
workqueue_init_topology() later when topology information is known to be
available.

This doesn't seem to crash anything but it's doing useless work with dubious
data. Let's skip the premature and duplicate node_max_active updates by
initializing the field to WQ_DFL_MIN_ACTIVE on allocation and making
wq_update_node_max_active() noop until workqueue_init_topology().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

This doesn't seem to be causing immediate problems but let's nip it in the
bud. Applied to wq/for-6.9.

Thanks.

 kernel/workqueue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 31c1373505d8..ffb625db9771 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -386,6 +386,8 @@ static const char *wq_affn_names[WQ_AFFN_NR_TYPES] = {
 	[WQ_AFFN_SYSTEM]		= "system",
 };
 
+static bool wq_topo_initialized __read_mostly = false;
+
 /*
  * Per-cpu work items which run for longer than the following threshold are
  * automatically considered CPU intensive and excluded from concurrency
@@ -1510,6 +1512,9 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 
 	lockdep_assert_held(&wq->mutex);
 
+	if (!wq_topo_initialized)
+		return;
+
 	if (off_cpu >= 0 && !cpumask_test_cpu(off_cpu, effective))
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
-- 
2.43.0


