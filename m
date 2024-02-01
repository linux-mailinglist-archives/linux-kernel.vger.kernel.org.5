Return-Path: <linux-kernel+bounces-48296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29D8459C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05F91C242B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBFE5D488;
	Thu,  1 Feb 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc06Ur2D"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A45337E;
	Thu,  1 Feb 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796931; cv=none; b=sKM6FAqX+VFYK5bTe7AoW2JaqkjpUQ/gVf4O4QlFyt6nrUFIQ2KTXAWyCst1YY/Ae9jsUg7i5m8KhrDuGrCrn5cjR/j/pXLRug4PLtUF92/hc7luAdObmGS8Mw+Qi1eY4dyc7wos3XjBtL9jjFOJsvOUd4s4yrd4V6Fx3MLuW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796931; c=relaxed/simple;
	bh=gJfEYE0597179ZmLxN/fGRj5iBfPVSnPPdFVqXYTudA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMkmgO8TQlvHvvXlECmHJzjjpeZ/Lf+lZLVaZFGO/Z3fzmW++NgEWV8fVhEZyyEF2my7ojbxY079gvSepjBrOdnFlP11N7UdHROzQexcFLSbedAqzh7+EEqCRkst8uH2d0I/97gbroemhZ5X7KhxAryHmQNrabcMD7UTdXMUy4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kc06Ur2D; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a359e6fde44so100863566b.3;
        Thu, 01 Feb 2024 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796928; x=1707401728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GG4y8pUYqdaN9W5dgoBJ87G9KYZX8k/K4851BbIdGxs=;
        b=kc06Ur2DDzu1T43BLPa1z9x8G70LwnHG5gHSV18eD2GjYVaC1GjxICmGaIwudMTjKC
         njTLyDbgTWABQS+UGOBCc3VdC9iZbFrvTUiEyNkF9BvIU0XQGr5G8xJ8tnSryWSBKdH7
         Yhg1N3czQintaZFiM+qn26L8c0I9UaDZ1BR095P2+DXt0fo/8P+MVY7+QODtrLON6Z5I
         cgEdqqXp5iOJylT8k2gKfy+7fW7Cd2u18wnJekuNQeWPFKh48w058Gw/N19lhAfHSnQv
         FZVzA6DExUBZbtcZeGG5sqWqEzE6zhx/T+YdxfXZdpcIOPzI2eqFQbsX9Zw9D8FY/dSS
         81oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796928; x=1707401728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GG4y8pUYqdaN9W5dgoBJ87G9KYZX8k/K4851BbIdGxs=;
        b=ovqzcxVca27myJrISfWF35j6U/lWYATbCUVF/DeyOHfzvOhOohMOQNfHK6/1Wci2d3
         eLQJwKq1vGQb38pol8DvwMRKMLkz5li87dvDcwGX3g5jl85WEKHcWYSFoS5j2FWE8Ckl
         hlJy63rb+1T0OOLC4jRjVfatrbopkJfw43VfRzG2DMi3TfH25hQa/xgGGPZYvQp7vr8L
         wT0sQFY1hzwi79VAToXxHeLvV5afeH2DpZbnUYzns/bB/3LA2stykEF99tNvKUTo6bm5
         9saxxk/mNCxgO8/BMDOP3vfB2Qpc9L+R28mzrlvT26Kw3W4Q4zVVuN+/FvsSNFmiENNM
         xtsw==
X-Gm-Message-State: AOJu0Yz6riPJrV0fMlcZrRNERoguVRQO1pnX2pMWLlzSops5gHVCeY7S
	DYExswyVlXh6kvLsz9foBEeCT3Qmj2jd1QDtJD+tTkiOG6qb0xGT
X-Google-Smtp-Source: AGHT+IF1v1vf9i2YDCcd5GDPJC7NAu8AsCZtL/xJaObagkcVDqvbmfhrYrrShyiAIXrTWubw1FImmA==
X-Received: by 2002:a17:906:fa8e:b0:a36:c338:49b with SMTP id lt14-20020a170906fa8e00b00a36c338049bmr1355670ejb.60.1706796927667;
        Thu, 01 Feb 2024 06:15:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVGlzpTqZPJvV2dIsLIgxHvQ5rJvfzrGvea6V3gMulB7a/mEguyZIjW1IYI3T5BVUiZJQPiDUuiV6LWTzuwW2VANSLCdASbKYW4Csy2w2K7xibKw6bVVe8gnIJjntn+AbKQpDHKeow7GzAOI4cotciekraO5fH8wknYND91T/xXMp2t5UxCU6xuI0IDH8hFXilvGsZWvOtG0nKXCitWuAOMGwMkTW7o2T9BFLIyv6JCKcdUxVMG4zp/Z4RyN7U8U7TIub9heemENQmiJNhZs4OgNLdDaVsDuR/y91PFIgQ8zcOUmGIQt3thAN8J0pTdrya//xfPmmwZ+N62PGx1guZPUBN55x5bZi8E6XDQ4Qah1kq9M5lK2g==
Received: from localhost.localdomain (IN-84-15-186-107.bitemobile.lt. [84.15.186.107])
        by smtp.gmail.com with ESMTPSA id kb4-20020a1709070f8400b00a3493e2dbfesm7185784ejc.53.2024.02.01.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:15:27 -0800 (PST)
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
To: linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	akaessens@gmail.com,
	thomas.preston@codethink.co.uk,
	andriy.shevchenko@linux.intel.com,
	preid@electromag.com.au,
	u.kleine-koenig@pengutronix.de
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arturas Moskvinas <arturas.moskvinas@gmail.com>
Subject: [PATCH v2] pinctrl: mcp23s08: Check only GPIOs which have interrupts enabled
Date: Thu,  1 Feb 2024 16:14:07 +0200
Message-ID: <20240201141406.32484-2-arturas.moskvinas@gmail.com>
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
 drivers/pinctrl/pinctrl-mcp23s08.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 4551575e4e7d..38c3a14c8b58 100644
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
@@ -395,6 +396,9 @@ static irqreturn_t mcp23s08_irq(int irq, void *data)
 	if (mcp_read(mcp, MCP_INTCON, &intcon))
 		goto unlock;
 
+	if (mcp_read(mcp, MCP_GPINTEN, &gpinten))
+		goto unlock;
+
 	if (mcp_read(mcp, MCP_DEFVAL, &defval))
 		goto unlock;
 
@@ -410,9 +414,12 @@ static irqreturn_t mcp23s08_irq(int irq, void *data)
 		"intcap 0x%04X intf 0x%04X gpio_orig 0x%04X gpio 0x%04X\n",
 		intcap, intf, gpio_orig, gpio);
 
-	for (i = 0; i < mcp->chip.ngpio; i++) {
-		/* We must check all of the inputs on the chip,
-		 * otherwise we may not notice a change on >=2 pins.
+	enabled_interrupts = gpinten;
+	for_each_set_bit(i, &enabled_interrupts, mcp->chip.ngpio) {
+		/*
+		 * We must check all of the inputs with enabled interrupts
+		 * on the chip, otherwise we may not notice a change
+		 * on more than one pin.
 		 *
 		 * On at least the mcp23s17, INTCAP is only updated
 		 * one byte at a time(INTCAPA and INTCAPB are

base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.43.0


