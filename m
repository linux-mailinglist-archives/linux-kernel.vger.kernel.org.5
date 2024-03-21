Return-Path: <linux-kernel+bounces-109791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06328855C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B331F21C14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0D2A1C6;
	Thu, 21 Mar 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SAm9nyHt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247020326;
	Thu, 21 Mar 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009975; cv=none; b=m5tdtL4rBaJpYhIarq6WeJHLV1K8Z/z/CL1m8G0Xo/kEWFqSW2TVbMrhZJnO0HqVcCqszbdh1891eX1NefzEgmruvxAbSOYm2adzaoHsl60ow0Nd8TpsTMpo0ZiXALpAebZT2pOZ0AxLKVGg89JzVMdUdZNUeVplywxcCxMkuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009975; c=relaxed/simple;
	bh=z+FrTDDpCS5sBLXqT3PMNnGtVkxHHd/9OmfBSzShTHo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JeOEPF8shy96J1fcV79PCIiJOPTjUfw7rZxv3QaNuxS751muxvZlb6P6sB644XNkMt7goHHukjczdMcutsX1Se8wRUkWxJw7DTMDD2RwoygRDYhk8bwkr1d/MDOcINnAb/efgTPapfePta0QxJCAZtymXcrGi6XRejrhmJaCnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SAm9nyHt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L7cUuU021617;
	Thu, 21 Mar 2024 08:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Qa7Q5URf9WyJXmiA4bjGLM7ZuuZskXa385voHGR4D+Q=; b=SA
	m9nyHtAXh7j2drP1kxsrmDoFMD6R7TAiiYMYrvsS3TM4lYoTDtxBzN6PNzdBBUcx
	pKqFSF05ulinctD1TqS9SWt8j+Yqsaxd6loN/sncb91mIy8ievAV9iSgQonZSW06
	LqqSbXStLPs1RU0kDR+BTkm8BGDGH7svAW8Vy82a6EyPPs5LRfuJ8tqr0n+//0Mt
	n/ag8TqZmUvIcbiIxUSIWb2mdwosk88xupXazIYDn8JKWs5QjFFx9N1q8lNUeE0O
	C9Z7sRiqQWsxkNaUpeWsGCEKVqcNObvR93oVb79AM7cogF1+hvAOSSJpDCv8wCHO
	oJsnzrEWJi/czONj6oYQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0ecf0cju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:32:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L8WUSn009011
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:32:30 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 01:32:25 -0700
From: Tao Zhang <quic_taozha@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
Subject: [PATCH 0/4] Add support for multi-port output on the funnel
Date: Thu, 21 Mar 2024 16:32:03 +0800
Message-ID: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NFOT1mAxFAuCF5sCagxdGqdsYFU89aqZ
X-Proofpoint-ORIG-GUID: NFOT1mAxFAuCF5sCagxdGqdsYFU89aqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210057

Funnel can support multi-port output in our hardware design. Since original
funnels only support a single output connection, the code needs to be
modified to support this new feature. The following is a typical topology
diagram of multi-port output of the funnels.
|---------|    |---------|    |---------|    |---------|    |---------|
|  TPDM0  |    |  TPDM1  |    |  TPDM2  |    |  TPDM3  |    |  TPDM4  |
|---------|    |---------|    |---------|    |---------|    |---------|
    |               |             |               |              |
    |               |             |               |              |
    |               |             |               |              |
    |-----|   |-----|             |-----|   |-----|              |
          |   |                         |   |                    |
          |   |                         |   |                    |
       [0]|   |[1]                   [0]|   |[1]                 |
     \-------------/               \-------------/        \-------------/
      \  FUNNEL0  /                 \  FUNNEL1  /          \  FUNNEL2  /
       -----------                   -----------            -----------
       [0]|  |[1]                   [0]|   |[1]                  |
          |  |----------               |   |                     |
          |            |               |   |                     |
          |-------|    |      |------- |   |          |--------- |
                  |    |      |            |          |
                  |    |      |            |          |
               [0]|    |[1]   |[2]         |[3]       |[4]
           \ ---------------------------------------------------/
            \                     TPDA0                        /
             \                                                /
              ------------------------------------------------
For example, TPDM0 and TPDM1 are connected to the [0] and [1] input ports
of the funnel respectively, and output from the [0] and [1] output ports.
In this way, when data is output from the Funnel's output port, it needs
to know the source component corresponding to this output port. Our
solution is to add a property named "label" in the devicetree to mark the
source corresponding to the output port.
After introducing this new feature, another new problem also needs to be
solved. For example, TPDA driver will search for all the TPDMs on a input
port. In the topology diagram above, when TPDA searches for TPDM from the
input port[0], it will find TPDM0 and TPDM1. Our solution is to add a new
property named "qcom,tpda-input-port" to mark the input port number of the
TPDA in the devicetree.

Tao Zhang (4):
  dt-bindings: arm: qcom,coresight-funnel: Add label for multi-ouput
  coresight: Add support for multiple output ports on the funnel
  dt-bindings: arm: qcom,coresight-tpdm: Mark tpda input port number
  coresight-tpda: Add support multi-port input on TPDA

 .../arm/arm,coresight-dynamic-funnel.yaml     | 34 +++++++-
 .../bindings/arm/qcom,coresight-tpdm.yaml     |  8 ++
 drivers/hwtracing/coresight/coresight-core.c  | 81 ++++++++++++++++---
 .../hwtracing/coresight/coresight-platform.c  |  5 ++
 drivers/hwtracing/coresight/coresight-tpda.c  | 27 ++++++-
 include/linux/coresight.h                     |  2 +
 6 files changed, 139 insertions(+), 18 deletions(-)

-- 
2.17.1


