Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65725798F53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbjIHTbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344781AbjIHTb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:31:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7231E1BEA;
        Fri,  8 Sep 2023 12:31:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97505C43397;
        Fri,  8 Sep 2023 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201438;
        bh=VEfuBzvAe1ClXyjHdy//kvGqpsKQLdmmE3zetC7ol28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRsy0Z/mdvJWXneEPyUJWI5SjgvFCi01Gz/jjXQSWvMePxEFBEovu/iD+ZCsPXwXK
         oPl/wcGACLhdqsLF+v0khHkgWffVECZjJMeA+7C+EfANNrDWJBKpxsZk1lB114iYLB
         4RByZUEIcUbVsGBB7hgv7lC4sYjEmkMSILmE8nwf04lC3DDEcPd2x7JkH9SZKtNs9c
         qSex3JdKVWP0/KkdtDQ8JbaEdHDUPPYjaAuv0iTCigTK+nhE6YbRhMjJUtJe5dZEmD
         b+2rQBreNxMeFIX9k/2SCOVXa66IAjKCbZwH6egi6jiQTNK1ee2CeAa8bgNGd1iGRl
         9s9QzFq/CZ8HA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        amadeuszx.slawinski@linux.intel.com, muralidhar.reddy@intel.com,
        bradynorander@gmail.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.5 19/36] ALSA: hda: intel-dsp-cfg: add LunarLake support
Date:   Fri,  8 Sep 2023 15:28:30 -0400
Message-Id: <20230908192848.3462476-19-sashal@kernel.org>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit d2852b8c045ebd31d753b06f2810df5be30ed56a ]

One more PCI ID for the road.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230802150105.24604-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 317bdf6dcbef4..2873420c9aca8 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -481,6 +481,14 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 
+/* Lunar Lake */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_LUNARLAKE)
+	/* Lunarlake-P */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_LNL_P,
+	},
+#endif
 };
 
 static const struct config_entry *snd_intel_dsp_find_config
-- 
2.40.1

