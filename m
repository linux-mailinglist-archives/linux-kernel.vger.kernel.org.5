Return-Path: <linux-kernel+bounces-144343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D367B8A44C3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A74C28242F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4103B137763;
	Sun, 14 Apr 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmS/9jly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4913774E;
	Sun, 14 Apr 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120553; cv=none; b=sHg8KGJXdvkv/LQihridf6w5DnLWX7wL/dPNjKjMIll18l586Dpbhvojve9nNrB9Dqb1VyAhU+DM3tPktnTbsv31El9LlI8lgyCvQrjL6NpOnS7XQ2hFw/g2PI7FDxzEuXZCohnTgSEJIkFSEKbD/J3rh1wP92uq0oO0/pSmybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120553; c=relaxed/simple;
	bh=Db4WsSNM2FgoOQSGgEU4G93ggGnc3OdLIs1I7eFzzWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4OoYuIwe0naYiggwVDqcn9rq2K+mi+077j3HM3oK3VDLnASMUg3+1nlscOeSJj/vnGyXeZfmOpZJGvMI7nrDFqnQ5yG9++fhhWIMrmxjcblHkC/0mxZl5d6bK28oMwpG0DiWRDq/Hznwxq7HYCJOfN2ur+qfb4jfM0oPiytYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmS/9jly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AD2C3277B;
	Sun, 14 Apr 2024 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120553;
	bh=Db4WsSNM2FgoOQSGgEU4G93ggGnc3OdLIs1I7eFzzWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VmS/9jlyQ4dccHlLXUaQHIkl1zQz5LAXsDlXSjtbsDu4aLEk3nOGz1aktC644SWOS
	 y33TIrNdE+g3Ze0eFdtUM/xU93SvPXSC991p2erQSZomhATgtVC4YuWHbC+Ut1ZbTb
	 4Igc1DZr6P3JstvjAzDKjq22aIztDWtO42G1C7Z7nSD00A/Xm6slmqbyK6ncrx+iae
	 BZ/FHCwhwenCUKQtxH5afBzPONqmCw6dLhJAKjjYVxDPoY/x0RvKafavlZ9r+SR11E
	 gMbk7h8YF9CSDtqe/f8SUxO8xvAg4v5pr9/bBfUBaJpoGppoUEBCcka+IN5lJZFB/d
	 PADRZ8PgFd8lA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:36 +0200
Subject: [PATCH 11/14] ASoC: SOF: intel: bdw: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-11-8f53ee5d981c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=699; i=krzk@kernel.org;
 h=from:subject:message-id; bh=Db4WsSNM2FgoOQSGgEU4G93ggGnc3OdLIs1I7eFzzWE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTNXyPnD1k9PhT0IGglQogIL0hIpkrjzGLbn
 fTJ1GhAAz+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkzQAKCRDBN2bmhouD
 11o/D/4o/aVI6rNfgMctgSxzfRhCLSZE8MUPowQU6qt8JnDQXZCNgUGqXls89ap+m+sgna8TkUn
 C+Rw8fYNENZXviIemO9yqJirzRTqmIsID0whZ4Gj/++XWPshkF8Ruqb502ps0qg6hHfm44A1UL8
 vZ55c82xWdaO2sfoTUJruIs9+HO+X1eXlSDOi83q2nLekxwPxmvbctKx/OkgR5fitGIYmnukz6v
 0I1jr2l++iphrte5SJr9KXqALBYj/bZEdCiymT+2v/yxYbNDQ5G4EKYbNJHUw+k+K4Nro6VRZs6
 2CLUBqvGb5QvEzzT7xZg4AkI/eli0fCkJ/5OGPwkVpEiakyknR7RfYXPVp2mXsuF+nGMKsFVwM2
 198rpkov9I+yg9+PwJUAuA0z7V1bKY46I62kaeaOOdQPg7tkLYmfAsOdc/kiZKr6yYtc7ztPJkW
 8V08A2oZNAGz/Giqhu3RTPgU8uKrc5Tu9dVIVVgZyFMPoP+afiqAv/bnnaLE543O3d6hdizzANI
 ztTZ5zExCDDYnNywGeP7jxHBNzevpZRYuylv/AtIniOuTLHl+J+4A61CrV012dY30ssG0YN8Lb0
 vQDMuO9ApmJZP/mkzyynvkkzbFAircRrSG9Rlnzvq5fz6iPJ+8Wmkyex08xOZkPSxBHbVUaQ9SR
 fjgVeEn/HCCplxg==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/intel/bdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index e30ca086f3f8..2e8926cd00f6 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -567,7 +567,7 @@ static struct snd_soc_dai_driver bdw_dai[] = {
 };
 
 /* broadwell ops */
-static struct snd_sof_dsp_ops sof_bdw_ops = {
+static const struct snd_sof_dsp_ops sof_bdw_ops = {
 	/*Device init */
 	.probe          = bdw_probe,
 

-- 
2.34.1


