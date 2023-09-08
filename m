Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BAB798F4A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbjIHTb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344755AbjIHTbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:31:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE561BF;
        Fri,  8 Sep 2023 12:30:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AB4C43395;
        Fri,  8 Sep 2023 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201433;
        bh=Qkt0LV0/frAiZgW2slQTjtoSuucG5zInnwlfK88x0oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3hXsFP3Ou3mNzJ2ZXUiHslSfg9rj/2i4E43LHfN1+/HUw2MiNMZtN6gTvqpCXcAD
         d9NvQ+DzDTd+Dp3ZN7xP4kj4z6PFWw5K9PfpoU7dJnyNQPP0DJe8pLbPCE6wkJYdF1
         MnmKOt2runqM7PrVOFmd50gKCIjhtUREPQBIVpMU8AkBF84pgmooqox+iHj6HBLE47
         onenLWDUq2Xu+/e+jBn5qzMQZXQiNSKULyd1UKi4Mm8lJ+B+r3PT1qxb0lNpfPh383
         rAeuAz3VToYAWCpSK1fGynlyDKhVu/2/ddo5SsGGRm/xc9YThhqEzg1oYt64O8vc3G
         G0sgJDG6zEpVQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Uday M Bhat <uday.m.bhat@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jairaj Arava <jairaj.arava@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        gongjun.song@intel.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.5 18/36] ASoC: Intel: sof_sdw: Update BT offload config for soundwire config
Date:   Fri,  8 Sep 2023 15:28:29 -0400
Message-Id: <20230908192848.3462476-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uday M Bhat <uday.m.bhat@intel.com>

[ Upstream commit a14aded9299187bb17ef90700eb2cf1120ef5885 ]

For soundwire config, SSP1 is used for BT offload. This is enabled
in sof_sdw_quirk_table

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Uday M Bhat <uday.m.bhat@intel.com>
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230731214257.444605-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 0201029899cad..c86f8f9a61003 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -467,7 +467,9 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Rex"),
 		},
-		.driver_data = (void *)(SOF_SDW_PCH_DMIC),
+		.driver_data = (void *)(SOF_SDW_PCH_DMIC |
+					SOF_BT_OFFLOAD_SSP(1) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
 	/* LunarLake devices */
 	{
-- 
2.40.1

