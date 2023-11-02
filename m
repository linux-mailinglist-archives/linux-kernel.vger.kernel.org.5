Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDF27DF5D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345041AbjKBPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjKBPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:12:15 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74531187;
        Thu,  2 Nov 2023 08:12:06 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id D0760848D4;
        Thu,  2 Nov 2023 16:12:04 +0100 (CET)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Thu, 02 Nov 2023 16:11:08 +0100
Subject: [PATCH v7 02/10] dt-bindings: pinctrl: pinctrl-single: add
 marvell,pxa1908-padconf compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231102-pxa1908-lkml-v7-2-cabb1a0cb52b@skole.hr>
References: <20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr>
In-Reply-To: <20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Leo Yan <leoy@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Karel Balej <balejk@matfyz.cz>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=XB52xSkcW7DlpdxdsDrnjNPD7kW7z6MEd0cFXu6HRPY=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlQ7w4s0X/U4LfTPm+d3uM/f8sVLN8kU+aEvTP7
 Uln5kwWiPGJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZUO8OAAKCRCaEZ6wQi2W
 4UBOD/9XSrU6k/VpMh4t2ctpZgfmH9BIW4xIC/g7N2fLI3uAYchePaqWsjv/O2ZDBAQ9rKccpMf
 wzidE0AvYkJQhr/G2EiiDVr4u7b00b2IorTUGkIOkmX8a4tyFI/+KJsaBIVNiBD24va6gZq5Ew2
 PoQsztYvv1p2t9RHpS/d0ceDb2GZX0cNq9SeGcBGlR4NZ7EneBmUuTjb2iUL7cN4ovIKyYhGPgJ
 scW07emNsENae6F/yqJbahnL2HXc4Gi3cDHL/iuNXLos0yzXILsXl7lvIEuhr9IXqhRtJYZ+H9v
 pUWuO7mt8Xg2QgJAi+qX3ZUuUFkdzLgaGz/AOeCQzxJ6PhMcfWrp51ElmRCqUHZgM08ZZ/NLWF7
 PQ1kbIhMN6rgewJvmdr1FfhcXSiUGsAXRdBqvk41wODAjtr0p6u9T7I9IzqrjI0+0t0Bt8XIHIj
 7/E8V/TrQ3mJDVAlrPSTeb30/si5QhEQRU7D0YPwnoHXi0EAS1V/VIdU76gUWYcLk3TE9OOQi95
 ql5iEImrlQmY25Cxq0uR4GPzE4ya4pXjnkKF1ilnqmF0/5WlFTN3fXG0J0MN2qs+JZ8Z6cR1vjj
 0BaJVwy1z8PNobG552NcH0MKhZqvheNQDfRcCaalw1uYiB37dQxAFkiH49UP/xArkEF/aq6Ey/D
 gGqZRowQytonoWA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
separate pinctrl driver later.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
index 45a307d3ce16..0f7e16a28990 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
@@ -32,6 +32,10 @@ properties:
               - ti,omap4-padconf
               - ti,omap5-padconf
           - const: pinctrl-single
+      - items:
+          - enum:
+              - marvell,pxa1908-padconf
+          - const: pinconf-single
 
   reg:
     maxItems: 1

-- 
2.42.0


