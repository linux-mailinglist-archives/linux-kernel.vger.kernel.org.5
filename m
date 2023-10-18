Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5781E7CD4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbjJRHCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjJRHCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:02:37 -0400
Received: from mail-m12772.qiye.163.com (mail-m12772.qiye.163.com [115.236.127.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA3FD;
        Wed, 18 Oct 2023 00:02:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=N6+2Ol1k51E6JWP/gsM/nEjC/4dgFUyqaGcEs5R23VJbcRGC+quRYMjjuy1wTrNPbZpND7bbRTmPCaEL/GKrcU8azvzt+amHH7klqDJ15ObTp2yIBJX575o33hg0oWwQzpsYww6Q5jsHrZ2wH+wXmvRfponmKzWu3J/eLHavMdQ=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=1XvCOfyGPEo/kOJS0FZNwvhpiSiL4ph7pVogJ4dlp7w=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 7EFC0400308;
        Wed, 18 Oct 2023 15:01:53 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        andy.yan@rock-chips.com
Subject: [PATCH v4 3/4] dt-bindings: clock: rk3588: export PCLK_VO1GRF clk id
Date:   Wed, 18 Oct 2023 15:01:43 +0800
Message-Id: <20231018070144.8512-4-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018070144.8512-1-zhangqing@rock-chips.com>
References: <20231018070144.8512-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR9KSlZKHkJJGk0eHhhOQkxVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8b4197423d2eb3kusn7efc0400308
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzY6NDo4LTw*DEtKTS9JGkIR
        KgswFDZVSlVKTUJMTUpJTkpPSENDVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlJTEw3Bg++
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MBIST_MCLK_PDM1 is not used,
Use PCLK_VO1GRF to replace it.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/clock/rockchip,rk3588-cru.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
index 5790b1391201..5816cd71a4e3 100644
--- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
+++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
@@ -36,7 +36,7 @@
 #define PCLK_DSU			21
 #define PCLK_S_DAPLITE			22
 #define PCLK_M_DAPLITE			23
-#define MBIST_MCLK_PDM1			24
+#define PCLK_VO1GRF			24
 #define MBIST_CLK_ACDCDIG		25
 #define HCLK_I2S2_2CH			26
 #define HCLK_I2S3_2CH			27
-- 
2.17.1

