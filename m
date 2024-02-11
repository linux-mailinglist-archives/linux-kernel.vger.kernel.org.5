Return-Path: <linux-kernel+bounces-60941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D848B850B67
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88E31C218B9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14CE5F859;
	Sun, 11 Feb 2024 20:15:41 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C285EE9B
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682541; cv=none; b=rE4hWjvkyKlAMeqMuln1stuBEhPxcHMdJmRYPa196lbDGudKP5snTTBsrv1bzqJHpktOsjlaeaWRI94nJe9+UaFyQUyE0119oh2oE65nXeaJtqfYRTgTpCECz96twBGadUMfzzUoo2X/YZV0YO2wjnS7rT+ila2k+iaBfVispyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682541; c=relaxed/simple;
	bh=ZrHIuQSM8iDm77EAadM1fDiTchD/AxV8beVPT6IGqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZnKjKMi54QPWOTpgKa3szzmtBehDyvvnft2Z0WRES/qW/Vzbg2jyhIvUwkai9DLpCtSkFkCUp4Celm3iIYSWFZQJKH4Ch1ELsI94w/aiiPbjm/Z8dY92zJRkficgw+Dh11e5agw6Lit/MU3dgq+NBin2pM9C9bFJs3c5yINZls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 4e07fa90-c91a-11ee-abf4-005056bdd08f;
	Sun, 11 Feb 2024 22:15:31 +0200 (EET)
From: andy.shevchenko@gmail.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marius Hoch <mail@mariushoch.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/3] iio: st_sensors: lsm9ds0: Don't use "proxy" headers
Date: Sun, 11 Feb 2024 22:14:33 +0200
Message-ID: <20240211201526.1518165-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211201526.1518165-1-andy.shevchenko@gmail.com>
References: <20240211201526.1518165-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h      | 5 ++++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 4 ++--
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c  | 4 +++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c  | 4 +++-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
index 76678cdefb07..e67d31b48441 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
@@ -4,9 +4,12 @@
 #ifndef ST_LSM9DS0_H
 #define ST_LSM9DS0_H
 
-struct iio_dev;
+struct device;
+struct regmap;
 struct regulator;
 
+struct iio_dev;
+
 struct st_lsm9ds0 {
 	struct device *dev;
 	const char *name;
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
index 7b9dc849f010..10c1b2ba7a3d 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -7,10 +7,10 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/device.h>
+#include <linux/array_size.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/common/st_sensors.h>
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 61d855083aa0..ab8504286ba4 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -7,8 +7,10 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gfp_types.h>
 #include <linux/i2c.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index 8cc041d56cf7..69e9135795a3 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -7,7 +7,9 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gfp_types.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
-- 
2.43.0


