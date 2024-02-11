Return-Path: <linux-kernel+bounces-60652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22D850810
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328FA1F2291E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BF946558;
	Sun, 11 Feb 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="vO9wcHof"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FE45018;
	Sun, 11 Feb 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707638220; cv=none; b=tCFWJ3NtISMfcuSIxcBOGa6/La+LmQ+x5uA88ovI767eYR6gks3cJrg0Na2dAyXxQ2YTU+83Lcrp/n61rinGE6vZcK3EAleu7ks6uJghpqlne3yGfLQE94+Zsflj7BZSeKOhsyJofT4os81V+d3dNCtPz59iQ9b5G094AuiKP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707638220; c=relaxed/simple;
	bh=wNBkdVLyeOQ8x7+iyTGkd18QjqQbam0wLSd/ELJIWfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ars/S6BrA7lHJfNTGUi6TAt5cvVFznTRPfCtbaQDJ+onk5C9Rv6X2719PlXB6fwT1n22PTaCUtvl83baCW299XKztoz5DqYyFe4nOJrs4yor4euXAeeKNu9+BG8mR4ZodmMeeDmf5PcfV4uOeL+6d8HklRbbi2oiiyRubzN7FAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=vO9wcHof; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.101.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id AADA933BBBD;
	Sun, 11 Feb 2024 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1707638209;
	bh=wNBkdVLyeOQ8x7+iyTGkd18QjqQbam0wLSd/ELJIWfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vO9wcHof7POCfjrX+pzF2SLjiQgOVQsuiZS05FFn9iSfJpzFGBhCcrTkplkRzihmK
	 lINysF0o6MXs7W9ZlD8dZZ3f1dVYDFQkb7vux+XfakUwtXgAXuOKa6XVrPPxdSTuas
	 dBaI18aZDvWfr7xb1kKI0RypmuRTQWQtpIz2u2rA=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 4/6] iio: pressure: hsc030pa: update datasheet URLs
Date: Sun, 11 Feb 2024 09:56:35 +0200
Message-ID: <20240211075645.28777-5-petre.rodan@subdimension.ro>
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

Provide bus-specific technical datasheet in the _i2c.c _spi.c headers
instead of the generic one.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 no changes
v2 -> v3 split cleanup patch into 3 parts, no code changes
 drivers/iio/pressure/hsc030pa_i2c.c | 4 ++--
 drivers/iio/pressure/hsc030pa_spi.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
index b0c47f863afb..b5810bafef40 100644
--- a/drivers/iio/pressure/hsc030pa_i2c.c
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -4,8 +4,8 @@
  *
  * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
  *
- * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [hsc]
- * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf [i2c related]
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
  */
 
 #include <linux/device.h>
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
index f6da49cdb5e5..8d3441f1dcf9 100644
--- a/drivers/iio/pressure/hsc030pa_spi.c
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -4,7 +4,8 @@
  *
  * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
  *
- * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-spi-comms-digital-ouptu-pressure-sensors-tn-008202-3-en-ciid-45843.pdf
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
  */
 
 #include <linux/device.h>
-- 
2.43.0


