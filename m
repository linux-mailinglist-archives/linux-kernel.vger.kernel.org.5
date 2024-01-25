Return-Path: <linux-kernel+bounces-38380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990FF83BE8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FAC286A61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB681CA94;
	Thu, 25 Jan 2024 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GPNQp0sv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F41CA80;
	Thu, 25 Jan 2024 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178288; cv=none; b=XEss/3wbNef6Q1QZqpKjrM4MZtq61G117o6W5qNrwzMQsntFRJprgaxH8zDus0YIRHe4nmUxwcIB7wsGg2doZDhuuxhK0/Pj6jtolx//0e2U9g8RaOaeKos9Fdt+atAK/K+ufwZj5DN5w5X6/PHP6lOU6psLfO9WCPRVfBgtFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178288; c=relaxed/simple;
	bh=1uLuo0q4CJFxnwbdcpnYTHdkbkU42NKCQv4Mp39rfgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cniIZF+5fBWnmnsn4AhlRgfOpDm+tTdVmDY4uk1SnaiFPD4MmDsKBqzPM2hAz+xDoR2y1fIyo9qhJ7yJuNamN1bOV8BTFnWdsbxP1CmADL9WlPk7wNxk3Zjl1PeNkIvAW4Jh8RFaY/wWdx1cDXKWssVtxVP7lxHgWpdmUOOVYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GPNQp0sv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P9dtHb031568;
	Thu, 25 Jan 2024 10:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=elRGrw/emhO5jisB+PebDbwXVwKPeANiwLTWWLDJB8w=; b=GP
	NQp0svZJjmf5yYMB0Rdbj8+G9B4GE3Wl3wboK8veH8PaKlJAPFel/has9DeFMqCW
	+DQp6qYMIu7NHXfHXx80Jufj6CN+87m4jxPmADSifArVGyIdUZ1o/2KK/gPH+KLO
	jJv6qQRidtyYgQXz0OoxaiEmgRiWotGiMyvm/twz8bqR1dn9McNAvZhJt+VqH2jy
	FstNew3UzdfAZSROr0rXfCECKd4XkvPeBlmKVVEr5Pzxi83Caq0+f79Xip/vaexA
	zglGh5pULB782N20QMdteLBJt/xOLu0aVwNFqENgqacoMCC2qPIDxGfkLxiKw9MF
	UCMLFJM6fDYisFhRs1Yw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vun6w034k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:24:42 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PAOfvE012594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:24:41 GMT
Received: from hu-lxu5-sha.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 02:24:35 -0800
From: Ling Xu <quic_lxu5@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <quic_kuiw@quicinc.com>, <quic_ekangupt@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ling Xu
	<quic_lxu5@quicinc.com>
Subject: [PATCH 0/2] arm64: dts: qcom: Add dma-coherent property on
Date: Thu, 25 Jan 2024 15:54:11 +0530
Message-ID: <20240125102413.3016-1-quic_lxu5@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r0emfoENkl3pxTxT0EjfgUlYkUeP8f3F
X-Proofpoint-ORIG-GUID: r0emfoENkl3pxTxT0EjfgUlYkUeP8f3F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=342
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250070

Add dma-coherent property to fastRPC context bank nodes on sm8550 and
sm8650 dtsi files to pass dma sequence test in fastrpc sanity test,
ensure that data integrity is matained during DMA operations.

Ling Xu (2):
  arm64: dts: qcom: sm8550: Add dma-coherent property
  arm64: dts: qcom: sm8650: Add dma-coherent property

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 13 +++++++++++++
 2 files changed, 26 insertions(+)


base-commit: 774551425799cb5bbac94e1768fd69eec4f78dd4
-- 
2.17.1


