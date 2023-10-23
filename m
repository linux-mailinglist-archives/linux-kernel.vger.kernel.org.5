Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B027A7D2858
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjJWCMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjJWCMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:12:31 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E997A8E;
        Sun, 22 Oct 2023 19:12:29 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 23 Oct 2023 11:12:29 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 54D902059034;
        Mon, 23 Oct 2023 11:12:29 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 23 Oct 2023 11:12:29 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A7B71B1D40;
        Mon, 23 Oct 2023 11:12:28 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/2] arm64: dts: socionext: add missing cache properties
Date:   Mon, 23 Oct 2023 11:12:21 +0900
Message-Id: <20231023021221.2884828-3-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023021221.2884828-1-hayashi.kunihiko@socionext.com>
References: <20231023021221.2884828-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

As all level 2 and level 3 caches are unified, add required
cache-unified property to fix warnings like:

  uniphier-ld11-ref.dtb: l2-cache: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 1 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 54e58d945fd7..4680571c264d 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -53,6 +53,7 @@ cpu1: cpu@1 {
 		l2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 18390cba2eda..335093da6573 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -87,11 +87,13 @@ cpu3: cpu@101 {
 		a72_l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		a53_l2: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 56e037900818..d6e3cc6fdb25 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -84,6 +84,7 @@ cpu3: cpu@3 {
 		l2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.25.1

