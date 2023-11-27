Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947167F9B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjK0IOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjK0IOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:14:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 043FA184;
        Mon, 27 Nov 2023 00:14:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43C592F4;
        Mon, 27 Nov 2023 00:15:08 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E7FBF3F6C4;
        Mon, 27 Nov 2023 00:14:18 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     lukasz.luba@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        conor+dt@kernel.org, daniel.lezcano@linaro.org
Subject: [PATCH] arm64: dts: rockchip: Add dynamic-power-coefficient to rk3399 GPU
Date:   Mon, 27 Nov 2023 08:15:11 +0000
Message-Id: <20231127081511.1911706-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dynamic-power-coefficient to the GPU node. That will create Energy
Model for the GPU based on the coefficient and OPP table information.
It will enable mechanism such as DTMP or IPA to work with the GPU DVFS.
In similar way the Energy Model for CPUs in rk3399 is created, so both
are aligned in power scale. The maximum power used from this coefficient
is 1.5W at 600MHz.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 9da0b6d77c8d..87cfdf570b19 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2113,6 +2113,7 @@ gpu: gpu@ff9a0000 {
 		interrupt-names = "job", "mmu", "gpu";
 		clocks = <&cru ACLK_GPU>;
 		#cooling-cells = <2>;
+		dynamic-power-coefficient = <2640>;
 		power-domains = <&power RK3399_PD_GPU>;
 		status = "disabled";
 	};
-- 
2.25.1

