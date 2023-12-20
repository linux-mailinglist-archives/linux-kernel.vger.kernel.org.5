Return-Path: <linux-kernel+bounces-6781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189C7819D77
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE94B244D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871DB20DF3;
	Wed, 20 Dec 2023 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pjHNRlCf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC120B2C;
	Wed, 20 Dec 2023 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK9LE7Q032333;
	Wed, 20 Dec 2023 11:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=uZLXpWp
	atcSGW7WnIy7wcRKFTAeBbx5Y2C2MIyCYREU=; b=pjHNRlCf6tCzAlqgS9wWXw5
	9KBgtVAeLd03mhlbkbRLFuGw8BDsOeZjH6LsB7Zhkif7/sXPQED3/l4pP6cgJNUH
	UmXnm/LMmRyZuruOyeRVS1iFR1VPZdV5BmQ7I66QvnJ7DSJpSD9ZmP325RnPd9NJ
	rmC73Yhemq9Zv+k2EvHqu3N4h/WqV6ncXLQbpyVzHLBiDFZqsXxw9MKIFIu/w4A9
	GvlPBsgZZ3GItxKkSgRjwanjUzIPPOdWL8Yq1Nmg9aSnrKdJ/cVGMW0tjwMMJtt8
	6KlB/qWi7q/+MisEY80QBPrjMtn/N5NaSwvqy7wuIvAL+jJp9h6Y7ecWKVS2pQw=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3pkys1y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 11:00:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKB0Zqm024201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 11:00:35 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Dec 2023 03:00:31 -0800
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "Naina
 Mehta" <quic_nainmeht@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 0/2] Correcting the voltage setting for vph_pwr
Date: Wed, 20 Dec 2023 16:30:13 +0530
Message-ID: <20231220110015.25378-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YcbsLEjX1z_bOwthiU6gWaLqqWgpmEhp
X-Proofpoint-ORIG-GUID: YcbsLEjX1z_bOwthiU6gWaLqqWgpmEhp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=292 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200077

Correcting the voltage setting for vph_pwr for qcm6490-idp and
qcs6490-rb3gen2 boards.

Komal Bajaj (2):
  arm64: dts: qcom: qcm6490-idp: Correct the voltage setting for vph_pwr
  arm64: dts: qcom: qcs6490-rb3gen2: Correct the voltage setting for
    vph_pwr

 arch/arm64/boot/dts/qcom/qcm6490-idp.dts     | 4 ++--
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--
2.42.0


