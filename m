Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1DF7B09F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjI0QZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjI0QZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:25:18 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE227DE;
        Wed, 27 Sep 2023 09:25:15 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,181,1694703600"; 
   d="scan'208";a="177447615"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Sep 2023 01:25:15 +0900
Received: from mulinux.home (unknown [10.226.92.108])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 05AB3401F564;
        Thu, 28 Sep 2023 01:25:10 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] Add RZ/V2M CSI slave support
Date:   Wed, 27 Sep 2023 17:25:06 +0100
Message-Id: <20230927162508.328736-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

the CSI IP found inside the Renesas RZ/V2M SoC supports
both SPI host and target.
This series extends the CSI dt-bindings and driver to
add SPI target support.

v1->v2: I have dropped properties renesas,csi-ss and
        renesas,csi-ss-high. I have added property
	renesas,csi-no-ss, and to configure SS as active
	high one now needs to use property spi-cs-high.
	I have also purged "master" and "slave" as naming
	schemes (besides for the title of the cover letter,
	to make it easier to follow this discussion), I
	am now using "host" and "target" and related APIs
	instead.

Cheers,
Fab

Fabrizio Castro (2):
  spi: renesas,rzv2m-csi: Add CSI (SPI) target related properties
  spi: rzv2m-csi: Add target mode support

 .../bindings/spi/renesas,rzv2m-csi.yaml       |   9 ++
 drivers/spi/Kconfig                           |   3 +-
 drivers/spi/spi-rzv2m-csi.c                   | 127 ++++++++++++------
 3 files changed, 94 insertions(+), 45 deletions(-)

-- 
2.34.1

