Return-Path: <linux-kernel+bounces-140136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B18A0BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6537EB26EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F3143C4F;
	Thu, 11 Apr 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RlREm/a+"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC2A13DDC3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826410; cv=none; b=r9xc9hKPeamRy0R/xNQjUii0Pq/bsy6+CM4hqFhSteXJ1g1jSLXFEy9IK3YA3aenXKH+PMvvCiOoT76uH5ImvEP3VAB58/STf0oLY6WKk34sn3py+rcKCQNVHv2tv4FNNZmX+OvdgveZU1JTjIrpqY5gCi8j1/6hFrYgB9a5af8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826410; c=relaxed/simple;
	bh=6DbO2IfX4foKh9Xb3n4eNqJb7FJipbHuEUEhvFPlwPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ihfArm9yVLB3q//TBJem2OfZ9VzU5lK22r6G55aW8poIelLYxl+RZCVQzMD4hOtbvCp0SVi9P9M225VRRjKnc+mOsGbQZ4wejMScm1L4baYDjD4awVmIFjNsYNqR1dOWPdGLgsZ/xxw/Q3TXqcEXXustYRjwenU60wCi7Nc3VDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RlREm/a+; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22a96054726so6179013fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712826408; x=1713431208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CBhqQGQ9V37via17GNYW/9Ko6M+5Uqp4L2VsS7G79oA=;
        b=RlREm/a+ZFZ67ldxqDWSLX0njC+wMkESc9RDwWLmT+TgPzD0ReMrHav/xfTvBNZOsi
         VhHvIH3kRagoWCO4QOJuLOO+9uVrq5SvsWKJTZ//b/ShwVJZpax0eBYG1DW9P6WXHMVt
         KcfAgScxDtdj9UYoI+4kN9xlBZ2su7qBGgqSIcXyvpghy3Y4YH7JG93EH3DWvBBdkoe5
         DNpmgjkqDS1stZRt3qDE7s9hJov2HVLozBJLAJTvjOIpo9UQa8xftWUsJP0Z4JFasH9x
         lWpfgcr1pO1CWqEBVSpGlddspXcGHzXuQPN3I8M6zrjf6fmPJ3jPT84Um0z8jGyhq1m1
         o1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712826408; x=1713431208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBhqQGQ9V37via17GNYW/9Ko6M+5Uqp4L2VsS7G79oA=;
        b=b0jg3hsxeXtUDHHmT/Ma3yhAF27zGuzIdS6FnkBNuYCpPR58AP/GRf7NSq2ynoFdKj
         8kLYJ9NleIb1AGuPeoonel82LEB3c9RrTHB0WHlZauUsgunHBKppWQSbtXT23nHV5itr
         qj4m+C5pJGF5q0LmF9WCPbl5jZx0nS47XE8bWIdB4aUtu/wZiqFoFQfbsj7M2+EFfn2R
         djrCffbwRF9TbioBXFB+A74jH6Zg0dMazGlKk4XAsIWvM37KRAwsQ//qkX2bayxtHHiV
         hLhFB3qMdagBsSJ1Q+E9Cxty3qoiRlwzudRggv5eV5lR7zF+gunVlwhx6grJJyZBVRP/
         2RdA==
X-Forwarded-Encrypted: i=1; AJvYcCVYJuLSQF9IqGRl71kEMSPuvpJFgoTHOvFJoAAHxo+1YzxOfQIlxB3CqpfbjD8LuG1poZIiXuUNYxIvwTcoa+eUkFwH33OenpPgMRm3
X-Gm-Message-State: AOJu0Yzdx6bB0q1VeauA+S8SCG7AlMYYWoUrWPlSaU56zjLn+LWHzBgY
	XaloLSlTPqro/QvLzC6u81B1c+/Rqk1feqN9nTlP1fVDirC2wPmS/VY5YJLVe78=
X-Google-Smtp-Source: AGHT+IHdV+Ixn8TwQhwDHZf5ScDldFNUD5vTYYRbuxDbqU8SomJtrIceDwDNi2J3aMwBPVQwYLhmIA==
X-Received: by 2002:a05:6871:5c6:b0:22e:c48a:bfda with SMTP id v6-20020a05687105c600b0022ec48abfdamr5675910oan.28.1712826408430;
        Thu, 11 Apr 2024 02:06:48 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.82.118])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78c55000000b006e729dd12d5sm816738pfd.48.2024.04.11.02.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:06:48 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/2] KVM RISC-V HW IMSIC guest files
Date: Thu, 11 Apr 2024 14:36:37 +0530
Message-Id: <20240411090639.237119-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the HWACCEL and AUTO modes of AIA in-kernel irqchip
to use HW IMSIC guest files whenever underlying host supports it.

This series depends upon the "Linux RISC-V AIA support" series which
is already queued for Linux-6.10.
(Refer, https://lore.kernel.org/lkml/20240307140307.646078-1-apatel@ventanamicro.com/)

These patches can also be found in the riscv_kvm_aia_hwaccel_v1 branch
at: https://github.com/avpatel/linux.git

Anup Patel (2):
  RISC-V: KVM: Share APLIC and IMSIC defines with irqchip drivers
  RISC-V: KVM: Use IMSIC guest files when available

 arch/riscv/include/asm/kvm_aia_aplic.h | 58 --------------------------
 arch/riscv/include/asm/kvm_aia_imsic.h | 38 -----------------
 arch/riscv/kvm/aia.c                   | 35 +++++++++-------
 arch/riscv/kvm/aia_aplic.c             |  2 +-
 arch/riscv/kvm/aia_device.c            |  2 +-
 arch/riscv/kvm/aia_imsic.c             |  2 +-
 6 files changed, 24 insertions(+), 113 deletions(-)
 delete mode 100644 arch/riscv/include/asm/kvm_aia_aplic.h
 delete mode 100644 arch/riscv/include/asm/kvm_aia_imsic.h

-- 
2.34.1


