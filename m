Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96C278FBED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbjIAKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjIAKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:52:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C6E10CC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:52:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso32305731fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693565521; x=1694170321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Xmp9WqBbQgAo1cevlJdH0YFWuDdqUeSzKBH4Ev5l8s=;
        b=L5ynpmZDh6C13olvawaeYSu2qC8FlV5QwPw4S61lz/NyC0n4usnGqI+8D2N3Qcn36/
         QXN2KEBYW4ieh5RrU0/OJHCFC2SZJVGcq4AALd/4aYkOft0YOb9ukeD+qgfnTU/aG5sP
         fgtJZPS3WQ16TwqsCZ8Ft+FVS0CxQgyRKYoqhTNszRQHnRhHVeiRmtH/bvb1mWfzs2DE
         T66DNebWNyyrRCDuk+fuFL8EiTdb0hv0MlRMLr+BK5qVmUpCZrIXZGG46G0tOMOmLkZu
         oGeHNCqfbtEDd/JTh6vz5/7rMzef2zYsPlhahZiaoVAH8im4kMc6OelBYvuHkBVa7TXZ
         W3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693565521; x=1694170321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Xmp9WqBbQgAo1cevlJdH0YFWuDdqUeSzKBH4Ev5l8s=;
        b=huZkSg4nfwnXM12MHH08aIqB+TVk0HT4b+dOkJE1J2YHYhRrYFGwjfcPEWj7OheKRF
         oeLWeJFPKDXfyqGsnNBkRVLO6Ai/fGyLgqbm2VVXcoPN6SrcJ5LfR4X3/d8aicIYdM0+
         mwTXOuh9pO655tL0UkQbVh7dihYG6G0a6+nVcEPTfPiD4BRyYVPSDoTqT3qbyKUqCNgL
         TcMGLZQ5vHPNT6cOw9sw/uv69qyldsMqH4YzmFEu4/I+ene441XQOeIOMg5quDzGAzm0
         lPnOZDyS0gDVjtCu1RaZ5Pj+fdAG6RMQO3dAhq3eocGVBFdgUYnGjtkk1KzaE/OcFzp0
         kE8g==
X-Gm-Message-State: AOJu0Yxg2/pCjLldtyLQSPN8m3mJYO/YX23uN8gu44bZtpXbr0eRagEu
        iqd+/DOAXPK51WexMToUUBo=
X-Google-Smtp-Source: AGHT+IGGkITGqugrHo6c9lWxjv069VV2n6HMgoHi23eIRSVL/TtfI5z/CRm5kFpMVR3m/saeOUWXIQ==
X-Received: by 2002:a2e:7403:0:b0:2b6:cdfb:d06a with SMTP id p3-20020a2e7403000000b002b6cdfbd06amr1275906ljc.22.1693565520727;
        Fri, 01 Sep 2023 03:52:00 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:64d6:8737:b80d:a298])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c025000b003fee7b67f67sm4497495wmj.31.2023.09.01.03.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 03:52:00 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] riscv: Kconfig: Select DMA_DIRECT_REMAP only if MMU is enabled
Date:   Fri,  1 Sep 2023 11:51:11 +0100
Message-Id: <20230901105111.311200-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

kernel/dma/mapping.c has its use of pgprot_dmacoherent() inside
an #ifdef CONFIG_MMU block. kernel/dma/pool.c has its use of
pgprot_dmacoherent() inside an #ifdef CONFIG_DMA_DIRECT_REMAP block.
So select DMA_DIRECT_REMAP only if MMU is enabled for RISCV_DMA_NONCOHERENT
config.

This avoids users to explicitly select MMU.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 468063780a93..a065abdc80e3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -273,7 +273,7 @@ config RISCV_DMA_NONCOHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select DMA_BOUNCE_UNALIGNED_KMALLOC if SWIOTLB
-	select DMA_DIRECT_REMAP
+	select DMA_DIRECT_REMAP if MMU
 
 config RISCV_NONSTANDARD_CACHE_OPS
 	bool
-- 
2.34.1

