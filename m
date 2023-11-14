Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974AC7EB1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjKNONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjKNONf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:13:35 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD010D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:31 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-778a25cad6dso14497385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971210; x=1700576010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQjQphgrA/D8IHhb5D1IdcN3VnDD+XZViad2Wn0dvR0=;
        b=H4VpaHTlSlWCb2pXMxShYVdRvn4ua+qKZpgLAoVScEIOzo8eQ6VAAjI8znrdboZ0t9
         DYaz2w0JhB7jxGKNb94DrFnGieJWTLW7bSg/HZFRvy/ZbWrflzluVykku3RfFgMuzY/I
         1UlYCd/Py54rWyt8a7li4ivicJmaufluLkYD+QbA5qPJdLjsmJsi6vOa1YZJzzif32Hx
         zZw0GYCA8SZd5+SMgEproCkvto0aHsnLv3lc4RKxQfaKErbiCIbRf8y2OKiKGkwBAFIz
         Ji19ThwrxorYWRUuztrnOjyNUwFmS5NkhLxE5nywzLiFX5oKlBudaPYSZ3vsatPZy3Hx
         8EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971210; x=1700576010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQjQphgrA/D8IHhb5D1IdcN3VnDD+XZViad2Wn0dvR0=;
        b=ZPvQ5OOoEQNEMb3L+Ux8Kfif0ycgQdFHlGauYFhI6bTAkPNjZ+Hoih4Tnu1BEe7JZ1
         KszjtyWz3EPCE2y2sRg9mFenlMhZBXB4+BZRBGiNS54uRCz8bk6InxkkdfT6uwc+DtWu
         Rq8ZQhKkBV6cwXfXChVNNU/a3F1iCjhycGbTMtkxgL912NS1i377CyHH/aXokn9Puu8N
         iwwuVXknzmf9/Ewq9N9QoQhEfPGcm5B4C4ag1r7AZ8ncF16UC/U/seOmAEp4GaOvMC16
         YDQJf89lBqdcQtmVB2TgqpvDY4Yl58HMOf54nyRM8VjtT1GUURbaQhHw7teWb8t+fRRS
         3T9g==
X-Gm-Message-State: AOJu0YzyAK45BN82Qp2q2+qM8+f5Y62O2CtTrMDdmGaT78CEqZ19HeuH
        MpMjRPIq7lcckbZeoB4jsecxgQ==
X-Google-Smtp-Source: AGHT+IGheyAGwa9SEinQILE8hC+p0W4sbxl1g6NAUPPkIdAxCstjHbETQlMdJWiCH5rmRKIUUwuHcQ==
X-Received: by 2002:a05:620a:3941:b0:778:8ae9:2247 with SMTP id qs1-20020a05620a394100b007788ae92247mr2341870qkn.5.1699971210654;
        Tue, 14 Nov 2023 06:13:30 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:30 -0800 (PST)
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
        Jerry Shih <jerry.shih@sifive.com>
Subject: [PATCH v4 00/20] riscv: report more ISA extensions through hwprobe
Date:   Tue, 14 Nov 2023 09:12:36 -0500
Message-ID: <20231114141256.126749-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
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

In order to be able to gather more information about the supported ISA
extensions from userspace using the hwprobe syscall, add more ISA
extensions report. This series adds the following ISA extensions parsing
support:

- Zfh[min]
- Zvfh[min]
- Zihintntl
- Zbc
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
- Zfa
- Zbkb
- Zbkc
- Zbkx
- Zknd
- Zkne
- Zknh
- Zkr
- Zksed
- Zksh
- Zkt

Some of these extensions are actually shorthands for other "sub"
extensions. This series includes a patch from Conor/Evan that adds a way
to specify such "bundled" extensions. When exposing these bundled
extensions to userspace through hwprobe, only the "sub" extensions are
exposed.

In order to test it, one can use qemu and the small hwprobe utility
provided[1]. Run qemu by specifying additional ISA extensions, for
instance:

