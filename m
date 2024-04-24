Return-Path: <linux-kernel+bounces-156702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D8C8B0708
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5C82819B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97CF159588;
	Wed, 24 Apr 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oK8fWAw/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E381591EE;
	Wed, 24 Apr 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953768; cv=none; b=ZhY0RCxrOuZwKdGghFeTrLVzHEc+/1+uWB9L0qpX32f9PACMCFqPxQ/IZ/KqwF+WsVmaBxf9wtbIdQUspc5tSWbAAuuCK4SlfrmxkT0+7Ztc7ALQqvV44+i5Dg6diDBYhQ/PrL2rVwof8t/+lNMs0H2yrxlKgd90MQ0ZMdCElvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953768; c=relaxed/simple;
	bh=8Oy/uD9jVavJfWsgCdbYZdkk1sRLPXZ4IHuJWyeg0o4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mbH7dbs/6zp58MI0sz9AtmtzftjCED+t8n0nalpYS2GFoah1i26ZkoDV7DEzl7U9i5c8flEusKxpCGSYhyITcH8lzjJJIbg0hv/R+MNfXvXKhzDPTJT8rPlLwES5G2lmrnCynMuHyETtq4EQtZnocRPuchSgfhmB4MzNEzAxY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oK8fWAw/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O9Epq6004161;
	Wed, 24 Apr 2024 10:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=1B2VX4d
	TB2W68hxQi0d3/UidK3ko/7h+QJBXG0519x8=; b=oK8fWAw/5DWQm0D4wiEG5Pd
	wH9p2Rl4KOfJo690fDQKzcw2PRRZMVD3AFLLW9PWT2migCob04aDJxUu2aLxeCdd
	qZjh7JS6ucnFEn3CpGWq0qyE+h9P/Kzmun/pd5q8hRGKMVGvOODb58QeKXN+G0z7
	Xjmk1UIGNf0E2/FjNV5K/Tgj39UmtI0Mh4rf+bv1klUQtxT2taVqurDaipeSfJq6
	b3fZRx90XECCAfJZh8fVtBN9/htNFpiKhlSnzuRjDcK8o4gE+kfPbzDrqb2k5vpM
	QAlih6P055anwuQ7FWhyiiMWw3/NeiSiAKjplZSt7Iwks+X6OoebtxvtfA8NR+A=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9ggh31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 10:15:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OAFwCR028651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 10:15:58 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 03:15:54 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <manivannan.sadhasivam@linaro.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 0/3] arm64: qcom: Add cpufreq and clock support
Date: Wed, 24 Apr 2024 18:15:00 +0800
Message-ID: <20240424101503.635364-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kvPxvTkw4ALCRlRBrWrBt9D6o3iVGwUz
X-Proofpoint-GUID: kvPxvTkw4ALCRlRBrWrBt9D6o3iVGwUz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=893
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240042

Add cpufreq and clock support for SM4450 platform.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

Tengfei Fan (3):
  dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450 compatibles
  arm64: dts: qcom: sm4450: Add cpufreq support
  arm64: dts: qcom: sm4450: Supply clock from cpufreq node to CPUs

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |  2 +
 arch/arm64/boot/dts/qcom/sm4450.dtsi          | 37 +++++++++++++++++++
 2 files changed, 39 insertions(+)


base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
-- 
2.25.1


