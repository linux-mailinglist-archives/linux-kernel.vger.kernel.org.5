Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81D7AFF40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjI0JAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjI0JAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:00:40 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBCE1B3;
        Wed, 27 Sep 2023 02:00:35 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3ae0135c4deso6226966b6e.3;
        Wed, 27 Sep 2023 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695805235; x=1696410035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiV1ULQG3s0x2nlhHANe2aPzX+bV/lE/JH9vnJWbNSw=;
        b=WZQlqWb6Qze7sgt7+nLKOCihhdk4Hl9jzQBar+niynpsP0Yg+u2MqalCV8hXS/d4Kd
         LbqRZvP/cRNEJAVydacNP7M0Pjh2nuMLDqFlr0NIdVrhw5tHdV9StAqY+22Xtdxvk7FP
         U+h9o16Y0vXOJ1K3pT2P/Sd7zWgRgSM2w2j6b3kzHLoTQh2YDgFFns7FoNO9cS8l870u
         9vq+jo3NWDkho3+tMw/Kf+Ip+VTTYDI4azOxoGuX5oRB+96hluYvu4bvm3RXFhcvFCRG
         untWG534LNq94lgsS7htuSoWyr6m+LPVTfYg4682q9HtTw0BqDe0CMVzng3jjVXoy01f
         SkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805235; x=1696410035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiV1ULQG3s0x2nlhHANe2aPzX+bV/lE/JH9vnJWbNSw=;
        b=NUdBb4tr7OcgtrobfYFpbQrNXgdQQeVyzYh+21LlzsATGzduvYuWIfiISRZ1Im2SaF
         7fPTdtJlYqH3DUypqUfT5C/emOsIYgb5akucn/K6xTIQEGgrn1iGxoV1XCbVmu/ZmpOy
         If0sqGfCgj2BArQSCvtPY2V/lBROfYyZOJRSOfqijXxAAu9nLfVabS0ZaawuN9062CzZ
         UBDZjNgMgdKyu+Qe8nwHS8C/zTq7kdeTzifdD4Yhds0DklBYif53DSswwmbkwslz/rVW
         y6t9HBGAAhBBzV4kMhyX4i4yAjZLChyCELon8Tkwl7p3zecx5aJ0O7hPr6LVfPB98vi/
         wbHw==
X-Gm-Message-State: AOJu0YwLv4XDvGOTPoPyjt3GKa4G1iwlnSk0oGGiOIqm4lqn7a+H9zP3
        nPYWJWVs6Ln8vlKZnBzNpDg=
X-Google-Smtp-Source: AGHT+IHRLsiqqvilGXV7akKllvlYz9S+uorAcdH6PSFC8vgoeHy/ik7nsmsja3IemwyAGE0aqJ/3KQ==
X-Received: by 2002:a05:6870:819c:b0:1dc:a055:8587 with SMTP id k28-20020a056870819c00b001dca0558587mr1850005oae.6.1695805234798;
        Wed, 27 Sep 2023 02:00:34 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id kr9-20020a0568719ec900b001dd60c202e6sm766131oac.10.2023.09.27.02.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:00:34 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicornxw@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v3 02/11] dt-bindings: vendor-prefixes: add milkv/sophgo
Date:   Wed, 27 Sep 2023 17:00:27 +0800
Message-Id: <df92b2a50cc372098a7a8340e09be4d4cbc664b7.1695804418.git.unicornxw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695804418.git.unicornxw@gmail.com>
References: <cover.1695804418.git.unicornxw@gmail.com>
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

Add new vendor strings to dt bindings.
These new vendor strings are used by
- SOPHGO's SG2042 SoC [1]
- Milk-V Pioneer board [2], which uses SG2042 chip.

Link: https://en.sophgo.com/product/introduce/sg2042.html [1]
Link: https://milkv.io/pioneer [2]

Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Chao Wei <chao.wei@sophgo.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
Signed-off-by: Chen Wang <unicornxw@gmail.com>
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

