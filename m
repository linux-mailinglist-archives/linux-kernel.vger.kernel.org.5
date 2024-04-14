Return-Path: <linux-kernel+bounces-144346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7AD8A44C6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4DD1C2104F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76391137925;
	Sun, 14 Apr 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiAtfsJi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4201137920;
	Sun, 14 Apr 2024 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120573; cv=none; b=nRq6VSTe3LWiq1LXPegc3T8oov2J2WSze8eHCefwj8Wge4kQh+U5FXKC69BrcX+563XEaT5EN/WdV8zndwoM2EgXQQ5g+/zkTV96aglYy70zRUCV6NbchWkiu+np2dNO/ILnWjMV/U/x5TrEF9ZtxuVSx102YKd8KGb0SErEBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120573; c=relaxed/simple;
	bh=uQ+S648l3NSz9IkZmbPzGnp5Cl0axGVfcA86WU5fpOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fyPV0zPsXzV57YMX4Vy/Cx2JnGkMPC5eh8cQCiWb7Og80wdvWKRV2UC7ipUYY6vmkZPyt2vXgOP/UshNkmej0yoQz7lc28ffqIK+wcAIvMUHdXTI7XXD0Krz4riRouqCDskoF2Ashq0V7aKQx7o+/a1/Q4PtRVJhQfj2SqR5ZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiAtfsJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357F6C32781;
	Sun, 14 Apr 2024 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120573;
	bh=uQ+S648l3NSz9IkZmbPzGnp5Cl0axGVfcA86WU5fpOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eiAtfsJiikEqdcr+79VZ0KLx7AOXG08ERkM3TDQN5wCxSAFVD8YpOGqVpW4tS9Rw3
	 Wn26J/SZaTauJoaHGH6+uaUG492rkuKKOm4xiMPC4JK84sLpEgv/othNzDupLaRR3o
	 mhWLm8S7vkz5iAKftgIs1WK4SREUhefAzCDsjOgOMpYbh7PX8z6FIFtN00soXrXQlq
	 HbnzTOj8SLt/62K8FSqU1c/+d56SE5jCwmSJ5nEIEVa56bD6Uc2bhjBa4z93hqnC1u
	 Tnr+J12+YFvwpGUl5fM1nK5AraIHuJcVzHBrcpZqj6TEfLI4Z+rOtJ2MfyZ2JIqAYM
	 gq1pPwN1HzuCA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:39 +0200
Subject: [PATCH 14/14] ASoC: SOF: mediatek: mt8195: Constify
 snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-14-8f53ee5d981c@kernel.org>
References: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
In-Reply-To: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=krzk@kernel.org;
 h=from:subject:message-id; bh=uQ+S648l3NSz9IkZmbPzGnp5Cl0axGVfcA86WU5fpOg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTQ0H8PMFuGVM51N5GfYEFfknVy7Wcjmiiwt
 43bIx4ypMSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwk0AAKCRDBN2bmhouD
 1xqKD/9NDtfWOgNmQGNrhyx8gyrXKfwSIDBIaqa5HHvwGUzbkT2Y3ROKNtSGB+/7UYL7KhtXR4H
 gKNGsnKTAGyeDXtAGyQd1hLupkbTd6+p9UFkgV4cuGMTfBUZC5Y8ny5pMSmgWqMGUOb2vMnZwgm
 RCF1iSsFygSvRC+ikIES5ZWQTGSt5WIMWmIV2+yRiYOopUPsG4NePPkrV11fHrBcjeVtcbCvKHj
 +hpnW3WeyLnGLMQbwlITgtFa+OUOQ2dgTKUGQNSK8zVcUoaASoeOQUnupH5rkuCzCSePm8gtoyf
 /CCh4QW+swNq9fhLyRAcuafehxbsbLU8Va2Mr7PX1Im/MmKifR/eIqTY/HwK6ac43Sn3ezA3a+a
 Wi5g9D6oVQO+iVcvWnDr5NbMVGdrYG3hOvqQkJNeuMec90Jrr6xcrRMNtUdBGN1jVAjF7t9lJgy
 /7tRkDgQyPaSt6F77UfToAceeC0Dfx8s9VmIUjHZgavbgXiVnOeYvFL3gqhPxKMCCDdbG51YjYO
 pczurvBtz9+Nh5DUZOkKleoSMQvNs4DhpDRzS0NYJhmfYcTWboSdDHReANirzMp+a7D/cQE3C82
 DBYswsZXuklU0MnOccqVU5n0CqOj6Sjv174g+w1qEE+5CCSA4lSALtZacDRT9Vkb1iMBNWXOxAG
 71E1iAysInF4j4w==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 8ee7ee246344..fc1c016104ae 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -505,7 +505,7 @@ static struct snd_soc_dai_driver mt8195_dai[] = {
 };
 
 /* mt8195 ops */
-static struct snd_sof_dsp_ops sof_mt8195_ops = {
+static const struct snd_sof_dsp_ops sof_mt8195_ops = {
 	/* probe and remove */
 	.probe		= mt8195_dsp_probe,
 	.remove		= mt8195_dsp_remove,

-- 
2.34.1


