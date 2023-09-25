Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A3D7AD359
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjIYIaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjIYIaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:30:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EAEFC;
        Mon, 25 Sep 2023 01:30:00 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P4xcYp021373;
        Mon, 25 Sep 2023 08:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=N6aWaUoYHhym6q1tyn3LRmP8Pw+KrkZCZ9h7duFCjWQ=;
 b=G2K8JSbZKrXqt8LmueIDfwFRL2BihQ62XglnhIjR/sHcIxiB++nf+RcArHxgnDq+bOBE
 2Zert5qIV7iwRFdY0RrfWln5EOWb5xgwiIOT50QMrxbDy8OA/7QSnwoF234ClBDEWbcb
 C1hkwkvCo4RCUgHjeZmeLieHe9DUCZpEqD8qIlAeh374NaT2lCpsO8twAbJZkvu1/NPx
 TDBTFyFE7RZNa7a3FPvu/jHfclmTj/5l5ODizsyTE3ZIys/gpaq1ER/KlMySyhq5LRBA
 oKD4XShoWtV3kpOE2tmEed1Tljq0Zb+Z7QH1YsZuYGhcjemElHJpLsKE0xY8ZlovpR+t pA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb3hfrnf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 08:29:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P8TXa5012793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 08:29:33 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 25 Sep 2023 01:29:31 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Mon, 25 Sep 2023 13:59:22 +0530
Subject: [PATCH v3] firmware: qcom_scm: use 64-bit calling convention only
 when client is 64-bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230925-scm-v3-1-8790dff6a749@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOFEEWUC/0XMQQ6CMBCF4auQri0ppYXgynsYY8ow2IlpwSkSE
 8LdLW5cfnkv/yYSMmES52ITjCslmmJGfSoEeBcfKGnIFlrpWnXaygRBDo2GBoaqM20v8rN3CWX
 PLoI/vsGlBfkYZsaRPr/89ZY98hTk4hndP9qoVhlbG1tqq0wnK/l6E9yfbvHEbr0cogglTEHs+
 xcEWzrysQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695630571; l=2034;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=ChQa/Bb1LGd9JUoVHYCpu+dhnFDE745UH//nDZnjRGo=;
 b=5JtAXE60/zRvqiEexLfPMutKkzAGfsHRUZt5ZL+ThVooGdSm3qPATJbR6MkXih5aQ/OOUAXcV
 /2u8eRhs7raDC3SXEQnn8jrojSBWnWXuOgrPr806ym34sfuzu2sMzN1
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bZY13A6LY6Uh6VwdLHgN1u9ldvjgh7yy
X-Proofpoint-ORIG-GUID: bZY13A6LY6Uh6VwdLHgN1u9ldvjgh7yy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the "SMC calling convention specification", the 64-bit calling
convention can only be used when the client is 64-bit. Whereas the
32-bit calling convention can be used by either a 32-bit or a 64-bit
client.

Currently during SCM probe, irrespective of the client, 64-bit calling
convention is made, which is incorrect and may lead to the undefined
behaviour when the client is 32-bit. Let's fix it.

Cc: stable@vger.kernel.org
Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and legacy conventions")
Reviewed-By: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in V3:
	- reworded the commit title and msg
	- pick up the R-b tag

Changes in V2:
	- Added the Fixes tag and cc'd stable mailing list
---
 drivers/firmware/qcom_scm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index c2c7fafef34b..520de9b5633a 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -215,6 +215,12 @@ static enum qcom_scm_convention __get_convention(void)
 	if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
 		return qcom_scm_convention;
 
+	/*
+	 * Per the "SMC calling convention specification", the 64-bit calling
+	 * convention can only be used when the client is 64-bit, otherwise
+	 * system will encounter the undefined behaviour.
+	 */
+#if IS_ENABLED(CONFIG_ARM64)
 	/*
 	 * Device isn't required as there is only one argument - no device
 	 * needed to dma_map_single to secure world
@@ -235,6 +241,7 @@ static enum qcom_scm_convention __get_convention(void)
 		forced = true;
 		goto found;
 	}
+#endif
 
 	probed_convention = SMC_CONVENTION_ARM_32;
 	ret = __scm_smc_call(NULL, &desc, probed_convention, &res, true);

---
base-commit: 8fff9184d1b5810dca5dd1a02726d4f844af88fc
change-id: 20230925-scm-d62c6cd1947b

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

