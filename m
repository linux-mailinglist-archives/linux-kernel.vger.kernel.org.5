Return-Path: <linux-kernel+bounces-76123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C595B85F331
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79771284235
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F44053AC;
	Thu, 22 Feb 2024 08:41:42 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FE20310;
	Thu, 22 Feb 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591302; cv=none; b=rdiJMaWOvBLUjXTEzpDwLIL33jn46U8/bGrmChdGWu2iyHXeM9KJJcLcXDHM8vqKnBKyovwCi7z+zvVWa9bJ+a+hfHAdQ7Incv1NQALBRWN0ah0K6CjC84UF9dMced5m9JxiVfStb2A/wLlG/N2cQRpo0VR/6N4qgGnhqPJWioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591302; c=relaxed/simple;
	bh=7sZNOHc7T8PiveA1x9QwwNpNSGm5S1gwPv/mAQj5Njo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mqrignsEmYIV+MxQUFNUlwM+VnjQJZg8rVqy8Bt5xXo2IF3ilbqS7p7NudYO2Cg/qb57imiPIbVGoPn8TKZjzABgoAL8Umnm46SFZtJmPnxKdbdtZRQOyG8G3gwGgd3O5YDMbm+vTd7cYiJ2AKBGkcG5zHpD+37p1dOxLBieKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 41M8drkA074262;
	Thu, 22 Feb 2024 16:39:53 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Feb 2024
 16:39:52 +0800
From: Yu Chien Peter Lin <peterlin@andestech.com>
To: <acme@kernel.org>, <adrian.hunter@intel.com>, <ajones@ventanamicro.com>,
        <alexander.shishkin@linux.intel.com>, <andre.przywara@arm.com>,
        <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
        <atishp@atishpatra.org>, <conor+dt@kernel.org>,
        <conor.dooley@microchip.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>, <jolsa@kernel.org>,
        <jszhang@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <locus84@andestech.com>,
        <magnus.damm@gmail.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <n.shubin@yadro.com>, <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterlin@andestech.com>,
        <peterz@infradead.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tglx@linutronix.de>,
        <tim609@andestech.com>, <uwu@icenowy.me>, <wens@csie.org>,
        <will@kernel.org>, <inochiama@outlook.com>, <unicorn_wang@outlook.com>,
        <wefu@redhat.com>
Subject: [PATCH v9 00/10] Support Andes PMU extension
Date: Thu, 22 Feb 2024 16:39:36 +0800
Message-ID: <20240222083946.3977135-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 41M8drkA074262

Hi All,

This patch series introduces the Andes PMU extension, which serves the
same purpose as Sscofpmf and Smcntrpmf. Its non-standard local interrupt
is assigned to bit 18 in the custom S-mode local interrupt enable and
pending registers (slie/slip), while the interrupt cause is (256 + 18).

The series can be found on Andes Technology GitHub:
- https://github.com/andestech/linux/commits/andes-pmu-support-v9

The PMU device tree node used on AX45MP:
- https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md#example-3

Locus Wei-Han Chen (1):
  riscv: andes: Support specifying symbolic firmware and hardware raw
    events

Yu Chien Peter Lin (9):
  riscv: errata: Rename defines for Andes
  irqchip/riscv-intc: Allow large non-standard interrupt number
  irqchip/riscv-intc: Introduce Andes hart-level interrupt controller
  dt-bindings: riscv: Add Andes interrupt controller compatible string
  riscv: dts: renesas: r9a07g043f: Update compatible string to use Andes
    INTC
  perf: RISC-V: Eliminate redundant interrupt enable/disable operations
  perf: RISC-V: Introduce Andes PMU to support perf event sampling
  dt-bindings: riscv: Add Andes PMU extension description
  riscv: dts: renesas: Add Andes PMU extension for r9a07g043f

 .../devicetree/bindings/riscv/cpus.yaml       |   6 +-
 .../devicetree/bindings/riscv/extensions.yaml |   7 +
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +-
 arch/riscv/errata/andes/errata.c              |  10 +-
 arch/riscv/include/asm/errata_list.h          |  13 +-
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/vendorid_list.h        |   2 +-
 arch/riscv/kernel/alternative.c               |   2 +-
 arch/riscv/kernel/cpufeature.c                |   1 +
 drivers/irqchip/irq-riscv-intc.c              |  82 +++++++++--
 drivers/perf/Kconfig                          |  14 ++
 drivers/perf/riscv_pmu_sbi.c                  |  37 ++++-
 include/linux/soc/andes/irq.h                 |  18 +++
 .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
 .../arch/riscv/andes/ax45/instructions.json   | 127 ++++++++++++++++++
 .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
 .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
 18 files changed, 488 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/soc/andes/irq.h
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json

-- 
2.34.1


