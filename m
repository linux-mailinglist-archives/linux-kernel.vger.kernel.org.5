Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE987A49CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbjIRMe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbjIRMee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:34:34 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08F93CE5;
        Mon, 18 Sep 2023 05:34:02 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,156,1688396400"; 
   d="scan'208";a="180129093"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Sep 2023 21:34:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.107])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 36EDA4005E22;
        Mon, 18 Sep 2023 21:33:58 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/2] Fix for GPIO interrupts
Date:   Mon, 18 Sep 2023 13:33:53 +0100
Message-Id: <20230918123355.262115-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following issues observed while adding IRQ support for RTC.
 * The driver is not following reverse order of enable() for disable().
 * The driver is not following as per hardware manual for setting
   GPIO interrupts. As per HW manual we need to set noise filter
   for GPIO interrupts.

This patch series fixes those issues.

Biju Das (2):
  pinctrl: renesas: rzg2l: Make reverse order of enable() for disable()
  pinctrl: renesas: rzg2l: Enable noise filter for GPIO interrupt input

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.25.1

