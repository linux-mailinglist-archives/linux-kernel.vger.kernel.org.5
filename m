Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C67AC694
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 06:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjIXEsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 00:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXEsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 00:48:45 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FEF11B;
        Sat, 23 Sep 2023 21:48:39 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34ff2ee8f8eso13754785ab.3;
        Sat, 23 Sep 2023 21:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695530918; x=1696135718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruiINtpGZfULEUut8GaQI6nqxxaArMSZTd8GUgMbPVk=;
        b=MaX3KKMx0Y+q1PVqglpKbgzk0B7TLPSFU+bntLrs/0pYbjDMVfCz5bunrYWBnmh+cC
         d+d0w0X8d1fBaeccByCcL4pBTzd7cRL5nUmI25N1RzkX0F4QV4Z3o/td6Ls/8JdZxQcz
         Hlbd7eGy109q9xXPO7gw9TbEU/cZb1rxyl9L9OI3vJbtz4IwdY7ByQuURo168wLnP+ky
         CxsCeyiki6Z247ROOvuPYWgbHSf2UG6q5gt7m9C5To4Yax3cYa1/FrsxqCoXdMkEFYEM
         ODESOzhAlUakfbYq5u09ZWb/cwshYLf6RjIBLtXb0yEHUt7HanbO+7a1djvW4HW2dhBN
         VPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695530918; x=1696135718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruiINtpGZfULEUut8GaQI6nqxxaArMSZTd8GUgMbPVk=;
        b=fgDAQO8mDj5nwhrCrAXZfcRpaQdANZIQGmkMiWMXaynCM00gD/pKmxzIKllyKBmkPH
         ExsnFX/s9NhxZ9gM73y28AjimPd/Ta//tcNv2eNIaxG2byeDHKoJTB0KmUwSs5yuXcPq
         hbgam63coiWsObYjy6mR2qs3MlwIop2HZ30brsKw0QbsytKp14RFrH0YGhM1v63If0qh
         TVsz8ESAX0kKq5wsLZQJmK2rHooPhaBRaY0A7eOT8Z3qxvDxENZ6uQWrwsb02ec/uu5l
         RnRb4541zpYR+059eAKNIZ7HWkSrMVNPNwuHQoSQvO+n2ZfO0+WVSoXNjXAsKUeLxFrQ
         viTQ==
X-Gm-Message-State: AOJu0Yx0JkMwXTNWlvv2ZKZcVYUfWhiynSxkbMF1WeRzvc+jSQV6lG4j
        d0hBtzT9lP0TjYnl7i5RJ4dN1xaEQ2618QWu
X-Google-Smtp-Source: AGHT+IEhMnvkCdrJom/RgvNmrq7uoCatLmeqnkiWYo47n6sVmxW24FpQa+ku0Fp+fWMyKm+R2kniAw==
X-Received: by 2002:a05:6e02:1cab:b0:34f:ae17:c23b with SMTP id x11-20020a056e021cab00b0034fae17c23bmr4680297ill.11.1695530918637;
        Sat, 23 Sep 2023 21:48:38 -0700 (PDT)
Received: from james-x399.localdomain (71-33-152-19.hlrn.qwest.net. [71.33.152.19])
        by smtp.gmail.com with ESMTPSA id z11-20020a92650b000000b0034bae80711dsm2065125ilb.82.2023.09.23.21.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 21:48:37 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with Custom Board
Date:   Sat, 23 Sep 2023 22:47:55 -0600
Message-Id: <20230924044800.2199524-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.

Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 9450b2c8a678..c47f5ecdd249 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -385,6 +385,12 @@ properties:
           - const: toradex,apalis_imx6q
           - const: fsl,imx6q
 
+      - description: i.MX6Q Variscite VAR-SOM-MX6 Boards
+        items:
+          - const: variscite,mx6customboard
+          - const: variscite,var-som-imx6q
+          - const: fsl,imx6q
+
       - description: TQ-Systems TQMa6Q SoM (variant A) on MBa6x
         items:
           - const: tq,imx6q-mba6x-a
-- 
2.34.1

