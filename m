Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBFD7CC497
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJQNUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbjJQNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:19:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8633310D;
        Tue, 17 Oct 2023 06:19:45 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HD7r7m005672;
        Tue, 17 Oct 2023 13:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=NeT+IRRuva6DpKf1d3DVM+LAzJk7rHkcj0Io7+v/HYY=;
 b=VYAGxS60/dK4hI97FRD4Lmmc6y4gcce1kEla4froM0dEdsTrfmGd4P0iBIMC9hfCidIV
 Kq4Dqhvd/sVYs8IIBedfjoaFOpKEpS7KVT1WRVObwwF0tmJtozRVx5ViN5pcnWHyG8HA
 WLLfi6JyAH5/IEKB4qwvVLvaphRJim65i38w/tYFevUctVRJtflcmcRk5/vQWXFIca+0
 rvMmczBrUljsyPuXLznSZZ0B+jGjbAGIvbuDpg2juqjzmZu837bUBHGFAJILLGLbAbZA
 YJFiEQkgS8NlAiKo5uFw6ZIPxtMGLYex7CNtz6caggggjGOEpC6oBiddir2x9JhNkhtQ vA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tstv9r0v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:19:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HDJbJb009518
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:19:37 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 06:19:32 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <quic_wcheng@quicinc.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC 7/8] arm: dts: qcom: Enable runtime for SM8450 QRD
Date:   Tue, 17 Oct 2023 18:48:50 +0530
Message-ID: <20231017131851.8299-7-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131851.8299-1-quic_kriskura@quicinc.com>
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OPQNKBZ_sU67acFWmnqY8aHU4VFZHiYT
X-Proofpoint-ORIG-GUID: OPQNKBZ_sU67acFWmnqY8aHU4VFZHiYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=450 impostorscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable runtime and wakeup source for SM8450 QRD platform.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index aec47e45284e..d3e8fe7a37ec 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -490,6 +490,9 @@ &usb_1 {
 
 	dr_mode = "otg";
 	usb-role-switch;
+
+	qcom,enable-rt;
+	wakeup-source;
 };
 
 &usb_1_dwc3_hs {
-- 
2.42.0

