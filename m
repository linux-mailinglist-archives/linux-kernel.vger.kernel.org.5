Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699347867AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbjHXGpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbjHXGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142B7198;
        Wed, 23 Aug 2023 23:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A60D2646AF;
        Thu, 24 Aug 2023 06:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40147C433C8;
        Thu, 24 Aug 2023 06:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692859521;
        bh=bcZU8YxffkCIfRb0QCjzp823WBVM6ukmSQ1+psPp8jA=;
        h=From:To:Cc:Subject:Date:From;
        b=JIqCFyYzi/+ovUjSlx41YA5FHd8G0SWzpc/MvS6UTxznILw7FBpJSEyQO/7OAsp4t
         iAegdW6sQjZccs2ty9aC2cJ5npy0HlDpblEjqmkR3uMFXuwv2gcwFfciAZ/wcB/c36
         6GkZyt8H1XE3my9fFPcyXEo23T/BT7m5tv/3VtsD2fugH6dbAut+rAY+8S0nTxhFpr
         N+GPeWIRG/ppwkevburgYtB1Kf6N1ZFpWuOSP34/DNFUL9240g0B15nLua4Z6VAnNl
         Sc5wi2jwXbGUGgTCgSaD4BINPwWxV2pRKSOQxVnnV84xS0MMGIlBTuz5ik66KBPjD9
         e7AtiAu1bhmJQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: [PATCH] pinctrl: single: remove get rid of __maybe_unused
Date:   Thu, 24 Aug 2023 15:45:08 +0900
Message-Id: <20230824064508.968142-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are always used in pcs_probe().

While I was here, I also changed 'unsigned' in the same line to
'unsigned int' to address the checkpatch warnings:

  WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/pinctrl/pinctrl-single.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 0dabbcf68b9f..51783fa62c1c 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -240,32 +240,32 @@ static struct lock_class_key pcs_request_class;
  * does not help in this case.
  */
 
-static unsigned __maybe_unused pcs_readb(void __iomem *reg)
+static unsigned int pcs_readb(void __iomem *reg)
 {
 	return readb(reg);
 }
 
-static unsigned __maybe_unused pcs_readw(void __iomem *reg)
+static unsigned int pcs_readw(void __iomem *reg)
 {
 	return readw(reg);
 }
 
-static unsigned __maybe_unused pcs_readl(void __iomem *reg)
+static unsigned int pcs_readl(void __iomem *reg)
 {
 	return readl(reg);
 }
 
-static void __maybe_unused pcs_writeb(unsigned val, void __iomem *reg)
+static void pcs_writeb(unsigned int val, void __iomem *reg)
 {
 	writeb(val, reg);
 }
 
-static void __maybe_unused pcs_writew(unsigned val, void __iomem *reg)
+static void pcs_writew(unsigned int val, void __iomem *reg)
 {
 	writew(val, reg);
 }
 
-static void __maybe_unused pcs_writel(unsigned val, void __iomem *reg)
+static void pcs_writel(unsigned int val, void __iomem *reg)
 {
 	writel(val, reg);
 }
-- 
2.39.2

