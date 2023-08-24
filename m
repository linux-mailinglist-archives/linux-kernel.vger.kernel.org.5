Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F437879D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbjHXVCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240485AbjHXVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:01:43 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1041319BF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:01:42 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 939F616C0047;
        Fri, 25 Aug 2023 00:01:40 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DwQrudmliFeG; Fri, 25 Aug 2023 00:01:39 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1692910899; bh=Tm63Mvp1jvDf3sJhV/8zUpCX7xgXcTbDK1PgG6byMck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9+JsulQYF8QcuNC0in5P0Mz+GgGOdKYcq8yrJZYhAuZMdh8S4CRo63VTEqYX+AfR
         3TbWd7CQjRgOO+nTn6EDl4svzq1qV98E9P7bpU6/tlm08jG97FMJ03HCrSQxWzsU41
         fEd6cL9O5fcojj8UsWzFf7m6VUjtD+VgCElUtUKU=
To:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH v2 1/4] ASoC: es8316: Enable support for S32 LE format
Date:   Fri, 25 Aug 2023 00:01:32 +0300
Message-ID: <20230824210135.19303-2-posteuca@mutex.one>
In-Reply-To: <20230824210135.19303-1-posteuca@mutex.one>
References: <20230824210135.19303-1-posteuca@mutex.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To properly support a line of Huawei laptops with AMD CPU and a
ES8336 codec connected to the ACP3X module we need to enable
the S32 LE format.

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

