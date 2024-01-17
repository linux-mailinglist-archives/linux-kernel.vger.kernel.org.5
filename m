Return-Path: <linux-kernel+bounces-29052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD638307B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068812869D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F07208CE;
	Wed, 17 Jan 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MCdienl9"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E28D208AF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500876; cv=none; b=pDuQr1AzLd2yAIo/jYVebKmuyu3gqklXk8V6HRCa1tJZRWqMqSYJIMc+Cg8bD2MLTS2kaYl5eugwp/AN/1R3Wql7H9TgshuqMacke+fPvVu0fgzWfcz2GOY4gTABgu4mrN63iRTl+D6eX/IgCmlBpKq+U7y80oYMXzSfiBWoKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500876; c=relaxed/simple;
	bh=lmgZa7f/ELPa6toEIDJ0EyEhSq23V1tYphW716ZxMHc=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version; b=itDxp7PvwXQm0y32+WzqmzCIyRShx8YMlDmx5QNHgRfEq94LOjP0Hbs8TSPKGpbiyWDBY64scr3YKUXoCw1Fmjyc7K0IA1Zfv3PkE6TgCOLNkqb5udcFdg0Imp99jm7QOQZN2onLRqyT17u8u9/Uw7Fj0BL1IE7pd64XdFIaw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MCdienl9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H9DZua012699;
	Wed, 17 Jan 2024 06:14:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=cax1QRJ5lsxNK1A2gaTh4NQDbx9TYQNto6HU4+Cjyck=; b=MCd
	ienl9Jp1cJld56wvt7+QqIVdn/KPA6IKuWxiJw9H1VKgHCB+Sx/gsCO3brIPtlyH
	Vm/EyqRzcVMUk9JjLqebljKUCBrmT2ZOCOD6s8oMLYXmKWefvwbPEVpZIxqAFm/l
	dXPyX5zT3dxTtXXplcAXxpOmcyKPht8m+z9RHPti7IiwOp0uSZHFD6W+EJITJA86
	fuBL/0jFooNSzCYvvXoOTbXGi5f2vp0ywvKgxg5L2F1UM3O4ShJjdeoL7I8RUGtn
	6mX3b69feFITBLFz9eYejuAKSuAcntv1ENVeJ7Uv/Y6rNInX2EkHZS9c/Ec8zxTs
	q3O341t3JBYaRK4wMUA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vp0ge391x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:17 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:15 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 7B9625B693F;
	Wed, 17 Jan 2024 06:14:12 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 01/14] fs/resctrl: group the resource control types for schemata list
Date: Wed, 17 Jan 2024 19:43:52 +0530
Message-ID: <20240117141405.3063506-2-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117141405.3063506-1-amitsinght@marvell.com>
References: <20240117141405.3063506-1-amitsinght@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: dg164YAmtkz7pJkD482dY42myEbx2shd
X-Proofpoint-ORIG-GUID: dg164YAmtkz7pJkD482dY42myEbx2shd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

At the moment, resource control group support the basic control features
(that can be applied to system resources like cache, and Memory)
such as CAT (Cache Allocation Technology), and MBA (Memory Bandwidth
Allocation).

Apart from these basic controls, System can support other controls that
does not directly affect the allocation of memory-system resources.
Instead, it has an effect on conflicts that arise during access to
resources, such as Priority partitioning found on ARM MPAM.

In order to support control types of different nature, lets divide them
into different groups, already existing control features (CAT, and MBA)
is grouped under basic schemata type .i.e. SCHEMATA_BASIC, and to support
priority partition (the downstream priority one), it is placed under
SCHEMA_DSPRI control type. These control type is associated with list(s)
of schemata.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
		* No change, it's new patch.
---
 fs/resctrl/rdtgroup.c         | 26 ++++++++++++++++----------
 include/linux/resctrl.h       |  1 +
 include/linux/resctrl_types.h |  6 ++++++
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 9c5dfaaa7fa2..12e31d4dddf6 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2256,7 +2256,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	return ret;
 }
 
-static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type)
+static int schemata_list_add(struct rdt_resource *r,
+				enum resctrl_conf_type type,
+				enum resctrl_ctrl_type ctrl_type)
 {
 	struct resctrl_schema *s;
 	const char *suffix = "";
@@ -2284,10 +2286,12 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 		break;
 	}
 
-	ret = snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
-	if (ret >= sizeof(s->name)) {
-		kfree(s);
-		return -EINVAL;
+	if (ctrl_type == SCHEMA_BASIC) {
+		ret = snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
+		if (ret >= sizeof(s->name)) {
+			kfree(s);
+			return -EINVAL;
+		}
 	}
 
 	cl = strlen(s->name);
@@ -2300,14 +2304,15 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 	if (r->cdp_capable && !resctrl_arch_get_cdp_enabled(r->rid))
 		cl += 4;
 
-	if (cl > max_name_width)
+	if (cl > max_name_width && ctrl_type == SCHEMA_BASIC)
 		max_name_width = cl;
 
 	/*
 	 * Choose a width for the resource data based on the resource that has
 	 * widest cbm/data_width.
 	 */
-	max_data_width = max(max_data_width, r->data_width);
+	if (ctrl_type == SCHEMA_BASIC)
+		max_data_width = max(max_data_width, r->data_width);
 
 	INIT_LIST_HEAD(&s->list);
 	list_add(&s->list, &resctrl_schema_all);
@@ -2328,17 +2333,18 @@ static int schemata_list_create(void)
 			continue;
 
 		if (resctrl_arch_get_cdp_enabled(r->rid)) {
-			ret = schemata_list_add(r, CDP_CODE);
+			ret = schemata_list_add(r, CDP_CODE, SCHEMA_BASIC);
 			if (ret)
 				break;
 
-			ret = schemata_list_add(r, CDP_DATA);
+			ret = schemata_list_add(r, CDP_DATA, SCHEMA_BASIC);
 		} else {
-			ret = schemata_list_add(r, CDP_NONE);
+			ret = schemata_list_add(r, CDP_NONE, SCHEMA_BASIC);
 		}
 
 		if (ret)
 			break;
+
 	}
 
 	return ret;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3ad308e9e226..125c4b0c2ff7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -249,6 +249,7 @@ struct resctrl_schema {
 	struct list_head		list;
 	char				name[8];
 	enum resctrl_conf_type		conf_type;
+	enum resctrl_ctrl_type          ctrl_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
 };
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index 3897de9c4ecb..b9268ec3ba71 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -57,6 +57,12 @@ enum resctrl_res_level {
 	RDT_NUM_RESOURCES,
 };
 
+enum resctrl_ctrl_type {
+	SCHEMA_BASIC = 0,
+	SCHEMA_DSPRI,
+	SCHEMA_NUM_CTRL_TYPE
+};
+
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
 
 /*
-- 
2.25.1


