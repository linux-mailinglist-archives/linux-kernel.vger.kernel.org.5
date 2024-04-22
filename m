Return-Path: <linux-kernel+bounces-153416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE28ACDDE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B499B2841E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2654D14F9C4;
	Mon, 22 Apr 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIp0FpOD"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6014A4C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791386; cv=none; b=ht84SmQMvb6ZFK9dyCA+80zLwgTN8sGZ6Upg3k2hbN8XWmbB/4btyFP1R9Fz7aFuBdoWPl3+wNOhLcN8W+1UuErkD0L0F+FxjFzTxmgzuFF2Nd1uM2EDGkT+y2Su57Gnw7crzOziB1Z9SKh8XAXGFUCvn9CkciZgtGvtj4nbceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791386; c=relaxed/simple;
	bh=EmytpR3hiDF7eaHjanNCIBEomEUebZN9dQKzx+9i2PU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tiYJfX2omFzJ83NBM138dUyQOrsFuuAHcndMvKqwchfPgDGn3shNwmA/f8sqeqMgSoanWlmSnqpmrscy0YZLvnixIBtrykFjuvl4CxbkCDzbzv+NFeJaln119cbKnUods4zb9Lg35DCLwhdHWhkK6xsrxb+d2UoPp/yJsHSdukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIp0FpOD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso5316701a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713791383; x=1714396183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud+l648lwWbelghGc5Wsa5A4PKk5RWhMpAeStRI8GJE=;
        b=dIp0FpODZe2kjl/aLPuUc2ry3MFWto2M9i1+cxpDfkTY63h4WoaK9MIgvHbVVQEuA2
         rXz7NY9tQG1Oh41m0LF9Sb3J48y6UKNteolOo0NehJiC4PZwwC4NSukkDkQCzVS5H+KA
         LGQu+/fDgB/m7KaeuHRXnXz84ae5eUKhkXEOwSN7BNnih5xzBRawYqcqZme5pyQeoVDa
         nSpw0McmWbRcEaOhn1muSa+O8jBpWKDMlryPVAewh0NH6iND4xR8MDNjKaRXbwOnnfjG
         J3YogxFbIk7nOGc4HtgitVcTRmzV74PPPtJRJvvAEjmKaJN5IwT72fLMLafqNZ7J4LwD
         t9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713791383; x=1714396183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ud+l648lwWbelghGc5Wsa5A4PKk5RWhMpAeStRI8GJE=;
        b=XGh33S3j+iCsOhZIcnZ2zyg4fEDjkuRU2pTSOrtaB7yknWuBnym3GhSKr/06YtTBu7
         keuGSzpBwMnBDLvTwER7CaUaUqb+hsf/A71szXp+BfRPHlIDlGH1hy7m+NKXOZaHebh3
         WW7VrOSXZr01IRl03zbN9qHLi+tToF9X6lIyy0imPA3dlfzblHP2LpAlv6DIVS9FMN1p
         s9ptc3oIK9809vhSmdBBWSZWu0WUyxvxD8dfgRhupzcPlMUjZ9QvIuAk9ek47HLF9AjS
         AErsS2s8s589xn+wcKADehcXksHd/UnYjlhqMbM+ko2L4OkofJwN3sJeCiOFdpaM92QX
         g+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI+bnc2X8jRmIK82XkEoCPT5f7SVB80oI2HmVXTe3rRRxG6ewOJXsnZB7PFgREcqVj5DTOH5S9wduvh5UY6flOGAX6Vic+T5cZCmJm
X-Gm-Message-State: AOJu0YxHUz4WNx+lnOtL6sS9B2C0gRf/yErMTZYYaNH8e5J+yBhgTvO3
	w6TM6Y8sRxxuvKGeu1FhmidgWWIWVzDNAa42HFCRSCL47sfEyVXM
X-Google-Smtp-Source: AGHT+IHtuJiwVJl1yz6VoRHjbUyZNOg3RMreOBEDMpeMAndfuhBY7QZobDYpH67qQLHNfhqRSAFMsg==
X-Received: by 2002:aa7:c3c4:0:b0:572:4e:3f19 with SMTP id l4-20020aa7c3c4000000b00572004e3f19mr2509209edr.23.1713791382227;
        Mon, 22 Apr 2024 06:09:42 -0700 (PDT)
