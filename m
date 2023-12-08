Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8428680A843
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573772AbjLHQJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjLHQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:09:16 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1D3198D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:09:21 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d719a2004fso18926967b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702051760; x=1702656560; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6imjyzF7qx6UKd6s1Syi6NhYQbuoJMem1zS1tbU350=;
        b=wytdtopD7MqdQGFPKQnpn4UD6hPZGTE6UpdzIOtNoTlXL5Rjt1OkLbOe+uCSy0qF0x
         KSD2MmIgTwQkga/IIQ1bSPOxh/EiMo2US7Wkf44qMzgua73JIm4kX+NkVTL78nW7cPGk
         Kt2RduAspR/QX8azx0dkrHn03D3MGh0LN8709S3ngIHwYckUlle7DbxshJXMV0jwHgJF
         MbrKh3OhmgeXHoPPbTjkS+wEiTJ48SLBbJvFoI/eLmNj6h/qPDT+MuqUWeCazHTxbbDP
         4QfLXxpjQxl6XrsVElzgRoVkvXgYdsNGB0rvh0IWWDJFtfSFCGI12Rd9ih7I55Pt++jk
         7ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702051760; x=1702656560;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6imjyzF7qx6UKd6s1Syi6NhYQbuoJMem1zS1tbU350=;
        b=EcXlkR/0QQDDDim3ruhDHw20pf8WmaXl5ybHZctMNxHb1PXbCHsad2LYXctOUX2kr1
         5dK1cDFroCMPtfFnWEurM03iRnC2VUlTd78iBTB+VLmfpczeTgj7GMgPbLA0lx+LRir5
         oK9lSro778H49vhTlBm7CRAghkwJESQEVCFw+k8ibK36Xvpd3NdyIhdqXK7whB149oRp
         zwax+t3vzIe4/1NLFVD91C+kf4vf2k6PpfkeIThaJMpoN2g0psidn77g0W05/FpPtbjd
         XCsbcAQOYwv3dGpU/o8meHupwYpPkVslYIAVdaOu4jx1P5rHGo+qKjkBnPhv9m77hIW8
         qp5A==
X-Gm-Message-State: AOJu0YxK+Lpvl2yRCE5aFmvgv9o0HplSQrplA1Y9iF8f/4XwFpVNaKfk
        qY/naRveIpomjWucYsq/Wh82EQAIhT9D05sUbKI=
X-Google-Smtp-Source: AGHT+IG1sNFI0tjwkJLDXwhSee+BTMFi+F9FpTRtUaY+XoDDUgPjyW3cBDmhTK2DPzvRyGlXcq6PGw==
X-Received: by 2002:a0d:dac4:0:b0:5d9:ace2:e496 with SMTP id c187-20020a0ddac4000000b005d9ace2e496mr133461ywe.90.1702051760428;
        Fri, 08 Dec 2023 08:09:20 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id o65-20020a817344000000b00583f8f41cb8sm745193ywc.63.2023.12.08.08.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:09:19 -0800 (PST)
Date:   Fri, 08 Dec 2023 08:09:19 -0800 (PST)
X-Google-Original-Date: Fri, 08 Dec 2023 08:07:52 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.7-rc5
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-1c062b80-96c4-4146-a689-9338ce7c524c@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.7-rc5

for you to fetch changes up to ed5b7cfd7839f9280a63365c1133482b42d0981f:

  riscv: errata: andes: Probe for IOCP only once in boot stage (2023-12-06 07:18:58 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.7-rc5

* A pair of fixes to the new module load-time relocation code.
* A fix for hwprobe overflowing on rv32.
* A fix for to correctly decode C.SWSP and C.SDSP, which manifests in
  misaligned access handling.
* A fix for a boot-time shadow call stack initialization ordering issue.
* A fix for Andes' errata probing, which was calling
  riscv_noncoherent_supported() too late in the boot process and
  triggering an oops.

----------------------------------------------------------------
This is all a bit big for rc5, but I think it's really just up to me being out
for a bit around Plumbers and Thanksgiving.

----------------------------------------------------------------
Andrew Jones (1):
      RISC-V: hwprobe: Always use u64 for extension bits

Charlie Jenkins (3):
      riscv: Safely remove entries from relocation list
      riscv: Correct type casting in module loading
      Support rv32 ULEB128 test

Clément Léger (1):
      riscv: fix misaligned access handling of C.SWSP and C.SDSP

Lad Prabhakar (1):
      riscv: errata: andes: Probe for IOCP only once in boot stage

Palmer Dabbelt (1):
      Merge patch series "riscv: Fix issues with module loading"

Rob Herring (1):
      dt-bindings: perf: riscv,pmu: drop unneeded quotes

Samuel Holland (1):
      riscv: Fix SMP when shadow call stacks are enabled

 .../devicetree/bindings/perf/riscv,pmu.yaml        |   2 +-
 arch/riscv/errata/andes/errata.c                   |  20 ++--
 arch/riscv/kernel/head.S                           |   2 +-
 arch/riscv/kernel/module.c                         | 114 +++++++++++++++------
 arch/riscv/kernel/sys_riscv.c                      |   2 +-
 arch/riscv/kernel/tests/module_test/test_uleb128.S |   8 +-
 arch/riscv/kernel/traps_misaligned.c               |   6 +-
 7 files changed, 106 insertions(+), 48 deletions(-)
