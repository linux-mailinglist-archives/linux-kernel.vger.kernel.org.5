Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02E7FF8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346659AbjK3R4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3R4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:56:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F260106
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:56:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39605C433C9;
        Thu, 30 Nov 2023 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701366969;
        bh=gNNI6Vpn1UZq1RAioCl0smWD/0FRBB3YSPywtR360Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pWL/8XCQPjjyv2Z+YaeYOEMIAPX++Jzi3PJt2x27hS13WKN4IDrL66P2BFg2eNWjt
         L7VrK6rKGGfQ2JTN84Hum0YUGEVSEVj5Nx1kxjp4QdezxfrQAEQTvluJxCooI/7wf6
         Wq0eWusxG5BjV3rj4/3TmkrcMIah8RsPFZ4XS7fUyE2YAz7JxJoI03aXbK3WFjEKjQ
         CRhqBY9T450UtHMMkJa+MBl5umX6VPOGV0BRZEtS75G4UGY+dzAeIvkbPaO/PQxe7u
         dpC4jDuDl8e2oPXHn4fA4oX3z/hJ8626tlnl8l/BFDYxTlz2U+JYHDQiruREFxYxbP
         Wc9OFPs/03W2g==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8lHG-0003iC-34;
        Thu, 30 Nov 2023 18:56:42 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] arm64: dts: hisilicon: hikey970-pmic: clean up SPMI node
Date:   Thu, 30 Nov 2023 18:56:35 +0100
Message-ID: <20231130175635.14251-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130175635.14251-1-johan+linaro@kernel.org>
References: <20231130175635.14251-1-johan+linaro@kernel.org>
MIME-Version: 1.0
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

Clean up the SPMI node by dropping the redundant status property and
moving the 'reg' property after 'compatible' for consistency.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
index c06e011a6c3f..299c4ab630e8 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -10,10 +10,9 @@
 / {
 	spmi: spmi@fff24000 {
 		compatible = "hisilicon,kirin970-spmi-controller";
+		reg = <0x0 0xfff24000 0x0 0x1000>;
 		#address-cells = <2>;
 		#size-cells = <0>;
-		status = "okay";
-		reg = <0x0 0xfff24000 0x0 0x1000>;
 		hisilicon,spmi-channel = <2>;
 
 		pmic: pmic@0 {
-- 
2.41.0

