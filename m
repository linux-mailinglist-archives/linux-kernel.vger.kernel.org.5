Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC1E76FB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjHDHYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHDHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:24:08 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBAB3AAF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:24:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 894E240007;
        Fri,  4 Aug 2023 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691133845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j342T9+w8AIX1vd6sGWYzMcKTCMg2Pp7WhT/NRZD0HI=;
        b=VQ/plgzca1J+scu3DbttC2hJ520sKbtmufEHGJYPtSxyfbwfkrt1qMEGjZf7O3PkGjfQrn
        A6E5TXCo1M9SzmBDOajA/pbFIHHGUc5BxAYlYay+ijyGSdFbHJLTH2KhdadwVSnwz5sbAp
        WN5HI5zd2dV6Gk2ID6sE0qIr3OAuM10hy8NIi6IQ9HzFL+6FZQesj9XKSbmqsvTa5qdeXb
        LNPnm7FN67qo7krxEFmeEYZGshmyryI8q1KjlmTK3EYv1llvp1zgduxx9lE5JVCt86I7JG
        xmAyTQwDBJpqqpfvopsowL6550UrI0UO1oXl9D/mITH5fA19VpC+UjvktkM4wQ==
Date:   Fri, 4 Aug 2023 09:24:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v6.5-rc5
Message-ID: <20230804092401.18b19001@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is a fixes MTD PR for the next -rc.

Thanks,
Miqu=C3=A8l

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.5-rc5

for you to fetch changes up to c6abce60338aa2080973cd95be0aedad528bb41f:

  mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op() (2023-07-2=
7 16:54:23 +0200)

----------------------------------------------------------------
Raw NAND fixes:
* fsl_upm: Fix an off-by one test in fun_exec_op()
* Rockchip:
  - Align hwecc vs. raw page helper layouts
  - Fix oobfree offset and description
* Meson: Fix OOB available bytes for ECC
* Omap ELM: Fix incorrect type in assignment

SPI-NOR fixes:
* Avoid holes in struct spi_mem_op

Hyperbus fixes:
* Add Tudor as reviewer in MAINTAINERS

SPI-NAND fixes:
* Winbond and Toshiba: Fix ecc_get_status

----------------------------------------------------------------
Arnd Bergmann (1):
      mtd: spi-nor: avoid holes in struct spi_mem_op

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix OOB available bytes for ECC

Christophe JAILLET (1):
      mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()

Johan Jonker (2):
      mtd: rawnand: rockchip: fix oobfree offset and description
      mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts

Olivier Maignial (2):
      mtd: spinand: toshiba: Fix ecc_get_status
      mtd: spinand: winbond: Fix ecc_get_status

Roger Quadros (1):
      mtd: rawnand: omap_elm: Fix incorrect type in assignment

Tudor Ambarus (1):
      MAINTAINERS: Add myself as reviewer for HYPERBUS

 MAINTAINERS                                     |  1 +
 drivers/mtd/nand/raw/fsl_upm.c                  |  2 +-
 drivers/mtd/nand/raw/meson_nand.c               |  3 +--
 drivers/mtd/nand/raw/omap_elm.c                 | 24 ++++++++++++---------=
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 45 +++++++++++++++++++++=
++++--------------------
 drivers/mtd/nand/spi/toshiba.c                  |  4 ++--
 drivers/mtd/nand/spi/winbond.c                  |  4 ++--
 drivers/mtd/spi-nor/spansion.c                  |  4 ++--
 include/linux/spi/spi-mem.h                     |  4 ++++
 9 files changed, 50 insertions(+), 41 deletions(-)
