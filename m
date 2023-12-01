Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60BF800786
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378122AbjLAJut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377899AbjLAJuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:50:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9DDE6;
        Fri,  1 Dec 2023 01:50:53 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B17cmRN008763;
        Fri, 1 Dec 2023 09:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Tl8IqY6Kcy0jW57meklkeqwCcOwDWbiHTS215GP0cXc=;
 b=Js6ET2CqaUlQVCdN43TEryUesuBgHzTPp+d3Zb4Sisgg/53Bt7x+D+Q/upBiBiv1k3FP
 poSprU0DWal7fDPuyRHzZMnb+Oib7pFCxhMCVaIFpYfXk6ihSC+TcmRb3aGNEpw0dTXA
 LuH3cqXXTAvjT70oAZZ8cuv2znk3LZrqG9niFIOMjGuqb1h1SbMGj6EW5cJJWIkUxtIS
 pgYXD+mY8PuMNH0k5s2IjPQu7PrUdyrjKJLjzmxclm/58cdQyhkrreMvbHDJmdOuh6By
 EpX91gjp9PXb06MqvglufFwB4a+aOfsNBL1RRqba7iwcT2u9/sZTzcm1ZFLk+zGVHvxI qA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uq3f7s6dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 09:50:49 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B19omZW006757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 09:50:48 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 01:50:44 -0800
From:   Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date:   Fri, 1 Dec 2023 15:20:26 +0530
Subject: [PATCH v3 3/4] clk: qcom: videocc-sm8150: Add missing PLL config
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231201-videocc-8150-v3-3-56bec3a5e443@quicinc.com>
References: <20231201-videocc-8150-v3-0-56bec3a5e443@quicinc.com>
In-Reply-To: <20231201-videocc-8150-v3-0-56bec3a5e443@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j5DM2gxt_pYozLFxZlNmB62a4wnILtS4
X-Proofpoint-GUID: j5DM2gxt_pYozLFxZlNmB62a4wnILtS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_07,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=983 bulkscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver was ported upstream, PLL test_ctl_hi1 register value
was omitted. Add it to ensure the PLLs are fully configured.

Fixes: 5658e8cf1a8a ("clk: qcom: add video clock controller driver for SM8150")
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 drivers/clk/qcom/videocc-sm8150.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
index 6a5f89f53da8..52a9a453a143 100644
--- a/drivers/clk/qcom/videocc-sm8150.c
+++ b/drivers/clk/qcom/videocc-sm8150.c
@@ -33,6 +33,7 @@ static struct alpha_pll_config video_pll0_config = {
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00002267,
 	.config_ctl_hi1_val = 0x00000024,
+	.test_ctl_hi1_val = 0x00000020,
 	.user_ctl_val = 0x00000000,
 	.user_ctl_hi_val = 0x00000805,
 	.user_ctl_hi1_val = 0x000000D0,

-- 
2.25.1

