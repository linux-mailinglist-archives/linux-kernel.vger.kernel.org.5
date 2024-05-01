Return-Path: <linux-kernel+bounces-165109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3148B8830
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA840B22182
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677B52F6A;
	Wed,  1 May 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIfF1rP4"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9D51036
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714556605; cv=none; b=uzmG43XUnGSFirrgihbcYmUs0TWEPPCT/YqhKxLs8kM4ib5Xmql08C731G6gR84+PnX/ntPClIHxQ7Yg0voMME7r48S7CPa1umLZPD1cWs4kK0c85x/HTZ/xgq2kLlF1Tjp9Z7CtwXhhr2v0Ykar/4cjaWMEOUt5sByG029NSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714556605; c=relaxed/simple;
	bh=3jg62h3Hu2fuaFdbjnT3RxfYocLA0/tePdSgajJKJ38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G25AK2kqU5YiXEZtmqQYF585SZ1WzQFnNKB2Z2KB+VCUxPQ5dfl+rKzhsxnR01GnRLk2CABGAwa1CIyPCKcg+EP/6B3N32j73zQi1zcag5or7ptIEd85VMRs8fH/MsZVRK6Qo+SaXwNdt6v1ih5SEk8NHy9zyCyzdVRcHh2GFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIfF1rP4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a58d0aea14cso651787466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714556601; x=1715161401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5XTpNV3JYiAh3NDp1NR0OjOOZ2RzglJr33dx3TuYGQ=;
        b=SIfF1rP4LfhL6Bbt0A48dQ0AuF/W3Yc6CoKvECYFi+T1MkSzeoLnIU6EdXvcSY5rxc
         qOP19a+aRkcRtT5EVguhSEHgfSAioLvKUb4CHUxvbF29HH11Bi0jDgIXHZCjI3b4kwrO
         H2qWYKDRTA+f2kB+kGW/fWy3WqV4i9pxyco8mCtZduEPmBNMx7AyA7wBsUJzSgDemnsQ
         JYw18n6NWmFP74XBpv1R9340Y23ucWSkVu6iGxYftpPjIG3ijptDbIIqraVJEqWH6gfL
         pQqUrN+tA8pEE4SPcugx2TgV6uXsJUhh0sPmvXwP+rVQVUOHhbi4L6EvXlkzMsThNmcz
         3oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714556601; x=1715161401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5XTpNV3JYiAh3NDp1NR0OjOOZ2RzglJr33dx3TuYGQ=;
        b=WFm5mWJJexurv6zdKostyg96rUmZ3prenJv489EuAiGx22b8bJfaOowtLB6ttsRW1i
         K+H84jc3KLstEsiBCjnRSs2gHo+NAykPSQ1XQzGpYfCi90uun0ejyYh1h5xucEZR4JWt
         8qN1HwTw/VDBd/08y9oUXIMls8/SOPlOvsc3rte4mb16GgMR3Xt/9NM5qaZrPT5fngpL
         LUonBP/7pUlyMt3UmAJpGcUMsT77grKXdxWP8A0TBO/yRyDm8lSC0fNCJhF68hlejrON
         dccfQ7Q1pMcZqc0tht7J7hYFyT8sXo7o93SoIqrcLE5rosrpu3d17kQBfytmtbp2FbYl
         XM5A==
X-Forwarded-Encrypted: i=1; AJvYcCVm4ChVuxS9nHkkyuMx9CBKe79n2ReRCDfTI5OoD6uIfLuh+Hd7C4O9tyZzVDy/9b0gBPksNfkxzi5hpmHc4jdn+muJ1j3HNBjgFFoL
X-Gm-Message-State: AOJu0YzpUkKhpQqHUPvgBGbHNF66BjXgV/MckZWamicY+6sr4IvcV93i
	Vp5ZZkSQr2faAyVbm3onU/TVJdLMjyKdR1HPTpTlg7zGzHBAJtRi
X-Google-Smtp-Source: AGHT+IE4LkSICHZssWAH5s7Vcso/dTkLmYrOc5+M23W2bLjmS9koFtSzNTEZg4PxNW0WFG88PrrLwQ==
X-Received: by 2002:a17:906:33ce:b0:a58:bd17:f96a with SMTP id w14-20020a17090633ce00b00a58bd17f96amr1458600eja.36.1714556601397;
        Wed, 01 May 2024 02:43:21 -0700 (PDT)
