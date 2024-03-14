Return-Path: <linux-kernel+bounces-103373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFA187BEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA9A1F22BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2946FE08;
	Thu, 14 Mar 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Lbfzo5sq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AueD9i4M"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BBA6CDD7;
	Thu, 14 Mar 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425823; cv=none; b=Fo9pLqVkavV1moxel7VbFHTS/Oxcvb3Oh2ROP8QOuJlZrC+BzsAeOTNcB+QDstjJ0IPa0QF69FRpD+oJiHGrMnJxiOzBstdXmEv94AKQUdTh2X6I1wRkdOiEUaSYFbzrRFnzJ2fy7gFXp0gcMLidRs8VszG8szowo1/9alaLKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425823; c=relaxed/simple;
	bh=t3Fhm82IA3qEn//L6TADwfZ/ubG1FO2YvkjqhDWU4X0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tqZm9UAST/rMN/YnalyY3avzJtTYRbAqxB5ZHtCnAg6WMbp0ftBu/3chukERIkmV/IZrp18GNq7sA6j0wPDVAjKZHF99ycHWZiVHPSGi604vQUvz8CsRKOhH+yqCA1nH1MzEiq59NgX5DaajgT9tQmY4Ai/yVBIw5jxUHHbAjig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Lbfzo5sq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AueD9i4M reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1710425820; x=1741961820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8iPlLmUMgTAPqy90kGRd7xSvJIZZRBMTH99jyn15Q1U=;
  b=Lbfzo5sqQaRYNEsGK/vJK2TF+/4WznGjUTdVffhXYc7CkQJo4WU2HHC8
   gSZL3eoXd9sRGB4t61M9r6c+LkvBVTJ566p7TO512ibRJEyYeo+RFYp39
   JbqZSYvRZ7E1jaM09rs+89nz8WA1DDG/fHyyFyBixHRcbFBeJA2pDUwgt
   oZsUzSuhJKs6YUj6eFWliARfVS/kDP3yZna1asQ+IzuWgBiG9Y/2353ZO
   tzPEC7ukXjOXd/XZI342qRE/C6GA94XM2A8CKKHwLaiiPtZAjJkD/QlYA
   6Gj73NsyBUICpoNetqaPl4I5c2v4qx9HhX1YzHXpQVKONefDHjVni5JKz
   A==;
X-IronPort-AV: E=Sophos;i="6.07,125,1708383600"; 
   d="scan'208";a="35915593"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Mar 2024 15:16:57 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BDCBA16EA37;
	Thu, 14 Mar 2024 15:16:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1710425813; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=8iPlLmUMgTAPqy90kGRd7xSvJIZZRBMTH99jyn15Q1U=;
	b=AueD9i4MSbWj8uDoyxhJnFzJjBepny7VkKEApYcIw7tTFraO68yvuhq/FmEgRpDxcKT8EX
	j66+6KUj9UlkVXTFnfoTttuazt9UfiAMkfytU9h2+TG/6S7xsbjKfo47je+NGIqqy3irHU
	Zg3EnXFNQ5IrfIXzV1orSYS7KfpyTneJF+ZmwdhSbdiQR9iwnQta/Nh5gv+NUAPF4rkAmq
	sn9Dk5dN1uPtjvM+J9OPJMm3x4DIOGnBn7r63YtQgE+L+0jMeHbYAOSZmXuTBx0VHe18x3
	u/c8Bt64qTcdfJKQNtaMubrpFyZwYJ2RVM4z+PEF+GMUI1NPI+oXIronXfbNZg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ASoC: fsl: fsl_ssi: Add dev_err_probe if PCM DMA init fails
Date: Thu, 14 Mar 2024 15:16:42 +0100
Message-Id: <20240314141642.2943605-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This happens especially if this driver is built-in, but SDMA driver
is configured as module.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 sound/soc/fsl/fsl_ssi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ab6ec1974807..4ca3a16f7ac0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1401,8 +1401,10 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 			goto error_pcm;
 	} else {
 		ret = imx_pcm_dma_init(pdev);
-		if (ret)
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to init PCM DMA\n");
 			goto error_pcm;
+		}
 	}
 
 	return 0;
-- 
2.34.1


