Return-Path: <linux-kernel+bounces-2943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FB5816509
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021C91C22183
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1400524C;
	Mon, 18 Dec 2023 02:48:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13B1FCA;
	Mon, 18 Dec 2023 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp71t1702867627tx88g6ua
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Dec 2023 10:47:04 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: r9wZAFwAeIhsT0p6iQDTCfhqVkKzHRN8P5N/1o9jgGyFAadu1hH7lhKVcGC9B
	BRIl3J4Fwxlm82r903iSnPJ1GkXFoJdG/HNfW240HFXoaAOvDeRfP3+5nd0fAICI6hlx3VH
	dBCzp2YoOLGwzM1FhidQYA0yGdQIcp/gGI/lBYcZsGAEopdOSX89zMJQc94mETZUpVLtS98
	akstqJgMGCRc0CXBk+F+GO9ao7rLmJveUPbNeAQg7zv139vtx4J797/lDVy0Nu5vxaq0y/b
	MoEqsl0AT/A1kOO1IDbxc7Pe2ZkfHcn+I7ELXfAQePl868gli13uxCV0cMZZC6bOkRuW+8T
	UBYyBbNu2HbmnWeW6LoxDqUKehChVRk+S2udVzMzx43es85tyONAcYwRMCUf1tKjHIlBXsZ
	WNZOjZeeqUC8cpsDfWCwnA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 609347166627549979
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: shenghui.qu@shingroup.cn,
	ke.zhao@shingroup.cn,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: "JiaLong.Yang" <jialong.yang@shingroup.cn>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/perf: PVN for HX-C2000 CPU with Power8 Architecture
Date: Mon, 18 Dec 2023 10:47:03 +0800
Message-Id: <20231218024704.962-1-jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

HX-C2000 is a new CPU made by HEXIN Technologies Co., Ltd. And a new
PVN 0x0066 has been applied from the OpenPower Community for this CPU. Here is
a patch to make perf tool run in the CPU.

Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
Link: https://lore.kernel.org/all/20231129075845.57976-1-ke.zhao@shingroup.cn/
---
 tools/perf/pmu-events/arch/powerpc/mapfile.csv | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
index f4908af7ad66..599a588dbeb4 100644
--- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
+++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
@@ -11,8 +11,7 @@
 #
 # Multiple PVRs could map to a single JSON file.
 #
-
-# Power8 entries
 0x004[bcd][[:xdigit:]]{4},1,power8,core
+0x0066[[:xdigit:]]{4},1,power8,core
 0x004e[[:xdigit:]]{4},1,power9,core
 0x0080[[:xdigit:]]{4},1,power10,core
-- 
2.25.1


