Return-Path: <linux-kernel+bounces-131285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A278985B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A65B244AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820684D3C;
	Thu,  4 Apr 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="anO+nJtp"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068980BF7;
	Thu,  4 Apr 2024 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228638; cv=none; b=GOAIhM74o4tno7mUBH+vtg909QMUslSoCpga3B5tk7ouNUTtqdMiNiTs9v8mb5IH9pb3HDPKKUOYaHf8pwdyr5KewjW54szMoXAtbjPsgjBiCvGLVrNhosw3BKQN9cfpGBvJwHC9X7ZqESkH8J0Asnos0FptNE7TPAhOVPtW5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228638; c=relaxed/simple;
	bh=fNPiCbBBcgPGtymUHxCG0IpXbjRneBGghOMvhTO+DqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qQ4ZfOnGyXgbNvg0Um+QdWcpT/AbbhrUvHGvkjM5wcnJ92UqokyEnZT0D3H7V5b5XVRczHy6KNgOk+nM2JUxQuN67PVCzn34RNnkgz5cfuOGhVE2quChXA1SJrPYA+1P/yRAr7W9Q3GMwmPPyUBhki+DXXZuWrevG4rYqUnLQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=anO+nJtp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4348kTdq001466;
	Thu, 4 Apr 2024 07:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=Zm3rujeW7pr9+TvGVuPV6jpggXoiyUF0IIiJF0klROg=; b=
	anO+nJtpBHFgiiU9gGAy7hflJvGOfoKhG/xvRYhr/Kg7LD/7arERPEu8iNr8/h5K
	d6CPneTTyJfssYkmkrsuwr8wJWgxkWtcPFisYvGcw3dp/Ux5ojFMCB8NgmcigcT2
	z+fl3W8jz24dmOe7ij25WPAZZxRP30jBjQWMk/a+XTXwzAmrVxNw6y+2U/GB3U3s
	3L1J8PxlSLYvNHQw5OUpBP4t7oX7P2b8utAMRGCNJ+ONMsZvbRJfPvSVEcNDrzRD
	tcKkIQLx5KffWoOKtrtgYitjdxiVOj2+JtgyxeJEPeC1VloeR78sMdi+YqlpkD8U
	4d473gN5GJVoAZdi6dMSTw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x9eks2kxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 07:03:26 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 434B3PsU018938
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 07:03:25 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Apr 2024 07:03:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Apr 2024 07:03:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Apr 2024 07:03:24 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 434B2vcC008372;
	Thu, 4 Apr 2024 07:03:18 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Apr 2024 13:06:26 +0200
Subject: [PATCH 4/4] iio: common: scmi_iio: convert to dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240404-dev-add_dev_errp_probe-v1-4-d18e3eb7ec3f@analog.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
In-Reply-To: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
To: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Chris Down
	<chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712228790; l=3435;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=fNPiCbBBcgPGtymUHxCG0IpXbjRneBGghOMvhTO+DqU=;
 b=64jKEQPfu/ZDLyWV9aXCfxf50ckJeLtPMKfQjsAWlkaU3xEB/UpZ1i3GrNSL6ExwPo+0coGCF
 6HvXLmWmFUTARkoTYIk5DHME6nLPPRjrTJmu9rAX3jYpaqq9KqoL0G4
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: HB34zM9lJCEPMMpLTsjJWIyFIAlCUiKo
X-Proofpoint-ORIG-GUID: HB34zM9lJCEPMMpLTsjJWIyFIAlCUiKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404040075

Make use of dev_err_probe() and dev_errp_probe() to simplify error paths
during probe.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++-----------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 0c2caf3570db..30d58af02b4c 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -626,12 +626,10 @@ scmi_alloc_iiodev(struct scmi_device *sdev,
 				SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
 				&sensor->sensor_info->id,
 				&sensor->sensor_update_nb);
-	if (ret) {
-		dev_err(&iiodev->dev,
-			"Error in registering sensor update notifier for sensor %s err %d",
-			sensor->sensor_info->name, ret);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return dev_errp_probe(&iiodev->dev, ret,
+				      "Error in registering sensor update notifier for sensor %s err %d",
+				      sensor->sensor_info->name, ret);
 
 	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
 	iiodev->channels = iio_channels;
@@ -653,10 +651,9 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 		return -ENODEV;
 
 	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
-	if (IS_ERR(sensor_ops)) {
-		dev_err(dev, "SCMI device has no sensor interface\n");
-		return PTR_ERR(sensor_ops);
-	}
+	if (IS_ERR(sensor_ops))
+		return dev_err_probe(dev, PTR_ERR(sensor_ops),
+				     "SCMI device has no sensor interface\n");
 
 	nr_sensors = sensor_ops->count_get(ph);
 	if (!nr_sensors) {
@@ -667,8 +664,8 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 	for (i = 0; i < nr_sensors; i++) {
 		sensor_info = sensor_ops->info_get(ph, i);
 		if (!sensor_info) {
-			dev_err(dev, "SCMI sensor %d has missing info\n", i);
-			return -EINVAL;
+			return dev_err_probe(dev, -EINVAL,
+					     "SCMI sensor %d has missing info\n", i);
 		}
 
 		/* This driver only supports 3-axis accel and gyro, skipping other sensors */
@@ -683,29 +680,25 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 		scmi_iio_dev = scmi_alloc_iiodev(sdev, sensor_ops, ph,
 						 sensor_info);
 		if (IS_ERR(scmi_iio_dev)) {
-			dev_err(dev,
-				"failed to allocate IIO device for sensor %s: %ld\n",
-				sensor_info->name, PTR_ERR(scmi_iio_dev));
-			return PTR_ERR(scmi_iio_dev);
+			return dev_err_probe(dev, PTR_ERR(scmi_iio_dev),
+					     "failed to allocate IIO device for sensor %s: %ld\n",
+					     sensor_info->name, PTR_ERR(scmi_iio_dev));
 		}
 
 		err = devm_iio_kfifo_buffer_setup(&scmi_iio_dev->dev,
 						  scmi_iio_dev,
 						  &scmi_iio_buffer_ops);
 		if (err < 0) {
-			dev_err(dev,
-				"IIO buffer setup error at sensor %s: %d\n",
-				sensor_info->name, err);
-			return err;
+			return dev_err_probe(dev, err,
+					     "IIO buffer setup error at sensor %s: %d\n",
+					     sensor_info->name, err);
 		}
 
 		err = devm_iio_device_register(dev, scmi_iio_dev);
-		if (err) {
-			dev_err(dev,
-				"IIO device registration failed at sensor %s: %d\n",
-				sensor_info->name, err);
-			return err;
-		}
+		if (err)
+			return dev_err_probe(dev, err,
+					     "IIO device registration failed at sensor %s: %d\n",
+					     sensor_info->name, err);
 	}
 	return err;
 }

-- 
2.44.0


