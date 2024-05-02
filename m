Return-Path: <linux-kernel+bounces-166365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14428B9990
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D31C21499
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F5284039;
	Thu,  2 May 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkX4COHK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94470612EB;
	Thu,  2 May 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647592; cv=none; b=f3h6GtI9g3/nEw+X+OxagtzgY1sHr79ohOm3CTPOugCnpul5ilPlTXcp+KBVjDD8ovg0lc28YgHB4ZPxTd313BlJH1U76sPQQruiEywfjKwGrbB/rDrViRq6MzJGk5mBD6efmVQsnLMDHaJpMtgK91zvxdnQwo1Uz9Y5UDurl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647592; c=relaxed/simple;
	bh=XXIsWHXWWwlLgroCpLva4Kxg4vgU/j/a3IMMNVMdzmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQduEegBZTQPmezRua6FBcF3hM8VX3Z4VPapVFOhXGvC62fyoT4C8AcIoaqNY6YgxYm46BOUPh7WOZvkJ7mui8eKxIfeCGKzii2+0z0lAj+QJZ36oyK6RswWXqE7cCZPFSqArZ2SNOEp7M6wxWyCA9FI4hDOTgq3BmztTfkY3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkX4COHK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714647588; x=1746183588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XXIsWHXWWwlLgroCpLva4Kxg4vgU/j/a3IMMNVMdzmk=;
  b=gkX4COHKUAWVWRVdCDz7DtkzpaTJh+Bt4LRpDM9zM9s4XwtuyERSEyjO
   crTItfBbHCyeobmVGcRJSdlFZVq/F3ZTLhMqMJ5RNA0YzeFtQ1ZzCBqiS
   NVgA4MHp/gM8m9NuKZw5cY/ZnOSRxqNmxPNvXwz/Bz2f0iL5EpaoFwhPn
   mrYYxQChuJPSQzpRRSH08sgK6qadeRFAhjaSqhFeRK4H8YR6HeVBmllnI
   Z8R07KJoaPvm44XlZKEFVvR2bFxr9CQFDajimRr3phW26ckB/hKrnkIWR
   aMDESdNGaDBLy68Ax5i2cZvSE+J+zvMtbdoR7afcxsrbUiA8W6gIrYNEb
   g==;
X-CSE-ConnectionGUID: QAcB0Q87TY+kBps/2ReO1g==
X-CSE-MsgGUID: J7u0oxkZSs+xqsJp2/a0pA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14228686"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14228686"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:48 -0700
X-CSE-ConnectionGUID: qodtdz0LRS6Xf6M6AWiYTw==
X-CSE-MsgGUID: clNg57qqQDe6gr4Z+53i7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50279004"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.210])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:44 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 09/10] perf intel pt: Add new JMPABS instruction to the Intel PT instruction decoder
Date: Thu,  2 May 2024 13:58:52 +0300
Message-Id: <20240502105853.5338-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502105853.5338-1-adrian.hunter@intel.com>
References: <20240502105853.5338-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

JMPABS is 64-bit absolute direct jump instruction, encoded with a mandatory
REX2 prefix. JMPABS is designed to be used in the procedure linkage table
(PLT) to replace indirect jumps, because it has better performance. In that
case the jump target will be amended at run time. To enable Intel PT to
follow the code, a TIP packet is always emitted when JMPABS is traced under
Intel PT.

Refer to the Intel Advanced Performance Extensions (Intel APX) Architecture
Specification for details.

Decode JMPABS as an indirect jump, because it has an associated TIP packet
the same as an indirect jump and the control flow should follow the TIP
packet payload, and not assume it is the same as the on-file object code
JMPABS target address.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index c5d57027ec23..4407130d91f8 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -92,6 +92,15 @@ static void intel_pt_insn_decoder(struct insn *insn,
 		op = INTEL_PT_OP_JCC;
 		branch = INTEL_PT_BR_CONDITIONAL;
 		break;
+	case 0xa1:
+		if (insn_is_rex2(insn)) { /* jmpabs */
+			intel_pt_insn->op = INTEL_PT_OP_JMP;
+			/* jmpabs causes a TIP packet like an indirect branch */
+			intel_pt_insn->branch = INTEL_PT_BR_INDIRECT;
+			intel_pt_insn->length = insn->length;
+			return;
+		}
+		break;
 	case 0xc2: /* near ret */
 	case 0xc3: /* near ret */
 	case 0xca: /* far ret */
-- 
2.34.1


