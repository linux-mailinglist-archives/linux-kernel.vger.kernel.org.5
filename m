Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7472975E637
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGXBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjGXBP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE310C8;
        Sun, 23 Jul 2023 18:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A459D60E17;
        Mon, 24 Jul 2023 01:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6569C433C8;
        Mon, 24 Jul 2023 01:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161318;
        bh=2qlq7uUxNq/Q9bKoby1GbgQFSQ7lyi23LUd+35mUoQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mj8P5d9MazwgUZrH4eHGF7N29GHaBmii0olHJ0N4g6FNfJ1bCJYDgdKSW6+fssUfH
         83Vsoopcanpr2/CvfubKmX0VjpEZmIYfYXndKzknBI2aepnkaVoioPqWD2mqdLOcMI
         Df05LjKR5bdYkaXotsqET+X/5b0RqBDztFtG5/vOUrfbcIisc7Edhaw/LsyDgjG4C0
         UUz6A7i5QIYGHoyQ+0Uw93+IJckprnsPb+9LX+FLWD8RHRS1IV5UFBA5gdreOOyXlf
         5hozAHAoM9GjBIxYmaFqtno600RJUOeL6dFHFO5m5AtDvA2IE0WNonC4iE49WttLNN
         Q2YaN3OH9lM1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 22/58] ASoC: Intel: sof_sdw_rt_sdca_jack_common: test SOF_JACK_JDSRC in _exit
Date:   Sun, 23 Jul 2023 21:12:50 -0400
Message-Id: <20230724011338.2298062-22-sashal@kernel.org>
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

[ Upstream commit 526a1876fc48e2d0c0ea8ad63b58bdb2cc13047f ]

if (!SOF_RT711_JDSRC(sof_sdw_quirk)) is tested in rt711_sdca_add_codec_
device_props(), and we don't add software node to the device if jack
source is not set. We need to do the same test in
sof_sdw_rt711_sdca_exit(), and avoid removing software node if jack
source is not set.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230602202225.249209-8-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw_rt711_sdca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
index 7f16304d025be..cf8b9793fe0e5 100644
--- a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
+++ b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
@@ -143,6 +143,9 @@ int sof_sdw_rt711_sdca_exit(struct snd_soc_card *card, struct snd_soc_dai_link *
 	if (!ctx->headset_codec_dev)
 		return 0;
 
+	if (!SOF_RT711_JDSRC(sof_sdw_quirk))
+		return 0;
+
 	device_remove_software_node(ctx->headset_codec_dev);
 	put_device(ctx->headset_codec_dev);
 
-- 
2.39.2

