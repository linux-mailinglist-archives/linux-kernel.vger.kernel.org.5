Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE008761775
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjGYLsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjGYLsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:48:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1420410E2;
        Tue, 25 Jul 2023 04:48:24 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PAYktD019048;
        Tue, 25 Jul 2023 11:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=clDcQqjrv+FXeXzp9dqtQs5Snq+9ZGR37NVMAlAyCgw=;
 b=kIFh256eTdoyZzhDtphEWLmJf3mO7QNU5kTvftjTRha3dkK3WmqNGkyUJaXf+TVpu1I3
 S591jkbvraA4SCJb6CKEu0ohGZ5yhX7/2kZmB4FkDYWMm+0YE1kz4zFKAQibEdiEQEWX
 l2EgkjerBXyPRINQiHcOYinl7DLcvusIP6YcbohTVeMDdVNO11EvMgAxxZSAupH0Z//m
 9AFfaMjZYBfYGAgMF6ArL2DgmwrPakkGrSGmNg6g6mZWFjyMoTDPVJv9ogVEhKLvnf7+
 Ua8DCJmh5a4zu+7lGOKOtpJ04yMZimD6I8oAnwNKAp7la5s16BQHhFh4wosVrPoFHp1R 9g== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1u3taayd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 11:48:19 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36PBmFHn008429;
        Tue, 25 Jul 2023 11:48:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s086kv0xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Jul 2023 11:48:15 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36PBmFbo008424;
        Tue, 25 Jul 2023 11:48:15 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36PBmFE1008423;
        Tue, 25 Jul 2023 11:48:15 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id A6E743434; Tue, 25 Jul 2023 17:18:14 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        dan.carpenter@linaro.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 0/4] spi: spi-qcom-qspi: Follow-up patches to DMA mode support
Date:   Tue, 25 Jul 2023 17:18:05 +0530
Message-Id: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fWeRQ_8UFhZKKIxNLeebMjjvl2G24nOb
X-Proofpoint-ORIG-GUID: fWeRQ_8UFhZKKIxNLeebMjjvl2G24nOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_06,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=636 clxscore=1011 impostorscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250103
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds 4 follow-up changes to DMA mode support.
1. Handles write failure in some cases by averting a race condition
2. Handles static checker warning
3. Adds a memory barrier to avoid a possible data out of sync case
4. Book keeping change

Vijaya Krishna Nivarthi (4):
  spi: spi-qcom-qspi: Ignore disabled interrupts' status in isr
  spi: spi-qcom-qspi: Use GFP_ATOMIC flag while allocating for
    descriptor
  spi: spi-qcom-qspi: Call dma_wmb() after setting up descriptors
  spi: spi-qcom-qspi: Add DMA_CHAIN_DONE to ALL_IRQS

 drivers/spi/spi-qcom-qspi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 

