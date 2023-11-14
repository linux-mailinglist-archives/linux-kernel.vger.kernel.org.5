Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F0C7EB1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjKNOOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjKNON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:13:59 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DAC172C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:48 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-779d0c05959so55569185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971227; x=1700576027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ak2BDRIk2vDqh5U51tE5B/vdW3wNdZF+MHtrJJi5jsA=;
        b=0hFu8LzJy4hfD8J0+/tBOtIJWT5aqMsYZcKW/3+b6BQITqhDlT5jNNlp6tzHZTdNy2
         z7yomNmeGGQ/zquiK3QP0anWgCfJk/j1h6Ph4VDWgY/LqP7c1eJC3lTsRYLEAA/7e12t
         CibcLX8kBkTwtlwm4PMTzFPHDn2MxoxgGH+NFD8pF7zaicLbFF8q+wQwBXUv6j8H/+7C
         gA9Zibe2/72IkwYgqdAfNY2+5B/Ul9AAuubDus+xAF8+oPVWfUquuR7QRCZSX97A+iNB
         gRlPLKqPLp5DQEY3BTzCqngqs9GXWCvYVpanJGZQHTTUF5GBoSRM6bcBo3iZy3ufYAcI
         62LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971227; x=1700576027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak2BDRIk2vDqh5U51tE5B/vdW3wNdZF+MHtrJJi5jsA=;
        b=JuWd/o4bl3Sps+Wdl3HVIr1C4G3GCEqzR6OqMnbKFNC/wiRtcrbYJXo3XfzwnYoAiX
         iuKbFpg7dQHtj78IKRI6e7QlcamYqd8BT3cm3lTQaViW7yPLbX6Fyh6BtyFru/pMygCS
         MdlBCSh5rWwdphPfuyntZbwe4hzywIRrB2LsVALQJ2bMnhd3Fo8UBZ6Aq7q7ZfiyIDdJ
         xMYniIYXcZgGLAYe+AjGS6AEmq2BHJMH14oLZVnw7JxCjy+FjvaDOvAO1VH+j0XqUHlR
         QabpkdfJ7h/0cwK5I88A7+2ZRW8zcaEEpZbp4jo3R9vnE3uIJU3fojPbDAjoHbjTZOv3
         Qdgg==
X-Gm-Message-State: AOJu0YzSSTBPJvFOjngbpw6/V9KXrnL15dEXEiEIu6DvZqmIabQmeKKR
        /9BUdgd0WSGsezGgHEJBgzEhhg==
X-Google-Smtp-Source: AGHT+IF2D+KBDRTw0WcUH3F5f9hiu2zqM89jEEHbneHS+TDtFN6UAjynE2yo55wJNn9K3IiKYTPHXQ==
X-Received: by 2002:a05:620a:31a8:b0:77a:69a1:b6a3 with SMTP id bi40-20020a05620a31a800b0077a69a1b6a3mr3097295qkb.1.1699971226657;
        Tue, 14 Nov 2023 06:13:46 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:46 -0800 (PST)
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
        Jerry Shih <jerry.shih@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 11/20] dt-bindings: riscv: add Zfh[min] ISA extensions description
Date:   Tue, 14 Nov 2023 09:12:47 -0500
Message-ID: <20231114141256.126749-12-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114141256.126749-1-cleger@rivosinc.com>
References: <20231114141256.126749-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of Zfh[min] ISA extensions[1].

Link: https://drive.google.com/file/d/1z3tQQLm5ALsAD77PM0l0CHnapxWCeVzP/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/extensions.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index e845e461b6e1..f3c99e69619b 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -214,6 +214,19 @@ properties:
             instructions as ratified at commit 6d33919 ("Merge pull request #158
             from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
 
+        - const: zfh
+          description:
+            The standard Zfh extension for 16-bit half-precision binary
+            floating-point instructions, as ratified in commit 64074bc ("Update
+            version numbers for Zfh/Zfinx") of riscv-isa-manual.
+
+        - const: zfhmin
+          description:
+            The standard Zfhmin extension which provides minimal support for
+            16-bit half-precision binary floating-point instructions, as ratified
+            in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
+            riscv-isa-manual.
+
         - const: zk
           description:
             The standard Zk Standard Scalar cryptography extension as ratified
-- 
2.42.0

