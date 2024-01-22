Return-Path: <linux-kernel+bounces-33084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A8C836441
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A391F21FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7CF3D3A8;
	Mon, 22 Jan 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UjbenRto"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5993D39F;
	Mon, 22 Jan 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929409; cv=none; b=S/PszfXZlH0US9FOnHEK8I97WvtHRuUzOjq+H8FnQnIZyNmMkHvhjEXLfBHj4jvUAsVVGgGtLxIVrwMkrf5bwDaBNRRrgustBqrphLHV7FPgnsfkE44cp15vFRtkihTLjxj/fz93nOJo1HqVUf42qe4puXxbbOA/0NmcDr7ub5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929409; c=relaxed/simple;
	bh=5OTzxWy2mxSiFp491HKJnNIOqCN0rnoUjUd846/28K8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUjljAH6srQBCwG7HDjy2pi0/Gnl+m/t2CsMVL9dlIHavwzr7WHpgqVR8rzM1lQho2DjMgMUn4b+42yAiiBLZQzbjSsZnwNEJeRrmhYT9wYA7Qo2PyAWc3GqO7lwyhOehQJG6qFjUO0o2Ulf0wY6EHQbWmfaMahSDU3OhtVDKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UjbenRto; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M6O1Ze019496;
	Mon, 22 Jan 2024 13:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=SBNHE9DQls9DIJECVazn
	vGTPkMtVxoey0reuqcrLIi0=; b=UjbenRtom7xVVc2rhK14NBVq6aystPUoeuLl
	odSPRsvdqzm0Er2SHGkshUd7JpP7RSg+I77/7NQotYrd25qnJ7jofFqkxMlzqH/N
	SdeWKRspoTaQbCVxs/gPSEqd0dHZDYRyei7cdP01YUQQiKpi+14vcNFoSc2fTumt
	fPLOR+zb+BvCk957GwxHbICq7DNKt9nOJrWL64uh9SWzG9C5DfAPq5MGXa93bg0F
	b0Mwy8S25ucXnmGKh/WwcEXoBMMbuo2/dFek6qCO3yOiOhwIXwJWEEnyzRrkN39O
	6ET6CcQLZuz8T660eiTGToS+Q1B/fqtgGDXXE/pQ2wFdswbKQw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr6jbv384-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 13:16:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MDGXXS003485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 13:16:33 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 05:16:27 -0800
From: Nikhil V <quic_nprakash@quicinc.com>
To: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J.
 Wysocki" <rafael@kernel.org>
CC: Nikhil V <quic_nprakash@quicinc.com>, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Yan-Jie
 Wang" <yanjiewtw@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Peter
 Zijlstra" <peterz@infradead.org>,
        "Steven Rostedt (Google)"
	<rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kprasan@quicinc.com>,
        <quic_mpilaniy@quicinc.com>, <quic_shrekk@quicinc.com>,
        <mpleshivenkov@google.com>, <ericyin@google.com>
Subject: [PATCH v3 3/4] PM: hibernate: Add support for LZ4 compression for hibernation
Date: Mon, 22 Jan 2024 18:45:27 +0530
Message-ID: <740b533280791236b985c1310b5a79502b95fb36.1705927916.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1705927916.git.quic_nprakash@quicinc.com>
References: <cover.1705927916.git.quic_nprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EuAfe-kyXqI3zAotwpmz1Hins9y99-Tv
X-Proofpoint-ORIG-GUID: EuAfe-kyXqI3zAotwpmz1Hins9y99-Tv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220093

Extend the support for LZ4 compression to be used with hibernation.
The main idea is that different compression algorithms
have different characteristics and hibernation may benefit when it uses
any of these algorithms: a default algorithm, having higher
compression rate but is slower(compression/decompression) and a
secondary algorithm, that is faster(compression/decompression) but has
lower compression rate.

LZ4 algorithm has better decompression speeds over LZO. This reduces
the hibernation image restore time.
As per test results:
                                    LZO             LZ4
Size before Compression(bytes)   682696704       682393600
Size after Compression(bytes)    146502402       155993547
Decompression Rate               335.02 MB/s     501.05 MB/s
Restore time                       4.4s             3.8s

