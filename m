Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0252275BFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGUHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGUHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:36:55 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2930E2;
        Fri, 21 Jul 2023 00:36:33 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-786f25bcb40so72503239f.3;
        Fri, 21 Jul 2023 00:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689924992; x=1690529792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rwVqooMhU6/qCyAsIXyrwVrxORybblqV7NPbOLjp6eQ=;
        b=kiY9xGcFRMHRU+6vcgB1ZWXy601u2U13MnKnCeR+clwk07W46VlXKydgHm8RxFrh+P
         wOwccvmh7fy/K/IfMuzGAmXHy9D8PIQR/Klql14waFXCSDbTXd4Kaiw2VXX7goeuqK2v
         qxP6pJaYnn01j6gyeA+7uY43QdeLU3ou41MuRgWJkSac+lhPbQiaeN3jCV/uA5jkaJTe
         rs0fs2bfhudulx4VL/yCYRQtVwgI1fiO2UA+XlXiaUbB8meSgSC54DO9oRwIn9LLPSZn
         n8BLILA9NsrBHJNZTL4tPiRPWy1PMM161TMGgA+IT5U44YIL7PE4sZ8Ic+53G17PNGyI
         6e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689924992; x=1690529792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwVqooMhU6/qCyAsIXyrwVrxORybblqV7NPbOLjp6eQ=;
        b=G1C7ThI9bclRddtzamkA3rXoITUOnyoIHRM0NHg6ZJd0aTDI/NGXN2CfM8d8xDn4iF
         RsllxVaDS6ETDE3U7dJ1Xae8p7mjg4fOO/k8/h8DTPmq+1TbjExDewtysJ9OxO8zZaGw
         XVIdHIzmumON+c3tRmg38WHhL/6G8gXMZ8k6VppziF0gfaA4c24F4byc2c75aX2y52wl
         oi9XFHdoZTWXnK2XSbRfQ9HENhDvDLijf8XkKkHIjy7CUVyze5jdRbk5Hj04qqXOIjOO
         KbRLDdDosfihG2RD0JVX4D4UNrXUN5e1Q4bGEx5xLT6cqW2zot01txALJ3VLr1zjXZ8a
         qJaQ==
X-Gm-Message-State: ABy/qLaPiAn1vamIQvvKx8aOs5wHWXYs87juSZqPbOAiSbUOoN2JfnVZ
        rTJ5mJTjBNgsExyeuc2LBtlOYwOLiuEdDw==
X-Google-Smtp-Source: APBJJlEYUrmsmfELS+tWrSOJXjolEwY3UMjoLdTwnhyAr6shA04JfsLVam+QEPhKD/selRboy3OKrQ==
X-Received: by 2002:a5e:a705:0:b0:780:c787:637b with SMTP id b5-20020a5ea705000000b00780c787637bmr1161420iod.0.1689924992151;
        Fri, 21 Jul 2023 00:36:32 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id k20-20020a02c654000000b0042b35e163besm883017jan.88.2023.07.21.00.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:36:31 -0700 (PDT)
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
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM
Date:   Fri, 21 Jul 2023 01:36:19 -0600
Message-Id: <20230721073626.3673429-1-james.hilliard1@gmail.com>
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

