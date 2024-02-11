Return-Path: <linux-kernel+bounces-60938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845DB850B61
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EAFAB21C7A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A845E3A0;
	Sun, 11 Feb 2024 20:15:37 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74A5B668
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682536; cv=none; b=n6H7FUbHVZW31ayLqkkEf0hTVCKTBQ01puzxtMbvY2gHaD6FbqE0zVxO2ysJrX/wIcyLZG3834sYK2ivIardcJk2XWUK9fU9AYwexP+IwGdF/dFNrIBK7y3SlGDUoj2/nGtnWYN+nwAKEGuoKeeRqvc7JxdtsxsHM+RYHMw9KLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682536; c=relaxed/simple;
	bh=5XIv07/wKtmBMOxCIJedyIk4CrP17JzQEnwYP4BIfKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bgrgp5DPlCzqb3+x22Gg92GT39SAvlwLSWFemUS+x/WDjc4R9qwAYOfXyo5CtoTxfaYJRhHNL7fHI2UouFKP1jhHKIOvvqGtiSLbm+1vSUQW2sL9eR1+gDsscqf+YGD2LiIR0AvnjOo89Bntm3FcPMJWJEI7UvMVGNYaqnoCaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 4e677400-c91a-11ee-b972-005056bdfda7;
	Sun, 11 Feb 2024 22:15:32 +0200 (EET)
From: andy.shevchenko@gmail.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marius Hoch <mail@mariushoch.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 3/3] iio: st_sensors: lsm9ds0: Use common style for terminator in ID tables
Date: Sun, 11 Feb 2024 22:14:34 +0200
Message-ID: <20240211201526.1518165-4-andy.shevchenko@gmail.com>
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

Use common style for a terminator entry in the ID tables.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index ab8504286ba4..d03cec3b24fe 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -41,7 +41,7 @@ MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
 
 static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
 	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
-	{ },
+	{}
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
 
-- 
2.43.0


