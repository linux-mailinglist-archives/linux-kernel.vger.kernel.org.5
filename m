Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4187D6E43
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbjJYOAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjJYOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:00:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5303B132;
        Wed, 25 Oct 2023 07:00:13 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDPOqq011628;
        Wed, 25 Oct 2023 14:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=G4GgJfR9dckI432uLf8DhH6mErgC9HcrRLZOBk4jvyc=;
 b=JeNbtQH6VlKX1hY7hPZvPIgLG7CSov/vov8RIAHnus9u/FSUHYszoIvc0l/Klkcm0XPs
 gT274UykOtQdvZHOvZdgQs0vFPEYFs9vwQXhfawiiOcy/YLQd6mWtozSyrbB1MjwSJ3X
 1aQQvTROgjYveA/7/IVjzbZUpQC/ytZV9BHrwUdQntOtTQgG2QEqZyKbIx2V7c3EtTu6
 YnietgqkmA33qAYkhwZ2Vg0T+XSpMcSH9+8tRbNPC5bIEJnUrlKrM7TlpA6s2fexjg5R
 NZBjKdT87WW83pfatKgcHK3guCnzZmB0pDuDDX7faV9j7vUf+MuytJ85G8CIHfbzmO2Z iA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txtw1h2td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:00:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PE08IC028998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:00:08 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 07:00:03 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 0/3] pmdomain: qcom: Add power domain support for SC8380XP
Date:   Wed, 25 Oct 2023 19:29:40 +0530
Message-ID: <20231025135943.13854-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9kRE8W7qrrQzxiPMnQo__psX7L8DSLH7
X-Proofpoint-GUID: 9kRE8W7qrrQzxiPMnQo__psX7L8DSLH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=782
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds power domain support for the Qualcomm SC8380XP platform, aka Snapdragon X Elite.

Dependencies: None
Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat

Abel Vesa (2):
  dt-bindings: power: rpmpd: Add SC8380XP support
  pmdomain: qcom: rpmhpd: Add SC8380XP power domains

Sibi Sankar (1):
  dt-bindings: power: qcom,rpmhpd: Add GMXC PD index

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                | 28 +++++++++++++++++++
 include/dt-bindings/power/qcom,rpmhpd.h       |  1 +
 3 files changed, 30 insertions(+)

-- 
2.17.1

