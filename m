Return-Path: <linux-kernel+bounces-122981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB668900A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061E3292A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31181754;
	Thu, 28 Mar 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxeZb6LB"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18481737
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633361; cv=none; b=k5TzMlTjSvS9YrdHKa1d7cYkJqnjrec8vAaeghNXlNmdmr8dXaUAME2JbcX6dXO7m4OcA2cgaFEdOxZv5NMhKIyxabEjuquE4j8OsAKiImjU9xHP0cr2EphSHxOKQldQhXG5x0TzQXWn2nm6uFSV23kdqvSmYJ3EFVekOJwNcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633361; c=relaxed/simple;
	bh=hhRlYplAngPEQbPQPZoDSxo+OkYmG1EWXwIVdXRC3Vs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ixJaPlJQB4WlVDTAtKiqdZoQsG2k4nTzEo/utiqMw4eBDDDEkLNX0lCQ8q9Xx4yIGdVx6lsDyCV3/XKN7G6H2WaPbGKDC9EwONPaAAFZ+8Cy70oxMkb7Xw/9fAQejpdPPAgZkB5iHi0YJcUx8HI6fHV2zxmsdkxUV+f79zm4c6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxeZb6LB; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4d42ea640f0so340338e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711633358; x=1712238158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5CeNIBGwaVDgfO73ZfAkhp4Wwo/FpVfC31xG4w3suuo=;
        b=jxeZb6LBmRnKlbpHuqQPEDQ0UjwfC0L6iud0Q7S06oIvGCd28la3R5+5ApzUAlsgQb
         UIzNCpc4CxeScUd20nxgscW0tGWkXKrHW+RcEEPzw+I2l90nc98w0dfCM3FrTbSICQfv
         uzwOqOMVhsO/LpAscs+C+yZsXaujWE01ebnimA4e3HbDemkjIaR+AVl3wilbzQ+m2VqZ
         FOknYdUvW7TfWl+2/1uA5YJNCv+UBt9vVNttRvh6eHG3g0x763CrsTNVbuf5ODIKd5st
         RLKxnd8DR3vP6k2vmX0Qfg4bkEvLjU/7lWScyEH7fNdSvueR1tZp28zu2P7Ql4gFQWqc
         t3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633358; x=1712238158;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CeNIBGwaVDgfO73ZfAkhp4Wwo/FpVfC31xG4w3suuo=;
        b=IPVM80zJUeSlGhAFINI5Ypyql98y6eB0/PsV+/Oq+2q8sYOrMMZgsaNiYopboaihgE
         a9hMm34fVGImv8ffRJufA4rU83uWaKquXmuPCgiSP2/q647FcKBZchJmzCCcQSvD/tHD
         YzkF0lJzESwOKTIT4/o5X9WZrmGcHnadTJgcONxPPa42z5KmgpGN3F0x3HV6jpCHcJj3
         i1//3ukKt97dps4P3C8OP1AG7nS0bmsbRpo8TbvKtQHN7O99bTHRssj9wMzzUVkmrP7G
         EeLQ1rwCLzinw3we3cA9z3Y6KE6XNBUXyLTtRqty7BUvva6iORXeD8fLidUOsF0lOp/9
         jcNw==
X-Gm-Message-State: AOJu0Yxrm0kyPQDAdtRxcPdUs4kVQYn0iIiBtgqPWFt1+aSzopY8BQTe
	F0bAV39Hympgwi/+dmZFaak0VgRsorKBsz8jnRtdruIcW6ec3AsTSuVIWS/P1loWyWy0EDynS0S
	TtRP7/4LN50+RcB3Q7tttuO54RmCHjbY6Hzl/ORFoA6MulJUTH4w=
X-Google-Smtp-Source: AGHT+IGCQwVFe0hrVaXjlFER1xvXN0uGdEjUdmEts8/9uJnSVwOGSKAOOHh35Vp2giMo7mQCITi+xEA2fQUNpHq1clk=
X-Received: by 2002:a05:6122:d9f:b0:4d4:19e9:db0 with SMTP id
 bc31-20020a0561220d9f00b004d419e90db0mr3400240vkb.0.1711633357669; Thu, 28
 Mar 2024 06:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Mar 2024 19:12:26 +0530
Message-ID: <CA+G9fYvB6unkhzFomVcg+M14Cc7xSKkzhMuXaWqZQbDej_aduQ@mail.gmail.com>
Subject: next: sh: mm/cache-sh4.c:250:51: error: too few arguments to function 'folio_flags'
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	linux-mm <linux-mm@kvack.org>, Linux Regressions <regressions@lists.linux.dev>
Cc: willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

While building sh defconfig with gcc-11 the following build warnings /
errors noticed on Linux next-20240328 tag.

sh:
  build:
    * gcc-11-shx3_defconfig  - Failed
    * gcc-11-dreamcast_defconfig - Failed
    * gcc-11-defconfig - Failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
---------
arch/sh/kernel/cpu/sh4/fpu.c:389:6: warning: no previous prototype for
'float_raise' [-Wmissing-prototypes]
  389 | void float_raise(unsigned int flags)
      |      ^~~~~~~~~~~
arch/sh/kernel/cpu/sh4/fpu.c:394:5: warning: no previous prototype for
'float_rounding_mode' [-Wmissing-prototypes]
  394 | int float_rounding_mode(void)
      |     ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/thread_info.h:27,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/sh/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:79,
                 from include/linux/spinlock.h:56,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/mm.h:7,
                 from arch/sh/mm/cache-sh4.c:14:
arch/sh/mm/cache-sh4.c: In function 'sh4_flush_cache_page':
arch/sh/mm/cache-sh4.c:250:51: error: too few arguments to function
'folio_flags'
  250 |                         test_bit(PG_dcache_clean, folio_flags(folio)) &&
      |                                                   ^~~~~~~~~~~

steps to reproduce:
----------
# tuxmake --runtime podman --target-arch sh --toolchain gcc-11
--kconfig defconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240328/testrun/23229659/suite/build/test/gcc-11-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240328/testrun/23229659/suite/build/test/gcc-11-defconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240328/testrun/23229659/suite/build/test/gcc-11-defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

