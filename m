Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FFF76C92B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjHBJPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjHBJPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:15:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1711530CF;
        Wed,  2 Aug 2023 02:15:09 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3723ivs6023590;
        Wed, 2 Aug 2023 09:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=pWLSIC3/nU6pzu6ZHepqcBqMp6jMTF6iZIv0YAr16+A=;
 b=HCuX+lDOMFuIyf9Ip/n7G/q+8kGCQ04TW65imKXiEH0heU9X4LiPwO725H4j1xR9Ydg8
 CTc7AnjtQQrjGa8FuFMU7g4V1H11Q803FsA6mF+9y6ZZ4w2awGpdK7MMKI/ssn2MH+g2
 OX3HRgBilrJ+Zs3l5BoJl5XcV3PPPQXpOfGIBIbG4hfbBz2PvbqGv81O9+uLSO6k3bX8
 qMVwvOmiNQWiGb9eOK4JQ/m05yQnsTmEzrAl7eCiKPZx05zn7CBpHNg/red1+CBr3FlQ
 U+Qj9LAqEyduYLFNoLZsL11GU5k6OA7UtZAIyO0J9xcqKH9G2kd92nWJ4tMSwA9NEs4l gg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75dg9yxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 09:15:06 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3729F5Up009440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 09:15:05 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 02:15:01 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v6 3/6] nvmem: core: Add stub for nvmem_cell_read_u8
Date:   Wed, 2 Aug 2023 14:44:25 +0530
Message-ID: <20230802091429.20892-4-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802091429.20892-1-quic_kbajaj@quicinc.com>
References: <20230802091429.20892-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u-8HQtIffTA5g1i-oOIm-ytlDcDQkdj6
X-Proofpoint-ORIG-GUID: u-8HQtIffTA5g1i-oOIm-ytlDcDQkdj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=880 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the stub nvmem_cell_read_u8() function for drivers running with
CONFIG_NVMEM disabled.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 include/linux/nvmem-consumer.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index fa030d93b768..5c88635d4c2b 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -125,6 +125,12 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
 	return -EOPNOTSUPP;
 }

+static inline int nvmem_cell_read_u8(struct device *dev,
+				     const char *cell_id, u8 *val)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int nvmem_cell_read_u16(struct device *dev,
 				      const char *cell_id, u16 *val)
 {
--
2.41.0

