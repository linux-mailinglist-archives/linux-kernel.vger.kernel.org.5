Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CAC7A1E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjIOMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjIOMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:15:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6630F268E;
        Fri, 15 Sep 2023 05:15:43 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FAA7Pj030278;
        Fri, 15 Sep 2023 12:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=GygQ/u2fnwhNWv//DRS3iWa9bJQ4jyMvttmcZQRrUJg=;
 b=DdtCcGLs8TKoe/KOIvsB1ZfgOgVOOBAdBOAep0EsPgU21Yf5Pja5owrONHSiA5qrxxsj
 vllQSYAAXQ5NZ/xgQtJyXrriIi38alYxp3H9S/k8ZfwEghIz1RAAuCp8ulMaTHuC3EPT
 bA2x6f5CiFDO0XR1BlvtiAnLus/jswrMZIXVwysBHUPnUUYnHgdNTTpdRb12AHpleQeZ
 2t6cDr/yi0ph3D/SlPPMXyT+PyDI0zvted6m4H5j/UEa2czDRcPqacJ+BTwwvK1Cc0FZ
 /9432VfgopUICnqQvKz3KGYwMDU7LIZ5Ep5aQC/3dPI00u6zXiKGiXna9Ejv5NwsGPvr sg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g5tgvw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:15:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FCFZTV004488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:15:35 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 05:15:31 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH V2 0/4] Add support for IPQ5018 tsens
Date:   Fri, 15 Sep 2023 17:45:00 +0530
Message-ID: <20230915121504.806672-1-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 05c275zDFas4SN5Locq7WA02D42AB1JN
X-Proofpoint-GUID: 05c275zDFas4SN5Locq7WA02D42AB1JN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_08,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=644 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 has tsens V1.0 IP with 4 sensors and 1 interrupt.
There is no RPM present in the soc to do tsens early enable.
Adding support for the same here.

[v2]
	*) Sorted the compatible and removed example
	*) Fixed the name for new tsens_feature
	*) Used tsend_calibrate_common instead of legacy
	   and addressed comments from Dmitry.
	*) Squashed patch 3 & 4
	*) Fixed node names, order and added qfprom cells
            for points seprately
	*) Squashed patch 6 & 7 

Sricharan Ramabadhran (4):
  dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
  thermal/drivers/qcom: Add new feat for soc without rpm
  thermal/drivers/tsens: Add support for IPQ5018 tsens
  arm64: dts: qcom: ipq5018: Add tsens node

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c               |  58 ++++++
 drivers/thermal/qcom/tsens.c                  |   5 +-
 drivers/thermal/qcom/tsens.h                  |   5 +-
 6 files changed, 237 insertions(+), 2 deletions(-)

-- 
2.34.1

