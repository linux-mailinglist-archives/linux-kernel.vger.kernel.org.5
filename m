Return-Path: <linux-kernel+bounces-94932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA68D8746E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8CD1C21AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466161D54A;
	Thu,  7 Mar 2024 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dFVogi+D"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11C1CFAF;
	Thu,  7 Mar 2024 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782639; cv=none; b=btTx4P2q/6A1sOAFCgNIfZfK4qrwF74OA2Old+XDV19bahmiG9t9SxUwxMBA3kv0jdU922Bw6+uv+i0Lc79IgYUmPtNGjalD+D/IU2XhhFdF5pH5ziP+tbPNbl/cLXfPHiYinENl0ZA74Q1a0nni0SMLrZtbrjuvgfA5Y9SSH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782639; c=relaxed/simple;
	bh=fAt1tQOvTrgvaev9pfXMoxXhOFLMAQ7/sVOoyBUBbCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8Zzb812IbDZhVax1AH7zufjVmiQnEsJsLFXcPkKCWPDnechxrVJH6Hs69qjw+oLRQwWTdp9AinFXLU8LHxnUktAuFX9fAt+j1/vFytbdSRTYrBBO/EBVL7Eyp4LOYCLpapobbmDmyagQQx1LGyAxGrx9UdC7md4hHxDjEYQJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dFVogi+D; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426IMZMx004729;
	Wed, 6 Mar 2024 19:37:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=Z1yQ6LO9CronCnaaj5XgCopl4cNmPdDg4Z0VDcSml5s=; b=dFV
	ogi+DWOCb0Twa+RbHgav+IpGvWSkdezAJ5rk7LRkMpuZt8r6JJhutRK/KPP7b7NA
	HBJDV26ZixCmjMD1BDR3FBPCMHcc03lfn2gFm8ExJT1vzB+q7AvnhIpGSsUX6ZmQ
	glrU7FARI7eK2IDAdDQgBTFaeIJWqKriyfZGCuQXJXzDF59XxR4RQh1RPHUACRdL
	X5PxdN4SILYeOk9pXH5FQ+dZtRmJtH5W14JEq/D2Fmh1GrV4QqtXVyqC27DvXYlF
	YHpOMyXZryLpKcTijbBrCxt4Zjjod2oHzNWJBFVYYOA5BCk5xL+SoqgLpbzdmdc9
	M6OXz4R1Whufb+LuMBg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wpp7bm1bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 19:37:09 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 6 Mar 2024 19:37:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 19:37:07 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 538103F7084;
	Wed,  6 Mar 2024 19:37:03 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>,
        <leo.yan@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v7 6/7] coresight: tmc: Stop trace capture on FlIn
Date: Thu, 7 Mar 2024 09:06:24 +0530
Message-ID: <20240307033625.325058-7-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307033625.325058-1-lcherian@marvell.com>
References: <20240307033625.325058-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Snqe1TOtZpKo10pqPoOB1rVsyHi040pa
X-Proofpoint-GUID: Snqe1TOtZpKo10pqPoOB1rVsyHi040pa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02

Configure TMC ETR and ETF to flush and stop trace capture
on FlIn event based on sysfs attribute,
/sys/bus/coresight/devices/tmc_etXn/stop_on_flush.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v6:
* Added new sysfs attribute stop_on_flush 
* stop_on_flush event is enabled on TMC only upon user request
  for sysfs modes

 .../hwtracing/coresight/coresight-tmc-core.c  | 31 +++++++++++++++++++
 .../hwtracing/coresight/coresight-tmc-etf.c   | 16 +++++++---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 16 +++++++---
 drivers/hwtracing/coresight/coresight-tmc.h   |  4 +++
 4 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index b6bc37159527..701952ce9e87 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -452,9 +452,40 @@ static ssize_t buffer_size_store(struct device *dev,
 
 static DEVICE_ATTR_RW(buffer_size);
 
+static ssize_t stop_on_flush_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sprintf(buf, "%#x\n", drvdata->stop_on_flush);
+}
+
+static ssize_t stop_on_flush_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	int ret;
+	u8 val;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	ret = kstrtou8(buf, 0, &val);
+	if (ret)
+		return ret;
+	if (val)
+		drvdata->stop_on_flush = true;
+	else
+		drvdata->stop_on_flush = false;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(stop_on_flush);
+
+
 static struct attribute *coresight_tmc_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
 	&dev_attr_buffer_size.attr,
