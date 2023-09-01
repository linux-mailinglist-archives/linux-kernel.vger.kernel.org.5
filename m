Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E478FC01
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349068AbjIAK77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345772AbjIAK76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:59:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A210D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:59:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5007abb15e9so3316000e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693565993; x=1694170793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPHcmAD9CRQ9UoDmbcvoNZ8a9fCLHJeehssHlOotx8k=;
        b=qnMlB05NZyGZQy1cGX/OcC2Zi96eDYh5ul4Pg5m11XFCVtA0u505T2Sr6TMvX5BQ/c
         DDfImVxRY3N3XS+GgoVSrawsHPEZVRQqkSc+HNCsKBGHugUX9jaQ+rXpRB4caHAH24UU
         XD/wybulMP88dckPIrnz3e3EJgZPZuqHQyAFDnJP8zC0f6YvvCA68E7hjQGWw3JzIj1s
         gVOZpLZGJyN6r//zLSova6RlYtAR3gh4Pe+wwxAOSwdDspmUaaRys0miMYQl1bV2J2PD
         Tj5M7sbh/sqX0hhFShBAK9XBtjqG0BAGgzUTwzLhrtYq3fAO+o894Da+M+Hg/BeLqSsz
         ZIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693565993; x=1694170793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPHcmAD9CRQ9UoDmbcvoNZ8a9fCLHJeehssHlOotx8k=;
        b=AW6BQQ3eChVEA6TryP/NZaJ2tvAHmJJUYHEa+3MyN0NXHBW1bjvRwMXobzPJBPtDkq
         kC9Bmtd6QUGsoIk1E3WKhr57s1R/g2LpKnreMZUAqSW4Yob48hCb+grEyQtcPBEm6qzE
         PRKimnXKI7l80kCq8KobZxCQ1d1bF6/SdtZ7sRg1LH8JjO5fytFRJdklETO0Rlou99WG
         1zGwTgcF3rls1yLXkJbpr3lIxChJjBLm1L+VQYVOSBTGxr7JEHgHz7fKD97u/Jvm8xyD
         Zo3C/z2wlFsfiY98HaxD18Wp4/BIwfJm4nWZRtBWKCKjzj6eWSdxw9U3uQEcvqaLnT76
         cPDQ==
X-Gm-Message-State: AOJu0YwFaBVnGYCU4hWj7xbD5xKb2TAQJ33tHuq0QT3a1Y1WGFGfytOE
        gMaA84NTdbkdREmNqXLmgEM=
X-Google-Smtp-Source: AGHT+IFcg/nVsdjSQfPUUokzU+sRfNuxh2D+RuR5R16y1wHUCa60XciguEdDyvboW1fdR/xI87GXMQ==
X-Received: by 2002:a05:6512:2114:b0:500:78ee:4cd7 with SMTP id q20-20020a056512211400b0050078ee4cd7mr1165114lfr.23.1693565992910;
        Fri, 01 Sep 2023 03:59:52 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:64d6:8737:b80d:a298])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c248b00b003fc01495383sm7657973wms.6.2023.09.01.03.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 03:59:52 -0700 (PDT)
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
Subject: [PATCH] riscv: Kconfig.errata: Drop dependency for MMU in ERRATA_ANDES_CMO config
Date:   Fri,  1 Sep 2023 11:58:58 +0100
Message-Id: <20230901105858.311745-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Now that RISCV_DMA_NONCOHERENT conditionally selects DMA_DIRECT_REMAP
ie only if MMU is enabled, we no longer need the MMU dependency in
ERRATA_ANDES_CMO config.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, this patch needs to be applied only if patch [1] is accepted or else
we might see build issues with randconfig.

[1] https://lore.kernel.org/linux-riscv/20230901105111.311200-1-prabhakar.mahadev-lad.rj@bp.renesas.com/T/#u
---
 arch/riscv/Kconfig.errata | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 92c779764b27..bee5d838763b 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -12,7 +12,7 @@ config ERRATA_ANDES
 
 config ERRATA_ANDES_CMO
 	bool "Apply Andes cache management errata"
-	depends on ERRATA_ANDES && MMU && ARCH_R9A07G043
+	depends on ERRATA_ANDES && ARCH_R9A07G043
 	select RISCV_DMA_NONCOHERENT
 	default y
 	help
-- 
2.34.1

