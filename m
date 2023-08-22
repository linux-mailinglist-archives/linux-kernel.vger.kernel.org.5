Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00077844B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbjHVOvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjHVOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:51:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B600ECFC;
        Tue, 22 Aug 2023 07:51:15 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MCpgex022299;
        Tue, 22 Aug 2023 14:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=sR3wWF1ycTTqF9jMxE6yGa+PalIqCjsKStFHveX30vo=;
 b=UKqAbYfH5sXS2AWRteRUisXsIAsi/89hQcurK2M45JpyCzNRKHXKk8dEmxVFMJpGs/E+
 Ah4S0tAWHUCq6AgeWTuqwHHI0PLyC/GDYSGnKcZlsWmlrZZYpHC4bKAtsicIonj+hpG/
 ElcZf/L6GkrfgOHjZCL7V5oj3xUb94wVOQ0lG4y4XN19Qmvx0GbqfkHBZAayh98yb/EW
 YsFTB2BulOa6JGkXWA9w9jnAAUq1zhPU9tWGYwoUWbQaN88o7gis4Z5V4XmIkSGHyYGV
 xL79Ut2aw7Kf8edDnw4690v2M48dTthFMET2iCJTCnJZU6JjYS2hpacS4tHS/J0RiTly IQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smgeq1kbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 14:51:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MEoog1008786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 14:50:50 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 07:50:50 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/3] ath*: Fix a few spelling errors
Date:   Tue, 22 Aug 2023 07:50:47 -0700
Message-ID: <20230822-ath_spelling-v1-0-8e2698759564@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEfL5GQC/3XMSwrCMBSF4a2UOzaSh9jWkfuQIiG5aS7UtCY1K
 CV7N3bu8D9wvg0SRsIEl2aDiJkSzaGGODRgvA4jMrK1QXKpeCfOTK/+nhacJgojU0a5lreuV9p
 CvSwRHb137jbU9pTWOX52PYvf+gfKgnF26qUz2HGrub0+X2QomKOZHzCUUr42VIEYqgAAAA==
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0WFyPQa7BOnPkiOb4WelnmoX5h2RQ_fm
X-Proofpoint-ORIG-GUID: 0WFyPQa7BOnPkiOb4WelnmoX5h2RQ_fm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=565
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some spelling errors flagged by 'codespell'.

---
Jeff Johnson (3):
      wifi: ath10k: Fix a few spelling errors
      wifi: ath11k: Fix a few spelling errors
      wifi: ath12k: Fix a few spelling errors

 drivers/net/wireless/ath/ath10k/htt.h     | 4 ++--
 drivers/net/wireless/ath/ath10k/pci.c     | 2 +-
 drivers/net/wireless/ath/ath10k/sdio.c    | 2 +-
 drivers/net/wireless/ath/ath10k/wmi.h     | 8 ++++----
 drivers/net/wireless/ath/ath11k/dp.h      | 2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c   | 2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c   | 2 +-
 drivers/net/wireless/ath/ath12k/dp.h      | 2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   | 2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c   | 2 +-
 drivers/net/wireless/ath/ath12k/mac.c     | 2 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h | 2 +-
 12 files changed, 16 insertions(+), 16 deletions(-)
---
base-commit: 25e2452fd61fd73cc78e150f13bac6dcdb3be2ac
change-id: 20230816-ath_spelling-3c3f707f93ad

