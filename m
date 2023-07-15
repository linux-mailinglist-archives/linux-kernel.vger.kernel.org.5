Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC227545EA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGOBET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjGOBER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:04:17 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EB353A9C;
        Fri, 14 Jul 2023 18:04:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,206,1684767600"; 
   d="scan'208";a="169014684"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jul 2023 10:04:14 +0900
Received: from mulinux.home (unknown [10.226.92.194])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id DE3E240A10D5;
        Sat, 15 Jul 2023 10:04:11 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 00/10] spi: rzv2m-csi: Code refactoring
Date:   Sat, 15 Jul 2023 02:03:57 +0100
Message-Id: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

this series is to follow up on Geert and Andy feedback:
https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230622113341.657842-4-fabrizio.castro.jz@renesas.com/

Thanks,
Fab

Fabrizio Castro (10):
  spi: rzv2m-csi: Add missing include
  spi: rzv2m-csi: Adopt HZ_PER_MHZ for max spi clock
  spi: rzv2m-csi: Rework CSI_CKS_MAX definition
  spi: rzv2m-csi: Leave readl_poll_timeout calls for last
  spi: rzv2m-csi: Replace unnecessary ternary operators
  spi: rzv2m-csi: Squash timing settings into one statement
  spi: rzv2m-csi: Switch to using {read,write}s{b,w}
  spi: rzv2m-csi: Improve data types and alignment
  spi: rzv2m-csi: Get rid of the x_trg{_words} tables
  spi: rzv2m-csi: Make use of device_set_node

 drivers/spi/spi-rzv2m-csi.c | 139 +++++++++++++++---------------------
 1 file changed, 58 insertions(+), 81 deletions(-)

-- 
2.34.1

