Return-Path: <linux-kernel+bounces-7879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5D381AE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E901F24B03
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9930EB64A;
	Thu, 21 Dec 2023 06:05:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544DBA29;
	Thu, 21 Dec 2023 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp89t1703138658te87spac
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Dec 2023 14:04:16 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: J5JfekO1Wsjz5NyORLhPTRxZaCE3ofmeLpw7waOCn0XanAKdVpbp6hjumU7+6
	9tm+uoKbGjbWvocQsCJQqDgCb6NdSwtUoXMRpF0EUIhsTAekCAhL43wbcyg11T6OLZFBJWy
	7LFfKCTEAFaCKUdAxRVtF8Rg3D00GuLvJvCbFeG1pQTebdrOBp3RRKEUibkaMx1JtQaMGhI
	L5kNuPOoBudZBpYBfWj7mXMQN+dYU77jMzQjTn5rSRyTG1jrGEdDq9hQODtoX1v/oRauH5L
	8DWsXqbDttDtBfccK3cGTpqKd36Mag8FRuqGWA+J3cQXBNcNB9rtJKX9Qi3fxCE3QYuub9B
	c4O8w/eGUdq/ZIrtVbstgRJ9OSnEtx8qggpf5zB7FxrplQVnAyI/pgwd4oskx4QuAiz99w/
	FcaZnt1NLoeDIQvLrrB4fQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4835634459533132483
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
Cc: shenghui.qu@shingroup.cn,
	ke.zhao@shingroup.cn,
	zhijie.ren@shingroup.cn,
	"JiaLong.Yang" <jialong.yang@shingroup.cn>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V0 RESEND] tools/perf: Add PVN for HX-C2000 CPU with Power8 Architecture
Date: Thu, 21 Dec 2023 14:02:41 +0800
Message-Id: <20231221060242.4532-1-jialong.yang@shingroup.cn>
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
---
Here tells detail info.
Link: https://lore.kernel.org/all/20231129075845.57976-1-ke.zhao@shingroup.cn/

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


