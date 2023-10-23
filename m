Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC77D2B06
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjJWHTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJWHTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:19:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFA1D6E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:19:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a3b8b113so4345703e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698045548; x=1698650348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tyOup0+oFY1qNiEuX6Mw7ppmGYAINv0IB1dZ7z8mjE=;
        b=ns9iRyBmplWE3aUJQW8Ri3OqhrBoAB6NaDocqu7c4oIrXwXNdDmxK33gUw3KHmGqhl
         Q7afDVJxULV1AdI8LLwbIHVQiPQRXuZkWRgTHnPEWZ/e/VPrSAryVIGg7plNkzicqABR
         v6I0laHJynJjrGIpTI6Yvi+d8Uh8vB7rE+5jh5fmIe4/213PLZtNB+nAXo+k5MtxfNiO
         nKlpJ8mNQSNR7chCQoCp3sJpESQRIgKVZJQmvdp+hiyEYHIGtJP4K7u/gTzCOe57hxNw
         0+EwsmoHFnV/9hXOzcERnpAxvH9rKITFN0Ynfg9Y8CBqKpRCbupSxV+Tp3P38qqPND//
         iyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698045548; x=1698650348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tyOup0+oFY1qNiEuX6Mw7ppmGYAINv0IB1dZ7z8mjE=;
        b=m+ZUrqEtC4Ya+LqZBkGoS8rSEEtBjdUpcR0tZ70UIDrD32MOYFpXkLfBTz22U+dyfY
         0GKOV2AHJRwMGp69ViN96SAZsoOkIG04Y/tmfL4jhjdRlHeI6YRpprSCgpZOc2ufwu85
         GbrGUFC5ZChy/MwIfYYJS+pvLvAtOm3rHle8eJZAu22pkOdEmNszrUtzFHsfeNREQPcc
         P9D36uArsTTIpctvirh1QnSGlPdKqx7egVBPf51TthGYJAtA4jibmlpYc4d71qEGTxq+
         5QPfTlQlGaE/RANc+WaCvFJvEkwadFmPhaFsD6+8A/8xZBG9YWS3Lg1baNn1FxKzk0EE
         xLKQ==
X-Gm-Message-State: AOJu0Yyb7UR7Mb5OSiDRx5djek+GmQ0ga23Lb+18k3XVxl6p5ods0GP3
        /bZ76P0bSvyMeSUvKeBfdNv4aA==
X-Google-Smtp-Source: AGHT+IGDalWEGxPNcMqfMhzsK7CMCx7fUXXylPNH6oOJUMXrVw7IaZ2iPNraUE0ypwwaZpR/UEtg0A==
X-Received: by 2002:a19:4f16:0:b0:507:aaa4:e3b3 with SMTP id d22-20020a194f16000000b00507aaa4e3b3mr5101284lfb.50.1698045547836;
        Mon, 23 Oct 2023 00:19:07 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651204cf00b00507a682c049sm1578727lfq.215.2023.10.23.00.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 00:19:07 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 Oct 2023 09:18:52 +0200
Subject: [PATCH net-next v5 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-marvell-88e6152-wan-led-v5-1-0e82952015a7@linaro.org>
References: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
In-Reply-To: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings using dsa.yaml#/$defs/ethernet-ports specify that
a DSA switch node need to have a ports or ethernet-ports
subnode, and that is actually required, so add requirements
using oneOf.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 6107189d276a..368169f7fd37 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -46,4 +46,10 @@ $defs:
             $ref: dsa-port.yaml#
             unevaluatedProperties: false
 
+  oneOf:
+    - required:
+      - ports
+    - required:
+      - ethernet-ports
+
 ...

-- 
2.34.1

