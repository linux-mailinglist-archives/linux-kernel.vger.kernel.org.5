Return-Path: <linux-kernel+bounces-131284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A508985AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA2A1C21C30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517B82860;
	Thu,  4 Apr 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zkDK7Vtl"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEE8002A;
	Thu,  4 Apr 2024 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228637; cv=none; b=qiO9LMUM5mA7ggDMDUmC6TA14rqcXWystsOb+fjMGNOPQecAAiTkk3izdG8KaLBViTVUisM2MrC+bp9ZYqLpMtHjR7DhjBOjQ8AuhTyfj1yYBACQi6Rgt+TV+RRfSR6PVXAewJL07+W6U1PrGbMitKpiZGBuuOK9oEwRASn6uLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228637; c=relaxed/simple;
	bh=p7rra+d/iE4ivxuEmfElqbM0Q9Z+oVixbVj1b4czt8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eGomENoaJTKwrSkK93JTI+9Ln+vNlu3bugdWdMwOXIwozeCorGM0KSIAVkB0MP6NS2mUkOfigXGy1PrKdp0nv8HvNNvkJJUptSQH+2Cykh39cLDErKx1xawZ5Mc2tdb074wrrCK/YWit9nH2gLjzqFVFmB3F2RsBq7J73LQK9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zkDK7Vtl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434B1HuJ028213;
	Thu, 4 Apr 2024 07:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=Nh08y7HYdiMV69mgnPkZwib68VCRhA9yOaBASDG+Eoo=; b=
	zkDK7VtlCKGytr3IFAV3lIN9x4AUnk5EjKz2I7g6yMCZ2weSAhPVtcxByLdCWd0x
	BRv2c+1sKvAFEL6zLrtNdmd6gehv21n4s1xzuxJhd7p6zAybRCyq5AXU5LuoELNQ
	GSa1Gu6wqCyLhT3zJz/UXn4a0H4AVB7VYnRiaTYt5mApWxucaG6hO+2kuthoG4gX
	+Z3C/583GFNli2Ys5FQeKF8+aNeQk77b0IQvETimhlrAW/2LsF1e6Ac23UYvf5wI
	QlE5JSN2H0vnw41808P95v0D5n+WzxIpa8cX2woYnDqXINeroaMdOkFvRzkRQq/X
	7lLUzXClaex5WSwwBD/8Gg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3x9ty900bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 07:03:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 434B3KhI018919
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 07:03:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 4 Apr 2024
 07:03:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Apr 2024 07:03:19 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 434B2vcA008372;
	Thu, 4 Apr 2024 07:03:15 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Apr 2024 13:06:24 +0200
Subject: [PATCH 2/4] iio: temperature: ltc2983: convert to dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240404-dev-add_dev_errp_probe-v1-2-d18e3eb7ec3f@analog.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
In-Reply-To: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
To: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Down
	<chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712228790; l=19092;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=p7rra+d/iE4ivxuEmfElqbM0Q9Z+oVixbVj1b4czt8A=;
 b=AfVtrRcMvBGg2/5f7zE8NOeoHDk67pYnmsALE8LSbOC88tp7mlEZQW/izi8IQ6lxLqDRQbpyU
 AydFNbxyKOODzm7t2pgqoZX2D3DzkzB+Mbe3MrGlwmexdvj7YeiaJKx
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: VERckTjO_6b0EkYfifp0jYzSJjwMb8wN
X-Proofpoint-ORIG-GUID: VERckTjO_6b0EkYfifp0jYzSJjwMb8wN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040075

Use dev_err_probe() in the probe() path. While at it, made some simple
improvements:
 * Declare a struct device *dev helper. This also makes the style more
   consistent (some places the helper was used and not in other places);
 * Explicitly included the err.h and errno.h headers;
 * Removed an useless else if();
 * Removed some unnecessary line breaks.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 255 +++++++++++++++++---------------------
 1 file changed, 115 insertions(+), 140 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 3c4524d57b8e..b4a8ca36458a 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -8,6 +8,8 @@
 #include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -657,10 +659,11 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 			 const struct ltc2983_sensor *sensor)
 {
 	struct ltc2983_thermocouple *thermo;
+	struct device *dev = &st->spi->dev;
 	u32 oc_current;
 	int ret;
 
-	thermo = devm_kzalloc(&st->spi->dev, sizeof(*thermo), GFP_KERNEL);
+	thermo = devm_kzalloc(dev, sizeof(*thermo), GFP_KERNEL);
 	if (!thermo)
 		return ERR_PTR(-ENOMEM);
 
@@ -687,21 +690,19 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 					LTC2983_THERMOCOUPLE_OC_CURR(3);
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid open circuit current:%u", oc_current);
-			return ERR_PTR(-EINVAL);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid open circuit current:%u",
+					      oc_current);
 		}
 
 		thermo->sensor_config |= LTC2983_THERMOCOUPLE_OC_CHECK(1);
 	}
 	/* validate channel index */
 	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermocouple",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chann:%d for differential thermocouple",