Received: from sacco-Inspiron-5559.station (net-37-182-167-227.cust.vodafonedsl.it. [37.182.167.227])
        by smtp.gmail.com with ESMTPSA id q11-20020aa7da8b000000b00571c0ba62c8sm5069519eds.32.2024.04.22.06.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:09:41 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: sudeep.holla@arm.com
Cc: gregkh@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	skhan@linuxfoundation.org,
	vincenzo.mezzela@gmail.com
Subject: [PATCH v2] drivers: use __free attribute instead of of_node_put()
Date: Mon, 22 Apr 2024 15:09:31 +0200
Message-Id: <20240422130931.176635-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419140106.3mkayxriqjt2cz5i@bogus>
References: <20240419140106.3mkayxriqjt2cz5i@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the __free attribute for scope-based resource management.
Resources allocated with __free are automatically released at the end of
the scope. This enhancement aims to mitigate memory management issues
associated with forgetting to release resources by utilizing __free
instead of of_node_put().

The declaration of the device_node used within the do-while loops is
moved directly within the loop so that the resource is automatically
freed at the end of each iteration.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
changes in v2:
    - check loop exit condition within the loop
    - add cleanup.h header

 drivers/base/arch_topology.c | 150 +++++++++++++++++------------------
 1 file changed, 73 insertions(+), 77 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 024b78a0cfc1..c9c4af55953e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -20,6 +20,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/units.h>
+#include <linux/cleanup.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/thermal_pressure.h>
@@ -513,10 +514,10 @@ core_initcall(free_raw_capacity);
  */
 static int __init get_cpu_for_node(struct device_node *node)
 {
-	struct device_node *cpu_node;
 	int cpu;
 
-	cpu_node = of_parse_phandle(node, "cpu", 0);
+	struct device_node *cpu_node __free(device_node) =
+		of_parse_phandle(node, "cpu", 0);
 	if (!cpu_node)
 		return -1;
 
@@ -527,7 +528,6 @@ static int __init get_cpu_for_node(struct device_node *node)
 		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
 			cpu_node, cpumask_pr_args(cpu_possible_mask));
 
-	of_node_put(cpu_node);
 	return cpu;
 }
 
