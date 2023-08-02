Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB476D23F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjHBPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjHBPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:38:50 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B972D78
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:38:00 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3491bcf0ae7so4069445ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690990680; x=1691595480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwwam74pzhHFEUqT4XAcAOsJClTD9hVWsEI9hEoiqVk=;
        b=DO3nbl0FHNkDFvmxD4c7Suq0WyVDfJLaVTQ2rGf+rlgEk/B2mQv81BCZlYE1+uQtqs
         0rZDZEnkZtek27ZgjhfJoCgSK1JKgRFCM0dWIX6/2jNF3xagNWJZk1FGE3+2EMurFN/Q
         dBtEbDDU9YSC/Ric2fqyBvTHtIMWCgKROKfzywvEs7SOBNtuq/O7S2daU8Cv8YTlmroX
         mQec/RmfeGecLYavGZoIIvQcfpNFSE3NKqrbT5Wt/l1zAp55Ov7bw84NaIY5oXpRBhcj
         Xey8KOC14knBgxxNDjLHD8ZlOY4BOfdchEy3AKJ51DNuVQO+EHa0F8zcxjcONpfCPt+L
         ojSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990680; x=1691595480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kwwam74pzhHFEUqT4XAcAOsJClTD9hVWsEI9hEoiqVk=;
        b=jyXoRN7Ho8dvd5S0/0uxGq7jVXdRVqDgT7s+gnmwJqe0QR4ur4OL95bju+k/iiUPXy
         +puW7o5+EeAKNlRvYrlvBhmaiYR2ywLN2sw7KdOIdh6L66Td/ExoKUTd2xAI7ibnMSMX
         kLHIgint63xBPkiYaD7x9HIPJI2WxfIi2dNsgjDqb+49BiLEtnUti4bKcSAiGJ5MhsvW
         GFKTzHa8pXc3vD4piWOlrm+dtnle0M4DZmk6p1PNX79jMuASFE/KlLvU7i8ONYu8ChAl
         FfVxiKTjcdSYLFXv4zMrFNdUeoN0apuBjvU16D4j3ahhlxMBWhR9jRRkfOVk0Xh8pJOd
         XTtg==
X-Gm-Message-State: ABy/qLZLdWTg92bALRg2Lg3jU07c1Nghi7epTwg1HUkyJsiK1Z3AEGVn
        Fc8bZ8R+sjs6q54Bf6OQlVI=
X-Google-Smtp-Source: APBJJlGQXuWWIjRNew/Vj6B5cF4LBmmOlXRxbiBDJSdDXV/KmzqBWo/+bX4Ga7KBGZaoqE27Vleetg==
X-Received: by 2002:a6b:c30f:0:b0:783:6e76:6bc7 with SMTP id t15-20020a6bc30f000000b007836e766bc7mr13512517iof.2.1690990680143;
        Wed, 02 Aug 2023 08:38:00 -0700 (PDT)
Received: from localhost.localdomain ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id g8-20020a6b7608000000b00786f50d6bf5sm4556830iom.19.2023.08.02.08.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:37:59 -0700 (PDT)
From:   Matthew Anderson <ruinairas1992@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Matthew Anderson <ruinairas1992@gmail.com>
Subject: [PATCH 1/2] ALSA: hda/realtek: Add headphone quirk for Aya Neo Geek
Date:   Wed,  2 Aug 2023 10:37:29 -0500
Message-ID: <20230802153730.39273-2-ruinairas1992@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802153730.39273-1-ruinairas1992@gmail.com>
References: <20230802153730.39273-1-ruinairas1992@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the headphones on the Aya Neo Geek handheld.
Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 44fccfb93cff..33f9beec8179 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6521,6 +6521,20 @@ static void alc294_gx502_toggle_output(struct hda_codec *codec,
 		alc_write_coef_idx(codec, 0x10, 0x0a20);
 }
 
+static void alc269_fixup_headphone_volume(struct hda_codec *codec,
+					const struct hda_fixup *fix, int action)
+{
+	/* Pin 0x21: Some devices share 0x14 for headphones and speakers.
+	 * This will fix ensure these devices have volume controls. */
+	if (!is_jack_detectable(codec, 0x21))
+		return;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		static const hda_nid_t conn1[] = { 0x02 };
+		snd_hda_override_conn_list(codec, 0x14, ARRAY_SIZE(conn1), conn1);
+	}
+}
+
 static void alc294_fixup_gx502_hp(struct hda_codec *codec,
 					const struct hda_fixup *fix, int action)
 {
@@ -7016,6 +7030,7 @@ enum {
 	ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET,
+	ALC269_FIXUP_HEADSET_AYA_GEEK,
 	ALC269_FIXUP_HEADSET_MODE,
 	ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC,
 	ALC269_FIXUP_ASPIRE_HEADSET_MIC,
@@ -8440,6 +8455,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
+	[ALC269_FIXUP_HEADSET_AYA_GEEK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_headphone_volume,
+	},
 	[ALC299_FIXUP_PREDATOR_SPK] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9934,6 +9953,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1f66, 0x0101, "GEEK", ALC269_FIXUP_HEADSET_AYA_GEEK),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
-- 
2.41.0

