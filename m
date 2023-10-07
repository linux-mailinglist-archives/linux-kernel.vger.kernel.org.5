Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F48B7BC5D4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbjJGHzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343739AbjJGHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:55:36 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56BEBF;
        Sat,  7 Oct 2023 00:55:35 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c67060fdfbso1995213a34.2;
        Sat, 07 Oct 2023 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696665335; x=1697270135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Srl7q1CDQqnOcA8A4KoDbSUD1lo3jJe2F7cZabOFURY=;
        b=HHuBOwlsTSRMSoV60v13/ntlUOqzPHt9VuiZip4Uj/jzp+WBo6JiM7wtD8v1npFiPQ
         LLa/qgUXm/xDrojyN2EkYwe3mqjTek/Uk+HJQVJ4YUgt6vn97UCEou8rJ8whyuiomwA0
         LGO2tjzhXl7hSs8VKCZyKTxBRBmhLWwdFe9zSGsOJQlpR7GUm1fYDZqdxMY4FEmkOQVF
         ZbUN1PpnDm3wFocViw7YhX3FCPrVOXoqw7D9//dpS9/AdfGX7vWfHH9Ab9JgaGaZn5Z+
         w63IQbSq2KdAoQ1urusc460FM1u93uXG7buA36quIRbZ2xsUzAog1troMQoziKzkzU4a
         6+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665335; x=1697270135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Srl7q1CDQqnOcA8A4KoDbSUD1lo3jJe2F7cZabOFURY=;
        b=XDl3sW7ILifI44TqoI8blkcsM7aFUbbDtMwH4L4jhAxQ55K1Xc+u4IfRlv2nS9wWos
         TZm+x8gUCcVkj6Fd4CcpKp5XgRjookoSrevmuteZr347QyaR/3RPzM98qA9dzMLYhdW/
         lLvi1IkrzoeKIeq4fD4mu8ESvq/ICcbkqPt/9xcNTdUZ52b5yy7pBgBylvOTd0Vv6Zuy
         BHNzl8ZcFgXBY9gnX6zNM+CIuiNViclXvMSKnBBVJHJIht8PB2updzqQQ99QsVM/WAvx
         ov7dKWgzJydXImumx0Oze9y1oSCInIbO2sSEuPvhNeK2ddcDVLuMTO0U7yKgVPZt3Kux
         bkFw==
X-Gm-Message-State: AOJu0Yz9qLOwdY2NbaUTpl/bU7fBltUpML78QbFjpKUP//PyijMBdrnA
        p0CD4G1quMfhIHRyrR069kc=
X-Google-Smtp-Source: AGHT+IHs2ohbPpXYA99aB8ELd0gUEDQJsHk9lTEy3E25h+y+yzB9uVSfHjmNczbSroS6r/oWrbw70g==
X-Received: by 2002:a9d:62cf:0:b0:6b9:cba6:b246 with SMTP id z15-20020a9d62cf000000b006b9cba6b246mr10165678otk.9.1696665334888;
        Sat, 07 Oct 2023 00:55:34 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id x2-20020a056830244200b006c7c1868b05sm666285otr.50.2023.10.07.00.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:55:34 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 04/10] dt-bindings: riscv: Add T-HEAD C920 compatibles
Date:   Sat,  7 Oct 2023 15:55:27 +0800
Message-Id: <0783d4e9c9fcea8a84a8a7245f87168d4b698149.1696663037.git.unicorn_wang@outlook.com>
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

The C920 is RISC-V CPU cores from T-HEAD Semiconductor.
Notably, the C920 core is used in the SOPHGO's SG2042 SoC.

Acked-by: Chao Wei <chao.wei@sophgo.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 38c0b5213736..185a0191bad6 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -47,6 +47,7 @@ properties:
               - sifive,u74-mc
               - thead,c906
               - thead,c910
+              - thead,c920
           - const: riscv
       - items:
           - enum:
-- 
2.25.1

