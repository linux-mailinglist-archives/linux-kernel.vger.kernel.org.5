Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD377D24FC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjJVRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVRi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:38:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90395E6;
        Sun, 22 Oct 2023 10:38:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9be1ee3dc86so362935366b.1;
        Sun, 22 Oct 2023 10:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697996304; x=1698601104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ulbEnMKrXKyGSmHqMat1kFkWd98phUcO15IDin4BJXw=;
        b=Riu6aTg0h/+a9yjbNsPkyR3ulN8YweAXg0GXIO4if3QeX6+AXPB808K9ggbCVqh3I3
         ykNJ5t8+ZyXon3Dgol7mTBgE7rlXYY2CKb4+3a3BbD7Y8Zrdh5BcTCWLqom/jIFDQwDg
         s/UZR+BcRDcSpQ2ZIMIMAYBjgfKuS1pUeoMJxTD7N4Ctjw6d1lBEs/HB6jl52aUZ9urx
         wM72qCg3VyGjMg/QmwYqtu/Cu6nF52OfU8J4eo5GuTT+Gd+nNlryJ85Pz2/UBkDOc8vK
         7rsUIk/9piBEn6I7b33LQPbxhPgqoAz5O9VmDLF2TamZ5JS/Ck7kga0CUntpaMTJQlFe
         7PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697996304; x=1698601104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulbEnMKrXKyGSmHqMat1kFkWd98phUcO15IDin4BJXw=;
        b=S9ttMyNvESDmhgg+0eC66TVsLDNNs8bY002vTZFFKgR/2N+ZWMwdxwL+n8BaU5+Bio
         /nAE7snKm2i8F9PND5YvfbQC8mKY68KAxdqjDW/A52BXUTBFljK20HV1H73bRx8JmRVJ
         OnRbz7i5e232t3OgsHh7s44TJ29zXGm8qDzaQ6trytFJOobfT1QMGwJefhkzLhxBgR62
         Dk08SOXSKjofTEPhK9TaaBoODg/CyJ4GxokyjZQXXEXOZ69MsLDvtUU8WGTur/hNdXwz
         piKqYkeM8gzr9K+XCnwK/aCesvXhnlyytizN98CvUEfXK0AXclOYhU9JFxyRnyIgZ9ro
         uD0A==
X-Gm-Message-State: AOJu0Yy5b2u6OfXIIWI4PmBJKG8ud17ngmhCfgHGR11dpA2BnCwkV80O
        6Vqs9dj/aS2eHpi/Ewq9Iis=
X-Google-Smtp-Source: AGHT+IEA32eEvxPEjVZiUkxoWYOMLHVizRvYePQzcTHQ12Xkp+AEiUE2zhtWesLgHvN6hsQnbX3R8w==
X-Received: by 2002:a17:906:fd8b:b0:9ae:54c3:c627 with SMTP id xa11-20020a170906fd8b00b009ae54c3c627mr5280712ejb.71.1697996303625;
        Sun, 22 Oct 2023 10:38:23 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:3344:1b7d:7200::eba])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906261900b0099293cdbc98sm5472634ejc.145.2023.10.22.10.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 10:38:23 -0700 (PDT)
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
Cc:     Luka Panio <lukapanio@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)
Date:   Sun, 22 Oct 2023 19:38:10 +0200
Message-ID: <20231022173811.8229-1-lukapanio@gmail.com>
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

