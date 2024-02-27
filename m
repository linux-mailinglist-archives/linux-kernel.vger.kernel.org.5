Return-Path: <linux-kernel+bounces-83666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151ED869D06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38B0287553
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0C52C69D;
	Tue, 27 Feb 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="ss/rCZVI";
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="Ac+HUnNY"
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C21D54A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053277; cv=none; b=uaHuesXcOS+dzvKlhNP7HKBSRYS3aOlVA+jetL7mXECPyv5lCCUGH/yRxrm6ntW0NsrQDhZH8xuzQ8T8XYWTnMWwY7BmpHxlYZN3Erj6f47v+P5mj0EZ8UuDJN22qVpsQ2t0w45Vn+nOgy1J+IaRg6WC1qZJa5oZyNdTBbGoTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053277; c=relaxed/simple;
	bh=bznWHDXOpwAbmVELiNtkF+Zamo+nMl6cy7ms9jMVmTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rbpff0ZYvVCQ2FBojk2ujoPXQNulFh5d8HpmyCyXOAEi9//y/a/A0TgnAu/fwtLFvgfmh/mpZbNXBE2YYu5fpsG1YwgGjw/pr1VnzqPs1isCuCuv228KJCGKr27sYYfBpaWflCbipPilua+LU8Ccs4009+1NHlpAYCbGuAJLD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=fail smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=ss/rCZVI; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=Ac+HUnNY; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=syntacore.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 219C4C002E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-04; t=1709053273;
	bh=mczoY9NKf5IBt5T4Xh9ynOn0nMrRnFZ+wXSkQuHkLYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ss/rCZVIbpEiLw/81MIs41zgCIYwQ7eO1waUK8E2lC8XV1bPZ/ADFEl5i9RCdVgQn
	 NVgXiB2dxEOFXWIKocoDXNdcQ+2ppyHptremx/GYff26TGVX6GRbvNeIWq329bsEcI
	 XulHE91KC1Oj9t/Wb+cDtuvFR2oD13+CZd7wHbiH5dFfRx797j4UOCCsGy+p+yG4UH
	 Sv7JIk/FNsJzUVcdNGIKyYsXSwav/yKU9qqMTUEyzTYlCrBl4aG6epatfU/yYXgdcx
	 DTmEnXn7rAKjOaIxBvQxaYWh+AXP4XiOx3HHj6wqal3uhghxS37F+2xk4PNEbb+FC6
	 mFvMoAegilq5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-03; t=1709053273;
	bh=mczoY9NKf5IBt5T4Xh9ynOn0nMrRnFZ+wXSkQuHkLYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Ac+HUnNYE6GR09eK4K4fDoSgzTYJDSzmjFTWbF4DHCLei8ZJ7/ZyhmedErh8tfw/i
	 ouFn25bFeAJZgIzuSuoykv3pDYUCflzkbH6U8QlAqtW91cdxy81wrCSF9EiXM2TfeY
	 C9o+l/5J39JIugvNl1fy+cxk7SYW88+zIyh7Wut7B+P4/c5hDjf4i++9/lRgLOIlES
	 /DEqtjTlehyFThpiclkVrSV4eKqotjf2z0f/8pwTDZ1H5z6ktgfNd0CKiUB3Nlt5PS
	 EG22pwa7H5Ytcv4YEx+XLMI0F6XLVE/XPzEiu+fI8+C8duGJUJ5V1PkM22tR1q1E7F
	 UqQTU2G4Q4SXQ==
From: Vadim Shakirov <vadim.shakirov@syntacore.com>
To: <linux-riscv@lists.infradead.org>
CC: Vadim Shakirov <vadim.shakirov@syntacore.com>, Atish Patra
	<atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, Will Deacon
	<will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2,RESEND 1/2] drivers: perf: added capabilities for legacy PMU
Date: Tue, 27 Feb 2024 20:00:01 +0300
Message-ID: <20240227170002.188671-2-vadim.shakirov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227170002.188671-1-vadim.shakirov@syntacore.com>
References: <20240227170002.188671-1-vadim.shakirov@syntacore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 S-Exch-01.corp.yadro.com (10.78.5.241)

Added the PERF_PMU_CAP_NO_INTERRUPT flag because the legacy pmu driver
does not provide sampling capabilities

Added the PERF_PMU_CAP_NO_EXCLUDE flag because the legacy pmu driver
does not provide the ability to disable counter incrementation in
different privilege modes

Suggested-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
---
 drivers/perf/riscv_pmu_legacy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index 79fdd667922e..a85fc9a15f03 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -117,6 +117,8 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 	pmu->event_mapped = pmu_legacy_event_mapped;
 	pmu->event_unmapped = pmu_legacy_event_unmapped;
 	pmu->csr_index = pmu_legacy_csr_index;
+	pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
 
 	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
 }
-- 
2.34.1