+				      sensor->chan);
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,cold-junction-handle", 0);
@@ -709,14 +710,13 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 		ref = NULL;
 	} else {
 		ret = fwnode_property_read_u32(ref, "reg", &thermo->cold_junction_chan);
-		if (ret) {
+		if (ret)
 			/*
 			 * This would be catched later but we can just return
 			 * the error right away.
 			 */
-			dev_err(&st->spi->dev, "Property reg must be given\n");
-			return ERR_PTR(ret);
-		}
+			return dev_errp_probe(dev, ret,
+					      "Property reg must be given\n");
 	}
 
 	/* check custom sensor */
@@ -752,16 +752,14 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,rsense-handle", 0);
-	if (IS_ERR(ref)) {
-		dev_err(dev, "Property adi,rsense-handle missing or invalid");
-		return ERR_CAST(ref);
-	}
+	if (IS_ERR(ref))
+		return dev_errp_probe(dev, PTR_ERR(ref),
+				      "Property adi,rsense-handle missing or invalid");
 
 	ret = fwnode_property_read_u32(ref, "reg", &rtd->r_sense_chan);
-	if (ret) {
-		dev_err(dev, "Property reg must be given\n");
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return dev_errp_probe(dev, ret,
+				      "Property reg must be given\n");
 
 	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
 	if (!ret) {
@@ -780,19 +778,19 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->sensor_config = LTC2983_RTD_N_WIRES(3);
 			break;
 		default:
-			dev_err(dev, "Invalid number of wires:%u\n", n_wires);
-			return ERR_PTR(-EINVAL);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid number of wires:%u\n",
+					      n_wires);
 		}
 	}
 
 	if (fwnode_property_read_bool(child, "adi,rsense-share")) {
 		/* Current rotation is only available with rsense sharing */
 		if (fwnode_property_read_bool(child, "adi,current-rotate")) {
-			if (n_wires == 2 || n_wires == 3) {
-				dev_err(dev,
-					"Rotation not allowed for 2/3 Wire RTDs");
-				return ERR_PTR(-EINVAL);
-			}
+			if (n_wires == 2 || n_wires == 3)
+				return dev_errp_probe(dev, -EINVAL,
+						      "Rotation not allowed for 2/3 Wire RTDs");
+
 			rtd->sensor_config |= LTC2983_RTD_C_ROTATE(1);
 		} else {
 			rtd->sensor_config |= LTC2983_RTD_R_SHARE(1);
@@ -815,29 +813,22 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 
 		if (((rtd->sensor_config & LTC2983_RTD_KELVIN_R_SENSE_MASK)
 		     == LTC2983_RTD_KELVIN_R_SENSE_MASK) &&
-		    (rtd->r_sense_chan <=  min)) {
+		    (rtd->r_sense_chan <=  min))
 			/* kelvin rsense*/
-			dev_err(dev,
-				"Invalid rsense chann:%d to use in kelvin rsense",
-				rtd->r_sense_chan);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid rsense chann:%d to use in kelvin rsense",
+					      rtd->r_sense_chan);
 
-			return ERR_PTR(-EINVAL);
-		}
-
-		if (sensor->chan < min || sensor->chan > max) {
-			dev_err(dev, "Invalid chann:%d for the rtd config",
-				sensor->chan);
-
-			return ERR_PTR(-EINVAL);
-		}
+		if (sensor->chan < min || sensor->chan > max)
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid chann:%d for the rtd config",
+					      sensor->chan);
 	} else {
 		/* same as differential case */
-		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-			dev_err(&st->spi->dev,
-				"Invalid chann:%d for RTD", sensor->chan);
-
-			return ERR_PTR(-EINVAL);
-		}
+		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid chann:%d for RTD",
+					      sensor->chan);
 	}
 
 	/* check custom sensor */
@@ -885,10 +876,9 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->excitation_current = 0x08;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid value for excitation current(%u)",
+					      excitation_current);
 		}
 	}
 
