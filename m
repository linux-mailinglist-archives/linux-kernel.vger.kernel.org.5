Return-Path: <linux-kernel+bounces-29736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0528312B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC0F1C22198
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0379455;
	Thu, 18 Jan 2024 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZVv9PYaB"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FA8F4F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559382; cv=none; b=ZduPXpXDsSJJozE7aeGghG7F8axKVoceMZHzsXzEh9uQQ57AP8mcmogPoHVYv0iYr6oCGu2jy6MThkPwmazWl7vKsfJQ6A9P1v3Q2MmYXvx2ofZaJ7AfmVL5bsTFVXhTuRsHa8opoEhoYfTb4jg6Y/QFxWLz11suUJ3voOizjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559382; c=relaxed/simple;
	bh=/u5+kKTAb8cIuSKjldQRcHga6oj7W+2Gqj2x18oGMoo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=fMxyAEOcj+MhCMkcs6PmtcA29nJO0qe1HAvvqEuMC3LcSwhx+N4ixyQgjcUeMu+9EYr7Rosmi5rwb0aPyZeA/rwWG/bfqSOEknTvvtcchUs8lVWQB7Iu3zUj6KnwhwO6X2Lzeo5Dyh+hZj95fVnQzj9USYwA4uYqHPxtqOi6hI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZVv9PYaB; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ba9f1cfe94so8572439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705559380; x=1706164180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nKRSRDgZCX0qZ4H/CNTVQl9+01tMfjOuLKW5Fu3dbqs=;
        b=ZVv9PYaBmSZgU6YRxXbURJRcUxyWweIO8g0p1RB60f8an/4jD7wpFlpN/cd+fHsL1Y
         eLJlVuPbQenlc2El+yiJlNfTywtMeyRQkJrlqn/lCYFuyazT7nFZ8IIpeaW47pFwamf5
         on1dKai6HNIDXVIiB9VseJCVI4cs1hhzXMSqqkWVuCWxEIZ5iCNROILiIEtcq/FCL+IT
         76rzgNqrHUdrLorPesnB8eOwnLCOwO2t/paQZaPH5d6zMmiwDZGLF8fCsx0Rt50/LqNQ
         297z7hdQpcEqZvXY/5JlZrm87b7R8EA/N0HoXJnzXqwNluiTUOYRTCbbA3x0fj8u+VSo
         L5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705559380; x=1706164180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKRSRDgZCX0qZ4H/CNTVQl9+01tMfjOuLKW5Fu3dbqs=;
        b=sw6CvHSG71Hk6xBbJI2FJUJQEANhjI+DlUhxMDPln6/4m7kKMYa4Tw0kDjhxFI01y3
         J/b7c9Mq/rFu+j8ztegGBxxo9BzrrvBmbVHhr/j+I3WI6Ggou0CiUZPy6OR6KfbUVcyp
         i4gmYHOeSp59XFJvyFS64jd8LDuF8y0wASVbWh0IdX06LYTpy4phKQWYeoG2zH+1Z4tT
         Vh+ZAbLfZnkJK+Q/LuQ2RMaUf+lhybPa66n5H9AnhAeoZSGiloFxyWGE32PK/gf0Wirt
         kJzyuyfMAeRAHM6VLw3pJvHVnE5Bsc5qi+Pfkp97s35uAKR4RW0tKezNyhXuUJ8yS+wF
         4gUA==
X-Gm-Message-State: AOJu0YyeV0WBvEKjrTeQPoGZ28Z8x903UbyAj/nWoPiflNJ68iJGwJTK
	HdOF0KqSrV+C3dqJWSQT4I+4K/JP6e3r++RfYYjYIkeZR3slwnllb4USYb0utvU=
X-Google-Smtp-Source: AGHT+IG1KliUgFB2bTNUn2Iwg2xlnQseSG6/fqem8LxM9mRgfpKIp7Pca72j/MOfj5keAZE9edU4lQ==
X-Received: by 2002:a92:c844:0:b0:35f:e0a7:888a with SMTP id b4-20020a92c844000000b0035fe0a7888amr360581ilq.21.1705559380680;
        Wed, 17 Jan 2024 22:29:40 -0800 (PST)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id bn28-20020a056e02339c00b0035fec699584sm4663269ilb.13.2024.01.17.22.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 22:29:40 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 -next 0/3] RISC-V: ACPI: Add LPI support
Date: Thu, 18 Jan 2024 11:59:27 +0530
Message-Id: <20240118062930.245937-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for Low Power Idle (LPI) on ACPI based
platforms. 

LPI is described in the ACPI spec [1]. RISC-V FFH spec required to
enable this is available at [2].

[1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#lpi-low-power-idle-states 
[2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v/riscv-ffh.pdf

Changes since v2:
	1) Added "riscv_" prefix for functions made non static (Feedback from Drew)
	2) Added RB tags from Drew.
	
Changes since v1:
	1) Reordered the commits such that the patch which enables
	   ACPI_PROCESSOR is the last one in the series.
	2) Used GENMASK and other changes to address Drew's comments.
	3) Moved common functions required by both DT and ACPI based cpuidle
	   drivers from the DT driver to common arch/riscv/suspend.c.
	4) ACPI cpuidle driver is added under drivers/acpi/riscv
	5) Rebased to latest for-next branch of linux-riscv.


Sunil V L (3):
  cpuidle: RISC-V: Move few functions to arch/riscv
  ACPI: RISC-V: Add LPI driver
  ACPI: Enable ACPI_PROCESSOR for RISC-V

 arch/riscv/include/asm/suspend.h    |  3 ++
 arch/riscv/kernel/suspend.c         | 49 +++++++++++++++++
 drivers/acpi/Kconfig                |  2 +-
 drivers/acpi/riscv/Makefile         |  3 +-
 drivers/acpi/riscv/cpuidle.c        | 81 +++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-riscv-sbi.c | 49 ++---------------
 6 files changed, 141 insertions(+), 46 deletions(-)
 create mode 100644 drivers/acpi/riscv/cpuidle.c

-- 
2.34.1


