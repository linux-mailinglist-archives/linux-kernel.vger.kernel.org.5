Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3578CF56
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbjH2WBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbjH2WBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:01:30 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B88185
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:01:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id B61B016C004F;
        Wed, 30 Aug 2023 01:01:24 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jvhPjC8fXho6; Wed, 30 Aug 2023 01:01:23 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1693346483; bh=xI66UpNVTpcShnwJRClXF7/oI1rnpdo0EK+ou864+xU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItLp8ZUvJ1ruMD1YHexop0ed+TEwT46nmOwE7RwRIpdpy60BF2XcWeKq1VfaXTasg
         2sT8p5P5TDV20cVrANugSxKUC/j6NwT52cTRWUHGJcG2BkPsM7kBZVMgVjT/phfzPq
         B7iXcnnzJiSiPLVDoQaxWHAclHYmxFFVr7jOt2do=
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH v3 1/5] ASoC: es8316: Enable support for S32 LE format
Date:   Wed, 30 Aug 2023 01:01:12 +0300
Message-ID: <20230829220116.1159-2-posteuca@mutex.one>
In-Reply-To: <20230829220116.1159-1-posteuca@mutex.one>
References: <20230829220116.1159-1-posteuca@mutex.one>
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

This CODEC does support the S32 LE format in es8316_pcm_hw_params(),
but doesn't have it enabled in ES8316_FORMATS. Enable it so that we
have more options to match with components.

Signed-off-by: Marian Postevca <posteuca@mutex.one>
---
 sound/soc/codecs/es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index a8f347f1affb..09fc0b25f600 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -526,7 +526,7 @@ static int es8316_mute(struct snd_soc_dai *dai, int mute, int direction)
 }
 
 #define ES8316_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
-			SNDRV_PCM_FMTBIT_S24_LE)
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops es8316_ops = {
 	.startup = es8316_pcm_startup,
-- 
2.41.0

