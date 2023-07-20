Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F975AF47
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGTNKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjGTNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:10:37 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE86269F;
        Thu, 20 Jul 2023 06:10:36 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-78666994bc2so32481539f.0;
        Thu, 20 Jul 2023 06:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689858635; x=1690463435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bMTfdQ8zmTyWG805WFJweJbn+FKA39MnBuSsUcH+GY=;
        b=GKc2QB+X8QX0ihdNv9WDEq8tA2gTZFzfYjaLPNuK9Lp4O2L9C3bSU6hfDJ5sWeyJNT
         MKjM63ptD360kOFF47zF3rqIyREAl1sGNqNWo+N99CxM2ViZgfXbMapJlFB6MvWxjUa1
         zPpWtgpZTr+eRYL7w6R1v5eDWXVvDTskedtQLuHF/h859DXSkAl/SGcomD4jOj2hPnhV
         sSsrHFBuxtoXBH+6cXRqca8NtnNpIurcHLLx6BmuNhrKfWtmahjIULRUpSUuYGVsw3k4
         3utoUpTMGn+oCffw4wgH6vku8Xa2w0P3tChIQrbMpDnjYSPZjd7E/fQgfMeuol6R/Lbv
         ZLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689858635; x=1690463435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bMTfdQ8zmTyWG805WFJweJbn+FKA39MnBuSsUcH+GY=;
        b=RFDXVWnN93sI2u+3PxzR8iGPqY6iD8i5f1oRJfi2+pCw5nYyn0ZianQXRfY8NPLwqS
         w69tLoSf8VfrF6v2jhB1Av4zFtjeuU4LuhWTrQPV0Ockoaj3qg+1CeB5eLOvLnJcqDej
         q+LLVSCxgxkzededaapO+shA3kM2h8k0KYGcCGBhLpywkQoRdv36itUmHoYZaRvlEBLg
         yVzj6fFgAlpRcgn4TBuoZ2/tBgme9he6y0MAKcLOGIlhRAmwixbvYibli3F+QcTVozNp
         06wJDv8BortGGHbio/jdQIURlDd2kN89OV7jZwEKyFBiz/rs/SgDOtrUPX0IXNy+qQH/
         CP4w==
X-Gm-Message-State: ABy/qLZZVr41IdZZq8frICe5X1Sjgqd2+glB2A6rSNb1w4jeWaGvUzhF
        V3WZVoQp97YuiUf20spgDQXLsjcKQ5GYjw==
X-Google-Smtp-Source: APBJJlFfJPq1F+Qu7Ho+PICQgbvXzTS2X/RdLdnvx1UKSaRr4rydkr3wM8dNXUVnIWHJVvVwMXQXJw==
X-Received: by 2002:a6b:f002:0:b0:783:5e4e:b785 with SMTP id w2-20020a6bf002000000b007835e4eb785mr9118527ioc.19.1689858635266;
        Thu, 20 Jul 2023 06:10:35 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id k12-20020a02c64c000000b004290fd3a68dsm324873jan.1.2023.07.20.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:10:34 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
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
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM
Date:   Thu, 20 Jul 2023 07:10:22 -0600
Message-Id: <20230720131028.3730704-1-james.hilliard1@gmail.com>
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

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2510eaa8906d..a3ab78429799 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -298,6 +298,7 @@ properties:
               - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
               - uniwest,imx6q-evi         # Uniwest Evi
               - variscite,dt6customboard
+              - variscite,var-som-imx6q   # i.MX6 Quad Variscite VAR-SOM-MX6 module
               - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
               - ysoft,imx6q-yapp4-crux    # i.MX6 Quad Y Soft IOTA Crux board
               - ysoft,imx6q-yapp4-pegasus # i.MX6 Quad Y Soft IOTA Pegasus board
-- 
2.34.1

