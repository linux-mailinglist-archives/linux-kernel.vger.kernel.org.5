Return-Path: <linux-kernel+bounces-111499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF38886D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC4C287BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED650605C1;
	Fri, 22 Mar 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OtPpZIRd"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580875FF0E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114017; cv=none; b=P+fYiHvRATOeqqPNHIwalI17A6Tu6XqxV88KDAYrBkHOEeHErvURBXh5DXy1O1Ho8+aO5IQtcc2SLOpFI+UD84iC227DXezBNk3moA5Uvnksg8b0pdrXLoNSm7FypWBIbkatSwrsfTBkRjDvLrb0dkss0nkMwyhh44WjUPrDXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114017; c=relaxed/simple;
	bh=WO3DbylpQPgN6NYC59JVZ3TCZs+4KFNv+oAPbFnZkS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mix2p9zPy2Z37OQJ/CwrndhpJ/+To2ZMBmQs0SavFGMUUI88Wsn3uTOCiE6J0HrNF69R3XrjKCNvIbZElBddyi7faFB9Fnz1estrDfZoCgtGQd+ryR70IP4d+IELGaCAz9rCkHEL1wvd8q0OqB06HpuaKO7xvVad2YQbYf84lLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OtPpZIRd; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=DPk9C/eldcF/PegK95oT49FZFkWMxsc7VuXN/WF7JZk=; b=OtPpZI
	Rd87+dTKx4yAVMrc+FVVht8X5O3BALh2oEKo2DWYttlmQyMXc027dY3TStRnyVgR
	sQY6K5YWDb1Qs1O8g08fPDS9fXFsIjYNW83DS50UHSqr+hV8tG89kDbFh6aI4hCP
	d/SQp40oWBahcU7mjaxuFaptmgQtDUsfSq4h7GX+sQjd7SD6uAbm/jbXtAQzO2qC
	eCeJhaQfdcdPrMcIrl/rE1IWNfzVQVSgp3UVByeGFb5Lx3ADu/ohlhGt4IPHLNwf
	+I3zqTH6paaeURhTN2uM9uNuAQGVlAuQnNPysP1qFeIRznDLB2e72snpqLAwqcmY
	6b79ufGgRwCDmcgg==
Received: (qmail 3870598 invoked from network); 22 Mar 2024 14:26:38 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:38 +0100
X-UD-Smtp-Session: l3s3148p1@VVYIxj8U/OBehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 21/64] i2c: gpio: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:14 +0100
Message-ID: <20240322132619.6389-22-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
specifications and replace "master/slave" with more appropriate terms.
They are also more specific because we distinguish now between a remote
entity ("client") and a local one ("target").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 4f1411b1a775..e0bd218e2f14 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -216,8 +216,8 @@ static int fops_lose_arbitration_set(void *data, u64 duration)
 
 	priv->scl_irq_data = duration;
 	/*
-	 * Interrupt on falling SCL. This ensures that the master under test has
-	 * really started the transfer. Interrupt on falling SDA did only
+	 * Interrupt on falling SCL. This ensures that the controller under test
+	 * has really started the transfer. Interrupt on falling SDA did only
 	 * exercise 'bus busy' detection on some HW but not 'arbitration lost'.
 	 * Note that the interrupt latency may cause the first bits to be
 	 * transmitted correctly.
@@ -245,8 +245,8 @@ static int fops_inject_panic_set(void *data, u64 duration)
 
 	priv->scl_irq_data = duration;
 	/*
-	 * Interrupt on falling SCL. This ensures that the master under test has
-	 * really started the transfer.
+	 * Interrupt on falling SCL. This ensures that the controller under test
+	 * has really started the transfer.
 	 */
 	return i2c_gpio_fi_act_on_scl_irq(priv, inject_panic_irq);
 }
-- 
2.43.0


