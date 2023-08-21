Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBBD782336
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjHUFfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjHUFfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:35:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0743A3;
        Sun, 20 Aug 2023 22:35:40 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37L500XT015608;
        Mon, 21 Aug 2023 05:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=vZqBlmH2wGR+UOS/VlA3481JwpGSHATnLCf/CSV0MrY=;
 b=YyZiPZ/KhESrdVk0qjt8gG/bzdbaHkcA2VovSgES5OTKwmbm69pk1lGpINn0hu0UIy+c
 O6HhWEGsEAnLLF+eRP3S9H9Y7YW1rS5oPF2UIK0FVRYp+O0nw8F2ddQvb7vGaW1Xts3i
 I7sprQtqxR1VSRvSWertw5at/kYxS7KQpK+JK8TMFwvFmKT9nMH12FG2wfx+q67GJHzV
 5CLn4brG1jsTyfe86jHXEjrOB1Lakh+RpsalTpbeCP+7sMOS/HXn3qHl6BfghiB+/Cxt
 TD5U2cP2XwyXkzanS0TU/xlD0KmF2M8pbyc0Z63DS6Gjs2r/OkeiVCj+mcIR2oDUdLR5 EQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjnu12q0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 05:35:21 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37L5ZIVt019528;
        Mon, 21 Aug 2023 05:35:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3sjptkewpd-1;
        Mon, 21 Aug 2023 05:35:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37L5ZIVl019523;
        Mon, 21 Aug 2023 05:35:18 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 37L5ZHNO019521;
        Mon, 21 Aug 2023 05:35:18 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id E232A12010C6; Mon, 21 Aug 2023 11:05:16 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_mdalam@quicinc.com, quic_srichara@quicinc.com
Subject: [PATCH] mtd: rawnand: qcom: Fix build issue
Date:   Mon, 21 Aug 2023 11:05:13 +0530
Message-Id: <20230821053513.13728-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Tn_DHjJjhkmqpd2QvulhN1VearquCJa6
X-Proofpoint-GUID: Tn_DHjJjhkmqpd2QvulhN1VearquCJa6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=795 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210051
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the build issue, after removing unused variable nandc
in qcom_parse_instructions() function.

Fixes: 0bb2bd18efe8 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 370a779610e2..6aff45f32260 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2593,7 +2593,6 @@ static int qcom_parse_instructions(struct nand_chip *chip,
 				    const struct nand_subop *subop,
 				    struct qcom_op *q_op)
 {
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	const struct nand_op_instr *instr = NULL;
 	unsigned int op_id;
 	int i, ret;
-- 
2.17.1

