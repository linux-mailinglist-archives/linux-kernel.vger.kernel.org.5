Return-Path: <linux-kernel+bounces-42465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D18401B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C62835F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDA260897;
	Mon, 29 Jan 2024 09:28:37 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA160864;
	Mon, 29 Jan 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520516; cv=none; b=VGIi7c85zh2aZH0rHCD4yXzMZNAR66fQ76yfCNK365FMtNUqagcgxvkmkBL+Tg3oqRUN8QQ5bVT9vjqToEnfu2CCwzsHkJW+WQKKtO89C8KSmJaOLw2Z5UG3MttCPhAJp8wEUmWgMf33Y7oNsSuY2ii4kL4qbcRSlHWjdB2wXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520516; c=relaxed/simple;
	bh=KmnQCO9L3bVBcZaB+8oklJut8FyVVW78SVUs2lJgV+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhWZw9deJZckeQIU7gH7gXF9GyMxBh3uZDbB7gemfOUx4u3LdwA9tcvXJDsXtD2GEYugOjIvorsNIRC5Dk8cAHf3KN9C903mlNHSFxsNV/SiicU+gRiGTfnYedx5z1sZt3GE5Vgdrha4MmIrBweXF1x+O4dXdffS7Rt6VBR3nGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 40T9Qogc080373;
	Mon, 29 Jan 2024 17:26:50 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Jan 2024
 17:26:46 +0800
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
CC: Charles Ci-Jyun Wu <dminus@andestech.com>,
        Leo Yu-Chi Liang
	<ycliang@andestech.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v8 10/10] riscv: andes: Support specifying symbolic firmware and hardware raw events
Date: Mon, 29 Jan 2024 17:25:53 +0800
Message-ID: <20240129092553.2058043-11-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129092553.2058043-1-peterlin@andestech.com>
References: <20240129092553.2058043-1-peterlin@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 40T9Qogc080373

From: Locus Wei-Han Chen <locus84@andestech.com>

Add the Andes AX45 JSON files that allows specifying symbolic event
names for the raw PMU events.

Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>
Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Atish Patra <atishp@rivosinc.com>
---
Changes v1 -> v2:
  - No change
Changes v2 -> v3:
  - No change
Changes v3 -> v4:
  - No change
Changes v4 -> v5:
  - Include Prabhakar's Tested-by
Changes v5 -> v6:
  - No change
Changes v6 -> v7:
  - No change
Changes v7 -> v8:
  - Include Atish's Acked-by
---
 .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
 .../arch/riscv/andes/ax45/instructions.json   | 127 ++++++++++++++++++
 .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
 .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
 5 files changed, 330 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json

diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
new file mode 100644
index 000000000000..9b4a032186a7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
@@ -0,0 +1,68 @@
+[
+  {
+    "ArchStdEvent": "FW_MISALIGNED_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_MISALIGNED_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ILLEGAL_INSN"
+  },
+  {
+    "ArchStdEvent": "FW_SET_TIMER"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json b/tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
new file mode 100644
index 000000000000..713a08c1a40f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
@@ -0,0 +1,127 @@
+[
+	{
+		"EventCode": "0x10",
+		"EventName": "cycle_count",
+		"BriefDescription": "Cycle count"
+	},
+	{
+		"EventCode": "0x20",
+		"EventName": "inst_count",
+		"BriefDescription": "Retired instruction count"
+	},
+	{
+		"EventCode": "0x30",
+		"EventName": "int_load_inst",
+		"BriefDescription": "Integer load instruction count"
+	},
+	{
+		"EventCode": "0x40",
+		"EventName": "int_store_inst",
+		"BriefDescription": "Integer store instruction count"
+	},
+	{
+		"EventCode": "0x50",
+		"EventName": "atomic_inst",
+		"BriefDescription": "Atomic instruction count"
+	},
+	{
+		"EventCode": "0x60",
+		"EventName": "sys_inst",
+		"BriefDescription": "System instruction count"
+	},
+	{
+		"EventCode": "0x70",
+		"EventName": "int_compute_inst",
+		"BriefDescription": "Integer computational instruction count"
+	},
+	{
+		"EventCode": "0x80",
+		"EventName": "condition_br",
+		"BriefDescription": "Conditional branch instruction count"
+	},
+	{
+		"EventCode": "0x90",
+		"EventName": "taken_condition_br",
+		"BriefDescription": "Taken conditional branch instruction count"
+	},
+	{
+		"EventCode": "0xA0",
+		"EventName": "jal_inst",
+		"BriefDescription": "JAL instruction count"
+	},
+	{
+		"EventCode": "0xB0",
+		"EventName": "jalr_inst",
+		"BriefDescription": "JALR instruction count"
+	},
+	{
+		"EventCode": "0xC0",
+		"EventName": "ret_inst",
+		"BriefDescription": "Return instruction count"
+	},
+	{
+		"EventCode": "0xD0",
+		"EventName": "control_trans_inst",
+		"BriefDescription": "Control transfer instruction count"
+	},
+	{
+		"EventCode": "0xE0",
+		"EventName": "ex9_inst",
+		"BriefDescription": "EXEC.IT instruction count"
+	},
+	{
+		"EventCode": "0xF0",
+		"EventName": "int_mul_inst",
+		"BriefDescription": "Integer multiplication instruction count"
+	},
+	{
+		"EventCode": "0x100",
+		"EventName": "int_div_rem_inst",
+		"BriefDescription": "Integer division/remainder instruction count"
+	},
+	{
+		"EventCode": "0x110",
+		"EventName": "float_load_inst",
+		"BriefDescription": "Floating-point load instruction count"
+	},
+	{
+		"EventCode": "0x120",
+		"EventName": "float_store_inst",
+		"BriefDescription": "Floating-point store instruction count"
+	},
+	{
+		"EventCode": "0x130",
+		"EventName": "float_add_sub_inst",
+		"BriefDescription": "Floating-point addition/subtraction instruction count"
+	},
+	{
+		"EventCode": "0x140",
+		"EventName": "float_mul_inst",
+		"BriefDescription": "Floating-point multiplication instruction count"
+	},
+	{
+		"EventCode": "0x150",
+		"EventName": "float_fused_muladd_inst",
+		"BriefDescription": "Floating-point fused multiply-add instruction count"
+	},
+	{
+		"EventCode": "0x160",
+		"EventName": "float_div_sqrt_inst",
+		"BriefDescription": "Floating-point division or square-root instruction count"
+	},
+	{
+		"EventCode": "0x170",
+		"EventName": "other_float_inst",
+		"BriefDescription": "Other floating-point instruction count"
+	},
+	{
+		"EventCode": "0x180",
+		"EventName": "int_mul_add_sub_inst",
+		"BriefDescription": "Integer multiplication and add/sub instruction count"
+	},
+	{
+		"EventCode": "0x190",
+		"EventName": "retired_ops",
+		"BriefDescription": "Retired operation count"
+	}
+]
diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json b/tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
new file mode 100644
index 000000000000..c7401b526c77
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
@@ -0,0 +1,57 @@
+[
+	{
+		"EventCode": "0x01",
+		"EventName": "ilm_access",
+		"BriefDescription": "ILM access"
+	},
+	{
+		"EventCode": "0x11",
+		"EventName": "dlm_access",
+		"BriefDescription": "DLM access"
+	},
+	{
+		"EventCode": "0x21",
+		"EventName": "icache_access",
+		"BriefDescription": "ICACHE access"
+	},
+	{
+		"EventCode": "0x31",
+		"EventName": "icache_miss",
+		"BriefDescription": "ICACHE miss"
+	},
+	{
+		"EventCode": "0x41",
+		"EventName": "dcache_access",
+		"BriefDescription": "DCACHE access"
+	},
+	{
+		"EventCode": "0x51",
+		"EventName": "dcache_miss",
+		"BriefDescription": "DCACHE miss"
+	},
+	{
+		"EventCode": "0x61",
+		"EventName": "dcache_load_access",
+		"BriefDescription": "DCACHE load access"
+	},
+	{
+		"EventCode": "0x71",
+		"EventName": "dcache_load_miss",
+		"BriefDescription": "DCACHE load miss"
+	},
+	{
+		"EventCode": "0x81",
+		"EventName": "dcache_store_access",
+		"BriefDescription": "DCACHE store access"
+	},
+	{
+		"EventCode": "0x91",
+		"EventName": "dcache_store_miss",
+		"BriefDescription": "DCACHE store miss"
+	},
+	{
+		"EventCode": "0xA1",
+		"EventName": "dcache_wb",
+		"BriefDescription": "DCACHE writeback"
+	}
+]
diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json b/tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json
new file mode 100644
index 000000000000..a6d378cbaa74
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json
@@ -0,0 +1,77 @@
+[
+	{
+		"EventCode": "0xB1",
+		"EventName": "cycle_wait_icache_fill",
+		"BriefDescription": "Cycles waiting for ICACHE fill data"
+	},
+	{
+		"EventCode": "0xC1",
+		"EventName": "cycle_wait_dcache_fill",
+		"BriefDescription": "Cycles waiting for DCACHE fill data"
+	},
+	{
+		"EventCode": "0xD1",
+		"EventName": "uncached_ifetch_from_bus",
+		"BriefDescription": "Uncached ifetch data access from bus"
+	},
+	{
+		"EventCode": "0xE1",
+		"EventName": "uncached_load_from_bus",
+		"BriefDescription": "Uncached load data access from bus"
+	},
+	{
+		"EventCode": "0xF1",
+		"EventName": "cycle_wait_uncached_ifetch",
+		"BriefDescription": "Cycles waiting for uncached ifetch data from bus"
+	},
+	{
+		"EventCode": "0x101",
+		"EventName": "cycle_wait_uncached_load",
+		"BriefDescription": "Cycles waiting for uncached load data from bus"
+	},
+	{
+		"EventCode": "0x111",
+		"EventName": "main_itlb_access",
+		"BriefDescription": "Main ITLB access"
+	},
+	{
+		"EventCode": "0x121",
+		"EventName": "main_itlb_miss",
+		"BriefDescription": "Main ITLB miss"
+	},
+	{
+		"EventCode": "0x131",
+		"EventName": "main_dtlb_access",
+		"BriefDescription": "Main DTLB access"
+	},
+	{
+		"EventCode": "0x141",
+		"EventName": "main_dtlb_miss",
+		"BriefDescription": "Main DTLB miss"
+	},
+	{
+		"EventCode": "0x151",
+		"EventName": "cycle_wait_itlb_fill",
+		"BriefDescription": "Cycles waiting for Main ITLB fill data"
+	},
+	{
+		"EventCode": "0x161",
+		"EventName": "pipe_stall_cycle_dtlb_miss",
+		"BriefDescription": "Pipeline stall cycles caused by Main DTLB miss"
+	},
+	{
+		"EventCode": "0x02",
+		"EventName": "mispredict_condition_br",
+		"BriefDescription": "Misprediction of conditional branches"
+	},
+	{
+		"EventCode": "0x12",
+		"EventName": "mispredict_take_condition_br",
+		"BriefDescription": "Misprediction of taken conditional branches"
+	},
+	{
+		"EventCode": "0x22",
+		"EventName": "mispredict_target_ret_inst",
+		"BriefDescription": "Misprediction of targets of Return instructions"
+	}
+]
diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index cfc449b19810..3d3a809a5446 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -17,3 +17,4 @@
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
+0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
-- 
2.34.1


