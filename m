Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE357AB149
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjIVLvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjIVLvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:51:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6021100;
        Fri, 22 Sep 2023 04:51:30 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M9DiEE017906;
        Fri, 22 Sep 2023 11:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=1+AKX+rqRYizEhUeZUvPc6CNQXUhdtnOWFBRpuI8OZM=;
 b=ghZrDaZ2ruvFt+0CMaz94xiCTPMGMhXfcRF9b8QueZhWwHQ7GqGxtE33ITg7ayFv/AlR
 yhi+ASwyj/GnhwQWSDk6tCyqJmNlY1RjTqiPHdlOXi0vH5n6bM/zcBP1kAimy2knwpD3
 D7dnQWPCQAabUcLigsdh0q5qMkuwSA0esWnfBITOC1tzpFoNkNGBggrbX5X51nMk3JWx
 62IGzf/SI4qZWTFtN1G9WNEpnhF288izVR6xNMrq5/8M6Znq+6Vsb1nK8EehzRhAV26G
 4v78CVi90dJScuztyMX97aOQx1yqREcIK1tQOqG5P9aWF3nVgpke50W9ZicAeQvWX1w0 HA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8um1sq5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:21 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38MBobHF027221;
        Fri, 22 Sep 2023 11:51:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3t55emanca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MBpHEZ027858;
        Fri, 22 Sep 2023 11:51:17 GMT
Received: from win-platform-upstream01.qualcomm.com (win-platform-upstream01.qualcomm.com [10.242.182.84])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 38MBpHTN027852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:17 +0000
Received: by win-platform-upstream01.qualcomm.com (Postfix, from userid 330701)
        id 8488A984; Fri, 22 Sep 2023 17:21:16 +0530 (IST)
From:   Sricharan R <srichara@win-platform-upstream01.qualcomm.com>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        quic_srichara@quicinc.com
Subject: [PATCH V3 0/4] Add support for IPQ5018 tsens
Date:   Fri, 22 Sep 2023 17:21:12 +0530
Message-Id: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dv-dBlnYdfCKT3Gd0qqovlnjX-_4v_rr
X-Proofpoint-GUID: Dv-dBlnYdfCKT3Gd0qqovlnjX-_4v_rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_09,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=772 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1034 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 has tsens V1.0 IP with 4 sensors and 1 interrupt.
There is no RPM present in the soc to do tsens early enable.
Adding support for the same here.

[v3]
	*) Added the tsens-ipq5018 as  new binding without rpm
        *) Added Dmitry's Reviewed tag
        *) Fixed Dmitry's comments for error checks in init_ipq5018
        *) Ordered the qfprom device node properties

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

 .../bindings/thermal/qcom-tsens.yaml          |   4 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c               |  60 +++++++
 drivers/thermal/qcom/tsens.c                  |   5 +-
 drivers/thermal/qcom/tsens.h                  |   5 +-
 5 files changed, 241 insertions(+), 2 deletions(-)

-- 
2.34.1