@@ -912,16 +902,14 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,rsense-handle", 0);
-	if (IS_ERR(ref)) {
-		dev_err(dev, "Property adi,rsense-handle missing or invalid");
-		return ERR_CAST(ref);
-	}
+	if (IS_ERR(ref))
+		return dev_errp_probe(dev, PTR_ERR(ref),
+				      "Property adi,rsense-handle missing or invalid");
 
 	ret = fwnode_property_read_u32(ref, "reg", &thermistor->r_sense_chan);
-	if (ret) {
-		dev_err(dev, "rsense channel must be configured...\n");
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return dev_errp_probe(dev, ret,
+				      "rsense channel must be configured...\n");
 
 	if (fwnode_property_read_bool(child, "adi,single-ended")) {
 		thermistor->sensor_config = LTC2983_THERMISTOR_SGL(1);
@@ -936,12 +924,10 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	}
 	/* validate channel index */
 	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermistor",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chann:%d for differential thermistor",
+				      sensor->chan);
 
 	/* check custom sensor */
 	if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART) {
@@ -980,12 +966,10 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 		switch (excitation_current) {
 		case 0:
 			/* auto range */
-			if (sensor->type >=
-			    LTC2983_SENSOR_THERMISTOR_STEINHART) {
-				dev_err(&st->spi->dev,
-					"Auto Range not allowed for custom sensors\n");
-				return ERR_PTR(-EINVAL);
-			}
+			if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
+				return dev_errp_probe(dev, -EINVAL,
+						      "Auto Range not allowed for custom sensors\n");
+
 			thermistor->excitation_current = 0x0c;
 			break;
 		case 250:
@@ -1022,10 +1006,9 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 			thermistor->excitation_current = 0x0b;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid value for excitation current(%u)",
+					      excitation_current);
 		}
 	}
 
@@ -1036,11 +1019,12 @@ static struct ltc2983_sensor *
 ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *st,
 		  const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_diode *diode;
 	u32 temp = 0, excitation_current = 0;
 	int ret;
 
-	diode = devm_kzalloc(&st->spi->dev, sizeof(*diode), GFP_KERNEL);
+	diode = devm_kzalloc(dev, sizeof(*diode), GFP_KERNEL);
 	if (!diode)
 		return ERR_PTR(-ENOMEM);
 
@@ -1055,12 +1039,11 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 
 	/* validate channel index */
 	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermistor",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chann:%d for differential thermistor",
+				      sensor->chan);
+
 	/* set common parameters */
 	diode->sensor.fault_handler = ltc2983_common_fault_handler;
 	diode->sensor.assign_chan = ltc2983_diode_assign_chan;
@@ -1082,10 +1065,9 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 			diode->excitation_current = 0x03;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid value for excitation current(%u)",
+					      excitation_current);
 		}
 	}
 
@@ -1101,26 +1083,26 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
 					struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_rsense *rsense;
 	int ret;
 	u32 temp;
 
-	rsense = devm_kzalloc(&st->spi->dev, sizeof(*rsense), GFP_KERNEL);
+	rsense = devm_kzalloc(dev, sizeof(*rsense), GFP_KERNEL);
 	if (!rsense)
 		return ERR_PTR(-ENOMEM);
 
 	/* validate channel index */
-	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chann:%d for r_sense",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chann:%d for r_sense",
+				      sensor->chan);
 
 	ret = fwnode_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
-	if (ret) {
-		dev_err(&st->spi->dev, "Property adi,rsense-val-milli-ohms missing\n");
-		return ERR_PTR(-EINVAL);
-	}
+	if (ret)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Property adi,rsense-val-milli-ohms missing\n");
+
 	/*
 	 * Times 1000 because we have milli-ohms and __convert_to_raw
 	 * expects scales of 1000000 which are used for all other
@@ -1139,21 +1121,21 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 					 struct ltc2983_data *st,
 					 const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_adc *adc;
 
-	adc = devm_kzalloc(&st->spi->dev, sizeof(*adc), GFP_KERNEL);
+	adc = devm_kzalloc(dev, sizeof(*adc), GFP_KERNEL);
 	if (!adc)
 		return ERR_PTR(-ENOMEM);
 
 	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		adc->single_ended = true;
 
-	if (!adc->single_ended &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chan:%d for differential adc\n",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (!adc->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chan:%d for differential adc\n",
+				      sensor->chan);
+
 	/* set common parameters */
 	adc->sensor.assign_chan = ltc2983_adc_assign_chan;
 	adc->sensor.fault_handler = ltc2983_common_fault_handler;
@@ -1165,21 +1147,20 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 					       struct ltc2983_data *st,
 					       const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_temp *temp;
 
