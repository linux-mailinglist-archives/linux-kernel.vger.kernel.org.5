Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2423C78C584
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjH2NdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjH2Ncv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F49E4A;
        Tue, 29 Aug 2023 06:32:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A06861D44;
        Tue, 29 Aug 2023 13:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D92C433C8;
        Tue, 29 Aug 2023 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315934;
        bh=Vu27EeyOaTT49MCsitsQ7/mC2fu7y2oNK59IjlyS50k=;
        h=From:To:Cc:Subject:Date:From;
        b=nMG71CAsmZ5+OCzvzjaTtWC8lBZom2FU90/DSjVY4ePAWz05zdVN88IIDXHmsrCba
         L3+n3vMBG7/F4ackdLsUcPYS6sO4PXy0P+VmRH9Fgf+VSPxylrxGtYlkMBEJm7VlgE
         2TN2dLmHLw7tSI2LdDFay1TLOHle0hlGKCJClXyPQqG5SzAlnBenaYpPC3avqCmBuk
         gNg21z9qcBn7/5JAsk+Fc/G0k0/JaR0e0hcIbY3Ud8hKgrf40jE3+6PrDSdZfE6OzX
         Fo+JmqU8Rt+FrM5AjKRQFSu//bEU5GeLiBodCXlzc2jiKjJ8kqNAopQCUfC4W1r176
         CJ6LLRiaQuJIQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andyshrk@163.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 01/17] arm64: dts: rockchip: correct wifi interrupt flag in eaidk-610
Date:   Tue, 29 Aug 2023 09:31:48 -0400
Message-Id: <20230829133211.519957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 8183bb7e291b7818f49ea39687c2fafa01a46e27 ]

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning: GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE.

Correct the interrupt flags, assuming the author of the code wanted same
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_HIGH  => IRQ_TYPE_LEVEL_HIGH

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230707063335.13317-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
index d1f343345f674..6464ef4d113dd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
@@ -773,7 +773,7 @@ brcmf: wifi@1 {
 		compatible = "brcm,bcm4329-fmac";
 		reg = <1>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "host-wake";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_host_wake_l>;
-- 
2.40.1

