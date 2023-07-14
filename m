Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E847534ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjGNITJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjGNITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:19:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5F112D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:19:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31441dfbf97so1828709f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689322744; x=1691914744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6rkw/d3NUtBafblKczwAEcy96n0x+1MYdeOk8yK+6k=;
        b=MHJoUKOhwKAQ7wFX1MRaWJ9nMOhZRndFHlfeUyd0oWsPlxA+jT9EYx8k/6Y9P3idRk
         z7B4yvCTNfzRuwwHG6AmfvCFUe+a66634dwX8yQt3ofAkF4Q8s3jmeT54r7+I3zq6HlN
         90oJ+SunUU97ACXJFilGucB/UvablPM3Z1p5f40P3ohfUOp6J3NartY5L11gnzJ+Wt+7
         nHs+ImIdScLYVwZkXqfHsuBGUdJUVYFEvKERdrrIAt3YC3x12A3VmyFGzg5RGLN5SpPB
         dWkhr7QDmqxXRw/wAsr+cvn0JC9FheQwsMokAwGxTkxPDWh+T57kGYHugmu94hzDz6ZE
         FEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322744; x=1691914744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6rkw/d3NUtBafblKczwAEcy96n0x+1MYdeOk8yK+6k=;
        b=Pdl0l0cb8e055P3SRTQMDY9nff2yPF+ptLgU9Q2t15A7cshZk9zdZaYouXzz1x3krX
         TUv88fAtePxyl1LTSD81IM0fmxr8wPIdahClirX6uKnYDvDF6UEh9+6bBp3ZxlNyptBn
         eb4yatMFdbk36MobuL02y4aUbQgqq4BqiQiJQrgWqiihxxywdryCvzH1xi3BQzbjzdoZ
         GB9FmXQSB/yDNH2WmZS1ZORF4V7X3KzQYnZxZ8hswSr6LRqKnOgQ2M6ATkey5ipcBUOi
         SNq7fHmGZkuZHTRVcNAkHYdvufXfnIVUH1VCKkP/quLBh8NuitJH3qErxuy14eOY+KDN
         NelQ==
X-Gm-Message-State: ABy/qLZO8UpWblB7km62eunF+JHR4T3OzpJuWxgjwcxuo3DRChqgUW8I
        kjiHTs2eKnQkxOkzr+TADddEng==
X-Google-Smtp-Source: APBJJlEKqU1J2yGOt6XwTChfB3zLqIdH9NO4jSnyb9Tgl7SxnTOCCaF5J/DtMjOpYX3xWK41+zbhGQ==
X-Received: by 2002:a5d:4e85:0:b0:313:ef24:6feb with SMTP id e5-20020a5d4e85000000b00313ef246febmr3679680wru.3.1689322744461;
        Fri, 14 Jul 2023 01:19:04 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d6810000000b003144b50034esm10143635wru.110.2023.07.14.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:19:04 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: cypress,cy8c95x0: Add reset pin
Date:   Fri, 14 Jul 2023 10:19:00 +0200
Message-ID: <20230714081902.2621771-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch adds support for an optional reset pin.

The reset pin is used to bring the chip into a known state and has an
internal pull-down, allowing it to be left floating if not needed.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V3:
- Update reset-gpios description.
Changes in V2:
- Update subject
- Update reset-gpios description.
---
 .../devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
index 222d57541b65..7f30ec2f1e54 100644
--- a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
@@ -51,6 +51,10 @@ properties:
     description:
       Optional power supply.
 
+  reset-gpios:
+    description: GPIO connected to the XRES pin
+    maxItems: 1
+
 patternProperties:
   '-pins$':
     type: object

base-commit: 3bc551a3007a751a53bfba5b37fa16157f4fb861
-- 
2.41.0

