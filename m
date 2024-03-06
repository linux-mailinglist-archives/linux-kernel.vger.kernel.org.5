Return-Path: <linux-kernel+bounces-94538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D905874122
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A0E1F25BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71849145661;
	Wed,  6 Mar 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="k9FoDYV8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2691420BB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755473; cv=none; b=o6azt+/l7E5YRWX84JmDBGrcgP/UAkljW0D4NuQH44PN2HG/gMSDixfqtWtTL2YJF5A6452RRAZolMt2igx9ViH4nYpEP3BRnCMQlagANaxe1yhlCmg8872jkhLWg0k8bGPitO0y7j5DUGPbPJAZFhSCKYGR6OTFI71CoPSo6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755473; c=relaxed/simple;
	bh=VSZiKx13zcdCVDYwqIRzCcJDp79icXmI6mc1wjrw+wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJ27799/mqxCFvAwYRDmlbS8CdmpwNsxQRLWewuRqDgSCAmPlSY01xCxmo/d1qUJnK4LbXXH56YTDpTU9o7WRGFNqS4LYq6o/ofpcxS/Z4hl7Qu/KElpugiS18ncm8xbowmGhYBPoCdy9mN8yit/7GEvgqV+nMwtKZsg+J5cuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=k9FoDYV8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dccb2edc6dso943525ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709755471; x=1710360271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8i7Hn0NjGdBjABWwTPM97LUVWqQ4V1pWIxyh4e32z8=;
        b=k9FoDYV8UTfU/j2HryRYDpAot5v/B8w7q/q3FRc1sor8Db57yqOKnh4C01ruX5AMI5
         2PsCLQ0W9R7LppcDiJ2Jd1zJL/TjxQf9GNPyXT8P2EqcG5ssunmis4Mr8FoDD9NRWANd
         /m5n/iFiO2yWhvgupyDnnXxINHON/NfxoNhI+Duv8UoHAmwHKetd3CbsGqcS7XvPfgHp
         bdaXEriOpU0+UOYYqlcyBQt9Loz213z9o5h1yj+ylTVN9cEXz3Tltdd67b9kwBcm/4sx
         sQQwj7HydXaFIe/726i85drYu1RCQi5p2HsL9MFarLPopz0a3QEWcjvK3F7AOB9Dx3Xm
         /hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755471; x=1710360271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8i7Hn0NjGdBjABWwTPM97LUVWqQ4V1pWIxyh4e32z8=;
        b=ZJ0qgnFcWo89fflbdyTX65vgt58sAvEXFYtO90jwqhxVzhnxSvKMMTbAeWL5ZKx9wB
         x6PjdQowsP7gb2FOpC9V4fOgz2ORmp0+8Pl5jeNSn6pLB6XDfgbMoU6v0coD9wJfIMaV
         G2TsA1bCdOPCi69TBscGqSUV102foiS9gvJL1WLkckvfv58TJiS36wzomQwYFwI122lQ
         KaggYbwJtnAWatXUapL5Ir5n8httKr059cedq4GSudHOtRxFN0TvuPMO+qp++zMbG0+A
         3+m6N41XEpmBHGMNHUYvYhYyEw694HUj3Y5iL6ZJOwxCWHOFfxT5GFivRsC26CMl8Mrz
         Z/mg==
X-Forwarded-Encrypted: i=1; AJvYcCXF/EJsAKSuq+i4He8yhCtSx7YpM6g6HA8SnvsiQaU7ljy/MShIjNpZ8KuVoPhBMS8QEj6sHmwUJKopEoxTm2D4iMQmk0T2xu90pscZ
X-Gm-Message-State: AOJu0Yy425xyie4svMMLKiHNH8FhRKmIsuJLOxNrR3/D196FlvQ8PfHn
	8sUbNpANG7UO0PPSYWFUa/bBxxE8x6WfXZX5IuJF//19Mwi7v472VeClEkGXrzE=
X-Google-Smtp-Source: AGHT+IFiTweil7aQBRcwI+7H86suc3cGJBwmzJVih/YHjqX8u0RZZY9V0G85J7qj4Q4zuaOUvEoKZQ==
X-Received: by 2002:a17:902:f787:b0:1d9:8832:f800 with SMTP id q7-20020a170902f78700b001d98832f800mr7051856pln.8.1709755471482;
        Wed, 06 Mar 2024 12:04:31 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001dd42bbb08asm874913plx.253.2024.03.06.12.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:04:30 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 06 Mar 2024 12:00:02 -0800
Subject: [PATCH v7 2/4] riscv: Only check online cpus for emulated accesses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-disable_misaligned_probe_config-v7-2-6c90419e7a96@rivosinc.com>
References: <20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com>
In-Reply-To: <20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709755467; l=985;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=VSZiKx13zcdCVDYwqIRzCcJDp79icXmI6mc1wjrw+wY=;
 b=J0jL6+8JqCrPcSklgw9NSjUi73EcQ1W43bQbtjsgXL78c2d9/VwkDRPZmyz/8+75OR9dmiASR
 BogsnEbR27ICPcusENpMNmdyy8SN/GRLOuSHLzCSpXseFkTsqmzXnz5
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The unaligned access checker only sets valid values for online cpus.
Check for these values on online cpus rather than on present cpus.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 8ded225e8c5b..c2ed4e689bf9 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -632,7 +632,7 @@ void unaligned_emulation_finish(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		if (per_cpu(misaligned_access_speed, cpu) !=
 					RISCV_HWPROBE_MISALIGNED_EMULATED) {
 			return;

-- 
2.43.2


