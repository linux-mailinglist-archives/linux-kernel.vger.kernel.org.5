Return-Path: <linux-kernel+bounces-98791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61974877F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F36B21C82
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A93D978;
	Mon, 11 Mar 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D1rwrRu7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2993C064;
	Mon, 11 Mar 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158603; cv=none; b=guT371itFtXBYomCFXhaMmfRDxj25OFmgIqYOOfWNSdelyZT+Gm7AlouANirjAdhtbwHoLZP+vF2k1BjTrgYwT92wNrSdIhl1xCg5NI3lC0sX4nUAllwsJDoGybM/Gbg2AfrbxeNWAnUt1r3ZqH28i120DwSccXNuwiXEBADiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158603; c=relaxed/simple;
	bh=TKMT2rdzO+/5ChgLIqApqclXNnkC3VHE5qfko++u4Cs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RaIIOtqDnlrLuJyiKN9rRarxWP+amuDcWl5B0ZAKWRrmwVgxwrU9BNKBp4jmh/0Q9hEOLazPFq9OnahyaYPn+XsC+Oi+wvY+ERHS8gsERhB0/Vm/qHgbhYkb/YNZVHXfBJ45Dyn+9x7uhVArhAxg141P1aIuOxyAl8DGB/3Rpho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D1rwrRu7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B8LItZ018303;
	Mon, 11 Mar 2024 12:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=d99JtsJ
	ZhHsoZbUbQC6eIvwCP4EmFMN0LTeOQNY2154=; b=D1rwrRu7C/BQnG2TLMCVWw2
	Oha5UOawSqnKd3YRw7P3c4P0XkqDILZzegxF+2E1ALsjD645GHCsNSoCEvAWS4ll
	8oUwVZl7DkQzYHf1ADAr4v843y5nLfmfsJ+m3J+s5Qys7r/7FOwYYKnHR4UZvWoZ
	TeElaxzrIjPH+/kuAUvkx8pUvzAJG5QIiGZYvdxPQhEBZAE5cWF/pSNClqaYtEFD
	9U2CnAZ/OeF1giDsx3Cn7DlWa1/T/JM+cmVD99ReF+H/vi8bR3XgwBJEG5ls3txX
	GL5xP9RIt0kL+qyzX9lSvdR54JRUcSsLOWo39W8fidNBI8sq45mMdBjRqbl6e/w=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsxbvgk2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:03:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BC30q3008886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:03:00 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 05:02:55 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 0/4] Add USB Support on Qualcomm's QDU/QRU1000 Platform
Date: Mon, 11 Mar 2024 17:32:11 +0530
Message-ID: <20240311120215.16845-1-quic_kbajaj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZCX08ZLZ9iip6Ws4TPoNjUnMzz_vvQgi
X-Proofpoint-GUID: ZCX08ZLZ9iip6Ws4TPoNjUnMzz_vvQgi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=675 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1011
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110091

This series adds support of USB3 PHY support for Qualcomm's QDU/QRU1000 Platform.

Komal Bajaj (4):
  dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QDU1000
  dt-bindings: phy: qcom,qmp-usb: Add QDU1000 USB3 PHY
  dt-bindings: usb: dwc3: Add QDU1000 compatible
  phy: qcpm-qmp-usb: Add support for QDU1000/QRU1000

 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |  2 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |  1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  3 ++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 52 +++++++++++++++++++
 4 files changed, 58 insertions(+)

--
2.42.0


