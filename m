Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A0B7C51BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjJKLUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346136AbjJKLTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:19:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F016D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-406aaccb41dso18558755e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697023168; x=1697627968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6vkJpRdG/bLQ2xKu/qLTVaLR+B+KqIXN0A+WQhuda0=;
        b=1EvNDN95s8fo5kRPe1sDwlewaoKAlz8zqE7fsvjxMnU+V4mNLKzjP7t27snt1RvUjY
         76aUkUi9DL62UAJgI7APXDdwDfQcxvHxY5BWmA7TJ2sPJ45HnDPYMjAV7RiITP7q3eKU
         IkuMxA4zrxy4D1Pl4APy8hU4nBHR3fkcp5NFvgPRZ+6w0ccAjP3P1K3ach9dK4FlSvYE
         cmC7FDG959sLD6Ky6p/TVshA+YUHzhogx8wsH0ro9D4qrx4bBdmzPDHRUkv8VxCslEVX
         Hms+xEDLq/7DtiGO1vqLTvpSr4iOpiM1aHqxMKixiwvFctoh1V6M33HYPA33fo44SC9d
         xv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023168; x=1697627968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6vkJpRdG/bLQ2xKu/qLTVaLR+B+KqIXN0A+WQhuda0=;
        b=lSeCuj/mYKxZzCk4LMr8+xed863wcgvNGZUSHvCpovB5Do+8kqX10c2jnOvgDD2Cjl
         j+qfnpwSR/W5MMC0CtBF1nYo7inqLyMd/YfphZZ42lqn0RhCmjdczCJ4ZHs7+yXMyCl3
         pn1pRm+TBwq/o2LvWY21zBRN0qdEYPzOcj9ych7EQvTkq1HzZoRb6hfbpmc8u0ZvPVma
         LRRv9Zn+xsnoL00/e5aOAkOHfN7n6zbdT5fY0Y32QUxdtrEDM99bmHThtVAsN2U5pJuG
         /ZZO2BMWL1drZcfWHerlQw4J0cm3cBgMHPfvflnOKjqH0yTTHCcwkMYfacTa1CNZu6gI
         BCvg==
X-Gm-Message-State: AOJu0Yxk2EAktLGM/XKsLp4asB3ottv8IJGfFm3BtiKqNNp5KTUmPOHa
        tOrX/RMO88jZCzj/9gISt3P4HQ==
X-Google-Smtp-Source: AGHT+IHXrxe2sFvVo+XelH0PH3G8nahvmswXp0qGPu5jm1rix/iAXBAzMu1U6LxnE5OCFMSwjGB0dQ==
X-Received: by 2002:a05:600c:511d:b0:401:b53e:6c3e with SMTP id o29-20020a05600c511d00b00401b53e6c3emr18807765wms.1.1697023167444;
        Wed, 11 Oct 2023 04:19:27 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm18945715wmm.30.2023.10.11.04.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:19:26 -0700 (PDT)
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
        Evan Green <evan@rivosinc.com>, Conor Dooley <conor@kernel.org>
Subject: [PATCH v1 13/13] dt-bindings: riscv: add Zvfh[min] ISA extension description
Date:   Wed, 11 Oct 2023 13:14:38 +0200
Message-ID: <20231011111438.909552-14-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011111438.909552-1-cleger@rivosinc.com>
References: <20231011111438.909552-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for Zvfh[min] ISA extension[1] which can now be
reported through hwprobe for userspace usage.

[1] https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/view

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 70c2b0351357..ae7db420ab92 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -277,6 +277,18 @@ properties:
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

