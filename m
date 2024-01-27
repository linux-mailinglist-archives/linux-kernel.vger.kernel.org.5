Return-Path: <linux-kernel+bounces-41455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFD983F212
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D0E284755
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A60122F17;
	Sat, 27 Jan 2024 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pWg7k66a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCCE605A8;
	Sat, 27 Jan 2024 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398032; cv=none; b=qZFpJC7dDdjOdHB6xMfgU5tj3nnlRXDRMEsI8pJGbl73RAnqmzcJYbFnQ1RXc9YC0Rcd+vav3y3QzCn6tyehaEkDsQdqIIGMFA19qzLmjsN2Q9ibbSrdxxA9k9raKIvaI/E0N7aCRyCzzJkyiLVlwYrieNGszpTsqnREW9o5iD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398032; c=relaxed/simple;
	bh=zfoNCu4IsN3Ufxw3jVFjT/A618uSC+Eubp1ucYYYdaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=md+fLWoZ7HZjuyzoaLWS+lPJPr7EDm+T/8X1R0w6YQLXtizhLhtd2AvE8vxCSHtMdd4LM5vnGVERQC+Ubi6NFUn+LECOzCJR0KJS/HhTjSsrEvrbFatQekne/tkdAg9pDBrH7HD7l+RBVvmchIpSiqgsYI+tRkHzs1/EyWjRC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pWg7k66a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RNQNUM020504;
	Sat, 27 Jan 2024 23:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=E+iwlnmoPXk9gph6SiysUn8uVV+PpxD5+H0Q/j5SfpY=; b=pW
	g7k66aUw7cH/aWWU+x+QyAWY9zmkZPMQWmnOf7JKHrMiarzQ79fUf7hN1lErp7lD
	KWhs41W6CjijwZ49z3uJw42JibJtyAKPiJKuWkD5skue9Nf5MbDkzNebBT1D8ZaV
	OYWyiKKLSmpRBiMppC99Q2K+LO4OeKm+xG4a9mtedD0PoFbdaWaKe7x4X1wriQxE
	FKF1K54YpoWMuDlhaOjNHboPxQ3ca1TQmq6mr0nzXWjnTHZqbjF1aMbftnbkm6n2
	Pr65X3wN3KakKe3zihZjHGo7678Yy+Fc83owzp88aoS7dwXTu3F1N2kvVGIb5Llb
	4BcLN5A+CYZ7Xaa/sqEg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvswy94f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40RNQLwl001449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:21 GMT
Received: from hu-gaurkash-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 27 Jan 2024 15:26:16 -0800
From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
To: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <andersson@kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <kernel@quicinc.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_omprsing@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <konrad.dybcio@linaro.org>, <ulf.hansson@linaro.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <mani@kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>
Subject: [PATCH v4 03/15] qcom_scm: scm call for create, prepare and import keys
Date: Sat, 27 Jan 2024 15:14:01 -0800
Message-ID: <20240127232436.2632187-4-quic_gaurkash@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ItnDuifzuA-KtT1D_L_aTCcJek8We-Ck
X-Proofpoint-GUID: ItnDuifzuA-KtT1D_L_aTCcJek8We-Ck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401270178

Storage encryption has two IOCTLs for creating, importing
and preparing keys for encryption. For wrapped keys, these
IOCTLs need to interface with Qualcomm's Trustzone, which
require these SCM calls.

generate_key: This is used to generate and return a longterm
              wrapped key. Trustzone achieves this by generating
	      a key and then wrapping it using hwkm, returning
	      a wrapped keyblob.
import_key:   The functionality is similar to generate, but here,
              a raw key is imported into hwkm and a longterm wrapped
	      keyblob is returned.
prepare_key:  The longterm wrapped key from import or generate
              is made further secure by rewrapping it with a per-boot
	      ephemeral wrapped key before installing it to the linux
	      kernel for programming to ICE.

Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 182 +++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   3 +
 include/linux/firmware/qcom/qcom_scm.h |   5 +
 3 files changed, 190 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 4882f8a36453..20dbab765c8e 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1285,6 +1285,188 @@ int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_derive_sw_secret);
 
