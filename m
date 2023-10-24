Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD6A7D4C09
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjJXJZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjJXJZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:25:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4607CC2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:25:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a5f2193bso4847662e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698139512; x=1698744312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3ohJUebuUECvOi0FjqwIOrHZugSfuRp6dT+KCBYjf4=;
        b=mGWueSOjb78oBCLJei5DiYZJd1mNezLomG9F5zPlpP3eLbuWPBwoafiKKIBDVRnIZp
         ZmLLd/uWZBlWewPOxF3/Ye59zpR+01YRHOWjRDkXjWgFqCTavzPBD2UN3NN+RT4s+kLf
         yM1EAhGHsSrq5A/k+ONZhRP/7e2SblFQwl7BKWwvva/ixUqTGhfiXEF7vZ5zNKVFLiq0
         02vgzDbgViAVL/j4DR37O8DoyPvHLAA928I5BqAaKdmryPnWqHOWnlORqBZcfjC8aZBc
         XJUn9hLBD8TgkHGqQg0czBaOLfPJzztY9rUeOpNBaGTCBi80wl0LOM1OhC+bOvr7xjaB
         jDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139512; x=1698744312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3ohJUebuUECvOi0FjqwIOrHZugSfuRp6dT+KCBYjf4=;
        b=RfkRyo7urc3HSL/iMR5jX28MDqC93d+Xfas5GJ5bVuamVB4wADQnbYNf2i4mC7hLj4
         h9DePLIxJhohMr6DrqQFqse9gASbVPGxr+Bjrhug+xHYaD8RxH7M90hxxDvvGaC4KabN
         Tw9nEaTkAopppukDuQrdKlU9iL60NYiiCF2a4o+1weNKiFsVHtPKuCxvmxuqi5r0CthQ
         MQdQH/iFaVCcWK0oUno9GKVWqKNjHEOVrdBkOhFrk+ktAbZfJoG3s/KtyWnL95DQsjLN
         ZGrHw3tvKoqbiy9Oaz9YzP1Riilsgm/YIZQ4IAMf7za5eJqDY4J/G+54VgdhqA2tXLGc
         4MEg==
X-Gm-Message-State: AOJu0YxWNKNSNYGsaGBOshB91NZNg5wCwZkNUdtH99L168d3dGCFa9yn
        zr1qpgmn6srQP7IeM6Q/0WUKMA==
X-Google-Smtp-Source: AGHT+IGiyQM7g5OyW8btVnjClzjpUyoGGYj82N9E2e8k/Ty2hz9D8SMWiF5JyYso8GbS/oipvF07Ag==
X-Received: by 2002:a05:6512:159:b0:4fe:8ba8:1a8b with SMTP id m25-20020a056512015900b004fe8ba81a8bmr4012841lfo.7.1698139512609;
        Tue, 24 Oct 2023 02:25:12 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id c12-20020ac25f6c000000b004fbc82dd1a5sm2060246lfc.13.2023.10.24.02.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:25:12 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Oct 2023 11:24:53 +0200
Subject: [PATCH net-next v6 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-marvell-88e6152-wan-led-v6-1-993ab0949344@linaro.org>
References: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
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
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
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
index 6107189d276a..53ab2158fe2d 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -46,4 +46,10 @@ $defs:
             $ref: dsa-port.yaml#
             unevaluatedProperties: false
 
+oneOf:
+  - required:
+    - ports
+  - required:
+    - ethernet-ports
+
 ...

-- 
2.34.1

