Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5F27AE93C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjIZJ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjIZJ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:29:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3668F101;
        Tue, 26 Sep 2023 02:29:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q4UkTt028789;
        Tue, 26 Sep 2023 09:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=YD6TNBb0PH+pJri9BpRNJOaNzubtn2YqRwEMYMRp5Y8=;
 b=DWUN/FOxYpnqHbdvXbd7Zln7oiZy92IVHvggmFDSG+ta+jQayMVLxrlOxyXI2BT5iEdy
 Ley3ZwzoV1i0u5rkk05BCgLPNZL127H6pXy5D1SvjoJqtwc5j4MFt0VCD3mcDSBHr4z0
 1/AB3xf2B/5ges1sRmTaq37s1Di+Ako3eLnuXRbfedYsodoJR/FYMir7KMOw2ECkMB1m
 cjc6TdySP3FUpGTOF/uI75YjfiNQnrG56uEyOaDXghKIXKRUo3X4x9g1vgKEPMWooDcC
 0s31dIyh13s75xs+J+Fp1bBy40dbKqaWR5epVIXTFP4N3G8J8epBI9AbWHfJlN+XARPQ qw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbbyf28hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 09:29:31 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38Q9TRfE001613;
        Tue, 26 Sep 2023 09:29:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t9s3knfx0-1;
        Tue, 26 Sep 2023 09:29:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38Q9TRtf001598;
        Tue, 26 Sep 2023 09:29:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38Q9TQMT001596;
        Tue, 26 Sep 2023 09:29:27 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id C3DBB1E52; Tue, 26 Sep 2023 14:59:25 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 0/3] Add devicetree support of Interconnects and USB for SDX75
Date:   Tue, 26 Sep 2023 14:59:21 +0530
Message-Id: <1695720564-2978-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NnvIhph6yJNR-luuyuhP_AUXPHc8duta
X-Proofpoint-ORIG-GUID: NnvIhph6yJNR-luuyuhP_AUXPHc8duta
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxlogscore=298 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309260082
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v2:
 - Updated the commit subject of patch 2/3.

This series adds devicetree nodes to support interconnects and usb for sdx75.
This is based on previously sent driver series[1], [2].

[1] https://lore.kernel.org/all/1694614256-24109-1-git-send-email-quic_rohiagar@quicinc.com/
[2] https://lore.kernel.org/all/1695359525-4548-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.


Rohit Agarwal (3):
  arm64: dts: qcom: Add interconnect nodes for SDX75
  arm64: dts: qcom: Add USB3 and PHY support on SDX75
  arm64: dts: qcom: sdx75-idp: Enable USB3 and PHY support

 arch/arm64/boot/dts/qcom/sdx75-idp.dts |  29 ++++++
 arch/arm64/boot/dts/qcom/sdx75.dtsi    | 164 +++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+)

-- 
2.7.4

