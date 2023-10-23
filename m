Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51817D2E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJWJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjJWJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:21:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B043D79;
        Mon, 23 Oct 2023 02:21:35 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N9KKId003789;
        Mon, 23 Oct 2023 09:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tadKhoGkTAuofCfIxeBedER4iY9EPbmpdtbegz6s/S4=;
 b=Vz0RWVXvvcs3qv22abgP+h/aGw4Ej0XfFrSS3UXtIOb0Ic4Dr0Bat7KFrp7vRV+1n83z
 90TDhdG60JC1coKqlwFZGwEwKghDxdYGgi2Ny0QonqTMIFfDdO6BmenGGXwQrTxXtApb
 AKjQy5RblUnxZ7vcE7MiNObH6OVZCr2M6WqEnUMevXp00MOWEMBKkbxEJHpxDbONMUwG
 2ABY+7ZiSLMB3WBYaZLIdNloy6R7FsIvQ7+qhbOz25NRATguXLXAEC+Bc4bYO+llbowQ
 HxKvdX5qvuHL21SlD+yyBlUIs4F/F5bzu0sa6k1wHNSD9Gik7sHEKaoX+WXko76yxWQt og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twp3vg03c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:21:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N9LWpY014338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:21:32 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 02:21:27 -0700
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH v1 4/5] arm64: defconfig: enable Qcom Memory Dump driver
Date:   Mon, 23 Oct 2023 17:20:56 +0800
Message-ID: <1698052857-6918-5-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: snygaL2k99inW0Sv_PKC3NzIB5rU0nkT
X-Proofpoint-ORIG-GUID: snygaL2k99inW0Sv_PKC3NzIB5rU0nkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=348
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Qcom Memory Dump driver to allow storing debugging
information after crash by firmware, including cache
contents, internal memory, registers.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5315789..99a8c81 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1301,6 +1301,7 @@ CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_CPR=y
 CONFIG_QCOM_GENI_SE=y
 CONFIG_QCOM_LLCC=m
+CONFIG_QCOM_MEMORY_DUMP=y
 CONFIG_QCOM_OCMEM=m
 CONFIG_QCOM_PMIC_GLINK=m
 CONFIG_QCOM_RMTFS_MEM=m
-- 
2.7.4

