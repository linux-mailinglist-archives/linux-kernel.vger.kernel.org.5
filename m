Return-Path: <linux-kernel+bounces-164652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE18B80C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D15284F63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCA199E9D;
	Tue, 30 Apr 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Y6qkihPR"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F2194C9D;
	Tue, 30 Apr 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506289; cv=none; b=uGqetebOp5hhi3gn8zC0+iWB5TO+7ZUj5zbd/68TBOMMYwYQGDROwcY0gKwfmjOBtN7e3licKXKx/VxjJax17CLgPEr6QRTVeUwIGE7r+C45mHB+/neb3VYAjqHIIEUhmJ0CsTlQMQJPrhyOENud/tLlNCs2Gcm1npzMpgC5bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506289; c=relaxed/simple;
	bh=Yh/0kVomvA82YnCAEzDosws8iXCLFew+YFzQx0chFOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFFWHWAFDhUePmCUObxjVzJm5Gfdjq+PNgl2NNFjqR+rJtSdLwsc6NPU71zGw+z62tZOU/DqqqXeA9zPhkE1e9fituLAH6d+M1bFBS0fvoLukqM1rDHiPyC/7fXhRfdOX6k1TUcPXz5jyMW7ZnOXdwudzaMmS+65/nWDK8i5R1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Y6qkihPR; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 1tGXsqFYLGyax1tGXss3dW; Tue, 30 Apr 2024 21:35:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714505751;
	bh=skKo5kEoG79r6I+m+tXF3MUHJgIN3Agmwa3aOsSEA5o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Y6qkihPRSdTI4mGkFmI3rkql6GZAFYWajX5CbOBz7NPrpMB0fZaaMx1OU0j4milP/
	 nBPv4d1a3bzLe6GaH6/mVP6jypYcEFUD9oI9eQVNlwEoSzipjv6GzGh2ZxUZ0HdL+b
	 soQNlzkUmREM+hqL4f8iYZjoEkOUDVKz+3FEhTyDaVCJn2hrtCH5lV/+yz1SiYf6PO
	 wcilfOX7XPFSrqVWGPPUb5ilCM6jtGv6DV+b7QHBrB4DAmK871udognHxQV57EZXxS
	 We9vC8Pzli4CGyFrum4lO/Lyo4Zn2qE7KT3mPfVSyM9dTRVyVJd4b96TJy9Knh/eX6
	 DXiY6czAp7JQw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 30 Apr 2024 21:35:51 +0200
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
Subject: [PATCH 1/2] hwmon: (npcm750-pwm-fan) Remove an unused field in struct npcm7xx_cooling_device
Date: Tue, 30 Apr 2024 21:35:37 +0200
Message-ID: <74eee8aa739f94b8c6425ce3e37a427ca92243ea.1714505655.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct npcm7xx_cooling_device", the 'fan_clk_freq' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This field was added in the initial commit f1fd4a4db777 ("hwmon: Add
NPCM7xx PWM and Fan driver") but was never used.
---
 drivers/hwmon/npcm750-pwm-fan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 904816abb7c4..6d92a3b89198 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -197,7 +197,6 @@ struct npcm7xx_pwm_fan_data {
 	void __iomem *fan_base;
 	int pwm_modules;
 	unsigned long pwm_clk_freq;
-	unsigned long fan_clk_freq;
 	struct clk *pwm_clk;
 	struct clk *fan_clk;
 	struct mutex pwm_lock[NPCM7XX_PWM_MAX_MODULES];
-- 
2.44.0


