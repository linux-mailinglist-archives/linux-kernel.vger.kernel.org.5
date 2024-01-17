Return-Path: <linux-kernel+bounces-29054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A4D8307BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459B4B24CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26DF20B26;
	Wed, 17 Jan 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ebmv5tGY"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2320B16
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500885; cv=none; b=byDKLzzOdqC6VicCEBM4h+f/iOw5r2Y0MqyDLJJZINbLtEybUxRz7Ca3jk7Kx8o16f1LyUA+J/ejeUEdMFwSNcFwyvnRymG2eldytgWq5g5y93i0oiX84FYsBAGsKCpDC9W8H9xNc//QUWJm/XZtoO6ZhGcnNaI+/P5raOGD6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500885; c=relaxed/simple;
	bh=C+aMxZ7Ip/WHsMAvP4P2n1fKInCnWr5NgsE9bQjI62E=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=DlBlp4UE6Fu6jjFhLkQjVbdCiLj9GGbCYjO0jXdHOCrl0Dv1KW32PzVUJ/29A7xUBsIkbckAnUUlFJzO68gP9OImhu3Y1RNS5kRkVYVSu5Aj/Tu1OSz7TbVfm5FOAYKgg/SOAW2wl0EV5KtugZSFJyjE4naib73zKU7z3FW28JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ebmv5tGY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jo62029521;
	Wed, 17 Jan 2024 06:14:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=xA6RMJGilhe9+aPlfzYBX8vaxgYauQ2LjbGUd8YkV/k=; b=Ebm
	v5tGYwdekmSthXwAeQr5CFeWk/VM5oC/ANkfVeka6rPiNP2jl/GAUus2xyz/9JS9
	1FlB2SOreXBE2KQdmzHZ4h4YkdfJN3a/4y4O03x5BydLNbVk9f9ZTXmknPy6F5Fs
	3aPPaoDFmJia4XdPHjuCbaXZbkEijH7oJxrj7GtO6Br9BoJAz+kmy4ZAw6lQl5rs
	wAOxudHu8/HZ8+XU7BcG7jtbs3dabb5uhbVyM48PXb63F5Bxv2Ai8B0j4M2z8cWS
	xtTmKacUWVtgBlq8o9PuioPdniRdQZhbCMMpAcUVtTKFtrwgQ2PEOC+ibvmUi4tf
	YIgeBIQu+51cWntUw0g==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask950w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:25 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:23 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 30F7B5B6931;
	Wed, 17 Jan 2024 06:14:19 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 03/14] arm_mpam: resctrl: extend the schemata list to support priority partition
Date: Wed, 17 Jan 2024 19:43:54 +0530
Message-ID: <20240117141405.3063506-4-amitsinght@marvell.com>
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
X-Proofpoint-ORIG-GUID: ScJjFKCWYsT3vvpncs3L39Bf0sa10WLO
X-Proofpoint-GUID: ScJjFKCWYsT3vvpncs3L39Bf0sa10WLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

At the moment, "schemata" list is consist of two basic control types .i.e.
cache portion bitmap (CPBM), and memory bandwidth allocation (MBA),
represented as following under schemata file.

MB:0=0100
L3:0=ffff

Lets' extend the "schemata" list to support priority partition control,
This control is listed in following format (last column indicates the
priority value) under schemata file.

L3DSPRI:0=f

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
		* This patch is reworked, Now in order to configure DSPRI partition control
                  dedicated schemata is used (L3DSPRI). 
---
 drivers/platform/mpam/mpam_resctrl.c |  7 +++++-
 fs/resctrl/rdtgroup.c                | 34 ++++++++++++++++++++++------
 include/linux/resctrl.h              |  3 +++
 include/linux/resctrl_types.h        |  3 +++
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index 09618d9ceb1d..6fd2bfeffa0a 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -729,8 +729,13 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
 			exposed_alloc_capable = true;
 		}
 
