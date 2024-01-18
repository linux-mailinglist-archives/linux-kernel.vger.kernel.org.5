Return-Path: <linux-kernel+bounces-29739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0C8312BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20711F22197
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3B0AD32;
	Thu, 18 Jan 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UojUzUzv"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD311CAD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559399; cv=none; b=okmo7SRojcm5FacVZYDNrhjL7Alsst8VXT+mC9dZlFecEjmlrC9IDP0T0n2wlVwL3GwfxdiKTJezUgQnOVYy3GY2LYjkJ/TNTEM092enKW7QuqKV+RvTumMl+GWUsXG8hyoE0TrI9Y80f9j7far7LAjjNnM2Md2CBxRNxnqSQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559399; c=relaxed/simple;
	bh=s0jCrtcsnupGkX8Rh/JQOe2YBiR/JeRC946luu2mtS8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=UgMQUCb8fOQ9U6HcS8pLRqZZqsstG36fVivSO4zUnzrXV4QyLJzOEVv/nTe71XiFa4K45W2Ss2KshuIUeaGhVwBettFhK3DPv6KGAGSuWFnR4+cwOLrVPJqELQY9HooUlkZI9CZKs4EzFUg97nDQ5DlmzxUKkCisgYpTQTGcxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UojUzUzv; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bc3e297bc9so538117939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705559397; x=1706164197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtA1yi7bJhENd0OSwZZPO3/DRQ+e8frz78vUteV9MTU=;
        b=UojUzUzv24vzKx8LoRVUqy+GH3tnYvLx6nxhIdmKNRHtZt5k827VZNiTDqRLpaUggM
         0c6zZAM07/9NpdX3ZN890z4INf7iHl1L2+cT1aHcY+BIEHVSQ7ICMWiwegTJEGFIs00s
         562W/JY0SrDUTEPg1Gy36ZSGZRql2w8T7FhIbey8GsECnhweTWcIlEJwvNhBJOfATpXT
         u2sxvhrltg2cne/Y5X/dK+nlYe51jneghQxDxAaSujLJwmQhnGTREj7DZz5IAzW5hTLh
         TpZHbUuYAT+Nwouicz2cQqv25vFDdUfS+sX5yIp39Cpna8XMnIZMJrEcjjmGwq7aNi0e
         Ctkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705559397; x=1706164197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtA1yi7bJhENd0OSwZZPO3/DRQ+e8frz78vUteV9MTU=;
        b=wBGN0/Y98qyEiduuGdk2Dezuv2unJUdMVDezTm+xjgFDNlh5TxuEvRZu64W0HqUfTG
         lJzr1/k1Su3YFN2S2Dvo6TYCkuHynocjpTOhf8HOcUvEDs1hGIwUUactLdYX/8aurkmy
         kkw+lyn0GwpNRqJ3PSO6T+7R2X3C3lkpp6spTsnRiHmTwnvEyxvur/TsSoiCrQzbSeT/
         oR6cp6dxEQafkLBcFKiYsdo47yKmNOgkIgbP3z7f7HP2fWM/HFlB8/70iWa5rfAG5vAQ
         qBNnf5azwt8l1GsOV2059ryWG0e0Hpe2qysm95z1jERCForIFxaqW1yHOlAhW70FGM6E
         PdOw==
X-Gm-Message-State: AOJu0YzVN2DrNDN4SxYf98pkXa9VvHlSzaSqtvNsyH5UHwaiabp8pFRX
	HlckVfY9yBz8TADT8ZI1ZLCQwnSlx3P8lWXcwkOoIOgSUzstgnjQpGCvM+puiKI=
X-Google-Smtp-Source: AGHT+IG5FtqixEBaNJDSNquSyctMTnCf+hskKjTKsUAyOqYtmHJhBUoYOvToNqCtx5vuaVjQy/gmAg==
X-Received: by 2002:a92:4a01:0:b0:361:993b:7f3 with SMTP id m1-20020a924a01000000b00361993b07f3mr523402ilf.11.1705559397011;
        Wed, 17 Jan 2024 22:29:57 -0800 (PST)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id bn28-20020a056e02339c00b0035fec699584sm4663269ilb.13.2024.01.17.22.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 22:29:56 -0800 (PST)
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
Subject: [PATCH v3 -next 3/3] ACPI: Enable ACPI_PROCESSOR for RISC-V
Date: Thu, 18 Jan 2024 11:59:30 +0530
Message-Id: <20240118062930.245937-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118062930.245937-1-sunilvl@ventanamicro.com>
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI processor driver is not currently enabled for RISC-V.
This is required to enable CPU related functionalities like
LPI and CPPC. Hence, enable ACPI_PROCESSOR for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f819e760ff19..9a920752171c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -282,7 +282,7 @@ config ACPI_CPPC_LIB
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on X86 || ARM64 || LOONGARCH
+	depends on X86 || ARM64 || LOONGARCH || RISCV
 	select ACPI_PROCESSOR_IDLE
 	select ACPI_CPU_FREQ_PSS if X86 || LOONGARCH
 	select THERMAL
-- 
2.34.1


