Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF46760989
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjGYFmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjGYFmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:42:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCA19AA;
        Mon, 24 Jul 2023 22:42:33 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P50stf011612;
        Tue, 25 Jul 2023 05:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UcuJkSPVewAq2mQMO/8R/716GP8gL4S9D4isQKyMuk0=;
 b=fTtK8WCxDI/T5GxBH4yvfmagLnc2QF+gLKahnq0abpcOyx8pTQQfVRqbfqBX7YBX+J75
 vn+IHEwerpeK7ivnz+IbZO0Z2OfcbxeSooRil56AzlXTIPYZbOJIM4u/LlaCWsYlpcvQ
 qPE9BVg13rybxhdDRWCYsahdD//pf0mfApRPFu4IDVVczAIx72m+shPyxIiA+q/gIL2P
 ErkkisA+1WBUwfcdP+mUIR42ZsAaGAchvCPW+ZMbr/KAIBi80TElpBqe9cx5NbmpjwPH
 6LjPuZcQfWzcqHePKBWHgvwxAuh0lWxgYipTD5FSrhPl588btwy8NfI9Db7Wmpg0RR2B Wg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1sr71um2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:42:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P5gTC7030057
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:42:29 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 22:42:26 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>, <quic_kamalw@quicinc.com>,
        <jestar@qti.qualcomm.com>
Subject: [PATCH v3 0/3] Add support for vibrator in multiple PMICs
Date:   Tue, 25 Jul 2023 13:41:35 +0800
Message-ID: <20230725054138.129497-1-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bNxHtt2ujnse05vU_qQXvOc4Kkmhq_1A
X-Proofpoint-ORIG-GUID: bNxHtt2ujnse05vU_qQXvOc4Kkmhq_1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=803 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250051
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SW support for the vibrator module inside PMI632, PM7250B, PM7325B, PM7550BA.
It is very similar to the vibrator module inside PM8916 which is supported in
pm8xxx-vib driver but just the drive amplitude is controlled with 2 registers,
and the register base offset in each PMIC is different.

Changes in v3:
  1. Refactor the driver to support different type of the vibrators with
    better flexibility by introducing the HW type with corresponding
    register fields definitions.
  2. Add 'qcom,spmi-vib-gen1' and 'qcom,spmi-vib-gen2' compatible
    strings, and add PMI632, PM7250B, PM7325B, PM7550BA as compatbile as
    spmi-vib-gen2.
 
Changes in v2:
  Remove the "pm7550ba-vib" compatible string as it's compatible with pm7325b.

Fenglin Wu (3):
  input: pm8xxx-vib: refactor to easily support new SPMI vibrator
  dt-bindings: input: qcom,pm8xxx-vib: add new SPMI vibrator module
  input: pm8xxx-vibrator: add new SPMI vibrator support

 .../bindings/input/qcom,pm8xxx-vib.yaml       |  18 +-
 drivers/input/misc/pm8xxx-vibrator.c          | 167 ++++++++++++------
 2 files changed, 126 insertions(+), 59 deletions(-)

-- 
2.25.1

