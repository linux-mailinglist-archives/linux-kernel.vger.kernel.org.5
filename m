Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB61675DEB8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGVV4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGVVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:55:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5E41FE1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:55:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666ed230c81so2929311b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690062958; x=1690667758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0JNllw6YvIs6jSDaAjTSNP2MDXmmerUxHA1NZNjLJQ=;
        b=uZOWBr3aaueto5xP/qXeJbRJbn0+RTbLPvbcirdo8Ffeagz8iCHCs+N8ScoNHKAR+j
         iv4TW4KcTuonLswXb2c/PkmJFpFz51Y3imRmpVFuuKnFswOgLZ97viYAiiJ4Q0PTwdTw
         Tysdox8ZvktE++Sr2PfauiPWVX8v2zHU6mgY5LM8KWK/GpUNh9BCdQfwS2UEMM/ramYo
         k19nJzbUj3EnuH2QLDWmB8eTI+WDcl2vhDjgvM7/P6n52YJT5yO6FX5jCc/EBOIb8gAf
         HIxVfm0p3fEwMsO6wheT1oEYzOJZ063bH0eLjRElS4MlqAaA2XPDPnb7VWbdS30u/AsW
         ENXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690062958; x=1690667758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0JNllw6YvIs6jSDaAjTSNP2MDXmmerUxHA1NZNjLJQ=;
        b=aoF2amB516qzEFxqGG2YHkgvRj504R+Z0rIqpNFUNFyTAcrON0qrDbC+RbMT2mXnp7
         fWz8vw6ckM93hxUBv+TCFU8AC2ZX3UIDxFm7FrSFCVUvGt4M5J3TPYopVJYlOReYEEDy
         Dq188jRE6hK3NawsqLJmqiR0Q30sYBbUWySN+JfqUN7nykjHHYcr2g5MjgcmwbSe9GWC
         ALCAHRePC1MuYo6xuvUevkR4FFLGlftvRTDLmPtTPhcF0DSL+9HyMpWrfWDIFQDgf9R8
         5gqdLoG3fz8a8SJsErWSDPOdWoVuwEeT62gYwy4VQBXwQmbnUlgCUSmfTafFlidBrN9v
         AoeQ==
X-Gm-Message-State: ABy/qLYda7d4Q1zEUuSKlAutvMoVxUrtdxpCjq32bP5sLEIe4acYs2NA
        F5DVvgYuin0SAnOyhbphrVu2qQ==
X-Google-Smtp-Source: APBJJlElPqAGVAXFzDAGu3qSK+Asy0AZaCO/U/XwWIwm+ZAhMWhOE0kKZtF1s7sCXUOlBljg7Xj1Mw==
X-Received: by 2002:a05:6a20:4310:b0:11f:c1a1:8c with SMTP id h16-20020a056a20431000b0011fc1a1008cmr7856875pzk.54.1690062958091;
        Sat, 22 Jul 2023 14:55:58 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2a8c:966f:392d:7230])
        by smtp.gmail.com with ESMTPSA id e23-20020a633717000000b0056368adf5e2sm5517642pga.87.2023.07.22.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 14:55:57 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Sat, 22 Jul 2023 14:55:40 -0700
Subject: [PATCH 2/3] dt-bindings: riscv: Add BeagleV Ahead board
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230722-upstream-beaglev-ahead-dts-v1-2-ccda511357f4@baylibre.com>
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690062955; l=897;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=tidwSbBXYqHL7QLAqHRbgz7GOIH+ZD2CBcsPW6ALH0o=;
 b=wz/iUY0XPRM3CLWBMCPorTf2YRAlE9UOWlPEJn/mBs7UuUiP3tnw7Af+gWJgqGvnZsWKUs+kR
 DhcA5sk4jxGAvZnmBVkpD3MGrKDWSCq19X7IMgs2NpMimouDBVKAz3E
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible strings for the BeagleV Ahead board which uses
the T-Head TH1520 SoC.

Link: https://beagleboard.org/beaglev-ahead
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 Documentation/devicetree/bindings/riscv/thead.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/thead.yaml b/Documentation/devicetree/bindings/riscv/thead.yaml
index e62f6821372e..3b8b24812a24 100644
--- a/Documentation/devicetree/bindings/riscv/thead.yaml
+++ b/Documentation/devicetree/bindings/riscv/thead.yaml
@@ -24,6 +24,11 @@ properties:
           - const: sipeed,lichee-module-4a
           - const: thead,th1520
 
+      - description: BeagleV Ahead single board computer
+        items:
+          - const: beagle,beaglev-ahead
+          - const: thead,th1520
+
 additionalProperties: true
 
 ...

-- 
2.34.1

