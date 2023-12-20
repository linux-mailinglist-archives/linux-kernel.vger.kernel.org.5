Return-Path: <linux-kernel+bounces-6477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D6D819970
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6031F22225
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95320208D6;
	Wed, 20 Dec 2023 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlhxLrGn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9CE20332
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ba46a19689so4337379b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057155; x=1703661955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxzi9ZH3ZXDmX6RKO6P2GdkUNrTFYcPXoStsnEgL3J0=;
        b=RlhxLrGnjLcUrhYaUB/7DBDV7j47EOx0D7ElV2BGYDAo1B4LxkFIfb3Lk1/fZ7jaJb
         9gCdFgNnNXk7goXqBwuMIZKWOdzT1yND3GxQd6J73yV4HDmWpg1ao53Xprqqj8q+WM9A
         Iv2OVbO0SgqgjFGVHupZ70PqXm2BrsZU0kD7ZLzhIdXmStxHzgJ3FPSEtYuRhK6d3GaG
         UJZdtst5vb12e3sjn0GVng+VGVF+9urqPmNZRtX96R4rs978hkK1/xCS+J5H+KkYg8aD
         KNY0LL9GO8kEaRgARPrGJ7EyKW2GYOmKTOz1bUlMZg0j7837b0bqYznYxYPMaJ2ZxQeY
         e9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057155; x=1703661955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bxzi9ZH3ZXDmX6RKO6P2GdkUNrTFYcPXoStsnEgL3J0=;
        b=xPRCapSsH26P1FAmmfPve6iU7mwhHJI0w3VAS6DbeJGbfl6xfFhgNyuL46+0Efeiz/
         nPZc1YAhi/FYBM3Dyj49X0Q9YBXbJ92+jFC0uWMwcqvG2Q+4NyiGJTNd0KGQixrlYGY3
         k2CygEealqTxl9IOjSKwQ9vK9GD1jnRPp4zq8rD0kGZcgVRiBglkBIAOZEv4CjIh1q4W
         JwLlbaLO+p1USWyAFJGJtF69471VC0lMoaYtxSuj+ROj846ewhmC5MAUI3twZ1GZTMvd
         tMsIeKxGgTlgrdUJgmkfSk6zdRTpafVaduGliLSykqHtK5DymcPUc8EY2am/KFsTBxyL
         M5Jw==
X-Gm-Message-State: AOJu0YwRE9Bo6d9v6nMiN5sDbM+0u5NYR0oBFvyEed4INgbnlI4Bip4x
	luX5EMFbEk8F19bLTuU3gEg=
X-Google-Smtp-Source: AGHT+IHE1p3oNJJpP6Swk4wb16sSHh3fjJkX1XZ4Um7BTPXxpq0XwofdHzVE27MDdckznwuEUqjCww==
X-Received: by 2002:a05:6808:4446:b0:3ba:130b:af64 with SMTP id ep6-20020a056808444600b003ba130baf64mr24939466oib.38.1703057155304;
        Tue, 19 Dec 2023 23:25:55 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a000bc300b006d8e32935efsm3630774pfu.161.2023.12.19.23.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:25:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/10] workqueue: Add first_possible_node and node_nr_cpus[]
Date: Wed, 20 Dec 2023 16:24:37 +0900
Message-ID: <20231220072529.1036099-7-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220072529.1036099-1-tj@kernel.org>
References: <20231220072529.1036099-1-tj@kernel.org>
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
index 143c0b31505e..a9f63cd61454 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -53,6 +53,7 @@
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
+#include <linux/topology.h>
 
 #include "workqueue_internal.h"
 
@@ -338,6 +339,8 @@ struct wq_pod_type {
 	int			*cpu_pod;	/* cpu -> pod */
 };
 
+static int first_possible_node __read_mostly;
+static int node_nr_cpus[MAX_NUMNODES] __read_mostly;
 static struct wq_pod_type wq_pod_types[WQ_AFFN_NR_TYPES];
 static enum wq_affn_scope wq_affn_dfl = WQ_AFFN_CACHE;
 
@@ -5610,6 +5613,8 @@ int workqueue_online_cpu(unsigned int cpu)
 	struct workqueue_struct *wq;
 	int pi;
 
+	node_nr_cpus[cpu_to_node(cpu)]++;
+
 	mutex_lock(&wq_pool_mutex);
 
 	for_each_pool(pool, pi) {
@@ -5665,6 +5670,8 @@ int workqueue_offline_cpu(unsigned int cpu)
 	}
 	mutex_unlock(&wq_pool_mutex);
 
+	node_nr_cpus[cpu_to_node(cpu)]--;
+
 	return 0;
 }
 
@@ -6601,6 +6608,9 @@ void __init workqueue_init_early(void)
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
+	first_possible_node = first_node(node_states[N_POSSIBLE]);
+	node_nr_cpus[cpu_to_node(0)]++;
+
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
 	cpumask_copy(wq_unbound_cpumask, cpu_possible_mask);
 	restrict_unbound_cpumask("HK_TYPE_WQ", housekeeping_cpumask(HK_TYPE_WQ));
-- 
2.43.0


