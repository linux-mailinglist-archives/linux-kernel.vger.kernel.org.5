Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35A4758575
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGRTZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGRTZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:25:04 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E99771993;
        Tue, 18 Jul 2023 12:25:02 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="173456513"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jul 2023 04:25:02 +0900
Received: from mulinux.home (unknown [10.226.93.62])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2ED2740671B9;
        Wed, 19 Jul 2023 04:24:58 +0900 (JST)
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
Subject: [PATCH v2 0/4] spi: rzv2m-csi: Code refactoring
Date:   Tue, 18 Jul 2023 20:24:49 +0100
Message-Id: <20230718192453.543549-1-fabrizio.castro.jz@renesas.com>
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

I am sending this series to follow up on the comments received
from the first version of this series.
The first 5 patches of the first series have been taken by Mark
already (thanks Mark), this second version only addresses the
remaining patches.

I would like to highlight that I have dropped patch
"spi: rzv2m-csi: Switch to using {read,write}s{b,w}" for now,
and maybe I will send a follow up patch later on.

Thanks,
Fab

Fabrizio Castro (4):
  spi: rzv2m-csi: Squash timing settings into one statement
  spi: rzv2m-csi: Improve data types, casting and alignment
  spi: rzv2m-csi: Get rid of the x_trg{_words} tables
  spi: rzv2m-csi: Make use of device_set_node

 drivers/spi/spi-rzv2m-csi.c | 78 +++++++++++++++----------------------
 1 file changed, 32 insertions(+), 46 deletions(-)

-- 
2.34.1

