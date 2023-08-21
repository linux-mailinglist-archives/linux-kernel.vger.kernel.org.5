Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F85B78249A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjHUHj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjHUHjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:39:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03EDBF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:39:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-318015ade49so2726471f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692603561; x=1693208361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVufyxAYBL++eZVUlykUJ1x0R0a9PMstCFmo4QvbcTA=;
        b=cIZTKagVwDPKGXX77aD9/XTsOMIjLVfSVc47JDGUaEFSel1MARicUEpvvURgKgq224
         kfxFYno89pHytrfcNh2EHznjNUrmtBnpGmEbX2f5Di2UswJj/mH2aewGD2z6LMl2S/sn
         I2vjvSr18YuatjawenZpFUd8N6RhmrnJ+W6HelISThX1WOKfRgqrQ2wXuKAsXEgWSqD+
         MnEdYBpbgtQ8pAYbHSqwXHeR25gpYaP6Q4EZK5s+tfqQ5Y1RP9PDYiNXZckQ/HaSv773
         aZxL/PZkaIPxk3w7Aqazv/JV/XVz1TihP7SUXFO2/5r/vd8N74lQ9zmyf/aK5C2Xt4MM
         HVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603561; x=1693208361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVufyxAYBL++eZVUlykUJ1x0R0a9PMstCFmo4QvbcTA=;
        b=DxDRZUct+LCozi674ukRaMZcJv7d3w8eU2SCCjT2pVJA3a32WXiPlT0SfQo3DVw1/W
         rdTY9J5sLWxOu2HqvORaKUEKoK7z0AGu2GYuq5sPNqhcofzn93eeTPvDtAuwRQl/EjK3
         sDd/edxPV/rMZzq5doLma2T5N1wpK0uCeGkClmELKM2j5sTTc7N6jDqYJ0zldXqSF1aX
         DtdSLREe6ncj/RGBgEHefoFidGQtmJi9O7Q0uQ49eUp7/DZDRZsikHuX2YEkqVb5Wk4n
         9Zbp/xo+Zi5dC4z3OGGL7MQiDGMDByohc0r/i4hDVr7EMq2RvxdjPykqLUejAD8ddAUb
         t7Tw==
X-Gm-Message-State: AOJu0Yzrxo/S8ibUNqLsSA0GT6//5qfWv9rxizXD/UdSKr/YkxviYrTs
        T0SyLBAO0bEvYU80rVcJjazanw==
X-Google-Smtp-Source: AGHT+IGrW00vzvXSCby9JKkbYSn07645TjnnEE8yKtUu82a7WSxUOx3B+bthCMnv3RQsRwwPsDPHKg==
X-Received: by 2002:adf:f64c:0:b0:319:77dd:61f9 with SMTP id x12-20020adff64c000000b0031977dd61f9mr4249069wrp.35.1692603561093;
        Mon, 21 Aug 2023 00:39:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d674f000000b00317909f9985sm11389092wrw.113.2023.08.21.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:39:20 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 21 Aug 2023 09:39:13 +0200
Subject: [PATCH 1/2] dt-bindings: cpufreq: qcom-hw: add a 4th frequency
 domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-1-2d4d9fc828d8@linaro.org>
References: <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-0-2d4d9fc828d8@linaro.org>
In-Reply-To: <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-0-2d4d9fc828d8@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jKlBHtKi3gW02O/NbpPoTCHgDY1ty6crZ3hgpGsk30Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk4xSlDwelwVnLArZb7xK2SVY/I3wqr9q+YG4TtOWv
 BP+8GYWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOMUpQAKCRB33NvayMhJ0aHfD/
 0Y8+SGzMuwDXiWVc3kvFV/saDoc8xNbyyDSlPzXBFBBGqip5qtkNe8M+jvX0A812UZZa+A9uR3pVkB
 EriWluSi8Trp7GBeHMSAPS1ekbpBQ0NSZr4+fgVA24pNpHKlPC8rtJsozbuWiZCDVQnMWdpYC0h10Z
 2DbuiCdcwHJrJ0N24XoW1u1853C+pJW+F0S0mWP0zknvszCgpye2IS8AOXNp0k20aSPrRQhPCi7t0h
 Bxe1ZgxGRcGc9Wc4YkFv65XYBANqlOyXdIRT7d0ZYVcOw2j5EW5iZwT2OCfyvRKsSJUmKeIbdqr4m4
 k2ijOu8il25amSZ5nw562O2Y/d4heq4MEvSr+YJYAcUjBFeBwlKwYkqDS0+kHzlVvO1S3U/R6nFmTy
 rRLVR/XdTAwdJjW1tUWavq+ioAJp3VFTLdQgafy7M2Nz/4pSbhRtToiODIo/CbO37GOHyPmuMaBA5u
 Edyz4gwvnrk+6kIUsPBQebknT08At2W4g1VnOYQlWGYVVlShU64TGQhtOcMDUKQ3aI2r4VJzNfYGG0
 wxX7e/SMvnSZDsyIXEwor9voK96f05yQREoTNFIM6Z+b7Hoqx7mIJje1E34rJMCYQsI3u71N0m9DqA
 g7Xr9HYN+89hwmspaiYltlpRwf4XOXrOvKMIs0zXq4wJv9z9aseICFhj9FwA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On new platforms, a 4th frequency domain is used, document it.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index a6b3bb8fdf33..c1d225fcf2d5 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -49,6 +49,7 @@ properties:
       - description: Frequency domain 0 register region
       - description: Frequency domain 1 register region
       - description: Frequency domain 2 register region
+      - description: Frequency domain 3 register region
 
   reg-names:
     minItems: 1
@@ -56,6 +57,7 @@ properties:
       - const: freq-domain0
       - const: freq-domain1
       - const: freq-domain2
+      - const: freq-domain3
 
   clocks:
     items:
@@ -69,7 +71,7 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 3
+    maxItems: 4
 
   interrupt-names:
     minItems: 1
@@ -77,6 +79,7 @@ properties:
       - const: dcvsh-irq-0
       - const: dcvsh-irq-1
       - const: dcvsh-irq-2
+      - const: dcvsh-irq-3
 
   '#freq-domain-cells':
     const: 1

-- 
2.34.1

