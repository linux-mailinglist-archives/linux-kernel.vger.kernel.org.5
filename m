Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AB88118AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjLMQGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjLMQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:06:20 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD8CDB;
        Wed, 13 Dec 2023 08:06:26 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67ad531686eso63546526d6.1;
        Wed, 13 Dec 2023 08:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702483584; x=1703088384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mV7pcScjZucWWRXnAxSJek2hZSxOGAqXVzogrAoZOIE=;
        b=C0kQ9t+UDxyRZVsZd4YiiVbV/VH4h+L6ErF5H/fOa6R+1QRm+4jVPAmbOvkfcHgeF3
         jZ8zwX6L0A8TxjD2lvCtwNPLGIqha62bWYpsQamu7cu9dFe1L3GVwHA0Bdo8vkWB8jkP
         SEGoMjTAzYmfxi29Ivgiee0i5eUwYJqh/SgVxq94lulKDQIuyaPZGTtNyQwd4MbvPM2/
         ikDQjHlqxaJOgPDixtncU4TuwaXrFfiVeFJL4lICUOGSIT+yOZqkr+SPoB0Etr4Ltrgl
         jwh6S+CwSa/ir0iVgrsAtyDGJC4lM2lxwkLA+nJBKZGs1EKajGXWcilnXFaG8l38jLKM
         GrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483584; x=1703088384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mV7pcScjZucWWRXnAxSJek2hZSxOGAqXVzogrAoZOIE=;
        b=LxL7WW7sBXgMzS4xjDhEKq3iYZHyGojhkNO1ODcMl2V7gBu6h3bVTo+fkSDctYJ3Ak
         8iPObG9p99eXfxPrgurtsEu6ZfS2ul72q42QcS+U0h/j9opcATWFEkHnpEf80dWAO2cj
         uOfre8E+ViCLAx5F8RtT08UkpdYJfKJHD/N69eMKIuVY/J929Q/6h3px6xr/nznytPbL
         2BHgWtIWo4RmRB/HW1Fyt89corZYb2BZ+Y9TOS3ft0nZAsU4OCR+aluotjerhunaLr+7
         32XM/FwZiXf/+tWyTtJn6WZjb3vunmGGV5QhjohnT19eT3+MN06k9bdsNoPMojmE+w6o
         tXMg==
X-Gm-Message-State: AOJu0YwnGk0Tk19BaYPHAZz4LLSwcGete9H2L2KB848DJ+RvWHsQ6zVD
        B3MzM0zEDQFUJGtR3Qjrxvjz2mxafc8=
X-Google-Smtp-Source: AGHT+IGXmvitHaimiJfEzIE4bQb1b+g+FbM+iFhthTlXcxDos1V7s36HFzw+7/wuVmnwUsuUirgsWw==
X-Received: by 2002:a05:6214:5e85:b0:67e:f80e:56db with SMTP id mm5-20020a0562145e8500b0067ef80e56dbmr1520364qvb.54.1702483584629;
        Wed, 13 Dec 2023 08:06:24 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id h11-20020a0cf8cb000000b0067aa2d86ce3sm1720378qvo.52.2023.12.13.08.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:06:23 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2] arm64: rockchip: dts: rk3328-rock-pi-e: add gpio-line-names
Date:   Wed, 13 Dec 2023 11:05:55 -0500
Message-ID: <20231213160556.14424-1-twoerner@gmail.com>
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

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- fix subject from "amd64..." to "arm64..."
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

