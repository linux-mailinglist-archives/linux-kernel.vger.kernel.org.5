Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F9753C55
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjGNN7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjGNN7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:59:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6BF270B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:59:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso14496545ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689343139; x=1691935139;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n+At+8xi69gBbD6TfRysRNivcXiaDRsl+xovEf19KU=;
        b=jo5k+NLAbC/ndaJ1oHqHaiBNHxfJ607vhJ4LfTdmfny/4ckLBwprejctuwuS0VNzMK
         +jJ+dI5QCMPBSX0JY5JvL4rtTII2EyRE/kvaaTCOAzBnolGPwkQ3+pe0AAHv8RTbvvqZ
         QvbTqIaPuSprIoMffFy+BEaG0UDjdPSAqVj0sLhISM7Ax9hgut3PP0v4XlKqiQS7JDq6
         +u6NjjKeXYCl8mL6nytd/6YcXBNF57O3tCS5md3/I090wtCkJryXTDqbFDky5KPHy9JF
         dRbfRdutxwfss87WHUmGjy0+MMt2slwqGTEi+dvTyC9sKIERHepsuaCjA4VU871rnU7p
         t2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343139; x=1691935139;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6n+At+8xi69gBbD6TfRysRNivcXiaDRsl+xovEf19KU=;
        b=IJgF3P6ELZO2VHUn3RlyZBgPGxPj2+6UDORSTh91dePlrUyInd597mm3DwennI8nFg
         tV1mE/wf3L475cw0dzAn3yCY+omVGA8FsejN5uXjQaCZuAEQU25eT+V4Xl+s8MepmWkw
         /jl2KMgEfRngqR3takVZsbTpRf9UBfquECppFq5Y0JVL2mpy5ISJug54DGCGL3dmqiS5
         +UT+F1JR0CAAdkQCLPd49HTxc4FqoHsELG2X90a2RIPevTbKnyFuHiVwOKXxMoZiuV00
         bqPcNLBnLIxNR5t5vMifNBdg+mF+2ROWAi/ZjVA8oeLugwm8VaBqWmTZtYHTsB8tWulS
         kS3Q==
X-Gm-Message-State: ABy/qLbfst7UO4qxGnCjE+cfoDwPdAztsrP+r4568AdVjockjTWXu+fS
        jYSY7SWdZ6C9oalpBYyYdkHLmdaaUvuZ/xqcTMI=
X-Google-Smtp-Source: APBJJlGBde31pPNZ6ICzy2zL2r0ulqrihLJzktzlepVmoM6plKTmCCyZATGupOaAIEyGfD+moxNK4A==
X-Received: by 2002:a17:902:d382:b0:1b9:cb8b:3bd3 with SMTP id e2-20020a170902d38200b001b9cb8b3bd3mr4656013pld.31.1689343139306;
        Fri, 14 Jul 2023 06:58:59 -0700 (PDT)
Received: from localhost ([50.173.2.66])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001ab39cd875csm5645732plg.133.2023.07.14.06.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:58:58 -0700 (PDT)
Date:   Fri, 14 Jul 2023 06:58:58 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Jul 2023 06:57:36 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.5-rc2
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-c0a9115b-10ec-4bf0-8c4f-af009c34423f@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc2

for you to fetch changes up to ab2dbc7accedc2e98eb7d8b8878d337e3b36c95d:

  RISC-V: Don't include Zicsr or Zifencei in I from ACPI (2023-07-12 10:04:40 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.5-rc2

* A fix for a formatting error in the hwprobe documentation.
* A fix for a spurious warning in the RISC-V PMU driver.
* A fix for memory detection on rv32, which does not manifest on any
  known system.
* A fix to avoid parsing legacy parsing of I in ACPI ISA strings.

----------------------------------------------------------------
Eric Lin (1):
      perf: RISC-V: Remove PERF_HES_STOPPED flag checking in riscv_pmu_start()

Jisheng Zhang (1):
      riscv: mm: fix truncation warning on RV32

Palmer Dabbelt (2):
      Documentation: RISC-V: hwprobe: Fix a formatting error
      RISC-V: Don't include Zicsr or Zifencei in I from ACPI

 Documentation/riscv/hwprobe.rst | 2 +-
 arch/riscv/kernel/cpufeature.c  | 9 ++-------
 arch/riscv/mm/init.c            | 2 +-
 drivers/perf/riscv_pmu.c        | 3 ---
 4 files changed, 4 insertions(+), 12 deletions(-)