LZO is the default compression algorithm used for hibernation. Enable
CONFIG_HIBERNATION_COMP_LZ4 to set the default compressor as LZ4.

Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
---
 kernel/power/Kconfig     |  5 +++++
 kernel/power/hibernate.c | 25 ++++++++++++++++++++++---
 kernel/power/power.h     | 14 ++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index d4167159bae8..afce8130d8b9 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -101,11 +101,16 @@ config HIBERNATION_COMP_LZO
 	bool "lzo"
 	depends on CRYPTO_LZO
 
+config HIBERNATION_COMP_LZ4
+	bool "lz4"
+	depends on CRYPTO_LZ4
+
 endchoice
 
 config HIBERNATION_DEF_COMP
 	string
 	default "lzo" if HIBERNATION_COMP_LZO
+	default "lz4" if HIBERNATION_COMP_LZ4
 	help
 	  Default compressor to be used for hibernation.
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 76b7ff619c90..219191d6d0e8 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -727,6 +727,9 @@ static int load_image_and_restore(void)
 	return error;
 }
 
+#define COMPRESSION_ALGO_LZO "lzo"
+#define COMPRESSION_ALGO_LZ4 "lz4"
+
 /**
  * hibernate - Carry out system hibernation, including saving the image.
  */
@@ -786,11 +789,24 @@ int hibernate(void)
 
 		if (hibernation_mode == HIBERNATION_PLATFORM)
 			flags |= SF_PLATFORM_MODE;
-		if (nocompress)
+		if (nocompress) {
 			flags |= SF_NOCOMPRESS_MODE;
-		else
+		} else {
 		        flags |= SF_CRC32_MODE;
 
+			/*
+			 * By default, LZO compression is enabled. Use SF_COMPRESSION_ALG_LZ4
+			 * to override this behaviour and use LZ4.
+			 *
+			 * Refer kernel/power/power.h for more details
+			 */
+
+			if (!strcmp(hib_comp_algo, COMPRESSION_ALGO_LZ4))
+				flags |= SF_COMPRESSION_ALG_LZ4;
+			else
+				flags |= SF_COMPRESSION_ALG_LZO;
+		}
+
 		pm_pr_dbg("Writing hibernation image.\n");
 		error = swsusp_write(flags);
 		swsusp_free();
@@ -980,7 +996,10 @@ static int software_resume(void)
 	 * the algorithm support.
 	 */
 	if (!(swsusp_header_flags & SF_NOCOMPRESS_MODE)) {
-		strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
+		if (swsusp_header_flags & SF_COMPRESSION_ALG_LZ4)
+			strscpy(hib_comp_algo, COMPRESSION_ALGO_LZ4, sizeof(hib_comp_algo));
+		else
+			strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
 		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
 			pr_err("%s compression is not available\n", hib_comp_algo);
 			error = -EOPNOTSUPP;
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b1befc65e6ee..63ede40ce12d 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -167,11 +167,25 @@ extern int swsusp_swap_in_use(void);
  * Flags that can be passed from the hibernatig hernel to the "boot" kernel in
  * the image header.
  */
+#define SF_COMPRESSION_ALG_LZO	0 /* dummy, details given  below */
 #define SF_PLATFORM_MODE	1
 #define SF_NOCOMPRESS_MODE	2
 #define SF_CRC32_MODE	        4
 #define SF_HW_SIG		8
 
+/*
+ * Bit to indicate the compression algorithm to be used(for LZ4). The same
+ * could be checked while saving/loading image to/from disk to use the
+ * corresponding algorithms.
+ *
+ * By default, LZO compression is enabled if SF_CRC32_MODE is set. Use
+ * SF_COMPRESSION_ALG_LZ4 to override this behaviour and use LZ4.
+ *
+ * SF_CRC32_MODE, SF_COMPRESSION_ALG_LZO(dummy) -> Compression, LZO
+ * SF_CRC32_MODE, SF_COMPRESSION_ALG_LZ4 -> Compression, LZ4
+ */
+#define SF_COMPRESSION_ALG_LZ4	16
+
 /* kernel/power/hibernate.c */
 int swsusp_check(bool exclusive);
 extern void swsusp_free(void);
-- 
2.17.1


