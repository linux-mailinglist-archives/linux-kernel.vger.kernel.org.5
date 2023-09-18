Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6458A7A4341
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbjIRHob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbjIRHoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:44:06 -0400
X-Greylist: delayed 538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 00:41:49 PDT
Received: from mail-m127160.xmail.ntesmail.com (mail-m127160.xmail.ntesmail.com [115.236.127.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1AA130;
        Mon, 18 Sep 2023 00:41:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=OVBVYR//m2GOTeqi6qbpjcHpfx0LAIPHufHrPyHGpugR30OthtIJY5L0htqTYiuizLQlrm3RZwhNFJU0Kyy1msBy66LlKq58eJf9tN/fcCz6yptJjb0T7Pc7DI+EflLLvviOCgr3wnL4ayluSF3/8LKF7YAljAkE1TlTpq2yD6c=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=DvBFYt+jqVEQKs9UGgC5VD5M1NXx2xvswehqQpfi6qw=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 5F67C6805DF;
        Mon, 18 Sep 2023 15:31:55 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        xxx@rock-chips.com, xf@rock-chips.com
Subject: [PATCH v1 3/8] dt-bindings: clock: rk3188: Add binding id for ACLK_CPU_PRE
Date:   Mon, 18 Sep 2023 15:31:46 +0800
Message-Id: <20230918073151.7660-4-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918073151.7660-1-zhangqing@rock-chips.com>
References: <20230918073151.7660-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhgfTlZLSR9IHR0aH0lDGEJVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8aa733f8f92eb5kusn5f67c6805df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6Shw5CD0CSkodIg4xSUMj
        KD0wC09VSlVKTUJOS0lJSEpNSUNPVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlKTEw3Bg++
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

export clk id ACLK_CPU_PRE.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/clock/rk3188-cru-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3188-cru-common.h b/include/dt-bindings/clock/rk3188-cru-common.h
index afad90680fce..e728ed076c5b 100644
--- a/include/dt-bindings/clock/rk3188-cru-common.h
+++ b/include/dt-bindings/clock/rk3188-cru-common.h
@@ -67,6 +67,7 @@
 #define ACLK_PERI		204
 #define ACLK_VEPU		205
 #define ACLK_VDPU		206
+#define ACLK_CPU_PRE		207
 
 /* pclk gates */
 #define PCLK_GRF		320
-- 
2.17.1

