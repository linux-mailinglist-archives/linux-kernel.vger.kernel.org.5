Return-Path: <linux-kernel+bounces-29059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2888307C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026C4280E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2921C22329;
	Wed, 17 Jan 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hrwD04qp"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAA21A16
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500909; cv=none; b=gOu/B6bmCJK0ynvrGwMz9mlm1xacqh1EWYLvGrBwCA0TAnjyKwPM1RZCuhOneLN/CkraJDyWds9icQ+fZ459Wklb8XNnbum6VEgNdkHvXXPsycm+iIZUGskUB1IjplA7qU+sLKKt1KxfancEIL+Qed6At83NdIZLa7+4JXTfkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500909; c=relaxed/simple;
	bh=Uacz0OmaBpPdLHAvxMrAph8YSMi47QQZn4+e3V7k3n0=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=fbfP+MOpF/Dx/bOscRASWH0s2RBIms8g6nQ3V0w3MJsbUMW3a6qVqveIelrKmmLEb+7DAdgRhKXjFE3850oriuFeKQCU9NFCxpYSeVujzVRfz2yz8BPVDZxPo9pjSNhv7HaoN/7a4PRoCsUXuw1h1z2zAxaBWCKgo/7w0cpSczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hrwD04qp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jROo028480;
	Wed, 17 Jan 2024 06:14:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=ClHK3/wLgAYScaXmKMdx+tz4GzxuqNqE2DlmfLex1Jw=; b=hrw
	D04qp8VwXtDOdngWTYpLQTHAQsAV1lE+nexzfgW0tiHgnzQ9L66kDvYL1KUnbtVR
	c8+ifAs+OcpvK9rASdZBXXGwmGVUZjZ/i4owr/K2cdsii7lze1v4ctIfja92RLCO
	yhX/nTLbCmNloAoUCi6hwsQ3geKf/hiF89fAWFlItImiZUGMD73tDggpTdQqG2Fl
	Zz6R+1SDch+SrU54Llg3TMkdRT0RpWe0IAKaT4MVoWKBrYvQv8F9++6OS85apas2
	jhzsR5uItU6N+3QpOo8RFMf4YboKCh4n60SHprynP4npssnOoQimsYRhXU7uuPq4
	uEb4eBgLC1wDCiOnwXA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask9528-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:44 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:42 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 6DC035B6931;
	Wed, 17 Jan 2024 06:14:39 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 08/14] fs/resctrl: Extend schemata write for priority partition control
Date: Wed, 17 Jan 2024 19:43:59 +0530
Message-ID: <20240117141405.3063506-9-amitsinght@marvell.com>
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
X-Proofpoint-ORIG-GUID: 6BxRsaXflju6f4cNxs1tIwQfGAIJiaHO
X-Proofpoint-GUID: 6BxRsaXflju6f4cNxs1tIwQfGAIJiaHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

Currently, Users can pass the configurations for CPBM, and MBA through
schemata file. For instance, CPBM can be passed using:

echo L3:0=ffff > schemata

This change allows, users to pass a new configuration for downstream
priority. For instance, dspri value of "0xa" can be passed as:

echo L3DSPRI:0=a > schemata

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
		* As suggested by Fenghua Yu, Parse for DSPRI is called
		  from parse_line().
		* Decluttering code from rdtgroup_schemata_write().
---
 fs/resctrl/ctrlmondata.c | 59 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 78f9fb1c52fa..f1f57bbfa094 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -30,6 +30,55 @@ typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
 			       struct resctrl_schema *s,
 			       struct rdt_domain *d);
 
+static bool dspri_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+{
+
+	unsigned long dspri_val;
+	bool success = true;
+	int ret;
+
+	ret = kstrtoul(buf, 16, &dspri_val);
+	if (ret) {
+		pr_info("Non-hex character in the mask %s\n", buf);
+		success = false;
+		goto out;
+	}
+
+	if (dspri_val > r->default_dspri_ctrl) {
+		pr_info("dspri value %ld out of range [%d-%d]\n", dspri_val,
+					0, r->default_dspri_ctrl);
+		success = false;
+		goto out;
+	}
+
+	*data = dspri_val;
+
+out:
+	return success;
+}
+
+static int parse_dspri(struct rdt_parse_data *data, struct resctrl_schema *s,
+			struct rdt_domain *d)
+{
+	struct resctrl_staged_config *cfg;
+	struct rdt_resource *r = s->res;
+	unsigned long pri_val;
+
+	cfg = &d->staged_config[s->conf_type];
+	if (cfg->have_new_ctrl) {
+		pr_info("Duplicate domain %d\n", d->id);
+		return -EINVAL;
+	}
+
+	if (!dspri_validate(data->buf, &pri_val, r))
+		return -EINVAL;
+
+	cfg->new_ctrl = pri_val;
+	cfg->have_new_ctrl = true;
+
+	return 0;
+}
+
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
@@ -201,10 +250,14 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	return 0;
 }
 
-static ctrlval_parser_t *get_parser(struct rdt_resource *res)
+static ctrlval_parser_t *get_parser(struct resctrl_schema *s)
 {
-	if (res->fflags & RFTYPE_RES_CACHE)
+	struct rdt_resource *res = s->res;
+
+	if (res->fflags & RFTYPE_RES_CACHE && !s->ctrl_type)
 		return &parse_cbm;
+	else if (s->ctrl_type == SCHEMA_DSPRI)
+		return &parse_dspri;
 	else
 		return &parse_bw;
 }
@@ -218,7 +271,7 @@ static ctrlval_parser_t *get_parser(struct rdt_resource *res)
 static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
-	ctrlval_parser_t *parse_ctrlval = get_parser(s->res);
+	ctrlval_parser_t *parse_ctrlval = get_parser(s);
 	enum resctrl_conf_type t = s->conf_type;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
-- 
2.25.1


