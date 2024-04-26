Return-Path: <linux-kernel+bounces-159367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE58B2DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BD91F2224A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA6F156988;
	Thu, 25 Apr 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3NvNvMVV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC2152526
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088903; cv=none; b=gtlpuzQc94VLkhoHWCV0tGu7fs8cvp7ZwkfCXgaj4EtkPGPFplUbgStd5LyWhGljfvo3CZUOAsqrGw5Zuo2exVj7t+56Bj89J2GKAMDkETKsgi3eEZILlrmtZ2Rkq2+CIwpEupsPNFJV7H/DYFOxfneNpRXSDQrKYRofVPhusOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088903; c=relaxed/simple;
	bh=IURpQ3ebKKLqgKoCj3ObLw1sPTXcurNY4djoYh/RTlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lhsTtxqs4cwyYyDslvyfAXwvlOvkYGXWoX+6gdbxEQQS6ZRq+rZd82l75iuIoK0neqzRJGcqWocA8V8Ggkp6yNh6aLdwxIzP6Wu6kx7il5Dvx2cMSpmh3gZz9XNCIVI+ccw00i2Xho8/gVFp32lejTNnVEw+ZDX9ZOT9BO+9RNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3NvNvMVV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e9451d8b71so14022065ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714088900; x=1714693700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Inr/KUA/PsquUt3bH2Kr9I94XwvfkcF6wR+KZiSWRA=;
        b=3NvNvMVVRNCRfqfsF6Goc5yNCznR7vkNCrgpYNIjVmy/3bodd8J7hqq8VDO8ECfsT5
         S7Xfrkx9tQH7MGKQiq58ppLDctMN9VY5v9YACFZZWd6mvl9S5BoCV4qhWC6DBOWztblm
         Hxt03MSsZogGs2do3hdHvBFewLvREdgWaeuZZJ3p8ifFSuUrQDLs7VhpFemoSaBte02I
         uOxlU0s7+b9ZYLkONXr/QgK8HKfDv2t9hpDODK6tO+Wq1CCOTg3Ffh9ZUPVXhIROoJDn
         eDggBZkWTI1MTe77KOOnhW/O/rbcadW3HbFQzocATn6KdbgbMmdlLveztwjdvd5jAoBr
         MPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714088900; x=1714693700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Inr/KUA/PsquUt3bH2Kr9I94XwvfkcF6wR+KZiSWRA=;
        b=ttUJ0wualWB3um/ACGBxDuxHOZtz/tauNSQUEyZA4JuPUspDBGk7y5tiLBf41zfmvL
         eAg7ZEuHgi2fLpCtERf+jL4e90YZkEgHdV4an8PrXo9CKqutJ7p9JiUhKRw4w0rRofP9
         Xv7Gpw+bsp/Ep6wf/tUP1x5TUT2t/RIXQ2g94JnNAs3xtm+PZYMwti+JfHcb2AVOS0L5
         IHHCBouaoeAHOSP0/UvjMH9gxtJ+NDMeiu0D6yMDUnwgAXCRPbeCXM/1C588y+tPps/1
         RWTLcdi3E+vrUz0PJ+RilRAajG6Ng1j3sPCJYmibF6WqxXbaP87zQCR4DAt3ZrYCpgON
         yPrg==
X-Gm-Message-State: AOJu0YyDbFMOeSxA/uIJ829aj3lyWBDpcfJjzN5XEQ+jWaVGKZ1dyVWG
	ICulKi+Q90g5BMbhQ9ww3ftwLoRqjXCkN0ZXN6V9gZIec2yBaOF2YhChY/yRGu6qgzx+fM6lgeG
	k
X-Google-Smtp-Source: AGHT+IHX+6H8Fll5EzS9fbIZupY/l5vMCSoe9nSxNaamG0WzcMWQPBF2gUz26IgHTNdOeLB+qR4B6g==
X-Received: by 2002:a17:902:680a:b0:1ea:d979:d764 with SMTP id h10-20020a170902680a00b001ead979d764mr1023158plk.50.1714088900189;
        Thu, 25 Apr 2024 16:48:20 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b001e0b5eeee41sm14349281pla.38.2024.04.25.16.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 16:48:19 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 kvm-riscv/for-next 0/2] Fixes for kvm-riscv
Date: Thu, 25 Apr 2024 20:16:35 -0700
Message-Id: <20240426031637.4135544-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are two fixes for issues found during review/testing after the
series[1] has been queued for 6.10.

@Anup: Can you please squash them into the original source commit 
22f5dac41004 that introduced this ?

[1] https://lore.kernel.org/all/20240420151741.962500-1-atishp@rivosinc.com/

Changes from v1->v2:
1. Added RB tags.
2. Optimized the logic for overflow mask.
3. Update the fixes tag. The cover letter should be enough to indicate the base
   tag for rebasing.

Atish Patra (2):
drivers/perf: riscv: Remove the warning from stop function
drivers/perf: riscv: Fix RV32 snapshot overflow use case

drivers/perf/riscv_pmu.c       |  2 --
drivers/perf/riscv_pmu_sbi.c   | 45 +++++++++++++++++++---------------
include/linux/perf/riscv_pmu.h |  2 ++
3 files changed, 27 insertions(+), 22 deletions(-)

--
2.34.1


