Return-Path: <linux-kernel+bounces-164650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD28B80AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5799328553D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA39199E95;
	Tue, 30 Apr 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="e9vL+6Zr"
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524612B73;
	Tue, 30 Apr 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505839; cv=none; b=gzARsr8ehsalsgOo33vcrO9OWdPEpjqMhYi867NcIc3z+/69BJLwI5eurVdpqCxVqNNmJVTFSmBUxBE1kZDPjbbZwhsL6qOqkcGop6uNworHg+pyCser3RYluMZ1XSEoRTkqmVG9bLUFQsb/NkHDbNg7R2a58HXYg+3NhOLWHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505839; c=relaxed/simple;
	bh=u6JMWq3KGYar+o2HDcMvI/GFxB4sUHEoyhTzUKj4zXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkhklNYEbq8i92GRKMXL41BcihBiwig3Mr6fM09Yxa6/NdgVK3ZvN50BL8Wtxs89Fevze2P19dSOlXPs/Ds6eBG6jrmwR8NYKwvtX8SQfhAyszxmESqJB3B/ztS0V6+BSVSdTYJas95eDz+7/K9urGkX5rlJsZ5/mcwdnUzyV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=e9vL+6Zr; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 1tGXsqFYLGyax1tGfss3e5; Tue, 30 Apr 2024 21:35:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714505758;
	bh=KS+TeFbjBWX9rgIDk409K2MoYqtyjLkv3GQe1jxfQhU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=e9vL+6ZrgjJ68/ouUB/vmJWJpMlplejctB6eF/dWgiHgPT4QjCTGD5HI4dMFlX7qf
	 bea9axvhuGIBqjh92H+7+85/GE/lg+dGQrLXFRQsfrYhtnn0vod6lhglae4o+Phnml
	 /DUG0aTQvR2K+X4R6KSOONbyAR4j+L9dlTOFmFczhtO8ruaO9HuYHUOHvD52n07Fkd
	 dQ41jZV1e6kTI0OFmn54cQcKZc6LyR5GUA+7sfXNpo7W0Ye5BH1I4ohtPxsUgdX6wr
	 rzuDyr3xW8R8T6YE/NHSpHdgUsUQe9MziyZiJ3Ha4OpSEXS5bsru9oDj5pOCei5OdM
	 vsV9NjI9XVLmw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 30 Apr 2024 21:35:58 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	openbmc@lists.ozlabs.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (npcm750-pwm-fan) Remove another unused field in struct npcm7xx_cooling_device
Date: Tue, 30 Apr 2024 21:35:38 +0200
Message-ID: <2ff738663d40ac5ae3d0b4d2e688ff7e36032be8.1714505655.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <74eee8aa739f94b8c6425ce3e37a427ca92243ea.1714505655.git.christophe.jaillet@wanadoo.fr>
References: <74eee8aa739f94b8c6425ce3e37a427ca92243ea.1714505655.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct npcm7xx_cooling_device", the 'pwm_clk_freq' field is only
written and never used.

Remove it and update npcm7xx_pwm_init() accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/hwmon/npcm750-pwm-fan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 6d92a3b89198..bc8db1dc595d 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -196,7 +196,6 @@ struct npcm7xx_pwm_fan_data {
 	void __iomem *pwm_base;
 	void __iomem *fan_base;
 	int pwm_modules;
-	unsigned long pwm_clk_freq;
 	struct clk *pwm_clk;
 	struct clk *fan_clk;
 	struct mutex pwm_lock[NPCM7XX_PWM_MAX_MODULES];
@@ -691,11 +690,12 @@ static u32 npcm7xx_pwm_init(struct npcm7xx_pwm_fan_data *data)
 {
 	int m, ch;
 	u32 prescale_val, output_freq;
+	unsigned long pwm_clk_freq;
 
-	data->pwm_clk_freq = clk_get_rate(data->pwm_clk);
+	pwm_clk_freq = clk_get_rate(data->pwm_clk);
 
 	/* Adjust NPCM7xx PWMs output frequency to ~25Khz */
-	output_freq = data->pwm_clk_freq / PWN_CNT_DEFAULT;
+	output_freq = pwm_clk_freq / PWN_CNT_DEFAULT;
 	prescale_val = DIV_ROUND_CLOSEST(output_freq, PWM_OUTPUT_FREQ_25KHZ);
 
 	/* If prescale_val = 0, then the prescale output clock is stopped */
-- 
2.44.0


