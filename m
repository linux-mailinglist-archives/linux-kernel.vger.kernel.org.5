Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65B7A1717
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjIOHPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjIOHPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:15:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60117115;
        Fri, 15 Sep 2023 00:15:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c06f6f98c0so16329175ad.3;
        Fri, 15 Sep 2023 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694762129; x=1695366929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPt+lflGxmD7kew86V+AaK7Q6nPGEAHxfdx7vSqNo0w=;
        b=ANaTPxcQofAhoSZo/2/yIQ6WSDH+xFZdb8dos3AtdWIArBZbslu1Lh5r4KqddMalPB
         QVVZHQ15F0x3EFuKlJlXkcNSoCSmYNj7ejo7iczNd1VjkHB4zjobrfkLTdSKyUippwvw
         E5Bvq+EIoNM+auX6L5vYu7YfY0jUq1+MOAkeIV119tZ/LEG9RsM4Hqm80494+B7ss+pI
         O8NjrcpztaXoxbbIZNF+g9+h4mD8NRTQ3CGkQZYLzWuCtfJ/85oGkzXwFiJLcHOlO7nE
         Ab2KJhvCHCEYHTsmbpapmSNDHTb6+tyT5Dxdnu295CKqaUgLRxr9tHzsRpPqVvC3Psv5
         p+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762129; x=1695366929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPt+lflGxmD7kew86V+AaK7Q6nPGEAHxfdx7vSqNo0w=;
        b=gc+eajuZTXFkUgqm1/a8K17T8Qn8X963vfF43pQdS6TScaKJ6fyXIHV5J3D6o9Tl8g
         nZaU1xHVv0Bv7yPy6vdUOxThcwrrlbwH2rUwGr7sc9+Smj/C4hfw4O/1TROXVvpjEg0e
         POjLAxynDCpDx4eZJXjQbT5eTfVVar3C3WBfBO1SKLFgXK5koF29ua3a5pLKVk8C5s0r
         V+cHE9QE5Fnk2JhZj8rvLIxCnJpFL4TbE7ztb4fHN9LyQn0CK16/YyNCxfNbyyK8lvNX
         lulVUegHa6ELqpdXqq5AXTt/eloWSqEB7TCoJyyMjfya1T1R1Wpzr9SVfouKgXHnC08a
         8+CA==
X-Gm-Message-State: AOJu0YyOom0J7tHcfzY6kMc3GOtGzgDT8xwFJOZ0ORBW+8HPJF/LkS3x
        sGiB4Hu4VPPEK7hYkKQE6N0=
X-Google-Smtp-Source: AGHT+IFCdr2RrtfYmIsOzqNUg5/c7ZTKK3DcpYDUDxfJxaRuGC+qz4+2B1LFXLrvhMSnOIofAHGA+g==
X-Received: by 2002:a17:902:a3cc:b0:1b8:1bac:3782 with SMTP id q12-20020a170902a3cc00b001b81bac3782mr889683plb.6.1694762128648;
        Fri, 15 Sep 2023 00:15:28 -0700 (PDT)
Received: from localhost.localdomain ([222.95.63.58])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902789700b001bdc6e13665sm2723958pll.275.2023.09.15.00.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:15:28 -0700 (PDT)
From:   Wang Chen <unicornxw@gmail.com>
X-Google-Original-From: Wang Chen <wangchen20@iscas.ac.cn>
To:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: [PATCH 02/12] dt-bindings: vendor-prefixes: add milkv/sophgo
Date:   Fri, 15 Sep 2023 15:14:09 +0800
Message-Id: <20230915071409.117692-1-wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new vendor strings to dt bindings.

Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
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

