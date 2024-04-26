Return-Path: <linux-kernel+bounces-159745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359388B338C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC982815A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C213F428;
	Fri, 26 Apr 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBD7tMPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AD013D2B2;
	Fri, 26 Apr 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122336; cv=none; b=jiSW9llttjNaqEZX71S+D/0zUcgXBP5lyF+G4V7s8uZLSf2PnVoF8DPbjP6Zvswx21CIf2Hx4nRiuIdO0Tnav0qAa9HP8zYl2OJqhEKT8eMYJI+xoMbEFCL+LJboZYdgzrONnbbpf5jrv4zLtNEgLMiQu+S7RkpzG7MobWtMRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122336; c=relaxed/simple;
	bh=vC0dygQsKcoCwXU125Mo6e+qkHR3/M16HFNlEdMw+P4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gRvaHFYNlhfLm+wdPXR69uUPdHdPJ47d8CZsLf1emMNzvlMo7xMLLRSAqJJoZF/TzVUaebRlhg4n3ZyGs0bdOBd5vGjLvDDpzlrht8tgm8bCALW6e8+pnVDFJgAXWZOmuJak7p8vckHRABkH34Z1siNDCSbHVBHv1sYps9OlOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBD7tMPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C4AC32782;
	Fri, 26 Apr 2024 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122335;
	bh=vC0dygQsKcoCwXU125Mo6e+qkHR3/M16HFNlEdMw+P4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XBD7tMPyyNheLa+gN8swvqjZ2Jamzylsq3bPnkP8QWH4sEa2ZluU5OEYNIgTn7TX9
	 1wZghFudVMbjYC2M+1hQO3kAOFUWSbZmv5QdBLvWVamtJH8zxylLKwfBmf0uh6Igyu
	 qJ8ceweXIcc+grjG/Asy7J1FfRaiECG+8MMTc9gTF1TG19hEW8uNMoPBOYx26WWJNY
	 y9xYg9+KNsWknviiPYU8V08+QtZTraEJSJvNFUU+pYakh1aoyJLIQowhNgKE6cYBXf
	 u4aygH1nTXekpDsnQhrSoR+8tJZhRd0xc8QqsDXIyr86rZj7iYTAromCL+P2QTk4DK
	 bv73PmIjclptg==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:52 +0200
Subject: [PATCH v2 05/14] ASoC: SOF: intel: pci-tng: Constify
 snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-5-e553fe67ae82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=krzk@kernel.org;
 h=from:subject:message-id; bh=vC0dygQsKcoCwXU125Mo6e+qkHR3/M16HFNlEdMw+P4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24jccjXN7HDS7Umt5KJRsyE/HRoZADSrvXMD
 GTqaTI+0zCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituIwAKCRDBN2bmhouD
 1/C2D/9/426s0WEhntopd8uoye52oKJ7JLw+XRKKjdBKQ6Q+gAlvGbx0CNaB6D+G/aFFOnYhlXW
 IOuxOZpAjB/JotGGK7cSOmkm1x7OVuUBERjIIX3X71w+MC0p445sFNqQQPPFxwCwc8JjTnFqsej
 MUfu7oh0kvbLlQV9tNz29JmQtmGebta8rxPYZstqtC8uOjlRc4ShuDTrLfFyuowyaecRDVxx4+t
 KBRCYnkOukaWH0XcEkhn5wfJm2b46+c9N9cOjkF+iHYJh2iId1ylUhffh78Jj1Kc8DMMLKbrzcQ
 GVZXWObaba9GYu5T9Xju5bvOFzCMZj+zj1KNTHbz8fkaAVZkjdiUTdsZJFQOgJZatKmprwdPz1P
 Nq/BSi+UKcNMLxOfnbpHzZBk2S+CvCdDnHbugd6+UeM8kbjtC1iXK+0ZWtWJtshzLiP4dooOgtV
 M8QOi1E+tCQbOYWUqkt1M5Qo11o4fFVA4w40qPUoYgVd+2nsQMLWeuz4RPxkJG96P3qJRAWiXk0
 BJY1suCg//gX/q32GBbe+HxSzDKhNmGWYGY5cqcxOHLKVe4Bhf18Kzlv/sr2X2IiYb6rLBZaU4I
 k45xHMPQVIgFwqZ4WKs+wf6gxs7PwHUGsJpjYjJNpfZ2bpbPrphAX5kmNC/hDQLIbFvIo6vHksA
 Gay0iMeShk99ryg==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/intel/pci-tng.c | 2 +-
 sound/soc/sof/intel/shim.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/pci-tng.c b/sound/soc/sof/intel/pci-tng.c
index c90173003c2b..d8a36d5a29f7 100644
--- a/sound/soc/sof/intel/pci-tng.c
+++ b/sound/soc/sof/intel/pci-tng.c
@@ -132,7 +132,7 @@ static int tangier_pci_probe(struct snd_sof_dev *sdev)
 	return ret;
 }
 
-struct snd_sof_dsp_ops sof_tng_ops = {
+const struct snd_sof_dsp_ops sof_tng_ops = {
 	/* device init */
 	.probe		= tangier_pci_probe,
 
diff --git a/sound/soc/sof/intel/shim.h b/sound/soc/sof/intel/shim.h
index 9515d753c816..18ce3d33fa80 100644
--- a/sound/soc/sof/intel/shim.h
+++ b/sound/soc/sof/intel/shim.h
@@ -196,7 +196,7 @@ struct sof_intel_dsp_desc {
 	int (*cl_init)(struct snd_sof_dev *sdev, int stream_tag, bool imr_boot);
 };
 
-extern struct snd_sof_dsp_ops sof_tng_ops;
+extern const struct snd_sof_dsp_ops sof_tng_ops;
 
 extern const struct sof_intel_dsp_desc tng_chip_info;
 

-- 
2.43.0


