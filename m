Return-Path: <linux-kernel+bounces-149822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117C68A9653
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F561C2169B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC0F15B0E8;
	Thu, 18 Apr 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQYA8nsS"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB415ADB0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433057; cv=none; b=lOEFs+XWUMJDydndSAXOey/tAL8Qp+8ZPd/d/NvXvg/OL0aK378IR5R1UFlfF1jjlKnwdmPGOT5AYZGN2cNweZtCBPpWx1LQI/e4QWe6w7P5tgtzFq4kXmXhM/scU1xHr3eZ6Y1AZMD4muR2XHeu3OSI9UYHnk6TEIN7snojFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433057; c=relaxed/simple;
	bh=oKebPGc7csYied+Trqn6NoQuTo1kiGGrhWQNjyzLyFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aixQ0JwwVcf2umn/j2KyhCOM21thvLOqdB/o2o/P18OWvcGTqeeKx9bKqLRMw8IXKf9HT5U6h8r1Ic61aSEN2OIecuDwcuhsKJ7JCbAwKJp6T5gDILeLeCXPkgL3h62FWNjdxM6mEjBvI9DYIogSW4FbVeLbaKbTHdEthMOFfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lQYA8nsS; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47a0f54fb13so257707137.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713433055; x=1714037855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R+5jHDSpgy+V7CAH4lxvvOy3F/SpQIh5uBt2JeDM398=;
        b=lQYA8nsSlFbSyRwvmCNnYGoNSVDHN2i0dP5KcJlO1cW8gEV5NnstNZIG4PCjkowhGt
         1TU2xFS/Zd3O1kVJIzr4OeZSIjicr3qlTW2Al021gNtSjM9oibmZ5APbkvkrdov1CMb9
         /yDNRO6J5gsa2HVvIxoAk8b+woXLnDO1U3YFwBOILykDY2E5b5iLDrH+uYjOEeu8uAve
         QHCD5TPvpjPKuYHb+vdf3/l6ana1LhEWd+qgDcEapqCvzMQ7ieSv0FMHLTpxphn8T1bU
         JxmQ1ilux0+S2qFjJlvQ0AtjcQ9obHIs2wqRAtxqXohNNwlxuRwM75BBtah4AgdkS4kD
         meVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433055; x=1714037855;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+5jHDSpgy+V7CAH4lxvvOy3F/SpQIh5uBt2JeDM398=;
        b=BotP9HQgmrrtinv2MQAla6JqJ0ThNtNGCl0gssKN+hbvxkiFddbFCEhTwarjRzURO4
         DsCUdv+OsJxIvLyUu5l8IA6zfjatcVFQ4s4l3aItp/MyAeTp1Ax2LYmp/25ZQP5CHwlr
         QUqr0z678pXNsJlZP9tXDGU1L8qKb458MLIkZE/93suJ83s/gqComGPONhoMv9NTgyjh
         WY/K7NF3RE8T3kHlITqHTALQRsIlVC/Il6pnxIKp54EnT4MXIMTaFVYbDKd96u9Ejwek
         fd34Mj5bOwqV+VdBxHqsNfD9LBNjY286xOlBCUkgB334sFHMZB/UeVTSo30TVAWKxrFV
         rg5g==
X-Forwarded-Encrypted: i=1; AJvYcCXus4dDoCQbBDpVL0jsfFry6tcCcY4b8GefMLWZR0ndzu0epVKKo8lIHB7ooYsavmgh9GBxWcLxqgD/u8Xv7l9vp5021c37mmRtVrtv
X-Gm-Message-State: AOJu0YxVntL9AMg+35n9x/zVE4TsjiTnXUzny1vGhzs31Cx36y78yKHj
	h6uxGEdr1pA0ynSe27VnKZoQQ2n8ajiOUUjeXSFkVmrLRKAlrGAMKzOXEQK1snppG/W5jy0OjWd
	uMZGXLFxOz/2MQcrcaeTuBEhSEUgnsUqiM+5DCA==
X-Google-Smtp-Source: AGHT+IGUiLjVF51AxMwojfexM6qeVP3BXEPl/EhnR3F2ljxY1JpFWs3N20simlQ0PqdaxtXXPMv54pqI1R7waXf5uug=
X-Received: by 2002:a05:6102:f08:b0:47b:99c5:50fc with SMTP id
 v8-20020a0561020f0800b0047b99c550fcmr3113575vss.1.1713433054849; Thu, 18 Apr
 2024 02:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 18 Apr 2024 15:07:23 +0530
Message-ID: <CA+G9fYvacWNZsmizotfcwD35xBq0999_EAV0wZgwjdi46yivgg@mail.gmail.com>
Subject: selftests: mm: seal_elf.c:140:45: warning: format '%s' expects
 argument of type 'char *', but argument 5 has type 'char (*)[5]' [-Wformat=]
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	lkft-triage@lists.linaro.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The Linux next building selftests with gcc-13 found these build warnings
and errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
PATH:
selftests/mm/seal_elf

seal_elf.c: In function 'test_seal_elf':
seal_elf.c:140:45: warning: format '%s' expects argument of type 'char
*', but argument 5 has type 'char (*)[5]' [-Wformat=]
  140 |                 if (sscanf(line, "%lx-%lx %4s %*x %*x:%*x %*u
%255[^\n]",
      |                                           ~~^
      |                                             |
      |                                             char *
  141 |                         &addr_start, &addr_end, &prot,
&filename) == 4) {
      |                                                 ~~~~~
      |                                                 |
      |                                                 char (*)[5]
seal_elf.c:140:69: warning: format '%[^
   ' expects argument of type 'char *', but argument 6 has type 'char
(*)[256]' [-Wformat=]
  140 |                 if (sscanf(line, "%lx-%lx %4s %*x %*x:%*x %*u
%255[^\n]",
      |                                                               ~~~~~~^~
      |                                                                     |
      |
     char *
  141 |                         &addr_start, &addr_end, &prot,
&filename) == 4) {
      |                                                        ~~~~~~~~~
      |                                                        |
      |                                                        char (*)[256]
seal_elf.c:110:13: warning: unused variable 'size' [-Wunused-variable]
  110 |         int size = 0;
      |             ^~~~
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/ld:
/tmp/cczODkiZ.o: in function `test_seal_elf':
seal_elf.c:(.text+0x738): undefined reference to `sys_mprotect'
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/ld:
seal_elf.c:(.text+0x794): undefined reference to `sys_mprotect'
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/ld:
seal_elf.c:(.text+0x944): undefined reference to `sys_mprotect'
collect2: error: ld returned 1 exit status

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

