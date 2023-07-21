Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0075C3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGUJxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGUJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:52:35 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD3930FE;
        Fri, 21 Jul 2023 02:51:25 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3465bd756afso8486035ab.3;
        Fri, 21 Jul 2023 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689933048; x=1690537848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyZDohbVmZV7Pirtq2n00zjMj4EMpaHLc+onkowTdcU=;
        b=DNs5ncQYxC89DkYalSTeSoGJ4gIM/r4AN3T0IuOx40o5aUbT3Os03pSP8YcaSevQ0E
         UlOmw1LCTTVWNhTd6WistXy1HEI1tpm2EtfFvWKZlE082qI88Ig4uQDFbduqWrJhTeAI
         VkYuhM9oEbocSc+dbbOWnJFn8OJbM3Y6x+XCzz4LJeDs1R+3z7OYm1uP1tFgqhmk0BNW
         miodZRM6YVrOlNwsD6gigFUeK1bne6teKx+WaaOoxvCQ1KtS+jH4pQPM9b/DBaNJu8Dt
         v4mdXzU0ujm2F5GTBnQxXNxUDu4Ogf2x7JMBiGtvBMSS5w0sGBTcYxfF1xKBn+qCftjC
         /p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933048; x=1690537848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyZDohbVmZV7Pirtq2n00zjMj4EMpaHLc+onkowTdcU=;
        b=fCWAigkiXz41jvFp1uhSnTHLl2vut24vuzACA54vOAZZq0xAeZa83IBrYXnV1VejV+
         SIRvGQ9cF5hgXSZWLg/tusobyyrN896blB2Kc6xMFcxvuf6HpGwuuH9UV4JhyoqseEIT
         wETH42apeE5nmAgeT6tvz5iEUWVQHAkg0AO0bG6aFeAmOMNdUi8+YCEe8Cbc+7pjUaG2
         g7H0mvV13I5jc1Ai44DPDrACXBGS5ND+gnMZ/xQv7R0J8kdSg7rmAXgNHdMTAQs+vV8l
         wQ+iXadcEGVQldIi7ZzuHOL6SX5yqn3EKwXSJHHuqBzbTbzndULdZJ6CmEV9n9Y2tYve
         oTlA==
X-Gm-Message-State: ABy/qLa0tmWEEvG3sQAXrA0GWag2Q5LgWjlqfi31yNXvTcyX2WdA1cLL
        MggMlbyfFGDqSUxhCERTQljyO9EESZIIkg==
X-Google-Smtp-Source: APBJJlHE0edL/COGoN5wvsG+NbbrgN88LPziDxbgRYvSEiFzQUELv0vAcQ9iTsEXjVzRMcZcIy7BmA==
X-Received: by 2002:a05:6e02:1c45:b0:346:1185:31d0 with SMTP id d5-20020a056e021c4500b00346118531d0mr2075364ilg.9.1689933048439;
        Fri, 21 Jul 2023 02:50:48 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id t8-20020a056e02010800b00348ac48e127sm787066ilm.33.2023.07.21.02.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:50:47 -0700 (PDT)
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
        Andreas Kemnade <andreas@kemnade.info>,
        Tim Harvey <tharvey@gateworks.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 Custom Board
Date:   Fri, 21 Jul 2023 03:49:59 -0600
Message-Id: <20230721095003.3681484-3-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721095003.3681484-1-james.hilliard1@gmail.com>
References: <20230721095003.3681484-1-james.hilliard1@gmail.com>
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

Add support for Variscite i.MX6Q VAR-SOM-MX6 Custom Board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index da486c4a4ecf..76bb098605e7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -387,6 +387,7 @@ properties:
 
       - description: i.MX6Q Variscite VAR-SOM-MX6 Boards
         items:
+          - const: variscite,mx6customboard
           - const: variscite,var-som-imx6q
           - const: fsl,imx6q
 
-- 
2.34.1

