Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448657A9D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjIUTmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjIUTmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:42:24 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B87D66D0;
        Thu, 21 Sep 2023 12:08:39 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59c07cf02ebso16265337b3.1;
        Thu, 21 Sep 2023 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695323318; x=1695928118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruiINtpGZfULEUut8GaQI6nqxxaArMSZTd8GUgMbPVk=;
        b=AwisRaIoaSVluCkRzFjDsc4+l3HmqHR/IJhptR1tb4T5IxETUjBe1aqzmtghMA2olt
         S6sQfy2EQ7+y6SX0Ftfm/1PfTK5wCLhLjD+Q9jFZffl+rAVjmrUl68SJ6yyJzGTD/F+D
         ldRqxl5d+OPxv7YOhiLUGWaUAfC/xLE5UajsgF33dPlOlllCk2N4z60HfWoDkZPVWVQN
         CxGfl2xMfUyMMcdzBfYV0xNcnyMqIgXndANppmtZOzCJ1BYA2ZE0/0HTRxxPh0uDITWl
         kNhIM0rEDPhRsBwZHbpwJuKasqgBElGOwlyjC76LpaYBpK+Vm2DuaznyVmZlmlGAexYy
         9hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323318; x=1695928118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruiINtpGZfULEUut8GaQI6nqxxaArMSZTd8GUgMbPVk=;
        b=aclNh3P4daSN3xlb9h/PGpNdH9bHVQJAVs64HSNA3OLsx3c2ogUa6eYbLOeE0mS9S5
         jeABszAJbyAwtw6rorFItFDKEuLXJRHycXPwStBFFj1Ovrz25AAsEao+IqS5m+IFRTRK
         ndw/RmFPu6vWAeqOuSrkRIyFWISS9KruD19Mn2OW18m4hOUgHih8tzlu2d8fhKbBKOTE
         vC//A5rGnqMJzs0AMg6m8Ns8QK8aCKT/IKppefwhj9KnBTeLZvl0jlTmME0HsVTgWZ9b
         jOVYoLqQJzYkvGmFy6pi7iPH2oAwNJjANb1/a887jAn3FK0qFF2fne7EKo+RFe5NiqBq
         alFw==
X-Gm-Message-State: AOJu0Yy3dko1G+wCTSGFOEtl0MJW2b4mzKjN/w58S/CVstkVOryQlvSM
        QzXnUgjS0JHbolHia9exd3tYpxYw6psOF2sw
X-Google-Smtp-Source: AGHT+IGzvTtHD3sFNB2BPTBDN+yVpmqMcJQ9gplzoOR2pPA0YL0NcetmRF5GqamTRnszmgJ2nDoQsg==
X-Received: by 2002:a92:c549:0:b0:34f:67da:3d98 with SMTP id a9-20020a92c549000000b0034f67da3d98mr6282951ilj.20.1695275814109;
        Wed, 20 Sep 2023 22:56:54 -0700 (PDT)
Received: from james-x399.localdomain (71-33-152-19.hlrn.qwest.net. [71.33.152.19])
        by smtp.gmail.com with ESMTPSA id e7-20020a056638020700b0042ad887f705sm182745jaq.143.2023.09.20.22.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 22:56:53 -0700 (PDT)
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
        Marco Felsch <m.felsch@pengutronix.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with Custom Board
Date:   Wed, 20 Sep 2023 23:56:06 -0600
Message-Id: <20230921055611.1459374-1-james.hilliard1@gmail.com>
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