$ qemu-system-riscv64 -cpu rv64,v=true,zk=true,zvksh=true,zvkned=true
  <whatever options you want>

Then, run hwprobe:

$ ./hwprobe
Base system ISA:
 - IMA_FD
 - C
 - V
Supported extensions:
 - Zba
 - Zbb
 - Zbs
 - Zbc
 - Zbkb
 - Zbkc
 - Zbkx
 - Zknd
 - Zkne
 - Zknh
 - Zkt
 - Zvkned
 - Zvksh
 - Zihintntl
 - Zfa

Link: https://github.com/clementleger/hwprobe_dump [1]

---
Changes in V4:
 - Rebase on master
 - Do not represent zvknhb as a superset anymore
 - Remove mention to hwprobe in dt-bindings documents
 - Add a text specifying that Zkr string dt binding means that the CSR
   provided by Zkr are accessible only by the privilege level to which
the device-tree has been provided.
 - Use a pointer for extension instead of struct copy in patch 1
 - Add missing RISCV_ISA_EXT_ZBC define
 - Remove ISA check macro since another similar commit was merged

Changes in V3:
 - Rebased on top of origin/master
 - Rename bundle_ext to subset_ext since it is used for superset
   extensions (Zvbb for instance).
 - Add an invalid id for pure lasso extension
 - Fix wrong type for check_isa ext, int -> unsigned int
 - Use bundled extension for ZVBB/ZVNHB
 - Split ZBC hwprobe support from scalar crypto patch
 - Fix typos (Evan)
 - Added a few Rb: from Evan
 - Change Zfh/Zfhmin to Zfh[min] to be more coherent with other commits
 - Reword comment about CHECK_ISA_EXT to be more clear

Changes in V2:
 - Fix typo in first commit title (fatorize->factorize)
 - Add Zfa support
 - Fix missing uppercase for Zvkt naming in dt-bindings
 - Add Conor Acked-by on dt-bindings commits
 - Add scalar crypto support from Conor/Evan.
 - Use reporting of bunbled extensions for vector crypto

Clément Léger (19):
  riscv: add ISA extension parsing for Zbc
  riscv: hwprobe: export missing Zbc ISA extension
  riscv: hwprobe: add support for scalar crypto ISA extensions
  dt-bindings: riscv: add scalar crypto ISA extensions description
  riscv: add ISA extension parsing for vector crypto
  riscv: hwprobe: export vector crypto ISA extensions
  dt-bindings: riscv: add vector crypto ISA extensions description
  riscv: add ISA extension parsing for Zfh/Zfh[min]
  riscv: hwprobe: export Zfh[min] ISA extensions
  dt-bindings: riscv: add Zfh[min] ISA extensions description
  riscv: add ISA extension parsing for Zihintntl
  riscv: hwprobe: export Zhintntl ISA extension
  dt-bindings: riscv: add Zihintntl ISA extension description
  riscv: add ISA extension parsing for Zvfh[min]
  riscv: hwprobe: export Zvfh[min] ISA extensions
  dt-bindings: riscv: add Zvfh[min] ISA extension description
  riscv: add ISA extension parsing for Zfa
  riscv: hwprobe: export Zfa ISA extension
  dt-bindings: riscv: add Zfa ISA extension description

Evan Green (1):
  riscv: add ISA extension parsing for scalar crypto

 Documentation/arch/riscv/hwprobe.rst          |  81 +++++++
 .../devicetree/bindings/riscv/extensions.yaml | 213 ++++++++++++++++++
 arch/riscv/include/asm/cpufeature.h           |   4 +-
 arch/riscv/include/asm/hwcap.h                |  30 ++-
 arch/riscv/include/uapi/asm/hwprobe.h         |  26 +++
 arch/riscv/kernel/cpufeature.c                | 189 ++++++++++++++--
 arch/riscv/kernel/sys_riscv.c                 |  33 +++
 7 files changed, 551 insertions(+), 25 deletions(-)

-- 
2.42.0

