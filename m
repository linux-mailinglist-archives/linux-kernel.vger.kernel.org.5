Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D158F759F39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGSUDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjGSUDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:03:45 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28F01FD8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:03:40 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1b055511f8bso59250fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689797020; x=1692389020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWSsNFba9oUv/FScx3zdSbWldRujPp4lpJvUZYeuiSU=;
        b=Wjxt1zwNO5cM+fN0gsoUnLeecCGrjqeRSyY2c7z0gRycqeSv3jSSKvVlyjU/98wiTk
         JyMAUd/rM0kh+Rklnlu6b7NE3fD/NWk95f0E1uQ/Hujs/HNnvGi19p73ycgiYadwcym3
         Vlzdrceion6WI/4k9LGb54YCMQy1Nbt/AnhHeEwsQWikLe5cCo6ge/nSVT23STI7pzze
         L/bO1aJkBnFbdWQAPZRj/f4CZkgXIiF41FeJVtygl4/XZDA7LGj+RgaxCTinJpKvUX6B
         hI37VlghRURpiGPCE2CPzOBlBS9UOoHJihTInm8LDjm9aAAUN91bdqsfsWD61gfAybT7
         RLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689797020; x=1692389020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWSsNFba9oUv/FScx3zdSbWldRujPp4lpJvUZYeuiSU=;
        b=GNCM8ZD4Mv55VebdcRE/np9wJo8lgf5yD4/1BVZ/an4+MOnN+i5QFuiAJfmVpYNmrr
         b4WrK6XvHWDOJM2a9OI1nZMOiaYqmOGMZzb36tYdgDZI9Vat0HQvVOySNgrAom5KjARz
         Rnw3zzESsDiRd3OuoKCNz8o3sirkgZ2aKwFAbF2gF6bBq9xm4g0wxIOyVFtYwCCnuCpo
         dEO0wZvL6aJZxemUnilNa8dDh3BJ+6rSan+edlOdyicMMo3sR4DSrDQ3RePu4PNS2Aob
         8emIwWWnYcghgDjBXssZsEt9s1cvS6vyLCjSsYM0TqdNPXBZ4OeVdAYhOkh9wvjQrlam
         TXHA==
X-Gm-Message-State: ABy/qLaLHRPGbXc6177sDpdzR79Q1V2hXCBPZw4deTFLdeX46qxjf3og
        832NEHQthUi/CU9EmVCbPow=
X-Google-Smtp-Source: APBJJlHVHGWOAVllrZYZzwR6gn4Ncl+JjHNugXsy56HPiv8isZ/45/aboLGsJABGZtS4EM7dsVSpBw==
X-Received: by 2002:a05:6870:e391:b0:1b0:1225:ffb5 with SMTP id x17-20020a056870e39100b001b01225ffb5mr2461352oad.16.1689797019957;
        Wed, 19 Jul 2023 13:03:39 -0700 (PDT)
Received: from policorp.cardumecowork.local ([177.91.232.53])
        by smtp.gmail.com with ESMTPSA id y4-20020a056870388400b001b3538afd01sm2238749oan.51.2023.07.19.13.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:03:39 -0700 (PDT)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        wtli@nuvoton.com, u.kleine-koenig@pengutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        edson.drosdeck@gmail.com
Subject: [PATCH] ASoC: nau8821: Add DMI quirk mechanism for active-high jack-detect
Date:   Wed, 19 Jul 2023 17:02:41 -0300
Message-Id: <20230719200241.4865-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Add a quirk mechanism to allow specifying that active-high jack-detection
should be used on platforms where this info is not available in devicetree.

And add an entry for the Positivo CW14Q01P-V2 to the DMI table, so that
jack-detection will work properly on this laptop.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/soc/codecs/nau8821.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index 96d75882b33a..ca6beb2d2649 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -25,6 +26,13 @@
 #include <sound/tlv.h>
 #include "nau8821.h"
 
+#define NAU8821_JD_ACTIVE_HIGH			BIT(0)
+
+static int nau8821_quirk;
+static int quirk_override = -1;
+module_param_named(quirk, quirk_override, uint, 0444);
+MODULE_PARM_DESC(quirk, "Board-specific quirk override");
+
 #define NAU_FREF_MAX 13500000
 #define NAU_FVCO_MAX 100000000
 #define NAU_FVCO_MIN 90000000
@@ -1792,6 +1800,33 @@ static int nau8821_setup_irq(struct nau8821 *nau8821)
 	return 0;
 }
 
+/* Please keep this list alphabetically sorted */
+static const struct dmi_system_id nau8821_quirk_table[] = {
+	{
+		/* Positivo CW14Q01P-V2 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P-V2"),
+		},
+		.driver_data = (void *)(NAU8821_JD_ACTIVE_HIGH),
+	},
+	{}
+};
+
+static void nau8821_check_quirks(void)
+{
+	const struct dmi_system_id *dmi_id;
+
+	if (quirk_override != -1) {
+		nau8821_quirk = quirk_override;
+		return;
+	}
+
+	dmi_id = dmi_first_match(nau8821_quirk_table);
+	if (dmi_id)
+		nau8821_quirk = (unsigned long)dmi_id->driver_data;
+}
+
 static int nau8821_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
@@ -1812,6 +1847,12 @@ static int nau8821_i2c_probe(struct i2c_client *i2c)
 
 	nau8821->dev = dev;
 	nau8821->irq = i2c->irq;
+
+	nau8821_check_quirks();
+
+	if (nau8821_quirk & NAU8821_JD_ACTIVE_HIGH)
+		nau8821->jkdet_polarity = 0;
+
 	nau8821_print_device_properties(nau8821);
 
 	nau8821_reset_chip(nau8821->regmap);
-- 
2.39.2

