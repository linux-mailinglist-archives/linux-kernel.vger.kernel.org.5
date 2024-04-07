Return-Path: <linux-kernel+bounces-134305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0489B01C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCABB1F2131A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6BD17554;
	Sun,  7 Apr 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dob2hbNP"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC41DA24;
	Sun,  7 Apr 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712482605; cv=none; b=Ij8ydtp7NKvNeT8V3EFKUIKTUHd81ecjDeM6+dkqa3JvcTqKIDzfln/inoxpTpFtR7qJOmG/kkRtj2X58b5GXB1XT0feRojK9I1A9EeS3dyy6BPG7AUXhBbV5VKcSBH+XBg5GKZG0j0CkMTrDRaDbtLOray9NRXC1mqGvTyNUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712482605; c=relaxed/simple;
	bh=wgpJNewPWXD9i6tLtR4HaO6GRw96M7e3TdecHKMTUCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGzcTrAEvtp8G8Vvgt74JkUmIcf6b5YZJyj2dSEB8Xs9dRrK6eEbCxRpx8HhXXcdSNHMGMi1jY6nb1ae6bRcNBFeDubGbDNnJqzPr36sAREEO8y3gaLrjD1W2fZM4Io+jVjk/DTXnzHwlKWmYUptqrLka/dEx8r5L++3c8fWGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dob2hbNP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4379JLkC072936;
	Sun, 7 Apr 2024 04:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712481561;
	bh=+szOaIXyCWy7fYEn4i/T7YAu2JUdSZzf9/yPp3g/3mI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Dob2hbNPkvRYXmRRDmN9sGbycTmdNDZEThhaMfLlYKxiVHrhClb8Vjs6SsGd0ER9t
	 jKG8fV7Tuf6nwJ65Rh+QmVK/IIvUNh9jP9gPLCVDYxx5WKsnxaS5s7q6kqihrb23eL
	 10UhPb8BSO9i8D7W8mgxiein6sQIWagzq0LOT1Yc=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4379JL26091164
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 7 Apr 2024 04:19:21 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 7
 Apr 2024 04:19:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 7 Apr 2024 04:19:21 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.144])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4379IpWo079280;
	Sun, 7 Apr 2024 04:19:15 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <manisha.agrawal@ti.com>,
        <aviel@ti.com>, <hnagalla@ti.com>, <praneeth@ti.com>,
        <Baojun.Xu@fpt.com>, Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v9 3/4] ASoc: PCM6240: Add compile item for PCM6240 Family driver
Date: Sun, 7 Apr 2024 17:18:44 +0800
Message-ID: <20240407091846.1299-4-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240407091846.1299-1-shenghao-ding@ti.com>
References: <20240407091846.1299-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

PCM6240 driver implements a flexible and configurable setting for register
and filter coefficients, to one, two or even multiple PCM6240 Family Audio
chips.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v9:
 - No changes.
v8:
 - use some reasonable format of changelog.
 - Link to v2: https://lore.kernel.org/all/20240126035855.1785-3-shenghao-ding@ti.com/
---
 sound/soc/codecs/Kconfig  | 10 ++++++++++
 sound/soc/codecs/Makefile |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f78ea2f86fa6..0c35cdfd4a47 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -179,6 +179,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_PCM5102A
 	imply SND_SOC_PCM512x_I2C
 	imply SND_SOC_PCM512x_SPI
+	imply SND_SOC_PCM6240
 	imply SND_SOC_PEB2466
 	imply SND_SOC_RK3328
 	imply SND_SOC_RK817
@@ -1422,6 +1423,15 @@ config SND_SOC_PCM512x_SPI
 	select SND_SOC_PCM512x
 	select REGMAP_SPI
 
+config SND_SOC_PCM6240
+	tristate "Texas Instruments PCM6240 Family Audio chips based on I2C"
+	depends on I2C
+	help
+	  Enable support for Texas Instruments PCM6240 Family Audio chips.
+	  Note the PCM6240 driver implements a flexible and configurable
+	  setting for register and filter coefficients, to one, two or
+	  even multiple PCM6240 Family Audio chips.
+
 config SND_SOC_PEB2466
 	tristate "Infineon PEB2466 quad PCM codec"
 	depends on SPI
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 7c075539dc47..5553155b843b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -204,6 +204,7 @@ snd-soc-pcm5102a-objs := pcm5102a.o
 snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
 snd-soc-pcm512x-spi-objs := pcm512x-spi.o
+snd-soc-pcm6240-objs := pcm6240.o
 snd-soc-peb2466-objs := peb2466.o
 snd-soc-rk3328-objs := rk3328_codec.o
 snd-soc-rk817-objs := rk817_codec.o
@@ -594,6 +595,7 @@ obj-$(CONFIG_SND_SOC_PCM5102A)	+= snd-soc-pcm5102a.o
 obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
+obj-$(CONFIG_SND_SOC_PCM6240)	+= snd-soc-pcm6240.o
 obj-$(CONFIG_SND_SOC_PEB2466)	+= snd-soc-peb2466.o
 obj-$(CONFIG_SND_SOC_RK3328)	+= snd-soc-rk3328.o
 obj-$(CONFIG_SND_SOC_RK817)	+= snd-soc-rk817.o
-- 
2.35.7


