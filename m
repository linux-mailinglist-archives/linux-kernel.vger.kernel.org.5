Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FBA7F43D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjKVK2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjKVK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:28:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FFD100
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:28:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so7475758a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700648908; x=1701253708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yT3SRC7g0WcZYpUlZzUhhdSFSVdcOgnIRd9ofgqTgO4=;
        b=vZlPKGeiK4tOm/AOzropggrcX3qFB6/9kbTWmAd9NC5HiJjiyVqTYDE9Z/aeq/8i4L
         aFRQlLplaeI0iNfCgwqDaifl4WW6Ci13s/lIaB1sBNYlus9qZRPQDKkCnvsZ9XLMKme1
         ZC02CgA3Ux+5zTQbvtvhO9QT1T1ALM2JQdAYe23qRlH1VwWrXKz95xgrrsijilvID2oJ
         E4xoBgUDvj+uqF4Sq8tCZbg8zpAikFA1RZZW1SUi+1NnK4Quo9IGSXSOs6sYQr3Lxzul
         z8yRYjLWZ6HWIF4r274pjpWsylnz2Il7zn+PoLLjITCrvW4Xld4WJ/dCADe/PfB3drb4
         QGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648908; x=1701253708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yT3SRC7g0WcZYpUlZzUhhdSFSVdcOgnIRd9ofgqTgO4=;
        b=HFZKbdJq4DgKjs8ubdA4jtMmE1KAZ9vv64d9TTCA65dKonkO535kNMx+5VeLSzwBMC
         j9BkvGF8rAwxUXAE27vRl1etjRDcjoXqrifl0vH4PFD84Q1XJQHU+wr28ifG9VqrUqKW
         dCvkPvn8JSJbnaxCCRZaqOuXMRAKHEWwFm9VUfA4X3V+GijtziNIiv5kEAjr2/u6oTDb
         xSCY7CHYNWKTHHvArmd3Jn7jPBdEL3Trw3i0g/MiBQs7YT/tEKIJMs4MvOhSpMISe6IN
         B+2JDRmp+N+KMTaG9gf1padncOM31bKX45smvnXCHJ8L6rIsG6xCiBIU9OWCUPyfAMM8
         /nRw==
X-Gm-Message-State: AOJu0YyggawwRVY7RT3MdBfcP4sRcaaaF0WekLXGV59dUtAmGNGVjtO7
        w+9u68yfrcCuIc3e4Yzoio6wCg==
X-Google-Smtp-Source: AGHT+IH4SHXq9mLdJwRDXoIJrNJUO5jXfmhoDNQ04drsrbcIGKENJlqOxtY8YoZElmIN+W6ReMJdhQ==
X-Received: by 2002:a05:6402:31fc:b0:548:5272:db61 with SMTP id dy28-20020a05640231fc00b005485272db61mr1534067edb.15.1700648908068;
        Wed, 22 Nov 2023 02:28:28 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id e1-20020a50fb81000000b005488a15b25asm4325139edq.70.2023.11.22.02.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:28:27 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 22 Nov 2023 12:28:08 +0200
Subject: [PATCH 1/2] dt-bindings: phy: qcom: snps-eusb2: Document the
 X1E80100 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-eusb2-x1e80100-v1-1-ce0991161847@linaro.org>
References: <20231122-phy-qualcomm-eusb2-x1e80100-v1-0-ce0991161847@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-eusb2-x1e80100-v1-0-ce0991161847@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=RjZWUAyEQH5jFz7bbSGKTtE999rrt7usdRU8o7GC+Og=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXdfHL+hyf1BeyziIAVgHIH/EWgwBzsYhPvxyd
 mJCdGU5wXGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV3XxwAKCRAbX0TJAJUV
 VvUiD/9Lozo7g4i3DLoFJIaW2U7tZZJZBp8AvtfEH6IQdCphksxxyrI2t0yXqKOj/hwR/Rijt5I
 G+cJEQB379AvQFoTXcAaE5b7/39aAKCINV8ikvK8B/9iZjtJwkWD+JwieH2b4zKi82h8BCwpBsX
 dN+m+OpD4NYRq5yogBf2MrP2gP2VfA3D2zJd6tPHDlZKknzeiborAk3gA9tOdQdbtfKn7jrNgeO
 uoMc3naEkYG66uo2CVf4pQEkUNvc7e98/B38WZdUmiDK8ejGRDEicgdm//e7OZ+aXxTbDkKXF9X
 wIQUSwMXnp0fqpNLjWfTw/BJcpLqmmQe2pwgLF0ncFlj431y2qdPlszp5qujyyqgw3MgwulVPyI
 gFnYSu0Nmt28gnaquujig/ufAED0w7+MFmpAHFfWEXCqJxTgCtQtwTxf0lnHuk/D0u1opas5Uk/
 Uoz2GDadqzbw9NWiMAXWZrkAAdjymkwZbV+fWUVuO/IT/wuQbaewDxn/zqG1sOnZkN0gGELI/7U
 1rZ7LApfJEQMxgZJ4qiah7dMxdmrluozrjUKiwKNrAoV2ypMLWljY7vEymAMJSm2GHlM79NaEeR
 TtQ4UP3ZdITaIvJbh+rriWAgGhxQiGSrzsAVvpIM221R7M1wiVFTlC2LubgN6mmKylSabR8Szip
 CYsvDf2mvr7H2Gg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the X1E80100 compatible to the list of supported PHYs.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
index 8f5d7362046c..ea1809efbf56 100644
--- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
@@ -21,6 +21,7 @@ properties:
               - qcom,sm8650-snps-eusb2-phy
           - const: qcom,sm8550-snps-eusb2-phy
       - const: qcom,sm8550-snps-eusb2-phy
+      - const: qcom,x1e80100-snps-eusb2-phy
 
   reg:
     maxItems: 1

-- 
2.34.1

