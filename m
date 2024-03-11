Return-Path: <linux-kernel+bounces-98683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D0F877DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15662280D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D92BB1E;
	Mon, 11 Mar 2024 10:15:36 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B222064;
	Mon, 11 Mar 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152136; cv=none; b=RVxr8FEeOkM2i0X4LF7QK2j/FTY0l0yJA3TDU17vCfxCuNPEcwO2ag2vVPMl1Q8S5gbktAeEy+8buQD7iQQ2mp2oeSUbgzk2eCGpfEfwGw2fY2FT2VKDXPiRmwPUq8793lzOzqiZU6lZ8z5GBBqckkEejDvZoznyXcg8uu3ZiP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152136; c=relaxed/simple;
	bh=NZRW6tzTmDle8kSotz8FaxRCcE6d0Ym/4Gh5ibq+z7o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=ATS0VVyQ9DDRg+dTGqKs2BGLfOvyz1gg4IATPUp6hQCfkAAnJFtf4xmDmlgywriPknQYC2rUPJLgWLr+nvIuPmuPxBE0EeNX++IWSG3F3PrAnQDQDfJ307u61E2GQecSup1/IPLjutHuWBPMbLeb0Qu9Jf2099L1ZzCV/4zL7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FA251A1970;
	Mon, 11 Mar 2024 11:10:15 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C918D1A022C;
	Mon, 11 Mar 2024 11:10:14 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 12492183AD15;
	Mon, 11 Mar 2024 18:10:13 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: hverkuil@xs4all.nl,
	sakari.ailus@iki.fi,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v14 04/16] ASoC: fsl_asrc: move fsl_asrc_common.h to include/sound
Date: Mon, 11 Mar 2024 17:53:49 +0800
Message-Id: <1710150841-26991-5-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710150841-26991-1-git-send-email-shengjiu.wang@nxp.com>
References: <1710150841-26991-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Move fsl_asrc_common.h to include/sound that it can be
included from other drivers.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 {sound/soc/fsl => include/sound}/fsl_asrc_common.h | 0
 sound/soc/fsl/fsl_asrc.h                           | 2 +-
 sound/soc/fsl/fsl_asrc_dma.c                       | 2 +-
 sound/soc/fsl/fsl_easrc.h                          | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename {sound/soc/fsl => include/sound}/fsl_asrc_common.h (100%)

diff --git a/sound/soc/fsl/fsl_asrc_common.h b/include/sound/fsl_asrc_common.h
similarity index 100%
rename from sound/soc/fsl/fsl_asrc_common.h
rename to include/sound/fsl_asrc_common.h
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 1c492eb237f5..66544624de7b 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -10,7 +10,7 @@
 #ifndef _FSL_ASRC_H
 #define _FSL_ASRC_H
 
-#include  "fsl_asrc_common.h"
+#include  <sound/fsl_asrc_common.h>
 
 #define ASRC_M2M_INPUTFIFO_WML		0x4
 #define ASRC_M2M_OUTPUTFIFO_WML		0x2
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index f501f47242fb..f067bf1ecea7 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -12,7 +12,7 @@
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 
-#include "fsl_asrc_common.h"
+#include <sound/fsl_asrc_common.h>
 
 #define FSL_ASRC_DMABUF_SIZE	(256 * 1024)
 
diff --git a/sound/soc/fsl/fsl_easrc.h b/sound/soc/fsl/fsl_easrc.h
index c9f770862662..a24e540876a4 100644
--- a/sound/soc/fsl/fsl_easrc.h
+++ b/sound/soc/fsl/fsl_easrc.h
@@ -9,7 +9,7 @@
 #include <sound/asound.h>
 #include <linux/dma/imx-dma.h>
 
-#include "fsl_asrc_common.h"
+#include <sound/fsl_asrc_common.h>
 
 /* EASRC Register Map */
 
-- 
2.34.1


