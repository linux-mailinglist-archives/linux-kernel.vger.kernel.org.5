Return-Path: <linux-kernel+bounces-57437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE084D911
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064401C22EA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C438225DD;
	Thu,  8 Feb 2024 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JWs4CpbW"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78772C195
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707363867; cv=none; b=nnGT5jl1N9mnaXTJZ1pf29z5pactF1ykntZGtaikv9fUnbGuPEyoG1Yv+GGf1eQkxEFj5jP6MvemzMY3GbZhq6BHEpcmZHZqoqrmJbkla+ziQwFaFYYk7MPYTHo/G2asiWBpGunM+8XQIxWExcBagx14jrzk8amaGZBk9/sf0gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707363867; c=relaxed/simple;
	bh=vsSy/zJmggrAHCtB3V+eVabWAwTZlsu8Q95Vvb3f2eM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uxt1R6IfDJEHpiA28E06ckkfIjuaIxuYIVw5Re8W3vFtZodk8hNDzq6xCjoI1oYQORBrGdtLA+/+m8w1xjcicnH62b6OIQMn2nKY1CczfyalPLWSBG51CKt0XbVVNjhrD7oKhTEobyNnKmKEJrDWkH90GiIm+h8CvXiamIkUvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JWs4CpbW; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2191b085639so550118fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 19:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707363865; x=1707968665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rkpIjNJ/hv5n3tdD+dzXGfS3/Ndu0cplbWReHM4buo=;
        b=JWs4CpbWGNM8iXfR4ffZHEN9oYOpAMjo8JkXqtZ74JRI4Os95tHus18sn3rFUSORJX
         65FL15CPhOtG7tRCqYvMpcjQRSm7L20moJ4VZXAaAI4CE2oVq6avuPpjaBQBYGSxWAHu
         leUacnmm29IMwH1YUhrgiGNBl0FIOtNPHcZTSZoWnCYD/BPwkmouXk/AALVLXUlohQ71
         qwC3DVtn8p5wDj4wjxnSkbBIIEM8IcuBbS6WnB8SJ9rL3H1mEUIyry1GRgav6fNnBDPt
         Akm3GCuait7XMT+SpxajzfA2lpVF25rbSih9+ywbJ0mpv6ZvXdAZfKk2Adu68gUCOmgU
         T40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707363865; x=1707968665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rkpIjNJ/hv5n3tdD+dzXGfS3/Ndu0cplbWReHM4buo=;
        b=n2DRWkb4Q3JqpJ2Z/ZC/whtLtggqWjpvlCKUg6wepKyKHqwbp/iiSla1+5EsRWJ9ip
         P3DepyEAii6LJCwFfKK/ocA5nWj6HwdnzH1+Qk1X2fvtSL0MLdjSQVVrkHjK0/aWEYPk
         q24oIYR7hshOzkIddx8qTsiT8uV453x6n85PegKNnoXge50DLXgbXqCfJV12uo8aQJ0x
         /EjB8WGpLABy/C06H+6O7YndgiGI5NLRAyBvLF3gY5pELnTrNtO9dsJoERntOQWnpeDN
         doXMZoUaApXLeQREfNA7E4J/s/I+kMP+QJTDPJL71pzyq7/Fl64BeF8S7FqkeLcj+u9y
         NpRQ==
X-Gm-Message-State: AOJu0Yz7NrUtFT6nRMeu83i/I6LthWrSqGvRF8jdO8TjaIvKvB6fmHY9
	qLU8pZVW1vXT1MlOTSGM3JjAkOLOnIpE8VuifLzHvPB2vlIu8jmWZRV+/bFK3d8=
X-Google-Smtp-Source: AGHT+IETnVB5Y1Emogv5wZLjpPx72/Ad2dmQ7q2aHg/gKzVhmZoAkRLugxsnjcd9UDe0soHHR6C2/A==
X-Received: by 2002:a05:6870:41ce:b0:215:68:65c7 with SMTP id z14-20020a05687041ce00b00215006865c7mr8076634oac.12.1707363864990;
        Wed, 07 Feb 2024 19:44:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXh6Y7e/7oqenCsNksOBgK8Ayl3MEleXrb0SC69KJwCjoy6Ey8iq/708woQvrjq2bOHV8mU3JamlAkdDBU+xjlsQVflHCt7IA+b19eXsc4CfW2BVQpk5GeNGyoFiup+m95HRQ6rOOR5yl0+Ab/ZbDIV1M4QZsij/3hKHxondSo0Mhsmknb7hpprGwZNc3sZmXIsr+x0ANpXIjBOJOFFAjhvAw96YqdnmKCmW92J4i3QB6GP4sUn+YkEfHsJajIfBNAaeCKAfUjMfD7BeeIBmIssLamTzy7+7/2J2oeslUfS8fnncICu29vWlef4R2LWRVvQSgYa5V258GZ5/ddCRCNTHfPAuG+K9E+bfZ5MnTtbETaUWqzOX6q7Mk9ap3/UpbjlARb/jQYpG+NEPWpb1V5LIcEdtEt/1+YVKT0rzh6zeOJaAgHAa8znbc1kC75OmdIjVYiP
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id g10-20020a056830160a00b006ddbfc37c87sm443595otr.49.2024.02.07.19.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:44:24 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 -next 0/3] RISC-V: ACPI: Enable CPPC based cpufreq support
Date: Thu,  8 Feb 2024 09:14:11 +0530
Message-Id: <20240208034414.22579-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables the support for "Collaborative Processor Performance
Control (CPPC) on ACPI based RISC-V platforms. It depends on the
encoding of CPPC registers as defined in RISC-V FFH spec [2].

CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
enable this, is available at [2].

[1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#collaborative-processor-performance-control
[2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v1.0.0/riscv-ffh.pdf

The series is based on the LPI support series.
Based-on: 20240118062930.245937-1-sunilvl@ventanamicro.com
(https://lore.kernel.org/lkml/20240118062930.245937-1-sunilvl@ventanamicro.com/)

Sunil V L (3):
  ACPI: RISC-V: Add CPPC driver
  cpufreq: Move CPPC configs to common Kconfig and add RISC-V
  RISC-V: defconfig: Enable CONFIG_ACPI_CPPC_CPUFREQ

 arch/riscv/configs/defconfig |   1 +
 drivers/acpi/riscv/Makefile  |   1 +
 drivers/acpi/riscv/cppc.c    | 157 +++++++++++++++++++++++++++++++++++
 drivers/cpufreq/Kconfig      |  29 +++++++
 drivers/cpufreq/Kconfig.arm  |  26 ------
 5 files changed, 188 insertions(+), 26 deletions(-)
 create mode 100644 drivers/acpi/riscv/cppc.c

-- 
2.34.1


