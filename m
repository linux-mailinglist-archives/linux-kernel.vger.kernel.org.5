Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4476E7A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbjHCMEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjHCMEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:04:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4412D5F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:04:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe24b794e5so8831895e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691064245; x=1691669045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rfvt+EmrHZv1zbeX+XtXPk6Fy/0gOVGXRVeJ603Il6c=;
        b=MyHUsgRRMHSkZ6qLbXroIG85T6WWK2ZHKgoQEtUUZ1od5FzypfMMuLf2df2pa9Ns0d
         0RgOFw8RC8NzLVUWkTHp8sEEJuf2pMQ3njOFjsjfJ2+n3woo1xFIiDVQSAQPXIjK13fz
         y/4Hzbf1atwfzMbiE5rKvMful6lMlBkSpgXAwjCL2vzV4WgS+6raJ00j6qBFYciWIlLV
         iv9Ga0x1KWd/5GgEuVQFVuUItjfkUqQJAyuy41U7wPZJDAKwVCOixSy38CUX+UBdeJE5
         aO6vSLt4ZSYOEXnDd1KMmO6dXXMilm71qTKRvVMazm227YmgO6PPCnjVIPykA/RowZty
         M3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691064245; x=1691669045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rfvt+EmrHZv1zbeX+XtXPk6Fy/0gOVGXRVeJ603Il6c=;
        b=MU5MexHi91XxKhADsFuvB0/UF71E+z5QtC4OKu8febHvD/WKPg9Vzb3WEm7c1hPqlJ
         b1JCEY71TuzAUaNCxU8B7UxlP5rFx9PETWvoQJypJ0XIeP+Y0oLo1mQ7Seu1MiGdSFX3
         BFXuVgHd5YZOTpAWTXwKlkFe4biN5Z6kYjDSSOgcwWygY59ItFi8Hxnj/N1F9Q+89ZIS
         RVfdtBUBVBR9ciIcKEGiH2ic6pN0EpLWnSxB95VFvQWFfJIzXfpdbKt0JLzjBZNrKOqi
         VNgCdPQgCWyGMj8SLCwmqRRZzFXpcydtHaGF3IywRz3OQCpIodKDvQJZdqR9vEmdyWWV
         kUdw==
X-Gm-Message-State: ABy/qLZykiU6CwJMZsVhDciI6chYiVL88rtdiQu8R3UcR/dqlVQ3zFXL
        kj66JLV9Nsgr+VjOdctjU3EWApppfypvBKne1G6U9A==
X-Google-Smtp-Source: APBJJlHyl5WYI6N8c8ajSFmQT4ZqGANnisyCQEfMYfWWz8LEKIkaPLA4Ac14e/Ko1++3dxrq9AhIaQ==
X-Received: by 2002:a05:600c:282:b0:3fc:85c:5ed2 with SMTP id 2-20020a05600c028200b003fc085c5ed2mr7182732wmk.11.1691064245559;
        Thu, 03 Aug 2023 05:04:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b00317046f21f9sm21487465wrx.114.2023.08.03.05.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 05:04:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 03 Aug 2023 14:03:55 +0200
Subject: [PATCH v7 1/9] dt-bindings: clk: g12a-clkc: add CTS_ENCL clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-1-762219fc5b28@linaro.org>
References: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-0-762219fc5b28@linaro.org>
In-Reply-To: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-0-762219fc5b28@linaro.org>
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
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=761;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OBDzXE6zqX89kc7pvzy4CIEH7gf5glqDzs5WzIgtsF0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBky5evPqlyqm2PHjNKCgp/BXcAaRArzuGQt1FzLmzh
 IYCgxKSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZMuXrwAKCRB33NvayMhJ0TAlEA
 C8/B9GuS3bdWQiUB/DwPVUIrv6jpMVkEuWwOY+3i31cD13nkHcb7O4C6Ld9WZbE94JrqeKg0/t9+iL
 JsdOzdf6971IiUC5SwHTtSVEHjxPbFzkOubk/eeoTJkxGRF/MsYM0iAg+rvNzbeTaxVF/9AtKrwriM
 9OzyJBguvh9wmnESKYRY0cSLznjvA+GxVDPHIzAYHDPLX3LJJ0cfpAx8JjEzx0PNWRjww7FGpm+zVa
 FYfy9EDQ6OQ06WQo9vNfskyh5SCBTWnFLvZbcb7/t0v7xncEuhNWtJvuyz6tWYw4yp/oFcmGXgjSFv
 aUqluT8S0r4sfNH/DGkXvBBpzHMbaNx7Kbdl+eyrrYjP7yu5h+Ig8urwtnW/qiu/myoj4DhwUQwXGo
 poOC5lpwnkbvAiFmFe3FGf8Hr2SEWuCelnjhfN8yBVKfAYzpJFN4jlCwUid2B/XPT0LDdnTjSnKmOC
 mzH0kUPdwR7m0g6eUYMW/wEpW00uNwDQgyPbBViE/hZqPg1oXFYG2e/5f7MY7VeQr6IWEq8XPJg7aL
 2XYlxslPMFYDCrDabsNy/o5baT4C26V/H1IuYCheOZeS/WHq2kd392DxMb1XwS+Cj+5FsMbJJnBaMh
 fjX9Kv43/zWgfJnIkL1GE7S7hAnc43MbnztJ7+TvF2D9S0bWJ5X8vEOlMhrg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new CLK ids for the CTS_ENCL and CTS_ENCL_SEL clocks
on G12A compatible SoCs.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/clock/g12a-clkc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index 387767f4e298..636d713f95ff 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -279,5 +279,7 @@
 #define CLKID_MIPI_DSI_PXCLK_DIV		268
 #define CLKID_MIPI_DSI_PXCLK_SEL		269
 #define CLKID_MIPI_DSI_PXCLK			270
+#define CLKID_CTS_ENCL				271
+#define CLKID_CTS_ENCL_SEL			272
 
 #endif /* __G12A_CLKC_H */

-- 
2.34.1

