Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060B178FC5A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbjIALhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjIALho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:37:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D840E70;
        Fri,  1 Sep 2023 04:37:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso19285805e9.0;
        Fri, 01 Sep 2023 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693568259; x=1694173059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/gv9E+V/pkXlxJLESJTglwoTQDj1Z8lIRhsobuy1wv4=;
        b=NM1KTdK6VGZjd9zEP89b5iZc5TyC5b4Q0S7bbRbLKhURt0haqyM3SrjgdcOEu4WKbx
         XfaDiwzSnGa+yFVs6kD8r/bYVfJVVleV0iVXG9sZtOKZ0zeJs4O+bntWIbrvf8nwioyC
         ya35MOGIXps9i6LqItkWT/hO+TKEqF1KAou/34dzKkU7CIY7xCR8xe0drtqYECOcWPJ4
         PBlVBxzIDdtEfLowykSwsXXKX1QFTxPEZUtbBXRNCHIUW4GhVc/Ll8wzadFWufHoSDZe
         fZoSGPcABd35NiyaumcG9i1Sap8oGq6mAA0q4E9gBUn8oFHb9gaNJclWfChSOqG/TZrY
         3E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693568259; x=1694173059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gv9E+V/pkXlxJLESJTglwoTQDj1Z8lIRhsobuy1wv4=;
        b=XCcP8THDMc34exikGPumcEHj1nhzA3RBu8IcOoLY/39iQ6ueD7f1jv++X4frzyt2PY
         7vaOBtlXXSLvO5Ha3AGuNwxX7eckMM9nKiJH/ICFXN/ZSldSNu3R+zb6W+ya0eo6XFSq
         qjQlw1uXDkq6+/Doxy5I4c5W75YdYvmccxF5mEa/IoMjmDzduLoAwKpssiN8SRddeSKA
         5MwBG1RDQpVSBxPz0ADg+JoKb9kQoLJrIwDo1IwedGEVvQ+5i/lJapmje7lcUiU3xvm8
         amgmO46FnnJ0p6zDpRRjodEsROxk1eZUCUEmlsW5m8jQK1KLMK2VE9ACsRAQR7JOdPJy
         vaiw==
X-Gm-Message-State: AOJu0YwoBSV19XMowySZhFuzURaJmtG2HEHQKo4RTTvYxvIuEU6aEFs3
        24R6+JoYJdznntC436u3NqbnS0280M6dDw==
X-Google-Smtp-Source: AGHT+IFPvhfxa1RwEKpcQRgvzEpDUHB8SfaD/+P6uuIMlXH/kAbMnX5YYpLW21TqCltE4hHDtx8SBw==
X-Received: by 2002:a5d:6b91:0:b0:31d:c36a:bdf9 with SMTP id n17-20020a5d6b91000000b0031dc36abdf9mr1547035wrx.67.1693568259243;
        Fri, 01 Sep 2023 04:37:39 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:64d6:8737:b80d:a298])
        by smtp.gmail.com with ESMTPSA id s12-20020adfdb0c000000b00317a04131c5sm4972240wri.57.2023.09.01.04.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:37:38 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] mmc: host: Kconfig: Allow selecting MMC_SDHI_INTERNAL_DMAC for RZ/Five SoC
Date:   Fri,  1 Sep 2023 12:37:03 +0100
Message-Id: <20230901113703.314667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Make MMC_SDHI_INTERNAL_DMAC visible for RISC-V architecture so that we can
select this config option for RZ/Five SoC which is based on RISC-V
architecture.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi Geert/Ulf,

I was in two minds here whether I should instead add dependency for
ARCH_R9A07G043 instead of RISCV. But adding dependency for RISCV allows
us to get this config option freely for future coming RISC-V Renesas
SoCs.

Cheers, Prabhakar
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 554e67103c1a..5190881cb204 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -677,9 +677,9 @@ config MMC_SDHI_SYS_DMAC
 
 config MMC_SDHI_INTERNAL_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
-	depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || COMPILE_TEST
+	depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || RISCV || COMPILE_TEST
 	depends on MMC_SDHI
-	default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470)
+	default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || RISCV)
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
 	  using on-chip bus mastering. This supports the controllers
-- 
2.34.1

