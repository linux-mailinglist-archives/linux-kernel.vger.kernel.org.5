Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349A97694E3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjGaLaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjGaLa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:30:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86517C3;
        Mon, 31 Jul 2023 04:30:25 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V68SqC022220;
        Mon, 31 Jul 2023 11:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=KopAFqbVBRVum9kb/c+ANhFtwvlP5h+ZavRB4Cnvcss=;
 b=mUANnaeAthBaRynxtA5HR/tGHsVOBsepSrL+8Gro695pJpbop2IS+b6q8+Txvu8NDCqL
 e5durRf/74Pb3VOB2+kuRGCw9DimejOXJ8XdrL8jv2xQHFDLZn1JggoDO2DE7kqHW5Ho
 cB72NHNfJNw0y6os7JNkcpkz3MqlL3Uq6sc+RceT7exFegGnSPj8jKs5AXu1pFQ95bo5
 TQl5Rw2JiSQ8UfVzj+N2YkIOuBMhnFtZJp1hUhY2rycumrC2QX+NAFx6GfBAAwXJbWPX
 0J4k9QouEdHKGdcs6n4u95aTKLob8gGouoIrihim4YCwU7VaZRW5VWq65iljhQJHRv6o uw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uat3hdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:30:19 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36VBUGeW027295;
        Mon, 31 Jul 2023 11:30:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s4uuke9rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 31 Jul 2023 11:30:16 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VBUF7o027272;
        Mon, 31 Jul 2023 11:30:15 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36VBUFVI027260;
        Mon, 31 Jul 2023 11:30:15 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id DA0E31A69; Mon, 31 Jul 2023 17:00:14 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v4 0/2] Add rpmhpd support for SDX75
Date:   Mon, 31 Jul 2023 17:00:05 +0530
Message-Id: <1690803007-8640-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zX4vxkmxw4IsQAzZ0oUOcoOTI_4b1qgq
X-Proofpoint-GUID: zX4vxkmxw4IsQAzZ0oUOcoOTI_4b1qgq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_05,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=741 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310103
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v4:
 - Moved the generic bindings patch to a separate series [4].
 - Corrected the subject of dt-bindings patch.

Changes in v3:
 - Removed the macros from rpmpd.h and created new generic
   bindings in patch [1/3] for rpmhpd only.
 - Corrected the versioning in this version of patch series.
 - Updated the patch series subject.
 - Updated the drivers change according to the new binding in
   patch [3/3]

Changes in v2:
 - Link to v2 series [1] (Added because of versioning mismatch).
 - Breaking the original series [2] into smaller series.
 - Added new generic bindings for rpmpd and rpmhpd keeping the
   older ones intact as removing them would break ABI [3].

This series adds the support of rpmhpd for sdx75 and also
adds the generic bindings for the PD to be used henceforth.

[1] https://lore.kernel.org/all/1688647793-20950-1-git-send-email-quic_rohiagar@quicinc.com/
[2] https://lore.kernel.org/all/1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com/
[3] https://lore.kernel.org/all/1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com/
[4] https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.

Rohit Agarwal (2):
  dt-bindings: power: qcom,rpmpd: Add compatible for sdx75
  soc: qcom: rpmhpd: Add SDX75 power domains

 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/soc/qcom/rpmhpd.c                               | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

-- 
2.7.4

