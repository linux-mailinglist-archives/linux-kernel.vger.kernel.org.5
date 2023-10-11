Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8658C7C519D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjJKLTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjJKLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:19:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0D6A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40651b22977so11504445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697023154; x=1697627954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgxCkZcwRtJ6lnqrc2aMJ8ZnEwBE0+jayLLcWD/cr6c=;
        b=ZXA+xqEJG9IXfUqLeTMbsMPF0Zjynjxr1IJr1KSY8PBnZONnlBlGxH/Y4FaxRYFbMw
         WnHuB39tv5+fhlLCdzu0qbnr59AuHv3pzrtqW5ktxBb95ClH3BS7C4jS6rkTklVQ6ZJq
         XdIT3B27sXwYSk8zCF9EzOU5RUmZKPgXRUzgmiul1ekhtWKfNtcp1GlXtJiAbI6eg562
         j089qGJ67OGb+ZVnJLeh2G2hV4ydzSuEfUAGoc6+qSQvl5sP91u56h+Hze3kU0xp5pmz
         xAbaEpT9cHKywJfptSO0ei6aZQAViUQfUVAGcCpLlA8dU56b2LEzD+y31/nblLTUpmuo
         Lkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023154; x=1697627954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgxCkZcwRtJ6lnqrc2aMJ8ZnEwBE0+jayLLcWD/cr6c=;
        b=gBanQc7QP8JxNb6GQcNQto+UNUvTT3P6nn3ppejlxFOGMCIZ9NRQi+0cvCxizu/wM7
         bKW8reLArDbJyDpYa6IQAUP94FMyyzcIQAtoNxTnqCLlZVzmj6npD7vvcu6KLC8/Ik+y
         msKQqZcqNkKDC9gsCLEmPU10pznPlQcA96Pd7I5IQeANRFCjS+cifBs7dc1Op09zRiVa
         xQolyOMtrhIBcbLVQ+heXrBEn1N7B7H7vpRCTQ+9gbYPNlGng9J5w6oialkX3kmG1LvI
         iEaG5ks7TMNl94feHDbXUtp7NROLieMygzCoRSXRtKeRxg0vMEuPu0GFSgzRMErxT3BB
         v1BA==
X-Gm-Message-State: AOJu0Yy80lWw8uIJt0yVKh7fzEu6YvbuQ/7BH40PG8CwWvS2K11mIb8/
        3jOsBoMTmNY4E25MeO6FlMTp4Q==
X-Google-Smtp-Source: AGHT+IEo/nqOQf5Nm/GUklG2Aaubo3KEMXGfw3sm6uWoHOgjqGYxkEcgDn49UXNfcqfEstuD4y7hWg==
X-Received: by 2002:a05:600c:3b9a:b0:3fe:21a6:a18 with SMTP id n26-20020a05600c3b9a00b003fe21a60a18mr18661658wms.3.1697023153795;
        Wed, 11 Oct 2023 04:19:13 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm18945715wmm.30.2023.10.11.04.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:19:13 -0700 (PDT)
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
Subject: [PATCH v1 00/13] riscv: report more ISA extensions through hwprobe
Date:   Wed, 11 Oct 2023 13:14:25 +0200
Message-ID: <20231011111438.909552-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
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

In order to be able to gather more information about the supported ISA
extensions from userspace using the hwprobe syscall, add more ISA extensions
report. This series adds the following ISA extensions support:

- Zfh[min]
- Zvfh[min]
- Zihintntl
- Zvbb
- Zvbc
- Zvkb
- Zvkg
- Zvkned
- Zvknh[ab]
- Zvksed
- Zvksh
- Zvkn
- Zvknc
- Zvkng
- Zvks
- Zvksc
- Zvksg
- Zvkt

Clément Léger (13):
  riscv: fatorize hwprobe ISA extension reporting
  riscv: add ISA extension probing for Zv* extensions
  riscv: hwprobe: export Zv* ISA extensions
  dt-bindings: riscv: add Zv* ratified crypto ISA extensions description
  riscv: add ISA extension probing for Zfh/Zfhmin
  riscv: hwprobe: export Zfh/Zfhmin ISA extensions
  dt-bindings: riscv: add Zfh/Zfhmin ISA extensions description
  riscv: add ISA extension probing for Zihintntl
  riscv: hwprobe: export Zhintntl ISA extension
  dt-bindings: riscv: add Zihintntl ISA extension description
  riscv: add ISA extension probing for Zvfh[min]
  riscv: hwprobe: export Zvfh[min] ISA extensions
  dt-bindings: riscv: add Zvfh[min] ISA extension description

 .../devicetree/bindings/riscv/extensions.yaml | 127 ++++++++++++++++++
 Documentation/riscv/hwprobe.rst               |  65 +++++++++
 arch/riscv/include/asm/hwcap.h                |  21 +++
 arch/riscv/include/uapi/asm/hwprobe.h         |  21 +++
 arch/riscv/kernel/cpufeature.c                |  21 +++
 arch/riscv/kernel/sys_riscv.c                 |  53 ++++++--
 6 files changed, 294 insertions(+), 14 deletions(-)

-- 
2.42.0

