Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51337DCAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343954AbjJaKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbjJaKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:32:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6BEFD;
        Tue, 31 Oct 2023 03:32:00 -0700 (PDT)
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA86E6607390;
        Tue, 31 Oct 2023 10:31:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698748319;
        bh=snKMPEw3/sZymut9YKmskK4tpvE9vyUtyrcQQzMwW3g=;
        h=From:To:Cc:Subject:Date:From;
        b=SAS7GJNIQK8qjHN8XRik3kZcD9sZCZkLAl3ZTwDYA4pvOqVkjXXyjUtk43OuWY7Wg
         vvWrfQtDqiggNTVVpNKRAgMyHLIio/ULcMREQHw++q7xU9AUB0uMdj80jCMEGPgDwY
         gnbLmepTCgkAIXfTRQMjMDbXMlLbMjYiS4WrwhRPTWDmm01BaYQp/gpBBtOqeS0pCz
         d+Qb8LNoyvs1LaOCK3B5seqliWSRwh6o9S+W3XgwfSzwpEy22kJAMQHEwQMvjOLc9b
         YtfTdv+jCOBmpYtFX8xDQiAIMiKTaNPVWU4LlU82zBA7SA7yDsbDPGUHlKOforksXZ
         adNjdphnFv7Zw==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     broonie@kernel.org, jiaxin.yu@mediatek.com,
        linux-sound@vger.kernel.org
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] ASoC: mediatek: mt8186_mt6366_rt1019_rt5682s: trivial: fix error messages
Date:   Tue, 31 Oct 2023 12:31:39 +0200
Message-Id: <20231031103139.77395-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property 'playback-codecs' is referenced as 'speaker-codec' in the error
message, and this can lead to confusion.
Correct the error message such that the correct property name is
referenced.

Fixes: 0da16e370dd7 ("ASoC: mediatek: mt8186: add machine driver with mt6366, rt1019 and rt5682s")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index 6dfcfcf47cab..f78197c8e582 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -1216,7 +1216,7 @@ static int mt8186_mt6366_rt1019_rt5682s_dev_probe(struct platform_device *pdev)
 	playback_codec = of_get_child_by_name(pdev->dev.of_node, "playback-codecs");
 	if (!playback_codec) {
 		ret = -EINVAL;
-		dev_err_probe(&pdev->dev, ret, "Property 'speaker-codecs' missing or invalid\n");
+		dev_err_probe(&pdev->dev, ret, "Property 'playback-codecs' missing or invalid\n");
 		goto err_playback_codec;
 	}
 
@@ -1230,7 +1230,7 @@ static int mt8186_mt6366_rt1019_rt5682s_dev_probe(struct platform_device *pdev)
 	for_each_card_prelinks(card, i, dai_link) {
 		ret = mt8186_mt6366_card_set_be_link(card, dai_link, playback_codec, "I2S3");
 		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "%s set speaker_codec fail\n",
+			dev_err_probe(&pdev->dev, ret, "%s set playback_codec fail\n",
 				      dai_link->name);
 			goto err_probe;
 		}
-- 
2.34.1

