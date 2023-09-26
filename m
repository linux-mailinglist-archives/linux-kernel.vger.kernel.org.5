Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D867AE880
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjIZJAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIZJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:00:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D4DD;
        Tue, 26 Sep 2023 02:00:28 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q4kQGv025635;
        Tue, 26 Sep 2023 09:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=gvCQTCR/NydbDHGjQ2qfSwSTxf+YX72vUpmHW0UtVCw=;
 b=OrEI4jCLOf4d7agg/8+w2A7X2oGPT4Pdf1Nv3Wj3fmq4r1H0QmCWUEEI20FencZm/1i+
 wTOfsDvOJHYMDKXPPrqiXKYfRzRt/SCH1wvy+bNyL42hmDB/v8t7iPP/sGXaHeOxGhGE
 BXiD0s+aWrhKUORq784aBX80DnHPlrDQG1hzcS7YoN4KY33M0uvt2jESztVfjxE5m6Zw
 cD2JzsGrPE1pgwvbvY3lb/orbsVgfwGa7bIMGuDwflLD5BeY+1nTDiIzc7/Tc3o0uHQW
 SAqG9svwmBTtLxp7Knxrl067BRfwbo3kcWbcXBHqHsbhKY+4iWI9G066vob7gkkTfeHR cA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbh25h7vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 09:00:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q90KNv024341
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 09:00:20 GMT
Received: from hu-priyjain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 02:00:12 -0700
From:   Priyansh Jain <quic_priyjain@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_manafm@quicinc.com>, <quic_priyjain@quicinc.com>,
        <kernel@quicinc.com>
Subject: [PATCH v2 0/2] Enable tsens and thermal for sa8775p SoC
Date:   Tue, 26 Sep 2023 14:29:46 +0530
Message-ID: <20230926085948.23046-1-quic_priyjain@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZDcfSJX9FAT4pdWoM8sqex-HGrpANbG-
X-Proofpoint-ORIG-GUID: ZDcfSJX9FAT4pdWoM8sqex-HGrpANbG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxscore=0 mlxlogscore=793
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding compatible string in TSENS dt-bindings, device node
for TSENS controller and Thermal zone support

Changes since v3:
- Correct the unit address of tsens node
- Updated tsens nodes in sorted order by address
- Moved thermal zones outside /soc node

Changes since v2:
- Indentation mistakes are resolved
- Updated offset of tsens srot region in reg property
- Updated tsens reg property cells properly


Priyansh Jain (2):
  dt-bindings: thermal: tsens: Add sa8775p compatible
  arm64: dts: qcom: Enable tsens and thermal for sa8775p SoC

 .../bindings/thermal/qcom-tsens.yaml          |    1 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 1096 +++++++++++++++++
 2 files changed, 1097 insertions(+)

-- 
2.17.1

