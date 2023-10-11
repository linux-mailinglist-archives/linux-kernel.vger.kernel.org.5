Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2787C593F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbjJKQeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjJKQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:34:03 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665EC9;
        Wed, 11 Oct 2023 09:34:01 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7333EC8910;
        Wed, 11 Oct 2023 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697042009; bh=7vvdhC6KAj7ZNdCmM8RVwUVEj98hfS/kjCzyhHOqUUY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=y0Vq9lxnBoUfhnUJzPzpqUG0A+xsaLC3WjTIubUGwdq0Dj9zwpnYM+p2jn5Cj+nbu
         BNidqwdUM650W7/GoPuHl35nJZfwx7H8E2kDRMm9nh23kp3dcZhiHQQvmvePsz7QgD
         +zO65A6GXqyi0V2tggeq6d+tneBOwkR6Xw/qOdGY=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 11 Oct 2023 18:33:14 +0200
Subject: [PATCH 2/3] ARM: dts: qcom: msm8226: Add watchdog node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231011-msm8226-msm8974-watchdog-v1-2-2c472818fbce@z3ntu.xyz>
References: <20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz>
In-Reply-To: <20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=JPCqKraYdY5NCeEAImGjma+5khbva/kahDElRCRUJ9Q=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlJs5XzfhSiX2IZXKcJPxLRMCoZftWzxm6lVNzD
 cVhFx//Rc2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSbOVwAKCRBy2EO4nU3X
 Vh5vD/0QM/pYNRwQD/CW/N0tgVPlzewH0I95dDI9FI5bKra8RwfnFH7OCyqGaj4Jqb81vuO71yG
 CimoFjWYP3HN5omUyeVvzueWuj3oh6yOft7h/If1jKYDD+rcTygIJ+3428jAgojzAx9tr40qHZ9
 R6gtvmon0juO4M08ne7VM3WGQ3AcHXaIE0t9M74peg1FT89Z1Nc8v0jM7XERgPsIz8a7EBpZHKl
 9D70hXJRBz6y8taoy21nMt8VFyvLKVRRYKVc2UM5lJN8BSSXHByTnn2wprYWMww+UINbZQ3NK4S
 ySoE7jm3icl+LOwNVEMw46Kh/Fn6c6oISFlPv/UpaDNiD+BOeDoh5ZhetKUndYmiF9qVwvKdjCd
 CvlSiiq3IDXm2ddB+iMueM5quvXjLUDUYJdBXOe4Tygkbw9Pom0PZPF3ocWRz+JekyfkWOsoyCl
 lzytRiA6QPCU2ReJ6bPqHVZndoGGLz1DM0uiGhgZFEZ1t2vxVsPlocGneLtJ03P6bxK7V29QwBk
 CKjk9h8BugSC+H3isgnMfuYSx6JqIg585mBnHLHNxTKUCXmOlLYqxNbau7CEc80oiWnWW05MaKI
 vZOXHpRVSr0wH8SKB/20VMC48HgQK9dGviOR37Xqj/wRJ4ToHD0Iv/OTVW5pl0Gjf9IbdD96zlP
 oRNbhZP67xUztmw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

Add watchdog for MSM8226 platform.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index 97a377b5a0ec..b5e715858211 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -185,6 +185,14 @@ apcs: syscon@f9011000 {
 			reg = <0xf9011000 0x1000>;
 		};
 
+		watchdog@f9017000 {
+			compatible = "qcom,apss-wdt-msm8226", "qcom,kpss-wdt";
+			reg = <0xf9017000 0x1000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&sleep_clk>;
+		};
+
 		sdhc_1: mmc@f9824900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;

-- 
2.42.0

