Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB347F51ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjKVUya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKVUy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:54:29 -0500
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35E41B6;
        Wed, 22 Nov 2023 12:54:25 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b357e43cc2so4868139f.1;
        Wed, 22 Nov 2023 12:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700686465; x=1701291265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMigwRCl9cvB/xNDkbop+XVkst+C2D3BmZfFKptDyQA=;
        b=DmVeZefRZkR0WN0L1Xakuj4ZbXEFR+bUMCRijS3dIZ8ahDJqB+n3DWfH7VS5Oj4c8n
         7qU3pODx5T92L3wsz/4jKoEDBTSARg/QMdvVBMfkRNB7IQ54JFxBaHcRZH6S6aziq/i0
         /EsPPXRI6wH+b6HUTAA5PMlfb3IaYXPy7lehWoW0Jr9rOtWqEvb8yvYPpGTvRHEMxF21
         Tq8vx40030g8mSgQhs05QeaR3zNujErh2TcCtVt4eXE17R+Sf6jhW8Gu2jObzhkCimZG
         KtXS0DCaB/fyzqJNs8TG2HtkWf6gcQCa1stw18kHqhy1rzuA4NhqxUwCag8BPlxhLu1d
         uq2w==
X-Gm-Message-State: AOJu0YzB1bsWx42UmwjOoWlmWxTHtQx5zM6IeOrMwGO8jslWppZf3OTJ
        xfPqiTd48hsX7zH+xugghQ==
X-Google-Smtp-Source: AGHT+IEfs9wZwAwxOmk2mhbLaZGPtT3oP1ybvHZWzMFXDzxC9VFGXHNGv0KeikuqcSKifzyz0PrBmw==
X-Received: by 2002:a05:6602:4818:b0:77e:3598:e516 with SMTP id ed24-20020a056602481800b0077e3598e516mr4354070iob.2.1700686464931;
        Wed, 22 Nov 2023 12:54:24 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p21-20020a6b6315000000b00791e6ae3aa4sm3648343iog.23.2023.11.22.12.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:54:24 -0800 (PST)
Received: (nullmailer pid 2482230 invoked by uid 1000);
        Wed, 22 Nov 2023 20:54:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: leds: Fix JSON pointer in max-brightness
Date:   Wed, 22 Nov 2023 13:54:17 -0700
Message-ID: <20231122205418.2482076-1-robh@kernel.org>
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

A valid JSON pointer should begin with a '/'. The json-schema package is
lax on this allowing either form, but that's changing in new versions.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/leds/common.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index c8d0ba5f2327..55a8d1385e21 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -167,7 +167,7 @@ properties:
       Note that this flag is mainly used for PWM-LEDs, where it is not possible
       to map brightness to current. Drivers for other controllers should use
       led-max-microamp.
-    $ref: /schemas/types.yaml#definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   panic-indicator:
     description:
-- 
2.42.0

