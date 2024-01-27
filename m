Return-Path: <linux-kernel+bounces-41299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD183EE87
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E311F245F0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFBF6089E;
	Sat, 27 Jan 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NgI8QuVQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C260876
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372437; cv=none; b=imVTV0R1Lh8heoCMnPQL2gCLxv6Zu0iezIY0Z4aareGTwZ+O4TMmClsbGsFm57Xlj094+xsJbKdcZn017J0iOycS+34RlOJ+H7JPNXcAsZLveRrS27gL+yvL+aqc9lSSXqrtE3lW3L4+bblPVhRZhQwWruC6CPNUJdELHNd01yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372437; c=relaxed/simple;
	bh=3djnGcxqa8gEQ0UXtprDkgPU0PXes/PEob7SPPzlR8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGkpoHvzzK5BOsKb3EyCVW0Pq/Lyk2SHJEyxqJzBljw+Obx0C2YbadlcrMuLGonQzVHLjq0HwohaMoGQJxTD8zwRLFlC39/O/bMUU/YFU5lvgaxmK7KvsB/mU/uwLKDV4RGaApCsFIS87avtfz65LYoyQNeGP6Ct8AHU0DqK1V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NgI8QuVQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d71b62fa87so16097995ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372435; x=1706977235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKr4R3ReoTivFHMhBAg5uu2FBun4VRRnzFiPnpPYZRY=;
        b=NgI8QuVQ/Wk69wbd9HVFRzM7l7JXTlictxwBe2/PySnQLruRgkdwFRntIKcAqq2hgJ
         o1bzI/37jeOrYDYdmOaHMY1GJnLQGwSMIfsWJL/Z6Xt06P1FeW1a/Fab2sVg2H9ckGly
         6+2j5XAlKuUYhpnsFRU6ykWHxo+ziXIUq6Go5uwaUP1plTjUiww3ymxLnlSkafjrDaRw
         mV1xVMnA+aII92UYJCyb7qPQDt6jVTLyYVJBVolZr+emBnd//Vzqnr4yDcY+TxDq8UWr
         ZUMCDx0+0QGoswDvWXhtCz3/sLAtNv69uhNtmAK3jQt4uXa+vOSsVUuHoNncCuiKuSEx
         nLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372435; x=1706977235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKr4R3ReoTivFHMhBAg5uu2FBun4VRRnzFiPnpPYZRY=;
        b=ddiIuTmnYgtNaSgJXgT+Msdf26U7Pzb4yDVJMPMV579t3He7xnjFlNnnkrP37Q9Dmy
         Z/wIE3d1DjVOFC+7uBjxckIkCUHkW2nU1i6ELVsVD+LutgEVlykEmd8pjPBhVqRhSPWY
         71xdX4euLb7p6r+o3yAEL0ZA6BnejiuJAaBoV+oyKtimRLIN6MT6M6WPgoqxInAKNUCT
         XzWKUUO0k1rEWOyzIPsrGymO8wsr6f59aOCxeRSI597ChIKiIAA1EVIenqCxhZ50lt5f
         HCkOduqklHU+Zz+KDG76vMcP2HJdrgR6fVEIq7T5CFQy3JjLYltr5CeiqEx7ULEzrJtF
         HzZQ==
X-Gm-Message-State: AOJu0YxA9derKbI6/bmQQCp+yS5NcqZUS6YAguTT5KrtGDgZFTXnD3TN
	oyua0MYrsPHp/N+JvyRaZ8GLtGCT983Ta/uKi7LZWg2m/nMaf5LSBKaYQRknNx4=
X-Google-Smtp-Source: AGHT+IH+09rxnVj+v63YGbzebMdNocoIUARHK8Q/XqwlAzTL0KPUnJV/xhDxS1x77jvAJNgqpyZR9A==
X-Received: by 2002:a17:90a:8985:b0:28d:5536:2e8d with SMTP id v5-20020a17090a898500b0028d55362e8dmr1647576pjn.48.1706372435319;
        Sat, 27 Jan 2024 08:20:35 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:20:34 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v12 24/25] RISC-V: Select APLIC and IMSIC drivers
Date: Sat, 27 Jan 2024 21:47:52 +0530
Message-Id: <20240127161753.114685-25-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240127161753.114685-1-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QEMU virt machine supports AIA emulation and we also have
quite a few RISC-V platforms with AIA support under development
so let us select APLIC and IMSIC drivers for all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..569f2b6fd60a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -162,6 +162,8 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
+	select RISCV_APLIC
+	select RISCV_IMSIC
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
-- 
2.34.1


