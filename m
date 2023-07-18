Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72FF757C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGRMwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjGRMwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:52:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1621D1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:52:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-315adee6ac8so5471172f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689684722; x=1692276722;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAzJmMJnLsLu0Ky/1Y8+HgMSARceM1UpH2sEela1PIE=;
        b=P7lzdJCvGQdDZRkmvnW6//CRILGhOhslxd2FvGv+UDI+T1Y13OoHpDtcBBhYZsrV+E
         s5uWrAZUMaDNQ7moCt78f4VWhltJh7uSDemEbSm1+GQW542Re7Pur6Ubknij/t95mbvV
         Jt+kSKY7A1gJm8sBM7UP6i0dezkhqQzM2ZZGq5Pug/GCK1j1kJy23AXR6KJ4kaiosWYs
         0jfxto3ZWQceglw0YdllZHI3teC5tajAdgXciYGAHCI8JdZuxtW16uiDw3OhUrvaxn6K
         1n5dPdPsab+rRKiRu5hB8Wq3tQjnK6AkTMwcN9MMkHW2v+LimUYG8IkcNeMjWLlqEYA2
         Q50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684722; x=1692276722;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAzJmMJnLsLu0Ky/1Y8+HgMSARceM1UpH2sEela1PIE=;
        b=NCYnvJoaU2sfKMNZ6Cy0CrmMFyivT1SWVthU30N1UbsWbUa+94rO/GWfEodbjG5XLz
         X9qF9xlkzKTgOp3dJiTBWxPYlDmjIjsbd7ysRjRL5NklUWoIJj49qwyUFFtHWxs0JFyC
         7iLXY9J3TkSe0jl4hBrpucB8LIixnSvx5zJ6XM3yv8ytRsUDZpXfeCEVvrapuswhRxyN
         +aCnvaRY72m86ZXuXCOScFgCbvB71oXduqlhpPRtO/x/jT43QOfI7urA1hBUgACoHaJF
         8eMF5tGCHsgWnWvXpBTBEotWZJfqZ5x7Y9zOpnaq9DY6e1tdSPzcvC4yvGhQfkWFecbZ
         hoSg==
X-Gm-Message-State: ABy/qLbdWwIH2gf/dRipsMs0AMMHKI7rhKucXCGG41us/T39/KxxrXgN
        FDCr6kJ2HflJ/+iZgOaDjzHE8d5Yc9tk8b8XqMxc/g+A
X-Google-Smtp-Source: APBJJlGs+NiR0pGfLqHWAfd5rBGO3eGAfhaD8rYxuzr4P8nQOPbtcj+pr/Yi3iHBvy7jgsr3lflJsA==
X-Received: by 2002:adf:e38c:0:b0:313:e456:e64a with SMTP id e12-20020adfe38c000000b00313e456e64amr13156235wrm.21.1689684722505;
        Tue, 18 Jul 2023 05:52:02 -0700 (PDT)
Received: from [127.0.1.1] ([86.71.62.179])
        by smtp.gmail.com with ESMTPSA id k15-20020a056000004f00b003143ba62cf4sm2309656wrx.86.2023.07.18.05.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 05:52:02 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
Date:   Tue, 18 Jul 2023 14:51:42 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable OMAP watchdog support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-enable-omap-wd-v1-1-34396f2c76aa@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAN2KtmQC/x2NywqDQAwAf0VybmBd8UF/pfSQXVMN6CqJaEH89
 649DsMwJxirsMGzOEF5F5MlZSgfBcSR0sAofWbwzleuLTvkRGFiXGZa8eixobqpou9cW3vIUSB
 jDEopjnc2k22st1iVP/L9n17v6/oBgWBoqnkAAAA=
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689684721; l=882;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=7EAr2st4JxHXmrZz8eO09oej24buZlVenfoWQa3B2c4=;
 b=ASkctEOOQlsN7ecEGV7PWy9u/Aseqda5OV1k98h7TedyhEga8bKbBx9sxz7nNx8waP2LVX9dF
 Rhp3FfUuU5wB/GoUEskAiDPOBBqJLWJX1b5JKlqEkm7BQJ3P2uIEHV0
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OMAP watchdog support by enabling
CONFIG_OMAP_WATCHDOG as module.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Enable OMAP watchdog support in multi_v7_defconfig.
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f0800f806b5f..7d93e21e0cb9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -554,6 +554,7 @@ CONFIG_SAMA5D4_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=m
 CONFIG_DW_WATCHDOG=y
 CONFIG_DAVINCI_WATCHDOG=m
+CONFIG_OMAP_WATCHDOG=m
 CONFIG_ORION_WATCHDOG=y
 CONFIG_RN5T618_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230718-enable-omap-wd-6a563c280752

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>

