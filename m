Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448497A431E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbjIRHna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbjIRHnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:43:13 -0400
Received: from mail-m12791.qiye.163.com (mail-m12791.qiye.163.com [115.236.127.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD176CCE;
        Mon, 18 Sep 2023 00:41:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=UEh7tRhqxHvTaUFQ0u3MeGBGhtzOP/PIi/s7GFyLhXmIlQ2+/CD2jlRdoQSsXQJf6b48/28Apzu9C/YfbudI/QH1+LjuLnfG8HkNqlPdceoCAU831/uiQX+LDSCLt1w10u+zkYvn1fF7QrQHiPcnBj9aAZm/mLdKrhq0BHFBTkM=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=89R2kmI3V5ZPb6807YAI+FcT78Vp6S5FMXaVvIkbARo=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id E9AA868021E;
        Mon, 18 Sep 2023 15:31:51 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        xxx@rock-chips.com, xf@rock-chips.com
Subject: [PATCH v1 0/8] clk: rockchip: Support module build
Date:   Mon, 18 Sep 2023 15:31:43 +0800
Message-Id: <20230918073151.7660-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MdQlZOT0tOQ01MTU9CGBpVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8aa733eb9e2eb5kusne9aa868021e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46OAw*Lz1RP0pWMg1LSUsD
        SSswCTVVSlVKTUJOS0lJSEpJQkJKVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhLT083Bg++
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elaine Zhang (8):
  clk: clk-fractional-divider: Export
    clk_fractional_divider_general_approximation API
  clk: rockchip: drop use of rockchip_clk_protect_critical()
  dt-bindings: clock: rk3188: Add binding id for ACLK_CPU_PRE
  clk: rockchip: Avoid __clk_lookup() calls
  clk: rockchip: rk3399: Support module build
  clk: rockchip: rk3568: Support module build
  clk: rockchip: rk3588: Support module build
  clk: rockchip: fix the clk config to support module build

 drivers/clk/clk-fractional-divider.c          |   1 +
 drivers/clk/rockchip/Kconfig                  |   8 +-
 drivers/clk/rockchip/clk-cpu.c                |  18 +-
 drivers/clk/rockchip/clk-px30.c               |  88 +++---
 drivers/clk/rockchip/clk-rk3036.c             |  42 ++-
 drivers/clk/rockchip/clk-rk3128.c             |  59 ++--
 drivers/clk/rockchip/clk-rk3188.c             |  59 ++--
 drivers/clk/rockchip/clk-rk3228.c             | 147 ++++-----
 drivers/clk/rockchip/clk-rk3288.c             |  74 ++---
 drivers/clk/rockchip/clk-rk3308.c             |  46 +--
 drivers/clk/rockchip/clk-rk3328.c             | 182 +++++------
 drivers/clk/rockchip/clk-rk3368.c             |  71 ++---
 drivers/clk/rockchip/clk-rk3399.c             | 283 ++++++++----------
 drivers/clk/rockchip/clk-rk3568.c             | 114 +++----
 drivers/clk/rockchip/clk-rk3588.c             |  19 +-
 drivers/clk/rockchip/clk-rv1108.c             |  65 ++--
 drivers/clk/rockchip/clk-rv1126.c             |  77 ++---
 drivers/clk/rockchip/clk.c                    |  20 +-
 drivers/clk/rockchip/clk.h                    |  18 +-
 include/dt-bindings/clock/rk3188-cru-common.h |   1 +
 20 files changed, 579 insertions(+), 813 deletions(-)

-- 
2.17.1