+/**
+ * qcom_scm_generate_ice_key() - Generate a wrapped key for encryption.
+ * @lt_key: the wrapped key returned after key generation
+ * @lt_key_size: size of the wrapped key to be returned.
+ *
+ * Qualcomm wrapped keys need to be generated in a trusted environment.
+ * A generate key IOCTL call is used to achieve this. These are longterm
+ * in nature as they need to be generated and wrapped only once per
+ * requirement.
+ *
+ * Adds support for the create key IOCTL to interface
+ * with the secure environment to generate and return a wrapped key..
+ *
+ * Return: longterm key size on success; -errno on failure.
+ */
+int qcom_scm_generate_ice_key(u8 *lt_key, size_t lt_key_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_GENERATE_ICE_KEY,
+		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
+		.args[1] = lt_key_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	void *lt_key_buf;
+	int ret;
+
+	lt_key_buf = qcom_tzmem_alloc(__scm->mempool, lt_key_size, GFP_KERNEL);
+	if (!lt_key_buf)
+		return -ENOMEM;
+
+	desc.args[0] = qcom_tzmem_to_phys(lt_key_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(lt_key, lt_key_buf, lt_key_size);
+
+	memzero_explicit(lt_key_buf, lt_key_size);
+	qcom_tzmem_free(lt_key_buf);
+
+	if (!ret)
+		return lt_key_size;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_generate_ice_key);
+
+/**
+ * qcom_scm_prepare_ice_key() - Get per boot ephemeral wrapped key
+ * @lt_key: the longterm wrapped key
+ * @lt_key_size: size of the wrapped key
+ * @eph_key: ephemeral wrapped key to be returned
+ * @eph_key_size: size of the ephemeral wrapped key
+ *
+ * Qualcomm wrapped keys (longterm keys) are rewrapped with a per-boot
+ * ephemeral key for added protection. These are ephemeral in nature as
+ * they are valid only for that boot. A create key IOCTL is used to
+ * achieve this. These are the keys that are installed into the kernel
+ * to be then unwrapped and programmed into ICE.
+ *
+ * Adds support for the create key IOCTL to interface
+ * with the secure environment to rewrap the wrapped key with an
+ * ephemeral wrapping key.
+ *
+ * Return: ephemeral key size on success; -errno on failure.
+ */
+int qcom_scm_prepare_ice_key(const u8 *lt_key, size_t lt_key_size,
+			     u8 *eph_key, size_t eph_key_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_PREPARE_ICE_KEY,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RO,
+					 QCOM_SCM_VAL, QCOM_SCM_RW,
+					 QCOM_SCM_VAL),
+		.args[1] = lt_key_size,
+		.args[3] = eph_key_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	void *eph_key_buf;
+	void *lt_key_buf;
+	int ret;
+
+	lt_key_buf = qcom_tzmem_alloc(__scm->mempool, lt_key_size, GFP_KERNEL);
+	if (!lt_key_buf)
+		return -ENOMEM;
+	eph_key_buf = qcom_tzmem_alloc(__scm->mempool, eph_key_size, GFP_KERNEL);
+	if (!eph_key_buf) {
+		ret = -ENOMEM;
+		goto err_free_longterm;
+	}
+
+	memcpy(lt_key_buf, lt_key, lt_key_size);
+	desc.args[0] = qcom_tzmem_to_phys(lt_key_buf);
+	desc.args[2] = qcom_tzmem_to_phys(eph_key_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(eph_key, eph_key_buf, eph_key_size);
+
+	memzero_explicit(eph_key_buf, eph_key_size);
+	qcom_tzmem_free(eph_key_buf);
+
+err_free_longterm:
+	memzero_explicit(lt_key_buf, lt_key_size);
+	qcom_tzmem_free(lt_key_buf);
+
+	if (!ret)
+		return eph_key_size;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_prepare_ice_key);
+
+/**
+ * qcom_scm_import_ice_key() - Import a wrapped key for encryption
+ * @imp_key: the raw key that is imported
+ * @imp_key_size: size of the key to be imported
+ * @lt_key: the wrapped key to be returned
+ * @lt_key_size: size of the wrapped key
+ *
+ * Conceptually, this is very similar to generate, the difference being,
+ * here we want to import a raw key and return a longterm wrapped key
+ * from it. The same create key IOCTL is used to achieve this.
+ *
+ * Adds support for the create key IOCTL to interface with
+ * the secure environment to import a raw key and generate a longterm
+ * wrapped key.
+ *
+ * Return: longterm key size on success; -errno on failure.
+ */
+int qcom_scm_import_ice_key(const u8 *imp_key, size_t imp_key_size,
+			    u8 *lt_key, size_t lt_key_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_IMPORT_ICE_KEY,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RO,
+					 QCOM_SCM_VAL, QCOM_SCM_RW,
+					 QCOM_SCM_VAL),
+		.args[1] = imp_key_size,
+		.args[3] = lt_key_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	void *imp_key_buf;
+	void *lt_key_buf;
+	int ret;
+
+	imp_key_buf = qcom_tzmem_alloc(__scm->mempool, imp_key_size, GFP_KERNEL);
+	if (!imp_key_buf)
+		return -ENOMEM;
+	lt_key_buf = qcom_tzmem_alloc(__scm->mempool, lt_key_size, GFP_KERNEL);
+	if (!lt_key_buf) {
+		ret = -ENOMEM;
+		goto err_free_longterm;
+	}
+
+	memcpy(imp_key_buf, imp_key, imp_key_size);
+	desc.args[0] = qcom_tzmem_to_phys(imp_key_buf);
+	desc.args[2] = qcom_tzmem_to_phys(lt_key_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(lt_key, lt_key_buf, lt_key_size);
+
+	memzero_explicit(lt_key_buf, lt_key_size);
+	qcom_tzmem_free(lt_key_buf);
+
+err_free_longterm:
+	memzero_explicit(imp_key_buf, imp_key_size);
+	qcom_tzmem_free(imp_key_buf);
+
+	if (!ret)
+		return lt_key_size;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_import_ice_key);
+
 /**
  * qcom_scm_hdcp_available() - Check if secure environment supports HDCP.
  *
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 56ff0806f5d2..c30d6383b6de 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -128,6 +128,9 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_ES_INVALIDATE_ICE_KEY	0x03
 #define QCOM_SCM_ES_CONFIG_SET_ICE_KEY	0x04
 #define QCOM_SCM_ES_DERIVE_SW_SECRET	0x07
+#define QCOM_SCM_ES_GENERATE_ICE_KEY	0x08
+#define QCOM_SCM_ES_PREPARE_ICE_KEY	0x09
+#define QCOM_SCM_ES_IMPORT_ICE_KEY	0xA
 
 #define QCOM_SCM_SVC_HDCP		0x11
 #define QCOM_SCM_HDCP_INVOKE		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 89358478ac67..a0983a40bc09 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -105,6 +105,11 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 			 enum qcom_scm_ice_cipher cipher, u32 data_unit_size);
 int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
 			      u8 *sw_secret, size_t sw_secret_size);
+int qcom_scm_generate_ice_key(u8 *lt_key, size_t lt_key_size);
+int qcom_scm_prepare_ice_key(const u8 *lt_key, size_t lt_key_size,
+			     u8 *eph_key, size_t eph_size);
+int qcom_scm_import_ice_key(const u8 *imp_key, size_t imp_size,
+			    u8 *lt_key, size_t lt_key_size);
 
 bool qcom_scm_hdcp_available(void);
 int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);
-- 
2.43.0


