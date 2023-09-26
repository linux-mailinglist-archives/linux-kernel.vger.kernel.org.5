Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412627AF6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjIZXn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIZXlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:41:55 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6468972BD;
        Tue, 26 Sep 2023 15:57:08 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,178,1694703600"; 
   d="scan'208";a="181059336"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Sep 2023 06:08:26 +0900
Received: from mulinux.home (unknown [10.226.92.200])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 14CDC40B91B6;
        Wed, 27 Sep 2023 06:08:21 +0900 (JST)
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
Subject: [PATCH 0/2] Add RZ/V2M CSI slave support
Date:   Tue, 26 Sep 2023 22:08:16 +0100
Message-Id: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

the CSI IP found inside the Renesas RZ/V2M SoC supports
both SPI master and slave.
This series extends the CSI dt-bindings and driver to
add SPI slave support.

Cheers,
Fab

Fabrizio Castro (2):
  spi: renesas,rzv2m-csi: Add SPI Slave related properties
  spi: rzv2m-csi: Add Slave mode support

 .../bindings/spi/renesas,rzv2m-csi.yaml       |  15 ++
 drivers/spi/Kconfig                           |   4 +-
 drivers/spi/spi-rzv2m-csi.c                   | 137 ++++++++++++------
 3 files changed, 112 insertions(+), 44 deletions(-)

-- 
2.34.1

