Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B567581BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjGRQJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjGRQJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:09:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7EBE0;
        Tue, 18 Jul 2023 09:09:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IBeNPb018133;
        Tue, 18 Jul 2023 16:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=NK+gRZ6OyFYwmAlmM+zt1RKS/RzKZtsNHuw7Z/F1nw0=;
 b=lPc1njf/VebIGOoJIk3RFtn+pD2kHQVNuzaevfS/YnBUz//BYyjvksMdxgveRAQ7pQgG
 ZJc2ba/So856ZvxOASnpI05XRytyHwtTTYzHtr6YmO6/Atl2OoASLFXBYVQ8gJdqr7PH
 oBPx2LMvJNCqmmOhqQC/FjzUKDrZumrjcYiRW1NPu0LGEkKi3kswsv7h+va0vR4qnUQR
 FpM98Mci1IzvI1fsiXJE7x75ZHnQobPao6hkoTZHQkeculaIwGGzZcVU05FzgXt0wdAq
 KGhRxIAM37aPhwx+9cOuzcyvuG2534f99Sz8bx6kMd380Q5ZrVM+ETk45lwCc+rDZEbu lw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwk5bhn19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 16:08:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IG8sCl019301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 16:08:54 GMT
Received: from car-linux11.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 09:08:54 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH 0/2] Add qcom hvc/shmem transport
Date:   Tue, 18 Jul 2023 09:08:31 -0700
Message-ID: <20230718160833.36397-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6rmYNnerBMpV9txQAKXezA-5cByqEiE-
X-Proofpoint-ORIG-GUID: 6rmYNnerBMpV9txQAKXezA-5cByqEiE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_12,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change introduce a new transport channel for Qualcomm virtual
platforms. The transport is mechanically similar to ARM_SCMI_TRANSPORT_SMC.
The difference between the two transports is that a parameter is passed in
the hypervisor call to identify which doorbell to assert. This parameter is
dynamically generated at runtime on the device and insuitable to pass via
the devicetree.

The function ID and parameter are stored by firmware in the shmem region.

This has been tested on ARM64 virtual Qualcomm platform.

Nikunj Kela (2):
  dt-bindings: arm: Add qcom specific hvc transport for SCMI
  firmware: arm_scmi: Add qcom hvc/shmem transport

 .../bindings/firmware/arm,scmi.yaml           |  69 +++++
 drivers/firmware/arm_scmi/Kconfig             |  13 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 drivers/firmware/arm_scmi/common.h            |   3 +
 drivers/firmware/arm_scmi/driver.c            |   4 +
 drivers/firmware/arm_scmi/qcom_hvc.c          | 241 ++++++++++++++++++
 6 files changed, 331 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/qcom_hvc.c

-- 
2.17.1

