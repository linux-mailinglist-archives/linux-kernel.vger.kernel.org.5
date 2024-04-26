Return-Path: <linux-kernel+bounces-159753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C942A8B3394
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 111ECB22F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3386913F446;
	Fri, 26 Apr 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGG9w0Ei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159A13DBAD;
	Fri, 26 Apr 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122389; cv=none; b=KH9oa4KqjSXmNwfftpiLvuR7UalzMXOVnNFc/KcZs+Nro67yOfHXCWZ04imSpveiF2KrzcLC2wJv/nnhSWCnEjSt+i3vzX96WYx6hRjOGzk6DMTN8bjcWq/WDyh3Covy9an2xSOKTJMSEbfu1AJktFfpVtsvJcpteex6M3Kobm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122389; c=relaxed/simple;
	bh=CxPAgNjTAhKSrnJ9nXn8uxxa5Gyc46BCpw5S/shz4vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pH3GbKgOJhqDvaOEBFVFc8tjpv6ncs863EQo2OQNwdbJxKhkQ22iygnrwjk/RhVoHDo5TZqpeOTuxRbavOpmlYIBvXcX11TDcAlnLhLLL530Tr6PElcGqtTSWdn0eljuQfULpSuKKNkLdxd4mnvGtH79HoLDZbsa74ouMddWPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGG9w0Ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D6DC2BD11;
	Fri, 26 Apr 2024 09:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122389;
	bh=CxPAgNjTAhKSrnJ9nXn8uxxa5Gyc46BCpw5S/shz4vw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mGG9w0EiFE359M4Z0kyegLPJAuOetfwlvp9QRl5QeoRqVdYpZtPj0vI8av/F9Alcx
	 vIbZ/OIlL0O48oW10NYCdK7FQwLHW2ttIsD9A76ippIY4cTI228dJpHnrFJFSR82dh
	 ajrbjJFT7UEh9YfSjpIY8H8CHX7+n19qSm8m7vqnXfSLM4Ja8vATtyGXf3l1c3YAwz
	 UcMW2ocWMcp8W1ZaRd7TnQLgdGtewx/25xd+rIyVhFBGaYZydgg5/mqzUNSO6JQ4cq
	 sDdm3SVjmlwRUkCdg4HWzL5ZYJlrgipbJqE7FPetpZQmuvGC7oq4HyUmXKBnIzpM9G
	 pIuwptjfd+0Sw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:04:00 +0200
Subject: [PATCH v2 13/14] ASoC: SOF: mediatek: mt8186: Constify
 snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-13-e553fe67ae82@kernel.org>
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
 h=from:subject:message-id; bh=CxPAgNjTAhKSrnJ9nXn8uxxa5Gyc46BCpw5S/shz4vw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24qWF6cO+604OtziJ/NJKVjNH2vRdMlOvKW2
 ZVeAFYdmmOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituKgAKCRDBN2bmhouD
 19rmD/wJu4RJJ1iOkGW6XNvX7fpPFzE4tZjBrpuoS3aDYr+2SZnWCK8uN7kvowcs3ZzHaa07zym
 wIXdJ7M08Y+Za281aWLjxHXI6wPqXkaHGSj6kn5rW8ni5iRo/tHYZjoso8PINUSg3ShVlrbCp7M
 mswEjchbBIYjGArF8MBdepFCzThLrd6LrQGhysK8P7F/VlrkcQMip820lmk8TuxBVMEg1CalacB
 PqnIHGc2WFlhcSW9okNqYX3ZKby0a6o6iBNukbx4KoeXbQJiNyZ0UG2bdT2l/Z7Dwai+a8YJnT9
 zp6NGMVAa7ak5V6RcD+OUc8RjoVn+/Dd+gW7HDucLBAmFiALB1G+q+hDp5WOSpVgQPPnTo53D6g
 ze6s697K+wgmY7eeEp3jxrByXLzJelThlzthE9aParvGZXOcKtGyi4j+a96wRWBMuYBEzQCDQvp
 NCZBXC+VxYZ+v+jNuIByVwSjH3BZV57alL6v0k6SksyarACcCnWLBN7jNcULL4L+JzZ5OFpfeUC
 yzn75lDUrGRVU0l/YsQC/CsXz8mrzEfy1uzc5SQKU2hBWHtGp/uJbF2cW/x4vh2OyUvE2VB6icz
 aLvdXQvbaawFW2zCL4hBre7yFlBs9r1C3TmjQ0G/cLcum2nuKj3qWy1pt5tTLiVG8YSNheWyq9q
 XLK9ow2hSolnP8w==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.43.0


