Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0921F78D229
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbjH3Ckb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241733AbjH3CkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:40:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76918E0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:40:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5008d16cc36so7934629e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693363219; x=1693968019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eftHGQRECzJuXi1OVtNB5hDXhj+Beyk7gIuR4DJasbs=;
        b=KtJQ381XdR/dLR82WKVphmKPHBuJHAAAk+Dka+MwxRXy3IwpOCt4Z7sLyjnaE9l3oL
         lNxC1CJ9a867vEvK2XB4WBlrnR4Z7Kq90DlAbgdbF2lp2uBAG3/npTh7X2TC90rKxlnv
         x/skRaqP1RuWI3XZv0FdbVpcxOwh3ZQ8remZe5SytRreOzPLyakqvmXJB5m1VNQadQv3
         IR8IMGvQHKqfMVn+KWbxuKCW2WxbpdGhAmQMy08g7deZ2uasoWMCIxKx9tLSanFvviFS
         0rC1pFAoEHZHmfcXzuc4S9CI7jYRvkFD17Hsy3r1mKGE+kqsG4TffmCFwqpAJADSNBCL
         ERZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693363219; x=1693968019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eftHGQRECzJuXi1OVtNB5hDXhj+Beyk7gIuR4DJasbs=;
        b=BiIVo8KHzPqpdWZYh1dFOpk0vRUoR3OlkmPVv1tDaW2kPJ5PFj/m+n+yx7APM8LHXX
         VWkzubY/vDm5VOQHJFNNkrOR9vFUiRbEKtJPhFLHe7kwmiGiMwCGE7MN+QSUgfSVaCIY
         YDne8bbRCez322FBinApPw0wzhCiws0k9TFh+KIKckrSD2XRJbsNx/hYEMj22A3Z7TwZ
         CPfugH4lXAZ2wH9FqdT5YCk97nZ2fB+/o/Uz15843xn7Bs94MiDx7/zraNMJ2TNvEvxh
         7HuvO3UBaBtR5uPA7ItYG3KgLRhBTLXN+kcMGPz2s74Y0pk+xD5qlw9TOjQUHCpNQ5Ri
         oC/A==
X-Gm-Message-State: AOJu0Yx52MVojDTMWaXFCQqDd3yaFd4uu5MpBxKLZFXkjZnJOYj1eSgX
        2vFOOFjP7Fw8tCKsHTVT/cbiPQ==
X-Google-Smtp-Source: AGHT+IFHf9gBoE1ACeP5RVIgyVWnmxwTQm1ACDYzoey0sp3f/Y6uJkIWgpkT86PBWwx0PT6aRJeXxQ==
X-Received: by 2002:a05:6512:368f:b0:500:bf44:b2b6 with SMTP id d15-20020a056512368f00b00500bf44b2b6mr406324lfs.45.1693363218120;
        Tue, 29 Aug 2023 19:40:18 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id w7-20020ac254a7000000b004fb99da37e3sm2183878lfk.220.2023.08.29.19.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 19:40:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 30 Aug 2023 04:40:15 +0200
Subject: [PATCH 1/4] dt-bindings: phy: qcom,snps-eusb2-repeater: Add magic
 tuning overrides
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-eusb2_override-v1-1-ab23825385a8@linaro.org>
References: <20230830-topic-eusb2_override-v1-0-ab23825385a8@linaro.org>
In-Reply-To: <20230830-topic-eusb2_override-v1-0-ab23825385a8@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693363215; l=1464;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gOCoteo3eQFlsbrCmDlbDQsd6KpyGXjafi9HiIGRkBg=;
 b=I1ZTgaIC2oul/Cky4mzGoprgT3MxHSMek90ddaxpeFmCCCti1/S1gJ/cYPlRgCg7X23/Efw9k
 oZB5EyI87n3CD7c8+a1pi5LAwKjFZirypeO0ii1ML28JEmvoAHi1ABk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EUSB2 repeater requires some alterations to its init sequence,
depending on board design.

Add support for making the necessary changes to that sequence to make USB
functional on SM8550-based Xperia 1 V.

They all have lackluster description due to lack of information.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/phy/qcom,snps-eusb2-repeater.yaml      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
index 029569d5fcf3..83fd6f936bf9 100644
--- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
@@ -32,6 +32,27 @@ properties:
 
   vdd3-supply: true
 
+  qcom,tune-hsdisc-value:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: High-Speed disconnect threshold
+    minimum: 0
+    maximum: 7
+    default: 0
+
+  qcom,tune-iusb2-value:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: High-Speed trasmit amplitude
+    minimum: 0
+    maximum: 15
+    default: 8
+
+  qcom,tune-usb2-preem-value:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: TX pre-emphasis tuning
+    minimum: 0
+    maximum: 7
+    default: 5
+
 required:
   - compatible
   - reg

-- 
2.42.0

