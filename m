Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61E880664F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 05:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376626AbjLFEiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 23:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFEiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 23:38:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3276118D;
        Tue,  5 Dec 2023 20:38:57 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B64UL4w018421;
        Wed, 6 Dec 2023 04:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=5ZlhSedtKp5MSUYC/YdyXwxoj0Vhrgsm+e3ENiLIsZ8=;
 b=XBKnr1oxvReLOHkxfBGTV/OzLIADZCg7XjBQRveSQZ8XcBmYrIQWzzy6DQlDjV8PvZr8
 wvyxXoz3rRgHHHUtU1RmQC0+F4CJQrgTFYdQlxFDlYIxteJ5l6UFhul6a2kjhm/ad9at
 eDQ0KJdTAVADo7JyjE/RGmhM+gttIohiZyGEMQCWeLRCBPovH+cs3d3rwM1L1IzdRLXW
 2jApoPjoL6/FVuWY3gkTUPO+bqZ4xRnTig7ozCXVQfvfPJ7Ph0qesLpk2AwFev3kqPBK
 9se3CVzzqS/k1Rx06i0OFz4qjiUzx/IMfrmf9oB2AYTxTo4judofn5jSNwSBuIi/kUMJ TQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utdeb8g8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 04:38:53 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B64cqmQ019188
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 04:38:52 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 20:38:52 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Tue, 5 Dec 2023 20:38:40 -0800
Subject: [PATCH] soc: qcom: stats: Express AOSS QMP module dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231205-qcom_stats-aoss_qmp-dependency-v1-1-8dabe1b5c32a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAM/6b2UC/x2NQQrCMBAAv1L27EIaDaJfESnbZLWBdpNmqyilf
 2/oceYws4Jyiaxwb1Yo/I0ak1RoTw34geTNGENlsMaeW2sczj5NnS60KFJS7eYpY+DMElj8H/n
 qjAvWuhtdoEZ6Usa+kPihZuQzjlXmwq/4O66P57btj3DBL4UAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701837532; l=1493;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=GJexMMIy2drjUp/kLm/O2CZm0PwgrK9hKbTlLPPjfa4=;
 b=iotaF5/HdpRGq58Bk0A6LIrVESdRYyqMd55TB+EwEeHI/hPos+TUfCDV7/pQegzrze5KL5YyzmCI
 vXyLfz+rAE4WTdKCeW/CIFSi00Pzlv8o4I3ZYX9IRfhC5z/yR5Lr
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ilv2Cq6Obl3TdZBCzZTgF5_W3EOlZGT1
X-Proofpoint-GUID: ilv2Cq6Obl3TdZBCzZTgF5_W3EOlZGT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_02,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1011 spamscore=0
 mlxlogscore=541 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060036
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case that the Qualcomm Sleep stats driver is builtin and the AOSS
QMP driver is built as a module, neither the implementation nor the stub
functions are available during linking, resulting in the following
errors:

  qcom_stats.c:(.text+0x33c): undefined reference to `qmp_send'
  qcom_stats.c:(.text+0x8a0): undefined reference to `qmp_get'

Resolve this by expressing the dependency between the two modules.

Fixes: e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/linux-arm-msm/202312061258.nAVYPFq2-lkp@intel.com/
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 2686fda9fe27..aa5956246f60 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -221,6 +221,7 @@ config QCOM_STATS
 	tristate "Qualcomm Technologies, Inc. (QTI) Sleep stats driver"
 	depends on (ARCH_QCOM && DEBUG_FS) || COMPILE_TEST
 	depends on QCOM_SMEM
+	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
 	help
 	  Qualcomm Technologies, Inc. (QTI) Sleep stats driver to read
 	  the shared memory exported by the remote processor related to

---
base-commit: adcad44bd1c73a5264bff525e334e2f6fc01bb9b
change-id: 20231205-qcom_stats-aoss_qmp-dependency-e7505d2259a4

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>

