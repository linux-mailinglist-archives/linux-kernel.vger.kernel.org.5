Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07217EB1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjKNOOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjKNOOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:14:18 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3559B19BA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:56 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-779f81223ebso9063485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971234; x=1700576034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoTFo90940vK77kTlCvHvrvp3qqCfWhzk2ZkyIVF9ns=;
        b=GUbaUU6Samn1yyulWPTYQwi9e2erNmDwXfkPyAwopdbM/x4Kyy1BkL9Fhp3m9sW4H2
         sGR/dQk6+64bURNcnMFWDrDoWDs9+1PgUkxV2toMU9HDjceHb3V1G+foANlVFhn56RVk
         p9fzw6H0S8mGcfd+fHbJX03t16QIUfhMqx25ExJ7v5kR9hxhuTWi/kowl/4cGfIZmvDB
         1XfuEuUpbrHQymePeBn60CIPA2qquqPvOgoJMwzllyo1aPGL0G4WeaGjhzkCiJgk6gW4
         SFTYhzYt2Eaz6jvVZQe8hs4s9ib6GuE2/3pi/Itr6RHxsIDfJvOak+PD+Lq8iR5MylH/
         2qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971234; x=1700576034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoTFo90940vK77kTlCvHvrvp3qqCfWhzk2ZkyIVF9ns=;
        b=HgQggFfhoojrULotnQxEA51PPJDY5peIQ9BYsZfbdh/VFJbCa9QDn5MHOjgIgcQNp4
         etS4G4PCf2rg4ulO+tVdSyqKqSMl0T24jbXdc63JNX5bgkRk4kT/pQ0zBKAC9HfIdQun
         U6d4dRCJaasUURHsl5rOqnpvTOm2cRAXqyCehUEuT0I/iAViKV3QDg17FHt4++3Rvx1w
         U9AVPwp3Nb1HvE7DlDIIleoVaAltHUv5TdCvHFmYS35kZY52Pr9mfx5/Md+irh68pf9G
         Xm9jlHVW3sGyuV9iwEqJARSXPrwCYXgXJbd7BHTk2W6NtOu29c8h8ys7CTj00gKtzcXd
         wJSA==
X-Gm-Message-State: AOJu0Ywn4eprAu8qiBzd0847UZ0kE8ZL88l4Atwv87SIs0UQKhDMAsmI
        7mIdx8n9Hc1AMQLqymD69/7kZg==
X-Google-Smtp-Source: AGHT+IFNCPX21/Ri63YAzgADy+EVaz2PJ/ebWolRkZq99YoI+InQVMnXeGM6ah9IB3zm0CykKOxaXw==
X-Received: by 2002:a05:620a:bd3:b0:772:5300:1c3d with SMTP id s19-20020a05620a0bd300b0077253001c3dmr2154010qki.0.1699971234326;
        Tue, 14 Nov 2023 06:13:54 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:53 -0800 (PST)
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
Subject: [PATCH v4 17/20] dt-bindings: riscv: add Zvfh[min] ISA extension description
Date:   Tue, 14 Nov 2023 09:12:53 -0500
Message-ID: <20231114141256.126749-18-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114141256.126749-1-cleger@rivosinc.com>
References: <20231114141256.126749-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for Zvfh[min] ISA extension[1].

Link: https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/extensions.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index f953c49be90d..b91d49b7c3a0 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -369,6 +369,18 @@ properties:
             instructions, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        - const: zvfh
+          description:
+            The standard Zvfh extension for vectored half-precision
+            floating-point instructions, as ratified in commit e2ccd05
+            ("Remove draft warnings from Zvfh[min]") of riscv-v-spec.
+
+        - const: zvfhmin
+          description:
+            The standard Zvfhmin extension for vectored minimal half-precision
+            floating-point instructions, as ratified in commit e2ccd05
+            ("Remove draft warnings from Zvfh[min]") of riscv-v-spec.
+
         - const: zvkb
           description:
             The standard Zvkb extension for vector cryptography bit-manipulation
-- 
2.42.0

