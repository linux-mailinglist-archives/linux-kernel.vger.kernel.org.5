Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB09760F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjGYJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjGYJd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:33:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A63448B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:31:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d0737b86c45so3632213276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690277458; x=1690882258;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ssxV/xV/7rnZbTq7Uh/n4BH2xb3hUa3L7svw7aUAE68=;
        b=Nui/P/18Pn72181tSUck1Zckhcn6y1rL1e721tOGD4jyE4IUU88DlcP/PXcsKxpK82
         CPrassXSguLpCo30pHo7wyZJkLbh6gJeKXeQlxIgs6Vk7vSMn9uTGbbtMEueqLL/kcIs
         zrdvfOVsfM0NXogtPlOslK+pNwwD+1/Ru/Go4UIn3fGQ8MTuGPx6IOFqdtMYWO4zwAaC
         GwoKX8iTxhwcUh21534mZDYPXTO/8JAoqDiWvXxfJHoAdHXJymi+ojRDTspuyynPiYNA
         2i4IC3WRhrz7R0CdGkofOufI9SIdvz0ml1hOCZx2aLwVv9yvOwNV0sHCZj/0dYm+O58P
         T0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690277458; x=1690882258;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssxV/xV/7rnZbTq7Uh/n4BH2xb3hUa3L7svw7aUAE68=;
        b=KINSvhueb5gVXgLSkxsafdfaE0JxqMwhc4mOhQ3dHjmeA2FRVD3DVyqSIqPdW81Og8
         kcji8ri1woY9AwWUZfHDaPJ2fBL87Stpb3TTjVCAxfgHBDip61A1/6BYZUvIqnMEuMHV
         KuNuHEm2yAmwqZq2ERxxDID+jzYGePRDPqbgiSZLX9j55d6amHefpQG4nNfLBCOEXxzV
         eH4FiXZFn/tfoF+3fA1vbJyirhZYG3UeVBGeecG63SrXtJx9hpO4RaUJPbpZcI8cmibq
         zZHP+061ImtVp7Rv4QP7THYfB3//AT6c8yBCPRCjdRK1WKyxizSNuXc8P7JLAbNfe2FV
         6o9w==
X-Gm-Message-State: ABy/qLaQca3ZSK5nFsGL+GFrkuZZuyZKw+0e3HSISgsQV0+vLhHE51bs
        CwToKGlhVu/aCEKEdNdrNoW5WV62KxHI
X-Google-Smtp-Source: APBJJlEtY7DCVNwWX8xJRKtlcbg4j6dgOj1Z0msKRQYwYC9hL8aVOpTkKFu9tvbdvQn3ETGRrVHG+i1LRuTURg==
X-Received: from lerobert.c.googlers.com ([fda3:e722:ac3:cc00:12:b22d:c0a8:2e6])
 (user=lerobert job=sendgmr) by 2002:a05:6902:1610:b0:d0c:77a8:1f6b with SMTP
 id bw16-20020a056902161000b00d0c77a81f6bmr48365ybb.10.1690277458611; Tue, 25
 Jul 2023 02:30:58 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:30:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725093005.3499455-1-lerobert@google.com>
Subject: [PATCH] ALSA: compress: add opus codec define
From:   Robert Lee <lerobert@google.com>
To:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Robert Lee <lerobert@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add to support decode Opus codec in Ogg container.

Signed-off-by: Robert Lee <lerobert@google.com>
---
 include/uapi/sound/compress_params.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index ddc77322d571..bac5797bcb02 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -43,7 +43,8 @@
 #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
 #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
 #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
-#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
+#define SND_AUDIOCODEC_OPUS                  ((__u32) 0x00000011)
+#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_OPUS
 
 /*
  * Profile and modes are listed with bit masks. This allows for a
-- 
2.41.0.487.g6d72f3e995-goog

