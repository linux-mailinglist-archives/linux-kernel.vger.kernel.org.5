Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93D27AE867
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjIZI5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbjIZI5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:57:50 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D94DE;
        Tue, 26 Sep 2023 01:57:44 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38Q5UgwX027575;
        Tue, 26 Sep 2023 04:57:36 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tad5fmw64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 04:57:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 38Q8vZxS038827
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 04:57:35 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 26 Sep 2023 04:57:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 26 Sep 2023 04:57:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 26 Sep 2023 04:57:33 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.173])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38Q8vOYX024299;
        Tue, 26 Sep 2023 04:57:29 -0400
From:   Ramona Gradinariu <ramona.gradinariu@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 1/1] iio: imu: adis16475.c: Add buffer padding after temp channel
Date:   Tue, 26 Sep 2023 11:57:21 +0300
Message-ID: <20230926085721.645687-2-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926085721.645687-1-ramona.gradinariu@analog.com>
References: <20230926085721.645687-1-ramona.gradinariu@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: cyuIt3TLd5LGJpo49luKHn2ZPlZ3A1Iz
X-Proofpoint-ORIG-GUID: cyuIt3TLd5LGJpo49luKHn2ZPlZ3A1Iz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309260078
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temperature channel has 16-bit storage size. We need to perform
the padding to have the buffer elements naturally aligned in case
the temperature channel is enabled and there are any 32-bit storage
size channels enabled which have a scan index higher than the
temperature channel scan index.

Fixes: 8f6bc87d67c0 ("iio: imu: adis16475.c: Add delta angle and delta velocity channels")
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
 drivers/iio/imu/adis16475.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 00e4e09cdafb..9af07fec0d89 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1197,6 +1197,16 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 		switch (bit) {
 		case ADIS16475_SCAN_TEMP:
 			st->data[i++] = buffer[offset];
+			/*
+			 * The temperature channel has 16-bit storage size.
+			 * We need to perform the padding to have the buffer
+			 * elements naturally aligned in case there are any
+			 * 32-bit storage size channels enabled which have a
+			 * scan index higher than the temperature channel scan
+			 * index.
+			 */
+			if (*indio_dev->active_scan_mask & GENMASK(ADIS16475_SCAN_DELTVEL_Z, ADIS16475_SCAN_DELTANG_X))
+				st->data[i++] = 0;
 			break;
 		case ADIS16475_SCAN_DELTANG_X ... ADIS16475_SCAN_DELTVEL_Z:
 			buff_offset = ADIS16475_SCAN_DELTANG_X;
-- 
2.34.1

