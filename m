Return-Path: <linux-kernel+bounces-165034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05308B86E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF581F23BEB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE00F50283;
	Wed,  1 May 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bIbPdIrn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DBE14AAD;
	Wed,  1 May 2024 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552369; cv=none; b=f/HKqBDdQDOgXsQ7BdWWLf+5J6dazE1WQ5unXG9/phOqZwdDd10ha+7HUvilO13qb1Zr/3Vr9DUXRb+EEyxMgc14Gek4Aq9a9MplRyiP3OMdYKtR/s/spb8MG6F775oZCBhhZxd6WAyR3JiPOxJ0Dlisd1nm5k0XINTnOSiJdbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552369; c=relaxed/simple;
	bh=RuXNAG1lXnKCvaqPxD3w7ZeY0eoB0xdldgqEftwwyIA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=tJtgWeZhaUPbwc+1nXL0LOWOZW509CCLfj+aZX0m4DonxWlt8WSJQWXwLKqBTmsDxrOKct4ST59XGRm5/YNmp9X9DHWqvXF1nZm7fMJUWmO+IIDRheNpA0qHWGxBq0jv4y2uN0SS846rs7U1Fw9aKqzhUDKKwMyGwD301o9N5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bIbPdIrn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4415cttO012053;
	Wed, 1 May 2024 08:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=cZcnwkyu4CHae9
	2lh6KDDACsglcNCH9BQvm5KKokaEM=; b=bIbPdIrnu9kAIL94mLFz7beWWkqmVH
	8jOn1EYvDuuRBNtvdD0ALDJceqUCIsES8OgNNz8hLaRmqix6AaOsBB+dpUWxWem9
	xKIlpE3Anz6Ji9qz4oWaHX38qnaGmlW/kJwpE/osus2lFoFcR5f0lnH6BtGVoPWM
	h8gs0IA9685Tr/EbRn0HMVLjDb0PZFoj6yf+SCTUMYDhbmOPPidrBcu/Mww/kRDv
	roGnlLHNTzzNNWYi2IsfC+LpdYjOv4ggy6boziHCfete10CrfeEavlte+S+5nvkh
	10qm3UpjTe4wUiN5+8lk+rC6iBTShq6ktLUppKLczxoBMO4spv4PehtA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xu71j92w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 08:32:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4418WSGL008791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 08:32:28 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 1 May 2024 01:32:23 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH v3 0/2] Add DT support for video clock controller on SM8150
Date: Wed, 1 May 2024 14:02:17 +0530
Message-ID: <20240501-videocc-sm8150-dt-node-v3-0-2c4bd9ef48bd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABL+MWYC/3XNQQ6CMBCF4auQrq1ppwjVlfcwLmA6yCygSrHRE
 O5uISbGBcv/JfPNJAINTEGcskkMFDmw71OYXSawrfobSXapBSjIlVFWRnbkEWXorD4o6UbZe0e
 yaHRh6vwITYkiHd8Havi1wpdr6pbD6If3+ifqZf2S2myRUUslK7KEBi0AwvnxZOQe9+g7saARf
 lCu9CYECTK1LdFB5dyx+Ifmef4ANBUAogcBAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Taniya
 Das" <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OroXDFL1kL9S_q2kNk2a2Sf4E2WmxpzI
X-Proofpoint-ORIG-GUID: OroXDFL1kL9S_q2kNk2a2Sf4E2WmxpzI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=708 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405010059

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Changes in v3:
- Adding the required-opps property back, which was removed in v2.
- This is needed because the lowest power state for MMCX on sm8150 platform
  is retention, but we want to enable the power domain in low_svs not retention.
- Link to v2: https://lore.kernel.org/r/20240401-videocc-sm8150-dt-node-v2-0-3b87cd2add96@quicinc.com

Changes in v2:
- As per Dmitry's comments, there is no need to update to index based
  lookup for already existing drivers, hence keeping clock-names property.
- Updated the videocc bindings to add AHB clock for the sm8150 platform.
- Link to v1: https://lore.kernel.org/r/20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com

---
Satya Priya Kakitapalli (2):
      dt-bindings: clock: qcom: Add AHB clock for SM8150
      arm64: dts: qcom: sm8150: Add video clock controller node

 .../devicetree/bindings/clock/qcom,videocc.yaml         | 17 ++++++++++++++++-
 arch/arm64/boot/dts/qcom/sa8155p.dtsi                   |  4 ++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi                    | 14 ++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)
---
base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
change-id: 20240308-videocc-sm8150-dt-node-6f163b492f7c

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>


