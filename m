Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01907B177D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjI1Jht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjI1Jho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:37:44 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D000A12A;
        Thu, 28 Sep 2023 02:37:41 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E7371A15C9;
        Thu, 28 Sep 2023 11:37:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 472CB1A059B;
        Thu, 28 Sep 2023 11:37:40 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 681281820F58;
        Thu, 28 Sep 2023 17:37:38 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v5 03/11] ASoC: fsl_asrc: move fsl_asrc_common.h to include/sound
Date:   Thu, 28 Sep 2023 17:00:11 +0800
Message-Id: <1695891619-32393-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695891619-32393-1-git-send-email-shengjiu.wang@nxp.com>
References: <1695891619-32393-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move fsl_asrc_common.h to include/sound that it can be
included from other drivers.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
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
index 05a7d1588d20..b034fee3f1f4 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -12,7 +12,7 @@
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 
-#include "fsl_asrc_common.h"
+#include <sound/fsl_asrc_common.h>
 
 #define FSL_ASRC_DMABUF_SIZE	(256 * 1024)
 
diff --git a/sound/soc/fsl/fsl_easrc.h b/sound/soc/fsl/fsl_easrc.h
index bee887c8b4f2..f571647c508f 100644
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

