Return-Path: <linux-kernel+bounces-159751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B326C8B3392
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8141F21D48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D44F1428FA;
	Fri, 26 Apr 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8CuFujt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6813E41D;
	Fri, 26 Apr 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122376; cv=none; b=cKmClh/+Uk5fF2E9YlCSzQak6WaaYd/S6VAfGj19u5Yg1nOUvyBZquGGwYslHUlHdnn/lLMTCCM78MUsk0pf4S3Idzr31YwKu72tp9NclAueldX0GHLzWSF2/xneBb34Vh78hsI7f91GxB0Jl346rRHX+lAmSZrfh7lcKo4XXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122376; c=relaxed/simple;
	bh=eJDuVWi+jYCBaLC3ORH57MWQfQKGUmZnVJ/O4TqSGNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaT9QWRsU4q2NbzelwKOqBmkU0AG9CrmLXMw7JIDyzc52mpT+KPCFHpdU1lVzdehhh90aGUJjb4ix7WmjzXZuLK4xiozaCZGPRyx1po/RTzuchdmaPAyxcz/c9xts5XH7dbzu9sa0e3P3uxNZHAMxlqMrlIDxu7u0Co4k8oTDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8CuFujt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026FDC113CE;
	Fri, 26 Apr 2024 09:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122376;
	bh=eJDuVWi+jYCBaLC3ORH57MWQfQKGUmZnVJ/O4TqSGNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z8CuFujtfOSPE3PZwFJJJ0wGgk/jW/SeyyhWXkZL5uIG+UqDKBTIN1LgQMmbvtzhW
	 AU45KNvTx3PhKBk2CPUs+qx/Wn3ftMNf5K2Ng6HIgI7UT8dVutBYL0Wows5bkpR8JO
	 sJxGP9nXkUruP5FCvjF1KYvzNN9L5VFaSoIurw8AqYZUlAlkLqkrqFE4OFdlIHBHNS
	 3CL7RY5G8huMxIgHIk/ZsCuWEyCHB8jZXv04wNJybGi8ed6+6R4ctapyFL1PrnY8CE
	 YXgY+u/Ke8JUAIUC7VG/1beiu9Ve1udYG09eiuhprYY1Pm+rbJV5cGwMg+Q6cGkdU3
	 InsIhnlgFuZrg==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:58 +0200
Subject: [PATCH v2 11/14] ASoC: SOF: intel: bdw: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-11-e553fe67ae82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=krzk@kernel.org;
 h=from:subject:message-id; bh=eJDuVWi+jYCBaLC3ORH57MWQfQKGUmZnVJ/O4TqSGNA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24o9lkdl0D+KPxdSHnWLzWtJkJA6J7OqHrZX
 IiU4DplLEiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituKAAKCRDBN2bmhouD
 16etD/9M9dSqAhJ0GkZ0uhTTUqcf5H/6EGraubd4ECuT/gVSj0r7R/Ft96l7+a1zxvQq7FZ9BN2
 2glALHBkYT5fH054mSanWWlGdixZOna/K2z5lCx58Ue+1rQD6c4m3xYgpCe0liS25NkcjqXwREL
 i2Kjc2ZiPz+qNFcaVW2h4Ahr/qS9A+1oYW9hghXhtZ8tsMdtZtaI3oByrTXnbz+s3CC5UA4HG/u
 dz/X5kVe0SSURufYHWoVULxYK3IJUL/AAqc84+0DN/TZZwkkoAdCVf8vQ13EQBaBz0jM+B04Tbt
 JAMuOGog1TztG4Gp06HgfLC2aB5kWieq9joJ3nBaMBikabLtkwk/xHH5GwTwrkTqJLJT2b9QMVR
 gqsGxx9+q/veY6LxeNdIqzdvk8ocpWsIpXWSehvOeMdH5z4Vq/bdLSxay4ah8cpaZSwWCyFKkFF
 3r398OngrAxgGEeEHEcyNqLGKROXdmlC4lu/y+emFEeir9P6iKzd8zKiB2CjNmAkJrovQjuT/sC
 8leguLCUQjehZ4G62cCYUPrGvHhGduVYp5TkEe1nwpX9LD+QLbzQz+4VNhjJYbibuedvq2Hr2X0
 Mem+jmArK7uyvmQPFariCvmraet9tCpyv6cSSEtfsntbnkwypEpvru9sv2HOgKBbJjrKKlSxhE8
 IZnyFt1IlRL3Lgw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.43.0


