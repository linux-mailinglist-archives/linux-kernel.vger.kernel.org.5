Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F679762AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGZFRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjGZFRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:17:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6648C1FF2;
        Tue, 25 Jul 2023 22:17:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id ca18e2360f4ac-785cbc5bfd2so316303039f.2;
        Tue, 25 Jul 2023 22:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690348625; x=1690953425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPYKx33gkKK6ihReNB0YWeTCKH/1xjgrNd1OWQ9D+48=;
        b=F8f18zSUxUJvKX5dCgBjqUC0AmlalXOJQ68FrUH6OTt9AEgk44T9q+3eUr5N2yhvXh
         tgHFGzcjSS3/t1j1zyKdT2naI0nqFCO2CUtMD0sDDgWJ9jTHBWyp4XH4FHNZkoi8iFz6
         PyKd9MwReFq/iPBRbeWYFL8x8Wp0m5PAjr5JRhUvKJHpw0skMVM+LVMlZvgmN0b0BQGI
         hW5jpFByXxZHkE3lBIca/7XQVyYfdg/pp1yS67tICSW07tYldC6nV8e4jr48rLH+0HbJ
         1Buu6lQy9lZOffh1OSLSlz2hjdSEeTfKvarZ2nOuZJU1Afnvt0ekFZ2uu8O2d6SHkpjN
         DnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690348625; x=1690953425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPYKx33gkKK6ihReNB0YWeTCKH/1xjgrNd1OWQ9D+48=;
        b=EZWtWKxmju/V9J0Yl0AsN4nt4Le5ijZZJd3D+K9U0mTJdhw+UsGPxweN7YURp+4GU9
         kEIAbsuEohZ0gQoVyxtlzMjjS9IxKqOxnPwUgwMzy1K0ionzAdAtK/nXzYxReKLgHIhK
         JIsVhjbxPLZZjWghAIRFhT7PM/kiKZ4rEkRYcYSVix/Zj58TWtKEe+kC99ysFZT9uXMR
         QXdVdzRhYUZ1OjHh+bZaEsIQE0QohOoSNK0zGqgT1INz+BuPc7TP9r5JrzEd8QCW/Z0R
         IVwWgK0PiZLnRn41VPtnsKEr7fwPDMualw9J7r+BB0jXgPoN19LqltfdU+xA19AssrA5
         EKrQ==
X-Gm-Message-State: ABy/qLY8l9ZhNJIjzVm9XfmGVRP4k0ljgtDINdpCvQsEuYaSIWH4PKdS
        AazWH+y7Fq1LnMQTRiE6S4AnVgitBRQy+Q==
X-Google-Smtp-Source: APBJJlEBHJpiCadpe6EljDY03VDLIRzVXuOI8kJ+Nj02QPZWynQi9qEIQHmZXaklTyGVl3jFRaBTMg==
X-Received: by 2002:a5e:a801:0:b0:785:d28f:1526 with SMTP id c1-20020a5ea801000000b00785d28f1526mr1010201ioa.3.1690348624786;
        Tue, 25 Jul 2023 22:17:04 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id q13-20020a5ea60d000000b007836c7e8dccsm4493949ioi.17.2023.07.25.22.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 22:17:04 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: hwmon: Add description for new hwmon sensor hs3001
Date:   Wed, 26 Jul 2023 07:16:34 +0200
Message-ID: <20230726051635.9778-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <0f32155b-bcc1-4d9e-bba9-058d63194abc@roeck-us.net>
References: <0f32155b-bcc1-4d9e-bba9-058d63194abc@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Werner <andre.werner@systec-electronic.com>

Add binding for Renesas HS3001 Temperature and Relative Humidity Sensor.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
v1: Using separate dt-binding hs300x.yaml
v2: Reviewer recommends documentation of driver dt-binding in
trivial-devices.yaml because the driver has no special properties
to describe.
v3: Simplify description of sensors compatible
v4: Change patch description

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
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

