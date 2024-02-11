Return-Path: <linux-kernel+bounces-60649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90785080C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCFC1C2133A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBDE45BFC;
	Sun, 11 Feb 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ZLcX3PHD"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0D45016;
	Sun, 11 Feb 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707638218; cv=none; b=cOrQIHzH9GQfK2jRPFaKNg2DW/3kSdt0jKzrBcWghISj8yoM/+C/aYxJVuXHtCejLyHZ15jFMoyR05NOw60h4M+O649d2cbWF7rdkDqq6kwIM29OZepKKgwhrgOm9fPBTIu8W8NRXS+1XDHDH3aXMx9V/FAZ86WaDoBmSxDk4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707638218; c=relaxed/simple;
	bh=KPGBnj0ZTjzETULRrhkS68q97OwTkGoJ0Kz/Oy+38+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foVdIkG+EOxfj+7+uC0YbB1NnnulK97tIhYLeY7Ef9hOSX6rS/hvOaECghBCiYbjydlIsi40e4IusfrrAln8c1WelZF4+Hg4+8a8vpkvoE9ujbBLw2G7iO71P5FpqF2sLnueElr39nK70/Ijx+q4bLtXRJ/RMCi1jWEFrVXhSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=ZLcX3PHD; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.101.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 6886F33BBBB;
	Sun, 11 Feb 2024 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1707638209;
	bh=KPGBnj0ZTjzETULRrhkS68q97OwTkGoJ0Kz/Oy+38+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLcX3PHDP2ihgdgBQp+gV53OxjvjcJNKraYw8PjjLjK3riO4MGcENlyOxABjamQBg
	 dwsZcBUx4BqlB6bNZ638yKNlOs0lcQ4dWS0xj5TDzVWMdtzLioCjO30m4NbBoLc9NE
	 6NCZ1kub/wuOQPlcC4uelvTZ+F2lvU5VHOIDiMz0=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 3/6] iio: pressure: hsc030pa: include cleanup
Date: Sun, 11 Feb 2024 09:56:34 +0200
Message-ID: <20240211075645.28777-4-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211075645.28777-1-petre.rodan@subdimension.ro>
References: <20240211075645.28777-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add includes based on prior reviews from Andy.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 no changes
v2 -> v3 split cleanup patch into 3 parts, no code changes
 drivers/iio/pressure/hsc030pa.h     | 2 ++
 drivers/iio/pressure/hsc030pa_i2c.c | 2 ++
 drivers/iio/pressure/hsc030pa_spi.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
index d20420dba4f6..f1079a70799f 100644
--- a/drivers/iio/pressure/hsc030pa.h
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -10,6 +10,8 @@
 
 #include <linux/types.h>
 
+#include <linux/iio/iio.h>
+
 #define HSC_REG_MEASUREMENT_RD_SIZE 4
 
 struct device;
diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
index e2b524b36417..b0c47f863afb 100644
--- a/drivers/iio/pressure/hsc030pa_i2c.c
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -8,10 +8,12 @@
  * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf [i2c related]
  */
 
+#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
index a719bade8326..f6da49cdb5e5 100644
--- a/drivers/iio/pressure/hsc030pa_spi.c
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -7,10 +7,12 @@
  * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
  */
 
+#include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/stddef.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 
-- 
2.43.0


