Return-Path: <linux-kernel+bounces-144337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6078A44BD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D0BB22622
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A219137C5C;
	Sun, 14 Apr 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjvcFNH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74254136671;
	Sun, 14 Apr 2024 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120508; cv=none; b=k6e3/x4FtUbabPZsp7p3GvZyt3TEOUgQ5CcaOpo45T2ThTxLPz4dr1audYpQE29PBSUOL3aKv+P/Fh/VBI0ue/3vMHHgCPF1TyCGeddyKRtNnbY/cPKXNHCj7Yn7SkBhvP3v21lOalePMjDTukMgEO+QzIVjBlzbkN4MyrCmwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120508; c=relaxed/simple;
	bh=E3Lgb8V8RKpyH5zK9wcRNDE7dtQPH+EB6tyX8qozgKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jyjn8OIcoM7/mthXxhkGPaAtlKbbCdQg069XWdi7bJVZeL1HATAqMvtxWuFo56HcZekJHT8q9npbxnvqIrrpB5ZdxklZ6xd7y9YBkmC1iFtVeB6EDJqy049f6zIFvQWWDbxwI43CX8MtkyuO0+X7e38RzWGnkZfnPJVCNes84WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjvcFNH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23B8C072AA;
	Sun, 14 Apr 2024 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120508;
	bh=E3Lgb8V8RKpyH5zK9wcRNDE7dtQPH+EB6tyX8qozgKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OjvcFNH3/nQWL33ZQOe+YPPlV/qcDPqGarfUwtM7Yt1eYuGdjnmLwv+CURMh55uFp
	 Jc2TEdCB9JymQt2mr56Kqxt5wxBpjx1xhcOSr96BnvKbq/g1lc5ehYs2everX6eAS9
	 7dkk2aFaP494U6uJjOzIt2vwx1xdoED96W0xYXHe7po4uLYFQDG771I1ZVSuCyWFxb
	 9GVRf5pVyI7CypZgKaoAz+Vc8gHPhNiTdO8HN6b2Qg3Pcxs02QX98vUyZg8W0CZEMS
	 Dus7lv2fEJxNLu2DUARmkv5tbIqIDyiEhDMbmWyv1J/PiRwMB9xokQfooY+BSKD8ox
	 5IK3F0oxs0uYg==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:30 +0200
Subject: [PATCH 05/14] ASoC: SOF: intel: pci-tng: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-5-8f53ee5d981c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=krzk@kernel.org;
 h=from:subject:message-id; bh=E3Lgb8V8RKpyH5zK9wcRNDE7dtQPH+EB6tyX8qozgKM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTIDy3Da7qtpblMGIwPzl1JuWlzNxlyq+NK4
 zvMVQDu3geJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkyAAKCRDBN2bmhouD
 170/D/0c3KsuAsTQcXYmaow+UH/9VU+H51CVHZL7moe4HJJNPIEb309ntaOE6QQO2G38wsFzY4s
 IpSWVJFTkIYjPMP5t5u04Xj9C3k4nU+qhY2OZD4o/V2fTyhDFvSbzV4r9uqBxBnlOKmugO2KRBt
 gTMAYU6cObX2/VnooacJ6Ce6N0c6Ggbkh4H5fXKB9FIxVgQBgGs5N0goiA9wSEzlg8+P8LFbKBM
 WPiuiF9sHnDIZdiyMQfvayqN9IFBd0hb/9gOaOC/3tVMweNHCFkoXYUeFgJHuSZ7odpNpqZD90y
 18/hzaIeeCg/uQKBEFe6aiqVpnCK3JmT2hRCZmDlZvSuyDzQU1liykKWJkzmznaYNhcgwg6pWn4
 ITWzbhb7KzteZt3yrOOqFIpYcZSWcbY55CoUX3hQB5vy2jyGT0uKBffZiFALermHpXMUUuMVp6R
 cr9IKnJaPtaE8N0qAW0+hcxIkmacyLxSydN36onQfgk/bYWuml6gRlog5CcmeIa18g+pd99JOTf
 D1Nh5orj5oE90J6Xv3qIaM5SmTtUkqFkQjqkF0H2VnLqJKBMZwEfJl9jB5dwkI0oAjs7I/wMSby
 Wf2hC1rWk5D13Xz1fpKaYErRNd+cwQ1Tgq17b2jGuz5N/mqj3gjNTHRrm2jiKQNnxUBS1q+QwV9
 IT2N8xI3TbDMUtg==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

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
2.34.1


