Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C487A4359
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbjIRHpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbjIRHoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:44:37 -0400
Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com [45.254.49.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945619A;
        Mon, 18 Sep 2023 00:42:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=anc0sa+d8rpcjzKssV90aHXJyouUoX4sa6cc8E8GkpuIFNV2UgBziV5zXdOumVXNie+eDu/bmQ4IPESh2l81HhgsQdUp5WxAnqlMS+pnuKRtY+gs4NW7QBZ1UHBjv19lGZ94/OW2LK+O9HG6NRt9gfsVVFb2vYlVu55GmxOOvIE=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=rQXmJM8WZ2P7TQ/NkWuRBycU5T8lBHAqSLpNdp/37dc=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 769C7680357;
        Mon, 18 Sep 2023 15:31:59 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        xxx@rock-chips.com, xf@rock-chips.com
Subject: [PATCH v1 7/8] clk: rockchip: rk3588: Support module build
Date:   Mon, 18 Sep 2023 15:31:50 +0800
Message-Id: <20230918073151.7660-8-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918073151.7660-1-zhangqing@rock-chips.com>
References: <20230918073151.7660-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk1LT1YYQh1CSh5MH0pMGEpVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8aa73408c92eb5kusn769c7680357
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBg6URw6AT1OSkoSSQERSA0I
        AyhPFENVSlVKTUJOS0lJSElLSEhPVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhKT0g3Bg++
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support CLK_OF_DECLARE and module_platform_driver
double clk init method.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3588.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk-rk3588.c
index 6f0db8ce3ba9..70ced70a3559 100644
--- a/drivers/clk/rockchip/clk-rk3588.c
+++ b/drivers/clk/rockchip/clk-rk3588.c
@@ -2504,6 +2504,7 @@ static void __init rk3588_clk_init(struct device_node *np)
 
 CLK_OF_DECLARE(rk3588_cru, "rockchip,rk3588-cru", rk3588_clk_init);
 
+#ifdef MODULE
 struct clk_rk3588_inits {
 	void (*inits)(struct device_node *np);
 };
@@ -2519,8 +2520,9 @@ static const struct of_device_id clk_rk3588_match_table[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, clk_rk3588_match_table);
 
-static int __init clk_rk3588_probe(struct platform_device *pdev)
+static int clk_rk3588_probe(struct platform_device *pdev)
 {
 	const struct clk_rk3588_inits *init_data;
 	struct device *dev = &pdev->dev;
@@ -2536,10 +2538,15 @@ static int __init clk_rk3588_probe(struct platform_device *pdev)
 }
 
 static struct platform_driver clk_rk3588_driver = {
+	.probe		= clk_rk3588_probe,
 	.driver		= {
 		.name	= "clk-rk3588",
 		.of_match_table = clk_rk3588_match_table,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver_probe(clk_rk3588_driver, clk_rk3588_probe);
+module_platform_driver(clk_rk3588_driver);
+
+MODULE_DESCRIPTION("Rockchip RK3588 Clock Driver");
+MODULE_LICENSE("GPL");
+#endif /* MODULE */
-- 
2.17.1

