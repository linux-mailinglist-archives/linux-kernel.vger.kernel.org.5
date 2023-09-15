Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC627A1738
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjIOHYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjIOHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:24:12 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD81A1;
        Fri, 15 Sep 2023 00:24:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so15436115ad.0;
        Fri, 15 Sep 2023 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694762647; x=1695367447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QaNp6vd76nBX4EIgc/17q2XiC73X4sxuT4uDWwfKOL4=;
        b=HWq8sVN8aYaLeJ3nafT1MCwehOldEydiURAYtaD7EPJo0ZFOk1n90ktUZ6xwe5RW3B
         KhSNtpu8Ic65K5WxHyae8G85riEyF+hbDfDf8CPFzyIApgcDD5hTGt+jJQSu8EfHqr7i
         gLvNrDMqxbGxM8CJEDeTTeF3EzRS3H6RutxPip+xyr8cuBFT6rQ9PqXQUC71eoNw8kpa
         /PW5aOzDMBKPo3LDpHhCZRS4QXqW5pmlKX9VSzkMCeg03hP8DlNYA/xzG0lbS66tCoi9
         qImuQWzONYeMPI2DxiyFU13brY0omDzpMunEf4nMd6JF09i1LsBpHXVvlLHHqIcw+r5G
         THcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762647; x=1695367447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaNp6vd76nBX4EIgc/17q2XiC73X4sxuT4uDWwfKOL4=;
        b=sfJqectffRrqCTHTFrRAIuAI+6l5loLsyYpofW/R9MhJYwykdkywJy8R07y+6l5FVI
         GaH7+Co8osTUsODQgYVKallEhNyRN4XD3VsAoKvYg31mzLAEbu11+GMB5X3YxNyb8GCD
         pPVaObVU8B2ek2SGFHstirssY+6cd7xgz+ijj5IU3iZqOXD1NOIHnNbAAQGIq6JB/7H6
         LEtBGmyxXIcwgKoXIBJcAlg0238lrEqwf5K74Omf/cve9zKMywT04UbIw/OcpN4PDpas
         P1DkPv1zrI2+HF/LWf4NCZp6y90B81u7HzvvIMG6Nyk8s/EeK0O+G20W//2fuqqapWSf
         XqAw==
X-Gm-Message-State: AOJu0YyO/Amag3zhXpLzSmRzAea4o8hicqSIScguH6/px5jlGaUbxqsG
        +qmkmDdDl8hPw39eJEg4c50=
X-Google-Smtp-Source: AGHT+IHyv/ddLA7MSNkIAr2jiHyMnYSlV0XYvR0QP7EyYs9q3c9bwg8H3ZjmKsWw+CfJpBwlz9L5jA==
X-Received: by 2002:a17:902:7081:b0:1bc:7001:6e62 with SMTP id z1-20020a170902708100b001bc70016e62mr740375plk.35.1694762647382;
        Fri, 15 Sep 2023 00:24:07 -0700 (PDT)
Received: from localhost.localdomain ([222.95.63.58])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b001b86dd825e7sm717590plb.108.2023.09.15.00.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:24:07 -0700 (PDT)
From:   Wang Chen <unicornxw@gmail.com>
X-Google-Original-From: Wang Chen <wangchen20@iscas.ac.cn>
To:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: [PATCH 05/12] dt-bindings: interrupt-controller: Add SOPHGO's SG2042 PLIC
Date:   Fri, 15 Sep 2023 15:23:58 +0800
Message-Id: <20230915072358.118045-1-wangchen20@iscas.ac.cn>
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

Add compatible string for SOPHGO SG2042 plic.

Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index dc1f28e55266..3abb1f68ea62 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -66,6 +66,7 @@ properties:
           - enum:
               - allwinner,sun20i-d1-plic
               - thead,th1520-plic
+              - sophgo,sg2042-plic
           - const: thead,c900-plic
       - items:
           - const: sifive,plic-1.0.0
-- 
2.25.1

