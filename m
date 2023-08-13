Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72A77A889
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjHMQDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjHMQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D90211C;
        Sun, 13 Aug 2023 09:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00434635C0;
        Sun, 13 Aug 2023 16:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96F4C433C8;
        Sun, 13 Aug 2023 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942564;
        bh=EMqGJx5pHddWrDSuGZKtEvkH0TNvXukf5vwbehXXIqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knoLw/RnxWq/i/NTwgjzDcSDNSVsLme/HYElGSDpjqjtamOrPa/h8dOTCC483yPMA
         2Ff6wsXS+AayEIFIHCKvuKnlpwYwl5idjfpUt84muuHhSDAohFo4TSFZEL+dbM5Wjb
         qOh4u44g29PcoOJPO5itTbv2v9d/hFYFEZ6RdESilOkPVBB455KEhKhJ1MOfTxnjXg
         1zaIo2Bwcy9+g71wD4FR9XU0x8ob5nbI7mvPkTdysgn/Zor8grheRWuTvE5VH0xMlk
         y21L9XmZCWlWFMGAQCI65/pv388qU6Mhbq/yM3/EmTBPnPXViUQc0fRf9G1wgyoDFq
         P7RhpPV+acghQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Edgar <ljijcj@163.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, cristian.ciocaltea@collabora.com,
        yung-chuan.liao@linux.intel.com, zhuning0077@gmail.com,
        hdegoede@redhat.com, pierre-louis.bossart@linux.intel.com,
        u.kleine-koenig@pengutronix.de, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 25/47] ASoc: codecs: ES8316: Fix DMIC config
Date:   Sun, 13 Aug 2023 11:59:20 -0400
Message-Id: <20230813160006.1073695-25-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 87775378362e7..c4e4ab93fdb6d 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -153,7 +153,7 @@ static const char * const es8316_dmic_txt[] = {
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

