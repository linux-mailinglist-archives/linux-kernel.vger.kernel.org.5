Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177C180CB8B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbjLKNw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343757AbjLKNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:52:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC21985
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A74C433C9;
        Mon, 11 Dec 2023 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302750;
        bh=ZqDHnId5/TbfAm+FTvYjpxxf2wubBNQ9vZpZbZSbxtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXG/B9bCjRNf6cvlbaoz17MKFGDfYgFlzMEFpZEitLxS3BA6QsDPypy3fMrvJhp4b
         H4ZkSdE9V9QUvs6UoDn3AqOc/bpPNdXJrVQngoXvcuju7yLgEr1klfgLbIH+Wc7UHx
         Mlcy+BF/rEkUXv+UUtEKw5/sDY5GLEOuJBqGocZ2Yu5XqH+4WBkRVEC0jYH71Cedu9
         nqhoutwcXYTOzdp3ItxzAb4mor8N1oJ4o/+uwdSYL5752g5HwTdmHR08UfR3gi0QZ2
         dpUqlJOt+LC4LLA7KVIYn54FA9XdePHFTaGWFnwAgPvBXQd6CAFysbgBEfFesjc6wU
         t2kEO9qtU7aaQ==
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
        kuninori.morimoto.gx@renesas.com,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 14/47] ASoC: SOF: mediatek: mt8186: Add Google Steelix topology compatible
Date:   Mon, 11 Dec 2023 08:50:15 -0500
Message-ID: <20231211135147.380223-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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
index f587edf9e0a70..35f5c2cfb6e45 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -599,6 +599,9 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
 
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

