Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04BA80CD51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344339AbjLKOJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbjLKOI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:08:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2F0270A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:55:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E087AC433CB;
        Mon, 11 Dec 2023 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302931;
        bh=uDlu4Y967RJ4SxiO9YzlT7AG+ZRio0a6mNsr/SQmFbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZL4nbKUVzWns2EId+asMBx/XS+gzzr+KhBunQNhTHc4/c8R2eeoMrAFUgVfBK5EW
         Q5t0uAoAVykJtlwB85OZYnzrp4542yzpCOkLsZmOEAcnlAxgoQnUxU9z0r9Ic1c4Ht
         FsVrGRaHcl9pcUC1uYPuA2ZpbpQ570EdBgSQixgBbEs8rbEMHqoKKrAyWBtQznYcJ5
         XgII0ZHT3i2nAkP3ZPGJaQoqz8RdwulgtqICfrFCcq3hvslYFZGIFvmGL/Hx2XEr5m
         nPTK0mMPvWAGdYWp49RHLAan2+4tDyj/gwaZJTi6jRYGHCiJiupBZ87OsXfnEe6BHJ
         SlmN0Za17OY/w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
        trevor.wu@mediatek.com, tinghan.shen@mediatek.com,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/29] ASoC: SOF: mediatek: mt8186: Add Google Steelix topology compatible
Date:   Mon, 11 Dec 2023 08:53:55 -0500
Message-ID: <20231211135457.381397-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 505c83212da5bfca95109421b8f5d9f8c6cdfef2 ]

Add the machine compatible and topology filename for the Google Steelix
MT8186 Chromebook to load the correct SOF topology file.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20231123084454.20471-1-angelogioacchino.delregno@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index 181189e00e020..76ce90e1f1030 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -596,6 +596,9 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
 
 static struct snd_sof_of_mach sof_mt8186_machs[] = {
 	{
+		.compatible = "google,steelix",
+		.sof_tplg_filename = "sof-mt8186-google-steelix.tplg"
+	}, {
 		.compatible = "mediatek,mt8186",
 		.sof_tplg_filename = "sof-mt8186.tplg",
 	},
-- 
2.42.0

