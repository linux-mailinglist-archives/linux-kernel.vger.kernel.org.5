Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222C08112A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379178AbjLMNSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379161AbjLMNSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:18:07 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA08EF5;
        Wed, 13 Dec 2023 05:18:10 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-425a116f1cdso41853851cf.0;
        Wed, 13 Dec 2023 05:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702473489; x=1703078289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i4l/5gRXaP1+RfdbJslxJg0fd6YM0cZ5wR9VCW+0Q3U=;
        b=OGxLB+0y/nDDpGTbIyFhLKtXL82c9oHexPHfKFD6DX5GDFXndoJYmWJe2FYKb1oUe9
         sgzwZHfmPXV21ralZeb8AxF9hT7JAbV2De4wFOKMRbHHHwLqWamXApQPbU/Y+gDRL/1R
         W0VLNuLHj5y8KNA818AZW9kiAAOLTdIqV8edqBwRhq7jJWd6WUsz+m15m9DvVFruWqlH
         vSxPRiZefJ7MihueKMB2mztbnRDozoVpgLp7w/epLlkMQc2ITowmmI9zXs/6fWcQ+/yq
         xGHHCw2jNatPpezX5JEFoIZ+aDZdqjlqR1CcPKQX/j0Hu/mFbZyOOmMZRwt6jOyuoqwt
         GCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473489; x=1703078289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4l/5gRXaP1+RfdbJslxJg0fd6YM0cZ5wR9VCW+0Q3U=;
        b=XeaxhF7bFbVEMv9F4v7FCBamBHmH9CU5ow0gXn0AZpoI+oSSuODDX8IGcesFrEGe7m
         UVGkoW62wfIMS0/zmYrTl6YBHUz5CDZmoicJxk3zKLGFi3o2FrhEy94AzWKA+a+D3suc
         jC925L4qhFPf+IvfBlxcWYB+mjJOQUfH3pZe1kPspfz9G05j+r9e0t+mxVByhFk/AdxK
         rtEdEdiWJ00U5mhRrxtDuItCmgxdATIAgjPTVNQiQ4CQ9GUXop7HYRuJKAPWTIh8pL01
         ibIvi72qCP/r/AGxWeXOQPJwHApt/fmLuegM+PoXfE5/v1yxPVAmnSGY8byow19iC1cD
         u3kQ==
X-Gm-Message-State: AOJu0YwwDLVZN2Ko8sqy+dFog3yeQiSX2imqoRK1F3vc2ckz01I8D1ff
        QqU4g2CfAPEwuUgkI+CZKBXtg39C4HM=
X-Google-Smtp-Source: AGHT+IHgcLpgW31VJbUwq7ETCySFb7UPpGI5z6ixSKAzF4FLXtqxQsOZnFRjUpq9Pkp2L2oo33Hu0g==
X-Received: by 2002:a05:622a:1708:b0:425:4043:18ca with SMTP id h8-20020a05622a170800b00425404318camr12136045qtk.125.1702473489392;
        Wed, 13 Dec 2023 05:18:09 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id f21-20020ac84995000000b00423890096afsm4889400qtq.2.2023.12.13.05.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:18:08 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] amd64: rockchip: dts: rk3328-rock-pi-e add gpio-line-names
Date:   Wed, 13 Dec 2023 08:17:38 -0500
Message-ID: <20231213131739.13900-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add names to the pins of the general-purpose expansion header as given
in the Radxa GPIO page[1] following the conventions in the kernel
documentation[2] to make it easier for users to correlate the pins with
functions when using utilities such as 'gpioinfo'.

[1] https://wiki.radxa.com/RockpiE/hardware/gpio
[2] Documentation/devicetree/bindings/gpio/gpio.txt

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../boot/dts/rockchip/rk3328-rock-pi-e.dts    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index 018a3a5075c7..3169c0854061 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -388,3 +388,56 @@ &usbdrd3 {
 &usb_host0_ehci {
 	status = "okay";
 };
+
+&gpio0 {
+	gpio-line-names =
+	/* GPIO0_A0 - A7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO0_B0 - B7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO0_C0 - C7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO0_D0 - D7 */
+	"", "", "", "pin-15 [GPIO0_D3]", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/* GPIO1_A0 - A7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO1_B0 - B7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO1_C0 - C7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO1_D0 - D7 */
+	"", "", "", "", "pin-07 [GPIO1_D4]", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+	/* GPIO2_A0 - A7 */
+	"pin-08 [GPIO2_A0]", "pin-10 [GPIO2_A1]", "pin-11 [GPIO2_A2]",
+	"pin-13 [GPIO2-A3]", "pin-27 [GPIO2_A4]", "pin-28 [GPIO2_A5]",
+	"pin-33 [GPIO2_A6]", "",
+	/* GPIO2_B0 - B7 */
+	"", "", "", "", "pin-26 [GPIO2_B4]", "", "", "pin-36 [GPIO2_B7]",
+	/* GPIO2_C0 - C7 */
+	"pin-32 [GPIO2_C0]", "pin-35 [GPIO2_C1]", "pin-12 [GPIO2_C2]",
+	"pin-38 [GPIO2_C3]", "pin-29 [GPIO2_C4]", "pin-31 [GPIO2_C5]",
+	"pin-37 [GPIO2_C6]", "pin-40 [GPIO2_C7]",
+	/* GPIO2_D0 - D7 */
+	"", "", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+	/* GPIO3_A0 - A7 */
+	"pin-23 [GPIO3_A0]", "pin-19 [GPIO3_A1]", "pin-21 [GPIO3_A2]",
+	"", "pin-03 [GPIO3_A4]", "", "pin-05 [GPIO3_A6]", "",
+	/* GPIO3_B0 - B7 */
+	"pin-24 [GPIO3_B0]", "", "", "", "", "", "", "",
+	/* GPIO3_C0 - C7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO3_D0 - D7 */
+	"", "", "", "", "", "", "", "";
+};
-- 
2.41.0.327.gaa9166bcc0ba

