Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F427F6CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbjKXHWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344684AbjKXHWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:22:21 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188DD71
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:22:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507cd62472dso2754833e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700810545; x=1701415345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+QJwQ2ibzfm4ZH4G7RxTWHsFFrHVq+i8PDqnY0Hrac=;
        b=lcVns6H2pfJSYqMv5D93CbOOs4B6CgPrNkEk8ZrKWnoYUSDz9+vDaIJovSPYEUy6az
         k/pRaPPFrXQHjcKzMKOz85YmkiALrblpw0xMgXACObsv9J+hbYEY9XKCuhrLOLvwHnVq
         MGLVNFbk2XYTmR3PdC2fzn1BIdZyP6Ggg7/Wpyz8C9VvK4JjLnaAPK/V/HodrWwhrpbe
         Gr3/3wdh+FXnsQjeWrGYzpnQIL30YeldnXyKeaPeMTFGKgDhTX1IX94/ldFpBWVSYuoP
         wsHYs4x7+rnVAt3YLlhqxeWPqh69ZKNytUEiIep7mWpuGSpGmwmfqqOEEUZSTthaIWPG
         cMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700810545; x=1701415345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+QJwQ2ibzfm4ZH4G7RxTWHsFFrHVq+i8PDqnY0Hrac=;
        b=oecSIWAxuPP6nNCGwYMEghXaJDwpZdOqLLyoVG9lcIspCDC+I98RliMXS41nsE8KSL
         IajGiHeSpudOEF0Mz+v8omRqV9z+Ok0ZQL0n6Kzd0gczM35Y3E55yEXdOyHiMeDnGkT4
         /fpOyvMHKqrrFhZCNdSDvXqqy/Mu2K6HduGxLCFq6u/D3K/qjfE9RvIsaMPDv6T7dSKE
         vAqqpTh+dJmkiHe2jLDEUrNgsrluBttw2Bxcghi1lTbVsQAveO1tgYQn6/XoHEXH3upX
         N/Mmg+HcvG2zlIDO38NdxVsxVV0g2O1bhh4HFuGc1tJUXD97HklaB0Tjq/KTDjZXHfkK
         sljA==
X-Gm-Message-State: AOJu0Yxa1gSY4ABy19jknbA3KXGEekPthdrwX/miuTGPYyIYZrur1/C3
        vvxbf4cuUJ9GwFTVbgrrMOZD8asafDoiNKaSVkkHZPQV
X-Google-Smtp-Source: AGHT+IG4KyTl5CwzMZ1gy4FucyPBBLxaEgYRfo01XZveBgxlerDUkvXhDFprA+AP7dQahAlFaE4+/g==
X-Received: by 2002:a17:906:2259:b0:9ee:a767:12e7 with SMTP id 25-20020a170906225900b009eea76712e7mr1762679ejr.6.1700810524590;
        Thu, 23 Nov 2023 23:22:04 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060e5200b00992f2befcbcsm1709930eji.180.2023.11.23.23.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:22:04 -0800 (PST)
From:   Christoph Muellner <christoph.muellner@vrull.eu>
To:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
Date:   Fri, 24 Nov 2023 08:21:37 +0100
Message-ID: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Müllner <christoph.muellner@vrull.eu>

The upcoming RISC-V Ssdtso specification introduces a bit in the senvcfg
CSR to switch the memory consistency model at run-time from RVWMO to TSO
(and back). The active consistency model can therefore be switched on a
per-hart base and managed by the kernel on a per-process/thread base.

This patch implements basic Ssdtso support and adds a prctl API on top
so that user-space processes can switch to a stronger memory consistency
model (than the kernel was written for) at run-time.

I am not sure if other architectures support switching the memory
consistency model at run-time, but designing the prctl API in an
arch-independent way allows reusing it in the future.

The patchset also comes with a short documentation of the prctl API.

This series is based on the second draft of the Ssdtso specification
which was published recently on an RVI list:
  https://lists.riscv.org/g/tech-arch-review/message/183
Note, that the Ssdtso specification is in development state
(i.e., not frozen or even ratified) which is also the reason
why I marked the series as RFC.

One aspect that is not covered in this patchset is virtualization.
It is planned to add virtualization support in a later version.
Hints/suggestions on how to implement this part are very much
appreciated.

Christoph Müllner (5):
  RISC-V: Add basic Ssdtso support
  RISC-V: Expose Ssdtso via hwprobe API
  uapi: prctl: Add new prctl call to set/get the memory consistency
    model
  RISC-V: Implement prctl call to set/get the memory consistency model
  RISC-V: selftests: Add DTSO tests

 Documentation/arch/riscv/hwprobe.rst          |  3 +
 .../mm/dynamic-memory-consistency-model.rst   | 76 ++++++++++++++++++
 arch/riscv/Kconfig                            | 10 +++
 arch/riscv/include/asm/csr.h                  |  1 +
 arch/riscv/include/asm/dtso.h                 | 74 ++++++++++++++++++
 arch/riscv/include/asm/hwcap.h                |  1 +
 arch/riscv/include/asm/processor.h            |  8 ++
 arch/riscv/include/asm/switch_to.h            |  3 +
 arch/riscv/include/uapi/asm/hwprobe.h         |  1 +
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/cpufeature.c                |  1 +
 arch/riscv/kernel/dtso.c                      | 33 ++++++++
 arch/riscv/kernel/process.c                   |  4 +
 arch/riscv/kernel/sys_riscv.c                 |  1 +
 include/uapi/linux/prctl.h                    |  5 ++
 kernel/sys.c                                  | 12 +++
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/dtso/.gitignore |  1 +
 tools/testing/selftests/riscv/dtso/Makefile   | 11 +++
 tools/testing/selftests/riscv/dtso/dtso.c     | 77 +++++++++++++++++++
 20 files changed, 324 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/mm/dynamic-memory-consistency-model.rst
 create mode 100644 arch/riscv/include/asm/dtso.h
 create mode 100644 arch/riscv/kernel/dtso.c
 create mode 100644 tools/testing/selftests/riscv/dtso/.gitignore
 create mode 100644 tools/testing/selftests/riscv/dtso/Makefile
 create mode 100644 tools/testing/selftests/riscv/dtso/dtso.c

-- 
2.41.0

