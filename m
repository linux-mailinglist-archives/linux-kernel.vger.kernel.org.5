Return-Path: <linux-kernel+bounces-41451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1794883F1FE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A42B1C224F4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD15C8E4;
	Sat, 27 Jan 2024 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XolMEuC5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA145959;
	Sat, 27 Jan 2024 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398012; cv=none; b=BXYDRX6DbHcGAtzw3G06ZAuOaJM1re8N/Fyh7iHb2ppFT9PeQ6jVRJZGVQFZc90YN4CYXvI9WRYJcLIyKdgYha4JtIUjFn90ZijAxtTKDIfYeSEL242n5GGejAyUt80UqTAAr9wwFj3v84hmgY9mkopccz7PiyhzmltLo1SqPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398012; c=relaxed/simple;
	bh=uFzYOBGLEFbtjSpClA4EglUVe5wO/NhVVgsIvf+G5NA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7GtIila1+/SMYtoodYDBWkZYHV6odM65qYVKIL+kycoXpbreNV1MGVIolzyFx/0Ln5ceA9LOF+WAgULBjvKh8cYVG732v5rtK10W6aeTiA0n6lLJ8mbWuJr5B/UFvTHsNs1MfGD+NCTuJtuj9l5kbnBdQhSLe5rALi3YA9x0ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XolMEuC5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RNQOP3000906;
	Sat, 27 Jan 2024 23:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=VHKfjZB1aXfXcepHFQtDQkyCYx8GZ9P4kZUo6KA6Bb0=; b=Xo
	lMEuC5JCK1+GrUNyanXuHuz/+0ECQGU/ATbD2vbIsqOJp3yVMY2MDFPrSzFKAEbl
	+jX4TwP0GRoCwrBOXKVnzNI/aXbiFKqBb2QfjuWrD8vtmhh4kBUtjA+0P3wvTfST
	bBQw6/Rnu+ZE3pWH+WO1wCsT9CNmbjWCvjxfVlgFYYuWOhO3A8wT8m0t6mMIbsWD
	8OaNRmTL2Vp9xogmeyZHCvgEzUV1EQBer3KOszqBUzRV0bfKkfR9FulXHybNmmPP
	YNS0d+8AtA0sFZW+yxOxCG+iBwD9xUkIerb6Sd1IBX+KVutniambadfiYNEPKzCI
	sKLAnINZcMEBSgD/0EXQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvu0rs1j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40RNQNSA031165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:23 GMT
Received: from hu-gaurkash-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 27 Jan 2024 15:26:19 -0800
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
Subject: [PATCH v4 10/15] ufs: host: wrapped keys support in ufs qcom
Date: Sat, 27 Jan 2024 15:14:08 -0800
Message-ID: <20240127232436.2632187-11-quic_gaurkash@quicinc.com>
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
X-Proofpoint-GUID: U817TLmrnVnMUsQBD6bYYv0JmEJIl6a-
X-Proofpoint-ORIG-GUID: U817TLmrnVnMUsQBD6bYYv0JmEJIl6a-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270178

Use the wrapped keys quirk when hwkm is supported/used.
Whether to use HWKM or not would be decided during an ICE
probe, and based on this information, UFS can decide to use
wrapped keys or standard keys.

Also, propagate the appropriate key size to the ICE driver
when wrapped keys are used.

Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index acf352594362..5c9ba06438a9 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -123,6 +123,8 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 
 	host->ice = ice;
 	hba->caps |= UFSHCD_CAP_CRYPTO;
+	if (qcom_ice_hwkm_supported(host->ice))
+		hba->quirks |= UFSHCD_QUIRK_USES_WRAPPED_CRYPTO_KEYS;
 
 	return 0;
 }
@@ -160,7 +162,11 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 	    cap.key_size != UFS_CRYPTO_KEY_SIZE_256)
 		return -EOPNOTSUPP;
 
-	ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
+	if (bkey->crypto_cfg.key_type == BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)
+		ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED;
+	else
+		ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
+
 	if (config_enable)
 		return qcom_ice_program_key(host->ice,
 					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
-- 
2.43.0


