Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC97F4194
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjKVJ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjKVJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:27:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD72DD;
        Wed, 22 Nov 2023 01:27:17 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM9FY0S012287;
        Wed, 22 Nov 2023 09:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=H6LLZviQ9lPZw2kIi5P1Ao+W/EERLpQEZlWwK1Bc2n4=;
 b=T9XW4ctjya4bqAPU3c2xVl2W+z/XoieFFgihQ4mV2UE1qRhdFQ+/4kbLD+NqVc/7TFnd
 ukz33mT6ltHOUIFOrFLesYgybjNrOVHwbcW9C4+E9fVLqjHTUTa03Z0g/KvDbKLiFIlE
 VcyUZi7HBzNDoZSAklxriVkJ9/toi9LjvltvEGQGhGpfrIZDHe/78u8BNStB0qMWiFSV
 Qu6H1J6AT0Md1pHlyF8/mv33IUgrNVzLpxPpXcTttxB9aPI10vMxj+RnHuFQQqPkfc7F
 RIB+QTz9ZHwcx6LETSS5zebTJqm2GB+X/Eq9VRj2zb5O54p2WmaH7BL01tfq3BHTnTQw Rg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uheqxga9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:27:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM7IQDF002623;
        Wed, 22 Nov 2023 09:27:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kxrby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:27:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AM9RAHF43254142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Nov 2023 09:27:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5CFD20043;
        Wed, 22 Nov 2023 09:27:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D18520040;
        Wed, 22 Nov 2023 09:27:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Nov 2023 09:27:10 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH linux-next] perf report: remove warning on missing raw data for s390
Date:   Wed, 22 Nov 2023 10:27:03 +0100
Message-Id: <20231122092703.3163191-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: coljJEbv67BzOlUm18XeAk2gGN680Z1W
X-Proofpoint-GUID: coljJEbv67BzOlUm18XeAk2gGN680Z1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Command
 # ./perf report -i /tmp/111 -D > /dev/null
emits an error message when a sample for event CRYPTO_ALL in the
perf.data file does not contain any raw data. This is ok.
Do not trigger this warning when the sample in the perf.data files
does not contain any raw data at all.
Check for availability of raw data for all events and return if
none is available.

Output before:
 # ./perf report -i /tmp/111 -D > /dev/null
 Invalid CRYPTO_ALL raw data encountered
 Invalid CRYPTO_ALL raw data encountered
 Invalid CRYPTO_ALL raw data encountered
 #

Output after:
 # ./perf report -i /tmp/111 -D > /dev/null
 #

Fixes: b539deafbadb ("perf report: Add s390 raw data interpretation for PAI counters")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/util/s390-sample-raw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 29a744eeb71e..53383e97ec9d 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -51,8 +51,6 @@ static bool s390_cpumcfdg_testctr(struct perf_sample *sample)
 	struct cf_trailer_entry *te;
 	struct cf_ctrset_entry *cep, ce;
 
-	if (!len)
-		return false;
 	while (offset < len) {
 		cep = (struct cf_ctrset_entry *)(buf + offset);
 		ce.def = be16_to_cpu(cep->def);
@@ -234,10 +232,9 @@ struct pai_data {		/* Event number and value */
  */
 static bool s390_pai_all_test(struct perf_sample *sample)
 {
-	unsigned char *buf = sample->raw_data;
 	size_t len = sample->raw_size;
 
-	if (len < 0xa || !buf)
+	if (len < 0xa)
 		return false;
 	return true;
 }
@@ -299,6 +296,10 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 	if (!evsel)
 		return;
 
+	/* Check for raw data in sample */
+	if (!sample->raw_size || !sample->raw_data)
+		return;
+
 	/* Display raw data on screen */
 	if (evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
 		if (!evsel->pmu)
-- 
2.41.0

