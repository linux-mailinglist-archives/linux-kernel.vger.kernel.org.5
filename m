Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1823D7A4344
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbjIRHoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbjIRHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:44:17 -0400
X-Greylist: delayed 533 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 00:41:51 PDT
Received: from m177126.mail.qiye.163.com (m177126.mail.qiye.163.com [123.58.177.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DDFCE8;
        Mon, 18 Sep 2023 00:41:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=Dx/i0c+8V9/7en//12Jz5c5gBRAnA8seIFegWNqTloJQOPfPosEIAnxJ1nBsv+tCOpQGQCpkO+lYIuC78m77ZmKAjoLc/754Y4JguuMLbdU4uEus9lhZ8++WIk9IK1EHT6o4fxKHB5bOa6uEL0UmZCgFwQY0OyBrVcqhRHUdll8=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=FkT1/NwLGJhJV/2v8LOqPw2GTHqfJkCBrpYsiomQWlQ=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 5EF406804E8;
        Mon, 18 Sep 2023 15:32:00 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        xxx@rock-chips.com, xf@rock-chips.com
Subject: [PATCH v1 8/8] clk: rockchip: fix the clk config to support module build
Date:   Mon, 18 Sep 2023 15:31:51 +0800
Message-Id: <20230918073151.7660-9-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918073151.7660-1-zhangqing@rock-chips.com>
References: <20230918073151.7660-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRgZTVZKS0JISRoaHh5PHhpVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8aa7340c5a2eb5kusn5ef406804e8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6NBw5OT1CL0oWIgwPSBMy
        QkxPFBVVSlVKTUJOS0lJSElKSE9CVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhLQ003Bg++
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark COMMON_CLK_ROCKCHIP\CONFIG_CLK_RK3399\CONFIG_CLK_RK3568\
CONFIG_CLK_RK3588 to "tristate",
to support building Rk3399\Rk3568\Rk3588 SoC clock driver as module.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/Kconfig b/drivers/clk/rockchip/Kconfig
index 9aad86925cd2..8574c2f6ecf6 100644
--- a/drivers/clk/rockchip/Kconfig
+++ b/drivers/clk/rockchip/Kconfig
@@ -2,7 +2,7 @@
 # common clock support for ROCKCHIP SoC family.
 
 config COMMON_CLK_ROCKCHIP
-	bool "Rockchip clock controller common support"
+	tristate "Rockchip clock controller common support"
 	depends on ARCH_ROCKCHIP
 	default ARCH_ROCKCHIP
 	help
@@ -87,21 +87,21 @@ config CLK_RK3368
 	  Build the driver for RK3368 Clock Driver.
 
 config CLK_RK3399
-	bool "Rockchip RK3399 clock controller support"
+	tristate "Rockchip RK3399 clock controller support"
 	depends on ARM64 || COMPILE_TEST
 	default y
 	help
 	  Build the driver for RK3399 Clock Driver.
 
 config CLK_RK3568
-	bool "Rockchip RK3568 clock controller support"
+	tristate "Rockchip RK3568 clock controller support"
 	depends on ARM64 || COMPILE_TEST
 	default y
 	help
 	  Build the driver for RK3568 Clock Driver.
 
 config CLK_RK3588
-	bool "Rockchip RK3588 clock controller support"
+	tristate "Rockchip RK3588 clock controller support"
 	depends on ARM64 || COMPILE_TEST
 	default y
 	help
-- 
2.17.1

