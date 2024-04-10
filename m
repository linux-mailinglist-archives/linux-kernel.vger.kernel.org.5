Return-Path: <linux-kernel+bounces-138595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4180E89F458
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6DAB2D4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C51607B4;
	Wed, 10 Apr 2024 13:24:33 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5051607B6;
	Wed, 10 Apr 2024 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755473; cv=none; b=eb7sHXQyMD50KbqnU/3k4DZZO1WlX7I37aEnT/y9yJa8fb9V67UazOjHpUBsyGTLEGtGbhYRtD8R+/Je6UuiCjMLIoffrLMkOXW+JZs9/BgA1slLpO5gIg5eFySSZztIWeZbd7QWNhV2x5Iv6oOW0jSZPl+WDFTtPjAGS5gvuak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755473; c=relaxed/simple;
	bh=t9jkfk8XACYeLJXoE1wrqULFC+XfVk5LexGcFzggemo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EXdd/CwKwH2BSKoAB6pMXd9u2jhSw1X7rt+u03EmG9WCjZZlNHuHbeTUXXKrXjbd540Tg/vdMiEm2AREIaiZmN3oAUDvms5YrUjXPFrouDc5Fr4+T2ztNu2hx1WgMC2F4r/p6k41o89ILUrAfis7QOIvdMYMLsn/ql+GbKWX9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea1189de94so2446876a34.0;
        Wed, 10 Apr 2024 06:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755470; x=1713360270;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtaYETGaEYlrDsdbImdt57cidjxrz0+GyNKetr9EE3U=;
        b=nvPp2yDT2Wg8UcQDZZ444FfxZS6yNtgWCfiBANWUs1XFUSw3e2JzPyoBfq+aqwF69O
         o7c0xa26BeidI7SUMCwhzUTAqnaxVFIvhWz6Mr3gOujqmBCb5AtDRTbt7XG4gUkngubF
         PSLN+WxnP+Kuhoj/AFkG4eiiOcXnZxZgC/T0kqTy4VIM83N7ApQuquvHyC4rkhtlR/yp
         11V4xlWZvk0CxFs824dHVic94a8u6GYyLzASvfp7/goo9/oyA8kXzqC8RgjN5MjEd+41
         cbBjAMS4/3Jnfi26XvfU0ec9QthpZwDV58GiXfwTD8TJtI3uB7/c+JQwsVv39EXJiAyQ
         cZyg==
X-Forwarded-Encrypted: i=1; AJvYcCUWuTr7N4rD62XpYNbOE6Shhg4oCIjmWaVG4+by4N4YI/t0be5c4hsb8xbEYSbCyL4+tWWHSfABViZLdfC2ZUjkfjeBjSSPS9QbqneQ
X-Gm-Message-State: AOJu0YxuT4sOt96PZW/n9qdWNQHnAQFhI8vv8j16mW/4+VIaTMo1UsgA
	XWl4PCj8/vvAF/N/DvMlYYkd1hR0grZCbldZgw3raUpjTuC4p0KduaaEo4dF1/4w9a8v7xnbIuC
	cCOuLZfipyhcnPdDihuU2saava8ZAF9KSHV4=
X-Google-Smtp-Source: AGHT+IG2WNvalWON7mCKZlXjytpV7RH6vRtGhizlJEjNAsAgPrhFb2y5eaL1suG5Lx/MdcmQZ0Tza6SxC+YRwVUcUR0=
X-Received: by 2002:a05:6870:505:b0:22e:9574:6121 with SMTP id
 j5-20020a056870050500b0022e95746121mr2847536oao.14.1712755470671; Wed, 10 Apr
 2024 06:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Wed, 10 Apr 2024 09:24:19 -0400
Message-ID: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
Subject: [GIT PULL] turbostat 2024.04.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-2024.04.10

for you to fetch changes up to 3ab7296a7e6aa34634dcc2926af933107a117996:

  tools/power turbostat: v2024.04.10 (2024-04-10 09:07:57 -0400)

----------------------------------------------------------------
Turbostat version 2024.04.10

Use of the CPU MSR driver is now optional.
Perf is now preferred for many counters.

Non-root users can now execute turbostat, though with limited function.

Add counters for some new GFX hardware.

Minor fixes.

----------------------------------------------------------------
Chen Yu (1):
      tools/power turbostat: Do not print negative LPI residency

Doug Smythies (1):
      tools/power turbostat: Fix added raw MSR output

Justin Ernst (1):
      tools/power/turbostat: Fix uncore frequency file string

Len Brown (4):
      tools/power turbostat: Expand probe_intel_uncore_frequency()
      tools/power turbostat: Fix warning upon failed /dev/cpu_dma_latency read
      tools/power turbostat: enhance -D (debug counter dump) output
      tools/power turbostat: v2024.04.10

Patryk Wlazlyn (11):
      tools/power turbostat: Print ucode revision only if valid
      tools/power turbostat: Read base_hz and bclk from CPUID.16H if available
      tools/power turbostat: Add --no-msr option
      tools/power turbostat: Add --no-perf option
      tools/power turbostat: Add reading aperf and mperf via perf API
      tools/power turbostat: detect and disable unavailable BICs at runtime
      tools/power turbostat: add early exits for permission checks
      tools/power turbostat: Clear added counters when in no-msr mode
      tools/power turbostat: Add proper re-initialization for perf
file descriptors
      tools/power turbostat: read RAPL counters via perf
      tools/power turbostat: Add selftests

Peng Liu (1):
      tools/power turbostat: Fix Bzy_MHz documentation typo

Wyes Karny (1):
      tools/power turbostat: Increase the limit for fd opened

Zhang Rui (6):
      tools/power/turbostat: Enable MSR_CORE_C1_RES support for ICX
      tools/power/turbostat: Cache graphics sysfs path
      tools/power/turbostat: Unify graphics sysfs snapshots
      tools/power/turbostat: Introduce BIC_SAM_mc6/BIC_SAMMHz/BIC_SAMACTMHz
      tools/power/turbostat: Add support for new i915 sysfs knobs
      tools/power/turbostat: Add support for Xe sysfs knobs

 MAINTAINERS                                     |    1 +
 tools/power/x86/turbostat/turbostat.8           |   18 +-
 tools/power/x86/turbostat/turbostat.c           | 2201 ++++++++++++++++++-----
 tools/testing/selftests/turbostat/defcolumns.py |   60 +
 4 files changed, 1819 insertions(+), 461 deletions(-)
 create mode 100755 tools/testing/selftests/turbostat/defcolumns.py

