Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209C175C3B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGUJwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjGUJwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:52:31 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BB1448C;
        Fri, 21 Jul 2023 02:51:16 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-345f3e28082so8373645ab.1;
        Fri, 21 Jul 2023 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689933040; x=1690537840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9qY/4YNMX7T5IBO1l2v1VxcveD25SPwYvfEqD6ycRk=;
        b=ag22LELc6lYBRYTXuz6K67yb+k0Q5/HtvEdrUsQVlE9e+UVh9yONwwuEyNME9OFNbd
         g9b445WTWC2PzHWBxw0EElNOoH0KQ5ZFTgdJR2WWNbOSmwhL+2Ay0iNc6fZa1ZlW21K4
         UOSmnFx/FemnzdtiZjx0FRgNn182YVcRh8S+i/2txajypxFRhLuMnqR4I59TggYWdWHG
         6vfeoprYDCY/SbESKBYkRcErVr/SrsfZu8FY7G6IypUkyFeB9/EkrpJLlZnbY2zFlO6M
         4dlUo1UTT0QlumW6VJylbNeLt4guVjHPNSzNYfHMBgkn8uOpJiTOwmDUCujzvO4w5HlC
         W7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933040; x=1690537840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9qY/4YNMX7T5IBO1l2v1VxcveD25SPwYvfEqD6ycRk=;
        b=kmznAewFMCHxLT8owiaEBrd0JBAgNv3c18m5lU//jrcPCLGjM541eUz3NPoOu/HRn7
         d0+41lJQ1JIEuY/RIcM9T9HdrEpgWhTNKlhpWFpHYzIvuP7/DPek6wl66EyVWT/6FtFz
         XcuFnY8ntMexSRkIKNAWJVmQ+6Ar+dFcwQhU0DSnLwzoB/m+b+FrGhDjcUf91NZDuI1U
         rktr00x/NOVajByQLXlfif+9QZhvpCvXtZanHd+4n2gnCyby5JyhUNse/XwY+mTstHus
         FUz5ORRSxcewDXtQBELlpzNLExrdQeKeWePArRhzTTTwMyZDbMKsFB9NRz/hb+AO94IV
         c4ng==
X-Gm-Message-State: ABy/qLZwE8V2i9TAQqtvfpEleHhKuDlo3g9TWGWEwlCqcm37UctGtjt/
        BnOVFZ+2v31Ici/WFwrGSoYhu7N7JLKGyg==
X-Google-Smtp-Source: APBJJlEm1wKaC88YcB7I4I4NwttPeXDAILugKUYWcw1MGlrFoQabm0MgSJi4JHiPnDBbdyVrA2MnCg==
X-Received: by 2002:a05:6e02:1ca3:b0:348:8152:95d4 with SMTP id x3-20020a056e021ca300b00348815295d4mr1973922ill.26.1689933039967;
        Fri, 21 Jul 2023 02:50:39 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id t8-20020a056e02010800b00348ac48e127sm787066ilm.33.2023.07.21.02.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:50:39 -0700 (PDT)
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
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM
Date:   Fri, 21 Jul 2023 03:49:57 -0600
Message-Id: <20230721095003.3681484-1-james.hilliard1@gmail.com>
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

Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2510eaa8906d..da486c4a4ecf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -385,6 +385,11 @@ properties:
           - const: toradex,apalis_imx6q
           - const: fsl,imx6q
 
+      - description: i.MX6Q Variscite VAR-SOM-MX6 Boards
+        items:
+          - const: variscite,var-som-imx6q
+          - const: fsl,imx6q
+
       - description: TQ-Systems TQMa6Q SoM (variant A) on MBa6x
         items:
           - const: tq,imx6q-mba6x-a
-- 
2.34.1

