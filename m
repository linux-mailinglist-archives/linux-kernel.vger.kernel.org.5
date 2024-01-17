Return-Path: <linux-kernel+bounces-29053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2078307BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27EA31F24BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B207520B22;
	Wed, 17 Jan 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EpgStO15"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4E20B18
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500885; cv=none; b=Ss4PrXmgxyCcW0MJEdbteqRHRZbowT8kTiw9aWLQcbCa59JuQZjrYcnF9xST1+aMLiCiq9bp7emloWja8MLwXyI9UWAJlr2FKpwzsqAlNmC76j8Rl7yEqM2G/ox8IcNXHzl/lnZRbuQ8qfmgucXEuumlZIbEt91pTEpWnB2Q5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500885; c=relaxed/simple;
	bh=uDm5mHo0nvURZEeKSIGljx7UOjUrAZi1t7bGD5kftAo=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=tFQSJNV+hrIEWMyqLUa3CeNaQ76dyGaH91MhVcApxv/GrMgi9oNiJrRgt3fXqFvE/kNimXBf5/Y4R7CFo0Gu1SE1Q2cQf+GptqYUQWvuRQrI4PtOvHkUpQH0RYeT8XphRG5G8QiZA7xrdGwoIZzGBg9wBChe5CRCjF8wvy4qjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EpgStO15; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jhMM028705;
	Wed, 17 Jan 2024 06:14:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=ANvjRHXSTBs+o+k8c9Tv21/16JEVYA9+pOmHZfsxa6g=; b=Epg
	StO15+lQDCJbHRGqTJ0BRWuLsb/FWECFGFixMNlBqH3G/h6MBMh3DukFdR5W0+x1
	thy4nSoYKZk5P6gMHg1oeNO80NfevMyx0EuEqvn2Sh6AJFsX6NLsUXoCj5aSrAQU
	MnBTLy7FMjWNxDudgSE7qPdK1AEvaxII0a1P55sxDAgZVZBIo2M+hf4SCnC5pj11
	t3cOA+Xidz5IIz9C/PeaAck4jnMvDL2+N6lpm1+ySsWWMJMWEcomI9c5fQ5DpLEb
	nsWqmuKx/yILC8UAyruv+VnP0Nhr/8pNN+OokrPKFLmGHRCFLiMnvpWTDuD7w+Nb
	8hIZjhgXBcHFt/jszWQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask951a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:28 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:27 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 09B095B6932;
	Wed, 17 Jan 2024 06:14:23 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 04/14] fs/resctrl: Set-up downstream priority partition resources
Date: Wed, 17 Jan 2024 19:43:55 +0530
Message-ID: <20240117141405.3063506-5-amitsinght@marvell.com>
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
X-Proofpoint-ORIG-GUID: pjjdJceoYJ1X477T0McyxvG5TmSUHVCJ
X-Proofpoint-GUID: pjjdJceoYJ1X477T0McyxvG5TmSUHVCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

Upon resource control group creation, Cache portion bitmap, and Memory
bandwidth allocation gets initialized to the default/maximum values,
obtained from resource control code.

Let's replicate it for priority partition resource, and setup the default
downstream priority value.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
		* Reworked a bit to support new Schemata L3DSPRI, for
		  instance, removed the "dspri_store" flag.      		
---
 drivers/platform/mpam/mpam_resctrl.c |  1 +
 fs/resctrl/rdtgroup.c                | 21 +++++++++++++++++++++
 include/linux/resctrl.h              |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index 6fd2bfeffa0a..02efec42bbe2 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -735,6 +735,7 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
 				class->props.dspri_wd = 0x10;
 
 			r->dspri_data_width = (class->props.dspri_wd + 3) / 4;
+			r->default_dspri_ctrl = BIT_MASK(class->props.dspri_wd) - 1;
 		}
 
 		/*
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 568bb9bb7913..d57eb2c7afa7 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3071,6 +3071,21 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 	return 0;
 }
 
+/* Initialize with default downstream priority values. */
+static int rdtgroup_init_dspri(struct rdt_resource *r, u32 closid)
+{
+	struct resctrl_staged_config *cfg;
+	struct rdt_domain *d;
+
+	list_for_each_entry(d, &r->domains, list) {
+		cfg = &d->staged_config[CDP_NONE];
+		cfg->new_ctrl = r->default_dspri_ctrl;
+		cfg->have_new_ctrl = true;
+	}
+
+	return 0;
+}
+
 /* Initialize MBA resource with default values. */
 static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 {
@@ -3108,6 +3123,12 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 				return ret;
 		}
 
+		if (r->priority_cap && s->ctrl_type == SCHEMA_DSPRI) {
+			ret = rdtgroup_init_dspri(r, rdtgrp->closid);
+			if (ret < 0)
+				return ret;
+		}
+
 		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index cb17c7704fd7..93b3e3b21d5d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -207,6 +207,7 @@ struct resctrl_membw {
  * @data_width:		Character width of data when displaying
  * @dspri_data_width	Character width of dspri value when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
+ * @default_dspri_ctrl: Specifies default downstream priority value.
  * @format_str:		Per resource format string to show domain value
  * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
@@ -226,6 +227,7 @@ struct rdt_resource {
 	int			data_width;
 	int                     dspri_data_width;
 	u32			default_ctrl;
+	u32                     default_dspri_ctrl;
 	const char		*format_str;
 	struct list_head	evt_list;
 	unsigned long		fflags;
-- 
2.25.1


