Return-Path: <linux-kernel+bounces-77037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F8086004E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2F9289C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3416159575;
	Thu, 22 Feb 2024 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NRaWZI8I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A415958B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624895; cv=none; b=Oxnvmq8ouDrOQBw9+SV/Q1NOCfZ5Tmng5cT5/bMCW6jyjWqv+x9/JJ5rE7Ylpryu28Tyw8hKsT/TuclcZ2M6OtuLzggq3Jew9Nz4jOyybnXF7ZJ9TfFXt5ukSLcswNWUSkJUHp2p2LYStDuqmM4h3uqLgnvxIypd7SMHJrZRwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624895; c=relaxed/simple;
	bh=Hf2vdIK5wvMBM9HYCFSZ0pmzvQMdYEUhBS/WYoYYuCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sc73alTuH6eQcfwXa4nwd9KQa7iKtkcjpu9Yf/unDxPrDwDkxXCGdIfqLAB+F9rQz9fbGyx1UlbVbLNYE/WauAgq+co1yUNzVBaZ9naKbOdCFFRPrgnhqoZVeQoG2lRjIPZC93MMf2OfpZdaUsi7veXCfdGA8vi1yKk/D6cUzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NRaWZI8I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MHXbYI011313;
	Thu, 22 Feb 2024 18:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=WWWmcwY3ouhT7+iupdFQYEQWZmvj5RtlPOV01FUCTXg=; b=NR
	aWZI8ICRBjNsixcpcOAp9jVnrNq4b0M/KE+9TVCvECCy1L8sN7s7sY0JgZLJvTFn
	QJ2UKh4S1mKcCgAdZCXLB2a0EIXeX2Y5lP9KiKyVC1W2uFUzmw94hEiurauLqm+9
	2BaQAzKl5jn3vJK/p7XiZYKYtm0hePfchx8iw2IrLXYfsskB6Cue7IliJxWJ7o84
	3I9L1jlBl1Hk8wc2wwBTZAOX4CCtT3qkoSj0syc+Bu3fehAr5M79J+XfA5MIEeDm
	afHrrBTRnWs34y3cRqLj9pg6geSFkbv8YAXELP+l2r/yfn1UHqdgLQVzYRc0RJt+
	JAAi7vNlzQsNBz1ZXNBg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weasbr40n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:14 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MI1DtV028732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:13 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 10:01:11 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH vRFC 7/8] firmware: remove prototype of fw_cache_piggyback_on_request()
Date: Thu, 22 Feb 2024 23:30:32 +0530
Message-ID: <20240222180033.23775-8-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240222180033.23775-1-quic_mojha@quicinc.com>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EvuIi56fq_i4yrGRxryZPC4ZPXQalN8N
X-Proofpoint-GUID: EvuIi56fq_i4yrGRxryZPC4ZPXQalN8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220140

We should always try to avoid using prototype of a static
function like fw_cache_piggyback_on_request() firmware
main file. Move the relevant code in such a way that avoid
the prototype usage.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/base/firmware_loader/main.c | 109 ++++++++++++++--------------
 1 file changed, 54 insertions(+), 55 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 1d752965d311..91a45767a3a7 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -100,8 +100,6 @@ static inline int fw_state_wait(struct fw_priv *fw_priv)
 	return __fw_state_wait_common(fw_priv, MAX_SCHEDULE_TIMEOUT);
 }
 
-static void fw_cache_piggyback_on_request(struct fw_priv *fw_priv);
-
 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 					  struct firmware_cache *fwc,
 					  void *dbuf,
@@ -672,7 +670,61 @@ static int fw_add_devm_name(struct device *dev, const char *name)
 
 	return 0;
 }
+
+static struct fw_cache_entry *alloc_fw_cache_entry(const char *name)
+{
+	struct fw_cache_entry *fce;
+
+	fce = kzalloc(sizeof(*fce), GFP_ATOMIC);
+	if (!fce)
+		goto exit;
+
+	fce->name = kstrdup_const(name, GFP_ATOMIC);
+	if (!fce->name) {
+		kfree(fce);
+		fce = NULL;
+		goto exit;
+	}
+exit:
+	return fce;
+}
+
+static int __fw_entry_found(const char *name)
+{
+	struct firmware_cache *fwc = &fw_cache;
+	struct fw_cache_entry *fce;
+
+	list_for_each_entry(fce, &fwc->fw_names, list) {
+		if (!strcmp(fce->name, name))
+			return 1;
+	}
+	return 0;
+}
+
+static void fw_cache_piggyback_on_request(struct fw_priv *fw_priv)
+{
+	const char *name = fw_priv->fw_name;
+	struct firmware_cache *fwc = fw_priv->fwc;
+	struct fw_cache_entry *fce;
+
+	spin_lock(&fwc->name_lock);
+	if (__fw_entry_found(name))
+		goto found;
+
+	fce = alloc_fw_cache_entry(name);
+	if (fce) {
+		list_add(&fce->list, &fwc->fw_names);
+		kref_get(&fw_priv->ref);
+		pr_debug("%s: fw: %s\n", __func__, name);
+	}
+found:
+	spin_unlock(&fwc->name_lock);
+}
+
 #else
+static void fw_cache_piggyback_on_request(struct fw_priv *fw_priv)
+{
+}
 static bool fw_cache_is_setup(struct device *dev, const char *name)
 {
 	return false;
@@ -1285,56 +1337,6 @@ static int uncache_firmware(const char *fw_name)
 	return -EINVAL;
 }
 
-static struct fw_cache_entry *alloc_fw_cache_entry(const char *name)
-{
-	struct fw_cache_entry *fce;
-
-	fce = kzalloc(sizeof(*fce), GFP_ATOMIC);
-	if (!fce)
-		goto exit;
-
-	fce->name = kstrdup_const(name, GFP_ATOMIC);
-	if (!fce->name) {
-		kfree(fce);
-		fce = NULL;
-		goto exit;
-	}
-exit:
-	return fce;
-}
-
-static int __fw_entry_found(const char *name)
-{
-	struct firmware_cache *fwc = &fw_cache;
-	struct fw_cache_entry *fce;
-
-	list_for_each_entry(fce, &fwc->fw_names, list) {
-		if (!strcmp(fce->name, name))
-			return 1;
-	}
-	return 0;
-}
-
-static void fw_cache_piggyback_on_request(struct fw_priv *fw_priv)
-{
-	const char *name = fw_priv->fw_name;
-	struct firmware_cache *fwc = fw_priv->fwc;
-	struct fw_cache_entry *fce;
-
-	spin_lock(&fwc->name_lock);
-	if (__fw_entry_found(name))
-		goto found;
-
-	fce = alloc_fw_cache_entry(name);
-	if (fce) {
-		list_add(&fce->list, &fwc->fw_names);
-		kref_get(&fw_priv->ref);
-		pr_debug("%s: fw: %s\n", __func__, name);
-	}
-found:
-	spin_unlock(&fwc->name_lock);
-}
-
 static void free_fw_cache_entry(struct fw_cache_entry *fce)
 {
 	kfree_const(fce->name);
@@ -1563,9 +1565,6 @@ static inline void unregister_fw_pm_ops(void)
 	unregister_pm_notifier(&fw_cache.pm_notify);
 }
 #else
-static void fw_cache_piggyback_on_request(struct fw_priv *fw_priv)
-{
-}
 static inline int register_fw_pm_ops(void)
 {
 	return 0;
-- 
2.43.0.254.ga26002b62827


