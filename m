Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4257F70F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbjKXKLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbjKXKKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:10:44 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23FD10FA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:10:48 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7c495bec2f7so13351241.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700820647; x=1701425447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RNwbKkpOOdlYnkUmnFUQa8oGNqtKbB29P4hnjmshOjc=;
        b=W//U3hd2XG8neh8uv2ahWMhv+4QOrs4rJw1Yqp1tQHS9tvtecbnOhZVJHceKDtUzbZ
         6DopOI0tR0IxayWWm6tVkjKPqmQN/j1ZdKJyw7jVc0D3mfsKzDcxX6dIP2LGzDfSXcUr
         4AiGF+3tX4tB/WSTy/If/6b4/grwx6NtnAp7i6zX1K31hFNb0tCyo8GCqDHeAyo8Ti8Z
         AnlBYhr3kJ24yTK++YpTtH2R2T0LH0ZZizt4QcYWzIrjwaHEBKaTLlJGY2Xhdk4z0EJD
         /B8xrHT4TN5W/EawgCm0l/oRBALKmN7gOygqmRBYZV1IvBWGEUBeU2SIKenhPlOYOEcF
         cLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820647; x=1701425447;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNwbKkpOOdlYnkUmnFUQa8oGNqtKbB29P4hnjmshOjc=;
        b=Oe5iEqVeJD897k5ghJav798ocgah/iY8KotRaROiFmVaqcc1oiL3zjrKlavZJoxAl5
         WhWFqf3l6/sHgKmkD5granm/vCfsg7npzjPPJOkrElUKlcE3mQF4DYbK9XJMKIrNmR71
         Wo8qUtQiap1QoEGHzd788dciwZYMdKEOn2HyOkRP5jdHaCdghwNR6dVuQaH3qypupTKo
         yETOO3ifNr1h68vldeufAZh7VN+LF+ZJwAMLJJJyag60TWSbOHot8h9DaPpisWqUOq65
         Q74Dp/NnNA3E//13k2pEJStKAOhfpTmxpvBLfhCj9prsmRFlWYuDaQCkZEpe+NK5q77q
         J00A==
X-Gm-Message-State: AOJu0YztfBr2x8kGpBI/vc5MJ0xcEyNW2AZorP+couJOqg4F4d0+2sq0
        tPCkwhE5xj7GM1w9pqBe2d6PSyXkfOeKpP7a0Aq8h2h+Hge5xaVpK+E=
X-Google-Smtp-Source: AGHT+IH1qYJUzvgMQWrRt/3NN7fan5ueWXzVBAKMLdmqcstxxzoVpfakJzluUr9qCtOyePI3AI91zWSiPENY9/RXLFw=
X-Received: by 2002:a05:6122:a15:b0:4ac:a482:f0d8 with SMTP id
 21-20020a0561220a1500b004aca482f0d8mr1264660vkn.7.1700820647430; Fri, 24 Nov
 2023 02:10:47 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 Nov 2023 15:40:36 +0530
Message-ID: <CA+G9fYtV6X=c3JVTTAX89_=wc+uqLpzggnsbGSx-98m_5yd5yw@mail.gmail.com>
Subject: next: arm64: vgettimeofday.c:10:5: error: conflicting types for
 '__vdso_clock_gettime'; have 'int(clockid_t, struct old_timespec32 *)' {aka
 'int(int, struct old_timespec32 *)'}
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build warnings / errors noticed on arm64 build on Linux next-20231124

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
arch/arm64/boot/dts/mediatek/mt8195.dtsi:464.4-27: Warning
(interrupts_property): /soc/i2c@11d01000/pmic@34:#interrupt-cells:
size is (8), expected multiple of 16
arch/arm64/kernel/vdso32/vgettimeofday.c:10:5: error: conflicting
types for '__vdso_clock_gettime'; have 'int(clockid_t,  struct
old_timespec32 *)' {aka 'int(int,  struct old_timespec32 *)'}
   10 | int __vdso_clock_gettime(clockid_t clock,
      |     ^~~~~~~~~~~~~~~~~~~~
In file included from arch/arm64/kernel/vdso32/vgettimeofday.c:8:
include/vdso/gettime.h:16:5: note: previous declaration of
'__vdso_clock_gettime' with type 'int(clockid_t,  struct
__kernel_timespec *)' {aka 'int(int,  struct __kernel_timespec *)'}
   16 | int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
      |     ^~~~~~~~~~~~~~~~~~~~
arch/arm64/kernel/vdso32/vgettimeofday.c:28:5: error: conflicting
types for '__vdso_clock_getres'; have 'int(clockid_t,  struct
old_timespec32 *)' {aka 'int(int,  struct old_timespec32 *)'}
   28 | int __vdso_clock_getres(clockid_t clock_id,
      |     ^~~~~~~~~~~~~~~~~~~
include/vdso/gettime.h:15:5: note: previous declaration of
'__vdso_clock_getres' with type 'int(clockid_t,  struct
__kernel_timespec *)' {aka 'int(int,  struct __kernel_timespec *)'}
   15 | int __vdso_clock_getres(clockid_t clock, struct __kernel_timespec *res);
      |     ^~~~~~~~~~~~~~~~~~~
make[3]: *** [arch/arm64/kernel/vdso32/Makefile:149:
arch/arm64/kernel/vdso32/vgettimeofday.o] Error 1



Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231124/testrun/21224014/suite/build/test/gcc-13-lkftconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231124/testrun/21224014/suite/build/test/gcc-13-lkftconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231124/testrun/21224014/suite/build/test/gcc-13-lkftconfig/details/



Steps to reproduce:
---
tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2YbbDYkIkXuo7IuAzRYY1HQS6Cr/config


--
Linaro LKFT
https://lkft.linaro.org
