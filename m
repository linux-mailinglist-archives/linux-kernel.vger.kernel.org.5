Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3A78FD2E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349419AbjIAM1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242802AbjIAM1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:27:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3FECF3;
        Fri,  1 Sep 2023 05:27:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31f2f43d5a0so88806f8f.1;
        Fri, 01 Sep 2023 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693571256; x=1694176056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6Gi10IhnUKAHhj8YSjYz36uUnCbI9VLNqIYsOM0UXo=;
        b=luWqthoahCErBFErph5qHvBZbPwNy5QNpluUVHp1pH2RP8Ylm5Ag8WXkts8TBBRf9N
         4T/yktUTOCVmVwBViMIqeez2UyFXlPDX6fSyYMVHEcMrncwXvWXP8ejnSNmu5ZrNe78y
         36IxqDGYJMi+QODLOwc4CrcdMJ3ngmHG+AIPxISRoEGeq+UTKDUZzekWIUtppMP6XADt
         xodV0pwb58NdC2ZaJbTHAgr19Ioolt8oM+6aT5qAoQVeEoQqcJ4r1pjP8dNXsp2bGmwO
         WtHKVuV9vGwC1zUSQa+Dyf23j90No83ELNaNCFJnkN/iltn92GNXzXx2y7KDdWNHYjiK
         HAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571256; x=1694176056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6Gi10IhnUKAHhj8YSjYz36uUnCbI9VLNqIYsOM0UXo=;
        b=frc9PmuKSW3qlOkPFphkDjHu/ETPfzbZP/NWY14ZHadpSs0bINB19/5y72HcYemE+E
         7sgpAXjlL7Lkc5QcbnGLQe1hRtKWs523ZZodtViLdhcGphkEl/ox1kdmIxrmXOLJIQib
         m9QMNfplpHdyXJ4RuYTjJ+pNkRy1AEJ+l0QcumwRUl0D9zEFMYiMbnZSyT1aUZkaO350
         sOUylrOLdH0O9AasYGftBmAXmIKRfOIQeFDTqTiR9AU691sWvjUbeDjqhr1hx2tlcrY/
         hpLndAgurD8B+n50vRHlmj2Wuk2E50/uz5cecB0p1LeF1+V1lx3pn+Uwe/yeeJ+oaa9y
         NdpA==
X-Gm-Message-State: AOJu0YwTd7QbJ7To1l/DSGI3MY2E4FpUnd8MjOAglvOeqSgzSgXZl/Uo
        YzpDjm9Kvqb4RFjAdB8Hr0aNFbgb90C++Q==
X-Google-Smtp-Source: AGHT+IEqgWw+U/mlROcBLLUoZsyNQ4XPlHlezyJwxdiU4mOsv4oFBuMQPY6CveJBROa53on31tNPCQ==
X-Received: by 2002:adf:fe92:0:b0:319:89ce:da0b with SMTP id l18-20020adffe92000000b0031989ceda0bmr1692269wrr.68.1693571255815;
        Fri, 01 Sep 2023 05:27:35 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:64d6:8737:b80d:a298])
        by smtp.gmail.com with ESMTPSA id x9-20020adfdd89000000b003196b1bb528sm5131530wrl.64.2023.09.01.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 05:27:35 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option dependant on ARCH_RENESAS
Date:   Fri,  1 Sep 2023 13:27:01 +0100
Message-Id: <20230901122701.318082-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

MMC_SDHI_INTERNAL_DMAC config option has dependency on ARM64 and
R7S9210/R8A77470 this dependency will keep growing for future SoCs for
varying architectures. So to simplify this configuration make
MMC_SDHI_INTERNAL_DMAC solely depend on ARCH_RENESAS, as all Renesas
SoCs inherently depend on the ARCH_RENESAS config option.

This allows selecting MMC_SDHI_INTERNAL_DMAC config option for RZ/Five SoC
which is based on RISC-V architecture.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1-v2
* Add dependency on ARCH_RENESAS instead of RISCV

v1:
https://lore.kernel.org/linux-renesas-soc/20230901113703.314667-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 554e67103c1a..2e8476db2381 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -677,9 +677,9 @@ config MMC_SDHI_SYS_DMAC
 
 config MMC_SDHI_INTERNAL_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
-	depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on MMC_SDHI
-	default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470)
+	default MMC_SDHI if ARCH_RENESAS
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
 	  using on-chip bus mastering. This supports the controllers
-- 
2.34.1

