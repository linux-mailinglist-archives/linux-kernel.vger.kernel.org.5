Return-Path: <linux-kernel+bounces-72387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC03285B2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E22286690
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21375A4CA;
	Tue, 20 Feb 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Cf243DzK"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E05A790
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409339; cv=none; b=UfI4WnM5PGSQJgYR5jLaE0f2eIV4Js2uT4DVWS5i5X/OdoMR/TDmv+gf+nbtw+xdq2pi2bfFRSh5BRmYjEyglfxoIzkNMk0GYxV7fKIltJU0Fg/Pstlu5BJdmJeJ5lfzoE9EfpnkgLplGw1q8Xs54yLjH5Y0h2y50MdqNwr5Qus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409339; c=relaxed/simple;
	bh=3djnGcxqa8gEQ0UXtprDkgPU0PXes/PEob7SPPzlR8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evbzN0u88A2+yzkxoqRfThyxWZcicPzDf741s8DzklJNheoupJVjWgeakJo/1eBIns/PAYafL0PyDn9dJ3Vhhys6KRJKxCseHHj9shKlb5Rnspr01BCVt5dTZFTQ7SD4zXilxaxYVze0M81znxU3654zwDySg85xaFRkFdc4ySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Cf243DzK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dbf1fe91fcso14467165ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708409337; x=1709014137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKr4R3ReoTivFHMhBAg5uu2FBun4VRRnzFiPnpPYZRY=;
        b=Cf243DzKkFszYGrZg73FXslAk6NhsHT34RamjGQc0yDMk+GReKfuGGUIPhGA1FaBst
         8qIhGt3CwAan47wr60ozDRhfR0QixvztTMYxISzm1T8jZCzqUPz8DYPfq1zps7c5uIef
         cmJNTiH9FkKGIDA3c5uKYBffwVU0pGw9YxI6n7VX1aLZgJYEDwoXrOVSLU9Su/iqUtzY
         d8yvTnR/2t85R0AFuYXH3iU0zvm5AV5uZ0v1wLsrlyGcppz1jqkuEFSsiydXYVbFZHxt
         jXN2WWdl+X/PbXj6kQS1SRBkP/HNvDOZwZSrmW8hqTjDHlQXvtMGCyCZxqNXZnF+eYt0
         YW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708409337; x=1709014137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKr4R3ReoTivFHMhBAg5uu2FBun4VRRnzFiPnpPYZRY=;
        b=UwrGO6j7nyIURfeIl+ePz3rPWcn6yfVkAEkH/7AlCzeh2IFvkHdz9/YvG5zfH2DpQK
         P+pWOjGUjnF9uZTv0lr7AJ2vUlX2qgiUMLix8BbHmjeutfvu8Igd69BLw+8eaF+IdO7O
         lFq489tPmiV9HzM7RYGQJ4YAdo2j0vju5zM5wCQfQI4sjJOqNkWNRbVR++spAG0etaD8
         G1jqLOOuN+A4g3U71lt17SUbug3K7Oa/E/uxpfCRPkyHGVK7ne0zj4Nc5YeWj9PSI9fM
         t7VmL3/nOYeXIwzx1VowQqlPLCV3SIq+DQIh7qgDJDfwCZKPPb4gSbfjlPn32A2IVfq2
         Mv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXU/sTC7GHjCFDuPB76Z82MpLQJ0pMk2DflbUC8q3cRdn8ZTguNk3bDiLv4JDgjuneC8wBIwKnWpfz1CgVwlt2R8jTLf9bUO18weZKT
X-Gm-Message-State: AOJu0Yz26sN/3qy8lfnJtyqA72Vs9vC5rxMVgNpT69T7asuq22myh/NW
	4DlY7A/5sNtsLvkFOTe8gWstNbsD4hE4JtRd05Le8H7w3hC0VEWDj/M4iWWcbUQ=
X-Google-Smtp-Source: AGHT+IFb9Bfg8TcznAeX4miXen9vY/PhmLFqArIgBS7TcN4jBtbB9IX0woMxS1qzebtfhfM8laVDAw==
X-Received: by 2002:a17:902:ec89:b0:1db:aa46:4923 with SMTP id x9-20020a170902ec8900b001dbaa464923mr13179616plg.40.1708409337095;
        Mon, 19 Feb 2024 22:08:57 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.86])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001db4c89aea5sm5368114plt.158.2024.02.19.22.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:08:56 -0800 (PST)
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
Subject: [PATCH v13 12/13] RISC-V: Select APLIC and IMSIC drivers
Date: Tue, 20 Feb 2024 11:37:17 +0530
Message-Id: <20240220060718.823229-13-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220060718.823229-1-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
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


