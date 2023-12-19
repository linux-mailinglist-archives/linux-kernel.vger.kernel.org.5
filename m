Return-Path: <linux-kernel+bounces-5912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F947819169
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3264282FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046C039AFF;
	Tue, 19 Dec 2023 20:28:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF139AD7;
	Tue, 19 Dec 2023 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJI4QUY024819;
	Tue, 19 Dec 2023 15:28:27 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3v3g4s8erg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:28:27 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3BJKSPQO034969
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Dec 2023 15:28:25 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 19 Dec
 2023 15:28:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Dec 2023 15:28:24 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BJKS5Ob030051;
	Tue, 19 Dec 2023 15:28:08 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 05/11] iio: adc: ad7091r: Remove unneeded probe parameters
Date: Tue, 19 Dec 2023 17:28:05 -0300
Message-ID: <090a6b461410a374511a8c73659de28b2665f96b.1703013352.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
References: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: bQPiDemYlo5RB9hBPmTCxSkh3CCBpS4y
X-Proofpoint-GUID: bQPiDemYlo5RB9hBPmTCxSkh3CCBpS4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312190152

With the grouping of ad7091r initialization data and callbacks into the
init_info struct, there is no more need to pass the device name and
register map through probe function parameters as those will be available
in the init_info object.
Remove probe parameters that are not needed anymore.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 8 ++++----
 drivers/iio/adc/ad7091r-base.h | 5 ++---
 drivers/iio/adc/ad7091r5.c     | 3 +--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index b5f9423e4e6d..2c65c63db40c 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -341,9 +341,8 @@ static void ad7091r_remove(void *data)
 	regulator_disable(st->vref);
 }
 
-int ad7091r_probe(struct device *dev, const char *name,
-		const struct ad7091r_init_info *init_info,
-		struct regmap *map, int irq)
+int ad7091r_probe(struct device *dev, const struct ad7091r_init_info *init_info,
+		  int irq)
 {
 	struct iio_dev *iio_dev;
 	struct ad7091r_state *st;
@@ -373,7 +372,8 @@ int ad7091r_probe(struct device *dev, const char *name,
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 						ad7091r_event_handler,
 						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT, name, iio_dev);
+						IRQF_ONESHOT,
+						st->chip_info->name, iio_dev);
 		if (ret)
 			return ret;
 	} else {
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index b3c43a200825..a57ec36491f5 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -70,9 +70,8 @@ struct ad7091r_init_info {
 
 extern const struct iio_event_spec ad7091r_events[3];
 
-int ad7091r_probe(struct device *dev, const char *name,
-		const struct ad7091r_init_info *init_info,
-		struct regmap *map, int irq);
+int ad7091r_probe(struct device *dev, const struct ad7091r_init_info *init_info,
+		  int irq);
 
 bool ad7091r_volatile_reg(struct device *dev, unsigned int reg);
 bool ad7091r_writeable_reg(struct device *dev, unsigned int reg);
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 4b8f9ba078eb..cb4c7865f0cc 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -64,14 +64,13 @@ static struct ad7091r_init_info ad7091r5_init_info = {
 
 static int ad7091r5_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	const struct ad7091r_init_info *init_info;
 
 	init_info = i2c_get_match_data(i2c);
 	if (!init_info)
 		return -EINVAL;
 
-	return ad7091r_probe(&i2c->dev, id->name, init_info, NULL, i2c->irq);
+	return ad7091r_probe(&i2c->dev, init_info, i2c->irq);
 }
 
 static const struct of_device_id ad7091r5_dt_ids[] = {
-- 
2.42.0


