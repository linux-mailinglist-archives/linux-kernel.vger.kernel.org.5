Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7087FFAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjK3TKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjK3TKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:10:51 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E1F10E3;
        Thu, 30 Nov 2023 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=UV2kGcH6+Z9wP1X2LMycZ5WrcrpzIA4/73bs01XpTXc=; b=kvA5k2X3IwFPR0P1qwEjDsEXQ8
        Y1p2OChsIKWnH8b/F0jO72LJDSBgz7bgDuaRdQtXof5LuW0w89Xan6TvtKcBN7zD3Sa8gBxHMi8zm
        Ubd8Q0Xqa0judaGvubS9LJ7OGWFz0+uMhsx7yezFe3I275bm6NK/MfWr/Mz7IFJXMejM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48272 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r8mR3-0003sb-07; Thu, 30 Nov 2023 14:10:54 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        hugo@hugovil.com
Date:   Thu, 30 Nov 2023 14:10:42 -0500
Message-Id: <20231130191050.3165862-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH 0/7] serial: sc16is7xx and max310x: regmap fixes and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series brings fixes and improvements related to regmap access
for sc16is7xx and max310x drivers.

They are related to commit 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port").

Patches 1 and 2 address some comments formulated during review of the
source patch listed above.

Patch 3 removes a structure member made obsolete.

Patches 4 and 5 are improvements for code readability.

Patches 6 and 7 port improvements from patches 4 and 5 of the sc16is7xx
driver over to the max310x driver.

I have tested the changes on a custom board with two SC16IS752 DUART over
a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
configured in RS-485 mode.

Thank you.

Hugo Villeneuve (7):
  serial: sc16is7xx: fix snprintf format specifier in
    sc16is7xx_regmap_name()
  serial: sc16is7xx: remove global regmap from struct sc16is7xx_port
  serial: sc16is7xx: remove unused line structure member
  serial: sc16is7xx: add macro for max number of UART ports
  serial: sc16is7xx: improve sc16is7xx_regmap_name() buffer size
    computation
  serial: max310x: add macro for max number of ports
  serial: max310x: use separate regmap name for each port

 drivers/tty/serial/max310x.c   | 19 +++++++++++++++++--
 drivers/tty/serial/sc16is7xx.c | 32 ++++++++++++++++++--------------
 2 files changed, 35 insertions(+), 16 deletions(-)


base-commit: d804987153e7bedf503f8e4ba649afe52cfd7f6d
-- 
2.39.2

