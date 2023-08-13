Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3515177A9C0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjHMQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjHMQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D53421D;
        Sun, 13 Aug 2023 09:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69E69638F8;
        Sun, 13 Aug 2023 16:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFDEC433CA;
        Sun, 13 Aug 2023 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943319;
        bh=jRDE0jWXws9jMExLZ0ak8vIhAFZa1jKUZhP1XXiU/4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7wyR1NOfWe6sZwrlK3ZtGpXXaKOWZrAhAQM+I/93iX9B+E85VAqYN5Rk0tU3f78O
         clU2Soz23ywpW+MR8w9hBkcB5rlLzcGSOUuPfMB7bAH4GQmin73Hg9PbMWkQdrfaRl
         uQWZGKNvm2BYaHYmymnq2Ag1ABAcKsiA+QfGL4yRX9F/9e8U6X5Ifirx2fKJf/Dx4P
         q7nf7ooapUzs3yVrWKZ4u9ClJ2B+eQNGPUPFsXFgX+U1UZT0VMiUj09jXIC+tJnlRU
         fz9ZueY4MfWBThK8E5wUfz5idtqZDiEskZDpV0u0ppzkqfIyd5LUpsmq96zMrRXKOG
         jkFh3555L5clw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Edgar <ljijcj@163.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, cristian.ciocaltea@collabora.com,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, u.kleine-koenig@pengutronix.de,
        zhuning0077@gmail.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.14 8/9] ASoc: codecs: ES8316: Fix DMIC config
Date:   Sun, 13 Aug 2023 12:14:26 -0400
Message-Id: <20230813161427.1089101-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161427.1089101-1-sashal@kernel.org>
References: <20230813161427.1089101-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.322
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edgar <ljijcj@163.com>

[ Upstream commit d20d35d1ad62c6cca36368c1e8f29335a068659e ]

According to the datasheet, the DMIC config should
be changed to { 0, 2 ,3 }

Signed-off-by: Edgar <ljijcj@163.com>
Link: https://lore.kernel.org/r/20230719054722.401954-1-ljijcj@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 0410f2e5183c3..d35a157bad57f 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -140,7 +140,7 @@ static const char * const es8316_dmic_txt[] = {
 		"dmic data at high level",
 		"dmic data at low level",
 };
-static const unsigned int es8316_dmic_values[] = { 0, 1, 2 };
+static const unsigned int es8316_dmic_values[] = { 0, 2, 3 };
 static const struct soc_enum es8316_dmic_src_enum =
 	SOC_VALUE_ENUM_SINGLE(ES8316_ADC_DMIC, 0, 3,
 			      ARRAY_SIZE(es8316_dmic_txt),
-- 
2.40.1

