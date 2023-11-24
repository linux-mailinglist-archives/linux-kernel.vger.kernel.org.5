Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416A67F6E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbjKXIlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjKXIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:41:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779C3D73
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:41:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3316ad2bee5so953934f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700815287; x=1701420087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmqHf7vG3OgSbkZDuoqTVPYV9KLNSSDAPn0Rr1mvHIw=;
        b=hucOygj6dzJxypEDNYXM3M/QtRLbKURLjKzWyeUi3Prs5KuxlCQQ817DaXYFOEcX/v
         eErmRNYMoH6IeNcmoP9PwKZct9aoWJy+xcL6cjEdBWLPstFRsxOGuNbZVCePVYWDB9u/
         QpDDtUHCriE3JP3uPzMc9Uv/RKqVgqyF2aDqJJz+B+k7ng+137hK2ZmkVOWearEfv32Y
         vVEqw1QRrcKeF5tAPL8OWPG/iuJFLaHKeMRB1EHIWyddXA15ehtDCkgXHs5IAfmTBlw9
         Q/XHgGnHPbMsPhR4aMfYQ2A95Lt4eTXxzy6qOfFWE3lIayFn9+t5DZyLmC487exDgzFo
         pIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700815287; x=1701420087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmqHf7vG3OgSbkZDuoqTVPYV9KLNSSDAPn0Rr1mvHIw=;
        b=KinvBm8MybuTr+4Qwv+OkIJkc6dli6I9Fwx1ct7HW/7J3+oO8p4vy+A2blbGWatw24
         OwqN8JtMtoEJP0Y91ATLT0x/Eyw43amsuV3yepZjUvYQ6bry5XX+fySmxg2JyNg9paN9
         NF42MU2DsD5Sq7zpUdaZZ/oKy8THia04HHYUoyPnnIDYnbevRsQtPwct5A3YBzWQj6bp
         UdCtA1/m1J92prmGXr2b8hRxBEP+WD7v6OLAdAcE6x9Wr6POyeed4CiwelPdZyYcBJsh
         KSBx+q5D5dsyOlQluNlmqdwiQvxNvtpYQVcLumu+27LVoHaO+uypwhpJM5RXSb6dzOr1
         kEHA==
X-Gm-Message-State: AOJu0YxeEPghPYf6nIVp+uMci2gg5VqmIO86CkeiZmtb/wxpO0+9Cke1
        yukysSDxlxGhEK0sKRHbUW9Y4g==
X-Google-Smtp-Source: AGHT+IFPKfH4bRgwYLSScdIAX4eq/D8aF5dbD0VbyY0HPbjeV7slo9I4RmgXoBTePe/TnCrXi0Gj6g==
X-Received: by 2002:adf:f10d:0:b0:331:6c3b:4f1b with SMTP id r13-20020adff10d000000b003316c3b4f1bmr1399602wro.6.1700815286963;
        Fri, 24 Nov 2023 00:41:26 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4f0b000000b00332e67d6564sm2534562wru.67.2023.11.24.00.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 00:41:26 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 24 Nov 2023 09:41:13 +0100
Subject: [PATCH v9 02/12] dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl:
 add example covering meson-axg-hhi-sysctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-2-95256ed139e6@linaro.org>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
In-Reply-To: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KQGG1ytiHBIC5JgUp3eMPUlMvnricP4K9ae8Hqw91b4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlYGGuRHAkz/o0FoARcM/nBhaSVY4S5HKY2Q4xPPDK
 g0HXtl+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWBhrgAKCRB33NvayMhJ0SoJD/
 40QaN+xss8YhXmbPd7kcRXbNr00DUi9YXy17gL5d+nQzAJClUpXWM/LHE9EckZTKnrONy8hm8IyTsm
 +Q7v99Ma/k1BhRTuMLsWwfwFdFNoAm7OTDjKTKX3C8XSRZsYU+fUgVCAk9mLi0ILxo3unQMKEakNSO
 dE9rb6fvsHrXEVu4hEJRwGyxCKaj3v/DHp1F3CJPhnYNbdk+GJFAYD9mL6/Rquv7pfpR3IjTM6le/R
 CteRqtCWIuTLlnxJ2PR3bb6vtUGOpsAkWvdE95r40uUkhGJ5c4kZUY26dxnxstVIwWFeG2s7oL8t3S
 ZVlS1l/hLzSrpaeHiYKZfwxv5nccbZ/0qhpFqor44I2oPPA1T3HykRL+qs0mIMrBmmmK6W5gikOwrA
 GZifoZAOOG3AChGpZamhVtFHgvVgLP/SvPLmJamG2uSYLX4M7Wu2blhSuoHw/L2HdKB+d3880wK096
 fdWsEuUVgv8fRo95lxdriQPJb69/AHXgHKL4NQcNFjTNqOJ8YkkAquQwhf/yOaDIcnW3ERUKxybg5+
 2lm/rhZbQ1IYLlYT1bip3o4J/rw6V6TvE6LtKHhjvs31uK1MH2UwobR7GUv+a6sJR+vtVHbwzC+9YM
 iNd8dCd57nIB+Awkk1LFT+YJgUoJCMyAh8AI+tTF+Y4Vrb1wSxd8bt5jIWKQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a third example covering the meson-axg-hhi-sysctrl variant and more
importantly the phy subnode.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
index 16977e4e4357..c6bce40946d4 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -158,3 +158,36 @@ examples:
             };
         };
     };
+
+  - |
+    system-controller@ff63c000 {
+        compatible = "amlogic,meson-axg-hhi-sysctrl", "simple-mfd", "syscon";
+        reg = <0xff63c000 0x400>;
+
+        clock-controller {
+            compatible = "amlogic,axg-clkc";
+            #clock-cells = <1>;
+            clocks = <&xtal>;
+            clock-names = "xtal";
+        };
+
+        power-controller {
+           compatible = "amlogic,meson-axg-pwrc";
+           #power-domain-cells = <1>;
+           amlogic,ao-sysctrl = <&sysctrl_AO>;
+
+           resets = <&reset_viu>,
+                    <&reset_venc>,
+                    <&reset_vcbus>,
+                    <&reset_vencl>,
+                    <&reset_vid_lock>;
+           reset-names = "viu", "venc", "vcbus", "vencl", "vid_lock";
+           clocks = <&clk_vpu>, <&clk_vapb>;
+           clock-names = "vpu", "vapb";
+        };
+
+        phy {
+           compatible = "amlogic,axg-mipi-pcie-analog-phy";
+           #phy-cells = <0>;
+        };
+    };

-- 
2.34.1