-	temp = devm_kzalloc(&st->spi->dev, sizeof(*temp), GFP_KERNEL);
+	temp = devm_kzalloc(dev, sizeof(*temp), GFP_KERNEL);
 	if (!temp)
 		return ERR_PTR(-ENOMEM);
 
 	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		temp->single_ended = true;
 
-	if (!temp->single_ended &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chan:%d for differential temp\n",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (!temp->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chan:%d for differential temp\n",
+				      sensor->chan);
 
 	temp->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-temp",
 						   false, 4096, true);
@@ -1329,10 +1310,9 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 	device_property_read_u32(dev, "adi,filter-notch-freq", &st->filter_notch_freq);
 
 	st->num_channels = device_get_child_node_count(dev);
-	if (!st->num_channels) {
-		dev_err(&st->spi->dev, "At least one channel must be given!");
-		return -EINVAL;
-	}
+	if (!st->num_channels)
+		return dev_err_probe(dev, -EINVAL,
+				     "At least one channel must be given!");
 
 	st->sensors = devm_kcalloc(dev, st->num_channels, sizeof(*st->sensors),
 				   GFP_KERNEL);
@@ -1419,6 +1399,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 			      unsigned int wait_time, unsigned int status_reg,
 			      unsigned long status_fail_mask)
 {
+	struct device *dev = &st->spi->dev;
 	unsigned long time;
 	unsigned int val;
 	int ret;
@@ -1437,19 +1418,16 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 
 	time = wait_for_completion_timeout(&st->completion,
 					   msecs_to_jiffies(wait_time));
-	if (!time) {
-		dev_err(&st->spi->dev, "EEPROM command timed out\n");
-		return -ETIMEDOUT;
-	}
+	if (!time)
+		return dev_err_probe(dev, -ETIMEDOUT, "EEPROM command timed out\n");
 
 	ret = regmap_read(st->regmap, status_reg, &val);
 	if (ret)
 		return ret;
 
-	if (val & status_fail_mask) {
-		dev_err(&st->spi->dev, "EEPROM command failed: 0x%02X\n", val);
-		return -EINVAL;
-	}
+	if (val & status_fail_mask)
+		return dev_err_probe(dev, -EINVAL,
+				     "EEPROM command failed: 0x%02X\n", val);
 
 	return 0;
 }
@@ -1457,16 +1435,15 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 {
 	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
 	ret = regmap_read_poll_timeout(st->regmap, LTC2983_STATUS_REG, status,
 				       LTC2983_STATUS_UP(status) == 1, 25000,
 				       25000 * 10);
-	if (ret) {
-		dev_err(&st->spi->dev, "Device startup timed out\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Device startup timed out\n");
 
 	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
 				 LTC2983_NOTCH_FREQ_MASK,
@@ -1566,12 +1543,13 @@ static const struct  iio_info ltc2983_iio_info = {
 
 static int ltc2983_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct ltc2983_data *st;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *gpio;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1582,10 +1560,9 @@ static int ltc2983_probe(struct spi_device *spi)
 		return -ENODEV;
 
 	st->regmap = devm_regmap_init_spi(spi, &ltc2983_regmap_config);
-	if (IS_ERR(st->regmap)) {
-		dev_err(&spi->dev, "Failed to initialize regmap\n");
-		return PTR_ERR(st->regmap);
-	}
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
 
 	mutex_init(&st->lock);
 	init_completion(&st->completion);
@@ -1597,7 +1574,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
@@ -1607,7 +1584,7 @@ static int ltc2983_probe(struct spi_device *spi)
 		gpiod_set_value_cansleep(gpio, 0);
 	}
 
-	st->iio_chan = devm_kzalloc(&spi->dev,
+	st->iio_chan = devm_kzalloc(dev,
 				    st->iio_channels * sizeof(*st->iio_chan),
 				    GFP_KERNEL);
 	if (!st->iio_chan)
@@ -1617,12 +1594,10 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
+	ret = devm_request_irq(dev, spi->irq, ltc2983_irq_handler,
 			       IRQF_TRIGGER_RISING, st->info->name, st);
-	if (ret) {
-		dev_err(&spi->dev, "failed to request an irq, %d", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request an irq\n");
 
 	if (st->info->has_eeprom) {
 		ret = ltc2983_eeprom_cmd(st, LTC2983_EEPROM_WRITE_CMD,
@@ -1639,7 +1614,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ltc2983_iio_info;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ltc2983_resume(struct device *dev)

-- 
2.44.0


