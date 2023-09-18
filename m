Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A297A4340
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbjIRHog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbjIRHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:44:10 -0400
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 00:41:52 PDT
Received: from mail-m121151.qiye.163.com (mail-m121151.qiye.163.com [115.236.121.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C791CF9;
        Mon, 18 Sep 2023 00:41:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=ZwXs1GBSjZwKqg5hCo8UmM8vhdPvEKScYskKbClAKbM69+rHkSipOVX1bZ5rwf04cZh5WM9QBIUraUuJpENVMO6HMsqvDQ3wYP8umDX2JY0yM5iymBOfd2KA5V0H2xHuRSM6OGCseOMObrN0tv30CZ9v/YchAXQTXa4hbRlND+M=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=FVjj8wFV8jwGPF8t4GJPuriYLO1LL7PtUtc22EoDAPI=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 0E5E1680587;
        Mon, 18 Sep 2023 15:31:53 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        xxx@rock-chips.com, xf@rock-chips.com
Subject: [PATCH v1 1/8] clk: clk-fractional-divider: Export clk_fractional_divider_general_approximation API
Date:   Mon, 18 Sep 2023 15:31:44 +0800
Message-Id: <20230918073151.7660-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918073151.7660-1-zhangqing@rock-chips.com>
References: <20230918073151.7660-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUgZGVYeH0JOTkgaQx0aGklVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8aa733efbe2eb5kusn0e5e1680587
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6Mjo*Lj1NDUoPIg1CSUgC
        KQ0wFC9VSlVKTUJOS0lJSEpPS0tLVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlPSE83Bg++
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used by the Rockchip clk driver, export it to allow that
driver to be compiled as a module.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/clk-fractional-divider.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 479297763e70..44bf21c97034 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -142,6 +142,7 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
 			m, n);
 }
+EXPORT_SYMBOL_GPL(clk_fractional_divider_general_approximation);
 
 static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
 			      unsigned long *parent_rate)
-- 
2.17.1

