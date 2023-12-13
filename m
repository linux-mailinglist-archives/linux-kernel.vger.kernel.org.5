Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60EC811029
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377728AbjLMLdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377991AbjLMLdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:33:31 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9BD124
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c317ba572so12199465e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702467196; x=1703071996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bstEpC4Wn7eojNR4ey8qLYKe/MWWQca3CdSgitFw4Fg=;
        b=RC0pQrg+1tzni5Y/urP2QWDVAWmKqQUsrkRj0mkkRUeu7RUyjQAaNL9xs2KZ8B8u7w
         qAyP3KEhtSBooyTraLIgzc97Zdu10Lx9T1Q9kCZ48YupxjLt1+XdRDesCjuKhqKZn6FG
         FZVe8wO+gH6jCMj+J8/4tSIFL0w65DgvzsVGTvvGa1b58Ji7zudsKY2+sPasFIale85o
         GHGLg5ufOgZWrGr/O5GmVaZvKWcAkSiUNQkVs9prh21o+vH+SmG3XAhe4zyDwUlWmfio
         Nf+uMiXqj3SgPD8H8wef4UCjj+48zhsFEK9XtAoEQjEoyRyz9yYTf6R1gODpJoFg50p4
         sNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467196; x=1703071996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bstEpC4Wn7eojNR4ey8qLYKe/MWWQca3CdSgitFw4Fg=;
        b=ZC8bxlDdCevZvDfZdnkmACzytEXf6dQxHi664oHPlZJAi+walYHkLVfrV7Meol2vnR
         u1zfOmvLlqAYrqzO/KDwva12KNluFdRKIyMnTzpIkT8CdiM89zH1XGs5zNiDgDnqnRko
         q3MR314Skf0I4vNLKpOjsVrtEH0bibVth4IsnEgIz235P+uuXQDV6Hbem15uSMC6e7xG
         vLAyWtEOHGyl7oeiUFrQxpajVD3ChPJLYgMt6W4mniRZwJD64beksdkkdQxqTF30qTjD
         2Ma8h1SICZwi65Rp3UE6Mfu8R8M8X0Fq/oqPwV2ZnmVg4fZuKazGl8TuXnZG55vXeQ3s
         G+JQ==
X-Gm-Message-State: AOJu0YwVXqWaMpGP2wxgDR9Fwchz+nCaVrZWTko2agPVe7x5Jr3uN30R
        SGIusDVngJZzEZSMjzGE0iYfhg==
X-Google-Smtp-Source: AGHT+IG2tOfMAS1pydsf4pPawIp50fPoX384Fx9efJpcAm8MmIokurwGuZwz8GEsZl7/fbAwTEX3Lg==
X-Received: by 2002:a05:600c:358c:b0:40b:5547:76a0 with SMTP id p12-20020a05600c358c00b0040b554776a0mr9797289wmq.0.1702467195152;
        Wed, 13 Dec 2023 03:33:15 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:c564:f167:d072:5672])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm22433137wms.30.2023.12.13.03.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:33:14 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robbin Ehn <rehn@rivosinc.com>
Subject: [PATCH 3/9] dt-bindings: riscv: add Zam ISA extension description
Date:   Wed, 13 Dec 2023 12:32:59 +0100
Message-ID: <20231213113308.133176-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213113308.133176-1-cleger@rivosinc.com>
References: <20231213113308.133176-1-cleger@rivosinc.com>
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

Add description for the Zam ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 3574a0b70be4..912cc6a42eb4 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -171,6 +171,11 @@ properties:
             memory types as ratified in the 20191213 version of the privileged
             ISA specification.
 
+        - const: zam
+          description: |
+            The standard Zam extension for misaligned atomics is supported as
+            ratified in version 20191213 of the riscv-isa-manual.
+
         - const: zba
           description: |
             The standard Zba bit-manipulation extension for address generation
-- 
2.43.0

