Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79F7F539A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjKVWog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjKVWoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:44:30 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F110C3;
        Wed, 22 Nov 2023 14:44:23 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35b048479b2so948095ab.1;
        Wed, 22 Nov 2023 14:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693062; x=1701297862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2Wb9fqX5wGIqyOWlMFehAorYquofRBtljUq7UG2Sxs=;
        b=wBiw8X25DUWnj6XN6JjrOqvHW1jW2Vt3l49GLn4RYWx/v1HNY/d96Q3uYf6dGzNOSo
         QaJYYt7wJgVMqLIjVvUdULgCPY3rInhvRGBnBWPP8v7T2zNtqKudIvaWOnkQ9cCPDcn+
         j3C0/PeHCi0dK8kiuzTiN3270mV/vpYY/eFFuVz4MkBnDFg/s6XPYTGUYLa/Wn0X0kw4
         lY9aVbQspc+AlT/WQRF1AMnQY4Aey+B5DSg+U2KQujApwKREZJkm4pjtPhQE2AnlLvRS
         9qpc9DLyqUfpmOo57DlJGwDSxxSjtM/xFoIyydJ8bYRoTS2Pd48x+vw6FnB1nqXEWJ27
         +f4w==
X-Gm-Message-State: AOJu0YwV6bdg+NvzbXRJAkZpo7NVI1DTgrhyWXyiHrkZ4+Sc5H+6s+Zp
        o97PTNwJwY7oaDEBpGJt4A==
X-Google-Smtp-Source: AGHT+IGFm0+j6e3UUQrpEurWryCYqQBPZdAFwcs+dwxaPeUhVSu7HXz3MZ7wxMS2VPJ2uEwMCVqw5g==
X-Received: by 2002:a92:c26c:0:b0:35b:2216:5c80 with SMTP id h12-20020a92c26c000000b0035b22165c80mr5377162ild.23.1700693062511;
        Wed, 22 Nov 2023 14:44:22 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id bl9-20020a056e0232c900b0035aa4b0d786sm179029ilb.25.2023.11.22.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:44:21 -0800 (PST)
Received: (nullmailer pid 2809435 invoked by uid 1000);
        Wed, 22 Nov 2023 22:44:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: fsl,dpaa2-console: drop unneeded quotes
Date:   Wed, 22 Nov 2023 15:44:19 -0700
Message-ID: <20231122224419.2809361-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
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

Drop unneeded quotes over simple string values to fix a soon to be
enabled yamllint warning:

  [error] string value is redundantly quoted with any quotes (quoted-strings)

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml b/Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
index 8cc951feb7df..59b83ea5e05e 100644
--- a/Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
+++ b/Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 properties:
   compatible:
-    const: "fsl,dpaa2-console"
+    const: fsl,dpaa2-console
 
   reg:
     maxItems: 1
-- 
2.42.0

