Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234BC75E796
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGXB26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjGXB2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:28:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7C810DF;
        Sun, 23 Jul 2023 18:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E41A660F35;
        Mon, 24 Jul 2023 01:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67945C433CB;
        Mon, 24 Jul 2023 01:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161866;
        bh=2KANAftaD78TguohAtEcbgQmDSJotr6QWfpIsNWzpxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6nepXz8JepxC4TpPzVZoc6UJYNbKvlFZk+7GN7ZKDiHFW8yV7oVcD7et+9NWzDbO
         73m1Gv00wCR1wCRdsJ464fwEBZWhMabL2rJMrsjqi/528FGJcs6F+LiLHY6PRXW7iL
         L+lXms8E2b1et/+2dF5Kd1t91sMKi3LNN2E51wxyPFOk+hAhuzHGtcVAl97F+ddCVS
         phRuK7Bu3ncYUgWOMiDa4t0vFL+SxPO8eyUP3/EjOK/FxyFmZVYRe2V4ddn1+b7JBu
         EYdqPSTxGbKNcTV82mNpqcok3Sxfcb71BoIKHNrPCbPqSo2sECnpalfAUP/N7e70t2
         z/ox9E9oCdsNA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 04/22] ASoC: Intel: sof_sdw: add quirk for LNL RVP
Date:   Sun, 23 Jul 2023 21:24:01 -0400
Message-Id: <20230724012419.2317649-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012419.2317649-1-sashal@kernel.org>
References: <20230724012419.2317649-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 91a7cb33042d8..30cc8bbceb79b 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -207,6 +207,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
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

