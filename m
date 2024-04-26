Return-Path: <linux-kernel+bounces-159750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF98B3391
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803D51F21D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3AD13F42A;
	Fri, 26 Apr 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHlRaIQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE41F13D602;
	Fri, 26 Apr 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122370; cv=none; b=NGxmpBDax0FsgFAnJRb3215jO3iLIWJTASR8sWHSAq4vwWZUPMcGyFQEKV59KLjaR4I2+z8l8BzvWEZRSidqLuQA8vyhTKOWqfpE+HwsLCq7oIVzk3Eh3S/HiLgTLDnO+62naAcrbpQvKfaoz294VdttE2AT5Z9Enf7jclW6mNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122370; c=relaxed/simple;
	bh=U7rM8eY2XCeqSnVqnkIcGkj39dk+3X6+eaiO397jKG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwHN2osiqDVQzlUYtHfh3VLUXQS5JP2NV4ACt8ZKJzUa2uFVWRsHU2gU/+k441+y0Dz9GtqFuZhk3+0KfUQAQVFGXjdVzTxTzMXk9YocSf/Q0B+0cOUQwxxxEeF6cy1meVxuqKISPRLeqVXypHu1MVYoIpoD7kg5Yg27Zd34vkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHlRaIQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C34EC113CD;
	Fri, 26 Apr 2024 09:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122369;
	bh=U7rM8eY2XCeqSnVqnkIcGkj39dk+3X6+eaiO397jKG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EHlRaIQHRZhxTInYYhLyQWXpqNgH1uCG5af4QWoEe8HPIv6gFk1wMCWrp0NQS+4hS
	 u5lBzB3dvgtEV/63/NPA7ElNZnGI7NO/vCDTBBRjQw8uZf2SB0USLGO+SGDPKXDGdu
	 Oxi4nitpAhrR/87jm13+X+DyJu3PYMn28kTXE2oKuG0MPT5ob3fniPVPh1igevk7dY
	 /bSTQhn93lZUtG7xtgyxjt92zkbL2pi2Q6l519/FCr+8eSuELxmN3VN9IIGc20tL9l
	 zFAfLVxWUXAT2g8gay7wjz9FL1tjSQjTz0Pp7xxBTryUJFJIGdBbI7hQNWLSh+TI3j
	 qIF8uv20kqhgA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:57 +0200
Subject: [PATCH v2 10/14] ASoC: SOF: imx8ulp: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-10-e553fe67ae82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=krzk@kernel.org;
 h=from:subject:message-id; bh=U7rM8eY2XCeqSnVqnkIcGkj39dk+3X6+eaiO397jKG0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24oIJZMxIOpyh3SskZv42qnFSQ4zPHQj51OD
 hjxWQK/V9eJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituKAAKCRDBN2bmhouD
 16t9EACOG2WZz1DIlgW0FSMln1bXk1N6nXfR61Jw8YlE7K3nuvGz+gnmo3qchGZ+w2KMVajg8WG
 XYGeOSHhsWJVMpBJjGOF2jnVrAFg3rn+i0fm+QPcmAobrJ18tRFYDLezgV5B/UzGgjqN4KKMJ+D
 auPeqGXppSZDWM7iOCQCKU49i2+oZl8eSYQbS+cKUpEWEwhhv+Gj2wjtjoGuWXd6oo6gabg/zL5
 IXOinT8WZYluCFuCwnDsA9rLcFwjBEZARaQWQZPt8Pkfog+6EQb4pBL4n1xxcRpLd74KicEfT81
 82lhfDRR2KrgxvoidGkhzDXXgWEwoqm37MmlN1CH2GXBWIhabGynE7V+Jc5TjeFTy5DBfQs7kwM
 R/bUlqSpohKJ9jEL4PlCIu7yA9Z6b85F0GcxURrlPhgEeDB5d3XnJuSa1gOWrdB0VdHIlHVXXwu
 YWzlXtS/bkT+RGzNejIfIFg9Jla2qhtd5yo9PaQaVJdA9L+l+jVc0bKhqSFEcSI6+rURwGNkFYb
 sk9VZOhWL0S9YntBb8bXD20TbBRxE2m9ktTVH0ShSPpQyyxUI0iyksSvR/sI5ApeJCmTkwy1mch
 OXka7spjPIcNHgFRIOsgB6Tro19CTHSdKt9W1YKzeg3DM8ER5hSCPs4Lxulkq585eDoEZfuxAZT
 GzjHtQ3YKizo4Ig==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/imx/imx8ulp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx8ulp.c b/sound/soc/sof/imx/imx8ulp.c
index 296fbf11f6d0..8adfdd00413a 100644
--- a/sound/soc/sof/imx/imx8ulp.c
+++ b/sound/soc/sof/imx/imx8ulp.c
@@ -408,7 +408,7 @@ static int imx8ulp_dsp_set_power_state(struct snd_sof_dev *sdev,
 }
 
 /* i.MX8 ops */
-static struct snd_sof_dsp_ops sof_imx8ulp_ops = {
+static const struct snd_sof_dsp_ops sof_imx8ulp_ops = {
 	/* probe and remove */
 	.probe		= imx8ulp_probe,
 	.remove		= imx8ulp_remove,

-- 
2.43.0


