Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB57FA503
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjK0PnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjK0PnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:43:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A2C19A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:43:17 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so4445720e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701099795; x=1701704595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0VwY6TaHpxI3borUCq3aH1TpiyNiMcQ1rckV7olnsw=;
        b=hJwOJyfIRkZ3jck+vwL4xcQnjN+q2Q+BFypatnmzv9+37ESI3ot/b1kL1epgGDzC1p
         0gfrG2J2Qc4TfbltgedED4x8v6k1DJT1vQ4jeRv9/DRhygaGn0zvoe80H7jpWeDd5vOz
         z3MMrfj3P6PlLCUZsr06Mf08NToX3Kw+ginhCQveBiwRjCyWLDRiqkCXeh9PF48xhDQ7
         1WhMPh76ZBP7RnNAPfNw7A/v76TXTnyOrSxTRT5FXd49QjpnEE5SGx2m1HE1gDZNDTHZ
         XsZkJeWCMlWzynfUMRrFBclCm85A0pzPpEQHDVvhgT8k1VVZQKqT1D45Tpf1ng/1fjrs
         8BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099795; x=1701704595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0VwY6TaHpxI3borUCq3aH1TpiyNiMcQ1rckV7olnsw=;
        b=YbhPcvzOKPWrIcmw6Dw8hsl6BJzWN3stz/meMv8oehU4vHaT5tOfTvzRBRgXf5Bz/G
         /RrXVCd8HbTWC/OcANOuCSle2sO6ob+pbHeOl4Z13/SUBe0Y4Er0G3GfnXv+qmh+ArnX
         /yWOLHiHwz40Y8k4NWNECbmCPLH0xQBHUAPa9ZGHHyQgUbR2cZKjw/iVjNdYes+XolRz
         I+pq3/Nz7pCe4aJWZlhr5rPw3rem+pyAKeB4b+8e2I+LiB4NpdANyIqL8uu3xG4/UXZp
         NW5FSK06n5arKydLUmvG25MFycDkOHSI5CE6pvOXEvZEr7tiwQafnd1/NUZV5aBBBBTW
         /I0g==
X-Gm-Message-State: AOJu0YzWzA1MnMA0SvqayzVwLtASyw57IMNe53sCq9pOM483uaHQjA37
        2RFPJq25twaA3USuS97Tch+wiA==
X-Google-Smtp-Source: AGHT+IGJIh0iNCqcRaBEhXI0IvYR0jy6MsPgVEUCTzSshOjc0I/4XTIINDQMn8M1qJldBnQ1LgxgaQ==
X-Received: by 2002:a05:6512:3e1c:b0:50a:7868:d3c3 with SMTP id i28-20020a0565123e1c00b0050a7868d3c3mr3315354lfv.16.1701099795086;
        Mon, 27 Nov 2023 07:43:15 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v28-20020ac2559c000000b0050ab86037d8sm1505049lfg.205.2023.11.27.07.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:43:14 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Nov 2023 16:43:05 +0100
Subject: [PATCH net-next v9 2/5] dt-bindings: net: mvusb: Fix up DSA
 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-marvell-88e6152-wan-led-v9-2-272934e04681@linaro.org>
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
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Fix this up by extending the example with those properties in
the ports node.

While we are at it, rename "ports" to "ethernet-ports" and rename
"switch" to "ethernet-switch" as this is recommended practice.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/marvell,mvusb.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
index 3a3325168048..ab838c1ffeed 100644
--- a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
@@ -50,11 +50,14 @@ examples:
                     #address-cells = <1>;
                     #size-cells = <0>;
 
-                    switch@0 {
+                    ethernet-switch@0 {
                             compatible = "marvell,mv88e6190";
                             reg = <0x0>;
 
-                            ports {
+                            ethernet-ports {
+                                    #address-cells = <1>;
+                                    #size-cells = <0>;
+
                                     /* Port definitions */
                             };
 

-- 
2.34.1

