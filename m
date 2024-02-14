Return-Path: <linux-kernel+bounces-64839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63185438C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C2F1C224A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41911738;
	Wed, 14 Feb 2024 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dcYux+04"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD161097D;
	Wed, 14 Feb 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896426; cv=none; b=EL2F0aWGebCdl0QkJEZQyrL1HmfFdtzQnjJZqAZq3+uV8dYbDppRJPu0HwfFW2+QpF8xyXwxzS0wA0WsweMm0ik2pKmGvC61ZP+gJS40grjZ8EWHD1gzfPfE7G1XKg5v0Yf+tcTkTzFso7+ai3QvLW70HXv+VjQIybSDM6/e2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896426; c=relaxed/simple;
	bh=KzHiASEVyPnG6jzWZ/r28DGP8rBbllHelFjSvDOXyoo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PgmZcyfjR65OSOw9gMd1CFqpiKswlWL6sLzL42v7siD4+6w6S5GYvp07XF/4CY/nhm/kukKFrHnrFjhAyFG5tHr0fVqekMMfPlL9vo+LK7IvVNk2CI0QdPH+Tcca0BvFbzbenoO9ISDACVBzUbXGOoXuBsTwn+RE7bxJGnepAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dcYux+04; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E6skOd019513;
	Wed, 14 Feb 2024 07:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=aY7yYKqx+GMyo+VIjJd5KjU/z5idd8ln+YeLlsF79QA=; b=dc
	Yux+04LlE1GydeENNZ4WFes1s/m/Zcs8ZCbracxjs3PA8XA2pZPUs4f6ukUJHbZq
	VrSiwI6zdf46KjW13aKocSjCQSCc5txqf9iuPzokSomCmZ1R+A7aw7Pt7WqDdOFP
	IMC4bkUZ7G3kFRmLdLegeK5RZEXGUs9NoNFibNZPMpkJKEhGjomK+gONbWIqm+SW
	PuzNo+qTwmBJHObYZYkvBxPYazLnCoxaXbvKq5u26AfYA/s5pu6R2EIP5rQzgZR0
	15lyiyxaQaGxAIUVw60tjj7sdD52aoDZId61gJ10GqeyR9OnQfJgIC4BDfGrwAB1
	fiUFc88trz+9SWU7edjQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8j65rmr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 07:40:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E7e3lJ031438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 07:40:03 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 23:39:57 -0800
From: Nikhil V <quic_nprakash@quicinc.com>
To: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC: Nikhil V <quic_nprakash@quicinc.com>,
        "Paul E. McKenney"
	<paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Yan-Jie Wang
	<yanjiewtw@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kprasan@quicinc.com>,
        <quic_mpilaniy@quicinc.com>, <quic_shrekk@quicinc.com>,
        <mpleshivenkov@google.com>, <ericyin@google.com>
Subject: [PATCH v2] PM: hibernate: Support to select compression algorithm
Date: Wed, 14 Feb 2024 13:09:32 +0530
Message-ID: <db6616c90d0e7de7658708b52ddca729679573bf.1707895925.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-GUID: V6pO_5SNNUqTnG7XYwyU3jmtg_7VRJYd
X-Proofpoint-ORIG-GUID: V6pO_5SNNUqTnG7XYwyU3jmtg_7VRJYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_01,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140058

Currently the default compression algorithm is selected based on
compile time options. Introduce a module parameter "hibernate.compressor"
to override this behaviour.

Different compression algorithms have different characteristics and
hibernation may benefit when it uses any of these algorithms, especially
when a secondary algorithm(LZ4) offers better decompression speeds over a
default algorithm(LZO), which in turn reduces hibernation image restore
time.

Users can override the default algorithm in two ways:
 1) Passing "hibernate.compressor" as kernel command line parameter.
    Usage:
    	LZO: hibernate.compressor=lzo
    	LZ4: hibernate.compressor=lz4

 2) Specifying the algorithm at runtime.
    Usage:
	LZO: echo lzo > /sys/module/hibernate/parameters/compressor
	LZ4: echo lz4 > /sys/module/hibernate/parameters/compressor

