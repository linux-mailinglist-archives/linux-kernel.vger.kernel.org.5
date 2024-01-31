Return-Path: <linux-kernel+bounces-46323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6CA843DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818731F2D232
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F286676C78;
	Wed, 31 Jan 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J0IUXpiv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1E6BB5C;
	Wed, 31 Jan 2024 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699420; cv=none; b=qXNaXKmr0HVqFrk2EQhkzIVjxSHV7DupZbae4JCmCQqeVnBU7VCKS4aEN2Wm/C80vvOGMDKNKhmtwg8IyXZs3J4hsOSwjRapxVVH4anhtbpP/YM8lWheKzx7LtIq4dN0eZOYSxRGSsOLEtx9H5fzUsEzMmNeXnIxtfY7QyVWQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699420; c=relaxed/simple;
	bh=879o0stse/wM791U4PDWEqFXWnjbVgCb9rBx9CGi17U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQN4Y9YMbNLps4J+mze0cPr9Ej0L4moWPqvj5f8y6oWlNdE8j4/jCc64A2hmi2zl6MMFEtA+/ZfFDra0lvAUe2+ww+rkFfMUTPs55rgoHMaP3dmQtP4Y3r8khcxKHMHkjZrCedTcjp03xsqL8IzxJGegW1TIA/hJ6j/Mu8x0Nb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J0IUXpiv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VARgkV017838;
	Wed, 31 Jan 2024 11:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=erVnAJZx8ifcWPyB4Oavo8ehNHt/B3Y78dIRrq0/iQw=; b=J0
	IUXpiveG7zrVwEHzA6c2Z0vnZgyhwl7F9BPqe04ukjo1v5EX8S7OXvxA7fDLsKpe
	EEWaUjMhk+CvGMd1l0bfB4nPThXq7aX9RvJCNPVNFV6mlEexX7Pzoxssu6lawMpW
	NlDu2TNKR+hUG+CspLedTlv+mA5E3c0sFIbPxnLyBlHXv5qEkFmRJODBWX0XHIIv
	WZI/3k/NBtKyHlBblDlHnRvi83JL2v5VyVivnmZpIhWwiZ0DbhKu3RkzwcBQ6u+s
	iyu9C6RRw1mnZHfdsenjSb6a7JG8qdZjY0HgV2EUvjZwH4RRr57tk3bXhO8t8WeG
	pymT+To93VMrnP4MCHbg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyjas0e0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 11:09:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VB9oDa001939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 11:09:50 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 03:09:41 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <corbet@lwn.net>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v8 07/10] MAINTAINERS: Add entry for minidump related files
Date: Wed, 31 Jan 2024 16:38:34 +0530
Message-ID: <20240131110837.14218-8-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240131110837.14218-1-quic_mojha@quicinc.com>
References: <20240131110837.14218-1-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: 9AAzU-6IftE53w_J4rLOFCofHTJNri2D
X-Proofpoint-ORIG-GUID: 9AAzU-6IftE53w_J4rLOFCofHTJNri2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=855 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310085

Add the entries into maintainer file for all the minidump related
modules.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c45587eb4c1d..a7eea6e64dce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18176,6 +18176,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
 F:	drivers/regulator/vqmmc-ipq4019-regulator.c
 
+QUALCOMM MINIDUMP DRIVER
+M:	Mukesh Ojha <quic_mojha@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/admin-guide/qcom_minidump.rst
+F:	drivers/soc/qcom/qcom_minidump.c
+F:	drivers/soc/qcom/qcom_ramoops_minidump.c
+F:	drivers/soc/qcom/qcom_rproc_minidump.c
+
+
 QUALCOMM NAND CONTROLLER DRIVER
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-mtd@lists.infradead.org
-- 
2.43.0.254.ga26002b62827


