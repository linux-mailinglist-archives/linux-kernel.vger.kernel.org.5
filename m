Return-Path: <linux-kernel+bounces-55756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153F884C147
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B00D281DD2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBFCDF44;
	Wed,  7 Feb 2024 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uw21QNs9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC5DDA0;
	Wed,  7 Feb 2024 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264655; cv=none; b=HhYD4wsX4h5DaHsbSJ+d59G0fBrlQpAe2nSC+PQWJYxUtHaRb4odDIMhv0HaOJQ8rJIuI5xRPYwihGhYAhMhN+eQnAPfvpHAmcyuSstQbHqh42TDKvKHQ6pi0Ic/IaQyct/P51fIVuZn2dcvzjohjiBglciNx7Q2ek2CaeaO5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264655; c=relaxed/simple;
	bh=6reKaR74PsLEEhWXFF0eYoOTUvHn7NUWzmF0g9nPW+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/Lc4KHK6Puk241P9PI2hAg9DKofMGs5dQpieJzPidkhfixfvWqXSFcV0wyzkrVKQmYAz7pGz48xEtWBZ2FEpj/oDcgePf6VzNxjY2B0NKIMCAmQQuGUS+hyZwNTp1P1UQakWPl6T5bWhzt+hrPNUvxSswM3tmrubr5b2WML1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Uw21QNs9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416NISTZ010794;
	Wed, 7 Feb 2024 00:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=Skg3HbQjq2/sqhBqmP0V
	Z8miwYY04Us8dUh25zkVrRE=; b=Uw21QNs9FXkmcZGXLoDo2qZoXPcwQ0ZqwPNt
	pabH1bIQXEqzBe1AeA/7kBvCRFhIi8S5hgjVBtG5M0Z9H5RBh88KA1vthCqYvicn
	HRMCj2Xq6jky79/V1JKxIBfllnzY0OqII2Xu/YXa28/MxPa7n/MyvZtTtfVrrGfR
	1gRqet3r9qSyl30SK1Rpwo8jWja0kxEYxI1GWGTvnynEXLynu+uc2vUts0gltE/K
	C8FToJft24r1UMfLcEJ4KwJKT0/naAVer3rf0bkApjb7Fy+iMZN+LMi2uplPUBaQ
	IhJowCUsW4fI7nj3YDJe22XvtVgVlMTFAIXwepsTypOCVOJ0kw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3ud2ree6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 00:10:38 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4170AbMC031971;
	Wed, 7 Feb 2024 00:10:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3w37h10ecd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 00:10:37 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4170Ab4d031966;
	Wed, 7 Feb 2024 00:10:37 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 4170AaGU031961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 00:10:37 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 5216A22B62; Tue,  6 Feb 2024 16:10:36 -0800 (PST)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>
Cc: kernel@quicinc.com
Subject: [PATCH v2] net: stmmac: dwmac-qcom-ethqos: Enable TBS on all queues but 0
Date: Tue,  6 Feb 2024 16:10:36 -0800
Message-Id: <20240207001036.1333450-1-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pFMpKkgujDH8ky-4mt2LIGwBn_H2n5fc
X-Proofpoint-GUID: pFMpKkgujDH8ky-4mt2LIGwBn_H2n5fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_15,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=801 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060171

TSO and TBS cannot co-exist. TBS requires special descriptor to be
allocated at bootup. Initialising Tx queues at probe to support
TSO and TBS can help in allocating those resources at bootup.

TX queues with TBS can support etf qdisc hw offload.

This is similar to the patch raised by NXP <3b12ec8f618e>
<"net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings">

Changes since v1:
- Subject is changed as per upstream guidelines
- Added a reference of a similar change done by NXP in
  body of the commit message

Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 31631e3f89d0..d2f9b8f6c027 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -728,7 +728,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
 	struct qcom_ethqos *ethqos;
-	int ret;
+	int ret, i;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
 	if (ret)
@@ -822,6 +822,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
 	}
 
+	/*Enable TSO on queue0 and enable TBS on rest of the queues*/
+	for (i = 1; i < plat_dat->tx_queues_to_use; i++)
+		plat_dat->tx_queues_cfg[i].tbs_en = 1;
+
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
-- 
2.25.1


