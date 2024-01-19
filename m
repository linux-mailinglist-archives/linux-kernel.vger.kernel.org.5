Return-Path: <linux-kernel+bounces-31104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21368328E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A685EB234EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD974F1EF;
	Fri, 19 Jan 2024 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mbi9StrE"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865F4F88A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664131; cv=none; b=QADWwu2qzq6wfqHmX2QABejxrdqNeNxw0b0QNVG0q1n/+e0G8J7VpWNiIGOO74WVZ0bARZGP54ZPD6lfpftbJpiZX9P1+VC5NDuCodb08bqEkwJskig/LQSz1r1d2wBt7xE2THGzzsyrDU7qyUcIWEsc0zLj5bRcWoStLUPB7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664131; c=relaxed/simple;
	bh=fqqDjN66329pa4niMWl6MkhJrFW850wjJ+KnOw48Ihc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQRTiT8H3f/cAk0Ml4OFt986C+UOnkl13R/v+IDJrPdvPd6RFGTtzPUOCEMqrkY9cqFfy6fscfsUIcj4hHP0V2Eedzrsksdr47oXAEfEcLKtWGwIskKPVQjZZ5gSS3RbyY5jPSsegT8yWXV4GB+CyHCkIPW/s/aJKwJpMrKEnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mbi9StrE; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36082f3cb05so2796725ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705664129; x=1706268929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bsP20n9g/LbbgzyTFqfc2H9X3ZVkLkHm6HS5kmWZpw=;
        b=mbi9StrENwn6XzzWy1BiKRt2MrZXI0FQNYiBXiqntu4B3GBqLg2ACdEkuni/HKDOh7
         xeHFb3EQ4WlP3gnlHxkvuLUeAnOPm7oBkcm2mR89JAIeBONVVYYMPaOT1s5m/dIVWmIO
         pguQv9lZ8KL+hld87j1xwIhhVTu1H6fBpSwC5CqNVHNT4qPb4gbFbihbHt30CbSeU1/K
         HAhwSrunwR1C6rvad4H0JDq93r6wWQpJ+Bl6Ms0U7xYYR5s2DDyV3FZ54ejnHy26fyuC
         d+eaaLcjyrkCIMaGGyiuHge4Fc6Vx61+LiM2GzvOnasu+Bt2JbhG3G63Z4dP0jSHW/Gf
         1Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705664129; x=1706268929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bsP20n9g/LbbgzyTFqfc2H9X3ZVkLkHm6HS5kmWZpw=;
        b=k5clVimfI0ppSDA7kW3TCjHBmLngI9z2ocIkJv3EjMzlIZ/eze6s+CfiVfTWX0l3Ir
         2kb8n0Tcx2yNy+uo6eDl/2O31JdwIgRHPNH79ROKQctAFt5e6jHOqQCJfj+UsUiVpkI0
         lxpZFXvTqsZaArT3g4E/6oiwFa85ETwhQoMGBmcZDDoojavWmAaRoSFKwSgV8dOShq7V
         98Ao/bI2Bq+bCjfAEZFH8IOhRsEbItT0oOufIQOrXUYhu0k10qXJvbyOc3ajqYd8yJ7A
         ElHribbvvEm+Bra1VM3ksypvxG78tgiQGWv2YQCvvmSQVQk7GhX+OBjOTifxSwUb4Yx4
         3U6w==
X-Gm-Message-State: AOJu0YxPDQbZMFP6tusQ81s+DN2WdZK7l/dKownA2wfYOFORkxuWxIab
	t6Jt2vfDDaT71kCACNf0P/RviI1jVjNeMwSeva1jQtIKyinI7H2TEipjMgWf8mY=
X-Google-Smtp-Source: AGHT+IGm7KnfG4/vcA0JrRBkZfX6RoyXH3aaqdl/Wta7fnqjAcw1zMCsGIqUf/hTovepwm0OqOzh9A==
X-Received: by 2002:a92:7310:0:b0:360:973b:844b with SMTP id o16-20020a927310000000b00360973b844bmr2368211ilc.11.1705664129602;
        Fri, 19 Jan 2024 03:35:29 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id a5-20020a92a305000000b0036062f40c51sm5347302ili.71.2024.01.19.03.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:35:29 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 5/5] RISC-V: Enable SBI based earlycon support
Date: Fri, 19 Jan 2024 17:04:49 +0530
Message-Id: <20240119113449.492152-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119113449.492152-1-apatel@ventanamicro.com>
References: <20240119113449.492152-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let us enable SBI based earlycon support in defconfig for both RV32
and RV64 so that "earlycon=sbi" can be used again.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 905881282a7c..eaf34e871e30 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -149,6 +149,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.34.1


