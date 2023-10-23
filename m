Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528687D2D89
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjJWJCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWJCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:02:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7638397;
        Mon, 23 Oct 2023 02:02:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98377c5d53eso428202766b.0;
        Mon, 23 Oct 2023 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698051758; x=1698656558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaSNLjd6qp2TTeM4lQ0nSQjwYYZEfvjgfhn3UAjO2Dc=;
        b=BIA6n2Er/gUoh8IXDlAXlhQUmbh2rFUL+mhuKOgyMSSF0InGHJTd5IY+WFEdgE7cpR
         Jar9K3lAPdjuERT8W2owjhVDBsl5lDWDSQERAR8oFe4IFz+RhCql7ax56tG1cVQG4iv/
         hfw8F+Fs0HQAB/ensbm/cj5URzauI6IF4yZyDCoHow5F+qCrBsjwE/zFyK32m4HP2znM
         AWoWiuG7NwXD3RhWsNS3N9tp2MuksFyPPt9vS6qMMz/QeAah2v9sC0kjVbpLk75xdwYy
         2zVEQ6eLdCvmYDIRBOUNZ7Q16I3KbijCKVKjotTdWU5/50Nolqb0BPNc0xVBfJxxxE2+
         pSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051758; x=1698656558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaSNLjd6qp2TTeM4lQ0nSQjwYYZEfvjgfhn3UAjO2Dc=;
        b=sIN07DIvXP4ETKDQ9iJNbpPmIF+b8BCywl3Mxq9JIGUeu60ya/rNXvW9v8ZBZmyGya
         8Y/JKZvMASuoU72Ruczug55loDQyrDOOwxYwY+zS75NFJnw9kkW2t3H/sbBpItmvvZar
         oLx/dBF8gg3fJFZm1he0VJVogmnkwyn9y80PKEpNCa40UdbQzjah7qXHahc7DHgzH/Yp
         duC5n0088UZKdHx1pZyAaAArwsZ7Ny1poOkE5nPDTb9Zt8TUly5xT27W3t+WC7acg2Oa
         GhYgWE58lqphwKo/l4Lf/FyTnzdOUD6WOQdpsaQYVmQHQoT/njGRIb0e5lyqNjvvowv2
         L+aQ==
X-Gm-Message-State: AOJu0YyT35umysOi369Ttd7lSxKv+MYnwctRlVWHzYhdrgIQNx6Hvlz4
        r/TMkNVI+NS/+6JkjEz/l+o=
X-Google-Smtp-Source: AGHT+IEzc+1DI+ZcbZbo3aWCLNDTe65vgU8MirpcnkiY1TwqFwyjVUnjpu1zsDvj4Uq1uSkly+nDuA==
X-Received: by 2002:a17:907:7da9:b0:9b2:982e:339a with SMTP id oz41-20020a1709077da900b009b2982e339amr6866306ejc.22.1698051757412;
        Mon, 23 Oct 2023 02:02:37 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:3344:1b7d:7200::eba])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906019400b00992b8d56f3asm6326555ejb.105.2023.10.23.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:02:36 -0700 (PDT)
From:   Luka Panio <lukapanio@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     Luka Panio <lukapanio@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 1/2] dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)
Date:   Mon, 23 Oct 2023 11:02:29 +0200
Message-ID: <20231023090230.43210-1-lukapanio@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for Xiaomi Pad 6.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Luka Panio <lukapanio@gmail.com>

---
v2:
Update commit message

v3:
Update commit message

v4:
Update commit message

v5:
Update commit message

v6:
Update commit message
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..1bfae1b237d2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -965,6 +965,7 @@ properties:
               - sony,pdx203-generic
               - sony,pdx206-generic
               - xiaomi,elish
+              - xiaomi,pipa
           - const: qcom,sm8250
 
       - items:
-- 
2.42.0

