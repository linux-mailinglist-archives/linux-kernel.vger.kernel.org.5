Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4A7D1480
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjJTRCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJTRCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:02:38 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B545CA;
        Fri, 20 Oct 2023 10:02:37 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b2e07e5f3aso1114621b6e.0;
        Fri, 20 Oct 2023 10:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821356; x=1698426156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=em6W/wKA5nIven/0xrneSCPDb3lC+lDEs9feH0KsLuc=;
        b=jYAWQrJfyCEvReJyDSzWDzTQD8MzrzgrO4kQ8vUN1okbkwLza7YTP0Dpxm5D8hHseE
         lWxTAN1pEIEA3HAclamwDp6lsmzt+qvbipB13P0NC59vpquiKI8kXOarq2CjX2OWI0fS
         zMun2v78Nmdb4yIcPa90LKifUF045tpec0lok00aUIvoMjmbIw7XPE9rrXSeTtHAY6qs
         zozVu8OFXSt8QIoII9zhPLhlJFfWvOayJdT7bzJjHS1shkMVdoKV6Oh7SSiEGMGcF2J/
         dX5UH8ROFb8fQ+xxhZ9ojG8gccgwchKWvQNVglIR8by93wlSMj/c+3M2qIXntw9ASsWC
         itYw==
X-Gm-Message-State: AOJu0YzfJMIFrK4pbw4EzTLZ9zSPLodbLe4IqVafPfa39UuTZt2lx7tf
        e5IwU2660Pglc0NEbrvFRg==
X-Google-Smtp-Source: AGHT+IEfleuQMGHz1zdXCLu0snW6Wqv3IOe8sAN1Y4wVWkLk99mTuPYTskpRl6S/76Krg/jY48JnJA==
X-Received: by 2002:a05:6808:1588:b0:3b2:f461:b31e with SMTP id t8-20020a056808158800b003b2f461b31emr1299538oiw.29.1697821356485;
        Fri, 20 Oct 2023 10:02:36 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a05680800c900b003af569ad2c6sm394737oic.3.2023.10.20.10.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 10:02:35 -0700 (PDT)
Received: (nullmailer pid 3633193 invoked by uid 1000);
        Fri, 20 Oct 2023 17:02:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dt-bindings: ti,ds90ub960: Add missing type for "i2c-alias"
Date:   Fri, 20 Oct 2023 12:02:24 -0500
Message-ID: <20231020170225.3632933-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every DT property needs a type defined, but "i2c-alias" is missing any
type definition. It's a "uint32", so add a type reference.

Fixes: 313e8b32c616 ("media: dt-bindings: media: add TI DS90UB960 FPD-Link III Deserializer")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml b/Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml
index 289737721c2c..0b71e6f911a8 100644
--- a/Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml
@@ -69,6 +69,7 @@ properties:
             maxItems: 1
 
           i2c-alias:
+            $ref: /schemas/types.yaml#/definitions/uint32
             description:
               The I2C address used for the serializer. Transactions to this
               address on the I2C bus where the deserializer resides are
-- 
2.42.0

