Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA6C778808
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHKHUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKHUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:20:22 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253F22738;
        Fri, 11 Aug 2023 00:20:19 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3492905f546so6056845ab.0;
        Fri, 11 Aug 2023 00:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691738418; x=1692343218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Op8n5tYGZGAKjH7wmFMz/XsPjY6Yr8dG1AahxEINqXE=;
        b=H0yGAhQIWcgJ9jrdjJj6Qix2tecdQKSC3aITuxLiz2Dlne433Ca06RhDFAUJBDUo14
         e6QJem0qoyIDfTZtgpy47sZDRMDJGmJNFt0Soof0/bf/CTTtHgL05IWhuAEzi20tADP0
         q0coh0G8csU6999bFy747k9e4Uo5iR0vtTVFQdGkgqnvgalbkMCqVYixZZ8R6jlxfHLk
         PsSTFRWqAD9lqJ+N9QAHD3+0evahnEHczfSmYoDPH94x/tv+Xb96F63b2ctHZZbkl1AK
         bhPtd6nO6zFRr8i5/VjfIPFFnmAXwWHpynNyTXg0YSTQdSZGTFB1p7p5wBw6i9h+bgOV
         ev2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691738418; x=1692343218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Op8n5tYGZGAKjH7wmFMz/XsPjY6Yr8dG1AahxEINqXE=;
        b=IXHy23UbznvHXOWRSrWwckkVGPRYKgyTRWBJSSBPIVIuSIwZN/kG8RtIqDz5eM6z+2
         wYDqW3v7iAtNSAkgpq2F9Azt4DI2wF30E1P+baTDcriNz5K7PS3E5JYwYMzS+j/4NaQW
         uG6ErUQB0pYm92hMVIoDheotG3+Zsl99hQv3gtxxj97EpclgHCnFAMdMfNEm4zIpezhh
         wHfT5OlOt+gj0Onh7siv1i+UsdwwCr6HzFJo9TMdP6UJ4OGiZoNnMM24OIkeHrVsVGme
         YHOqy8R1o/jfHCJRXfvioJKK9K5pKU7RSuyi/PIRCYaYFiwKgAfNQajwRSDDI+k9i5fr
         s80w==
X-Gm-Message-State: AOJu0Yxo8wDAQKwaq5Hail1PCl3baLCsVqiZQpqGrRCL61PUs7uc/ZTQ
        RotZUL7lWg+7smG/ew3fNwQSKoXoIExFBQ==
X-Google-Smtp-Source: AGHT+IH2URz41hz5xivldvevIpXAzBoTDXzcAShhukr0olyyEMqvAPctM8ZBI7+Md1znQW9te6Zang==
X-Received: by 2002:a92:c543:0:b0:349:650c:7226 with SMTP id a3-20020a92c543000000b00349650c7226mr1380049ilj.25.1691738418013;
        Fri, 11 Aug 2023 00:20:18 -0700 (PDT)
Received: from james-x399.localdomain (71-218-110-92.hlrn.qwest.net. [71.218.110.92])
        by smtp.gmail.com with ESMTPSA id t24-20020a028798000000b00423240c7296sm912435jai.69.2023.08.11.00.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 00:20:16 -0700 (PDT)
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
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with Custom Board
Date:   Fri, 11 Aug 2023 01:20:04 -0600
Message-Id: <20230811072009.55400-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 2510eaa8906d..76bb098605e7 100644
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

