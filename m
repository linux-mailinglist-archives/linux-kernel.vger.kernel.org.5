Return-Path: <linux-kernel+bounces-57439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B20C84D916
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCB11F22762
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1502D629;
	Thu,  8 Feb 2024 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="D6lzucUR"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753A2E3E5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707363879; cv=none; b=cjIzGZU99JmNMCzn9fWz8OXTLSSUTZvMsDcOlw73UWMizGdIZzSW3VsQ4SztoYbWoHlcKOVPhYJLNrQdBrFYQZjdR3V1E00U8u8L/h2N5aVkGm3+JaIMBLSHay0oCKUBxRs73dvTy2XweGDn8UiJiDcYO11FF4cUFnUNUwfEAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707363879; c=relaxed/simple;
	bh=g0fx2hA5H7XGXKhInZLiSKn01bgcxRTeVThP7ASvphc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KBHqwlHo3hXKz15seOolWcQ30w/wEUHHFWL8F1mwz/VrOWvpBoWrD2Ko7Agy+alLuSRaRnl1iYsj/bkTkAoh096L2jU5PoEph3HdS3BrVhh/Iu49dOyFvyV6zU8+Vsp9mpXeZ9WaB+n+M0lHwEXYrqzU8NCdWphgdGZfCbG5/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=D6lzucUR; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-21433afcc53so754103fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 19:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707363877; x=1707968677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yizVqarSWst4aU/Dh5XxoRIOdJJxEsR3ATXXBPWi+lw=;
        b=D6lzucURy+G58YW49NY9DjKm15fcUNvgkHS6CPHWXsc+eF+Yyx0R8Vr3RN4qmjPvSS
         RBCrJtbOaedOoKtym1BDD4nzsw5qKUyhMthXTWF6WjgsW0tw9qsXUBE3J09tBzy+XqKN
         1UPJPRnP+g+zKEzFS2t2us43tsWBcyCArIt9HlW7Nuf4R3fWmVGqQR8/4lDKeKfh5Vpm
         m8l8+q+A0f+MzcInNiWUW+ck7KEgSnnCxftqQWYGt6CHS1a25xnAnsH9yOfNs8AJ5co6
         hXZKLu8vghzVMbG1gV7dXJKPPnm2bRch4w1MsyKnPFRgqzneWHJdf3/MSVgqwU0eALjj
         yZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707363877; x=1707968677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yizVqarSWst4aU/Dh5XxoRIOdJJxEsR3ATXXBPWi+lw=;
        b=MoT+C+gC8NM65FMDcv2+1CL96z0YLhSipYqKVSEhBFGzj5Sfy9lGi8FzVW6xiBdRwA
         XdZgt1wfUebSu8myOLcmp7BVCR7v6cQXVLNIzkPTSQUaQBKNDF8FqqiwY1IktVJuitMf
         V4wbNcYTR9Tk2KGSahuppZmHe9hvPBQzuJEmZN5Y78VnLdiP0T0xUDU4B3ytMK7egmYu
         fNmssj3mWHxHSxJtUbfg39ZzGMwUP+bKth3Fa79FXifovYFTyAd2pRGCFcc6jPUlGbMi
         km4tUNWOq0HKR9HQQI3avojbkuX1BNnLj9/3teZoDDLMwRwm0cEnkrrJbjDRj+SI2LbT
         FElA==
X-Forwarded-Encrypted: i=1; AJvYcCXCz5OQPRyllGsZuVis9HCfvZmAhuUqYMTM7Dku0nMS2kWKbXz5BIxfI7alXh6LwqfmDc8RmHaNFWDD0X+FP/PIyoY9Cc5YRRFIVAD4
X-Gm-Message-State: AOJu0YxIsJHtBZKwUUBvKPiVuotV81JXQspHYCdr2A5QhBYf8owVmoj2
	TV+Y3cRsuNyLAJisHgQTKuoRmwxIOP5GiEZixTecf4csSOKM90AZEHjPCg1UHpQ=
