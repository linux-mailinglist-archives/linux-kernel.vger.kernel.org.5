Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B653C7661A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjG1CIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjG1CIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:08:18 -0400
Received: from mail-m12739.qiye.163.com (mail-m12739.qiye.163.com [115.236.127.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B80210B;
        Thu, 27 Jul 2023 19:08:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m12739.qiye.163.com (Hmail) with ESMTPA id A363A4A01BD;
        Fri, 28 Jul 2023 10:08:12 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com
Subject: [PATCH v2 0/3] clk: rockchip: add GATE_LINK
Date:   Fri, 28 Jul 2023 10:08:07 +0800
Message-Id: <20230728020810.29732-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1CH1ZKGRhMHRpNSktKQk9VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a899a40ea21b212kuuua363a4a01bd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kzo6Eww5Qj0DGjg1FTAYCU8R
        CyEwCz1VSlVKTUJLTkpLS0JIT0tPVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpDTko3Bg++
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent Rockchip SoCs have a new hardware block called Native Interface
Unit (NIU), which gates clocks to devices behind them. These effectively
need two parent clocks.
Use GATE_LINK to handle this.

change in V2:
[PATCH v2 1/3]: fix reported warnings
[PATCH v2 2/3]: Bindings submit independent patches
[PATCH v2 3/3]: fix reported warnings

Elaine Zhang (3):
  clk: rockchip: add support for gate link
  dt-bindings: clock: rk3588: export PCLK_VO1GRF clk id
  clk: rockchip: rk3588: Adjust the GATE_LINK parameter

 drivers/clk/rockchip/Makefile                 |   1 +
 drivers/clk/rockchip/clk-gate-link.c          | 189 ++++++++++++++++++
 drivers/clk/rockchip/clk-rk3588.c             | 110 +++++-----
 drivers/clk/rockchip/clk.c                    |   7 +
 drivers/clk/rockchip/clk.h                    |  22 ++
 .../dt-bindings/clock/rockchip,rk3588-cru.h   |   3 +-
 6 files changed, 280 insertions(+), 52 deletions(-)
 create mode 100644 drivers/clk/rockchip/clk-gate-link.c

-- 
2.17.1

