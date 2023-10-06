Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1377B7BBDE6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjJFRnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjJFRnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:43:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DDAAD;
        Fri,  6 Oct 2023 10:43:05 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396HQidc011774;
        Fri, 6 Oct 2023 17:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=w9D5zFiE5Fk89khSJXhALG58nv+79xh2VzKC33OnWMg=;
 b=WcpGaMnASCpvYFByZ2x/lpO8iNhURKjSvGgQL9aZcK0eWoljDPFLAFmk5g5ciM+4vpMT
 kyAfO5a81qjHd6HC9Q3TY21iTSsPMohCkhs9AYnP/8/Hrtx5vJBYZ7J10u6xY1p21Cxd
 24kWy1TAyMDYb3c4/oXeiK/xRp4xHof/q0rR0gK1o+AHK+bbuf5AeZ4wlA+/V3E4axsW
 MyzXuiIG1jPLg7Ec82fjXZto5KGzKcRtniFh2CGKL6LYENJi7h9DwHlQ/OhrVIY/SZpA
 sgabUNcQjgVKQjNMqhwiy1OON3xMnq5A5vwuYUepFyRstQ1G2GRWzjFWzGYJh5AIp81F GQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjgc691qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 17:43:00 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 396HgtZB009715;
        Fri, 6 Oct 2023 17:42:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tecrm81td-1;
        Fri, 06 Oct 2023 17:42:55 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 396HgtFE009710;
        Fri, 6 Oct 2023 17:42:55 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 396Hgt6Z009708;
        Fri, 06 Oct 2023 17:42:55 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 680AB3FEC; Fri,  6 Oct 2023 23:12:54 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH] spi: spi-geni-qcom: Rename the label unmap_if_dma
Date:   Fri,  6 Oct 2023 23:12:50 +0530
Message-Id: <1696614170-18969-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KOlDzzKuiDLgQvqTndcrOZQkhU1USYlI
X-Proofpoint-GUID: KOlDzzKuiDLgQvqTndcrOZQkhU1USYlI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_13,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=643 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060131
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code at unmap_if_dma label doesn't contain unmapping dma anymore but
has only fsm reset.

Rename it to reset_if_dma accordingly.

No functional change.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/spi/spi-geni-qcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f4f376a..b956a32 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -166,7 +166,7 @@ static void handle_se_timeout(struct spi_master *spi,
 		 * doesn`t support CMD Cancel sequnece
 		 */
 		spin_unlock_irq(&mas->lock);
-		goto unmap_if_dma;
+		goto reset_if_dma;
 	}
 
 	reinit_completion(&mas->cancel_done);
@@ -175,7 +175,7 @@ static void handle_se_timeout(struct spi_master *spi,
 
 	time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
 	if (time_left)
-		goto unmap_if_dma;
+		goto reset_if_dma;
 
 	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->abort_done);
@@ -193,7 +193,7 @@ static void handle_se_timeout(struct spi_master *spi,
 		mas->abort_failed = true;
 	}
 
-unmap_if_dma:
+reset_if_dma:
 	if (mas->cur_xfer_mode == GENI_SE_DMA) {
 		if (xfer) {
 			if (xfer->tx_buf) {
-- 
2.7.4

