Return-Path: <linux-kernel+bounces-164385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0B68B7D09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DE61C209FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CB517F36A;
	Tue, 30 Apr 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lUyO0UYU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F617F39A;
	Tue, 30 Apr 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494724; cv=none; b=Ljk4mHLPTh9A42S/pZ2yf/r7A/+s6KK1l1y2qQOqPK0CDsRG4SbD2ozS72Eas9+tRkxJxikDUm9TJe4EpF6wqZ0RwCNIBX9r4YrPrF3oAx6dX/qdI4gT5E4gDqj+ZvOngX4zf23FyKTmEhy2By/BKH+4SLj6H30UHAiZFf1Oc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494724; c=relaxed/simple;
	bh=O98bq1HErgHxSK83mc85TsVLlioqfec3zXy9BF5Y4Wk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uoQxtOr0U/KA070tOvuyyWlYm4HWntffMi+BOCzQ80ZsiMd/R3zEb0p7Wyjzc6vJrQLN64561lADzB8R1s62Ov43TnnIEA/QRopJmid0IvMImey5kL6Y5/b9Cwn/6K7TGssMYu590LUmAFbHETOvm72vrVgLJkMXrehqpYd0ZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lUyO0UYU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U4LNHh026519;
	Tue, 30 Apr 2024 16:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=rk7ITeWiEjcj
	X5CJ8GhjA3nlYy+V4+DZD57m0yLv2Ik=; b=lUyO0UYUwxqvtjvnyk4Kg1C80aLc
	hqE8ZdPsP9ZLXrgQ0u/pxsQG3ECwC/bzpikjl5YI3G1blDLwy7w1UX+rhIT0Xh0a
	jmb6DEp8qytRqvPXvUMjskXOw/+lDRj0t1RyXcneuDvGrqoJCw/YYmh2rPHu7VZi
	DovIbDa9KNb77hzVKYVkkCJl1H9VO5uXnuC1eBbRzXgwrHxgtiQARUGBnzKKQTk4
	HZdDkTmcoZwch4slmXEQYdfBJUT68Jg9aVUfv/vhzqZC2s8HzjNDfKzHOgmF90zq
	zHUQk2Zi9j4TRFres6OThdz2VNYSbv3CCWVfuDm50aRVsvPs1zVjWM9GXg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtfys41sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:31:58 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43UGVsW2003686;
	Tue, 30 Apr 2024 16:31:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xrtem1f7w-1;
	Tue, 30 Apr 2024 16:31:54 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UGVs3r003680;
	Tue, 30 Apr 2024 16:31:54 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43UGVsxu003678;
	Tue, 30 Apr 2024 16:31:54 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 7D30D2287; Tue, 30 Apr 2024 22:01:53 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Adding iommus property and setting max link speed for PCIe
Date: Tue, 30 Apr 2024 22:01:49 +0530
Message-Id: <1714494711-10322-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l__2j4wQ7hDAioliuVWmb4dRoVrokmmU
X-Proofpoint-ORIG-GUID: l__2j4wQ7hDAioliuVWmb4dRoVrokmmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=457
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300118
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This series adds 'iommus' DT property for PCIe RC nodes so that IOMMU
can be used for address translation.

and setting pcie max link speed to gen4 that was linited to gen3 ealier.

Dependency for Patch 2
----------------------

Depends on:
https://lore.kernel.org/all/1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com/
https://lore.kernel.org/all/1714494089-7917-1-git-send-email-quic_msarkar@quicinc.com/

Mrinmay Sarkar (2):
  arm64: dts: qcom: sa8775p: Adding iommus property in pcie DT nodes
  arm64: dts: qcom: sa8775p: Set max link speed to gen4 for ep pcie

 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4


