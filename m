Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F6792BD3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbjIERBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348616AbjIEEoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:44:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119CCC7;
        Mon,  4 Sep 2023 21:44:09 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3854SVRs027202;
        Tue, 5 Sep 2023 04:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=+X5Uesm0llKqCoNL/0vF3pB+UsjNNWAzmz9Idy6g96c=;
 b=TXxTZ3G5GznamcheUKDvfZzMH3msE27Zv76+tUkiBW8G/VbZ4IhG5zuYbUj/kVOlklIo
 MnUUr1UwEmA57MLn8iyp2wMcWkkHFYe/8JfhotejqWKyFov3ZwDk1Nn9UqgFRbBOXjDC
 Ylv3BcJG96boRJQbuPidCpL6QHjarpneOUP6EGYIENp9bb5H7aIHq+VQ/Psu1FE5H0EC
 vbsy2Ieiib3wazhVvQyfG1a1MBf0Z9sajbRbuI5P781cMG3RUkFp+XxQgLXE0pEtjVQj
 /c0+pgis4xecvxmN0FmyOmrSE8VI0GfGDmIMEdEr5iGljWHQj2F/ERo2Ud4dPNQFuDKX dQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swpr6ggab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:43:55 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3854hp6b013087;
        Tue, 5 Sep 2023 04:43:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kav14-1;
        Tue, 05 Sep 2023 04:43:51 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3854hp9c013081;
        Tue, 5 Sep 2023 04:43:51 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3854hp7P013080;
        Tue, 05 Sep 2023 04:43:51 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 54FBE1D04; Tue,  5 Sep 2023 10:13:50 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/5] Add USB Support on Qualcomm's SDX75 Platform
Date:   Tue,  5 Sep 2023 10:13:43 +0530
Message-Id: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k84bsobKjY3Q1GS3RNdcdMaeK4nR1BTX
X-Proofpoint-GUID: k84bsobKjY3Q1GS3RNdcdMaeK4nR1BTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_02,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=432 clxscore=1011 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309050040
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support of USB3 PHY support for Qualcomm's SDX75 Platform.

Thanks,
Rohit.

Rohit Agarwal (5):
  dt-bindings: phy: qcom,snps-eusb2-phy: Add compatible for SDX75
  dt-bindings: phy: Add qcom,sdx75-qmp-usb3-uni schema file
  dt-bindings: usb: dwc3: Add missing SDX65 compatible
  dt-bindings: usb: dwc3: Add SDX75 compatible
  phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support

 .../bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.yaml  | 106 ++++++++++++++
 .../bindings/phy/qcom,snps-eusb2-phy.yaml          |   7 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   4 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 160 +++++++++++++++++++++
 4 files changed, 276 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sdx75-qmp-usb3-uni-phy.yaml

-- 
2.7.4

