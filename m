Return-Path: <linux-kernel+bounces-29061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A628307C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D9A1F214A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DB1200D5;
	Wed, 17 Jan 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="O/fsvbkW"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295E224DA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500913; cv=none; b=LsTCiglRl21L0RUW40zlr3ZhYK2zT7VO1UKwKvSIgcV9P3LmZnc2ev4mAfbutHiE1GAIFnjBgyBydLvUeoAkH8FR3iMQViO2Vp86+9Ecv/cG0j0awnam/Lnz0gpHBgjYWauSnykISdkqcWEJCvzp35bPu6ZOR1KoYLGUFBFxFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500913; c=relaxed/simple;
	bh=R2ihv3gxBjZQJ8LHAqGvREa3UZH1OP8g3M6pOjjvNd0=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=N+QvQWRAqPypHUjIa7KTQuK8cj8OWmSB7yJFPI56fRltjgubnhzztD3SWuhvcorgny84uWdhcR0uzkJ5gdAqO8K6+r4sGca/DzJs1fDyAlavw7Z0YP78RVFIZpbt5XLsmcz3JN1ee7I7avjz0GZcbIRb+CA/+BI7VF0NQ7KaY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=O/fsvbkW; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jROq028480;
	Wed, 17 Jan 2024 06:14:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=l+S3NRJZhZMZgic+Qg3QaXyHk6lYRiz6QfTJLOdTtvU=; b=O/f
	svbkW6gIfyjwmzl/FgCh5iDYg3mix3P3+KVpgMAEqve/+AsSgxL6BV4lvUhkCoHf
	mCGvyeGIDFklERsAt54ZI7TLXsfmgiivYxvmJLRpi9zm6iczAXQYRHxhXd4EBwTk
	fXFC67TQA1r6rWymkarDh1f9Owr/THgfkfkJtWqkLpLwhDOm12Y+kGsQE88KBkDd
	U+TwIFtfKlCC6OTlsNNu1AHA0FqFJVi6UA24loSUsGZZ36BpijjYHORHXoEadpiu
	1tLPGvJsv3Pa/gYb3067n5D0Px+5+Xi+bnYbD/Pzucmgs5EHDq/Hd52AXjknIQb3
	Tk1UEan28F1T0uLDDmA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask9538-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:56 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:54 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 00B125B6932;
	Wed, 17 Jan 2024 06:14:50 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 11/14] arm_mpam: Fix Downstream and internal priority mask
Date: Wed, 17 Jan 2024 19:44:02 +0530
Message-ID: <20240117141405.3063506-12-amitsinght@marvell.com>
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
X-Proofpoint-ORIG-GUID: f_mntF0stDJ-zIfagyjHlMshtsHXYiSJ
X-Proofpoint-GUID: f_mntF0stDJ-zIfagyjHlMshtsHXYiSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

MPAMF_PRI_IDR_NS[DSPRI_WD] determines the number of implemented bits in
the downstream priority field (MPAMCFG_PRI_NS). For instance, if the value
of DSPRI_WD is 4, then the maximum value for dspri is 0xf, and mask should
be GENMASK(3,0).

But with current implementation, it turned out to be GENMASK(4,0) .i.e.
0x1f instead of 0xf.

u16 dspri = GENMASK(rprops->dspri_wd, 0);

Let's fix it (for both downstream, and internal), by subtracting 1 from
DSPRI_WD, and INTPRI_WD value.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
		* Include fix for INTPRI as well.
---
 drivers/platform/mpam/mpam_devices.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
index 3ef9e5d70afc..9953f2050d35 100644
--- a/drivers/platform/mpam/mpam_devices.c
+++ b/drivers/platform/mpam/mpam_devices.c
@@ -1099,8 +1099,8 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	struct mpam_msc *msc = ris->msc;
 	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
 	struct mpam_props *rprops = &ris->props;
-	u16 dspri = GENMASK(rprops->dspri_wd, 0);
-	u16 intpri = GENMASK(rprops->intpri_wd, 0);
+	u16 dspri = GENMASK((rprops->dspri_wd - 1), 0);
+	u16 intpri = GENMASK((rprops->intpri_wd - 1), 0);
 
 	lockdep_assert_held(&msc->lock);
 
-- 
2.25.1


