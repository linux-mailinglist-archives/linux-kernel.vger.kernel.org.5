Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596F5776643
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjHIRTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjHIRTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:19:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E18C1B6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:19:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31771bb4869so100825f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691601584; x=1692206384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XaG/agcdHHHXeqbueYhHg4bGC+O2TjD70CPDhGyhxg=;
        b=a5YViMUv3Kw4CcuwIt8Jg8uYH/DYqnPG3zt92oERud3qs7c2+bC0vDWvCZf6ZhN1q5
         Ody4StkupWi7qwHwpBi+dpYzPRwdFbWp2nM1V/wyghaS2sXMQnK0nVrI0ehjx3ehx8YG
         z4L0tw72OmXAPRyw4p0BNVolWl3gxakiswA4ujUwZWwpStU3c2All8lflbx3sxqipBZJ
         5OiSedoYnvvYNVnJSIKhgKndI0Vpchf0UzFGRb0oLSRkMaUZr86fHwPnuvsm60Q8ViU1
         2NlJnBGdZI0mrS7/LGaa/SgMpg4iBXOSNub2PkLk900WmSXLWsEv7XkAboKWpoOBVHNg
         a1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601584; x=1692206384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XaG/agcdHHHXeqbueYhHg4bGC+O2TjD70CPDhGyhxg=;
        b=dV/EckpyeEevjzMo/HRNvCuw/zqUbPda26mp4JL7Jh0egM2qFoFr2Wu6047L3xu5Kx
         BqFTe7vKbAhrTXnAm2DGb1diT3yRmddm7ixrJRjFWDiqyeIx/VYGHtALt/qgPGodkY/O
         BQl6n5HjiLEV90LQCiNhZx3wTGqywrBZS73cog7vEgiOqutQbBsSTL0/frpYyq6HncnN
         aOAS6MCcsEm0flTqxIneSWJQ2PuWPQGyR/FwcJ/mWxRiHTtnVVqQt4cnJj5AXDnF0eHv
         qllvbk4FdFCGmwHykOltNacIkfOaYtRNaPVTVhrCJAOL7mxrOOvaMHM53rq34gX/RbpU
         XYvg==
X-Gm-Message-State: AOJu0YzvE2UNO7/6A2elC0+aZRqSOhdmAV0hHp4Az9wa85fwllArTf90
        cq2li8wQ8UOhZ8YrJ8NO2ONCgQ==
X-Google-Smtp-Source: AGHT+IHKPGuXsPtyMe8JcF+q+kRG34gkrJFHOMtrzEff0nqGJEy7u7cLr+k+1gzH3mf8N1/atHsa1w==
X-Received: by 2002:a5d:6903:0:b0:315:9676:c360 with SMTP id t3-20020a5d6903000000b003159676c360mr14061wru.25.1691601583375;
        Wed, 09 Aug 2023 10:19:43 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:2a0f:2daa:ffb5:cc02])
        by smtp.googlemail.com with ESMTPSA id a18-20020adfeed2000000b00313f61889ecsm17335313wrp.66.2023.08.09.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:19:42 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: meson: axg-tdm-formatter: fix channel slot allocation
Date:   Wed,  9 Aug 2023 19:19:31 +0200
Message-Id: <20230809171931.1244502-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the tdm lane mask is computed, the driver currently fills the 1st lane
before moving on to the next. If the stream has less channels than the
lanes can accommodate, slots will be disabled on the last lanes.

Unfortunately, the HW distribute channels in a different way. It distribute
channels in pair on each lanes before moving on the next slots.

This difference leads to problems if a device has an interface with more
than 1 lane and with more than 2 slots per lane.

For example: a playback interface with 2 lanes and 4 slots each (total 8
slots - zero based numbering)
- Playing a 8ch stream:
  - All slots activated by the driver
  - channel #2 will be played on lane #1 - slot #0 following HW placement
- Playing a 4ch stream:
  - Lane #1 disabled by the driver
  - channel #2 will be played on lane #0 - slot #2

This behaviour is obviously not desirable.

Change the way slots are activated on the TDM lanes to follow what the HW
does and make sure each channel always get mapped to the same slot/lane.

Fixes: 1a11d88f499c ("ASoC: meson: add tdm formatter base driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-formatter.c | 42 ++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 9883dc777f63..63333a2b0a9c 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -30,27 +30,32 @@ int axg_tdm_formatter_set_channel_masks(struct regmap *map,
 					struct axg_tdm_stream *ts,
 					unsigned int offset)
 {
-	unsigned int val, ch = ts->channels;
-	unsigned long mask;
-	int i, j;
+	unsigned int ch = ts->channels;
+	u32 val[AXG_TDM_NUM_LANES];
+	int i, j, k;
+
+	/*
+	 * We need to mimick the slot distribution used by the HW to keep the
+	 * channel placement consistent regardless of the number of channel
+	 * in the stream. This is why the odd algorithm below is used.
+	 */
+	memset(val, 0, sizeof(*val) * AXG_TDM_NUM_LANES);
 
 	/*
 	 * Distribute the channels of the stream over the available slots
-	 * of each TDM lane
+	 * of each TDM lane. We need to go over the 32 slots ...
 	 */
-	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
-		val = 0;
-		mask = ts->mask[i];
-
-		for (j = find_first_bit(&mask, 32);
-		     (j < 32) && ch;
-		     j = find_next_bit(&mask, 32, j + 1)) {
-			val |= 1 << j;
-			ch -= 1;
+	for (i = 0; (i < 32) && ch; i += 2) {
+		/* ... of all the lanes ... */
+		for (j = 0; j < AXG_TDM_NUM_LANES; j++) {
+			/* ... then distribute the channels in pairs */
+			for (k = 0; k < 2; k++) {
+				if ((BIT(i + k) & ts->mask[j]) && ch) {
+					val[j] |= BIT(i + k);
+					ch -= 1;
+				}
+			}
 		}
-
-		regmap_write(map, offset, val);
-		offset += regmap_get_reg_stride(map);
 	}
 
 	/*
@@ -63,6 +68,11 @@ int axg_tdm_formatter_set_channel_masks(struct regmap *map,
 		return -EINVAL;
 	}
 
+	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
+		regmap_write(map, offset, val[i]);
+		offset += regmap_get_reg_stride(map);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(axg_tdm_formatter_set_channel_masks);
-- 
2.40.1

