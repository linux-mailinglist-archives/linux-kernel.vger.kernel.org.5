Return-Path: <linux-kernel+bounces-134251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7955D89AF83
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFA01F220B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41C811182;
	Sun,  7 Apr 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvGvCYWJ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F310A14
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477722; cv=none; b=f3+3u0rB0SiKOulKlgVpdInUFjlBJMpUdmXvzfwKKmckWf+Thk52Fe+KRlQMz0B3A0hMI7R1UJ1Pi6ZTvPmMWRGybQeniE8+SNc8OTB0XvOFGQ4fhJPGcAoYeb1OUVs2raSAsQvfFlDg9RxR21170/1kBIkhElKbkfNrIe/9gZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477722; c=relaxed/simple;
	bh=2d+Qqt0GWbCaMMFlBmk+zlu2fatfrTl5Fn7c/bcNO+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition; b=X2uF+s8AQIPDjrUmFGysC6/2JV5CwLjxhnz7SDcqSlMhnbQtdKdqTeextIAM2marpflFUwhfuoTmxd29CduKNZmoSSSfryb8VT9RG8Pt1umClMzwuvmzIhsCU4GNpE7FYdAYfPHU3UFYXKUyGBdG7rAoLB1kAThCXaom9zPu5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvGvCYWJ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d858501412so42146341fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712477716; x=1713082516; darn=vger.kernel.org;
        h=content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfc4d3QxGPJWsmODhOZ8rFenRoR734rTYSVJJP+CTL8=;
        b=gvGvCYWJGMnTXaMNUPxcfQQcZPBpT1CLxHuAtn9enNbNy3jfOzaAh7S5YjNYGkYoTU
         n7k6ejv1bAwHyvOJz9D/BQxix+pKvMVjBDVzILQQ5fqaey02mZXQ0zpfVbxed3mJdJp7
         hpCXwHdnADObZuGtCHBW0BYwTqs2H5jqDWzLtN3gQORIBDlH86JCfj2Tt7Qnfq8XeCJ+
         0jUTO1dKRa1uo+UClsO66CuBQn8Qy6hNXzzhjlmItJXT1OwFtnaiVB4U1gWoV+xm1jTw
         z7V/oJPwy4gCn1aneG2nDB+5yMe+jKY7r239cj/Y+yvwW6WqzY0Cew/0KKRep67LQL6y
         wPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712477716; x=1713082516;
        h=content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wfc4d3QxGPJWsmODhOZ8rFenRoR734rTYSVJJP+CTL8=;
        b=qNDxxNkEvEWQQR22OUNAQEZAJQJcV8qm+ZfwmPFPS/MlObmwqtkcMBX+HC29DwltOg
         IkDkssRfhcfR6Ey97+CGaHLfQw2G7ATdNkUkJYC8ZRsFILsmJBnEAbQe/XFgHDGIJwE0
         jhWNAY9heE3Rhc45TsZvEgOnT4dZJbOkdDCCiUrLdK+7IZFOths3bqZdm10UmMT4N3Pa
         5T8QsbbFj2E7oIqURBNjqzMMBhcgpsioqUYTra1Du/uJev65WZpQDgbVKYgOWvzE+i42
         IrEPULEJwIhjm195REvCXcoxst3XtSEsnmZYkmGeAB2pUYpfax24oHtO3CtyCuV3k8h2
         QPRA==
X-Gm-Message-State: AOJu0YxLk31D9WpytoHL3roMeV994VXsCv4hacPdjUvmaTIRxgmWY2Ki
	R6b6YM0uNgs9b7JmO5Jwh/UalQZXwHbktYhQ0DjscKhEIwPXTL9b
X-Google-Smtp-Source: AGHT+IHl72OOzwefSXV6cQ/kWW0CcClGoMzYMWYbsL3y7UaOAzIwfQ6C8SFBzYw0enzC922xYPJsVg==
X-Received: by 2002:a2e:6a17:0:b0:2d8:6725:e9c2 with SMTP id f23-20020a2e6a17000000b002d86725e9c2mr4284809ljc.28.1712477715968;
        Sun, 07 Apr 2024 01:15:15 -0700 (PDT)
Received: from gmail.com (84-236-113-28.pool.digikabel.hu. [84.236.113.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c4fc600b0041663450a4asm610733wmq.45.2024.04.07.01.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:15:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 7 Apr 2024 10:15:13 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZhJWEdkpXlagP9GH@gmail.com>
References: <ZYbv3GXLNLuc+rka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-04-07

   # HEAD: b377c66ae3509ccea596512d6afb4777711c4870 x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk

Miscellaneous x86 fixes:

 - Fix MCE timer reinit locking
 - Fix/improve CoCo guest random entropy pool init
 - Fix SEV-SNP late disable bugs
 - Fix false positive objtool build warning
 - Fix header dependency bug
 - Fix resctrl CPU offlining bug

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      x86/numa/32: Include missing <asm/pgtable_areas.h>

Borislav Petkov (AMD) (5):
      x86/kvm/Kconfig: Have KVM_AMD_SEV select ARCH_HAS_CC_PLATFORM
      x86/cc: Add cc_platform_set/_clear() helpers
      x86/CPU/AMD: Track SNP host status with cc_platform_*()
      x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
      x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk

Jason A. Donenfeld (1):
      x86/coco: Require seeding RNG with RDRAND on CoCo systems

Reinette Chatre (1):
      x86/resctrl: Fix uninitialized memory read when last CPU of domain goes offline


 arch/x86/coco/core.c                   | 93 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/coco.h            |  2 +
 arch/x86/include/asm/sev.h             |  4 +-
 arch/x86/kernel/cpu/amd.c              | 38 ++++++++------
 arch/x86/kernel/cpu/mce/core.c         |  4 +-
 arch/x86/kernel/cpu/mtrr/generic.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +-
 arch/x86/kernel/setup.c                |  2 +
 arch/x86/kernel/sev.c                  | 10 ----
 arch/x86/kvm/Kconfig                   |  1 +
 arch/x86/kvm/svm/sev.c                 |  2 +-
 arch/x86/lib/retpoline.S               |  1 +
 arch/x86/mm/numa_32.c                  |  1 +
 arch/x86/virt/svm/sev.c                | 26 +++++++---
 drivers/crypto/ccp/sev-dev.c           |  2 +-
 drivers/iommu/amd/init.c               |  4 +-
 include/linux/cc_platform.h            | 12 +++++
 17 files changed, 166 insertions(+), 41 deletions(-)

