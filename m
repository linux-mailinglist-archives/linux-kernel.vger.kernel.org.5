Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6232975E6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGXBXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjGXBWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005A510DF;
        Sun, 23 Jul 2023 18:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B232060F1A;
        Mon, 24 Jul 2023 01:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760E6C433C7;
        Mon, 24 Jul 2023 01:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161707;
        bh=o6qX34nlqMIz0BTkisqGMTe9KWeD/CNmwcKAly21D1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/t4C8dIkvsmUG8vtZCmzlz0K6ZVm8ws3owZ9MBUxsiBdny0jN3YdEGAzFFUyJx1k
         FwZOGJiEDKFhWT4+rUIdmYpln+mKguXJwQRY4H2t3YkDBIe4kzBB2Ak0P2c/m3oQbz
         xDg/GLdtUQNuO5thQNUVVO2mINOil4V/bO8iprHPkGIHAJOdMMXAFqYNVdKwr1PQcO
         nez7d5e6iptbdqh5tfpd3DWuO2NHAMuKqGgb9ewPdheU/ho8KFlteWvLfPzwSFZXB4
         btDYhOGDv5yIdBhdtEhyDf0l/NA8YocbXZWMaBvYFp2nW4TEUyY40pO2DFDhpEFRxY
         gaiOpFJay8Mtw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, cezary.rojewski@intel.com,
        pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        gongjun.song@intel.com, shumingf@realtek.com, yong.zhi@intel.com,
        u.kleine-koenig@pengutronix.de, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 08/41] ASoC: Intel: sof_sdw: add quirk for LNL RVP
Date:   Sun, 23 Jul 2023 21:20:41 -0400
Message-Id: <20230724012118.2316073-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit dfe25fea968dc4884e12d471c8263f0f611b380a ]

We should use RT711_JD2_100K for on board rt711

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com
Link: https://lore.kernel.org/r/20230512173305.65399-9-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index a06693827ae5b..da19bfdac1ea7 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -382,6 +382,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(RT711_JD2_100K),
 	},
+	/* LunarLake devices */
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Lunar Lake Client Platform"),
+		},
+		.driver_data = (void *)(RT711_JD2_100K),
+	},
 	{}
 };
 
-- 
2.39.2

