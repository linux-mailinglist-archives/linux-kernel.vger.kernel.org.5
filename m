Return-Path: <linux-kernel+bounces-6436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A60228198CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F6D1F26364
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8437A13ACD;
	Wed, 20 Dec 2023 06:49:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A97125DA;
	Wed, 20 Dec 2023 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp80t1703054733t6c8lpb8
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Dec 2023 14:45:31 +0800 (CST)
X-QQ-SSF: A1400000000000B0B000000A0000000
X-QQ-FEAT: 4g9JbZ7lBbHk//+iFLQFeZT7naV0p2I3/OTu2SuW+MEM2i23F4cj5uzQ6v9NH
	ONfSW+jaJuU/YsDFttbpPfosiGMkuHDbhGRH77alkM6iRj5390UDG/tNlhN5JC9fEQ5a18h
	bhrHc34X6RKFmagfpyMKH5sY3NG/lqVu/6+c5hNuDU/EfpGk+00gIZ7nfMGt4SYtBr7DpgC
	kS4IiR7b1KEnSpHRtoBvN7YXFxxr9R+PqLU8h2BDS6nVfvdt4I8+mfE4CjlvBdlmMP3MRG0
	wLuS/i18dspWhnu7byy6DIJqFMUZ/bTIcgxRihlAKBc4zNl9zcirZslWA2ZZia64b3/Y/pb
	9lo8gkrwRXPDBUKxnwq19QVhfU0h9tc5whuNGmnPqXiFk6ZDlPx0bqevlOakZIUgZ4kcEaF
	x/yAXMtJA0V5PzXNtKOM1w==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4118759023636609196
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: 2738078698@qq.com,
	"JiaLong.Yang" <jialong.yang@shingroup.cn>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/perf: PVN for HX-C2000 CPU with Power8 Architecture
Date: Wed, 20 Dec 2023 14:45:17 +0800
Message-Id: <20231220064518.16285-1-jialong.yang@shingroup.cn>
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


