Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A87CD769
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJRJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjJRJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:03:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC05F7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:03:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507c78d258fso826764e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697619831; x=1698224631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tyOup0+oFY1qNiEuX6Mw7ppmGYAINv0IB1dZ7z8mjE=;
        b=qJ1wYng2P/ZY4bg8Bl2Yx5rMa0McXZe1kIvz6BSt706kQFSt2ugMthu+brJHImmlnu
         S1RlFuULhpnTdGoMxZu9JYBvJitNRYG07BXnz5CSRhzRO7COYkkYp0dix/gIYNyNcC9i
         Ha9RX/7UDk1Uk2qbWr27Xw+gBacCefSQeddwEdJ8ztuf0MZV4BL6UEg133XmV73tc/sd
         zPF02RJEGNiEQYKzFPKDr7bZj0c10em8c8CidnG1VOUEzQr5iV+Evq8R+LT6i+UxMO4C
         3UzvsbXYT7g7QeBhR+fnsQf0rRwiZlhdocmamphwDoGjZEtjwlpoTkaSuA+yOE+hnO8f
         PdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619831; x=1698224631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tyOup0+oFY1qNiEuX6Mw7ppmGYAINv0IB1dZ7z8mjE=;
        b=rEF5s4vC6tCEE2Atma1KnS+pZa6690TBoYPDBhlJX3WCBXCVJiVl0D2EVgyruZbhEl
         xXvpE7JBvm9c8Pk+JAWftYRQhuqXKel8YJYS3VOzn/iudIInKEcne4h9YUvM/ePi99yl
         gbhkjlb6iUzROCuELEqUW3QWOXmajkSSkjxJLf142MDVQhMda8hsIK1IokIVJD21jqza
         6k4nl6fSW0Ndi8p/bofPg0ZlHxe9tJ17j0rCkZxtRQOGBRTiOsV/8TPNE32t3w9hasMf
         lspZtaHJnDO8gRL0O6+aYBlGAYTrCbMa/gMh1Y16JpEcGv+LQggjtLsw9RJ+S2qyxLWy
         d1Yg==
X-Gm-Message-State: AOJu0YyOYubnJMGNL5HoBVNjaeEF1gc7HQss297gC4MFgxqc7OFF3LVM
        Z67Co6ocbF/zJCYX5n3Q7eI6Kg==
X-Google-Smtp-Source: AGHT+IHMybJsDSExgJDVQSeN8JuA3T6ANKH6zJvy1EbxZZ9HCZV/eBXaUEtw9UO7m9Jtm4N4sfn9zQ==
X-Received: by 2002:ac2:484c:0:b0:4ff:a8c6:d1aa with SMTP id 12-20020ac2484c000000b004ffa8c6d1aamr3328690lfy.48.1697619831405;
        Wed, 18 Oct 2023 02:03:51 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651234d300b005056fb1d6fbsm616595lfr.238.2023.10.18.02.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:03:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Oct 2023 11:03:40 +0200
Subject: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
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
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

