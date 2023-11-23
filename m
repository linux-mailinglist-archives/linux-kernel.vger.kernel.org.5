Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D0A7F5A55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjKWIpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKWIpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:45:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BA3D41;
        Thu, 23 Nov 2023 00:45:18 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A22D46607377;
        Thu, 23 Nov 2023 08:45:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700729116;
        bh=pEBjnfCzPZOMm5mjeyRN3TyyyC1b+Njse8wt4P34EZg=;
        h=From:To:Cc:Subject:Date:From;
        b=dJWtsHaKQEwT234V/aE9m5DOUBXvUuPPx3/Itz3czdkuNf1aj+dbMLI3le64hfv1r
         ZYzMsQjRoubiuULRs4armVtyT8qOAjRFJxpPNX4NPT5CEUY7IQ0UM3S157MKCZnANM
         CFVfkG4Kj4VU9pVmpHhBDoSInS7UJY8Ighr53UPgkOb95NuvuUmpw5RtCSratJ3YGe
         WGU5qTEt+VotXm3TvyG8G8+hx/ot/DxlSb99PpuNfT327sfiOQxrwZcsmTSlbb0eqb
         0EIoHzytREL+6Ox2wa3r4zA7kR9/rduPTuiXuDEvursK2OHTGWBfPUPsWHjXxClTZx
         gOqk5khQNPpZA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     pierre-louis.bossart@linux.intel.com
Cc:     lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        trevor.wu@mediatek.com, tinghan.shen@mediatek.com,
        u.kleine-koenig@pengutronix.de, kuninori.morimoto.gx@renesas.com,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: [PATCH] ASoC: SOF: mediatek: mt8186: Add Google Steelix topology compatible
Date:   Thu, 23 Nov 2023 09:44:54 +0100
Message-ID: <20231123084454.20471-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the machine compatible and topology filename for the Google Steelix
MT8186 Chromebook to load the correct SOF topology file.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index b69fa788b16f..e0d88e7aa8ca 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -597,6 +597,9 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
 
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

