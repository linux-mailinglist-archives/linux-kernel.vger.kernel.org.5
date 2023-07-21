Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD22975C4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGUKeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjGUKd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:33:58 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBBDE44;
        Fri, 21 Jul 2023 03:33:54 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-78372b895d6so70984339f.2;
        Fri, 21 Jul 2023 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689935633; x=1690540433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfH7afwcHOtCInezfkJN0cTT30By3Tnv9pETfaaJ2XY=;
        b=iVdNUJjv6KssT/1nGCGiUeBtXCPARUwd9yUHJZ48H48/wBqnh4RQsQ/xE0vzdxEpx3
         WfkkENCONit+ronl+uPaS1fzVhAn0j+nYAK2/8WGg3rDqr1O7lHOQgu6I2DY9dQBgB9G
         moXTZ0lz6Uh00+rGAIYFoyV23gK1qFAsfFa/9SN6s23qndXnO+zKhODnPusW8FodHlgW
         MqzlcOZV1LtFLYECOG/MPD8Vof2TUS+hrw+PIRIeidRT9fDC4Ah0k7CfxHRSTJpfq75b
         wLqay1I+9Fjx2oQEDfaB7tDV0rxC9GvDNFmdnyYoKz1dNhoRyQ0CeXJicFzNOTwSr7PL
         VD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689935633; x=1690540433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfH7afwcHOtCInezfkJN0cTT30By3Tnv9pETfaaJ2XY=;
        b=eVkalRB7hoNwh7g8m/zNyoQYkb2ruGf4Gm4h+3buh3pSCcbBp5taepg6d/kcLeH2rI
         0bZ5oV/dY3UfEFKg7LP7XRoC3P6G5lNb6QN2gL8jjo0hsw21nnIcNIiZlZc1YRHIhg3E
         OUDGm2BX8McXGvl1dyDL74Byl8nvZoI+vOhjQxL6yaetBw99EkW7c0gwjUZknL01iGDC
         u+jz/LKahO0U3Ww3XGi4VrNDFgwcWCKW1SqDjOnNQ/H1d9zFIhCQeRg1OrdnM4ikxUOl
         ddrc2BJBrsdS61PMYXY6I8KJDvA8meHU85rF5XDqEA1c9YHsExXwvkg9aOsA6vhqED71
         vpXA==
X-Gm-Message-State: ABy/qLay/8A036CgCcFFcYfXaHzjPq78gGg0+gOqqY/4BCbcuW8eqGq5
        bdKFhQBAfjW10cK8xCQuvH6aQWJ0wViypw==
X-Google-Smtp-Source: APBJJlGHeT7JXLN9ycIdZv//f1eH5DuLjIu9lA6BGCLd2eHkTZ8oY/jck/uWviN9Jn+ShcJ5umd42A==
X-Received: by 2002:a5d:9c95:0:b0:786:463b:2ceb with SMTP id p21-20020a5d9c95000000b00786463b2cebmr1464851iop.11.1689935633453;
        Fri, 21 Jul 2023 03:33:53 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id j14-20020a02cb0e000000b0042b03d40279sm963225jap.80.2023.07.21.03.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:33:53 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
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
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with Custom Board
Date:   Fri, 21 Jul 2023 04:33:45 -0600
Message-Id: <20230721103350.3684483-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.

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

