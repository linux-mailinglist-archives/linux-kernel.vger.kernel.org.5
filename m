Return-Path: <linux-kernel+bounces-57440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4460C84D918
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717691C22CE4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6534B2E637;
	Thu,  8 Feb 2024 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZF/FY+Wj"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453032E847
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707363884; cv=none; b=mMlW5xzspOP2Gqsxr1/0AOcFKC1ARr/RsMCFDe3WIZWHW3cHHah37db8wrKVKDT8jACQf9HG9yvFpRTKXUF8Bl16OFtdMHJpt8WDu0lZ9VlZ3gfAH6ABqwXI5c3GP3/Sg3+Yip5GzIPOg64jY33UehC1mrJw5KMj2pbHNvZIo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707363884; c=relaxed/simple;
	bh=k//nL0O52r0Pst+dMnarHtp2qW40QOxuRpgoBz8kxz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qtw1q1BIaPwMAwBIhDLH9llUOm3gt1M0yIZKB2Hi4Slwzy0e2ldLSMsPnWX0ei8ccs+8V2kt9kjFDmcT7gBL7b2yx8MxZIknTtgiSH9NbAyV8lwE2+e2oDZTJW06snIO1ZCbtcjMek3rCarmUxmdotBuKPvh9sZxVetDICT2h5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZF/FY+Wj; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-218eea4f1a7so751939fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 19:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707363882; x=1707968682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHHbaCQ0poyIlU4NNDp8/EJ+oDcSBjCEciZfSlQAroE=;
        b=ZF/FY+WjnT3ygBMUPf6UDktNH+t5dSGZi617TrWm/5EmMUQmaKakp99wR7Q2hyZRtu
         oNgrqOifXttQaI9RzNJ4ay3MKfYrflfpcR8bPsr5FLeMANJ4wJ8JxQ3Xl/qVzykjgQKN
         04f00ErSBBM+FGGlrI6lQAzdw3OeFgxsIR/bTfEBZeYSOJcORX2T2oH+1OQDlP8z+Alf
         V7pqgocVhcsh9WjCkyaK4tZ+u8Cofbnse0SuuTD4GaW4nwkQLQQbWyJ1CG7sNDEjdUns
         8A5GmRHlsGd/FNQgqkBZbJQCzaved9w090gzAsUmHy7YqGRNF+mfYrsvldB48sC2HreU
         98wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707363882; x=1707968682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHHbaCQ0poyIlU4NNDp8/EJ+oDcSBjCEciZfSlQAroE=;
        b=T6tTk3pmVZUqTDZQIHLdlSLnAJ7JC6Y5qHO8seYM10/vQr+kCtt43WzY3HDDlT+tuq
         4AhKJO88V/jm6x/xJUWvYiAnN4UE4Ata+61g3RMo7hGnun0gN96htvfADSKuJPn2EXi6
         +O4VxW4++PeQegQbDAONbocLQrmQ79dKJOAKQu8XnjX+uD6Kh2OnvchTuglvtvHmK3xz
         futkAuLRy4ganmlanrM8XMzIDIO6xJlTRNd3nYBLw39hcohpzI3TEtLi3TDwL7yaQOFA
         WKQyhfc/CYhRHcEE5njYOeoE/79ivTvDV1wtfRB+g2GwsCsUt5TJjjG9CtTZDJ4VTrxe
         DY9g==
X-Gm-Message-State: AOJu0YyGhzlDUURw0dRONk6igy6pY/y2PHrInNgMa5SjUs64EVaoeznh
	6XDyR5PNj1WSo0m7sGvigN/F4gUXbReKuK4ZpaCLo7iijeLNXISjjcP1aHvZDKs=
X-Google-Smtp-Source: AGHT+IF8S/sWdD2/t/IehosLthOGcp9RQPnzkTr2qd4mbuxfbLO4HkNLnW4usy2ZbfgHlv8pV/ejiA==
X-Received: by 2002:a05:6870:5aa6:b0:219:efcf:4566 with SMTP id dt38-20020a0568705aa600b00219efcf4566mr608603oab.13.1707363882197;
        Wed, 07 Feb 2024 19:44:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVh/Tfazr2HX3H9HLVSgqn2h5sWZF5zZ5Zu3TylAEJBkg6WlJX4/E7mdRNyYeqRzmewuTn9VXmXv1FtoOtXhtlcOre2zou7FFXQUDmY6pI/9p/FsbwVr0+8GGlVgHQ9AYdz6tBzr5/i8hIFf+7EspTg8jBmrbfhdhTP3qiwyFvjpwO2in0n4qTOitGh8nK7brPcNu/Kvh21nlOV/qTSz2Rnp1Gbk49vPosP7AWKXM6PoV/qytusk6FagZIAGKefqaqZynnwmgekry/tFV+XDLPJWXhLi4W2ycmDpIRCad/Huk1Yjxqhm2F7DjWvdLC3aIgaUNaY9EbYeOBLtVswBA3q71Sj1eHrmp9KORNCA/U8M8UAnDOI4Yp334RzlA1isNR7FePtaKlAYAN/Vo8T3HErx+2vd6HLGUiyszV6wXoj9Hcm2pveNgVjS2wxW6nYATvDx94n
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id g10-20020a056830160a00b006ddbfc37c87sm443595otr.49.2024.02.07.19.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:44:41 -0800 (PST)
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
Subject: [PATCH v1 -next 3/3] RISC-V: defconfig: Enable CONFIG_ACPI_CPPC_CPUFREQ
Date: Thu,  8 Feb 2024 09:14:14 +0530
Message-Id: <20240208034414.22579-4-sunilvl@ventanamicro.com>
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

CONFIG_ACPI_CPPC_CPUFREQ is required to enable CPPC for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index eaf34e871e30..2988ecd3eb4d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -44,6 +44,7 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPUFREQ_DT=y
+CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
-- 
2.34.1


