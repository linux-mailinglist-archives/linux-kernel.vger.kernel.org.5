Return-Path: <linux-kernel+bounces-61559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C78B8513A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A87AB253D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269039FE8;
	Mon, 12 Feb 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WhcNn8x7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792983D0A1;
	Mon, 12 Feb 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741238; cv=none; b=s/9XWN8MiUj6e/lQ/djvN2uOkADx/4b9YTRVlwTvKoWy4BjpYSJ44h1cSJnDdpmXTdLODwq8Trh9TYrGk5n+S1eCgHDjpumUvBqdDjNRUt4S3jJbjBW82ztLr5lZ8TmeahT9IZQkk+Feg2TW5THqCyiWWP7/SP70tPIFi/9eHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741238; c=relaxed/simple;
	bh=e+5d3r+72OzUrBV15pT8dyFu9f82Q577QS6w+GDobOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mRdo1+DhhznjT+tNIKh5xiJ7iVChfx7pRatYcCGMXMYFQie4NzSqiO5SQcU/FHCEQ//FILApoc/M73+Zi03Gm90adYHV3jd2vNc5PXirKu9+jGVVV6llFolaOt8H89HdF0C6RRggzuGC6yb+VOiBjkwt1AaK1twB9f/skM7WPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WhcNn8x7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C9eLW0011091;
	Mon, 12 Feb 2024 12:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=iqXI0pDDefgL55gPNiogNqi9XFBWNuwrsoOnFvG5Q3w=; b=Wh
	cNn8x7s3wqwRXUA81Wa7y0f//cHx2eZWuokfgnA6U9EpnEXMp/+XNL7dHZQVbhIB
	jA6iIMKCNLpUK3fvLNfxMCRglw+La4Z2IQm4Jn1HhqipU+aOfoJ3wj1v5l9+RJpe
	kZ3w/N1fNUDwNpbnwmk/lpRl73Y2g7drTBHqbyU0khXfus+ukWlU/fUDAQKZE3c5
	tKNor3G6hjS54G5K+QOWaf0Gc5Z9GYzBhKpisVLBlllQ9ujLANPQAvpEvI1TpqSx
	HBFb/MpCsyqmc8CuGcI79w8k/3JFcVTzjFL9DSWK08z8Dq9L/NatmQ492ystqufa
	IFMv7LzBJCXPas/zsTZA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gvjgaxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:33:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CCXNdG030060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:33:23 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 04:33:17 -0800
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
Subject: [PATCH] PM: hibernate: Support to select compression algorithm
Date: Mon, 12 Feb 2024 18:02:51 +0530
Message-ID: <3776355f920c1af44490e076072f93bafdf128cc.1707740870.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UNVmhcoZ85xvqJ-Q_fJq7bWC3qana92K
X-Proofpoint-ORIG-GUID: UNVmhcoZ85xvqJ-Q_fJq7bWC3qana92K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120094

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

 .../admin-guide/kernel-parameters.txt         | 10 ++++
 kernel/power/hibernate.c                      | 57 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..522155056645 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1748,6 +1748,16 @@
 				(that will set all pages holding image data
 				during restoration read-only).
 
+	hibernate.compressor= 	[HIBERNATION] Compression algorithm to be
+				used with hibernation.
+				Format: { lzo | lz4 }
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


