Return-Path: <linux-kernel+bounces-25135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BA082C858
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F26A1C21D15
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD71EEDD;
	Sat, 13 Jan 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxplUxY4"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C35258
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-598a5448ef5so1653995eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105765; x=1705710565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKmOPtqUBfCJLTZKsue6QrD3IE56HDsg6EADsx/1XFw=;
        b=TxplUxY4+NvDca4v6YN4VdfR7rwl9JuRof4IA1elCZExdT/pK5e5QqPUHIGZxwxPj7
         QsbvcdL9y03VYG4wifJcIJOaJ8UY33JKUtSEwEaruPyMenOQ5ay26ObWvG1Ue/F3Ye74
         wiwBTlj1T2p1cyKlZbmrQXbVA9CPG+UGYhqYDrlBi3ZGMyXm++7+zGOef/An/jBD8Ls6
         Sw42Vk/SK4lOEZyNSjHzWz1cAQzkqu4daveBoSOQN3b9Jd7gurZRddLnqwjlnIuF/n7N
         AL1U8/URcDazz2Rt8BXuHzBfnW2X0PEYB1Ex1E8oaYukeL1kKeMc+GmS17qaqgYQ1qQB
         wqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105765; x=1705710565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKmOPtqUBfCJLTZKsue6QrD3IE56HDsg6EADsx/1XFw=;
        b=C7IWB5lN2Y+y/qqC0K+yPmlS+vZbWoNRkAugINY/c5bUdJzsMrvWyNPd4K5bXXxP8d
         2il5Nb5CrlmV6o46Ciy0GAcvJ7XefDWXKb6dqb6YLz2jknoF9kyWh/qY1mHgB6G7qnqg
         uxfke532RlCQSZoFQlR2XpV5MN2jh7XG6/6PeA1U/DwT3asO97wni78/OiM+mUXNgGuX
         Qr1jkYqumATIjvRjfx93QmiWE0ZjKmqZkZO6SoikxX7SN76efc6cKUbWqCnkNOHDCbpg
         GCL7fKaIEWg92t2P3/JYJqMa/Xr16mTGV6auCrHMdmCJ6ADYRQi0n3qk3GNSBc1A5ORf
         DsBw==
X-Gm-Message-State: AOJu0YwwQE9u/D9/PAWsWoVqXzSVBys6hykPX0KM+DHZXKEb/iK/ePyd
	AHWoNS7qyxF4yyMNA2cH1+w=
X-Google-Smtp-Source: AGHT+IFbfH5G7FDQmztvaQNrYl2SEJfajDaYjy6ykGkILc6xcAhZUzrJtgcYHQp9LqOBzqTCfKmiQQ==
X-Received: by 2002:a05:6359:a1c3:b0:175:13f0:a5bf with SMTP id kn3-20020a056359a1c300b0017513f0a5bfmr2999284rwc.62.1705105764972;
        Fri, 12 Jan 2024 16:29:24 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id px12-20020a17090b270c00b0028e17b2f27esm1382305pjb.13.2024.01.12.16.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:29:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/9] workqueue: Add first_possible_node and node_nr_cpus[]
Date: Fri, 12 Jan 2024 14:28:50 -1000
Message-ID: <20240113002911.406791-7-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113002911.406791-1-tj@kernel.org>
References: <20240113002911.406791-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To track the first possible NUMA node and the number of online CPUs in each
NUMA node, respectively. These will be used to implement system-wide
nr_active for unbound workqueues.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f90f797e73a1..3f45baa96d51 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -53,6 +53,7 @@
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
+#include <linux/topology.h>
 
 #include "workqueue_internal.h"
 
@@ -341,6 +342,8 @@ struct wq_pod_type {
 	int			*cpu_pod;	/* cpu -> pod */
 };
 
+static int first_possible_node __read_mostly;
+static int node_nr_cpus[MAX_NUMNODES] __read_mostly;
 static struct wq_pod_type wq_pod_types[WQ_AFFN_NR_TYPES];
 static enum wq_affn_scope wq_affn_dfl = WQ_AFFN_CACHE;
 
@@ -5617,6 +5620,8 @@ int workqueue_online_cpu(unsigned int cpu)
 	struct workqueue_struct *wq;
 	int pi;
 
+	node_nr_cpus[cpu_to_node(cpu)]++;
+
 	mutex_lock(&wq_pool_mutex);
 
 	for_each_pool(pool, pi) {
@@ -5672,6 +5677,8 @@ int workqueue_offline_cpu(unsigned int cpu)
 	}
 	mutex_unlock(&wq_pool_mutex);
 
+	node_nr_cpus[cpu_to_node(cpu)]--;
+
 	return 0;
 }
 
@@ -6687,6 +6694,9 @@ void __init workqueue_init_early(void)
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
+	first_possible_node = first_node(node_states[N_POSSIBLE]);
+	node_nr_cpus[cpu_to_node(0)]++;
+
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&wq_requested_unbound_cpumask, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&wq_isolated_cpumask, GFP_KERNEL));
-- 
2.43.0


