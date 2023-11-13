Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961827EA70B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjKMXgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjKMXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:36:09 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61310E0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:36:06 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c83ffcdbe3so25253621fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699918564; x=1700523364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7sBbrB5dazvmxdFbFWIm12yMxEolhEuwzB459S9svI=;
        b=GCYath4zyDrnwOJWVtITfzen6Cj9ndDAB2wpCz5yC2xJOvoIZmqQk6tfjPcKHKzIQX
         47rXe699q6IgYQatad0qpMeMa482pPA+cOvTH5HFU26TvYy6i+pkGh7Z4q+fsajhaDUC
         AdZvCAjiBSlg3dHBwVwTw7/xwRZ6evsSdHEtPL+PDEIleTaJXhGHZjh1mUah46fdAYQ1
         bbSrTHcCzykX/FPbMkmhFsadn4LlEWZyPB9sl34KXWBx6XiM6cO/H9HDycNyEM5J++Xw
         J3AAMkeohFvs+wYRT10v0Tqfw55dOHX4tqvMY9MXgjLzqdHRvgU203ibprg5npJ9P/gX
         yjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918564; x=1700523364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7sBbrB5dazvmxdFbFWIm12yMxEolhEuwzB459S9svI=;
        b=Q+dZupa9so2l7eWb6IbDbpPvqHrY6zk1AOqQIYhiQlZliRxsxakpeTQK2tKqopOirw
         1Gdyw3K3FZB9ilKOADXEl8iHKdXhnimhvBt2Itn+wURngdswe5FH89yXcKRrez/CzrMe
         k116mDcGqpuaL7yR9324u/x6nYBmNwn+FJSF6YyTFfwtFMsgcXqCgYFDjAOt0VH0vPyA
         jI9CoTWdYEGHmOAcCuopvK0GFWye6BqpHtfcBp2ApLbOCnPsvXo4F1+ok+vhDI4cA3Z0
         zI2N80Fk53nKwaj2yZpwAMbjkOgm64YUeQ1RdwCLle5KZmnMLVQK8s9F9vSKyckjw/ke
         rP8A==
X-Gm-Message-State: AOJu0YxJESvJ/ZPx6mCXYZOfObpAG3rmwiNIPdAsvFnSY7NeXpyYOyC1
        e0Cs9azeUzIlN2LPWa0phw3H3g==
X-Google-Smtp-Source: AGHT+IEcKzuTyUsnCCKx0aDIJeN7M8fqCWuHVFSv5zu+wJ/DA8g7pht0vHxLMNEUkq/nMkCaBzn1tQ==
X-Received: by 2002:a05:651c:1055:b0:2c5:3139:2d04 with SMTP id x21-20020a05651c105500b002c531392d04mr451059ljm.47.1699918564602;
        Mon, 13 Nov 2023 15:36:04 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 17-20020a2e0611000000b002b70a8478ddsm1202859ljg.44.2023.11.13.15.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:36:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 00:36:01 +0100
Subject: [PATCH net-next v8 6/9] dt-bindings: net: ethernet-switch: Accept
 special variants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-marvell-88e6152-wan-led-v8-6-50688741691b@linaro.org>
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
        Linus Walleij <linus.walleij@linaro.org>
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

Accept special node naming variants for Marvell switches with
special node names as ABI.

This is maybe not the prettiest but it avoids special-casing
the Marvell MV88E6xxx bindings by copying a lot of generic
binding code down into that one binding just to special-case
these unfixable nodes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/net/ethernet-switch.yaml   | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-switch.yaml b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
index 72ac67ca3415..b3b7e1a1b127 100644
--- a/Documentation/devicetree/bindings/net/ethernet-switch.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
@@ -20,9 +20,26 @@ description:
 
 select: false
 
-properties:
-  $nodename:
-    pattern: "^(ethernet-)?switch(@.*)?$"
+allOf:
+  # This condition is here to satisfy the case where certain device
+  # nodes have to preserve non-standard names because of
+  # backward-compatibility with boot loaders inspecting certain
+  # node names.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - marvell,turris-mox-mv88e6085
+              - marvell,turris-mox-mv88e6190
+    then:
+      properties:
+        $nodename:
+          pattern: "switch[0-3]@[0-3]+$"
+    else:
+      properties:
+        $nodename:
+          pattern: "^(ethernet-)?switch(@.*)?$"
 
 patternProperties:
   "^(ethernet-)?ports$":

-- 
2.34.1

