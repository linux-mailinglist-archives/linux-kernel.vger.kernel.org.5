Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748067E3A98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjKGK5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbjKGK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:56:41 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83A10CA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:20 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c5bacef31aso11257641fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354578; x=1699959378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7aEHK12fdFG0G9p5Ar5H42P12VBS+xQqa4RJxPd+e8=;
        b=ayg+6gMMwQQN8hONtjI0gXlKN5//lxIaiLRMm3z+XI5pRcz5oRJPAjz3sZIAXu8rXG
         EG3qYcyQAm0xYIEjefLnvVxZqOXSDC8MpMGdoSV0BJgIb2LfES8eGOfpgEErMJEBzZ0I
         e032kyevBqe+1YzlyxscLmOiDAMpxlhyqitti2VbYsLaIV7Q3XXLO5tlhQTf1jnbJG1B
         l1l7P/s3dEOfKqrmdPjHEP0aCfY13ecCvQR/VCGdPKEPMF0dbr1h4hTLOI5nVCoQdMjK
         wArv8Hb29G5EFWxqr2vGAhmX0NX0sxZC+Qhw+Ixlne/zQ4T4l2bthpzLdhWJNhi9oezG
         ivXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354578; x=1699959378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7aEHK12fdFG0G9p5Ar5H42P12VBS+xQqa4RJxPd+e8=;
        b=QPXb2MduXpAM/HP55eSnsy7mpIZjCcpANp6YTRoCtsz9fMTiGWrsI+c43Sb6WYjqiz
         kyZHLM/kwm6Xo+OKDFOuq3baFIDyVBkYJq4rXEfHgHnfoZ1ajZ0vAvzOH678eY0oOv30
         M8UcMmIHEqWbgZ1qeLa/3DnlFUvMNhq1j0+zSQgodyxqPEIDsn1kz8bdeM41RyJHI7+9
         AAzmz1KCi2CmQN5xMaVeM6ReK/eW2MfFCqMN5a2SsbpUg9K7VvyhB1J9lMeIoMx5dX21
         DKYX5/bZZtSqCEF0lfOU2j9/e6Eqy2vHu5Hjd63dWJpX9IytVzdjGoZYzzHy+crqoEfY
         uTaw==
X-Gm-Message-State: AOJu0Ywd9JsxDPGYb08b9Er7oQ57FSzkcZqW8xDyVicBAowCMVFMoA94
        nJvRM+iGx89sBg/AYi8pODMPzA==
X-Google-Smtp-Source: AGHT+IG6riKUjiH4caHBP0UY8y2QJ6HnExEb8OSRHzEi1uOV2r19/bcFPMSaXYWd+67hvhTH5Nkmjw==
X-Received: by 2002:a05:651c:1317:b0:2c5:36e:31ef with SMTP id u23-20020a05651c131700b002c5036e31efmr23580871lja.5.1699354578058;
        Tue, 07 Nov 2023 02:56:18 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:17 -0800 (PST)
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
        Samuel Ortiz <sameo@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 14/20] dt-bindings: riscv: add Zihintntl ISA extension description
Date:   Tue,  7 Nov 2023 11:55:50 +0100
Message-ID: <20231107105556.517187-15-cleger@rivosinc.com>
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

Add description for Zihintntl ISA extension[1] which can now be reported
through hwprobe for userspace usage.

Link: https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 62b5fe40b4a3..c80774b518c9 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -336,6 +336,12 @@ properties:
             The standard Zihintpause extension for pause hints, as ratified in
             commit d8ab5c7 ("Zihintpause is ratified") of the riscv-isa-manual.
 
+        - const: zihintntl
+          description:
+            The standard Zihintntl extension for non-temporal locality hints, as
+            ratified in commit 0dc91f5 ("Zihintntl is ratified") of the
+            riscv-isa-manual.
+
         - const: zihpm
           description:
             The standard Zihpm extension for hardware performance counters, as
-- 
2.42.0

