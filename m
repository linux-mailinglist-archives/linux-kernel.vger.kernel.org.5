Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EB97E5058
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjKHG2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjKHG2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:28:01 -0500
Received: from mail-m24125.xmail.ntesmail.com (mail-m24125.xmail.ntesmail.com [45.195.24.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF201706;
        Tue,  7 Nov 2023 22:27:57 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=afes7vLa0UYNoyl2Hn1bpfpkH+6V8c0Mo0pZUiJYqcpH2rhr4Da2clIiwRTR9WqpeTrhLUBxf8Zk3mCEbyKEs/m6Q9igjkkDcuU4dKjnSV6NzzWc0yQ+HZYXOKcV0QP3r1D7PCZHnRXtvMGExReeeYOzdvagNCOH1I/3kFUyD8Y=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=EygMve7+QrfsOan0WCQh7j3hMlgBeGtanJTpadshwQ4=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 67EE140024C;
        Wed,  8 Nov 2023 14:18:30 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        andy.yan@rock-chips.com
Subject: [PATCH v5 3/4] dt-bindings: clock: rk3588: export PCLK_VO1GRF clk id
Date:   Wed,  8 Nov 2023 14:18:21 +0800
Message-Id: <20231108061822.4871-4-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231108061822.4871-1-zhangqing@rock-chips.com>
References: <20231108061822.4871-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IaH1ZPTENJQhkYGUhMSklVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8bad9515c22eb3kusn67ee140024c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6LSo5Ajw#NQo0Fi0yTx0N
        HklPCR5VSlVKTUJCT0lPSEpKT0pNVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlJTk83Bg++
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

export PCLK_VO1GRF for DT.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/clock/rockchip,rk3588-cru.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
index 5790b1391201..50ba72980190 100644
--- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
+++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
@@ -733,8 +733,9 @@
 #define ACLK_AV1_PRE			718
 #define PCLK_AV1_PRE			719
 #define HCLK_SDIO_PRE			720
+#define PCLK_VO1GRF			721
 
-#define CLK_NR_CLKS			(HCLK_SDIO_PRE + 1)
+#define CLK_NR_CLKS			(PCLK_VO1GRF + 1)
 
 /* scmi-clocks indices */
 
-- 
2.17.1

