Return-Path: <linux-kernel+bounces-70325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 071F3859617
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158FB1C2156E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BC51CF99;
	Sun, 18 Feb 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hVZMYuGS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4F1CF81;
	Sun, 18 Feb 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708249439; cv=none; b=NLbkma4CDACjSltrzvfJ1aRyamRPfxH/oQCKTHWZv6QK4ZCVDaQ112/xKxkZHY3Fx5B7OZfQkecKX2P/Y7fmxmBU68Wtji8fsiSfXAfTeYatWvrYvDkv/z/Ui+D8efopEA4jwPzbbync0vdUDMfntrhSCZXFuGskUUyGUTMbvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708249439; c=relaxed/simple;
	bh=Gi/exkqkuNLSlzGPvDv0MkpDTsni9qUMHtNAHCPhiN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUCBRyo4RJ0q+onCcJ3mK2fZX5GqqtpcB16mAYoR+s3EcbYOuOLjcGCbNXi7q9BLZj+LjrY39HHObtCrsFuzQuh4IW9T4Epnim58FZlkwuC3DiwGzgKXnaq1r/kC5BatRHQQxMvKuy6/rQdyTUGqD1/oXkugBtzsdFSa10+1tJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hVZMYuGS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41I9N53P016845;
	Sun, 18 Feb 2024 09:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=bCpEG/iEJ6alJLg25zF1reZRTz9l9hb9cAwuGjH46hE=; b=hV
	ZMYuGSoxYIHKWVwRnmxFgdtU/yRVIgbpusFwv47knJtelosx4jlRF/fqCpNDiZfJ
	TheF/fyEZ8DyA/4Ip6IqWlOEYfF/VNmJUs44IbGgFtJDYpxU5V5oY4l4NFIGd9b7
	ZtipZ6hM7DPi7U4AAYan0KSbnEE+/oF7bKs2simfoA6EOZnCOwj72UtF9RR0LhYm
	LW9eGXSRyw2Z0ZQ5Io7CP+gCamnntVX7fG5j8uHy+MVsiIeZakznUbSuwksChzOM
	tzSsX8Qx/XcouOBpMArTyoz+0q1MryNFQwsALl6jtZpLWGDgb4feyNOLHQbQmEgi
	dUJOiHrC0F4aCifRF0FA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wajgk9ruf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 09:43:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41I9hl5J024628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 09:43:47 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 18 Feb 2024 01:43:46 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Mao
 Jinlong" <quic_jinlmao@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] coresight-tpda: Change qcom,dsb-element-size to qcom,dsb-elem-bits
Date: Sun, 18 Feb 2024 01:43:20 -0800
Message-ID: <20240218094322.22470-3-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240218094322.22470-1-quic_jinlmao@quicinc.com>
References: <20240218094322.22470-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GaCgWnGxqf4R4NEJflGjsFzsadNEpYBN
X-Proofpoint-ORIG-GUID: GaCgWnGxqf4R4NEJflGjsFzsadNEpYBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-18_07,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402180073

Change qcom,dsb-element-size to qcom,dsb-elem-bits as the unit is bit.
When use "-bits" suffix, the type of the property is u32 from
property-units.yaml, so use fwnode_property_read_u32 to read the
property.

Fixes: 57e7235aa1d1 ("coresight-tpda: Add DSB dataset support")
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 4 ++--
 drivers/hwtracing/coresight/coresight-tpda.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 6863afe7ca94..7739bc7adc44 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -69,8 +69,8 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
 	struct tpdm_drvdata *tpdm_data = dev_get_drvdata(csdev->dev.parent);
 
 	if (tpdm_has_dsb_dataset(tpdm_data)) {
-		rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
-				"qcom,dsb-element-size", &drvdata->dsb_esize);
+		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
+				"qcom,dsb-element-bits", &drvdata->dsb_esize);
 	}
 	if (tpdm_has_cmb_dataset(tpdm_data)) {
 		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index 19af64120fcf..c6af3d2da3ef 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -36,7 +36,7 @@ struct tpda_drvdata {
 	struct coresight_device	*csdev;
 	spinlock_t		spinlock;
 	u8			atid;
-	u8			dsb_esize;
+	u32			dsb_esize;
 	u32			cmb_esize;
 };
 
-- 
2.41.0


