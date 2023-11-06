Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799A37E2256
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFMw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjKFMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:52:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF45100
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:52:51 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc921a4632so35692455ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 04:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699275171; x=1699879971; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkJFm7AWqgoxZKtuuwPEj91uzHEQLQCaygX1QJt5r6M=;
        b=VZW4L/X42X/Ix1Us18wxjtshDTajO2PQUWQ6ueQraE00Gd4TRccANzfMe4tGEpl9XP
         8+9thiU5Cdh8x0lJd02G8XrH4o3rVCraSDJmdgvlyt83nB1FZv3hYyJqs+WDHzRWD/Lt
         p7h8zZEo5W9UyeCn4RChGeM+1N6matINvgghFJ3/1IZGRKCr6FuNEy5wLLZQSb8TyMLs
         AFe2+OwG9R5VZtPEpP6alhahmoIP6ha2pJzCN/xq778+pOi6wppTQbHOC4hkHZGgGt1J
         jpH2H7JA1KbM+qhU/ymR20XntN3eqak/+Lox+9Ncv53g4ZJ/7YiZGNLvXEAbquS5LicV
         uH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699275171; x=1699879971;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkJFm7AWqgoxZKtuuwPEj91uzHEQLQCaygX1QJt5r6M=;
        b=qrP0D/wQPoOF31hO0L9IIZ6p4lOIzEmyaNey8NIKdeDOXAS+xkGdVrJ0/lZK8wkRXh
         5OBZoDkT705lHqiGdaoAn5EJ/dDA7xa6HMFMTSb8zK0wZOqcxpnVGq54Sl5Xqs5AEAaK
         tTFrRM1B/zPrQzrjwRMCe2sN8zSA1w7NX5zSKoQwxx7iWnIOgFUgjxoKEg/c9o7kEcby
         xB8+1Z9ak1taMAp0uNddaltaN5QaE0aSYPDZW7e5+RntR2ZqLKnwuwPD6uK59VFH+mI2
         wze0qqgslMaOaW386R5zYj54sBGCs2JLI9uwqyqAgkAkdeAclxv/jXdM9wIrHWNemfA8
         kmxg==
X-Gm-Message-State: AOJu0YzXyMUq84V84Mk/VStpe9F5icA9yAzH84i/kiwSILPY9gIVxEeU
        D11Ugn0vYE8vUu/6qE3Jdn4=
X-Google-Smtp-Source: AGHT+IE2fBaQIh1ucFOQ2glJodobpZq4qRV6qGrShP4/Og+3rFK1m2kOxKs0zK5ib5GN2WPQ97ZTSQ==
X-Received: by 2002:a17:903:18a:b0:1cc:65b7:812b with SMTP id z10-20020a170903018a00b001cc65b7812bmr23955169plg.22.1699275170720;
        Mon, 06 Nov 2023 04:52:50 -0800 (PST)
Received: from [127.0.1.1] ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id iy18-20020a170903131200b001cc67103a15sm5884376plb.16.2023.11.06.04.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 04:52:50 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 06 Nov 2023 20:51:03 +0800
Subject: [PATCH] ASoC: sti-uniperf: Use default pcm_config instead
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-sti-uniperf-v1-1-b2d8749cfa2e@gmail.com>
X-B4-Tracking: v=1; b=H4sIADbhSGUC/x2NwQrCQAwFf6XkbKAboaC/Ih7S9a3NwbUkVQql/
 +7W4zAMs1HADUHXbiPH18LetUE6dZQnrU+wPRqT9HJOqR84FuNPtRleWEUgKBfBkKkVowZ4dK1
 5OpqXxgI/xOwotv43t/u+/wDckKYZdgAAAA==
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sti-uniperf pcm_config is the same as the default pcm_config.

Since commit 43556516fffe ("ASoC: soc-generic-dmaengine-pcm:
Use default config when none is given"), passing a NULL pointer
could let this driver use the default config.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 sound/soc/sti/sti_uniperif.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 2c21a86421e6..ba824f14a39c 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -461,10 +461,6 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 	return 0;
 }
 
-static const struct snd_dmaengine_pcm_config dmaengine_pcm_config = {
-	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-};
-
 static int sti_uniperiph_probe(struct platform_device *pdev)
 {
 	struct sti_uniperiph_data *priv;
@@ -493,8 +489,7 @@ static int sti_uniperiph_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	return devm_snd_dmaengine_pcm_register(&pdev->dev,
-					       &dmaengine_pcm_config, 0);
+	return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 }
 
 static struct platform_driver sti_uniperiph_driver = {

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231106-sti-uniperf-a22e2ef92e6c

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>

