Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB38042CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjLDXtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjLDXtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:49:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BD8FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=oAehMIztwNkWnpdM5B8v9ExxaYIxuWbdMaA+f9Kvzkw=; b=kWXNeewChvr0RhY7eiHq4d7dlI
        246UPYxGIxBNS35CJoCFpPvuXl4za0TT2c4xrdVBfqbVk7QCYkc6bl9wenzGp3c1IAUfSmtoqMiWp
        Aua0Oz62BTv0CRnyswVJqvL69qnU5Syb4rWRt3atuuUB/LbJK9K/4FaWqR8My19SZAD8m2AmhiKCS
        p/R0t4O23U6j8yMo/6tV+xhci10P3nJWY8yE2056AJicx+0WMgBu5YGOQkq4zW7YAkh2DjEo8Adts
        ApW59lUnj4e+APUiYEehMh4fEzgxY/MtvsaikvWxGg7pVzjHbU66zPuusMFUH5ZNBpLXEbxz+BHBG
        kF3g99wg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAIgg-005p0j-0w;
        Mon, 04 Dec 2023 23:49:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org
Subject: [PATCH] phy: renesas: phy-rcar-gen2: use select for GENERIC_PHY
Date:   Mon,  4 Dec 2023 15:49:17 -0800
Message-ID: <20231204234917.23509-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the last "depends on GENERIC_PHY" to use select, like the
other 170+ Kconfig users do. This can help prevent circular
dependency issues.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org
---
 drivers/phy/renesas/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/phy/renesas/Kconfig b/drivers/phy/renesas/Kconfig
--- a/drivers/phy/renesas/Kconfig
+++ b/drivers/phy/renesas/Kconfig
@@ -13,7 +13,7 @@ config PHY_R8A779F0_ETHERNET_SERDES
 config PHY_RCAR_GEN2
 	tristate "Renesas R-Car generation 2 USB PHY driver"
 	depends on ARCH_RENESAS
-	depends on GENERIC_PHY
+	select GENERIC_PHY
 	help
 	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
 
