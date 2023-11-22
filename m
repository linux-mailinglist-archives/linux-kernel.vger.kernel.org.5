Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0D7F5396
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjKVWoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjKVWoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:44:19 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD88D44;
        Wed, 22 Nov 2023 14:44:13 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35af2b4242eso1007745ab.2;
        Wed, 22 Nov 2023 14:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693053; x=1701297853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jv+I5ygeCBBH4i6/1z/VsQ04aiJmZYKY8Xf1D0sEDB8=;
        b=KASjoie1S474SY2KC3TTJDBXpFAdN0ZMergC/rTCR09HMyHA5wAS9URLAl4KfDJ1ln
         HoRNDfqJyA0DLDfn0A6jPCJWOcIPcnHa9x2aXQRBANzDuaCCRrYX3DbUa0siE+YONLj/
         SwZSyF8HT4jE2mOwGeSDAwkV6D7B3xklRRbnr5LOnUBIX+Z9q52Ct+sQ6+ksxluyXBtP
         hy9164x2Uqm0A58V8VjLc6EUXJW1v7dmIBVVROHlAykuQizRRGyqS71OyKPNMxkRXOi9
         uN3/MIzrAolrdIN0LeFLMYuOUxbxvQ8tOKH4XKzV+QoaV5I3exaQJ2Z3amvKHUc0q3Yn
         063g==
X-Gm-Message-State: AOJu0YwJIGtf3+LmqNg/cqsa9TWnw9XmTCDpTgAXFIgfpyyAJKk3Xywz
        2zBhWIRNlVdfM7K3f87gwKeHHaEfkw==
X-Google-Smtp-Source: AGHT+IFZX4h000rselaaWAr+ZwBLVTs0wSmY8oE1uFHQtmznbb/dbTuUk+6opx72ZK9RwAc/mqw6RQ==
X-Received: by 2002:a92:c685:0:b0:358:104:679d with SMTP id o5-20020a92c685000000b003580104679dmr4125263ilg.28.1700693052953;
        Wed, 22 Nov 2023 14:44:12 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f5-20020a056e0212a500b0035af9ec3e50sm172702ilr.48.2023.11.22.14.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:44:12 -0800 (PST)
Received: (nullmailer pid 2809108 invoked by uid 1000);
        Wed, 22 Nov 2023 22:44:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: renesas: drop unneeded quotes
Date:   Wed, 22 Nov 2023 15:44:08 -0700
Message-ID: <20231122224409.2808999-1-robh@kernel.org>
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
 .../devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
index 8271e7b2c162..8b8e4e1a000f 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
@@ -20,7 +20,7 @@ description:
 
 properties:
   compatible:
-    const: "renesas,r7s9210-pinctrl" # RZ/A2M
+    const: renesas,r7s9210-pinctrl # RZ/A2M
 
   reg:
     maxItems: 1
-- 
2.42.0

