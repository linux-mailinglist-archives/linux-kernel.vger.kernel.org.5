Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733B47E3A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjKGK5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjKGK5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:57:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97381720
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32fa4183535so811527f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354586; x=1699959386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiqFYUrrovnf1rhzBHvSluIgSBMGKUT9Q2F8cmlGclI=;
        b=qkxdtbQucEK7DLbiv1cKdTpCrLREePIFWimgYLnxfcHCSbA7Hw/4RlMhTwX/1y8H3i
         2AiDmSFI5R39zutNt6ytF7rgteIp6ZWOcZSOkBaIw2Yft/iUbjHP5yYW0OrFlOl+OhmD
         qj/HHvD5wAp/Tg5wI6GLNdwgE09YsQ5v1vCByiqUjqJjY06RVKGCfYkpAvVYZSUP/ccp
         DvkUxcUGFC3nLlqONCqce/kgc2zhXkFw71pd2axoIKSvio7w0nO9p5mcvIRaSWF4Oayv
         cqw5JLEsEUKTgB4Xrr0sBDAjMmWNXO5X69EVzHR7Dihj2OnZIXZUHCQ3vAgHPSGM/hmZ
         cPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354586; x=1699959386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiqFYUrrovnf1rhzBHvSluIgSBMGKUT9Q2F8cmlGclI=;
        b=w8rgIExmVNNCQkJHu7aG7+HJgaw3NX2pXy2i0lasL/qL2O520sTskVX6MhB8RU8a0V
         dTK8ZK5iIL41HqkqLWZtrFC7PwznmsFlHf/34xV8JvHBUCEPCaGOvEiCtaWZFdYwzaTs
         18nt/x0CZWoYZXyQk+WeNAuJ/gIVFc1/2ZHK8hSpU/96nYrRrPU+MMgCMNe7j1dWbYW6
         IuTXUOegCiTlteZVejkw7JO6Za2OcMQfupqph692yni3Ncsq50HGho8r0Lp9OwCGbGvw
         tK6ni6gRlgj1dU16Nk/5lqlzUn4CZLkzj1WbzQOZlILaJ4KSrxOvz0UXpITeS/ycAI9L
         zIzg==
X-Gm-Message-State: AOJu0Yx9gXE5YW+aLW9akK2CwRJCmT11yBAnYsQY5zVnrBvLvr/T/0xo
        GYHHxKHV9SgiM9cFW91ntGezqQ==
X-Google-Smtp-Source: AGHT+IF7Zo2YtACLiPHwQ6dLVhxCBp4VHRs60nrkUPyWwGQZ1utTTeaxqjcqGnJKdNMWHeSZvxGiKQ==
X-Received: by 2002:a05:600c:3b91:b0:407:52f0:b01a with SMTP id n17-20020a05600c3b9100b0040752f0b01amr26054980wms.2.1699354585803;
        Tue, 07 Nov 2023 02:56:25 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:24 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: [PATCH v3 20/20] dt-bindings: riscv: add Zfa ISA extension description
Date:   Tue,  7 Nov 2023 11:55:56 +0100
Message-ID: <20231107105556.517187-21-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107105556.517187-1-cleger@rivosinc.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for the Zfa ISA extension[1] which can now be
reported through hwprobe for userspace usage.

Link: https://drive.google.com/file/d/1VT6QIggpb59-8QRV266dEE4T8FZTxGq4/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 87c7e3608217..dcba5380f923 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -214,6 +214,12 @@ properties:
             instructions as ratified at commit 6d33919 ("Merge pull request #158
             from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
 
+        - const: zfa
+          description:
+            The standard Zfa extension for additional floating point
+            instructions, as ratified in commit 056b6ff ("Zfa is ratified") of
+            riscv-isa-manual.
+
         - const: zfh
           description:
             The standard Zfh extension for 16-bit half-precision binary
-- 
2.42.0

