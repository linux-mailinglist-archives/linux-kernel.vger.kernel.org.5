Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73DD76D215
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjHBPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjHBPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:33:57 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0111BF9;
        Wed,  2 Aug 2023 08:33:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372FXa4W105647;
        Wed, 2 Aug 2023 10:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690990416;
        bh=nLd3Vn8vlTe/h/zk8+jjq6q1zplV0I7CB3Lip2XFWrc=;
        h=From:To:CC:Subject:Date;
        b=iLws4c3sk7+TQefCVQBQxHzGvEz62WMtguqnGXWMzQyAxoRInGQpJe0hpUnj2vkXM
         eqtPpNsWCSY325hVpKz29y53oYex7uZhtkgNTp0YdBf0drC1SEInmbfqC10GqiplME
         ohl3N0WUrOMn/WIDGeOKX+OuKolpFZ8UmU6+F3Ns=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372FXa0Y120780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 10:33:36 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 10:33:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 10:33:35 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372FXYpw072743;
        Wed, 2 Aug 2023 10:33:35 -0500
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v8 0/9] TI-Nspire cleanups
Date:   Wed, 2 Aug 2023 10:33:24 -0500
Message-ID: <20230802153333.55546-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This series is an extended version of the series started here[0]
and here[1].

We break out what was the first patch into one for DTS change and
one for code changes as suggested by Krzysztof. Those are now patches
1 and 8 of this series (I kept the ACKs, hope that is okay).

While I was adding that, I noticed some other dtbs_check issues,
so while here fixed some of those up too (patches 2-6).

Thanks,
Andrew

[0] https://lore.kernel.org/lkml/20221026161302.5319-1-afd@ti.com/
[1] https://lore.kernel.org/linux-arm-kernel/20221027181337.8651-1-afd@ti.com/

Changes from v7:
 - Rebase on latest with new dts dirs

Changes from v6:
 - Old first patch was taken, remove from series
 - Add new patch 7/9, should be trivial enough

Changes from v5:
 - Rebase on latest master
 - Fix DT binding comments from Rob and add ACK

Changes from v4:
 - Rebase on latest master

Changes from v3:
 - Add Reviewed-by
 - Make new binding for patch #1

Changes from v2:
 - See cover letter message

Changes from v1:
 - Add ACKs
 - Rebase on latest

Andrew Davis (9):
  ARM: dts: nspire: Use syscon-reboot to handle restart
  ARM: dts: nspire: Fix cpu node to conform with DT binding
  ARM: dts: nspire: Fix sram node to conform with DT binding
  ARM: dts: nspire: Fix vbus_reg node to conform with DT binding
  ARM: dts: nspire: Fix uart node to conform with DT binding
  ARM: dts: nspire: Use MATRIX_KEY macro for linux,keymap
  ARM: dts: nspire: Remove file name from the files themselves
  ARM: nspire: Use syscon-reboot to handle restart
  ARM: nspire: Remove unused header file mmio.h

 arch/arm/boot/dts/nspire/nspire-classic.dtsi |  2 -
 arch/arm/boot/dts/nspire/nspire-clp.dts      | 93 ++++++++++++++-----
 arch/arm/boot/dts/nspire/nspire-cx.dts       | 95 ++++++++++++++------
 arch/arm/boot/dts/nspire/nspire-tp.dts       | 93 ++++++++++++++-----
 arch/arm/boot/dts/nspire/nspire.dtsi         | 26 ++++--
 arch/arm/mach-nspire/Kconfig                 |  2 +
 arch/arm/mach-nspire/mmio.h                  | 16 ----
 arch/arm/mach-nspire/nspire.c                | 24 -----
 8 files changed, 231 insertions(+), 120 deletions(-)
 delete mode 100644 arch/arm/mach-nspire/mmio.h

-- 
2.39.2

