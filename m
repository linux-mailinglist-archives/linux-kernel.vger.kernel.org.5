Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C677A72DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjITGho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjITGhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:37:41 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD2AD;
        Tue, 19 Sep 2023 23:37:36 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3ab3aa9ae33so4451579b6e.2;
        Tue, 19 Sep 2023 23:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695191855; x=1695796655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ6NBSLffyQDUyw9Nsh5Ze1xMH7VpdACEUTAmC664ss=;
        b=RyJGAXT/xyjhTCGMHJNxTOJy0eYvv85XbqKb37HKqVfHcd6ESe50MoPrHHrtTb8uGH
         8qvyogFkjo/1NbPe5/+Dy7nLju3ZAB7xpqq3mIzkCJO45WmC1pGQkTS1y4koTKNM2dDA
         V25GjTTt/2zq9JIvB9jNuanaBmfkrexPfHFIXtpavT2TgR2qQztjyjrsyhEaRoFyM22c
         NErQ9+L5ZEVvlfzMF2643tbeDuAq42T8PXShwnnPuKFqp4LRU4tJfpCZf2XoyWhVGE/X
         v/j9qwTegoDxopAiukhRze5zL5hetrX+JnhzUIZfP5XceSVvUmfpQ8tXJCqFd8lXcPjy
         YAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695191855; x=1695796655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQ6NBSLffyQDUyw9Nsh5Ze1xMH7VpdACEUTAmC664ss=;
        b=mof6z+4rQYapDymYycFckDXNTAfV/BESS9iLigv2luHd3Yfwcvsxt90ePLBedvYcL+
         gAC4XmXr1p3p6Kk8j4bnSv0ZZQs8DZYssdnVBlZa84gLPAq4qnGByBr7eg+uinKUhp+P
         ZCbn1Msk8FHV2zeVXIpFMf5lSUl6T6A46j5byUJSLwJMvP+sd3P3OKMC7IDTGLRD3z5Q
         08YDRSyRfRZuQz93lk3a46QK0aoQ2JE8Y8mCRv2iI7aBmqDxD0iKDjTFjnRkpAa44duK
         vin86uBViZtTduqiVXI0OWdVkN2YuV4lpAVJcCac5+vtw3Nki0BR6bD2Krt2jqkVHAML
         AbQQ==
X-Gm-Message-State: AOJu0Yz/l+bXAsCdReHiM6TeZX1YzJulokW3+nQKUERh8MNVGxpTT/r4
        ZP69eiH4nnEXLVL9MRQGIkw=
X-Google-Smtp-Source: AGHT+IE662iIMmE8Tx/TZuSvjCwuu2ZkKy5EsZzZZdv5EWqCqxMdo1lpSdW7efhxPf78AjvV5AejEA==
X-Received: by 2002:a05:6808:23d6:b0:3ab:81e4:4da0 with SMTP id bq22-20020a05680823d600b003ab81e44da0mr1636330oib.42.1695191855227;
        Tue, 19 Sep 2023 23:37:35 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id m2-20020a0568080f0200b003a75593746asm1717253oiw.57.2023.09.19.23.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:37:35 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
X-Google-Original-From: Chen Wang <wangchen20@iscas.ac.cn>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v2 02/11] dt-bindings: vendor-prefixes: add milkv/sophgo
Date:   Wed, 20 Sep 2023 14:37:28 +0800
Message-Id: <dbd7d823a73d8a9484efcd55f6616f5392daf608.1695189879.git.wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695189879.git.wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
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
- Sophgo SG2042 SoC [1]
- Milk-V Pioneer board [2], which uses SG2042 chip.

[1]: https://en.sophgo.com/product/introduce/sg2042.html
[2]: https://milkv.io/pioneer

Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
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