+	&dev_attr_stop_on_flush.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 6c3bc7907c58..d3bbadc76bcd 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -19,6 +19,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
 static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
 	int rc = 0;
+	u32 ffcr;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -32,10 +33,12 @@ static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 	}
 
 	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
-	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
-		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
-		       drvdata->base + TMC_FFCR);
+
+	ffcr = TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI | TMC_FFCR_FON_FLIN |
+		TMC_FFCR_FON_TRIG_EVT | TMC_FFCR_TRIGON_TRIGIN;
+	if (drvdata->stop_on_flush_en)
+		ffcr |= TMC_FFCR_STOP_ON_FLUSH;
+	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
 
 	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
 	tmc_enable_hw(drvdata);
@@ -225,7 +228,8 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 		used = true;
 		drvdata->buf = buf;
 	}
-
+	if (drvdata->stop_on_flush)
+		drvdata->stop_on_flush_en = true;
 	ret = tmc_etb_enable_hw(drvdata);
 	if (!ret) {
 		coresight_set_mode(csdev, CS_MODE_SYSFS);
@@ -349,6 +353,8 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 	tmc_etb_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
+	/* Reset stop on flush */
+	drvdata->stop_on_flush_en = false;
 	coresight_set_mode(csdev, CS_MODE_DISABLED);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 6fb9b7659f52..161f31f8bb3d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1056,7 +1056,7 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 
 static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
-	u32 axictl, sts;
+	u32 axictl, sts, ffcr;
 	struct etr_buf *etr_buf = drvdata->etr_buf;
 	int rc = 0;
 
@@ -1102,10 +1102,12 @@ static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 		writel_relaxed(sts, drvdata->base + TMC_STS);
 	}
 
-	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
-		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
-		       drvdata->base + TMC_FFCR);
+	ffcr = TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI | TMC_FFCR_FON_FLIN |
+		TMC_FFCR_FON_TRIG_EVT | TMC_FFCR_TRIGON_TRIGIN;
+	if (drvdata->stop_on_flush_en)
+		ffcr |= TMC_FFCR_STOP_ON_FLUSH;
+	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
+
 	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
 	tmc_enable_hw(drvdata);
 
@@ -1310,6 +1312,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		goto out;
 	}
 
+	if (drvdata->stop_on_flush)
+		drvdata->stop_on_flush_en = true;
 	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
 	if (!ret) {
 		coresight_set_mode(csdev, CS_MODE_SYSFS);
@@ -1805,6 +1809,8 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	tmc_etr_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
+	/* Reset stop on flush */
+	drvdata->stop_on_flush_en = false;
 	coresight_set_mode(csdev, CS_MODE_DISABLED);
 	/* Reset perf specific data */
 	drvdata->perf_buf = NULL;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 528174283ecc..81eadb384b83 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -205,6 +205,8 @@ struct tmc_resrv_buf {
  * @spinlock:	only one at a time pls.
  * @pid:	Process ID of the process being monitored by the session
  *		that is using this component.
+ * @stop_on_flush: Stop on flush trigger user configuration.
+ * @stop_on_flush_en: Stop on flush enable flag
  * @buf:	Snapshot of the trace data for ETF/ETB.
  * @etr_buf:	details of buffer used in TMC-ETR
  * @len:	size of the available trace for ETF/ETB.
@@ -238,6 +240,8 @@ struct tmc_drvdata {
 	spinlock_t		spinlock;
 	pid_t			pid;
 	bool			reading;
+	bool			stop_on_flush;
+	bool			stop_on_flush_en;
 	union {
 		char		*buf;		/* TMC ETB */
 		struct etr_buf	*etr_buf;	/* TMC ETR */
-- 
2.34.1


