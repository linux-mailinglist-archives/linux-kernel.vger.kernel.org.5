Return-Path: <linux-kernel+bounces-107353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF587FB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DD81C21C78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F607F46B;
	Tue, 19 Mar 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JUYBjJRF"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700747D3FB;
	Tue, 19 Mar 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842169; cv=none; b=RQrI5vX6oCDPLx+q4zs2neD8DDhScOf7TZ7IjRhWvJeK0vw48kUWYiO1qjrSZWP37jTTq/UdxrYEY9aITAo3UAo+LilyqyzH0GRP6m9RhLv9+XXqsI8lTUFSmk11+M9F+UCF0QoFH9Dx+++EKSTz5Fuf/PR9ah2hAEB/RdUitbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842169; c=relaxed/simple;
	bh=6Q1YQ9YaWQnSUaD6gx/UktQdUNdjrS2tZjoZqNG5yTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6Gg/VLxguN48rf/dHJsWwRCqGrSgOptcFYFjNFv/il2jaHVxhL6ddNPdFQ9BWZKFp/sUSb8K9Jr46KuvCsChQM6UkEuE0Vl1c8ifOFpYsuGmD34+05KaJFhZGhFW46JKQI2CWzzbSO6jYGAdQnhrofyiwRrho9IfGgFnZcJwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JUYBjJRF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42J9WUW7021788;
	Tue, 19 Mar 2024 09:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QpOwfZ/YlyW8DcF4PsTBwqDZqHcO+DL5JJeLS2rz8Qs=;
 b=JUYBjJRFTJR2vEHdQ6gUNfiUqzapIMrWfqKSaH7WlJknGSCD/VjXI/lWNlgTK0ExMvb1
 LO6y9K2aePFNK9tkX5RR0FU/Z1uJnHttTgKwJwqfPNeiGsDMhANcQBhplTuqERGnYKnj
 8xgPA7RzXrXKzHM7CHFdk1wQ7fpjqfkI/ULNL+EauU4nVfzq4CeGS4m8BS1X4JDzjfMu
 cUor2NgIzTwdmtv6TNsA8WZvkZt2chj8HDmhOS/ocJEqn0AhEU4OnCin8ZGQY3mZJpjV
 eX2U6vI9GlVFRCOZK68RaMbe4eybdO0McUism3fgJ7Ztr+8ccHOip61P6bD0p0NDcFyB jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy85n83ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:56:03 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42J9u2k8005123;
	Tue, 19 Mar 2024 09:56:02 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy85n83y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:56:02 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42J7Jvla017231;
	Tue, 19 Mar 2024 09:51:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrt6u1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:51:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42J9ouJp25297416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 09:50:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 958AB2005A;
	Tue, 19 Mar 2024 09:50:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E38020043;
	Tue, 19 Mar 2024 09:50:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 09:50:56 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2] perf list: do not print metrics on s390 zvm systems
Date: Tue, 19 Mar 2024 10:50:43 +0100
Message-Id: <20240319095043.857594-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240319095043.857594-1-tmricht@linux.ibm.com>
References: <20240319095043.857594-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UcUxdN1hkDnoEjw-dYDpE_aJfsQIKbNq
X-Proofpoint-GUID: 2jVV7YqfoNoE154-d1m7KTWv6n0pjF5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190076

On s390 z/VM virtual machines command perf list also displays metrics:

 # ./perf list | grep -A 20 'Metric Groups:'
 Metric Groups:

 No_group:
  cpi
       [Cycles per Instruction]
  est_cpi
       [Estimated Instruction Complexity CPI infinite Level 1]
  finite_cpi
       [Cycles per Instructions from Finite cache/memory]
  l1mp
       [Level One Miss per 100 Instructions]
  l2p
       [Percentage sourced from Level 2 cache]
  l3p
       [Percentage sourced from Level 3 on same chip cache]
  l4lp
       [Percentage sourced from Level 4 Local cache on same book]
  l4rp
       [Percentage sourced from Level 4 Remote cache on different book]
  memp
       [Percentage sourced from memory]
  ....
 #

This is not correct, on s390 z/VM virtual machines the referenced
CPU Counter Measurement facility does not exist. The command

 # ./perf stat -M cpi -- true
 event syntax error: '{CPU_CYCLES/metric-id=CPU_CYCLES/.....'
                       \___ Bad event or PMU

 Unable to find PMU or event on a PMU of 'CPU_CYCLES'

 event syntax error: '{CPU_CYCLES/metric-id=CPU_CYCLES/...'
                       \___ Cannot find PMU `CPU_CYCLES'.
			    Missing kernel support?
 #

fails.

Perf list should not display the metrics when the referenced
CPU Counter Measurement PMU is not available.

Output after:
 # ./perf list | grep -A 20 'Metric Groups:'
 #

Fixes: 7f76b3113068 ("perf list: Add IBM z16 event description for s390")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/arch/s390/util/pmu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/util/pmu.c
index 886c30e001fa..2dc27acc860c 100644
--- a/tools/perf/arch/s390/util/pmu.c
+++ b/tools/perf/arch/s390/util/pmu.c
@@ -8,6 +8,7 @@
 #include <string.h>
 
 #include "../../../util/pmu.h"
+#include "../../../util/pmus.h"
 
 #define	S390_PMUPAI_CRYPTO	"pai_crypto"
 #define	S390_PMUPAI_EXT		"pai_ext"
@@ -20,3 +21,19 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 	    !strcmp(pmu->name, S390_PMUCPUM_CF))
 		pmu->selectable = true;
 }
+
+const struct pmu_metrics_table *pmu_metrics_table__find(void)
+{
+	struct perf_pmu *pmu;
+
+	/*
+	 * Metrics defined on events from PMU cpum_cf aren't supported
+	 * on z/VM. Make sure the PMU exists and return NULL if that
+	 * PMU cannot be found.
+	 */
+	pmu = perf_pmus__find("cpum_cf");
+	if (pmu)
+		return perf_pmu__find_metrics_table(pmu);
+
+	return NULL;
+}
-- 
2.44.0


