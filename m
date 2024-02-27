Return-Path: <linux-kernel+bounces-83548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F55869B84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE54B2E9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839191487D3;
	Tue, 27 Feb 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m8OqEVLJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32582146012;
	Tue, 27 Feb 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049220; cv=none; b=aIXSjkCslx14CfMSDeS0D0mPeqK971+ItaVmjPjvb0cTQyS8Y2Nwhb+1avyGcZV79NbAmrnNzhnwFMpYsCaQ4avf5CBHBgL3qm4H9IQTpYKT+7+Ysg6rhE+Wr1JsEl6/Hala7yijBBEJKPFIUs9QsrhqwK20RbA1nPoTlYgjiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049220; c=relaxed/simple;
	bh=wNqr7/bTktWDZ9rqRhsDSN0LgRZjviGp6/h+Aufs2WE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPvTIRoXQQkbSQEHcKrm00RKNum5RdWm67Dm8Zk8MxNE3xabOpfYf15o9lTvGqoijpEsW8IpTjSNEUE0Giq/0/cywLum6PEStaTG5XwL1JkdJUxoiR8VnXFcqiC2/jXq73ybe+Pps628DrsstVwqbQXkKyBzPqL5RdJkha5PrSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m8OqEVLJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9Y8Dn014703;
	Tue, 27 Feb 2024 15:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=q0+hUnOoICebzhHPGRPxXfQBp7yrZlY1ry35Sv9WcxE=; b=m8
	OqEVLJ/W/O5pQC5XrB7QZNutY5MYCh2ADqBo3IvzmUj55uHkPttliiYqr7lLuUFK
	N4nqLmjjLZZsACQErMPzpkz7AfcemGCQzI1VElpXvBGQ3FSWNRcjr7AAKEBc0GGk
	lFGmtS4M7tybsJzVEwu/3yLnFHc8ZDmPg7W56VSddDoyWwKCZHdXClxOYOSAazll
	LtINOY7NUsMRrKrjXyTw/r1JMUXERfWTUWXYzkyS0fNJEh3C0BS1mYvqzaR8L1Fg
	c26i0Fkoz4PNlFy27VUAJrck6mThP9M+kHzaD+CZynWSSt5t+Byq3gdNWtPy1ppa
	0BN7WDXetcvdAx3d6tSw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh64h1u0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:35 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RFrYCY016565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:34 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 07:53:31 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Kathiravan Thirumoorthy
	<quic_kathirav@quicinc.com>
Subject: [PATCH v12 2/9] firmware: qcom: scm: provide a read-modify-write function
Date: Tue, 27 Feb 2024 21:23:01 +0530
Message-ID: <20240227155308.18395-3-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240227155308.18395-1-quic_mojha@quicinc.com>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aSHyXBmahNJyxya09-AOGp953LnYpJp1
X-Proofpoint-GUID: aSHyXBmahNJyxya09-AOGp953LnYpJp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=910 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270123

It is possible that different bits of a secure register is used
for different purpose and currently, there is no such available
function from SCM driver to do that; one similar usage was pointed
by Srinivas K. inside pinctrl-msm where interrupt configuration
register lying in secure region and written via read-modify-write
operation.

Export qcom_scm_io_rmw() to do read-modify-write operation on secure
register and reuse it wherever applicable, also document scm_lock
to convey its usage.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
---
 drivers/firmware/qcom/qcom_scm.c       | 33 ++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 2d0ba529cf56..8f766fce5f7c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -193,6 +193,11 @@ static void qcom_scm_bw_disable(void)
 }
 
 enum qcom_scm_convention qcom_scm_convention = SMC_CONVENTION_UNKNOWN;
+/*
+ * scm_lock to serialize call to query SMC convention and
+ * to atomically operate(read-modify-write) on different
+ * bits of secure register.
+ */
 static DEFINE_SPINLOCK(scm_lock);
 
 static enum qcom_scm_convention __get_convention(void)
@@ -481,6 +486,34 @@ static int qcom_scm_disable_sdi(void)
 	return ret ? : res.result[0];
 }
 
+int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
+{
+	unsigned long flags;
+	unsigned int old;
+	unsigned int new;
+	int ret;
+
+	if (!__scm)
+		return -EPROBE_DEFER;
+
+	/*
+	 * Lock to atomically do rmw operation on different bits
+	 * of secure register
+	 */
+	spin_lock_irqsave(&scm_lock, flags);
+	ret = qcom_scm_io_readl(addr, &old);
+	if (ret)
+		goto unlock;
+
+	new = (old & ~mask) | (val & mask);
+
+	ret = qcom_scm_io_writel(addr, new);
+unlock:
+	spin_unlock_irqrestore(&scm_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);
+
 static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 {
 	struct qcom_scm_desc desc = {
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index ccaf28846054..3a8bb2e603b3 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -82,6 +82,7 @@ bool qcom_scm_pas_supported(u32 peripheral);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
+int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val);
 
 bool qcom_scm_restore_sec_cfg_available(void);
 int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
-- 
2.43.0.254.ga26002b62827


