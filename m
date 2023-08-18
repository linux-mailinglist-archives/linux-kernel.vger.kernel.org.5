Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18052780E50
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377889AbjHROwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357743AbjHROvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:51:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F4330E6;
        Fri, 18 Aug 2023 07:51:24 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IEKQVm007391;
        Fri, 18 Aug 2023 14:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=q2D9GIaAAlCUQ4JULRnkcFFCMLwT+SEPQZvPIfxDzcI=;
 b=VpO0cMA3y5fXdCmrMssz30apR+7lRSWJxzBIYtcSzrPte0Gu5PxRAAXEs5zN1qsrGvwu
 DbFRj5KqezgS24oltvok9EEoBJLYDfcybwXI+qwALmHWjzgCxJw3l8rEq6OT2bY2WW9a
 p8tSu630hp93YACjGMI0abi7c2dSDTzdIoQR7+PuvbcEz7rK4FJLH1o9bOBNKQNP89eA
 arxc2O196lUZCmmjz1oqse7WhE1gEWYspaZLChjh9wlUDQIYZZHN9xXSlS4IFm2FKutb
 0og5bZObcrVt04FEs9Gr6A4Ngp88DliEIU+KfAByMEVj9Y0tjYkCflnKkauCzxePH33P Tg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sj92qg719-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 14:51:07 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37IEp4Ol032759;
        Fri, 18 Aug 2023 14:51:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3se35mqdxt-1;
        Fri, 18 Aug 2023 14:51:04 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IEp4wV032752;
        Fri, 18 Aug 2023 14:51:04 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37IEp42t032747;
        Fri, 18 Aug 2023 14:51:04 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 55F0512010CE; Fri, 18 Aug 2023 20:21:03 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_mdalam@quicinc.com, quic_srichara@quicinc.com
Subject: [PATCH 1/3] mtd: rawnand: qcom: Update read_loc size to 512
Date:   Fri, 18 Aug 2023 20:20:59 +0530
Message-Id: <20230818145101.23825-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818145101.23825-1-quic_mdalam@quicinc.com>
References: <20230818145101.23825-1-quic_mdalam@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tztXp1AfNqywYSYYM1Q5xYpOcGcfxWbF
X-Proofpoint-ORIG-GUID: tztXp1AfNqywYSYYM1Q5xYpOcGcfxWbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_18,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180135
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For parameter page read upper layer is passing len
as 256 bytes and if we try to configure 256 bytes
size in read loaction register then subsequent bam
transaction is getting timed out for 4K nand devices.
So update this length as one step size if its
less than NANDC_STEP_SIZE.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index d4ba0d04c970..413e214c8e87 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2885,6 +2885,9 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	op_id = q_op.data_instr_idx;
 	len = nand_subop_get_data_len(subop, op_id);
 
+	if (len < NANDC_STEP_SIZE)
+		len = NANDC_STEP_SIZE;
+
 	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
 
 	if (!nandc->props->qpic_v2) {
-- 
2.17.1

