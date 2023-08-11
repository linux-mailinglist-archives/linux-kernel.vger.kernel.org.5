Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4644E779900
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjHKU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjHKU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:58:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20020AC;
        Fri, 11 Aug 2023 13:58:57 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BFv8c6030614;
        Fri, 11 Aug 2023 20:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ocBL6WvaPHNqepT1/1W6t2OGIE0NG1oxBH11m7Mfs1w=;
 b=jew/Jpyf82ZAcXm3hWygc9qCaeda7oSjLfgX69rYiDmPMrd2ufh0V3cLaIxSEsZ/53QA
 Qu5fYPrcEHsoojjEUojEZ7hhGbDtz0vPcblgpjeXOi0lUMZ284ADBubVsqjX3FUYWIsz
 /arrHjQCdTmsol7L+7EO4l8Lpq5N9saVYszvzArytc7O0L8+ZeOswp89cCuXHqsUhP9T
 Wi7gzJ0/MmmP3/PoAGLRJgU98Z3KtBpLP5Y6eoMB9XJa3L+va+0L6gQgVpjaOV+yxu9f
 kXZa2tMT/EvJHG6G4mvBL1GF13naH2s3bdgb//ZD5XFcRov7Sy4CJ5uL0rf/cxEq5tSf UQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8ybtr2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:58:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BKwkl4005381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:58:46 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 13:58:45 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 3/4] soc: qcom: aoss: Format string in qmp_send()
Date:   Fri, 11 Aug 2023 13:58:38 -0700
Message-ID: <20230811205839.727373-4-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811205839.727373-1-quic_bjorande@quicinc.com>
References: <20230811205839.727373-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iV9SmfAytZeiKkBNnJjAros63wGAaDBw
X-Proofpoint-GUID: iV9SmfAytZeiKkBNnJjAros63wGAaDBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308110193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of callers to qmp_send() composes the message dynamically
using some form of sprintf(), resulting in unnecessary complication and
stack usage.

By changing the interface of qmp_send() to take a format string and
arguments, the duplicated composition of the commands can be moved to a
single location.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/qcom_aoss.c       | 22 ++++++++++++++--------
 include/linux/soc/qcom/qcom_aoss.h |  4 ++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 13bf13ab78d6..2d8b07b22ebb 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -207,27 +207,33 @@ static bool qmp_message_empty(struct qmp *qmp)
 /**
  * qmp_send() - send a message to the AOSS
  * @qmp: qmp context
- * @data: message to be sent
+ * @fmt: format string for message to be sent
+ * @...: arguments for the format string
  *
- * Transmit @data to AOSS and wait for the AOSS to acknowledge the message.
+ * Transmit message to AOSS and wait for the AOSS to acknowledge the message.
  * data must not be longer than the mailbox size. Access is synchronized by
  * this implementation.
  *
  * Return: 0 on success, negative errno on failure
  */
-int qmp_send(struct qmp *qmp, const void *data)
+int qmp_send(struct qmp *qmp, const char *fmt, ...)
 {
 	char buf[QMP_MSG_LEN];
 	long time_left;
+	va_list args;
+	int len;
 	int ret;
 
-	if (WARN_ON(IS_ERR_OR_NULL(qmp) || !data))
+	if (WARN_ON(IS_ERR_OR_NULL(qmp) || !fmt))
 		return -EINVAL;
 
-	if (WARN_ON(strlen(data) >= sizeof(buf)))
-		return -EINVAL;
+	memset(buf, 0, sizeof(buf));
+	va_start(args, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
 
-	strscpy_pad(buf, data, sizeof(buf));
+	if (WARN_ON(len >= sizeof(buf)))
+		return -EINVAL;
 
 	mutex_lock(&qmp->tx_lock);
 
@@ -491,7 +497,7 @@ static ssize_t qmp_debugfs_write(struct file *file, const char __user *userstr,
 		return -EFAULT;
 	buf[len] = '\0';
 
-	ret = qmp_send(qmp, buf);
+	ret = qmp_send(qmp, "%s", buf);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/soc/qcom/qcom_aoss.h b/include/linux/soc/qcom/qcom_aoss.h
index 7a71406b6050..7361ca028752 100644
--- a/include/linux/soc/qcom/qcom_aoss.h
+++ b/include/linux/soc/qcom/qcom_aoss.h
@@ -13,13 +13,13 @@ struct qmp;
 
 #if IS_ENABLED(CONFIG_QCOM_AOSS_QMP)
 
-int qmp_send(struct qmp *qmp, const void *data);
+int qmp_send(struct qmp *qmp, const char *fmt, ...);
 struct qmp *qmp_get(struct device *dev);
 void qmp_put(struct qmp *qmp);
 
 #else
 
-static inline int qmp_send(struct qmp *qmp, const void *data)
+static inline int qmp_send(struct qmp *qmp, const char *fmt, ...)
 {
 	return -ENODEV;
 }
-- 
2.25.1