Received: from sacco-Inspiron-5559.station (net-37-182-167-227.cust.vodafonedsl.it. [37.182.167.227])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b00a52274ee0a7sm16328635ejp.171.2024.05.01.02.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:43:21 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: sudeep.holla@arm.com
Cc: gregkh@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	skhan@linuxfoundation.org,
	vincenzo.mezzela@gmail.com
Subject: [PATCH 1/2 v3] drivers: reorganize do-while loops
Date: Wed,  1 May 2024 11:43:12 +0200
Message-Id: <20240501094313.407820-2-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
 <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test c = of_get_child_by_name() failures using "if(!c) break;" instead of
having the body of the loop all within the "if(c){ }" body.

This modification is required to move the declaration of the device_node
directly within the loop and take advantage of the automatic cleanup
feature provided by the __free(device_node) attribute.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 drivers/base/arch_topology.c | 107 ++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 52 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 024b78a0cfc1..ea8836f0bb4b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -543,23 +543,24 @@ static int __init parse_core(struct device_node *core, int package_id,
 	do {
 		snprintf(name, sizeof(name), "thread%d", i);
 		t = of_get_child_by_name(core, name);
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
 			of_node_put(t);
+			return -EINVAL;
 		}
+		of_node_put(t);
 		i++;
-	} while (t);
+	} while (1);
 
 	cpu = get_cpu_for_node(core);
 	if (cpu >= 0) {
@@ -599,48 +600,48 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	do {
 		snprintf(name, sizeof(name), "cluster%d", i);
 		c = of_get_child_by_name(cluster, name);
-		if (c) {
-			leaf = false;
-			ret = parse_cluster(c, package_id, i, depth + 1);
-			if (depth > 0)
-				pr_warn("Topology for clusters of clusters not yet supported\n");
-			of_node_put(c);
-			if (ret != 0)
-				return ret;
-		}
+		if (!c)
+			break;
+
+		leaf = false;
+		ret = parse_cluster(c, package_id, i, depth + 1);
+		if (depth > 0)
+			pr_warn("Topology for clusters of clusters not yet supported\n");
+		of_node_put(c);
+		if (ret != 0)
+			return ret;
 		i++;
-	} while (c);
+	} while (1);
 
 	/* Now check for cores */
 	i = 0;
 	do {
 		snprintf(name, sizeof(name), "core%d", i);
 		c = of_get_child_by_name(cluster, name);
-		if (c) {
-			has_cores = true;
-
-			if (depth == 0) {
-				pr_err("%pOF: cpu-map children should be clusters\n",
-				       c);
-				of_node_put(c);
-				return -EINVAL;
-			}
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
 
+		if (depth == 0) {
+			pr_err("%pOF: cpu-map children should be clusters\n", c);
 			of_node_put(c);
-			if (ret != 0)
-				return ret;
+			return -EINVAL;
 		}
+
+		if (leaf) {
+			ret = parse_core(c, package_id, cluster_id, core_id++);
+		} else {
+			pr_err("%pOF: Non-leaf cluster with core %s\n",
+				cluster, name);
+			ret = -EINVAL;
+		}
+
+		of_node_put(c);
+		if (ret != 0)
+			return ret;
 		i++;
-	} while (c);
+	} while (1);
 
 	if (leaf && !has_cores)
 		pr_warn("%pOF: empty cluster\n", cluster);
@@ -658,15 +659,17 @@ static int __init parse_socket(struct device_node *socket)
 	do {
 		snprintf(name, sizeof(name), "socket%d", package_id);
 		c = of_get_child_by_name(socket, name);
-		if (c) {
-			has_socket = true;
-			ret = parse_cluster(c, package_id, -1, 0);
-			of_node_put(c);
-			if (ret != 0)
-				return ret;
-		}
+		if (!c)
+			break;
+
+		has_socket = true;
+		ret = parse_cluster(c, package_id, -1, 0);
+		of_node_put(c);
+		if (ret != 0)
+			return ret;
+
 		package_id++;
-	} while (c);
+	} while (1);
 
 	if (!has_socket)
 		ret = parse_cluster(socket, 0, -1, 0);
-- 
2.34.1


