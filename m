Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AA580F739
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377303AbjLLTwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377287AbjLLTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:52:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631EFA1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:52:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so57560265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702410765; x=1703015565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99wiKlmvZ0yOuhSozih/oH4sju55TXVCbZzwWmMlsn4=;
        b=HJHrDI/cHnITExOZei1a83padeACCLI7lw8DlVYlPmvyozz41C86sxzLX5lpEnBTiK
         Xq6X2LZgUd5km8IbFsMZ36xEapwm5O6a5d7b0KJkDs4LPMjNenRrhRNhu3BcAxEnmJpn
         yJodM9plU0we0hZsnnoyY5mhG1YnV3S0zc+ySvQOFwPhClcRWD9i98C0nUSAiL4wgp4F
         3X0ZowCL+PBgwEBKLnNPz0dYx5wH3iiTUMJjvzK+cYjYjatJdP8wnN/IQAG6kF9vAGnx
         3kOY5G2HWXkMP80CB2OF0SsIzH89wjqs5yY9ZH2BxDEdDi+aginZBtGdvqSfy63lr4x6
         ydsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702410765; x=1703015565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99wiKlmvZ0yOuhSozih/oH4sju55TXVCbZzwWmMlsn4=;
        b=Q8UXWHs4mqclVg5C/bM5cTFosari+J2v8saguzBD8jkqWY3cKH4UUN9EPVoS1YO3k7
         uhAHJFyWljo0tB5PtBoL7PgVVeXcerPTE/iwOKwP5fXQzuanm5PYpFfky36Nx2fKEE+q
         ZAuIq50fSJiMhuBQTjqcVEfPf5MThXnLp4gMXA/tg/SevnkEMm0vR/Wv/cY5OzAd5RfD
         WU3NvGgZluVp0veCqp4GEGKvF2wOevT5Bwm5JBYN2QPBS+tQBN/mtUnuNfSBvo5hMz3p
         tx3G3p08kRhnGJVxUu+e8eygEnwlcZ86bQglkdTc1L4IXYZkw393/3kGRk6v8hEe820P
         6ytw==
X-Gm-Message-State: AOJu0YzXG/NsJeMMBlCjibH93xQWCQFy/G5GeRIVfdtQ78C4x55btl9A
        aQxX2IHM6huNsqMIPlMl2Q==
X-Google-Smtp-Source: AGHT+IFOwj3THLrh+pxCdwE4NuSW8VVqSrjWAbsSdvG6RxQkyYixxBUkZ22EmkKXaDkJNOkQowBuOw==
X-Received: by 2002:a7b:cd87:0:b0:40c:2b4c:623b with SMTP id y7-20020a7bcd87000000b0040c2b4c623bmr3150026wmj.52.1702410764505;
        Tue, 12 Dec 2023 11:52:44 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id z4-20020adff1c4000000b003333af25cb2sm11488138wro.66.2023.12.12.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:52:44 -0800 (PST)
From:   Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, sbinding@opensource.cirrus.com
Cc:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Jasper Smet <josbeir@gmail.com>
Subject: [PATCH 1/1] ALSA: hda: cs35l41: Dell Fiorano add missing _DSD properties
Date:   Tue, 12 Dec 2023 20:52:43 +0100
Message-Id: <20231212195243.10666-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dell XPS 9530 (2023) has two SPI connected CS35L41 amplifiers, however
is missing _DSD properties, cs-gpios and has a firmware bug which caps SPI
controller's speed to unusable 3051Hz. This patch adds _DSD properties and
sets second cs-gpio. In case SPI speed bug is detected, it will not
initialize the device to avoid hangs on wake up.

Resolution of SPI speed bug requires either a patch to `intel-lpss.c` or an
UEFI update with corrected values from Dell. Tested with locally applied
patch to `intel-lpss` on multiple XPS 9530 devices.

Co-developed-by: Jasper Smet <josbeir@gmail.com>
Signed-off-by: Jasper Smet <josbeir@gmail.com>
Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index c83328971728..69446a794397 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -7,9 +7,55 @@
 // Author: Stefan Binding <sbinding@opensource.cirrus.com>
 
 #include <linux/gpio/consumer.h>
+#include <linux/spi/spi.h>
 #include <linux/string.h>
 #include "cs35l41_hda_property.h"
 
+/*
+ * Device 10280BEB (Dell XPS 9530) doesn't have _DSD at all. Moreover, pin that is typically
+ * used for `speaker_id` is missing. SPI's cs-gpios definitions are also missing.
+ */
+static int dell_fiorano_no_acpi(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+				const char *hid)
+{
+	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
+	struct spi_device *spi = to_spi_device(cs35l41->dev);
+
+	/*
+	 * 10280BEB has a firmware bug, which wrongly enables clock divider for intel-lpss
+	 * Resultant SPI clock is 100Mhz/32767=3051Hz, which leads to ~3 minute hang on boot/wake up
+	 * Avoid initializing device if lpss was not patched/fixed UEFI was not installed
+	 */
+	if (spi->max_speed_hz < CS35L41_SPI_MAX_FREQ) {
+		dev_err(cs35l41->dev, "SPI's max_speed_hz is capped at %u Hz, will not continue to avoid hanging\n",
+			spi->max_speed_hz);
+		return -EINVAL;
+	}
+
+	dev_info(cs35l41->dev, "Adding DSD properties for %s\n", cs35l41->acpi_subsystem_id);
+
+	/* check SPI address to assign the index */
+	cs35l41->index = id;
+	cs35l41->channel_index = 0;
+	/* 10280BEB is missing pin which is typically assigned to `spk-id-gpios` */
+	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, cs35l41->index, 2, -1);
+	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 1, GPIOD_OUT_LOW);
+
+	hw_cfg->spk_pos = cs35l41->index  ? 1 : 0;	// 0th L, 1st R
+	hw_cfg->bst_type = CS35L41_EXT_BOOST;
+	hw_cfg->gpio1.func = CS35l41_VSPK_SWITCH;
+	hw_cfg->gpio1.valid = true;
+	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
+	hw_cfg->gpio2.valid = true;
+	hw_cfg->valid = true;
+
+	/* Add second cs-gpio here */
+	if (cs35l41->index)
+		spi->cs_gpiod = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
+
+	return 0;
+}
+
 /*
  * Device CLSA010(0/1) doesn't have _DSD so a gpiod_get by the label reset won't work.
  * And devices created by serial-multi-instantiate don't have their device struct
@@ -92,6 +138,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
 	{ "CSC3551", "103C89C6", hp_vision_acpi_fix },
+	{ "CSC3551", "10280BEB", dell_fiorano_no_acpi },
 	{}
 };
 
-- 
2.40.1

