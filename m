Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9F47874BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242320AbjHXP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242357AbjHXP6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:58:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E580E50
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:58:16 -0700 (PDT)
Received: from fabians-envy.localnet ([81.95.8.245]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MzyAy-1plCp73rPC-00wzta; Thu, 24 Aug 2023 17:57:51 +0200
From:   Fabian Vogt <fabian@ritter-vogt.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        SungHwan Jung <onenowy@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for mute LEDs on HP ENVY x360 15-eu0xxx
Date:   Thu, 24 Aug 2023 17:57:50 +0200
Message-ID: <4504056.LvFx2qVVIh@fabians-envy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:F0a+FMLpOhqb6tBysEiC0NzEclV4tBUJelYJvukP8488vDO2TH5
 kXQUGCzfSRVJ6HjIVnxodwL4dbJA1Ll1J0d0hpZf9RkT7hKa/gM6btNTOfLNoInja5tkhOn
 ag8i/OxI9vE1f+10m8LEUBpqUBjxenTTmFA9kDg4nIAx5B1NRxTNFGlkXLBD+WqjX4qepNd
 6qQAmeluBcW2sH8D2GsDA==
UI-OutboundReport: notjunk:1;M01:P0:9KX+/T3gwUQ=;QLU3XaUU4ZunHc20nIkCauAsB0d
 QzsbwTNEGhZmqvqdvevZSkOlYrjR+hrN5/YgqsHxEaE8jsHgXGKo10unnqVjP8UgV0t5d1cxF
 J507oJBs3VPrWvZXUdBJSSd6lDwFU1pNLUuQkAzzOG2CcWUhExt8jq2FTDBh/j4divoNn0i9/
 ekbRjQ68ZeM1w5Ffob8W3TP5Vf22FgWxS+9tHndmfT1IIDZTaYCMYMwKhd5zvohrJ5VEZdM0c
 in9dhKPccHq2vlBqMI5HOc8QqTW0pqmvMrJNQAgQMHCeu5nw7q0jsDmw5d2JRkxI2uuU3c+XV
 c6p/81aSzxbzdo5RnzAhzH+zm91LXtWlFM6xZw7TJoBDt/Raz5ifVb+YTvonvpRyBvc5Qelx2
 H38IT5Y8rrpNeW8/8PQ18BlH38GhUuW+YfmJH2MrYWnThUuIq/+ZA1KpsDyKKbK+yRLiuAQhk
 2QMVipusdWgMBShEs8kC9FXdzcC4MV7PVV4188NjoT8ehshkVzSvh+OMADSh++OOUMN1OdVM/
 vkxhmZ+cSZrEbEs4v5GoYikRK2b8/ueIXBEwe/20E8CIHeuzU3yX5akO6O6Ea+Vnw8S3m2nUh
 Q7L6JQ8aP681FYW9Qv5eUQcP5lYq3ukQApNeK/e8cTbm/fQLs01NB1jr2lMmx8uWed2OdXjx/
 hWRG100cT2OQfi7NG3ne+tgMq+7iXp00rvNd/yT7jDbXXYgM6RNcEITkTicPTNXILUlkXQ1Ee
 71cgefVDu5+at8FaT9FJQlKJC6bh/fIpb8i73T2Z1VCIadjy7MB7ImpDsWpQgxYoNHLMNiiE1
 v1+WIf0wO0nZrFAMqpCuIX92NFaSZE5jdgUSakddWmScKMEOSET8rjJHYM5MWoX9DMAYi5mcN
 4Oa/6b5S/1Rp24g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LED for the mic mute button is controlled by GPIO2.
The mute button LED is slightly more complex, it's controlled by two bits
in coeff 0x0b. Add a fixup for the mute LED and chain to an existing fixup
for the mic mute LED.

Signed-off-by: Fabian Vogt <fabian@ritter-vogt.de>
---
Applies on top of 89bf6209cad6.

I see that SungHwan Jung (CC'd) recently submitted the same fixup for
a rather similar but different model as
"ALSA: hda/realtek: Add quirk for HP Victus 16-d1xxx to enable mute LED"
Does your HP Victus also need the ALC245_FIXUP_HP_GPIO_LED? Then we could
combine the quirks.

 sound/pci/hda/patch_realtek.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc7b7a407638..cac207d7c0b9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4639,6 +4639,24 @@ static void alc236_fixup_hp_mute_led_coefbit2(struct hda_codec *codec,
 	}
 }
 
+/* The mute LED is controlled by two bits in coef 0x0b:
+ * To turn on, set bit 3 but clear bit 2.
+ */
+static void alc245_fixup_hp_x360_mute_led(struct hda_codec *codec,
+				      const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x0b;
+		spec->mute_led_coef.mask = 0xc;
+		spec->mute_led_coef.on = 0x8;
+		spec->mute_led_coef.off = 0x4;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -7231,6 +7249,7 @@ enum {
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
+	ALC245_FIXUP_HP_X360_MUTE_LED,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9309,6 +9328,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
+	[ALC245_FIXUP_HP_X360_MUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_x360_mute_led,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_GPIO_LED
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9551,6 +9576,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x887a, "HP Laptop 15s-eq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x888a, "HP ENVY x360 Convertible 15-eu0xxx", ALC245_FIXUP_HP_X360_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
-- 
2.41.0




