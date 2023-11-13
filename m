Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFCC7E9F03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjKMOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKMOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:44:43 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780461715
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:44:39 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEi1FW019388;
        Mon, 13 Nov 2023 08:44:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699886641;
        bh=TnqZLw/rt+gOohH8xdj1e0okN1hLN50UCmORokHboM0=;
        h=From:To:CC:Subject:Date;
        b=YDjuaIqBLeeR/wbif+Qx78y+gm+y29GWJiFfnH8biEZCpMnqXuwpoABlqIHhaP40P
         NcdJN9NMlUv/eMs9i/XT/mdnFYpoLHvrFjgSa5Bwely8DyKBro2GD2PC1rH+psQtOW
         lV0CoFR6W5DsWK8WP7bOPIKlwHU9TdShpskHVD3U=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADEi1D6093979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Nov 2023 08:44:01 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:44:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:44:01 -0600
Received: from fllv0040.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEi0ts065232;
        Mon, 13 Nov 2023 08:44:00 -0600
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v3 0/9] Remove some unneeded arm/mach- dirs
Date:   Mon, 13 Nov 2023 08:43:50 -0600
Message-ID: <20231113144359.174140-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This series removes some of the unneeded arm/mach-* dirs for
reasons described in the patches. Adding this cover letter
to keep track of version changes in one place.

Thanks,
Andrew

Changes from v2:
 - Add patch for mach-nspire as it is now ready for this move
 - Rebased on v6.7-rc1

Changes from v1:
 - Drop two patches that cannot be verified to not change behavior
 - Update commit message to include l2c_aux_mask info

Andrew Davis (9):
  ARM: Kconfig: move platform selection into its own Kconfig file
  ARM: mach-asm9260: Move ASM9260 support into Kconfig.platforms
  ARM: mach-rda: Move RDA Micro support into Kconfig.platforms
  ARM: mach-uniphier: Move Socionext UniPhier support into
    Kconfig.platforms
  ARM: mach-moxart: Move MOXA ART support into Kconfig.platforms
  ARM: mach-airoha: Rework support and directory structure
  ARM: mach-sunplus: Rework support and directory structure
  ARM: mach-hpe: Rework support and directory structure
  ARM: mach-nspire: Rework support and directory structure

 MAINTAINERS                    |   3 -
 arch/arm/Kconfig               |  92 +--------------
 arch/arm/Kconfig.platforms     | 208 +++++++++++++++++++++++++++++++++
 arch/arm/Makefile              |   5 -
 arch/arm/mach-airoha/Makefile  |   2 -
 arch/arm/mach-airoha/airoha.c  |  16 ---
 arch/arm/mach-asm9260/Kconfig  |   9 --
 arch/arm/mach-hpe/Kconfig      |  23 ----
 arch/arm/mach-hpe/Makefile     |   1 -
 arch/arm/mach-hpe/gxp.c        |  15 ---
 arch/arm/mach-moxart/Kconfig   |  28 -----
 arch/arm/mach-moxart/Makefile  |   4 -
 arch/arm/mach-moxart/moxart.c  |   6 -
 arch/arm/mach-nspire/Kconfig   |  15 ---
 arch/arm/mach-nspire/Makefile  |   2 -
 arch/arm/mach-nspire/nspire.c  |  18 ---
 arch/arm/mach-rda/Kconfig      |   8 --
 arch/arm/mach-sunplus/Kconfig  |  27 -----
 arch/arm/mach-sunplus/Makefile |   8 --
 arch/arm/mach-sunplus/sp7021.c |  16 ---
 arch/arm/mach-uniphier/Kconfig |  15 ---
 21 files changed, 209 insertions(+), 312 deletions(-)
 create mode 100644 arch/arm/Kconfig.platforms
 delete mode 100644 arch/arm/mach-airoha/Makefile
 delete mode 100644 arch/arm/mach-airoha/airoha.c
 delete mode 100644 arch/arm/mach-asm9260/Kconfig
 delete mode 100644 arch/arm/mach-hpe/Kconfig
 delete mode 100644 arch/arm/mach-hpe/Makefile
 delete mode 100644 arch/arm/mach-hpe/gxp.c
 delete mode 100644 arch/arm/mach-moxart/Kconfig
 delete mode 100644 arch/arm/mach-moxart/Makefile
 delete mode 100644 arch/arm/mach-moxart/moxart.c
 delete mode 100644 arch/arm/mach-nspire/Kconfig
 delete mode 100644 arch/arm/mach-nspire/Makefile
 delete mode 100644 arch/arm/mach-nspire/nspire.c
 delete mode 100644 arch/arm/mach-rda/Kconfig
 delete mode 100644 arch/arm/mach-sunplus/Kconfig
 delete mode 100644 arch/arm/mach-sunplus/Makefile
 delete mode 100644 arch/arm/mach-sunplus/sp7021.c
 delete mode 100644 arch/arm/mach-uniphier/Kconfig

-- 
2.39.2

