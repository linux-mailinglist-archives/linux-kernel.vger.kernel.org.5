Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636BD7EC320
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbjKONAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjKONAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:00:18 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F0F109;
        Wed, 15 Nov 2023 05:00:15 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso4176835fac.3;
        Wed, 15 Nov 2023 05:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700053214; x=1700658014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDT3a72/4EK2RXUg+bwJp3dxgNq1+ZbWNBolGSQCq8U=;
        b=ibN7e/0CnUF46/PfOZy6paIxeUlRCoWjZy9wlCAzkiWJDrWEl5VV87vMjXEDwdHPV/
         WxRyTBoIRuhyBbg58gGx5BObPvCo/w1Ey/jdolGlTjhcrLrqMDQab+N9Wgt/rJbbIcYW
         jhRg7k78zvNBCC7TMmAd8pKfXD3xZYIT4iDBK/LeBTWkfTlnTJC3biId/NBztVIWQRuE
         UClg2IXW2piS6KEtdf8Kta1lWZaOR8ILYbiBdwf4qUq9/tu3uKS6ywg0rvmRdrYCKK5l
         YsZZR45PCKKoOBoxfbAPr6wM1a78c+1xfEuS91jkwBg/vUcuV2M2CVjwDANRdPNJauYt
         JqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053214; x=1700658014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDT3a72/4EK2RXUg+bwJp3dxgNq1+ZbWNBolGSQCq8U=;
        b=ESbXCbdhXFj+67y5o440jwxlv18NPnG6W1qUiwpE3LnmuCUM5NDHquLHfT0viyM+WI
         7EtcQdT30e3lbnFNbfNXtSqPWQedIG5xWNeOqVlf7rlSYcw73HIctQfAT/bnQGc25gpV
         d9yaO2qylz3yUUgzIdQBSNM6tPxkeZr2k3YgAU9GC+4uLPXpZFGcIgWzLgukrPuY6FKw
         zs5UMoGAMt33y7Y8qCcCDy4JkefiU6MNJGZpS4S5+SnVER/kJDGuCCHmbNvuWNEUKTCi
         LLNwUeGX+AvTBN/W7gmWCw9xMLcfyE0piTXEi1atOttVWdCui0IoB6o6pKu7FGrEJMlw
         ZtoQ==
X-Gm-Message-State: AOJu0YxVB9riD1SBlrfY3xC2lBFcLE0ss7ROBxqpwN36U4tZVohKmuSy
        2td2kMSrFCKIQzFvSlofHJpeq5xQBl1x2w==
X-Google-Smtp-Source: AGHT+IEPrIUX6ZzViiJXg+HhiZ1aUAYZpbVsJ3LLGoCj+Ba6zvmxvqFqsdgCHXtK315N6GkzpKzK2Q==
X-Received: by 2002:a05:6870:f14d:b0:1d5:b2ba:bc93 with SMTP id l13-20020a056870f14d00b001d5b2babc93mr15039104oac.13.1700053203762;
        Wed, 15 Nov 2023 05:00:03 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id fh42-20020a056a00392a00b006c4d128b71esm2812867pfb.98.2023.11.15.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:00:03 -0800 (PST)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add aosong
Date:   Wed, 15 Nov 2023 18:28:06 +0530
Message-ID: <20231115125810.1394854-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aosong Electronic Co., LTD. is a supplier for MEMS sensors such as AHT20
temperature and humidity sensor under the brand name Asair

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v2:
- Changed vendor prefix from asair to aosong
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..48d4ff635562 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -117,6 +117,8 @@ patternProperties:
     description: Andes Technology Corporation
   "^anvo,.*":
     description: Anvo-Systems Dresden GmbH
+  "^aosong,.*":
+    description: Guangzhou Aosong Electronic Co., Ltd.
   "^apm,.*":
     description: Applied Micro Circuits Corporation (APM)
   "^apple,.*":
-- 
2.42.0

