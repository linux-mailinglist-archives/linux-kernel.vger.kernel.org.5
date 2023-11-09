Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B146B7E65D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjKIJAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjKIJAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:00:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880FA182
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:00:15 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a62d4788so797385e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520414; x=1700125214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rfvt+EmrHZv1zbeX+XtXPk6Fy/0gOVGXRVeJ603Il6c=;
        b=nJZ+K51gzWEXCx3tiayEPNivR1ez+61fwrz3Ykey0+1P2wm7ghFmVuTUz4vROTMLJe
         QNix/Vpg3Vrn8y18tI0cGPXnLnAhktDSQljkjd024vByQxhgs5tPdU++NwcyWLrnc8Eh
         nEmhQ9mrB2DG70MXtcNblTcyeFCjNb7hmGA8nsph7ZWu4MR3RHl15VJAg0eXmUCPdMkE
         4qFQfRW0KmrSot8UVsRFXgNDBxdHyJwnZVXlUllaPigJ1jXknC/kjjDDIz0RKAkE6dU/
         tkvSUbowfRiRT5VktlvEpFoqwY+fSiJ84507H+CIzNadxaJ6mAddipmhP/uJiid+XrUY
         nlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520414; x=1700125214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rfvt+EmrHZv1zbeX+XtXPk6Fy/0gOVGXRVeJ603Il6c=;
        b=SpRvj2kAHPDcqe/0lHM2gDuOLuS0IZ/ZlcBM8guSqx+ysTNNYVFnrYou3HwkNIb7zJ
         fHv3N1CZDhq+IR2bYvJ4Wh1v4mHFlSs3edQ7oNNhIrV4qU5Efc3nAB5lOSrkslaZmT/f
         vKXVEVdtRyG2uYrI9RaDgrevTdejh4gm9nP1f+Y3htQA6MYtn/kRSPS5FuivmDxndHzP
         U7xfL+IQBeNVm5ZF7Pb0d/YWxnQ4f6uMQfPWaUX/CHLy5mLS2vsPsA8E7bq73FUEFKXs
         lSzwFDcZVtM5GVGTWqjc+39FRtdfAW6XUTF3mA+eCEHeD9Aa2VRSIPh46FkpCc1QBmk8
         3sMw==
X-Gm-Message-State: AOJu0YyWM9K3vp4Nw1EexS5fYQTP4NU1HVoL5SRKMsCHCexaY04RGW5f
        nKNMxs67zoftF5gMsnVc24/S8A==
X-Google-Smtp-Source: AGHT+IHbarTLeXs1xRLnlOEthFHXQkLlQGddJUwWyZGyU3T60ayER/TL09SkJXBO48qJCeZljgsIWA==
X-Received: by 2002:ac2:551b:0:b0:507:a8d1:6e56 with SMTP id j27-20020ac2551b000000b00507a8d16e56mr833623lfk.35.1699520413701;
        Thu, 09 Nov 2023 01:00:13 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b0040472ad9a3dsm1428484wmb.14.2023.11.09.01.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:00:13 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Nov 2023 10:00:02 +0100
Subject: [PATCH v8 01/12] dt-bindings: clk: g12a-clkc: add CTS_ENCL clock
 ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-1-81e4aeeda193@linaro.org>
References: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org>
In-Reply-To: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlTJ+VapgP8WHcdrQgPiETykwQUlKVRqJ/4wVyCchQ
 YXz0F9aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUyflQAKCRB33NvayMhJ0RxQD/
 9C5ZGRPwcExahOsQp+FbfoxjpmIQhQTF166bZMrK4X3DXIHdj0XEIJf/stW+d9s8ZED+E350vg/VsN
 R5OhSGMemZL0MEM4w7cjd3pFBN1RXfzpt9UtYGdxkppLZsu/SgvZTnk+q7XTdimznCiJSl0+E5t4Wo
 R2/R7NbBSM147jSdi5bBeuREcm1exIjb2l48Atuw/a5Ab6EVXu/5nB4ieAkIpDuLLUztCGY8Pk118m
 yUKm8QsIcqitnSbhrG1pOnfHVmGPpptcLSxZPoG7P0eIJX2EcIFWz+kRo7VKBJpivZ5OJ+KnLoyD4r
 GI/QJgiVg7cnWNLkw5e+IW/9VCcxsxVcqXOzAl6i2f3NGq+T9IgsJ8I03z5Ppd3do1WshntIh4YMvE
 gstl29N0lvUGXR0jo3JZ3TVCMSwinf2AUgLS2oibuDIY0k3kdGG3ZuRevRpxjE/UNxSWWqmubUEnTd
 KtBi/TH3ACCcAsGTGh0VX7resg8xpbrCS7jFKxz3JEVMGa8wQ9Z9zNUcyizV/IvVu911b4KKruocfe
 DhBLWNPgLVBn2Xl8cAXuQJH3Jmz134RfvYj0UIzLHdbyrTkOB7RIOPUABuwP2jaTj/nD+P2F0OmKFm
 Ul0YEj/8PhtnUUoDwHdpk51cLMTTq+YhdJsUqgkgsOND5UV3glOI14ooO0ig==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