-		if (has_ppart)
+		if (has_ppart) {
 			r->priority_cap = true;
+			if (class->props.dspri_wd > 0x10)
+				class->props.dspri_wd = 0x10;
+
+			r->dspri_data_width = (class->props.dspri_wd + 3) / 4;
+		}
 
 		/*
 		 * MBWU counters may be 'local' or 'total' depending on where
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 12e31d4dddf6..568bb9bb7913 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2261,7 +2261,7 @@ static int schemata_list_add(struct rdt_resource *r,
 				enum resctrl_ctrl_type ctrl_type)
 {
 	struct resctrl_schema *s;
-	const char *suffix = "";
+	const char *suffix = "", *ext_suffix = "";
 	int ret, cl;
 
 	s = kzalloc(sizeof(*s), GFP_KERNEL);
@@ -2286,12 +2286,22 @@ static int schemata_list_add(struct rdt_resource *r,
 		break;
 	}
 
-	if (ctrl_type == SCHEMA_BASIC) {
+	s->ctrl_type = ctrl_type;
+	switch (ctrl_type) {
+	case SCHEMA_DSPRI:
+		ext_suffix = "DSPRI";
+		break;
+	}
+
+	if (ctrl_type == SCHEMA_BASIC)
 		ret = snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
-		if (ret >= sizeof(s->name)) {
-			kfree(s);
-			return -EINVAL;
-		}
+	else
+		ret = snprintf(s->name, sizeof(s->name), "%s%s%s", r->name,
+				suffix, ext_suffix);
+
+	if (ret >= sizeof(s->name)) {
+		kfree(s);
+		return -EINVAL;
 	}
 
 	cl = strlen(s->name);
@@ -2312,7 +2322,9 @@ static int schemata_list_add(struct rdt_resource *r,
 	 * widest cbm/data_width.
 	 */
 	if (ctrl_type == SCHEMA_BASIC)
-		max_data_width = max(max_data_width, r->data_width);
+		s->max_data_width = max(max_data_width, r->data_width);
+	else
+		s->max_data_width = max(max_data_width, r->dspri_data_width);
 
 	INIT_LIST_HEAD(&s->list);
 	list_add(&s->list, &resctrl_schema_all);
@@ -2322,6 +2334,7 @@ static int schemata_list_add(struct rdt_resource *r,
 
 static int schemata_list_create(void)
 {
+	enum resctrl_ctrl_type ctrl_type;
 	enum resctrl_res_level i;
 	struct rdt_resource *r;
 	int ret = 0;
@@ -2345,6 +2358,13 @@ static int schemata_list_create(void)
 		if (ret)
 			break;
 
+		for_each_extend_ctrl_type(ctrl_type) {
+			if (ctrl_type == 1 && r->priority_cap) {
+				ret = schemata_list_add(r, CDP_NONE, SCHEMA_DSPRI);
+				if (ret)
+					break;
+			}
+		}
 	}
 
 	return ret;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d49aed80a05e..cb17c7704fd7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -205,6 +205,7 @@ struct resctrl_membw {
  * @domains:		RCU list of all domains for this resource
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
+ * @dspri_data_width	Character width of dspri value when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
  * @evt_list:		List of monitoring events
@@ -223,6 +224,7 @@ struct rdt_resource {
 	struct list_head	domains;
 	char			*name;
 	int			data_width;
+	int                     dspri_data_width;
 	u32			default_ctrl;
 	const char		*format_str;
 	struct list_head	evt_list;
@@ -256,6 +258,7 @@ struct resctrl_schema {
 	enum resctrl_ctrl_type          ctrl_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
+	int                             max_data_width;
 };
 
 /*
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index b9268ec3ba71..b1a22053d7cd 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -57,6 +57,9 @@ enum resctrl_res_level {
 	RDT_NUM_RESOURCES,
 };
 
+#define for_each_extend_ctrl_type(t)    \
+	for (t = SCHEMA_DSPRI; t != SCHEMA_NUM_CTRL_TYPE; t++)
+
 enum resctrl_ctrl_type {
 	SCHEMA_BASIC = 0,
 	SCHEMA_DSPRI,
-- 
2.25.1


