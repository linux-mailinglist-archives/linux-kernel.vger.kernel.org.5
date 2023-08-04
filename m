Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7E770B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjHDVi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHDViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:38:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C04B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:38:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-267ffa7e441so1648121a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691185133; x=1691789933;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbiyRvXqeT+unFkVa+5zDQqAm6s07WUgRXjk/fKnxm0=;
        b=4UCnv2k/x79wuxtrhNSQgvc6zjUFTz62LA0H3NGPSJUp9aTOuqJoTTWrrgVuWoNSSc
         aDhaAKydeTs1VDlx8oG3T6muGcvW80M//MaOf96VvsQQB+sKl/TI23uZDybb+XEs6Nje
         i+gT4RhhdUpxJATzmDCcDYFW+V6myaipj2x/+BgBUm4Ht+lcv27u1up/nVbvnDdiVvOS
         dOCH8fQSxaisXbY2m+hMVFmr+AjsRu0l8IDiLoD2w9Z04gt0o8NeQwsMN7NHivv+aMCk
         K/L+dVsKMkiHx539pvvf3uYq319kQ/Oyog/NULDoe4dnQyemA+jXDClYpa5Jg337bdPh
         ePWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691185133; x=1691789933;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbiyRvXqeT+unFkVa+5zDQqAm6s07WUgRXjk/fKnxm0=;
        b=lUlELHM3pZWYchaCDkUeQjHEuKE6KuGHgfYsGxCE5sV+fkgo6GDqjSfCpfDrRCOaUN
         1+3x4Z/gjVdNKwhPIHmxwsvpTsV6OEXkusbMbnF5+uwhiWJSlp7sMiMGWr7uMhdmpnB8
         tdeVobCKMPQlgDhZmjBrkSfC+QWm7ARkH6zkCvx+JL/qozL6aAU7vfo84dL6k01CvPVR
         tC/f1FPgK8Gsyjad9slRWCyDxWtkiKJc1H83eSPBjzCx4NtV4ravzJZ3I35eIXHWNhhx
         P/2XL3gdmx6AFIc3Cx5/QIzyVYiF9S2XfgXtGpdwlNTZoz3UBCevWZTMGBBnrCpadi+O
         H7PQ==
X-Gm-Message-State: AOJu0Ywr0ExAE2dzeXwcvaj74defwDZlESz2TEUjbVLblSpqAe2EL380
        RHZlcTTwfvRhGqLAR3zacYBTPWXDDuoSZa4rGVM=
X-Google-Smtp-Source: AGHT+IHJTm/3frn0Fe4TAyLYSHtB25e8jdmO+cHzPnT6Uz+KgdBcsqx5LtvvfYk7th5HxiVphRG1nQ==
X-Received: by 2002:a17:90b:4b04:b0:268:dad:2fdc with SMTP id lx4-20020a17090b4b0400b002680dad2fdcmr2892911pjb.21.1691185133600;
        Fri, 04 Aug 2023 14:38:53 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id br8-20020a17090b0f0800b0026801e06ac1sm1920528pjb.30.2023.08.04.14.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:38:52 -0700 (PDT)
Date:   Fri, 04 Aug 2023 14:38:52 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Aug 2023 14:38:35 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.5-rc5
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-69f4a2f3-c179-411e-a85e-683bb3e088f3@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ab2dbc7accedc2e98eb7d8b8878d337e3b36c95d:

  RISC-V: Don't include Zicsr or Zifencei in I from ACPI (2023-07-12 10:04:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc5

for you to fetch changes up to 640c503d7dbd7d34a62099c933f4db0ed77ccbec:

  Documentation: kdump: Add va_kernel_pa_offset for RISCV64 (2023-08-02 13:50:37 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.5-rc5

* A pair of fixes for build-related failures in the selftests.
* A fix for a sparse warning in acpi_os_ioremap().
* A fix to restore the kernel PA offset in vmcoreinfo, to fix crash
  handling.

----------------------------------------------------------------
Alexandre Ghiti (1):
      selftests: riscv: Fix compilation error with vstate_exec_nolibc.c

John Hubbard (1):
      selftests/riscv: fix potential build failure during the "emit_tests" step

Song Shuai (2):
      riscv: Export va_kernel_pa_offset in vmcoreinfo
      Documentation: kdump: Add va_kernel_pa_offset for RISCV64

Sunil V L (1):
      RISC-V: ACPI: Fix acpi_os_ioremap to return iomem address

 Documentation/admin-guide/kdump/vmcoreinfo.rst            | 6 ++++++
 arch/riscv/include/asm/acpi.h                             | 2 +-
 arch/riscv/kernel/acpi.c                                  | 4 ++--
 arch/riscv/kernel/crash_core.c                            | 2 ++
 tools/testing/selftests/riscv/Makefile                    | 2 +-
 tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c | 2 --
 6 files changed, 12 insertions(+), 6 deletions(-)