X-Google-Smtp-Source: AGHT+IFOtpxyVrCmmf5j/9YheBJxdbKCH0Y2umngPfrW1aFy9KUJdJOkdmzNUcIURse5wbX8fsh1xQ==
X-Received: by 2002:a05:6870:1681:b0:214:269d:785a with SMTP id j1-20020a056870168100b00214269d785amr8743371oae.53.1707363877181;
        Wed, 07 Feb 2024 19:44:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWn8ZEOAjgnL+Jx4yBkYXCD5ALrkdT7ucfJBWU9DaGB2ywmBZjUnJW6ow7WqR3G5rX3vuzL+eJ3RulTStUSDcL6jTeGuOk3FAVNlVnC0cHJTRByIsx6ubfO/gOQZMro5pxY51D8WO++N/TlH4xtf6GZXlM9Gf918L6ENzgiQLyRny4viixyAPlBjxsHJhUAv0Piws3gr0ZQW9i59dTiUNVeyppZzrAk8QVeI7WGKSJifX9yCAMtJHGbo2VLVAojonpd6MgisF8Z5E9IzHJzW+dhkdwmd6QYg2A//29RZOG1h2iccMu5ipJIdI53iunhTFmAoqliiCsh1GE/HZw/by+qJK5lNPuWPMAa9JRdOt13fgFESIsvB0mUnrVa5rAciBlKP7ZYVbJlNXcTyUUa13pQUuEXUArgsWwcCT2jalgwb9YH2imqeDU0D76YTcY2hNgj0KYf
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id g10-20020a056830160a00b006ddbfc37c87sm443595otr.49.2024.02.07.19.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:44:36 -0800 (PST)
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
Subject: [PATCH v1 -next 2/3] cpufreq: Move CPPC configs to common Kconfig and add RISC-V
Date: Thu,  8 Feb 2024 09:14:13 +0530
Message-Id: <20240208034414.22579-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208034414.22579-1-sunilvl@ventanamicro.com>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPPC related config options are currently defined only in ARM specific
file. However, they are required for RISC-V as well. Instead of creating
a new Kconfig.riscv file and duplicating them, move them to the common
Kconfig file and enable RISC-V too.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/cpufreq/Kconfig     | 29 +++++++++++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm | 26 --------------------------
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 35efb53d5492..94e55c40970a 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -302,4 +302,33 @@ config QORIQ_CPUFREQ
 	  which are capable of changing the CPU's frequency dynamically.
 
 endif
+
+config ACPI_CPPC_CPUFREQ
+	tristate "CPUFreq driver based on the ACPI CPPC spec"
+	depends on ACPI_PROCESSOR
+	depends on ARM || ARM64 || RISCV
+	select ACPI_CPPC_LIB
+	help
+	  This adds a CPUFreq driver which uses CPPC methods
+	  as described in the ACPIv5.1 spec. CPPC stands for
+	  Collaborative Processor Performance Controls. It
+	  is based on an abstract continuous scale of CPU
+	  performance values which allows the remote power
+	  processor to flexibly optimize for power and
+	  performance. CPPC relies on power management firmware
+	  support for its operation.
+
+	  If in doubt, say N.
+
+config ACPI_CPPC_CPUFREQ_FIE
+	bool "Frequency Invariance support for CPPC cpufreq driver"
+	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
+	depends on ARM || ARM64 || RISCV
+	default y
+	help
+	  This extends frequency invariance support in the CPPC cpufreq driver,
+	  by using CPPC delivered and reference performance counters.
+
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index f911606897b8..987b3d900a89 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -3,32 +3,6 @@
 # ARM CPU Frequency scaling drivers
 #
 
-config ACPI_CPPC_CPUFREQ
-	tristate "CPUFreq driver based on the ACPI CPPC spec"
-	depends on ACPI_PROCESSOR
-	select ACPI_CPPC_LIB
-	help
-	  This adds a CPUFreq driver which uses CPPC methods
-	  as described in the ACPIv5.1 spec. CPPC stands for
-	  Collaborative Processor Performance Controls. It
-	  is based on an abstract continuous scale of CPU
-	  performance values which allows the remote power
-	  processor to flexibly optimize for power and
-	  performance. CPPC relies on power management firmware
-	  support for its operation.
-
-	  If in doubt, say N.
-
-config ACPI_CPPC_CPUFREQ_FIE
-	bool "Frequency Invariance support for CPPC cpufreq driver"
-	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
-	default y
-	help
-	  This extends frequency invariance support in the CPPC cpufreq driver,
-	  by using CPPC delivered and reference performance counters.
-
-	  If in doubt, say N.
-
 config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
 	depends on ARCH_SUNXI
-- 
2.34.1


