Return-Path: <linux-kernel+bounces-149824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B956C8A9658
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471EDB23ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637A15B0EC;
	Thu, 18 Apr 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhsXI73V"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8E15B0E8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433091; cv=none; b=VnQkyEhuOypezLDjwZZ0sc5cCPutLnWtSDggMMq7JZefVvVOjGXJQ3WrIGD8zrBgRGZRTEhj2Mf5OtwPRxOJifjDBJEtibnRekXB+jMFHibBRhpiSixza2jL8uUGo1fSEQX8N2T5BPm8leXWyE+EHFtyoMZQ3ycZoXXiR9ZYXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433091; c=relaxed/simple;
	bh=8ShK6BZyhaLHMQr2Rr9oA5Mcbeoqx2IAhm4x1HZZarY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fDccVnKHOyDWPRPAru3KU6hgZXFWzh5fTa8804OGZD1Y6Atl1MKna8s83wy3FCnXIPfxefpvPi8wHOMI4JEX73Zl6n1sfKRCOWA+7zIoQ337Qrt4CDFeSyXbXQciqNw+uVX6FtQlklkvyiBB8UcWopckJ60buqt6v2Sj6Xr1too=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mhsXI73V; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7e6cbbc20deso172037241.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713433088; x=1714037888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mFeVdDbx/Wm34+9Q/l7q6aDREQ/YSdgqO8vqBbzLk1U=;
        b=mhsXI73VMPWUEUoYwOKdhcm25q6sApNfMi4+JI243+p4o7OZSdviVUSedRHUscUK+k
         j8J7Pnca/Abv2qITf4DQqs7cT9yr0yADQwzcyHvgNf4pIn5ladBM6Oa4O34wNg/gvLBT
         XIqqKQedTV4ghDHUDLogMsCD4XNYVRznbqCIFE8a21PrkmiBZV1FE/jE0jpKONqIB8xO
         PCEBbTybI8o4f2eur37erNZTn0zv3scv3GasA0aZsd9pf9qgVnqg4Aq4a010SPmzYmzb
         xiljnkW8XCEhlZhNWfUTP+TbpfLPdYVfd9eECWZGVby1izJ8sYWEe7AZ/DPlDTrMaJSa
         Ln0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433088; x=1714037888;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFeVdDbx/Wm34+9Q/l7q6aDREQ/YSdgqO8vqBbzLk1U=;
        b=Zg8uGsrMZO7T7n2SsRSMJNvAcI17RbU0f44xflNQ/R3DkiVq4vQRQ8VKNq7XHBPEYz
         XfINNjGUfrxQxYjj06L5sJVmpnF52rziO6Ur6MI+5MIyCZgscaEQdPMDxwZqY45pVLRF
         E8ujAbqXjRgWOAwOO9Es6dqlhR38YOppVDwovzRFiiAC13pQVaLbu+RH26YcBPtM6n+y
         mvYEn0Yf7JpCwUdEZuWKCCzci1fGNQwLIwwxgQ7R1HQtR8KC3xUtDQSWq+b0jNcnJOsf
         70jZxz9mrp1nidBgRgJqChdqIKvdlwFLlAC6vMkCGsm+68czrTOdmGM1qLKsBEiejLcj
         orWQ==
X-Gm-Message-State: AOJu0Yz8nUcx/9w8DqjQ619ON4kmseziRa5goulMbSbS3Vtl8A7BqN+g
	GBp88j5fVFdbMCeOcesEWA26NxwD7Ttd1+GZVmchSIDyr3DYbWm/vu4aKpSCLtOOaU9Kjv1MPBj
	pm0MaCv7mkBTvqEJEZODDUgu1oIwAp/3HQRmWOsfMbDFq6FfJZPs=
X-Google-Smtp-Source: AGHT+IEoDIR/L/aazTWb4Qg2+VKVTMbhyKp0gSJZ3qS35wjNaK3q5yTn60lPAs6KLT11MyJ/yXVClp46VBRESQ9PGlA=
X-Received: by 2002:a05:6122:1da5:b0:4d4:17c5:8605 with SMTP id
 gg37-20020a0561221da500b004d417c58605mr2452601vkb.7.1713433088326; Thu, 18
 Apr 2024 02:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 18 Apr 2024 15:07:57 +0530
Message-ID: <CA+G9fYvJ7=rahqJ9g35=XzEvAq9+zAiq8PNhBE-ceb2EED2gnA@mail.gmail.com>
Subject: selftests: resctrl: cat_test.c: In function 'noncont_cat_run_test':
 ../kselftest.h:74:9: error: impossible constraint in 'asm' 74 | __asm__
 __volatile__ ("cpuid\n\t"
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Shuah Khan <shuah@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The Linux next building selftests with gcc-13 found these build warnings
and errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
Path:
selftests/resctrl/resctrl_tests/

In file included from resctrl.h:24,
                 from cat_test.c:11:
cat_test.c: In function 'noncont_cat_run_test':
./kselftest.h:74:9: error: impossible constraint in 'asm'
   74 |         __asm__ __volatile__ ("cpuid\n\t"
         \
      |         ^~~~~~~
cat_test.c:308:17: note: in expansion of macro '__cpuid_count'
  308 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~
./kselftest.h:74:9: error: impossible constraint in 'asm'
   74 |         __asm__ __volatile__ ("cpuid\n\t"
         \
      |         ^~~~~~~
cat_test.c:310:17: note: in expansion of macro '__cpuid_count'
  310 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~

Steps to reproduce:
---
tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13 \
  --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3wG8BqWxf0afUI5f4wkArPi/config
\
  debugkernel dtbs dtbs-legacy headers kernel kselftest modules

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3wG8BqWxf0afUI5f4wkArPi/

--
Linaro LKFT
https://lkft.linaro.org