@@ -538,28 +538,27 @@ static int __init parse_core(struct device_node *core, int package_id,
 	bool leaf = true;
 	int i = 0;
 	int cpu;
-	struct device_node *t;
 
-	do {
+	for(;;) {
 		snprintf(name, sizeof(name), "thread%d", i);
-		t = of_get_child_by_name(core, name);
-		if (t) {
-			leaf = false;
-			cpu = get_cpu_for_node(t);
-			if (cpu >= 0) {
-				cpu_topology[cpu].package_id = package_id;
-				cpu_topology[cpu].cluster_id = cluster_id;
-				cpu_topology[cpu].core_id = core_id;
-				cpu_topology[cpu].thread_id = i;
-			} else if (cpu != -ENODEV) {
-				pr_err("%pOF: Can't get CPU for thread\n", t);
-				of_node_put(t);
-				return -EINVAL;
-			}
-			of_node_put(t);
+		struct device_node *t __free(device_node) =
+			of_get_child_by_name(core, name);
+		if (!t)
+			break;
+
+		leaf = false;
+		cpu = get_cpu_for_node(t);
+		if (cpu >= 0) {
+			cpu_topology[cpu].package_id = package_id;
+			cpu_topology[cpu].cluster_id = cluster_id;
+			cpu_topology[cpu].core_id = core_id;
+			cpu_topology[cpu].thread_id = i;
+		} else if (cpu != -ENODEV) {
+			pr_err("%pOF: Can't get CPU for thread\n", t);
+			return -EINVAL;
 		}
 		i++;
-	} while (t);
+	}
 
 	cpu = get_cpu_for_node(core);
 	if (cpu >= 0) {
@@ -586,7 +585,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	char name[20];
 	bool leaf = true;
 	bool has_cores = false;
-	struct device_node *c;
 	int core_id = 0;
 	int i, ret;
 
@@ -596,51 +594,51 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	 * scheduler with a flat list of them.
 	 */
 	i = 0;
-	do {
+	for(;;) {
 		snprintf(name, sizeof(name), "cluster%d", i);
-		c = of_get_child_by_name(cluster, name);
-		if (c) {
-			leaf = false;
-			ret = parse_cluster(c, package_id, i, depth + 1);
-			if (depth > 0)
-				pr_warn("Topology for clusters of clusters not yet supported\n");
-			of_node_put(c);
-			if (ret != 0)
-				return ret;
-		}
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(cluster, name);
+		if (!c)
+			break;
+
+		leaf = false;
+		ret = parse_cluster(c, package_id, i, depth + 1);
+		if (depth > 0)
+			pr_warn("Topology for clusters of clusters not yet supported\n");
+		if (ret != 0)
+			return ret;
 		i++;
-	} while (c);
+	}
 
 	/* Now check for cores */
 	i = 0;
-	do {
+	for(;;) {
 		snprintf(name, sizeof(name), "core%d", i);
-		c = of_get_child_by_name(cluster, name);
-		if (c) {
-			has_cores = true;
-
-			if (depth == 0) {
-				pr_err("%pOF: cpu-map children should be clusters\n",
-				       c);
-				of_node_put(c);
-				return -EINVAL;
-			}
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(cluster, name);
+		if (!c)
+			break;
 
-			if (leaf) {
-				ret = parse_core(c, package_id, cluster_id,
-						 core_id++);
-			} else {
-				pr_err("%pOF: Non-leaf cluster with core %s\n",
-				       cluster, name);
-				ret = -EINVAL;
-			}
+		has_cores = true;
 
-			of_node_put(c);
-			if (ret != 0)
-				return ret;
+		if (depth == 0) {
+			pr_err("%pOF: cpu-map children should be clusters\n", c);
+			return -EINVAL;
+		}
+
+		if (leaf) {
+			ret = parse_core(c, package_id, cluster_id, core_id++);
+		} else {
+			pr_err("%pOF: Non-leaf cluster with core %s\n",
+					cluster, name);
+			ret = -EINVAL;
 		}
+
+		if (ret != 0)
+			return ret;
+
 		i++;
-	} while (c);
+	}
 
 	if (leaf && !has_cores)
 		pr_warn("%pOF: empty cluster\n", cluster);
@@ -651,22 +649,23 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 static int __init parse_socket(struct device_node *socket)
 {
 	char name[20];
-	struct device_node *c;
 	bool has_socket = false;
 	int package_id = 0, ret;
 
-	do {
+	for(;;) {
 		snprintf(name, sizeof(name), "socket%d", package_id);
-		c = of_get_child_by_name(socket, name);
-		if (c) {
-			has_socket = true;
-			ret = parse_cluster(c, package_id, -1, 0);
-			of_node_put(c);
-			if (ret != 0)
-				return ret;
-		}
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(socket, name);
+		if (!c)
+			break;
+
+		has_socket = true;
+		ret = parse_cluster(c, package_id, -1, 0);
+		if (ret != 0)
+			return ret;
+
 		package_id++;
-	} while (c);
+	}
 
 	if (!has_socket)
 		ret = parse_cluster(socket, 0, -1, 0);
@@ -676,11 +675,11 @@ static int __init parse_socket(struct device_node *socket)
 
 static int __init parse_dt_topology(void)
 {
-	struct device_node *cn, *map;
 	int ret = 0;
 	int cpu;
 
-	cn = of_find_node_by_path("/cpus");
+	struct device_node *cn __free(device_node) =
+		of_find_node_by_path("/cpus");
 	if (!cn) {
 		pr_err("No CPU information found in DT\n");
 		return 0;
@@ -690,13 +689,14 @@ static int __init parse_dt_topology(void)
 	 * When topology is provided cpu-map is essentially a root
 	 * cluster with restricted subnodes.
 	 */
-	map = of_get_child_by_name(cn, "cpu-map");
+	struct device_node *map __free(device_node) =
+		of_get_child_by_name(cn, "cpu-map");
 	if (!map)
-		goto out;
+		return ret;
 
 	ret = parse_socket(map);
 	if (ret != 0)
-		goto out_map;
+		return ret;
 
 	topology_normalize_cpu_scale();
 
@@ -710,10 +710,6 @@ static int __init parse_dt_topology(void)
 			break;
 		}
 
-out_map:
-	of_node_put(map);
-out:
-	of_node_put(cn);
 	return ret;
 }
 #endif
-- 
2.34.1


