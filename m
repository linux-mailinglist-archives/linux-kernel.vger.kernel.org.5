Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37290757A73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGRL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjGRL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:28:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0AD8;
        Tue, 18 Jul 2023 04:28:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3143b88faebso5933381f8f.3;
        Tue, 18 Jul 2023 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689679712; x=1692271712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJzMzEpgcfTGMfv1gl34ORzO1G62V99e1OasbGiTK8o=;
        b=gjteU6pXV3sw5zGc0HpF0z9o5SDa28qjhNP9aCK4floMaZBS/AYUxFEOa2Co36zT0U
         HgadPkVVgfH57whitVO1+mzkeP6UcX5/dSoUpEo3zoeMBfP26R5WcKVxjGNbyPfHbxQj
         Y0OEmsbSJuOlfzrUNoPyblg8TpRWt6M3nYaizrPMNGUlJJwRm9KNbolqJgKLRBat4RU2
         455VyEWqlpTWu53aakCi//wLqAJhgqQBu2qrEvyLYP8xV24Gf+AR4NIADu6wqkVAmupu
         ZCZisShniqjs8RK6EodlxrSenjYKdRCYeRvyOH91P6NGHroaRdiCOHXNuokwJGcAXLH/
         +ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689679712; x=1692271712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJzMzEpgcfTGMfv1gl34ORzO1G62V99e1OasbGiTK8o=;
        b=Ds9nfyFWHKKtUdIPPI4R5rOn+hBCmHBPsm9viSaRGKx21GTXlDvEFHiA0oz4fsrtU6
         7NyLMruk5zpq/KjZpmEmOeD8Nb7pRsSF1DhF2TtmMH1MFtf7bPcp/30W4mra8y3rGI7W
         3sLi7Wvtc0DNlo+5poFLZEfVoa2vZwS2ym2KxWgztsOewzCGkCbg+Wt0OJLNAaNDwggv
         ivfnzjpY9lOdEfCuPPGA/E0IT8K8gb2MOCQ0P0aW0I7loO+dMmqGV6Y+pFHKEXNoLhjy
         SS2dtsu7N6yQdg/ov/HOsd+MZ7oi9/2CU1iafqLyo/aRVogJ6wmSPaWsJqhaeG8oUpaU
         G59Q==
X-Gm-Message-State: ABy/qLaf0gV35ZHF6inulKygKuBmwAY6CKlVGbspiSfSD4slCN3byp8s
        p2L4N571DHnyUY+atDGx5BnyjXcCFpU=
X-Google-Smtp-Source: APBJJlFBtooWrm7dU3QzTEdD53zihCfebB6PfxBMXJduvyzdDjpeoSSNixcQtPfetxqfAHD24C4NrA==
X-Received: by 2002:adf:dd51:0:b0:314:4a15:e557 with SMTP id u17-20020adfdd51000000b003144a15e557mr12788974wrm.5.1689679712282;
        Tue, 18 Jul 2023 04:28:32 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id x12-20020adfec0c000000b003142c85fbcdsm2155433wrn.11.2023.07.18.04.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:28:32 -0700 (PDT)
From:   Andre Werner <werneazc@gmail.com>
X-Google-Original-From: Andre Werner <andre.werner@systec-electronic.com>
To:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v3 1/2] dt-bindings: hwmon: Add description for new hwmon driver hs3001
Date:   Tue, 18 Jul 2023 13:28:09 +0200
Message-ID: <20230718112810.21322-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the initial description.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>

---
v1: Using separate dt-binding hs300x.yaml
v2: Reviewer recommends documentation of driver dt-binding in
trivial-devices.yaml because the driver has no special properties
to describe.
v3: Simplify description of sensors compatible
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index ba2bfb547909..96eb59e56eb7 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -315,6 +315,8 @@ properties:
           - plx,pex8648
             # Pulsedlight LIDAR range-finding sensor
           - pulsedlight,lidar-lite-v2
+            # Renesas HS3001 Temperature and Relative Humidity Sensors
+          - renesas,hs3001
             # Renesas ISL29501 time-of-flight sensor
           - renesas,isl29501
             # Rohm DH2228FV
-- 
2.41.0

