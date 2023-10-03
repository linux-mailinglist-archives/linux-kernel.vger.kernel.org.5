Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792CA7B6601
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbjJCKEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjJCKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:04:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38110A6;
        Tue,  3 Oct 2023 03:04:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3939Cl3l003279;
        Tue, 3 Oct 2023 10:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=DJdu44NrpXLO9dNz78JvBBpLyr1AMk87QVg+T2ch4gs=;
 b=I7HCBRHWMp8yvyBzhlQi/PfD3Ry4qWiPJgvm0Ix9hpTR8xT6zmhMvVEByd88Q3h0mnov
 QawmiVpw/vvftYmwYX6TtOdR1tgYbD8LO7v95NnYpHY2/JScC0m6PjtX8sKRubYiT2h4
 qHjBiFV9OsQhjLaZi1cJVFYG4bFmz0tXnu8EIeQ1AGFm5J6sbhFOvqCXTXylJOKwdnP/
 qL80yXv3fGinpeGUUTVDhTVEo18UDOS40TtFCO6/XjHAyF9H6MiCH604yQaUU5wqISwR
 UM9I2vBYVaUVji1RNcXg0pqV6R3r9lC9oTrtHJ6C5D+AKGTTUU7txFlfudmrnVOaV77K GQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg9hdrtxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 10:04:38 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 393A4Ype032581;
        Tue, 3 Oct 2023 10:04:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tecrkqvra-1;
        Tue, 03 Oct 2023 10:04:34 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 393A4YGZ032567;
        Tue, 3 Oct 2023 10:04:34 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 393A4YZQ032564;
        Tue, 03 Oct 2023 10:04:34 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 00FE71EC4; Tue,  3 Oct 2023 15:34:32 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 0/3] Add devicetree support of Interconnects and USB for SDX75
Date:   Tue,  3 Oct 2023 15:34:29 +0530
Message-Id: <1696327472-21776-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A5PFekzuwFqMtvYpe_H9Ax7sHLqlFNSU
X-Proofpoint-GUID: A5PFekzuwFqMtvYpe_H9Ax7sHLqlFNSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=437 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310030070
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v3:
 - Using macro QCOM_ICC_TAG_ALWAYS instead of 0 in interconnects properties.
 - Collected reviewed by tag.

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
 arch/arm64/boot/dts/qcom/sdx75.dtsi    | 170 +++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)

-- 
2.7.4

