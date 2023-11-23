Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC20A7F5D67
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbjKWLGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjKWLFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:05:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A9CD54
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:05:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8CFC433C9;
        Thu, 23 Nov 2023 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700737554;
        bh=5+tWyKAC++2Xnrgn3NdMaK+q0ya4fE8D9fGwVpiP1Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXbiFiobNLe2JxXPcmWo8nLzQzuJ0EtGXlolJinYPcK8B4Od9jeB6dYYWU2PW8lSJ
         BTfn/20C6mIUm6KnKVQeLfRm+HqiNXQ8oCH9vNKLmuW7UOodeeKs53SgxP43UUPoSe
         8Iz6MqbaJhXWowQn+jh8OjVf/qnu4NDtJWRpJlKqOzlWU4zMZ7zPLYmi1YEI0g4oEC
         XVRgDyaGG2thEMkLswRlGbobUzOJ3FHm0aivGz6nvO4BDbcezPzh9l/PpE9NdLMX96
         ywX7Dm1pTI5o9GhFTua14j7NbMXLxSj4wAD9bpq5ApXsxQVxQDfxgKt3Zza62nnT5P
         sQ1jMRTTLFHGg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 5/6] usb: fsl-mph-dr-of: mark fsl_usb2_mpc5121_init() static
Date:   Thu, 23 Nov 2023 12:05:05 +0100
Message-Id: <20231123110506.707903-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123110506.707903-1-arnd@kernel.org>
References: <20231123110506.707903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function is only called locally and should always have been static:

drivers/usb/host/fsl-mph-dr-of.c:291:5: error: no previous prototype for 'fsl_usb2_mpc5121_init' [-Werror=missing-prototypes]

Fixes: 230f7ede6c2f ("USB: add USB EHCI support for MPC5121 SoC")
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/fsl-mph-dr-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 8508d37a2aff..6cdc3d805c32 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -288,7 +288,7 @@ static void fsl_usb2_mph_dr_of_remove(struct platform_device *ofdev)
 #define PHYCTRL_LSFE		(1 << 1)	/* Line State Filter Enable */
 #define PHYCTRL_PXE		(1 << 0)	/* PHY oscillator enable */
 
-int fsl_usb2_mpc5121_init(struct platform_device *pdev)
+static int fsl_usb2_mpc5121_init(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct clk *clk;
-- 
2.39.2

