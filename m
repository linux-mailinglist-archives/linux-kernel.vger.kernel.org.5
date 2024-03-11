Return-Path: <linux-kernel+bounces-98499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6061C877AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A2FB20D16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9ADE56A;
	Mon, 11 Mar 2024 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf0sNyAI"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549563D5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138649; cv=none; b=ZB5Zfj2YPioMOfh0aJYvaCluQN01W/fCiMZCd3czgJr1tzXDywJwvx9DFg+Hq6py+bMggTIKXUxP9WDpVcZeL7s5gMAztr5L+YbDrLeLibT1awzmod6YUrhE3WfcKsfzyFK/4/Fne0O+C4jQcOxRwjuD4uThIAg6c5aU99PADRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138649; c=relaxed/simple;
	bh=cmIBHkA2pdJXMvafu0YUa0N9N0kN4IiC2HGINT1wP9Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=eQKs3Xa/HM1hwxLIvlXRGwCUkyh3JF6UwyEk+V5YEfqVRQQAN8vNPilbFpAxk1mDK7UqykLyvCHUBlabcPrEmdK1MZJjxSznQ76al18p2sSXLo6+DXS+oVtI8WFr2Dn69y/zF4paHAv5aUJ4+9zKN4+IxSXmwv54qm/V1s0bvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf0sNyAI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e627596554so1690900b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710138647; x=1710743447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ7Kf9VmIry7xZNUuPTcVhrx5As2GM5N21xZAtn+OAg=;
        b=Uf0sNyAIVTpVBVkQif/NaAPpHAjbsRpcWL3nS41tUWqe2YDUAmvoLAtDkJOuazm1fV
         Nt95O54+TTZR1NQ51m+qhyTEtLIMMrA1qw7gBUrwowrh+YwSMzSCqpA46oGqMrb4w1IY
         6E576+9+Qc1C9krh2v55mDiCtBogNFtI41N7hE4q/R8xYS0IQbnrLq5Ks53/Axx8zX1S
         TMlANkMfPHIyzGDaGJd04wOmP6xSn2LrSRBkLvEPUNgcClUSCSC+LE2u35GPiGH2ielB
         pzIroCJQw5cnzna0A3BDnzbJvTMtf/aq4vkgcZJhU7wlYrl2+VR9LX/C34RK3Ts7j88x
         o1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710138647; x=1710743447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ7Kf9VmIry7xZNUuPTcVhrx5As2GM5N21xZAtn+OAg=;
        b=if2RMKtfV5+zGlLxCsG4iBaY1DFz4sDj4w0EQs2120WzkZE8S2EeUnQQyG6VFZaXNs
         5BeZma+6l8SZOdq/h0hit6wZM4m2IvDV12erjOD3Cbz+Bdd4trMy7PXXh4MXlJ1k/FBB
         9ZFclOV94JRLhvIvtY9RTABboKIPl1PRSBqtAUQvMFSfv2o1/IHPFSPP1OZp+yqZTmwb
         jEa4DQuvazSyZ+G1AilBNCQ+ySr0V8gaSdvgDjbo0zwYP13q+jMLE2AVEpclUUCQkWW1
         cgnmavwGck4UIblPE6EsJugaoK24rc49pLCjr7q9L6aheacif0q2aIxFoTw3cKN7XKzm
         Ngcg==
X-Forwarded-Encrypted: i=1; AJvYcCXeUOeh1lhqlM6mrYP+zxu8Qlo0OjpUYsSVB0+NPIYji0cyR7R/htN0/9nZeSS9ziP+SLpa6XKFNtkbXZnqRJnIhO9l6+q2/XuNvmqA
X-Gm-Message-State: AOJu0YzfXVQK7ryY+LyqKobGqQHqUBMg+Je4LDDdlfhZW2iNmHNHxcHx
	e3HBZNZ6/23CtxKwsO3LtZtWMKb4y6Qhc6qkU9/J9nHeBj+sq9A4
X-Google-Smtp-Source: AGHT+IE2d7g6KEx5Pi0QGiEbt7oNk3z4OQdctup+mwEl0Rlyqk0V6ap/+GtCZwJbxw1uSFnsM+m/JA==
X-Received: by 2002:a05:6a00:3c85:b0:6e6:35d8:9c56 with SMTP id lm5-20020a056a003c8500b006e635d89c56mr6841451pfb.11.1710138647023;
        Sun, 10 Mar 2024 23:30:47 -0700 (PDT)
Received: from DESKTOP-4R0U3NR.siflower.com ([2a09:bac5:80c9:183c::26a:36])
        by smtp.gmail.com with ESMTPSA id t23-20020a62d157000000b006e56277fd45sm3765410pfl.190.2024.03.10.23.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 23:30:46 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Date: Mon, 11 Mar 2024 14:30:18 +0800
Message-Id: <20240311063018.1886757-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T-Head C908 has the same IRQ num and CSR as previous C9xx cores, but
reports non-zero marchid and mimpid. Remove the ID checks.

Fixes: 65e9fb081877 ("drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 arch/riscv/errata/thead/errata.c | 4 ----
 drivers/perf/riscv_pmu_sbi.c     | 4 +---
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index b1c410bbc1ae..49ccad5b21bb 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -125,10 +125,6 @@ static bool errata_probe_pmu(unsigned int stage,
 	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
 		return false;
 
-	/* target-c9xx cores report arch_id and impid as 0 */
-	if (arch_id != 0 || impid != 0)
-		return false;
-
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return false;
 
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 452aab49db1e..87b83184383a 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -811,9 +811,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		riscv_pmu_irq_num = RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
 	} else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
-		   riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
-		   riscv_cached_marchid(0) == 0 &&
-		   riscv_cached_mimpid(0) == 0) {
+		   riscv_cached_mvendorid(0) == THEAD_VENDOR_ID) {
 		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
 	}
-- 
2.34.1


