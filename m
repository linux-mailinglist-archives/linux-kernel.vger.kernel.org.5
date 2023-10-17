Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2298A7CC45E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbjJQNQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343863AbjJQNPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F84102
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406532c49dcso17776645e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548540; x=1698153340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcwMvdrQT7dDiQfvq5mk8auJjq+yKDjdUlNI6K4rk90=;
        b=xa8kyVmxIMdgaf2ZwDbPGSzStRaubmGVqg+N2Ez+3aBJMLX9F1s7NeyquRbLn1WvHa
         JVOkzFUCAbAHJwaMRdSWl3HM7wN5vHYLAaw+hX6yKoGleqbEDt13vFcV23C1Y4sMBYuY
         BbfhmHkLSFl6y+Yy9KA+kP1IYca6qY4EP/labyUaUQ5nfPFUv4e+YCcGM02O+eNAFQ22
         aY5PSQn/2OxN14Tpp/8Z9EdVFAah7ebH7FpPTq04QmpWHZ1Sr3DT2K0xmeOTBT531OjL
         iTIDz/4HMQgceSwbTvNYwOhLZxRdk1fphcMrNkabml6cak/CJAcR8be9oovZSkg/JqG8
         vnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548540; x=1698153340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcwMvdrQT7dDiQfvq5mk8auJjq+yKDjdUlNI6K4rk90=;
        b=J7RkGDe8B1E3MxAJgIOffJVU+ByG/RngsM+Vo91k18rBtYbN/S1xDE849sdxZg0ByD
         ds8iWOzHsdcxx8wUGwhcA01fqoiaeEznl6AJgCAOxA7Hhye3hBZBwfR+/7cW0yCtKtU9
         e00AZGfPTr6ugNVL598IqwhRq/QwqJT4uvmanVyidcHPbEBnZf/a8udlbGYgjrlvHiJe
         EKsYJ0wzzV33ZW32IKWF5XXzSoK8kU2PYDQzkXG8AEQyKdQwPXn3PqnLeusCUCe22KG0
         VADVLWEzKrmC65o8x06yvrWk/DRmFtnE90pFbADpwY6U/tUhedfsGC2JwbUpwM/VHVZl
         9Jxg==
X-Gm-Message-State: AOJu0YxEn3dZoC11Y3jRFjiI5Kfa7uJU+SUEpa6ni4kk6VzM1qkpsOgY
        a7u73iXaIxzKQmMNvqGDrlEfcA==
X-Google-Smtp-Source: AGHT+IHVBUlyPGQBU14EXa9PZ6UFLb59Nwth5umwYgIAc2moUAd+hl54lbf8HW53OTtnTpusU2Ppyg==
X-Received: by 2002:a05:600c:150c:b0:405:38d1:621 with SMTP id b12-20020a05600c150c00b0040538d10621mr1641826wmg.3.1697548539594;
        Tue, 17 Oct 2023 06:15:39 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:39 -0700 (PDT)
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
Subject: [PATCH v2 13/19] dt-bindings: riscv: add Zihintntl ISA extension description
Date:   Tue, 17 Oct 2023 15:14:50 +0200
Message-ID: <20231017131456.2053396-14-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131456.2053396-1-cleger@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index b0a0d1bdf369..eb4c77b319fb 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -324,6 +324,12 @@ properties:
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

