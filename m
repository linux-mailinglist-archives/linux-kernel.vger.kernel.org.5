Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382197A173A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjIOHYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjIOHYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:24:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E647173B;
        Fri, 15 Sep 2023 00:24:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26f38171174so1461209a91.3;
        Fri, 15 Sep 2023 00:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694762665; x=1695367465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FJzMSRsFGWXl1x3CI8KZnuJ0K/8zXSh3L5yWA+KvyC4=;
        b=H36TSCYru5Nyi993We+I5CLzV28MSNbyjlTVMteZVLyaQrgndIdaWvao2kOaaQLQuO
         JdTtm/KnceqkJdXcL5LUPfNKNoG8qBrdYk8gXoVYyuafWm7MH0KHLYYUiHx98twwEiC9
         zha07xfsaMtYmGGEBs1qhSVO/gLmpD8eIQlfN5rrknhEETJhFEXE+YdeEehGaiFmu1UP
         vpgB7enaxWAPPoG7uGbKhvYrDwkSgMQFgG9DZLtktdWwVBLeeofEVyDHx1gd6LRj0atZ
         7+lvTlWQirXUwIUyXwkVQbTW0As9vc4UNaKz6w+LFgV4oZA1g3NMHT17aPrR+OEt2JGC
         fINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762665; x=1695367465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJzMSRsFGWXl1x3CI8KZnuJ0K/8zXSh3L5yWA+KvyC4=;
        b=NwvJu15/AhwnMegxiB9jjtx/916FKAq09x+RSo481fa99cwQqCnGWheK/vSQYyyDRo
         aB1JeytdEQFSxRMAPi3OSddc9FuVtJMmBs0XPgO3n3hNWB6V2BQ5hnsZpIDv46X+UQI0
         Nks4ABZyuGZI52nx0m6kW0vtsUbrfjCFO4u0EhbpVxdXHJIEksH/W8thjPQfGO9y6GEF
         XmI24uvzLSUfd4YRFajgu716EYTi+FbwzncynpRe5fn0Bhkh8ABycs3CuzcgRuw4WWyM
         513VF7Ci3A0+o0iXl0UeoDQppIL2a/TMwE6jLgEIEaMvP4h7RjQ8RviXtjyYh4cA5Dhk
         YiLg==
X-Gm-Message-State: AOJu0YwA5QItpzyQ8gupIw4i71viwUoMPNuQnb++MSYXzlKrTTd+kUCW
        YF/51A/h7SjGH6ldbepZn8g=
X-Google-Smtp-Source: AGHT+IGcjDGq/pgBeaCYUPSCvCko2Srj453SkMBJJGtrdJ8Q+8SCbaXebokzJrDTdZf7vscyLfhB/Q==
X-Received: by 2002:a17:90b:4a0d:b0:274:862f:3433 with SMTP id kk13-20020a17090b4a0d00b00274862f3433mr656664pjb.18.1694762665416;
        Fri, 15 Sep 2023 00:24:25 -0700 (PDT)
Received: from localhost.localdomain ([222.95.63.58])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b0026b420ae167sm4590589pjb.17.2023.09.15.00.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:24:25 -0700 (PDT)
From:   Wang Chen <unicornxw@gmail.com>
X-Google-Original-From: Wang Chen <wangchen20@iscas.ac.cn>
To:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Inochi Amaoto <inochiama@outlook.com>
Subject: [PATCH 06/12] dt-bindings: timer: Add Sophgo sg2042 clint
Date:   Fri, 15 Sep 2023 15:24:15 +0800
Message-Id: <20230915072415.118100-1-wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
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

From: Inochi Amaoto <inochiama@outlook.com>

The timer and ipi(mswi) of sg2042 are on different addresses. With the
same compatible string, this will cause a mismatch when is processed by
SBI.

Add two new compatible string formatted like `C9xx-clint-xxx` to identify
the timer and ipi device separately, and do not allow c900-clint as the
fallback to avoid conflict.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../bindings/timer/sifive,clint.yaml          | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index a0185e15a42f..2a86b80c3f1e 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -39,6 +39,14 @@ properties:
               - allwinner,sun20i-d1-clint
               - thead,th1520-clint
           - const: thead,c900-clint
+      - items:
+          - enum:
+              - sophgo,sg2042-clint-mtimer
+          - const: thead,c900-clint-mtimer
+      - items:
+          - enum:
+              - sophgo,sg2042-clint-mswi
+          - const: thead,c900-clint-mswi
       - items:
           - const: sifive,clint0
           - const: riscv,clint0
@@ -74,4 +82,22 @@ examples:
                             <&cpu4intc 3>, <&cpu4intc 7>;
        reg = <0x2000000 0x10000>;
     };
+  - |
+    clint-mtimer@ac010000 {
+      compatible = "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mtimer";
+      interrupts-extended = <&cpu1intc 7>,
+                            <&cpu2intc 7>,
+                            <&cpu3intc 7>,
+                            <&cpu4intc 7>;
+      reg = <0xac010000 0x00007ff8>;
+    };
+  - |
+    clint-mswi@94000000 {
+      compatible = "sophgo,sg2042-clint-mswi", "thead,c900-clint-mswi";
+      interrupts-extended = <&cpu1intc 3>,
+                            <&cpu2intc 3>,
+                            <&cpu3intc 3>,
+                            <&cpu4intc 3>;
+      reg = <0x94000000 0x00004000>;
+    };
 ...
-- 
2.25.1

