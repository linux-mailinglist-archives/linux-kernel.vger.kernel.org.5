Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2C7FF8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346520AbjK3R4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjK3R4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:56:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EF2103
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:56:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E440C433C8;
        Thu, 30 Nov 2023 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701366969;
        bh=rHWxyCU/rEPniKYflGKE/m/9/UZG1t+e14CDIdDJGhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtGx61is334RHsWYTPz410E7OL1s8oUJOBR4f1G26k+r6nYu33gx3w5ZVTeBM5VoV
         UNTQ6k9d5DLtXzkdj8sb0NQ+z8hw7+fFcyRF46yJRa83rJ8Jmjui6CigxLjGMhvW8U
         bcELBZRXulzy2odExLvusFAjNbrd92msLvTMYPKAEYx2g7l3RWT2IFz5SXyxy92GJs
         6jC+05kc8Gf/99TogwxJAJNfadUR5nUvC5dkT20VCKJSpImPaSUBpXfoka0/hBHwHB
         maIeAE2I77b/QgWUMEZSwFG8bM/MPaC9fzj6zpYMnwz+XU3wOSMo7actWKPu+Y+9Do
         6eup/uWKX+glA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8lHG-0003iA-2m;
        Thu, 30 Nov 2023 18:56:42 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] arm64: dts: hisilicon: hikey970-pmic: fix regulator cells properties
Date:   Thu, 30 Nov 2023 18:56:34 +0100
Message-ID: <20231130175635.14251-2-johan+linaro@kernel.org>
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

The Hi6421 PMIC regulator child nodes do not have unit addresses so drop
the incorrect '#address-cells' and '#size-cells' properties.

Fixes: 6219b20e1ecd ("arm64: dts: hisilicon: Add support for Hikey 970 PMIC")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
index 970047f2dabd..c06e011a6c3f 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -25,9 +25,6 @@ pmic: pmic@0 {
 			gpios = <&gpio28 0 0>;
 
 			regulators {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ldo3: ldo3 { /* HDMI */
 					regulator-name = "ldo3";
 					regulator-min-microvolt = <1500000>;
-- 
2.41.0

