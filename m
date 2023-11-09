Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5737B7E65F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjKIJAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjKIJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:00:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44134173E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:00:21 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507be298d2aso768916e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520419; x=1700125219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szbyE8B5HmerWTS9QCGM8GNA9TtBAZ10zn0t2kxJOBs=;
        b=l+hCgeJ3Hep33tzXsQu9ahEgX2G90qVKheK2+NPfmlKrKM7dVLCXDUuEsGYbRoTs4P
         sZmEDzmebQ/aV0e6nnlJzEtfyQYvFHKr4Ity+9hEMmcNNjGlplorUa3NXUqf9hQio1Fo
         xsARQLOqw3Q/D1l/bQ17Q0v3UbJTlBPZ1wqpRw1sNmLWOUu1ThhuIQsbObDV+lrbdtFa
         uKIus+8Ac1MxemLpQqx6B1bXhS53BR5TNC4N7aYXicVA+0sie5fFm/+tTDQPYVevH/lU
         8olMiW6nm4ZA7d9NeChirI/iZQBCE6zX0RVDvE3Gt4I2bTSmrEv91UgjQ5HS5jF1v5oA
         0dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520419; x=1700125219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szbyE8B5HmerWTS9QCGM8GNA9TtBAZ10zn0t2kxJOBs=;
        b=KWW7kVhYePcFOgFdqU8q5epqnAYY3tS9Onh0YwgGoZdRLFW9OTp2ZMzfPf4iTi9Orb
         128gEZ1zP2LLztrETifFow8NQbZAbp61GQg4YoeLorMM3yYcb9F3A1Qbfz/P3/mqR4wI
         FOCRloJIUWxgTSxb9Pugv+3VRa8QhOHeMOwel1mK5iuhEPdwGXbp5AxQ5SKe5FV7n/mQ
         J9HrT8m0kFNJiiI7vBVnEkupKqaE7icaKHCVMnMefPYv5wA7Rq+pAt+TjGYiZvG8X/s2
         brO2RevK5+a3ilbnRlpuOX5aqu85qSOiLGCOMwMUEzrQwfS0RtAYZeQ39ZkLRVdyV6yV
         91rg==
X-Gm-Message-State: AOJu0Yz7jImzyNZP4DuB0Wsuwb0lvL7AvuIVAKve5POhyYA4ilYadJ9x
        eRzkpB/viX47+VgmtiyuSnwOzg==
X-Google-Smtp-Source: AGHT+IHS6tUZm8jOoxmt7gLhfCx4bKpuATMzr2y/aX20jzVc0HP5QxgoQ9hMcisEW+40E1hCOQ92oA==
X-Received: by 2002:ac2:46e9:0:b0:503:3890:ca3a with SMTP id q9-20020ac246e9000000b005033890ca3amr700600lfo.66.1699520419352;
        Thu, 09 Nov 2023 01:00:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b0040472ad9a3dsm1428484wmb.14.2023.11.09.01.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:00:18 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Nov 2023 10:00:06 +0100
Subject: [PATCH v8 05/12] dt-bindings: arm: amlogic: Document the MNT
 Reform 2 CM4 adapter with a BPI-CM4 Module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-5-81e4aeeda193@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=886;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=dsHeljQP++qeke1zASpQ3YPnuH6eGTAu4r6z8mvmrbM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlTJ+XRZWlbUe5Rri8/LQk6vQMDR/N4E1+/QArPJOQ
 hDPKMSqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUyflwAKCRB33NvayMhJ0fZ6EA
 DKGXANe+GiL0Hty6vwML+EcHg/3t3bvOMWaCVnFG9FBVAF5J/3hzgAZUrtexB3iTxBxv1Wi/MMuZCd
 D0EIB7HroUpPGzid5eOt7jARPicDb6OkZO1vTf54GNfi4tzMGkGWWX9Nox2SzRokE+qZ6JQfcjcw3n
 xPIZMCZaczLGIhSpD0J4IDfGJ2B7txsxkeomBs26wTTz1NLegZ2YuDmQ4Zds9gF+5Ar7nhPEcGZqbI
 Ouub7B4/p/D3K5HYHXPNCFhFLddpfXPAqXp9NW6nzeDBBa6nJSqv7i/CJ4s2FqP85+jTcOnzmDWb4L
 X/A+WhvP8g9+SwI358niGHButCjVqyipLvgPR+2hYipGZIcIeNWivGBu3GgeX5moi/X6ISMsq+h0yk
 QJD2QkrquMFAEGWvdfKK3kcR/ifPtXpes1OPYSEv7I2catEfNaTS89Xnlz65mLGSOdkQm7kHDZqS5D
 Q0tYEdEUeYJNcfe7XfKMhSErO0ChRdkDiRWpDIxuIabO/o4ogXHF/ltLdpvJurBs0LvcMSr5cwwKk+
 Pz8nffeKLBAW+eq0HOmCYE2o8B0kYQDiSZvOQRHAE1nyEiOXVTvS0OxF1i0EVs4x0PcZMAxmN/yva8
 ny3mxnhepxPQesscosm346kOJPir48KLdIfA1jU8pEb2Tk+xgcoVaAXBT0Tw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MNT Reform 2 CM4 adapter can be populated with any Raspberry Pi CM4
compatible module such as a BPI-CM4 Module, document that.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index caab7ceeda45..2154a4614fda 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -164,6 +164,7 @@ properties:
         items:
           - enum:
               - bananapi,bpi-cm4io
+              - mntre,reform2-cm4
           - const: bananapi,bpi-cm4
           - const: amlogic,a311d
           - const: amlogic,g12b

-- 
2.34.1

