Return-Path: <linux-kernel+bounces-125400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9236A89257A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43491C2166B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DA76A014;
	Fri, 29 Mar 2024 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m8gmbQwA"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCCE225A8;
	Fri, 29 Mar 2024 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745114; cv=none; b=gcVc9bxNdTNxL+VjkAwh1uy0RJ+lslmvCyEcmebaDePNC24aKMYE2+3PZn/0wc/ALnA2Fg07SOUYVtkzRKUmL/GlqNsjxBJcpOLLEtvmuaPaxQj+p6JrrQG6Cfp9ScelAowpgSG8VhLrRgnbqfM4gXR7zjIaVe68PijVgjP3/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745114; c=relaxed/simple;
	bh=H/zfcDmDQXOBoDmRr5JMfKATjBOoYVT6ZhXGvrzN7JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rEpMiIpRun2CC+eDc83429XyHMtq/2pd7VrsY9Du1ipoAfQts2ktl8O7/o2YKlxHSZBZPI7wdXm/WLy4usyEytRZ5gV+3YsXnNNnhgDJ7oZ0hwlhGVdWyYWhGuPZEPfU8hMVCtXrlh56OSFnY0KJQwB0ML2oBarX6/UqmpQ0nss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m8gmbQwA; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0D97C0005;
	Fri, 29 Mar 2024 20:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711745107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ob7oexU0WPFKtD5q27b6YgS6moQs0+/GXcEyW5ksS0=;
	b=m8gmbQwADJ5OSc1wtL/EzI2JAcNXoG9SjWtLxhIM8dIic5Eff7C+KMnG+TADUJN4HlBKSi
	syk9AmWJK9UcYABy9ULe/us068ab2tLew6y/dSVZDZc33fwP8jKBNsdv30BcsZHdgpTmH7
	p9jIsDFnmYixZBnzu6jUIY+pUEaUTKgwvfxZvR7mggZfYHijzYmD8M7q3xFItynQYDBzqc
	t2ZnPBliShNJIAn2LhXH6O9TViesw6za1Bm7I9MzPp8KI8TZjmS8OQLrW0O1+8H2s1vYwL
	e0KibT/Py8FNRu6AUtlip1ri+buWtQeELOFaniO1D9jKpAd2Q7u5wMtZtYc8Pw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 29 Mar 2024 21:44:47 +0100
Subject: [PATCH] ASoC: codecs: rk3308: add dependency on OF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-rk3308-audio-codec-fix-warning-v1-1-b9d177fcd6c9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAD4oB2YC/x2NywqDMBAAf0X23IWYVKv9Fekhj1WXQiIb1ELw3
 xs8DgMzBTIJU4Z3U0Do4MwpVmgfDfjVxoWQQ2XQSj+V0SPK1xg1oN0DJ/QpkMeZf3haiRwX7Fr
 nupcmF8YeamQTqvoeTJ/r+gMib8qRcAAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

This driver is probed via device tree only, so depend on OF. Also remove
the unneeded of_match_ptr().

Fixes reported warnings:

  warning: 'rk3308_codec_of_match' defined but not used [-Wunused-const-variable=]
  warning: unused variable 'rk3308_codec_of_match' [-Wunused-const-variable]

Fixes: 9fdd7b45da18 ("arm64: defconfig: enable Rockchip RK3308 internal audio codec driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403271905.BYbGJiPi-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202403271907.0z0uuG5I-lkp@intel.com/
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 sound/soc/codecs/Kconfig        | 1 +
 sound/soc/codecs/rk3308_codec.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1c9d671a9848..7ee6c085bbc9 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1403,6 +1403,7 @@ config SND_SOC_PEB2466
 
 config SND_SOC_RK3308
 	tristate "Rockchip RK3308 audio CODEC"
+	depends on OF
 	select REGMAP_MMIO
 	help
 	  This is a device driver for the audio codec embedded in the
diff --git a/sound/soc/codecs/rk3308_codec.c b/sound/soc/codecs/rk3308_codec.c
index 9d3e4691a7b5..6b1cb92997b4 100644
--- a/sound/soc/codecs/rk3308_codec.c
+++ b/sound/soc/codecs/rk3308_codec.c
@@ -962,7 +962,7 @@ MODULE_DEVICE_TABLE(of, rk3308_codec_of_match);
 static struct platform_driver rk3308_codec_driver = {
 	.driver = {
 		.name = "rk3308-acodec",
-		.of_match_table = of_match_ptr(rk3308_codec_of_match),
+		.of_match_table = rk3308_codec_of_match,
 	},
 	.probe = rk3308_codec_platform_probe,
 };

---
base-commit: 534a5adb26b1924542f55643718a4b5ae601a4e5
change-id: 20240329-rk3308-audio-codec-fix-warning-51bb572ebd96

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


