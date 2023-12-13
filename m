Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1292F8121FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442841AbjLMWoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbjLMWoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:44:39 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716CA2125;
        Wed, 13 Dec 2023 14:42:26 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b9e2a5e8faso14820b6e.1;
        Wed, 13 Dec 2023 14:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507345; x=1703112145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maOKTDIEk53dJJsg1tE4bXh8KPN9eThMiSDLUEOZOEA=;
        b=sPBosREDFh+EzpNqt4rwcnANR3ZWb37qA9SRxfuU+L56wn65oVlyEkWD4Xtq7wXFry
         FXj2T39CKsZXwaQ03U133OsNKKjGNj1r81AHUrd9X165mZwymlJwXErYCI2JqZUbZMLZ
         4XdQrEUWNEhu0rCTlsyCPMLCb/4rTjN7MVc5uGoPtRI8Jag9TifQ3xpNpd524WFRLUV8
         mYDP9Nf+yiHpHdT8fucB/Fyt2akjcUPGqupEhb+Lm+2Ln4NCTQha9ABE5B32aN56ljK9
         ptdNlwxr/XrMS5zlJ6HqjMWXaYALvm8SLZeV1159f6c+s7hsOkrxh7sV4V4SXtbjNL4u
         rzpA==
X-Gm-Message-State: AOJu0YylyJ0PkXHgHMp7vfIOndJ7pWZnWpvtPiuoaozZPi0jW0yjH1pE
        OrCLlMhUAfngLw05Se0XMw==
X-Google-Smtp-Source: AGHT+IFhc2TiPyyyiqXGpdf2XNgz6JFD40p7uUQKwPCLtCujLO8EITVcRyPX6PPwx9fDVVg8STBkCg==
X-Received: by 2002:a05:6808:3020:b0:3b9:e287:580a with SMTP id ay32-20020a056808302000b003b9e287580amr3894637oib.27.1702507345520;
        Wed, 13 Dec 2023 14:42:25 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l22-20020a544516000000b003ba254def36sm489744oil.44.2023.12.13.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:24 -0800 (PST)
Received: (nullmailer pid 2191859 invoked by uid 1000);
        Wed, 13 Dec 2023 22:42:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: sdhci-pxa: Fix 'regs' typo
Date:   Wed, 13 Dec 2023 16:42:19 -0600
Message-ID: <20231213224219.2191721-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct property name is 'reg' not 'regs'.

Fixes: ae5c0585dfc2 ("dt-bindings: mmc: Convert sdhci-pxa to json-schema")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index 09455f9fa8de..4869ddef36fd 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -18,7 +18,7 @@ allOf:
             const: marvell,armada-380-sdhci
     then:
       properties:
-        regs:
+        reg:
           minItems: 3
         reg-names:
           minItems: 3
@@ -26,7 +26,7 @@ allOf:
         - reg-names
     else:
       properties:
-        regs:
+        reg:
           maxItems: 1
         reg-names:
           maxItems: 1
-- 
2.43.0

