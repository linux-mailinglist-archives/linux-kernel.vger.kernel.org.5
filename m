Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729A1803226
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjLDMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjLDMDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:03:35 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26186D50
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:03:39 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d986a75337so759716a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701691418; x=1702296218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8m9lBss2N9gmJ7CWiI2qsuc6tjxWOakJzaxWbQb+vtA=;
        b=pO+bIm3XndQ+k+YdjMCtoAn483wY5ephPEG+kbzU4o5Ppd3VZdt8658s3tNBDV298B
         kqxHo50qQ1yML1Z+Z7rfu1o05MEss+Rb/g4sbKLgeYMIqZIOnO+nQtzBU8lVS1ew0Yk7
         7MpajGYRAFX4MdUFOXdX7Wg4w82pBoUVVgfPzshi8mVQ0pS+AVJ0yFxgTPzL4+tpTX/G
         fWo8s4jv/KY5W+pYqE/hHi1PCvI6GWyYfbs0xo0iKg1XQ9EyJEXqTbttlg3iPZ0yZZPd
         o+LN9Y5SR5+yI3AeVes6FCDX4X6L1xUJXjOKJIVzT9eSt2NVuXMmvh0z7RkPMJ2Bhrrd
         KgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691418; x=1702296218;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8m9lBss2N9gmJ7CWiI2qsuc6tjxWOakJzaxWbQb+vtA=;
        b=C3z2H0O+CV4PPZuq65OO3rt/m5Oe6EjTjWtBZye7nKnydmtfEmnVnWIkZWRWanEtHV
         E0iwWVNlY+ht3bZ56BUzEAu680bSUPqBPPsmzR77FLaFIJNlmel63QRr3eV50nzIh6e1
         ckBsDQC5mweUDoxFhVzVcKTii8CZnrniRziSgwacgqd97GLG/dmRWX827dFPolQaiNN2
         GaeiW4WHomUjeSQopPlM6i8Nsq3SRzYaXeS3cnDSdBaHcWf3MSN0cIoDXheGLngHudBI
         UZzss3aFZX+/Hahf7lrshYEzQYABvYFMwYZhu6x0aCJmt4IN5Wfs6Ums63DakFyxbnSK
         NLHQ==
X-Gm-Message-State: AOJu0Yw1PMycA4ZQaL26iuea7LLSJrbLtWhIHEyFWzfOdPLQgCDj20Ok
        t8dFb2glnOH1CF2ufzfSGh7qWiiCML1wsJ+LYw/25nCWPg8AFQezNTo=
X-Google-Smtp-Source: AGHT+IEtcMK1FvJnO/N929rTgm1c5UQwY9ZKTuLRDbSnocjG2Dv64YKBRmzygwY+RjRRS5oUMM5l2sXrtIt5uIV35A4=
X-Received: by 2002:a05:6830:6e15:b0:6d8:74e2:c086 with SMTP id
 ec21-20020a0568306e1500b006d874e2c086mr5495794otb.56.1701691418411; Mon, 04
 Dec 2023 04:03:38 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 4 Dec 2023 17:33:26 +0530
Message-ID: <CA+G9fYvD72Vpfs2g8R+OJ6L8w9p_uaWbXpWMvnGAx_AOLabatw@mail.gmail.com>
Subject: clang-nightly: vdso/compat_gettimeofday.h:152:15: error: instruction
 variant requires ARMv6 or later
To:     clang-built-linux <llvm@lists.linux.dev>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        lkft-triage@lists.linaro.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build errors noticed on Linux next-20231204 tag with clang-nightly
for arm and arm64.

## Test Regressions (compared to next-20231201)
* arm64, build
  - clang-nightly-defconfig
  - clang-nightly-defconfig-40bc7ee5
  - clang-nightly-lkftconfig
  - clang-nightly-lkftconfig-kselftest

* arm, build
  - clang-nightly-allnoconfig
  - clang-nightly-axm55xx_defconfig
  - clang-nightly-bcm2835_defconfig
  - clang-nightly-clps711x_defconfig
  - clang-nightly-defconfig
  - clang-nightly-exynos_defconfig
  - clang-nightly-imx_v6_v7_defconfig
  - clang-nightly-keystone_defconfig
  - clang-nightly-lkftconfig
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-omap2plus_defconfig
  - clang-nightly-pxa910_defconfig
  - clang-nightly-s3c6400_defconfig
  - clang-nightly-s5pv210_defconfig
  - clang-nightly-sama5_defconfig
  - clang-nightly-shmobile_defconfig
  - clang-nightly-tinyconfig
  - clang-nightly-u8500_defconfig
  - clang-nightly-vexpress_defconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Build log on arm64:
---------
In file included from lib/vdso/gettimeofday.c:5:
In file included from include/vdso/datapage.h:135:
arch/arm64/include/asm/vdso/compat_gettimeofday.h:152:15: error:
instruction variant requires ARMv6 or later
  152 |         asm volatile("mov %0, %1" : "=r"(ret) : "r"(_vdso_data));
      |                      ^
<inline asm>:1:2: note: instantiated into assembly here
    1 |         mov r4, r1
      |         ^
In file included from <built-in>:3:
lib/vdso/gettimeofday.c:139:3: error: invalid instruction
  139 |                 smp_rmb();
      |                 ^

Build log on arm:
---------
In file included from arch/arm/vfp/vfpmodule.c:23:
arch/arm/include/asm/cp15.h:101:2: error: instruction requires: data-barriers
  101 |         isb();
      |         ^


Links:
arm64
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231204/testrun/21471527/suite/build/test/clang-nightly-defconfig/details/

arm
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231204/testrun/21471941/suite/build/test/clang-nightly-exynos_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231204/testrun/21471941/suite/build/test/clang-nightly-exynos_defconfig/details/



--
Linaro LKFT
https://lkft.linaro.org
