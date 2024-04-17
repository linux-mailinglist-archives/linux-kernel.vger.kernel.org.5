Return-Path: <linux-kernel+bounces-148617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA818A8526
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2411F21CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EECD1411E9;
	Wed, 17 Apr 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="uGv3Zi8p"
Received: from outbound10.mail.transip.nl (outbound10.mail.transip.nl [136.144.136.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BEE13D265;
	Wed, 17 Apr 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361507; cv=none; b=A3PKxHcF+tS0WcRNp4jGlkO+VKT4g/OitJO7wXj1gKQ5aO8QaVwWxYXZD0jn2Xnj1qQ5gvReS4F9Y5d/cC379Nn9rSEvhDkFrnR8vFbX1HVU9clWAdxT9n463m0PrR+HC+JXYWYjd1kqmrMoNSWoWSdrvsRODf9kLu/XzMXhMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361507; c=relaxed/simple;
	bh=t+qjWM6WqKQ78Oz7BhB/nstW8ocY0wkyhoC5eWgtaMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lXcuN6oM4lVE8V9g+jKUc01XtZ+iBA0TaUgExyFNyPW3M4GL8sas6Meei347NCdl2aOKUlr3InBSQr+yBrcxX/+kZd9YnsfDKLM2b8iF3Me9eY0a+XGfVy2UgvnU9oDl9asxokKYWGaZ60LNZfGhpxkM/Gg2ECDqsmZvainO1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=uGv3Zi8p; arc=none smtp.client-ip=136.144.136.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission13.mail.transip.nl (unknown [10.103.8.164])
	by outbound10.mail.transip.nl (Postfix) with ESMTP id 4VKMNB29c6zTPNQV;
	Wed, 17 Apr 2024 15:35:06 +0200 (CEST)
Received: from [127.0.1.1] (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission13.mail.transip.nl (Postfix) with ESMTPA id 4VKMN93D0Gz1xxC;
	Wed, 17 Apr 2024 15:35:05 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
Date: Wed, 17 Apr 2024 15:35:00 +0200
Subject: [PATCH] power: supply: max8903: configure USUS as output
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-max8903-v1-1-25d4dbf4ce9b@herrie.org>
X-B4-Tracking: v=1; b=H4sIAAPQH2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0Nz3dzECgtLA2PdxORUS/MU8xRjEwNzJaDqgqLUtMwKsEnRsbW1AEq
 3FsBZAAAA
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Wolsieffer <benwolsieffer@gmail.com>, 
 Herman van Hazendonk <github.com@herrie.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713360905; l=1957;
 i=github.com@herrie.org; s=20240417; h=from:subject:message-id;
 bh=t+qjWM6WqKQ78Oz7BhB/nstW8ocY0wkyhoC5eWgtaMk=;
 b=N3q9sr/Hrp55UApG4eNS6z0LV/G2ehm1oLOnjX2BlNxdz4c0gk8XL2UPEjQNDl0mcVex15LRX
 +CvR78NFtLhD6TiyCguqf2t3x4ZmLls4ZhwZVv0dyu5jBosGN6EAh7l
X-Developer-Key: i=github.com@herrie.org; a=ed25519;
 pk=YYxdq8fb5O9vhkW3n2dCH044FPZZO5718v/du7fRhFw=
X-Scanned-By: ClueGetter at submission13.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713360905; h=from:subject:to:cc:date:
 mime-version:content-type;
 bh=kSGhSxhNrtUmN9puZvQP3FJBm5BDqc34w0ZbNtdhuUg=;
 b=uGv3Zi8ppHjBs31fXy9/Wvm+jIJreoshHGttDWIdQvb8CG9mLt7vssuCy1OM4U5ZUBR2VC
 VMLaD2ubEB/g0fLCWgFH2P095qnNfZvogJjMVbgmmky7bJai3CaxlNjPoDU5DR6802/W1s
 3ChkiYiwuQ8/iD6HIYkj4AiF7lrlGAsTlSkDkoXGJx+7jRUbcmzbqLyxXyjnt5FcQjUXNS
 SFeimzRH3nl+vHITr7zOnLcM8WrYMmGNA5uVrR3VTAKiWsromqkXrQEI85R4uNTJQ9tjk8
 3RzO4eAZ+5l4CEJK31n5d2EjUzeMhtT8HuSDZd1OsuB7a5oRIYWDkzt4Ex7rPw==
X-Report-Abuse-To: abuse@transip.nl

The USUS pin was mistakenly configured as an input, when it should be an
output that specifies whether the USB power input is suspended. In addition
to fixing the pin mode, this patch also suspends the USB input when a DC
charger is connected, which should result in a slight reduction in USB
quiescent current.

Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 drivers/power/supply/max8903_charger.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/supply/max8903_charger.c
index e65d0141f260..15dc3a5239e2 100644
--- a/drivers/power/supply/max8903_charger.c
+++ b/drivers/power/supply/max8903_charger.c
@@ -102,6 +102,10 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
 	if (data->dcm)
 		gpiod_set_value(data->dcm, ta_in);
 
+	/* Set USB-Suspend 1:Suspended 0:Active */
+	if (data->usus)
+		gpiod_set_value(data->usus, ta_in);
+
 	/* Charger Enable / Disable */
 	if (data->cen) {
 		int val;
@@ -310,7 +314,15 @@ static int max8903_setup_gpios(struct platform_device *pdev)
 				     "failed to get FLT GPIO");
 	gpiod_set_consumer_name(data->flt, data->psy_desc.name);
 
-	data->usus = devm_gpiod_get_optional(dev, "usus", GPIOD_IN);
+	/*
+	 * Suspend the USB input if the DC charger is connected.
+	 *
+	 * The USUS line should be marked GPIO_ACTIVE_HIGH in the
+	 * device tree. Driving it low will enable the USB charger
+	 * input.
+	 */
+	flags = ta_in ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	data->usus = devm_gpiod_get_optional(dev, "usus", flags);
 	if (IS_ERR(data->usus))
 		return dev_err_probe(dev, PTR_ERR(data->usus),
 				     "failed to get USUS GPIO");

---
base-commit: 96fca68c4fbf77a8185eb10f7557e23352732ea2
change-id: 20240417-max8903-ace97d7d3407

Best regards,
-- 
Herman van Hazendonk <github.com@herrie.org>


