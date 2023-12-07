Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C916809048
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443394AbjLGSih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjLGSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:38:36 -0500
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA7B9A;
        Thu,  7 Dec 2023 10:38:43 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B7HfSFR032162;
        Thu, 7 Dec 2023 13:38:25 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3uujny87m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 13:38:24 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3B7IcNJx024416
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 13:38:23 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Dec 2023 13:38:22 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Dec 2023 13:38:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Dec 2023 13:38:21 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3B7IbxCa015129;
        Thu, 7 Dec 2023 13:38:02 -0500
From:   Marcelo Schmitt <marcelo.schmitt@analog.com>
To:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dan.carpenter@linaro.org>, <marcelo.schmitt1@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/13] iio: adc: ad7091r: Populate device driver data field
Date:   Thu, 7 Dec 2023 15:37:58 -0300
Message-ID: <14973feb4c0f4ad01a0e5047407c93ce9b9e5463.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 3Wzdlu1wudgA7SUZQRp6qWolFXqT608o
X-Proofpoint-ORIG-GUID: 3Wzdlu1wudgA7SUZQRp6qWolFXqT608o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=944
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312070155
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set device driver data so it can be retrieved when handling alert
events, avoiding null pointer dereference.

Fixes: ca69300173b6 ("iio: adc: Add support for AD7091R5 ADC")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 8e252cde735b..0f192fbecbd4 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -232,6 +232,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 	iio_dev->channels = chip_info->channels;
 
 	if (irq) {
+		dev_set_drvdata(st->dev, iio_dev);
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				ad7091r_event_handler,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, st);
-- 
2.42.0

