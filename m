Return-Path: <linux-kernel+bounces-122960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A969789005C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B171F255AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA897FBCD;
	Thu, 28 Mar 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajexxQKg"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72280020
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632966; cv=none; b=FRzONmNDLv5OaQogBDAQwz8aW1I3U2sv3hQ19mOHO/6X51TBjrUKU+1gxqLjnbY/U+S2B40D9vEXKtpnaZcJi3t91I7T23+BLXOS6ULjQZD/UfOAIH0KBEcfNP2C1z8a5m5EUz+E1Qz18DFlqv9WLe69waSDXxvg/xXwExYIhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632966; c=relaxed/simple;
	bh=qPSo9SyuNPKLPGiduEGiKIv2kZsIHdaIyrrQp+mxrXo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=D9NBAOCQi6x+IfuLdKL+vXASHSelg0nGsZ7qzBnT9QdF1dasSx91r//z/mECf0A1+Y/cLE/LYsqa0YBzqoA57GPd3zWmwjc7qVt3zkO+y8G1cAemycQkuE41x4trLngyduCLceOcwze7JlVWYk1edwHfpxkXkDYvn+5DI3yV8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajexxQKg; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7e04e70c372so241478241.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711632963; x=1712237763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HuxlR8CvEOXqyHj+Qq7Cj7wAF1B8kiKsrY6NRMdaszA=;
        b=ajexxQKgE5165G7BzgotXrkq1g6IOzFhwAQMn12QV/luCf3hO0MRIl4UoYaL/jgKqq
         ZZ6eigSvll8TuOy7ZdBSHc87D6WP1CFuXUmAl82fA15of+GWzZzgziin/0U5TmYJe7CA
         a+u64HtNtAKkrM0gzv6ehez1T7IWDWy0XMTRs2090RKwcNIcvaSwOo9zYmZOEzs43CGn
         EvOnh8uwC1UHU5o7Hzb9p6WPqQJAqSFf3nzPtDU+pmHuH3HgCvuxrWU7kv0Ql3jjbP6M
         MbB+LXOHIG4Ka8YFjFZ2kg24WTvoVW0fyyBRffnBJIme1PZUygMyyuqEBb2sIHdJxffu
         17bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711632963; x=1712237763;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuxlR8CvEOXqyHj+Qq7Cj7wAF1B8kiKsrY6NRMdaszA=;
        b=VzCItUEdRRl0LdN8ONPGFfQFOfn+5o4oYs/9+tHaDjmslJXHZ3uZ6icio0UnXwIc3S
         4wWzvGCeB3R6s39q72jKDPnvg9yydH5qcgZzSecTiAy4SqFyEp7+CTQmdbQvcWMOSZgv
         +mjIWeGzP0EAECVGDl293Y7Fw75WD5XZavwKCy2bMufX71CZRmpykmWLLMnb9EPK8qTM
         KmTWaLVYJmTiLFrxl2S/VXEUKoXGAol5TrlxDtEXWqpEoaHNMxHOPIYHXA5wrOKKriND
         Z3k/Ny6yBRLFGbJRng/3enZqikNekcgZQ4ayj68kD/K490sS0aCiNubyCRBF/gnHlesG
         CqMw==
X-Gm-Message-State: AOJu0YyQm+T9dZeRZ2wETfvYBu7UsZ4Ezs4GkGsgAA/xwAwWXbRW9xKh
	zzL8jqc7FyXxa9lgkEnXta686qYM8wMSxSMoElM5dpuougu4FeIr63m1xYwrhALog2rg4zdTzIi
	Nd0UrbkV3Ra5pPhPaLn9lZ0vsakbV2fz0z43nz6+J9czwZaq0S8E=
X-Google-Smtp-Source: AGHT+IHu7K7lWRnHw3NgjJmNDEaFubXFArdguKWXHksy1hC4QSKCDsGBXOPEsK+90ZnaUJkZYzR6GUfytoXhOk105Yo=
X-Received: by 2002:a05:6122:1698:b0:4d8:9541:41a0 with SMTP id
 24-20020a056122169800b004d8954141a0mr3518206vkl.12.1711632962732; Thu, 28 Mar
 2024 06:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Mar 2024 19:05:51 +0530
Message-ID: <CA+G9fYvbFMMCmk91vzVXcS5T2Ezkwg8tQDgt_TfF-8Q=c0B0PQ@mail.gmail.com>
Subject: next: x86_64 defconfig with clang-17 failed
To: open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	clang-built-linux <llvm@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	willy@infradead.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"

While building x86_64 defconfig with clang-17 the following build warnings /
errors noticed on Linux next-20240328 tag.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
---------
mm/memory.c:5094:25: error: variable 'pte' is uninitialized when used
here [-Werror,-Wuninitialized]
 5094 |                         writable = pte_write(pte);
      |                                              ^~~
mm/memory.c:5083:3: note: variable 'pte' is declared here
 5083 |                 pte_t pte, old_pte;
      |                 ^
1 error generated.

steps to reproduce:
----------
# tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
--kconfig x86_64_defconfig LLVM=1 LLVM_IAS=1


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240328/testrun/23230289/suite/build/test/clang-17-x86_64_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240328/testrun/23230289/suite/build/test/clang-17-x86_64_defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eIseG3mebbz7v0HESNW2YOTmiu/

--
Linaro LKFT
https://lkft.linaro.org

