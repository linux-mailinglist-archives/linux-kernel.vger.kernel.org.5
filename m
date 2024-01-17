Return-Path: <linux-kernel+bounces-29066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94DF8307CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341CB1F2211D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863B22609;
	Wed, 17 Jan 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QnZPcMGE"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3021A0D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500927; cv=none; b=XFx4lXvDTPczMVTm7LvmMipH2w60/TmWJfkgn+JyMNLg+BSQKlO+Abxi195lDYnAFwDqsYdYBDK/NXWK0how32oQExgFAmytTe+bhNOT3FSlniFf+3uygpE36lbukleOXzK0gfvLyCxnYs3xVwi2qSFGfckIS98f8IR1udhZ/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500927; c=relaxed/simple;
	bh=FPdDtBY/haMyEKtF5ifHGuWUBOHsyQehBf2C9JkxJ6I=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=gXXtWIcTR0wk9DA0Zgqq+pTgdhIrZQHb4HpObY2Xhhp7equVO6WXGD0fPhApEIPGsBhZ0ox5DTknJ/CMbsV2EdyIW8VwIXXRbseePK6VWx1VvUvGqXZw5KEDHVgglpOOPzR88FDWwkgm7ampTZXhZs+toZisREyulsiG9jL21qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QnZPcMGE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jROr028480;
	Wed, 17 Jan 2024 06:15:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=/xN3AdF7Ae4eT32Wd+i6HZ8ojNOSTLKCSBZfFn/Vwhk=; b=QnZ
	PcMGEQGEOruHyipobT//aEmS6RsveLW385X87nb9Zyg0VpGIayETnKDrfBsK635A
	/WbQHy4+dymBS8AOUJmFMKFt6LVOeAzlMftiUyXABzwEp82tkdo/BcX4q/O8waxI
	YfuD2J0DhM1TXH7G1PudFQ6gNjPxJKagHceFoa5qhy9fZpJsG4dq3yNYxlZugVaL
	DO2MZ20lxt9ztBTyWNUfahBqaUjKBirL4y1hqKLNBleTUXAtdNnlr6jDAQYqnZzu
	Q4TjrC8U4dsqutLiLUNUNHDMnmYJFKpZeeXAThGJNGMfRX91iVXh7q/gJY0ciFDC
	MVaMOlIIJQsGjmdTKwg==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask953w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:15:07 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:15:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:15:06 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 8BE755B6963;
	Wed, 17 Jan 2024 06:15:02 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 14/14] arm64/mpam: resctrl: export DSPRI value to info directory
Date: Wed, 17 Jan 2024 19:44:05 +0530
Message-ID: <20240117141405.3063506-15-amitsinght@marvell.com>
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
X-Proofpoint-ORIG-GUID: ZnrcZP3-NuROoWY2QqQdv4tcfeVQxXYM
X-Proofpoint-GUID: ZnrcZP3-NuROoWY2QqQdv4tcfeVQxXYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

Now that, we have support for priority partitioning, let's export
Downstream priority value (maximum value that user can supply) to
info directory. This value is visible under resource directory
to which this control (Downstream priority partition ) is applied.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
                * No change, it's new patch.
---
 fs/resctrl/rdtgroup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index d71fac0ae4d4..8c3df4bb8ee9 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1118,6 +1118,16 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdt_max_dspri_show(struct kernfs_open_file *of,
+				struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
+
+	seq_printf(seq, "%u\n", r->default_dspri_ctrl);
+	return 0;
+}
+
 static int rdt_min_bw_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
@@ -1713,6 +1723,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_bit_usage_show,
 		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
+	{
+		.name           = "max_dspri",
+		.mode           = 0444,
+		.kf_ops         = &rdtgroup_kf_single_ops,
+		.seq_show       = rdt_max_dspri_show,
+		.fflags         = RF_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
 	{
 		.name		= "min_bandwidth",
 		.mode		= 0444,
@@ -2009,6 +2026,9 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 
 	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
+		if (s->ctrl_type == SCHEMA_DSPRI)
+			continue;
+
 		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
 		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
-- 
2.25.1


