Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0455F809040
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443326AbjLGSjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjLGSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:39:54 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275951709;
        Thu,  7 Dec 2023 10:40:01 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B7FrQ7d008060;
        Thu, 7 Dec 2023 13:39:42 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3utd13sp5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 13:39:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3B7Ide1p024511
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 13:39:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 7 Dec 2023
 13:39:39 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Dec 2023 13:39:39 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3B7IdKwR015154;
        Thu, 7 Dec 2023 13:39:23 -0500
From:   Marcelo Schmitt <marcelo.schmitt@analog.com>
To:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dan.carpenter@linaro.org>, <marcelo.schmitt1@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 04/13] iio: adc: ad7091r: Align arguments to function call parenthesis
Date:   Thu, 7 Dec 2023 15:39:19 -0300
Message-ID: <ebf022a0583a68a3ff3697677a1836c51f245c48.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: qLtTPT8SBYIJDPc-yXnDV8owchSsZ9ny
X-Proofpoint-GUID: qLtTPT8SBYIJDPc-yXnDV8owchSsZ9ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=839 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312070155
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align arguments to function call open parenthesis to comply with the
Linux kernel coding style.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 6056a66d756c..3ecac3164446 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -240,8 +240,9 @@ int ad7091r_probe(struct device *dev, const char *name,
 
 		dev_set_drvdata(st->dev, iio_dev);
 		ret = devm_request_threaded_irq(dev, irq, NULL,
-				ad7091r_event_handler,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, st);
+						ad7091r_event_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT, name, st);
 		if (ret)
 			return ret;
 	}
-- 
2.42.0

