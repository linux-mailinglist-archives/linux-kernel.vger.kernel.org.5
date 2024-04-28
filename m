Return-Path: <linux-kernel+bounces-161328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516C68B4ABB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7641A1C20F01
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385454904;
	Sun, 28 Apr 2024 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS2pLW0L"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867514087C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714293254; cv=none; b=Rw5jN4HysyD5AeZVo7Ta5t9bsn3q9unD32zq5oud+RTH+HzgfDcUHtOKm88EG45HyQZKX458vjk8UkTotdTvagT9TDsqAj7KJi+o3eusy1C52UFE674ap10tf1ZtC+0L5pm1zyLiR5D2vHpVcWEKlUpv+cXz5W1pzQURi10mxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714293254; c=relaxed/simple;
	bh=mmnLHYm0BEWMqEUHRXsuLH7MLOOouxbnNoiookMrg9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UnT/8BbZ2zTN4wbR2jK8aUCEhoYZasMZDTel/DjJaVSdYocM9YiVB6dhJT653zs7YT+RA0alAvgu045N6tG5QLlEfYZ4EJF5v9CxFal+rAbzWAYQoGGp5F9uczFIKdABIBwIm9yVGpOBqrK/6wNa4BdZbg2CkjfKEYwyLEXf/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS2pLW0L; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41c1b75ca31so1923885e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714293251; x=1714898051; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CqnY0fwSvsK5vxkGPqXhZV+9zmQ8EsWDD5La8fAbCuo=;
        b=cS2pLW0LEG4Jzx/C0lDMEOSRYPvDhN9fo/URS0dQ4OzXgSXmN/WFCNu5yVz2A5xahP
         bAktg9qwEZEdNShtsMkY3lZstPjmGCq91ewDFNTxyyXYFDNeh5HYovXhr3LzOglmDZTb
         n1aOVd73ISPK0HJlgZJiqf8vulh87GaGqWfYfosULkVhWOP+lypsqfzoYylL8JeAq1Cn
         s5IItttwSBJg8Hmksq3ztqRAiOy7pPGunsD07fdeJUkxnqgoxaUjswwrIlTkqmQonvT+
         u3r5MZavekHwAk7ohC8wW8LOj9W1BSTw6fnqPI3d4OXkNrQoRSbGXFrM1ItyYYydTvQb
         r/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714293251; x=1714898051;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqnY0fwSvsK5vxkGPqXhZV+9zmQ8EsWDD5La8fAbCuo=;
        b=vPVJIbhSflcp0nb9tqJ0JxcegJpMCrAQTTwTjNJR+/L5zfp/vUAPFBtnwjB0lQdniu
         yB1LdrNvcZmcGMhxDCOB2f7ohRMzh3F+whQ0UuERn70GcoAJb33Hp56F4NQYhLj9mTz4
         oCjvWdvx8Vl+K1n6w9kSvXryDMcTyxYZunc6hiEd7qEpvlMVa6V0ge7eWyRcFMQJ59mf
         UW4zVDIL+HHu6KTsHzGOgjadKiEwyZgYfGA1v38brxVcBltdOHgm3rhDd97CjDlVHQlq
         jT3IKI3mCqw6LXRHb1YQZq5QdoQ8V7mUeT4/qKYNNi38aUjVvdkn1ZW0M9bPTtQPwX4t
         uzkw==
X-Gm-Message-State: AOJu0YwwpuHHbwIEEm7Axja8f3msAqr4oNnKnMCmdv3YQ2bDpsun/xTB
	uWGGsN1O+OJaX7Cp8vdrLeeGEbLHEstQWRTvnUsvaN64k24oFAx4
X-Google-Smtp-Source: AGHT+IHSLHATBVyeDQFtadcqkDrV/aDN8WWJhPvgV71dLmjotbjyAbP7amTcFg53b0tc0ClKtJMMbw==
X-Received: by 2002:a05:600c:1c89:b0:41c:190:2ba9 with SMTP id k9-20020a05600c1c8900b0041c01902ba9mr1725203wms.31.1714293250589;
        Sun, 28 Apr 2024 01:34:10 -0700 (PDT)
Received: from gmail.com (1F2EF175.nat.pool.telekom.hu. [31.46.241.117])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b00417ee886977sm41317439wmq.4.2024.04.28.01.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 01:34:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 28 Apr 2024 10:34:08 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <Zi4KAESpbiYDwXdA@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-04-28

   # HEAD: ce0abef6a1d540acef85068e0e82bdf1fbeeb0e9 cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n

Misc fixes:

 - Make the CPU_MITIGATIONS=n interaction with conflicting
   mitigation-enabling boot parameters a bit saner.

 - Re-enable CPU mitigations by default on non-x86

 - Fix TDX shared bit propagation on mprotect()

 - Fix potential show_regs() system hang when PKE
   initialization is not fully finished yet.

 - Add the 0x10-0x1f model IDs to the Zen5 range

 - Harden #VC instruction emulation some more

 Thanks,

	Ingo

------------------>
David Kaplan (1):
      x86/cpu: Fix check for RDPKRU in __show_regs()

Kirill A. Shutemov (1):
      x86/tdx: Preserve shared bit on mprotect()

Sean Christopherson (2):
      cpu: Re-enable CPU mitigations by default for !X86 architectures
      cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n

Tom Lendacky (1):
      x86/sev: Check for MWAITX and MONITORX opcodes in the #VC handler

Wenkuan Wang (1):
      x86/CPU/AMD: Add models 0x10-0x1f to the Zen5 range


 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/Kconfig                                    |  8 ++++++++
 arch/x86/Kconfig                                | 19 ++++++++++++-------
 arch/x86/include/asm/coco.h                     |  1 +
 arch/x86/include/asm/pgtable_types.h            |  3 ++-
 arch/x86/kernel/cpu/amd.c                       |  3 +--
 arch/x86/kernel/process_64.c                    |  2 +-
 arch/x86/kernel/sev-shared.c                    |  6 ++++--
 include/linux/cpu.h                             | 11 +++++++++++
 kernel/cpu.c                                    | 14 ++++++++++----
 10 files changed, 53 insertions(+), 17 deletions(-)

