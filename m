Return-Path: <linux-kernel+bounces-129631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85F0896D97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163FB1C2117A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF714198A;
	Wed,  3 Apr 2024 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PH9oOCug"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7B136E3E;
	Wed,  3 Apr 2024 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142221; cv=none; b=H67dKGFeWcbs/77axGCPWBWssCN22sgtnHWOSfTzPDaGeuwdcwKILHAgxp/6jFP2TMJHjJxJOCNOVySF9X1VnIpcvVar+LkNb5w2FJMiw0GXDbgJ/ATpbV9r9NZcjWgSVUFoboylRngoc2SrS8muoH37tD0NUOfKbf6YXqvsY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142221; c=relaxed/simple;
	bh=C1mMyUpYX6wiqaj1KKueawdDp6xbLRZvPGadLfNBjCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3SMdbboScF8rwYr2ODRX7s91tMfC4WvxJoYNSD/hDsVX3Zjeypt0yzDK5Zm5OtUrAQmXzWevYNZXmIeueodFDT/IOfq1cKIRqF/AZWqxMXd/xcT0B8qlEcXV2k08LDbYLpl3xupsxlYuFsZgbrGA1eNHkIH0ISJN/7HzOOWHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PH9oOCug; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C8701C0006;
	Wed,  3 Apr 2024 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712142213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxM7m7iXQdCV00+C0efugqMkr8tvqMWbpq9aXMsNUhI=;
	b=PH9oOCugG1kEhsFe8oyieg1ZsBCVvR8TNUXCgT+67IQ3nV16N3USEHlkA+OyZwdOSCdZyj
	Tp8Q02g0a3ia/vCfxTmuDBka1lt0V87lwG6hxjHLQbr4whcwZ/FEENnhYNnYPvIVziDIYy
	wFfxYElRQItP7ZLE1eLgRb1YsEO0X84lQL2sVuJIs/uOA13osy1eghw4FxPLlkUp8DQOw7
	pqyc2RYibNYiT79DCoRDwg8EHD1HGG9MLqj9Lzs5fYrecxYCRgoYsWNyOYvyZrB5LeQ84Y
	vyGhEmmg8BJY8WMBmbyP6zdoKCph8obl58PlDqk4wV2ThAO3aS8yxKcxJ+XMzg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 03 Apr 2024 13:03:19 +0200
Subject: [PATCH v2 2/2] ASoC: codecs: rk3308: depend on ARM64 ||
 COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rk3308-audio-codec-fix-warning-v2-2-816bae4c1dc5@bootlin.com>
References: <20240403-rk3308-audio-codec-fix-warning-v2-0-816bae4c1dc5@bootlin.com>
In-Reply-To: <20240403-rk3308-audio-codec-fix-warning-v2-0-816bae4c1dc5@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

This codec is only known to exist in the RK3308 ARM64 SoC, so depend on it
except for compile test cases. Note that the driver won't probe without
CONFIG_OF, but ARM64 selects OF already so it is not needed.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1752814fffdd..4e47bb6850aa 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1436,6 +1436,7 @@ config SND_SOC_PEB2466
 
 config SND_SOC_RK3308
 	tristate "Rockchip RK3308 audio CODEC"
+	depends on ARM64 || COMPILE_TEST
 	select REGMAP_MMIO
 	help
 	  This is a device driver for the audio codec embedded in the

-- 
2.34.1


