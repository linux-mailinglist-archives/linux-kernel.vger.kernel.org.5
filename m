Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC747BC5CF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbjJGHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343759AbjJGHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:54:16 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F1A6;
        Sat,  7 Oct 2023 00:54:15 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3ae1916ba69so1930059b6e.2;
        Sat, 07 Oct 2023 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696665255; x=1697270055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+Bt/pK9fjZb2V2F/uxXmZS4s2BES+Pi96M/AbPYC3s=;
        b=gvggehZnaAZntfC16ZHYtPUAuvry48yI2BLOxwtoiRIshGPZANt0OgA+ZZ6QOzwPJ0
         RRYtVeqGXqBi2MLiIKQUpXp97bTJRPsc+COJYqzGx7yN4uoAHBeh4tt+ILuFqxgkLtZz
         6tpLew0lK5znZVBmVHBjZ8g2tw5V0zEoB937k9JnBK9x0q+wVGIUcab8mLZWQpQQOcPB
         WN9skoejsBhYD7kdGb8hd8Gtn7/v1fv0kBAb7hPEaR5n0vZBGmghOmufpfOw8AQ1ezWu
         qjUMECJibEjbAQYiVgj8B6MQ0NkHNbE8Y8DTK0aMWFIBVL1xdulFcBXHkvPBuycFV7uN
         HRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665255; x=1697270055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+Bt/pK9fjZb2V2F/uxXmZS4s2BES+Pi96M/AbPYC3s=;
        b=Vnw3FGdKUV6hi5Q5w2VPZCO+Aa/w96obyuJdq6laAOyuviKeruNHnA6Utl3kSqyajf
         mf+1UsnojyeHLm7BoQfdFkujXByaEqFYp2g+bjigi20YWeOsnu0bp8yVsRqjufTZfWtG
         J3WbKQs1ixEY/qME60pdOxBKLU24JGVfnRJr6lhs7xrnpPub226nGkaF0GZkFdU4X1Cg
         q2XVvuGMqD097pJJKltM5Dz2wuqBRozWTbIsFMlZMtsSLEgog6j2HXmTp/3Tg42ubeq6
         XeX5hI/1mgfLmo7PsUIZ5OMxMJ0jaVjuE5F+1f/qT80MLkwBIfp1+sWmrgqM/LbLZTjl
         a4mw==
X-Gm-Message-State: AOJu0YzszF/K86KZj/cDMBvXEnt8629sByEvEir3xmz9d9a+1Vh95S2W
        QwhXYGmVZAZhRrYX7XvoEX4=
X-Google-Smtp-Source: AGHT+IGYYVSKz8U0XPm2HSLPok86XdRVhk858hg+KaxayfheYI3IX17LDnbk69Fq6lFvj8JkGYy48A==
X-Received: by 2002:a05:6808:1495:b0:3ab:83fe:e18e with SMTP id e21-20020a056808149500b003ab83fee18emr12806231oiw.54.1696665254781;
        Sat, 07 Oct 2023 00:54:14 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id e14-20020aca230e000000b003a78d196acasm899573oie.32.2023.10.07.00.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:54:14 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 02/10] dt-bindings: vendor-prefixes: add milkv/sophgo
Date:   Sat,  7 Oct 2023 15:53:57 +0800
Message-Id: <0aa38ae82ccefe7f3e83a73df93cee75f309efc0.1696663037.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696663037.git.unicorn_wang@outlook.com>
References: <cover.1696663037.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

Add new vendor strings to dt bindings.
These new vendor strings are used by
- SOPHGO's SG2042 SoC [1]
- Milk-V Pioneer board [2], which uses SG2042 chip.

Link: https://en.sophgo.com/product/introduce/sg2042.html [1]
Link: https://milkv.io/pioneer [2]

Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Chao Wei <chao.wei@sophgo.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..fcca9e070a9a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -863,6 +863,8 @@ patternProperties:
     description: MikroElektronika d.o.o.
   "^mikrotik,.*":
     description: MikroTik
+  "^milkv,.*":
+    description: MilkV Technology Co., Ltd
   "^miniand,.*":
     description: Miniand Tech
   "^minix,.*":
@@ -1273,6 +1275,8 @@ patternProperties:
     description: Solomon Systech Limited
   "^sony,.*":
     description: Sony Corporation
+  "^sophgo,.*":
+    description: Sophgo Technology Inc.
   "^sourceparts,.*":
     description: Source Parts Inc.
   "^spansion,.*":
-- 
2.25.1

