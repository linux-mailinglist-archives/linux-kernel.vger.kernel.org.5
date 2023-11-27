Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E827FA501
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjK0PnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjK0PnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:43:09 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87D71A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:43:15 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507adc3381cso5934790e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701099794; x=1701704594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuNdy95VNpWQjRKNnpzeQQ54Hlq4tpuG2i9HfgCgKck=;
        b=VdxgrLaVwdFGTf4L9jrcfSyoT39a3TgiWdFkBfhh5rVfDUHkfuHMS7djCDtKhgj/LT
         xbsNB/mSwDLi3a5NFTTkP5OPkfe/sRCDpZ8qC4HujDGw9Q1SzoTyOJB+pKu2R/Lccu1D
         2V20K6I3DwtP1tLgo0jZ8UkZkoTL4zZFTO1p25AQ729O16IfgVX4jsTG2vtZBxug7V8D
         y7eNJRNmisIwEgJDE9zH5L84jFTALzryx4dgcOvq5OgIyU4BaM5MZc+i5EppPmwL62Nn
         1cKupvK7UVAKB2w6cOz8g5I36exjd4nmdlm8evJ6zzS19/HsvkKxxCc5HJOeeJWHFwNX
         A7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099794; x=1701704594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuNdy95VNpWQjRKNnpzeQQ54Hlq4tpuG2i9HfgCgKck=;
        b=XIL3NEILXXJx0YkI5Aljz1Ar7m/9iaaOt/95yGVpZX/pRg4U/xZ4ncGzGnAhg+Hcg0
         wbkC8WVzM3+cs+zaFmVK24YX5Ao7oLs3NhP7P0lYLzoWAP9KG4oUEeMCCVeuI2sBwu2Z
         /rsQzAI2VtDcHZZo7RkXUrBm+qWYwYLQJK/ZY/M0zYW6a1oHLjeQEaPZUIgPkDBxeO1U
         K7u3EVM4f5T8eW4NnYfbndEbMh25iPys2nKdThWSikoHSKup7CpRz7UZJc4uJehJIDqP
         BJVkkwpgQhfMzoptsrjEtwVYMJGijG56Dary0VwlTRXpaKx1FWuTuk5lK8DL74IfGEfC
         8I7w==
X-Gm-Message-State: AOJu0YztDl+rA1RVA9h7VR0c5g1Ta0j++oGib1t8GVrdYbwUzjiaKkA+
        iexL0pw/AZc1pUsRryCKysRvng==
X-Google-Smtp-Source: AGHT+IGWjn7a7SaeCNhun0JE7z2oMYlgMR3QEHklOjINxZRkGcdglD8+plYLOYV/HHG6FnDABF2yng==
X-Received: by 2002:ac2:4858:0:b0:50b:ac21:29fb with SMTP id 24-20020ac24858000000b0050bac2129fbmr3844407lfy.31.1701099793925;
        Mon, 27 Nov 2023 07:43:13 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v28-20020ac2559c000000b0050ab86037d8sm1505049lfg.205.2023.11.27.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:43:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Nov 2023 16:43:04 +0100
Subject: [PATCH net-next v9 1/5] dt-bindings: net: dsa: Require ports or
 ethernet-ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-marvell-88e6152-wan-led-v9-1-272934e04681@linaro.org>
References: <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
In-Reply-To: <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

