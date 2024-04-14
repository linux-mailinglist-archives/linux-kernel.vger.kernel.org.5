Return-Path: <linux-kernel+bounces-144345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AAA8A44C5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632581C21173
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99150139CEE;
	Sun, 14 Apr 2024 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwATu6cR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5D137911;
	Sun, 14 Apr 2024 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120566; cv=none; b=ia/Nz4aDn0hhMqwxVFfQ81O5WgO20mefZmmgibjzNPZltnKJ6FUKXlDIAK80v+2Z4ge+iyfqI0xQ+3CdM+RSCYI/r9zG1YXqr5fHMkKY0JhvfT4Tu5PcGf+9kL0Bna90qMwtE3mtshabFrUjyTxOPhFmgbjDsuDwuvRipWuTGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120566; c=relaxed/simple;
	bh=PTqTHg6RfiqGrMd0uUIo4Ojcwe5ZdipOblCxCj/1tgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJwkeQ27e9ZvbasFgGbAvS1MRH/XzM5WVTMd2m2jgCYdA3ZfS5SOulquYI3TIw6EoZC+SVEyg8qHizqLlP2A8kDV2y46Xker+H3MLOP6t0bwIENJuxYljEV9+j+zus1creSJrVfwbRs8bbAYrdfEExGZK0GV80pCpWJ6aMmQrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwATu6cR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1463C32781;
	Sun, 14 Apr 2024 18:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120566;
	bh=PTqTHg6RfiqGrMd0uUIo4Ojcwe5ZdipOblCxCj/1tgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IwATu6cRmszBY4gR2PIa7SDexM9molkMbo+DqxHpgMHUlb7fjP4I67pfkyikAvx+B
	 8AUIgr8XobjSReXhJrt1DSZTDiMkg47rDLyrrH2JEgeCFU7D+x9Hs5eu7t2gipbk1R
	 XrlvZPZLHf85cZ4ATNly05hbHOG+d46hywerfCOCPPS/rTzOwVBMdFNJCyESfhi4/d
	 U0vid3hw78JLcntpuEAhpRiFp+9UiQy0MjdFVRHZet6M+Fcb1mAmrjjXg2OG/CKjpN
	 AL7C4C4DFwdg9cmMQm6LyML3hPjmMJtVd2hzv4P4KDfUSipX4A9Z03nQzBSN6Qoo5C
	 1Fflvm3LQo+mQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:38 +0200
Subject: [PATCH 13/14] ASoC: SOF: mediatek: mt8186: Constify
 snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-13-8f53ee5d981c@kernel.org>
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
 h=from:subject:message-id; bh=PTqTHg6RfiqGrMd0uUIo4Ojcwe5ZdipOblCxCj/1tgs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTPy0Vuz1BCpQH16OSjw800/AKgJdci1kr7g
 iuRvvsvesiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkzwAKCRDBN2bmhouD
 16l5D/9XYqMivdns13ObQag4GyuRKauiWiecnojrhow88jGtYdXBY7+jBn365wZvR9WRWZCMvwK
 51RrmDEO/WWeBCXADRmQPj2BhveNuH7fXlhKVhdL5Db/XhC6JqCD8nv5xvsUuuF6YQ70L/Tr24c
 hH2iKB0UidxHYxdkHmNzv/EXNA64W6+dsAIUsMbaM78sCDD7Lam9eUd59UkYzWvGx3h/KbI9W/H
 ZaPfqISgobcvuoetAEyzbLuDdLy+SYe2XvP0rLpg9byDRvPdHgNzFDKcMVcmBg73MlxfWGjGqjF
 xryOFNwxg2BBHHGEaiXfDFmUoU897EoeGsHDSQaSywILHigt32lhCbrQUp36CsRR04sbxNDp0gQ
 WdDNYHTTXFlPK7g+ainTKqvFZXwJc8TP2Krxn3ygqxHNQFNBFbCKOPLz/SyjpzaFQV+9PwC+nN1
 8uYEyHSpiaOqaOchTXMGIEQIQfxYx8sLe2JCZ1f3ylfQltQQzNihuVU7vPHEZBck3g9HRwxG32v
 xkJsLHxGt39rwFmq6+Hjv6sbzStih9HZwiLRmLVzWsD8Q5W0NeeD4/6yd6wLfVj6cQK54UVhrjw
 X41Xya6xAI4CLx0szmdhh7SbwLwQJ2c9OdmK8D24keawTloMzF7VkfUYKUSpXahdJddTEaIvNd2
 SnHjFx7gm/+DvmA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index 0d2d7d697de0..c63e0d2f4b96 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -481,7 +481,7 @@ static struct snd_soc_dai_driver mt8186_dai[] = {
 };
 
 /* mt8186 ops */
-static struct snd_sof_dsp_ops sof_mt8186_ops = {
+static const struct snd_sof_dsp_ops sof_mt8186_ops = {
 	/* probe and remove */
 	.probe		= mt8186_dsp_probe,
 	.remove		= mt8186_dsp_remove,

-- 
2.34.1


