Return-Path: <linux-kernel+bounces-159754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C9D8B3395
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9D02854C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05292143C6C;
	Fri, 26 Apr 2024 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQehXKrr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E213D500;
	Fri, 26 Apr 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122396; cv=none; b=jbO8yB/HvxU4r2wkbDTNvnids6QEAdESL3aIWRfbV7Fx/REiUdW2pSe0XK5tG85mKJQ8MM+NTvKA8GeUFrgy4N9E4Aw82JW22k/Y5z5CQyhTvOcW0rqjE+U5EPWvzAnnk/c5OnoJ0YwDrRHJhIKIOX56hfaEGMqq+idyCbXdh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122396; c=relaxed/simple;
	bh=1j45APt84Z2XIlLb4CgSXht8+Dv+bV1Rc+4llmd3nOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkQj1GYzqs2unCJX6y7Kjks/IcMHxbIyzKkoe/12STFQAvD8HoQOzk0h3UTDkED5j/Ug6lEhhhTHVJO483wOSZxP6FX2ERiexYGFDESZOYWQDKAEADb6T5amrFdMEQvH0B0pw1GzeaeIHe6FwsZfKQQwIcNWpKWNfSLLXedTmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQehXKrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F039AC2BD10;
	Fri, 26 Apr 2024 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122395;
	bh=1j45APt84Z2XIlLb4CgSXht8+Dv+bV1Rc+4llmd3nOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YQehXKrr/O/mDKcnEZ/VzzQIguHqfHe3LKofGVlscwcbsgubsTX5zxKFuh6luz/uZ
	 x5QOEM64z9voC8y7xCFEfsScljgkOzCOORs5FaB2kBMLjXa328uZOUQ4Cc0vf/ftt7
	 pCQRpP0M4CoeX20h+PraWWEdYcWtwHB9uLP+cRvTwa1LcT2sZm28NmT2tCRdSbpk+o
	 Kt2ixUBwlffHVhUkMnuvdCaPu+4qcjJ4xbPnPzOqVSvNJcB+u6/KRm0gXnT43X6Mfs
	 ET1okh6qQUwzrUjqbwwmQeMKpR5+FXRSp5va0PlCO42WRDjS7e1eoTIODOXevTJI0s
	 uyl0UUt2rOfYw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:04:01 +0200
Subject: [PATCH v2 14/14] ASoC: SOF: mediatek: mt8195: Constify
 snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-14-e553fe67ae82@kernel.org>
References: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
In-Reply-To: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=960; i=krzk@kernel.org;
 h=from:subject:message-id; bh=1j45APt84Z2XIlLb4CgSXht8+Dv+bV1Rc+4llmd3nOU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24ri5hbvvP8DkjdiR3gDZ/o/lD3rZTZSVmyL
 9OhKlqW3dWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituKwAKCRDBN2bmhouD
 1wyvD/979AcclNlfz3AHCAc7yWzJwuKG99G5B/V3GZmbbF/Q10mefin+IcW+1AAGJx2Ay8WQH06
 /gJnJMTc3D4r/w/4atnDj/NHGDbxk3muVAtK2hnvsR0839UYh5KzKhXGo1/6mOyClf6pbRaFPb1
 8jViXGzLcqMaBMKNWSCn7JwanyBjPd6O/O1J1Y5+cQvx5G94upsOAULNXWUOewj0xXSuTWXx4th
 gSgRLwfnoz+P1gVvurneJUtyWMOFYLINjNVclWPllOnNff328w3UN9Oi5rlxpJttkKV3EvOevXA
 D6M2gp7LsDUCyBHBVDe8ENUm9reCFKuFACkUnU6Gb3vF4AdUbVglglpD9+UHNr/MQMGNgc4n2g3
 ARGqfKiz9ibJC5AzsUnsErKtnJvNl9riPrMHpTxo9kyk5HDPSIg10LMOmzGp6ONl+8KBfGIuqgF
 6byJO3lHB14IYBAL77WuIUDDjUT9gIW5NzklFSiTcJys/0UWJ/zg1CnxJlTbq/1mzugQw+bOTeZ
 rpDZWvYtaNvQVTNIvr5WcZUUR2Pv4bPIf4D15CgtHKvTtbhBoFQqdkyqdvk/GIKXdjLqM2ShDRh
 OINLugwKjkJTmgFR6c+03NS9CXETbG+wymA6nbTIrHLhl9JrwVOoAxysfBELBVJLlzdCuokBjqv
 +kpjVSBdxdC1Z4Q==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.43.0


