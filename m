Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D2079901D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbjIHThG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345033AbjIHTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:36:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF61FEF;
        Fri,  8 Sep 2023 12:36:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC2AC4163C;
        Fri,  8 Sep 2023 19:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201750;
        bh=1K5r5hiuskro2gNQTiw+I6OgPu9bGerfXTpVUUnHHMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdzyW3owasykpCt162bCtcaC7/lo8XyCo2OrntGWc91gJJioNsXm4V1/SVQ1BNqt8
         bqOIbG9PLRZeV9kN9Fhqvcp1dglrmMvbdx8RYE12wH+UhzmGC1/nP8/yXeMgBa7LGz
         EF5FfJlmAiIFV7rjeHculsSV+hBOx/PQP6iKsRMvYYHZ6yeFLk5Rw4xWBpfQr1QWWu
         fXibn6VwNf16x5hMaUwWhX1M5CAfBpb3NeQaGu3cPfsk/h2TbRYYSxvm8q1MiS/xaf
         sQw5n3GpBN4KJujltSmuwQbNfZWUCTPjZnasxg6c+8xTBcz6qC8E+HaAktyrTw8iFW
         8HJ7fuKI5y7DQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        amadeuszx.slawinski@linux.intel.com, bradynorander@gmail.com,
        muralidhar.reddy@intel.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 07/13] ALSA: hda: intel-dsp-cfg: use common include for MeteorLake
Date:   Fri,  8 Sep 2023 15:35:23 -0400
Message-Id: <20230908193530.3463647-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193530.3463647-1-sashal@kernel.org>
References: <20230908193530.3463647-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
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

[ Upstream commit 73e6ebf6a21a62429282632eccb8aa4212489b3c ]

This was not updated in Commit 0cd0a7c2c599 ("ALSA: intel-dsp-config: Convert to PCI device IDs defines")

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230802150105.24604-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 513eadcc38d90..811d2ebc7d6ec 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -381,7 +381,7 @@ static const struct config_entry config_table[] = {
 	/* Meteorlake-P */
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x7e28,
+		.device = PCI_DEVICE_ID_INTEL_HDA_MTL,
 	},
 #endif
 
-- 
2.40.1

