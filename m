Return-Path: <linux-kernel+bounces-44055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE8841CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FAF2893AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDB253E05;
	Tue, 30 Jan 2024 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSMA3TKg"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9DB5381;
	Tue, 30 Jan 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600269; cv=none; b=AtotZgbKXQj1tFyjocustYmoFnybpKTczrCyaoDVbllYXZpuxBvVXBxzvBbQRi3ID0E1+FK1M/0YzT2ASIzSOZ94PXZZya6Qiwm1WifHxUXR/VF0qzcIaHSTFiR1NRoVmI+9VEferW6SorpyM9mq/vljgbOQBAn3Uy87zIz5VCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600269; c=relaxed/simple;
	bh=CR6PVZSHXcm0U7w7W+xSrJPsQWVADdLWHgQjiYpzOOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhXB0zJeg1oNtW/fjapwactwlZGgSRFIg1ccMf8uTPg7lacM02loN1PbSC+WbQN3w4PwRuW+Us9zd6zFXBZnOrTA7WA9d4XDo8u0RgDjfUofiUWFOyuyK1yXFbiUf1Jn6gWj+IVG4kyAkMPkkansk5Mke89j+GangXRuXS6RO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSMA3TKg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a318ccfe412so318052466b.1;
        Mon, 29 Jan 2024 23:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706600266; x=1707205066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1lwCQX8UDxXeosMqKgniJglHObjD45TSdgEX5mn5pQ=;
        b=FSMA3TKgvN1kP7+2RJ6mT1wntyyLKcjjtKylx/XkphAXh9dfxrlZJf5ghLw1LXv8ux
         U4D+FRa1b47/rJjcNTz9gUdZtF/Qui9RumrMrgVguu5SQbcSINHXXU2j6Yyv3/xbAZ1G
         VwaDmBn+UmjAqE+pkpMDM6fnJ5nLlEyCekWgBELzLVRttDuxi2ena0ptIlRtXGpu7SBx
         lffY8tp8o63vLqeDMYSUc7cMQLyqdgBerHCpexuzigjg5RRI7yYU4DE1UHjJCVgPq/nq
         /HHZNTv5Ns62q3eoHM4hvQihiRD0a6U/FAuC8rvt4gz5C4q0xlNpl+97ufBSJRyotIy6
         WVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706600266; x=1707205066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1lwCQX8UDxXeosMqKgniJglHObjD45TSdgEX5mn5pQ=;
        b=Ihl/3cC3JoGw8DK+mBf1ok5ieLtHVvqoZkORVf3Cjft3S3vXchVn6YjDTLM+h5PwyW
         v3J+wtEC5htlJ0xOaFMpKzbRGb2aHyjcj3ML/xobFRI8npGeKyud0CFC/afsO95kmI8M
         9mlfqgvqtYXtVXMWpzzXyHQxn++O5TEil+7JofcbuW6sXw9R6ra9778a7LRM166AW29B
         rjtyviyvsH7pil1npiEI8B9GpJ0T4N1qAMM9PxJME0g/W4lcyk5Q7sTb57n+c8kIF+/X
         e8/5teSzyWAu55uGmxhsMND+ZeYzWxfYcLPXpXLegXQASWEvVfpZxNy+gTyomVyfOzy4
         j0kQ==
X-Gm-Message-State: AOJu0YwsYrV68EOZtjWneot4DknG7O2xwOfT0GyuYNgCxvFrhzRkbZa5
	Ft2G1vCw5RKn3GUX4TbqdMKwcfXmBlb6JZklgYbdGQYbqqRvneeHfV617t07i5MeYg==
X-Google-Smtp-Source: AGHT+IFvoTf4fBcDm97p0pWq1BAJp1yu3JvbpLXYKp6lSvqJJaB5veMi5dGg36t6X4IWZrQ/jSER4w==
X-Received: by 2002:a17:906:e0ce:b0:a35:8278:3288 with SMTP id gl14-20020a170906e0ce00b00a3582783288mr4496103ejb.35.1706600265723;
        Mon, 29 Jan 2024 23:37:45 -0800 (PST)
Received: from localhost.localdomain (IN-84-15-186-107.bitemobile.lt. [84.15.186.107])
        by smtp.gmail.com with ESMTPSA id e5-20020a1709062c0500b00a3612ac991dsm620220ejh.143.2024.01.29.23.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 23:37:45 -0800 (PST)
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
To: linus.walleij@linaro.org,
	u.kleine-koenig@pengutronix.de,
	radim.pavlik@tbs-biometrics.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arturas Moskvinas <arturas.moskvinas@gmail.com>
Subject: [PATCH] pinctrl: mcp23s08: Check only GPIOs which have interrupts enabled
Date: Tue, 30 Jan 2024 09:37:10 +0200
Message-ID: <20240130073710.10110-1-arturas.moskvinas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPINTEN register contains information about GPIOs with enabled
interrupts no need to check other GPIOs for changes.

Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 4551575e4e7d..bfa933284e84 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -375,7 +375,8 @@ mcp23s08_direction_output(struct gpio_chip *chip, unsigned offset, int value)
 static irqreturn_t mcp23s08_irq(int irq, void *data)
 {
 	struct mcp23s08 *mcp = data;
-	int intcap, intcon, intf, i, gpio, gpio_orig, intcap_mask, defval;
+	int intcap, intcon, intf, i, gpio, gpio_orig, intcap_mask, defval, gpinten;
+	unsigned long int enabled_interrupts;
 	unsigned int child_irq;
 	bool intf_set, intcap_changed, gpio_bit_changed,
 		defval_changed, gpio_set;
@@ -395,6 +396,10 @@ static irqreturn_t mcp23s08_irq(int irq, void *data)
 	if (mcp_read(mcp, MCP_INTCON, &intcon))
 		goto unlock;
 
+	if (mcp_read(mcp, MCP_GPINTEN, &gpinten))
+		goto unlock;
+	enabled_interrupts = gpinten;
+
 	if (mcp_read(mcp, MCP_DEFVAL, &defval))
 		goto unlock;
 
@@ -410,9 +415,10 @@ static irqreturn_t mcp23s08_irq(int irq, void *data)
 		"intcap 0x%04X intf 0x%04X gpio_orig 0x%04X gpio 0x%04X\n",
 		intcap, intf, gpio_orig, gpio);
 
-	for (i = 0; i < mcp->chip.ngpio; i++) {
-		/* We must check all of the inputs on the chip,
-		 * otherwise we may not notice a change on >=2 pins.
+	for_each_set_bit(i, &enabled_interrupts, mcp->chip.ngpio) {
+		/* We must check all of the inputs with enabled interrupts
+		 * on the chip, otherwise we may not notice a change
+		 * on >=2 pins.
 		 *
 		 * On at least the mcp23s17, INTCAP is only updated
 		 * one byte at a time(INTCAPA and INTCAPB are

base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.43.0


