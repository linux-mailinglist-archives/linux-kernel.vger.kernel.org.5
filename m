Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB3A7FDB79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbjK2Pb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjK2PbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:31:21 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2DD1BF;
        Wed, 29 Nov 2023 07:31:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08D42E0013;
        Wed, 29 Nov 2023 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701271885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sAANN2EXeewZfaaobbe7muJTHqc8A8qnJjW9NGWcx8=;
        b=Bu0pbZECI7sSk70SeqV6BFWJPSrmAsRp2m0uGsoD2H1yVZjphF1Z5CqBRErPyFHg6wE696
        1Ul3AFqec7rPvpHTuEY+3yMu3rRr/pZvFgwnWQOfjdBbGOOQMaEqImhtUFxQoedH78DEY0
        XvOuwOwIAQ6woWiV8jBoXXhOaZwJSYYiBxkH/gYRbECvdKQ+GbieTpf/S4kYl6D3uZ3iFu
        VgEKVCDhmbyxL8CEhdsPocoVNXCSP1QAhcVvDItFiouwZMmaWag91eRfRnDyYlxdxef5k7
        Hcg52H2lyI68tqyjH3HcF2Da06v5jsqs/W4d84OeRDizSH04+hF8a2m5ys+86A==
From:   Thomas Richard <thomas.richard@bootlin.com>
Date:   Wed, 29 Nov 2023 16:31:19 +0100
Subject: [PATCH 3/5] arm64: dts: ti: k3-j7200: use ti,j7200-sci compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-j7200-tisci-s2r-v1-3-c1d5964ed574@bootlin.com>
References: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
In-Reply-To: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, u-kumar1@ti.com,
        Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On j7200, suspend to ram poweroff the SOC.
This compatible restores irqs at resume.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 467970fab3a0..d8dc1421e75e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -7,7 +7,7 @@
 
 &cbass_mcu_wakeup {
 	dmsc: system-controller@44083000 {
-		compatible = "ti,k2g-sci";
+		compatible = "ti,j7200-sci", "ti,k2g-sci";
 		ti,host-id = <12>;
 
 		mbox-names = "rx", "tx";

-- 
2.39.2

