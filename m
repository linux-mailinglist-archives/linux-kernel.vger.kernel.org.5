Return-Path: <linux-kernel+bounces-59027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F2D84F00D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDC72846B1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393E57306;
	Fri,  9 Feb 2024 05:59:48 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970957305;
	Fri,  9 Feb 2024 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707458388; cv=none; b=MQNlGm6wHlFuV6Wei/wFbxGOS+A4M532KmxzEUAWUqL3CmD8iWCD5jdLBN460Y6S/91MAugQDYjb613mjFURUxty2OTBS0VMwyCIKoGKYxSXPjftyES8oM2B/w670HEBiSvrMvXklePSpmI2MpDH/WneeasPoC+FsC9trhYzkCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707458388; c=relaxed/simple;
	bh=fI6cNqUhngSVtPXix0fMo3wRWmm06WucGdKiFh3SYuw=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=HVMKHPwsIEC/IGojQEgBxGzccPr76eYPwSNus+ejeV2Oyi0qliWELfm9mPQoarZQcUYp96PklyhAGJ45o7wpI0n+MKK/iPXnYM20ahENwYFbVHRpxDpCwsvGjm7kyAbR5NJRQt2sa6LvTOAhGSX+qZEcQfm6c7LRIxq66ytaNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69e54.dsl.pool.telekom.hu [::ffff:81.182.158.84])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071F9D.0000000065C5BF49.001B3A7F; Fri, 09 Feb 2024 06:59:37 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v4] ASoC: tas2781: remove unused acpi_subysystem_id
Date: Fri,  9 Feb 2024 06:59:34 +0100
Message-ID: <454639336be28d2b50343e9c8366a56b0975e31d.1707456753.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

The acpi_subysystem_id is only written and freed, not read, so
unnecessary.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
Changes since v3:
- remove Fixes and CC tags from commit message
- remove In-Reply-To from header
- rebase onto for-next
- link to v3: https://lore.kernel.org/lkml/7f056a4148fec176812ff6cc490860bf565b161c.1707255917.git.soyer@irl.hu/
Changes since v2: remove sub from tas2781_read_acpi
Changes since v1: remove physdev from tas2781_read_acpi
---
 include/sound/tas2781.h           |  1 -
 sound/pci/hda/tas2781_hda_i2c.c   | 12 ------------
 sound/soc/codecs/tas2781-comlib.c |  1 -
 3 files changed, 14 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 9aff384941de..99ca3e401fd1 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -103,7 +103,6 @@ struct tasdevice_priv {
 	struct tm tm;
 
 	enum device_catlog_id catlog_id;
-	const char *acpi_subsystem_id;
 	unsigned char cal_binaryname[TASDEVICE_MAX_CHANNELS][64];
 	unsigned char crc8_lkp_tbl[CRC8_TABLE_SIZE];
 	unsigned char coef_binaryname[64];
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 1bfb00102a77..4c9a788c3501 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -111,9 +111,7 @@ static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
 static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 {
 	struct acpi_device *adev;
-	struct device *physdev;
 	LIST_HEAD(resources);
-	const char *sub;
 	int ret;
 
 	adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
@@ -129,18 +127,8 @@ static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 
 	acpi_dev_free_resource_list(&resources);
 	strscpy(p->dev_name, hid, sizeof(p->dev_name));
-	physdev = get_device(acpi_get_first_physical_node(adev));
 	acpi_dev_put(adev);
 
-	/* No side-effect to the playback even if subsystem_id is NULL*/
-	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
-	if (IS_ERR(sub))
-		sub = NULL;
-
-	p->acpi_subsystem_id = sub;
-
-	put_device(physdev);
-
 	return 0;
 
 err:
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 5d0e5348b361..3aa81514dad7 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -408,7 +408,6 @@ void tasdevice_remove(struct tasdevice_priv *tas_priv)
 {
 	if (gpio_is_valid(tas_priv->irq_info.irq_gpio))
 		gpio_free(tas_priv->irq_info.irq_gpio);
-	kfree(tas_priv->acpi_subsystem_id);
 	mutex_destroy(&tas_priv->codec_lock);
 }
 EXPORT_SYMBOL_GPL(tasdevice_remove);

base-commit: aa0dc84513e94a6ee2df360cf5e3b207abf734e0
-- 
2.43.0


