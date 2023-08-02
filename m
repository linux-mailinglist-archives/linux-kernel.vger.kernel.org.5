Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A0376D63F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjHBR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjHBR6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE5A3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31759e6a4a1so62757f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999098; x=1691603898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc2UgdWbHJ5viusggKKpR6m1qOzlwVd02m2G5RcJAR0=;
        b=dJ5Gi04eppj2dUkhfPz8D8RqWdOOT5hoWQ5OY2vAj+BLvpM77cvkoY5AMjs1eRUxYN
         55GNINLHC25EzlSTILqK/pu2F2bjK7sc1Hakw3uwzR5d3xO0MBPcEODAikE20D9AEPZb
         B0njqovpopmV0Sqas/6H4RC/M5r53gD+VCF5JKy+cMwc1xp4tIBoJWyZYM5gzd8iE/pL
         PoClu/bk7kVPEBhR4OXvEDLzQ44bsnTqBv1UnwiAHfzh70NnXlRWL4gbmUrq20E2EN99
         lu5XqsaB9QhfATElsum0yZhC/h7jSyBx4eW3/xieQPtWlTSwHjbitwz48CYmG3lHV6b+
         5VOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999098; x=1691603898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dc2UgdWbHJ5viusggKKpR6m1qOzlwVd02m2G5RcJAR0=;
        b=f8+aFPL8mPGh6g5A/jMAgNhjYjnEhOZhIivqEQ6lfR+FN41eeF4HfEnNtXlo1yfS7O
         DYu+TR/USwhu9mLYCW/CbVIwXr5zN6VUHOl76FushoRFLBKUgPAnCZBWlTV1Q+iCE04m
         fFFxPiYuwDlirx5AfLlj5efqkZIFlHGjU8lYz5dDFddMpycrTVEHKirAtN8YRS/nEv4w
         X6Dinr9vczGFBSQya+3eMGZtN19Sx3GPGTe91dFGMkz5BcifZuwV4Aem0+WGN9Ii5MGx
         3UFlORt4wtLG9dCOde4JZm2aH7cTLvRnFbIh9cbBnQ14WOKXqERKnqm0zHumuw5FQtYG
         Gixg==
X-Gm-Message-State: ABy/qLb0F2GK47qUz/Ng7S9iLI9oIeulpFvpMXzKtsEPJ7etQ4q4nQVe
        9ehMIGE896Q5FId0evg6Xdc=
X-Google-Smtp-Source: APBJJlHAdL8nWYIDgUatLGt39dyqvop2OVrN7cratpwvF9SdHkc4NtoZ/M6UlWguYo9yfvrFKJTZGA==
X-Received: by 2002:a05:6000:1004:b0:317:5948:1fe0 with SMTP id a4-20020a056000100400b0031759481fe0mr5039599wrx.45.1690999098210;
        Wed, 02 Aug 2023 10:58:18 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:17 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH 12/27] ASoC: mediatek: mt8173-max98090: Configure jack as a Headset jack
Date:   Wed,  2 Aug 2023 20:57:22 +0300
Message-Id: <20230802175737.263412-13-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802175737.263412-1-alpernebiyasak@gmail.com>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
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

This driver has correctly mapped jack kcontrols for Headphone and
Headset Mic. However, it is configuring the jack to only care about
Headphone events. The MAX98090 codec used here can detect both
connections, so configure the jack as such.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
It also appears to support SND_JACK_BTN_0. Not sure if that should be
part of this patch.

 sound/soc/mediatek/mt8173/mt8173-max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index c2b0619b6158..bfb2094758ff 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -70,7 +70,7 @@ static int mt8173_max98090_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_component *component = asoc_rtd_to_codec(runtime, 0)->component;
 
 	/* enable jack detection */
-	ret = snd_soc_card_jack_new_pins(card, "Headphone", SND_JACK_HEADPHONE,
+	ret = snd_soc_card_jack_new_pins(card, "Headphone", SND_JACK_HEADSET,
 					 &mt8173_max98090_jack,
 					 mt8173_max98090_jack_pins,
 					 ARRAY_SIZE(mt8173_max98090_jack_pins));
-- 
2.40.1

