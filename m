Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8075E633
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGXBQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGXBPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC461711;
        Sun, 23 Jul 2023 18:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1ACD60F07;
        Mon, 24 Jul 2023 01:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828F2C433C8;
        Mon, 24 Jul 2023 01:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161271;
        bh=NEikLDfpeK3unjoQbd/Unr2X5ziouPV7lAi1vlD5w9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVh/rVZuyeJ71iQNypNd8Ffvw10WNZldAM7AOz9j4ynTRrMTBrCSVRVezWNWZtvii
         Gtipa94ae4rvgECXrRok55qo9XmomoQoQdCNZ/ByxOrbPXeh6POvjExLVA0jp0aSHC
         zN7pe/uE4g3gIkfeg4kUmhLWxKlvK47veKd2zQZdcCU5AqmLZ+0rE/2FmZuZAkwtoo
         AUrVA005vFdzrULVbuNcqpFumeFbvfNRhyLFGxif/SjnngruuFn0/QdueiVOHW0tfX
         DGDiEkG36G3/AR7EXaPktLv9zaLHK0IY/w0HxPal/7lISgSAfa/dmAP2fPngSTi4ux
         tJyJk59LRf2Ew==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, cezary.rojewski@intel.com,
        pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        gongjun.song@intel.com, uday.m.bhat@intel.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 10/58] ASoC: Intel: sof_sdw: add quirk for MTL RVP
Date:   Sun, 23 Jul 2023 21:12:38 -0400
Message-Id: <20230724011338.2298062-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 289e1df00e49a229a1c924c059242e759a552f01 ]

We should use RT711_JD2_100K for on board rt711.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Link: https://lore.kernel.org/r/20230512173305.65399-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 144f082c63fda..db99f7fefdfc7 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -415,6 +415,14 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(RT711_JD1 | SOF_SDW_TGL_HDMI),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Meteor Lake Client Platform"),
+		},
+		.driver_data = (void *)(RT711_JD2_100K),
+	},
 	{}
 };
 
-- 
2.39.2

