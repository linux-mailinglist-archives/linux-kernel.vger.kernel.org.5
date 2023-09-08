Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ABA7990A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343748AbjIHT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbjIHT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:57:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA090B4;
        Fri,  8 Sep 2023 12:57:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C1BC116B0;
        Fri,  8 Sep 2023 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201794;
        bh=PLgR11sTjPWKiEP6ESPmFnGJzLPoIOquipiFx3g2L0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsBIiU2IkfR71jUNs+ucy+S3ft28CrCTcQjL5AGgHJx3TJ3RcJK7DW9Fnx1Ugc/Qd
         Bqlr9Xk54NnO1s3JpYUtTrzDB99/8Oozp/X11JPCLhEFgtqIF4szdg/8tHgRZHFTrg
         upGQ8pMZkhfrt1nx/1NaGuFIxOUD5Rrdbgn4xPlNzVu8++YeKDU2bUyRJFGudUVMlH
         s8MEmO9GoBci3IN6w0AW7KSFkLo3jWckrQCWkj+IuK2T8WtE7yEDfZZ1reg+Hyo9np
         iYuFKpr9agkUJhZ35Ex7+nfv2tXKkGI0cpfopw4KTO7oyvPXD7d0fTNwq10xqgM4Ab
         VS/EYbew619Hw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        amadeuszx.slawinski@linux.intel.com, bradynorander@gmail.com,
        muralidhar.reddy@intel.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 5/9] ALSA: hda: intel-dsp-cfg: add LunarLake support
Date:   Fri,  8 Sep 2023 15:36:06 -0400
Message-Id: <20230908193611.3463821-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193611.3463821-1-sashal@kernel.org>
References: <20230908193611.3463821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
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
index ae785d9588fee..f616f00e349e7 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -368,6 +368,14 @@ static const struct config_entry config_table[] = {
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

