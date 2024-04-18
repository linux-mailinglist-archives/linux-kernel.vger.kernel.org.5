Return-Path: <linux-kernel+bounces-150064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F338A99E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20D8282D77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA004596B;
	Thu, 18 Apr 2024 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiNk++DM"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13729CEF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443525; cv=none; b=piZa4KH0rCBWqTVybS+aZIcLRFmj5bpuXM7p3LC5k47q3gleD6UVVfcqGyAdRIFuhWAFm5Bz9XmR8EEOAWiGdY+U6fbMttY2amlLI+9IW0ka2zYe2ZxCRHkGLtTJSd3BcmO4X4ZmJqmPxr2gBCpUB9RTEvHbAp46E7UtTk6DId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443525; c=relaxed/simple;
	bh=YqqjyI4oiP/yXAptquTGZQq4WuZbwYBddBkxs2Tq4zw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ni3zm/K3jf8E2lzRG3v00v4T6nP0rmsp9vLtazjEb2WDzsnT10N649twhxzigOInNpgP7E1fvKZXOPF5W+kHOOL4dspBIU3hSj/FXWvPZjDuhizk2fzjWJ3f48DvNCdMeFsZmHOpJZT1QxWDGoo8AEEPBzB4fQuILwKZAZjs59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eiNk++DM; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de46da8ced2so483769276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713443523; x=1714048323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hBMrt7abAHFg6HP/pUKNzKWG1Ya5Ou5z4dVSJW9qzG8=;
        b=eiNk++DMQvBw5xRdOMGTBeypQrG+B4tp4NgmG1m+Uvd5JXFloHaWnrIdW8nZTUA+4I
         stg8hqHfTkAuFAwluKRLf41fpwBjRNkSwDbY75f0uMYROo5dBSHZ9yI3wtPdIrDi4BUv
         7xF2qQ0Bl/E6frJHlxMVShQpTUYP0gNGCIHXkRwxmC3KfHnBaGPCqpst9F/r9IULt4VP
         bNPLQOqamJllqFKZ1Piew1jBW+2qnRIApo3u/NX3buQjy13iLnvSDMNvk8Se7zbN7SEr
         xJ9tus6KDJsYWquOglJsr3FSi/83G2jKCCVcFnDnTNfRO5uT4ZUv13eJ78UpU5YSYBr2
         8fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713443523; x=1714048323;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBMrt7abAHFg6HP/pUKNzKWG1Ya5Ou5z4dVSJW9qzG8=;
        b=jjeA4koPJvgZZrKU/NWNTcZH3BzoOueMGUKQXEFfePrCK6rfVYqZZNcBmit4MyzHS8
         k06P2pLy4YUVuoAsRXSU/ZTLtJvRtx+6AsaJz8u0IpDcOOPBOyzC2rc7pUdYds9oM2za
         zwKj5nFkmNVWWwoJXA/iOYL/MqHjCJDXrQHFGRIYaulR92noh5gHEm5aZ5u/lgk+RLlI
         wkAOh04F3Qdk/dFThgZ03L0jciMU9H7o6iBZGgLNAdKtPZ+6kMD7KIRrNIVjmo9QBKsR
         /zxr3t5A5Z4VEXGRmt1dTvFovYSkjts8HdiwvuHMH3BuUzXqwKt/o0Y/GR7ILDEduOHm
         M2SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnHk9DTvRI3c35ofOoB76PaePsb6RYT+ultSFNft9NM4pgNszSaofA4UdurQvBcU3poxWo761THuljtG11frgIiHWIjjnGgPNUpX0/
X-Gm-Message-State: AOJu0YxxNKFmhe3aJeoWTGmrVPQkT8mUCZU6EtlIzEsmPjC3GedUQ80X
	igs4B08o5ZIJgG0VtUbd2c1kLZCPga2aH7nvVHfByU/Dth7Ig83JcnOx5TvhILVMGozC1O9IA22
	XtbBYUv/Ih13CPqjy9z3yRNVJIywAoiJUsJ/6Kw==
X-Google-Smtp-Source: AGHT+IE8M0WQNPrcBCZmpPscuxyU5gGtU5Y9ThtsKAZHFHZ07Igffy0ScmGH/QLZC38vl1oUYNHXJhm+5CXWUXMI3kc=
X-Received: by 2002:a25:8052:0:b0:dc7:4a05:ca33 with SMTP id
 a18-20020a258052000000b00dc74a05ca33mr2301879ybn.64.1713443523047; Thu, 18
 Apr 2024 05:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 18 Apr 2024 18:01:52 +0530
Message-ID: <CA+G9fYsMhzDCyqCPoZ68oMUV5tMbMmi5qF7_C+55Ec9h6YfXgw@mail.gmail.com>
Subject: selftests: arm64: sve-ptrace.c:85:40: warning: data argument not used
 by format string [-Wformat-extra-args]
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The Linux next building selftests with clang-17 and gcc-13 found these
build warnings.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
PATH:
selftests/arm64/fp
The reported build warnings noticed on following test files.
  * sve-ptrace.c
  * za-ptrace.c
  * zt-ptrace.c

clang-17 warnings:
-----
sve-ptrace.c:85:40: warning: data argument not used by format string
[-Wformat-extra-args]
   85 |                 ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
      |                                    ~~~~~~~~~~~~~~~~  ^
sve-ptrace.c:88:40: warning: data argument not used by format string
[-Wformat-extra-args]
   88 |                 ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
      |                                    ~~~~~~~~~~~~~~~~  ^
sve-ptrace.c:344:11: warning: format specifies type 'int' but the
argument has type 'size_t' (aka 'unsigned long') [-Wformat]
  343 |                 ksft_test_result_fail("Error allocating %d
byte buffer for %s VL %u\n",
      |                                                         ~~
      |                                                         %zu
  344 |                                       data_size, type->name, vl);
      |                                       ^~~~~~~~~
and more

Gcc-13 warnings:
------
sve-ptrace.c: In function 'do_child':
sve-ptrace.c:85:36: warning: too many arguments for format [-Wformat-extra-args]
   85 |                 ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
      |                                    ^~~~~~~~~~~~~~~~
sve-ptrace.c:88:36: warning: too many arguments for format [-Wformat-extra-args]
   88 |                 ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
      |                                    ^~~~~~~~~~~~~~~~
sve-ptrace.c: In function 'ptrace_set_sve_get_sve_data':
sve-ptrace.c:343:58: warning: format '%d' expects argument of type
'int', but argument 2 has type 'size_t' {aka 'long unsigned int'}
[-Wformat=]
  343 |                 ksft_test_result_fail("Error allocating %d
byte buffer for %s VL %u\n",
      |                                                         ~^
      |                                                          |
      |                                                          int
      |                                                         %ld
  344 |                                       data_size, type->name, vl);
      |                                       ~~~~~~~~~
      |                                       |
      |                                       size_t {aka long unsigned int}
and more

Steps to reproduce:
---
tuxmake --runtime podman --target-arch arm64 --toolchain clang-nightly \
  --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3nAXzFH2GOEle3S3MVC53A9/config
\
  LLVM=1 LLVM_IAS=1 debugkernel dtbs dtbs-legacy headers kernel
kselftest modules


tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13 \
  --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3wG8BqWxf0afUI5f4wkArPi/config
\
  debugkernel dtbs dtbs-legacy headers kernel kselftest modules

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3nAXzFH2GOEle3S3MVC53A9/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3wG8BqWxf0afUI5f4wkArPi/

--
Linaro LKFT
https://lkft.linaro.org

