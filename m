Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8547D515A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjJXNUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbjJXNUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:20:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17C12C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:20:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507b96095abso6656717e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698153632; x=1698758432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UT552xSRxg7vfw/B4jlHzjbiGIGKhdCrIlQ9lB9ogSk=;
        b=RS6oO+kOF6nFFUVyLqUXSibAbxFVFD2hlRtuAZmm5qt2pu+qY5uBmBvWge6Dos0uDr
         4CtOsOImZWm1DeRwDfsVlV8eiKIKskzDay04kBVtIIOv81jIhU+7FgKLtjFZ8x9PeEfN
         VK6xhrdVk15l4GIpzzZCU5Vl+Pd9wfEYgQXyyP2IihEHDfJ0ST8cpc3QpVjHDMFphJc2
         eluxCaR6YYRBznfJrluPosuTuEBQgdKQWOe/TlJKv4xrCZEKewbSCE0t2IQctjBayRcg
         ICT+FSUc5yi6CbyJuL8U+cDuu4WqSULFW4pAQJyrq/tLdG3ulXrM+ISVFOTh9Iv9aQFt
         J5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698153632; x=1698758432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT552xSRxg7vfw/B4jlHzjbiGIGKhdCrIlQ9lB9ogSk=;
        b=xA0vpAX2MbHhWbIgRHrILauw0KL3K2hmrTBj/shuTpNZYl0zzrMVbcjpnVrPlqH9o4
         Bhvij4BRvJNkLY11RkYHSfMlo/A2GmsyV9ML+/0InNeNvV+zurTMSPuVthhGxlmVMFNV
         VFdo/ct0Oi5tgOGffVWcTlWn1gNOeS2BmHURZb8w3/1ByxEFzjbMvDGGij+knFujX5Zw
         K5/xnlb8n8HFybpK6/3IvY6Al33pnGaZ/0jgK4917sX3z6zsQ2AhwzIvQ8VvDUlccvVk
         ahS2D2p3tQuugN/Aueqvyl8T8+mFldkzPlraVAgppw/ENqE5f7szeJMZlS2zu+bnB+tP
         hURw==
X-Gm-Message-State: AOJu0YywWszPQjwZeXYQ9yMg2qwGpDa1g2nuKWWQ/gOwOd0eAT2KQD8j
        8oYr6KXjPemAkXJDWWF8W8qhzw==
X-Google-Smtp-Source: AGHT+IEj+KMeONE10q/gquHsR7jOzyg2PFLfGY6LK/CyGvVzrP9Ev1G3Y33qwldjE7BWxEeoNM6aWg==
X-Received: by 2002:a05:6512:4016:b0:508:1178:efa4 with SMTP id br22-20020a056512401600b005081178efa4mr188587lfb.55.1698153631805;
        Tue, 24 Oct 2023 06:20:31 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d5-20020a193845000000b00507ab956ab9sm2147365lfj.147.2023.10.24.06.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:20:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Oct 2023 15:20:27 +0200
Subject: [PATCH net-next v7 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-marvell-88e6152-wan-led-v7-1-2869347697d1@linaro.org>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
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

