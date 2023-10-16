Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744547CA3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjJPJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjJPJNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:13:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E62EE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:13:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a55302e0so1778347e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697447578; x=1698052378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQgNJEaB9CDsyBYuoK51xMQLKTuugJ9THzHXrzK30U8=;
        b=nQb0QjKaJfnIvo4xGbOlb7nrByQ5Rzxb52OhRQingH6C7lOLJ6+YiClX5pi4SVfrf0
         CJB1vn/eD5cNAbQwpqc4vGlwM5DDzPrKJmhHpAK6QZP7Sazrwt12ZCyWTiSU2vSTyuOW
         M91/zICsKRcowA/fbLtD2jurEDb2iCjHktQV0OXBullY5DvOtK/2Af1PFnzJUnXHtbsn
         xzWmbzgFD4qkTLZ41IJGdW80y2AJV43bKvAi8IVR2891r0CPF3OFHeK6aXQZGyQK8vhD
         7BB+bd/jX9UnVZXBNlr136ByUytUMfoXCXGrPEhgDc/JEJ+9RpXBZhOjX+FIzKracN6n
         DGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697447578; x=1698052378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQgNJEaB9CDsyBYuoK51xMQLKTuugJ9THzHXrzK30U8=;
        b=heazk2s7yaeKFZ1MZG9Y7g0xrgt+NaIiZeeiehCcV2zzGHbKYxnkV1AEM7bCvVD2R7
         WgDqskIAU8tQ8A550wW3f8GDfshnsvXpb3S3cE/1gx75j2vmj+tXk9a78Eh/1JYyWZjH
         4wV8jP3svi93KSEH9oB4zCuJArxT2/mm2gEcCEw7hNiHkW701iJUc/u0MO7rBG62otjc
         8bApGdG0Xe34dcn7a6fUzQ1C7Sg182ZpyhYF0wcFrTgPgykJHBbakf7RNb7wSRKIWS1S
         7rCx51VcxuazSYXLgmAb0ATGncTjsWVNYdqkO2BWH9QNo0deGgk9l0OQZ0xSvz2VuZVQ
         oRnA==
X-Gm-Message-State: AOJu0Yz0XO+lkWTw35SbQDPHxCKFAT6l7Qa8E0EjIXJIRCKektXg2urL
        aBroO8qhWRz+fYnSnVYOjWo+kA==
X-Google-Smtp-Source: AGHT+IHOrYoJN6TnzySSc3vvbrP9tHzSMIjwBQxg9l9tIyLk+Fcasw6JOLV7wUx0Rx3P9qzDheo1ow==
X-Received: by 2002:a05:6512:39d1:b0:500:ac71:8464 with SMTP id k17-20020a05651239d100b00500ac718464mr33408434lfu.66.1697447578588;
        Mon, 16 Oct 2023 02:12:58 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id br34-20020a056512402200b005068e7a2e7dsm4160986lfb.77.2023.10.16.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:12:58 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Oct 2023 11:12:56 +0200
Subject: [PATCH net-next v3 3/6] dt-bindings: net: mvusb: Fix up DSA
 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-marvell-88e6152-wan-led-v3-3-38cd449dfb15@linaro.org>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
In-Reply-To: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
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
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a proper schema for the Marvell mx88e6xxx switch,
the scripts start complaining about this embedded example:

  dtschema/dtc warnings/errors:
  net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
  is a required property
  from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
  net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
  is a required property
  from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

Fix this up by extending the example.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/marvell,mvusb.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
index 3a3325168048..ee677cf7df4e 100644
--- a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
@@ -56,6 +56,12 @@ examples:
 
                             ports {
                                     /* Port definitions */
+                                    #address-cells = <1>;
+                                    #size-cells = <0>;
+
+                                    port@0 {
+                                            reg = <0>;
+                                    };
                             };
 
                             mdio {

-- 
2.34.1

