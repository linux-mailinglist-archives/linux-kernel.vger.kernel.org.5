Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90DF7EA700
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjKMXgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjKMXgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:36:05 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF67AD71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:36:00 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c79d8b67f3so53361311fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699918559; x=1700523359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuNdy95VNpWQjRKNnpzeQQ54Hlq4tpuG2i9HfgCgKck=;
        b=ZWk9YWnAIILC5S/hmsCw/pV/GPcrxB4VbupyLbglHBtUkXGtEJiJp2K7MC8P7e1Eq4
         ZifiLlUgoDrm+byqiQCFGi4APAzigOsPqLer9i26xrkKs9rx5IdkkuteSQhHwtq1YYf5
         ISIiK40dBqbzMrMpHXJ71WJnCdDzLwnkrGuteyw8FnlQpPadma591KgjXLrR8Ncrpkww
         4m59XyJpMJo6GO5oO9Zmk+GBZQ7g/hfZiGbTLdmUzHt4UH+33R9a6ZtVuT5cNgiS0tqc
         8CImP9eJ0CNeAssYb8vWYqedxE6319UZlj4pYbt0y66/ilTU7lG6E39y+qvRqsqmmcTs
         PDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918559; x=1700523359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuNdy95VNpWQjRKNnpzeQQ54Hlq4tpuG2i9HfgCgKck=;
        b=dGsml3pkjcfW0IeFvW8M9FTX5FR1WgGLA9oUxm7YWshWWkWKHCIL9pm+C4tFbZ6+Zq
         VX0gANEIL37pTLAFQl1Ib/NN57bYZ8pJ40a7+aTStBswMtwmYKQd3qFKKxuA9j5YmSTn
         iIx6f6NWsr/epenILM48wMTcHGGYwun/Y8w2PWTD7kFDwZ+yO9g3QvBMOwg78ikdFYXY
         XOBhKfqrapCtJ+/QSa3qjVecnfRlKQ/T+ekhzpYctGlwq28QCG+rUS1ZKOFMaLlQnQVF
         1yvQ1d9pZz0a2KEDpb/zX7rGHJK2IPQYUog01bBpOulFKLqwXz85v6I9yRIjF2w6PO/G
         zK0A==
X-Gm-Message-State: AOJu0YwZitJz4+NKXj4tf+AAK6N27ZTZ6X+Ct0485LRRxS99rji6HsgP
        Sg1rFID3sFv7ClWGBRi1VFRxIQ==
X-Google-Smtp-Source: AGHT+IH+vpWSTfI+TqOPfDKq76GtSXfLBIVn7t5E38cxEXvkov/kjCBQrBt7VVuzFvyFnuIoPT3IzA==
X-Received: by 2002:a2e:1659:0:b0:2c5:169f:ff03 with SMTP id 25-20020a2e1659000000b002c5169fff03mr475738ljw.5.1699918558910;
        Mon, 13 Nov 2023 15:35:58 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 17-20020a2e0611000000b002b70a8478ddsm1202859ljg.44.2023.11.13.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:35:58 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 00:35:56 +0100
Subject: [PATCH net-next v8 1/9] dt-bindings: net: dsa: Require ports or
 ethernet-ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-marvell-88e6152-wan-led-v8-1-50688741691b@linaro.org>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
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
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 6107189d276a..2abd036578d1 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -46,4 +46,10 @@ $defs:
             $ref: dsa-port.yaml#
             unevaluatedProperties: false
 
+oneOf:
+  - required:
+      - ports
+  - required:
+      - ethernet-ports
+
 ...

-- 
2.34.1

