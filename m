Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB03F7A174C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjIOH0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjIOH0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:26:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8981FCC;
        Fri, 15 Sep 2023 00:25:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c4194f769fso10945055ad.3;
        Fri, 15 Sep 2023 00:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694762750; x=1695367550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtiQk2mCxeEr3VVOeU3ze8J3wl3kSWve+xDO77CYJdQ=;
        b=hbcZoBcwNZQ6CPKc/D66KDOsf+RmQKCoJuZ0IVap8tnow178Zi1gWjBi0HYFR7JneC
         tkDILHqic5pn83/kniYNWQPmQvJ87HCRgiLp+iC2vJ3pWlKYKF6GJ1vlvLDRdN4i7Mpq
         tcGgmHqbstjTjIZnUm0t8HLNb6QwJ71P5Z1AVfbvHlXfAcOYbgg5QVHqam7AXXFTVipI
         H1xmgHx+YbnHf2v8cb40vjf6xBnbM2a1sNr6Ic3FkXDI2EBm7eECEFM6lKirC4KyeYSo
         U4DdYr51S9IhhKZ6NjNUxn3OyhIvTGxD/E71KsjCDfD+Bz7rdQj4pvzmjJzxBvNKwi0W
         gv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762750; x=1695367550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtiQk2mCxeEr3VVOeU3ze8J3wl3kSWve+xDO77CYJdQ=;
        b=RCPMTm8fZZxa/JKniCI+p3pMtXN3JZQH3J7ZFilxKmQKo7t+Bat5hBDRoPFjUQ34g0
         WjMLRjZ+Uvs4YZY8/fH8inz0xflFbLxsZKS4dkKYHM10OuP+eVH6VWvsHGMRjGNCqkxD
         BlPNk4THICAVLjgtXtGcg77+2QtjJwwxfScWVahfz2/It2/SbBoLdkdPFBptuZDDzuDJ
         9PlMg/ocNXSPiY15eUkr8MnXuzHNvBlrRRbdJ1dn1C2JCy3P0PPMNpyrCNU3txxtZ7VP
         zuI0YeC1FUg/L+099swc/8kM0YC4SpeLGHI1ndEyUZ5OAIccv8kFRqs+BcTrtN6XAU/0
         NMew==
X-Gm-Message-State: AOJu0Yw/1vgrPaoEsuHJ1MyWUHAQBPv35NbrlqpQOF/d1baZiDR+gb4H
        a04Wo5tXFDleVh1sAIJg4kQ=
X-Google-Smtp-Source: AGHT+IGUJ7wF6Ucyfo9RtdakD9EC1ecubcsKAFWo65GxfMTiejWgtDU27K1EotMIcRhWahe11YpKAg==
X-Received: by 2002:a17:903:26c7:b0:1bb:8931:ee94 with SMTP id jg7-20020a17090326c700b001bb8931ee94mr747188plb.67.1694762750322;
        Fri, 15 Sep 2023 00:25:50 -0700 (PDT)
Received: from localhost.localdomain ([222.95.63.58])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001b9d335223csm2768866pli.26.2023.09.15.00.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:25:50 -0700 (PDT)
From:   Wang Chen <unicornxw@gmail.com>
X-Google-Original-From: Wang Chen <wangchen20@iscas.ac.cn>
To:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH 09/12] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2042 uarts
Date:   Fri, 15 Sep 2023 15:25:17 +0800
Message-Id: <20230915072517.118266-1-wangchen20@iscas.ac.cn>
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

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Add compatible for the uarts on the Sophgo SG2042 RISC-V SoC.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 17c553123f96..6c23562f1b1e 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -48,6 +48,9 @@ properties:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
           - const: snps,dw-apb-uart
+      - items:
+          - const: sophgo,sg2042-uart
+          - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
 
   reg:
-- 
2.25.1