Currently LZO and LZ4 are the supported algorithms. LZO is the default
compression algorithm used with hibernation.

Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
---
This patch is dependent on the patch series, [1] (patches 1/4 to 3/4).
This is picked in linux-next, [2].
 [1] https://lore.kernel.org/all/cover.1705927916.git.quic_nprakash@quicinc.com/
 [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/kernel/power?h=next-20240212

Changes in v2:
 Changes to incorporate suggestions from Randy Dunlap:
  - Update documentation to specify the default compression algorithm.
 Link to v1:
  https://lore.kernel.org/all/3776355f920c1af44490e076072f93bafdf128cc.1707740870.git.quic_nprakash@quicinc.com/

 .../admin-guide/kernel-parameters.txt         | 11 ++++
 kernel/power/hibernate.c                      | 57 ++++++++++++++++++-
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..8f7fb911b2cc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1748,6 +1748,17 @@
 				(that will set all pages holding image data
 				during restoration read-only).
 
+	hibernate.compressor= 	[HIBERNATION] Compression algorithm to be
+				used with hibernation.
+				Format: { lzo | lz4 }
+				Default: lzo
+
+				lzo: Select LZO compression algorithm to
+				compress/decompress hibernation image.
+
+				lz4: Select LZ4 compression algorithm to
+				compress/decompress hibernation image.
+
 	highmem=nn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
 			size of <nn>. This works even on boxes that have no
 			highmem otherwise. This also works to reduce highmem
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 219191d6d0e8..43b1a82e800c 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -47,7 +47,7 @@ dev_t swsusp_resume_device;
 sector_t swsusp_resume_block;
 __visible int in_suspend __nosavedata;
 
-static const char *default_compressor = CONFIG_HIBERNATION_DEF_COMP;
+static char hibernate_compressor[CRYPTO_MAX_ALG_NAME] = CONFIG_HIBERNATION_DEF_COMP;
 
 /*
  * Compression/decompression algorithm to be used while saving/loading
@@ -748,7 +748,7 @@ int hibernate(void)
 	 * Query for the compression algorithm support if compression is enabled.
 	 */
 	if (!nocompress) {
-		strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
+		strscpy(hib_comp_algo, hibernate_compressor, sizeof(hib_comp_algo));
 		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
 			pr_err("%s compression is not available\n", hib_comp_algo);
 			return -EOPNOTSUPP;
@@ -999,7 +999,7 @@ static int software_resume(void)
 		if (swsusp_header_flags & SF_COMPRESSION_ALG_LZ4)
 			strscpy(hib_comp_algo, COMPRESSION_ALGO_LZ4, sizeof(hib_comp_algo));
 		else
-			strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
+			strscpy(hib_comp_algo, COMPRESSION_ALGO_LZO, sizeof(hib_comp_algo));
 		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
 			pr_err("%s compression is not available\n", hib_comp_algo);
 			error = -EOPNOTSUPP;
@@ -1422,6 +1422,57 @@ static int __init nohibernate_setup(char *str)
 	return 1;
 }
 
+static const char * const comp_alg_enabled[] = {
+#if IS_ENABLED(CONFIG_CRYPTO_LZO)
+	COMPRESSION_ALGO_LZO,
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_LZ4)
+	COMPRESSION_ALGO_LZ4,
+#endif
+};
+
+static int hibernate_compressor_param_set(const char *compressor,
+		const struct kernel_param *kp)
+{
+	unsigned int sleep_flags;
+	int index, ret;
+
+	sleep_flags = lock_system_sleep();
+
+	index = sysfs_match_string(comp_alg_enabled, compressor);
+	if (index >= 0) {
+		ret = param_set_copystring(comp_alg_enabled[index], kp);
+		if (!ret)
+			strscpy(hib_comp_algo, comp_alg_enabled[index],
+				sizeof(hib_comp_algo));
+	} else {
+		ret = index;
+	}
+
+	unlock_system_sleep(sleep_flags);
+
+	if (ret)
+		pr_debug("Cannot set specified compressor %s\n",
+			 compressor);
+
+	return ret;
+}
+
+static const struct kernel_param_ops hibernate_compressor_param_ops = {
+	.set    = hibernate_compressor_param_set,
+	.get    = param_get_string,
+};
+
+static struct kparam_string hibernate_compressor_param_string = {
+	.maxlen = sizeof(hibernate_compressor),
+	.string = hibernate_compressor,
+};
+
+module_param_cb(compressor, &hibernate_compressor_param_ops,
+		&hibernate_compressor_param_string, 0644);
+MODULE_PARM_DESC(compressor,
+		 "Compression algorithm to be used with hibernation");
+
 __setup("noresume", noresume_setup);
 __setup("resume_offset=", resume_offset_setup);
 __setup("resume=", resume_setup);
-- 
2.17.1


