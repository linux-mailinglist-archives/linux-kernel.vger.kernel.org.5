Return-Path: <linux-kernel+bounces-41446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C506D83F1DA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD0D282A4A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4254C241E1;
	Sat, 27 Jan 2024 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dHY7RnRa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CB20B0F;
	Sat, 27 Jan 2024 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398004; cv=none; b=NCHUirupKBrUJ/+q53JGisAAuVoeUT+dQKY/qAhpkNy+PboyN2okVQdFc4LPKzlzCbPPP6RkZk3Ke1el/Qb/XihDNhYquOUM8rsZI8mAjzRHQKTxqpA4qd+RJ6OGjZnsgHzxuDHX15ISI3dMqjjH/o92U6ggh4EshlbuqiUPMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398004; c=relaxed/simple;
	bh=jstl00pDe6ZaQRcJVbIyePVGhUjWQPu0uo2G6X+kCwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSi5yx9SJc+hYdKltBjlw+CSTjJ4xlu/zZuOONRIPB68IdblND92lDVBXj/uUEJbvYTgjZsVR7hn0f8LQVoQNXobxhJOX9MLihay5w6Z8//I/Vm9l8nM28UvQMhVp8g8Tmr24UnFCgMSrkc4f09vK6TwS4fQ5Yk0287UCWWRjg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dHY7RnRa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RNQPEV032301;
	Sat, 27 Jan 2024 23:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=lpSwXfamTR8hWVVtjbbPTfipbhrNMGF5S4nOSytSb4Q=; b=dH
	Y7RnRa37N1y84AbOe/ePSsTIBNsZGxdQvrZpGlsu4QpYAoElovzxRzQEozypaYFf
	MIlGGTnhHzH8rkU6fiIZGh5NQgXJl5co0uOX6Voy1E6pzvYV/gxSA+HGPlsCr3DU
	WsHIeU6erV8d2tOcgWpMUuFZkz+rUNhfOCPqiwmY8VKZWhVN56jA+AkpP1hsKMx8
	nkHFYCAMgcTTRZrrO2hkJTEsJosNnUP0dCvOrqyNK2ItzBC2t28V0MeJv/Ggwebm
	ut0j9GndH/R3+vdugmuSagq0GgD3eAuMZ2dARGMLRP2MINmeERms/z+GI4zWdaAl
	wpsPjM4v1yxWUsc70BUA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvq6shb8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40RNQNFQ010255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:23 GMT
Received: from hu-gaurkash-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 27 Jan 2024 15:26:20 -0800
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
Subject: [PATCH v4 12/15] ufs: host: support for generate, import and prepare key
Date: Sat, 27 Jan 2024 15:14:10 -0800
Message-ID: <20240127232436.2632187-13-quic_gaurkash@quicinc.com>
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
X-Proofpoint-GUID: cK3VrZDmcMl2NO2NnfnczGmxlVCrHbrb
X-Proofpoint-ORIG-GUID: cK3VrZDmcMl2NO2NnfnczGmxlVCrHbrb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270178

UFS core defines a variant ops to tie the corresponding
generate, prepare and import wrapped key blk crypto ops
to the vendor specific implementation of wrapped keys.
This patch implements these variant ops.

Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index e319176accd3..5de23ae0538c 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -189,10 +189,41 @@ static int ufs_qcom_ice_derive_sw_secret(struct ufs_hba *hba, const u8 wkey[],
 	return qcom_ice_derive_sw_secret(host->ice, wkey, wkey_size, sw_secret);
 }
 
+static int ufs_qcom_ice_generate_key(struct ufs_hba *hba,
+				     u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_generate_key(host->ice, lt_key);
+}
+
+static int ufs_qcom_ice_prepare_key(struct ufs_hba *hba,
+				    const u8 *lt_key, size_t lt_key_size,
+				    u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_prepare_key(host->ice, lt_key, lt_key_size,
+				    eph_key);
+}
+
+static int ufs_qcom_ice_import_key(struct ufs_hba *hba,
+				   const u8 *imp_key, size_t imp_key_size,
+				   u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_import_key(host->ice, imp_key, imp_key_size,
+				   lt_key);
+}
+
 #else
 
 #define ufs_qcom_ice_program_key NULL
 #define ufs_qcom_ice_derive_sw_secret NULL
+#define ufs_qcom_ice_generate_key NULL
+#define ufs_qcom_ice_prepare_key NULL
+#define ufs_qcom_ice_import_key NULL
 
 static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
 {
@@ -1802,6 +1833,9 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
 	.derive_sw_secret	= ufs_qcom_ice_derive_sw_secret,
+	.generate_key		= ufs_qcom_ice_generate_key,
+	.prepare_key		= ufs_qcom_ice_prepare_key,
+	.import_key		= ufs_qcom_ice_import_key,
 	.reinit_notify		= ufs_qcom_reinit_notify,
 	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
-- 
2.43.0


