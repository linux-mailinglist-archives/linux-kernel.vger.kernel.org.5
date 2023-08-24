Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC08B787A05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243537AbjHXVNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbjHXVM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:12:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65751BE5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:12:51 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 936386607287;
        Thu, 24 Aug 2023 22:12:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692911570;
        bh=d4zubvJCvoX5O/QaOHaUQJ+vrBBsgC/+w6pj/RAtno4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E62eTY9Qovw2dR/eYxINN9IWZpefYqNMtyqHE4yWoiEa2Y29560V/Wte9mfIEU9Sd
         E90RMuj60OxFx0Ijail4qTM640oNzkfG46AGIdHGP1wNPD4PfC7hMsH8eYsncBgGrG
         aWSrwABpgsq1kybqHpaM28SegUdPU5Jei7ncxMQKgcoj8/A/Fe7hNr8GskmUY3av3P
         uZmAPCssv337+vhieeX0FpUX58mRHVmxzIWG2w85/A8UaDrOtPHg/teswuevC7v8tA
         EuSbrm2O41XNo+JoiYIqVKNg3C0xMF6WJP8DtcCYswRnOjXXYKud6mtIzc04jJ2D33
         2f29FLyuv7FJg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 2/2] ASoC: core: Rename component_not_find label
Date:   Fri, 25 Aug 2023 00:12:41 +0300
Message-ID: <20230824211241.388201-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824211241.388201-1-cristian.ciocaltea@collabora.com>
References: <20230824211241.388201-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct form of the verb in 'component_not_find' label, from
soc_dai_link_sanity_check() function.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/soc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 75a9641349ee..cc442c52cdea 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -942,7 +942,7 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 		 * component list.
 		 */
 		if (!soc_find_component(dlc))
-			goto component_not_find;
+			goto component_not_found;
 	}
 
 	/* Platform check */
@@ -963,7 +963,7 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 		 * component list.
 		 */
 		if (!soc_find_component(dlc))
-			goto component_not_find;
+			goto component_not_found;
 	}
 
 	/* CPU check */
@@ -988,7 +988,7 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 			 * Defer card registration if Component is not added
 			 */
 			if (!soc_find_component(dlc))
-				goto component_not_find;
+				goto component_not_found;
 		}
 	}
 
@@ -1002,7 +1002,7 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 	dev_err(card->dev, "ASoC: Neither Component name/of_node are set for %s\n", link->name);
 	return -EINVAL;
 
-component_not_find:
+component_not_found:
 	dev_dbg(card->dev, "ASoC: Component %s not found for link %s\n", dlc->name, link->name);
 	return -EPROBE_DEFER;
 
-- 
2.41.0

