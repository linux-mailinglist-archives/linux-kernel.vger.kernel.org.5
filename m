Return-Path: <linux-kernel+bounces-41448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AFF83F1E7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CA11F23468
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C748741AAC;
	Sat, 27 Jan 2024 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LwlsHC0P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF72E834;
	Sat, 27 Jan 2024 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398010; cv=none; b=PWsfqn2OMwZB4OKpqBQNecfXaP8sx3kQuTwCtQ4wk2lry2Xjlogb6AnbNcY1KcoHpJ27PyukDyjvy/7QTXHtUXKiHs8Ub9T0nQYbApAEyzW/Qug6haMYAYkZCLY5fdn0gj+nvX9XQjBCSkCRXWKZBXQvZ5UVF3b9zboUJeDE2LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398010; c=relaxed/simple;
	bh=6ZQ0kgnKoVx4yN1FKa6RPGFLw574BwEZVjH9EZEwlXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsmSmTvgqDNUGMbsli6reqWdeRPsNNcu/GRvTc4sglxWcBoa1bvBk2TGz7bzHXPyOyPJMUESku0CgJ3qUaI1fYBHoaA/WPOo10+FiS/1g4DLpnDtcFVPne+aNJU/OMZvY5MkUoc5PnyEdfOctH3n0Q6pSBIm/PoLT/BzKq9aYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LwlsHC0P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RNJV8Q021485;
	Sat, 27 Jan 2024 23:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=MQNujueof9e01XdtLBHf/Mn/2u1GIA7gc9ic8JiAi20=; b=Lw
	lsHC0Py+zYUFKGzcTRpK9xBbmvVcCTZQbVJnB4QPi5mkaquw5gU30V8mGPwjEsfp
	ms+mHCZwOzBgNiBLwSSgSee1MavTnm10mNxiuOCFAWvPSzlvubqpSAIQAaLCarb0
	G7/iCq2McPo34FdkzweUVwY9wJ6d8O+Cel5gZQSEEhAAmEr0lBBLIpggf3eNDGes
	ucSYDdAYcoaKKEfE1A7aB1ioc8Iue8bQIDweROogoLjq02r2Y6t3Tu8YmhgLtnv1
	7Z3hD8mXRxrYtulYhAuDCrO/VZLgsG2bRv1ka2Q8c6y1yXQdsaz5iY9o7fMMh++n
	ebDwOgrTzsOGeK4kKe4g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvtkm92nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40RNQNS9031165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:23 GMT
Received: from hu-gaurkash-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 27 Jan 2024 15:26:18 -0800
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
Subject: [PATCH v4 08/15] ufs: core: add support to derive software secret
Date: Sat, 27 Jan 2024 15:14:06 -0800
Message-ID: <20240127232436.2632187-9-quic_gaurkash@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KfOzke2nJI5BU70-hEWf1r_VjXxhcLhI
X-Proofpoint-GUID: KfOzke2nJI5BU70-hEWf1r_VjXxhcLhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270178

Block crypto allows storage controllers like UFS to
register an op derive a software secret from wrapped
keys added to the kernel.

Wrapped keys in most cases will have vendor specific
implementations, which means this op would need to have
a corresponding UFS variant op.
This change adds hooks in UFS core to support this variant
ops and tie them to the blk crypto op.

Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 15 +++++++++++++++
 include/ufs/ufshcd.h             |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 399b55d67b3b..c14800eac1ff 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -119,6 +119,20 @@ static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
 	return ufshcd_clear_keyslot(hba, slot);
 }
 
+static int ufshcd_crypto_derive_sw_secret(struct blk_crypto_profile *profile,
+					  const u8 wkey[], size_t wkey_size,
+					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->derive_sw_secret)
+		return  hba->vops->derive_sw_secret(hba, wkey, wkey_size,
+						    sw_secret);
+
+	return -EOPNOTSUPP;
+}
+
 bool ufshcd_crypto_enable(struct ufs_hba *hba)
 {
 	if (!(hba->caps & UFSHCD_CAP_CRYPTO))
@@ -132,6 +146,7 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
 static const struct blk_crypto_ll_ops ufshcd_crypto_ops = {
 	.keyslot_program	= ufshcd_crypto_keyslot_program,
 	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
+	.derive_sw_secret	= ufshcd_crypto_derive_sw_secret,
 };
 
 static enum blk_crypto_mode_num
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 680c010a53d4..8a773434a329 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -321,6 +321,7 @@ struct ufs_pwr_mode_info {
  * @device_reset: called to issue a reset pulse on the UFS device
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
+ * @derive_sw_secret: derive sw secret from a wrapped key
  * @event_notify: called to notify important events
  * @reinit_notify: called to notify reinit of UFSHCD during max gear switch
  * @mcq_config_resource: called to configure MCQ platform resources
@@ -365,6 +366,9 @@ struct ufs_hba_variant_ops {
 	int	(*program_key)(struct ufs_hba *hba,
 			       const struct blk_crypto_key *bkey,
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
+	int	(*derive_sw_secret)(struct ufs_hba *hba, const u8 wkey[],
+				    unsigned int wkey_size,
+				    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
 	void	(*reinit_notify)(struct ufs_hba *);
-- 
2.43.0


