Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3DF80CB67
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343720AbjLKNwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343753AbjLKNv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:51:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0514DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91354C433C9;
        Mon, 11 Dec 2023 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302723;
        bh=8IQSzUikd1CKaFoLmAHQxHAUP1cfJGx73DGJFN6Qhmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tv2Dqp8RTdnqcQi6pDg6bR8xa3LhSZ1id+1rbosn+OMpXvplltpVzI/RHYnqRi93T
         7SX1FVA9hfg9sFWHjYSi4lSHHGEWR7FVtb9ckrz9INpWswH+11uc8SdALuQDRTxI1O
         Cd1xO7Ap25gtT5lRMe5uGQmqtYltDNGUYpMNU5h/vfM9O65AQDMm2axzWq6fx7hkrf
         St1mfbXTB2nrr1R7/NnKD0MtAe9OT4kMdHo5W/f6aqWRNdj7BrY/aXwBnyKwvtqtyD
         TdsnhNkAMjoKWfXHZjBI/ufO3MlH2UUC5xFbbGfYoWz/IW+N22u/0+YSzrFjRXom90
         16SBfjYdAxRjQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        frattaroli.nicolas@gmail.com, jonas@kwiboo.se,
        jensenhuang@friendlyarm.com, inindev@gmail.com,
        m.tretter@pengutronix.de, jbx6244@gmail.com,
        s.hauer@pengutronix.de, aholmes@omnom.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 05/47] arm64: dts: rockchip: fix rk356x pcie msg interrupt name
Date:   Mon, 11 Dec 2023 08:50:06 -0500
Message-ID: <20231211135147.380223-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit 3cee9c635f27d1003d46f624d816f3455698b625 ]

The expected name by the binding at this position is "msg" and the SoC's
manual also calls the interrupt in question "msg", so fix the rk356x dtsi
to use the correct name.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20231114153834.934978-1-heiko@sntech.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index abee88911982d..b7e2b475f0707 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -970,7 +970,7 @@ pcie2x1: pcie@fe260000 {
 			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "sys", "pmc", "msi", "legacy", "err";
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
 		bus-range = <0x0 0xf>;
 		clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
 			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
-- 
2.42.0

