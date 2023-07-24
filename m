Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373B975E7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjGXB3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjGXB2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFAB49D8;
        Sun, 23 Jul 2023 18:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2200460F31;
        Mon, 24 Jul 2023 01:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACC4C433C9;
        Mon, 24 Jul 2023 01:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161871;
        bh=mxeAprAukg5+vo2ahTVMvq7xdC35g/vWkmBmw26VmAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDctIC5BdUWJpIEryh5AxQ+fSRibZ3P9XpjmXkrYznf2tIpmbWJYQfn6Gm/1xUkPd
         tSS3qqyEqbWzsXweg2oVF6ibR8DXEyiuaNukJfh1gxaN6H6zMcLJzSj4JSz/jfyLQv
         AdgmcslO/YebJaL4O2+4ZGpbNcJTTdTDQ8cLASW9vMEVcmwMmTSmph86w6yp+6F3KN
         e3a/TSqX6YevZfxxoH9vVQs+DTC7iTSirxX8Drd7JX667koGwnCC++boPIAKbuN7G3
         llfRPkBf4POeY2P5jkrZWiJCL3W08Q2g6O/44H42DfF2PB5SNkduh5/ZpeC5y6ZVBJ
         2KCULnPMTYtbw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Uday M Bhat <uday.m.bhat@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 07/22] ASoC: Intel: sof_sdw: Add support for Rex soundwire
Date:   Sun, 23 Jul 2023 21:24:04 -0400
Message-Id: <20230724012419.2317649-7-sashal@kernel.org>
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

From: Uday M Bhat <uday.m.bhat@intel.com>

[ Upstream commit 164e5dc17525181c05563f0a06796f1a363801d5 ]

Add rex entry in the soundwire quirk table

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Uday M Bhat <uday.m.bhat@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230602202225.249209-28-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 30cc8bbceb79b..cbbb50ddc7954 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -207,6 +207,14 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(RT711_JD2_100K),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Rex"),
+		},
+		.driver_data = (void *)(SOF_SDW_PCH_DMIC),
+	},
 	/* LunarLake devices */
 	{
 		.callback = sof_sdw_quirk_cb,
-- 
2.39.2

