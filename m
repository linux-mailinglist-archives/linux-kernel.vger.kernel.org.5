Return-Path: <linux-kernel+bounces-131943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A4D898DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8AF1C23F00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26079131190;
	Thu,  4 Apr 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="H0q2WnWP"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898A130E29;
	Thu,  4 Apr 2024 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254152; cv=none; b=RcrONEnGY/XWxsgO/TXCKlUpszQ3LgMD3XSoCoLcfIc4VE5qvv/f8ClxjowbiMDajbJMGSPbcc3Z2kgp/oOVsmu1F8aNXP7az3nih701LUAdxc1Tz9Ji0p6u91CokHlB+Y8//oU32FsAbRsxFaIR01xfdJzT69wghebLXycw3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254152; c=relaxed/simple;
	bh=pWFQHjM3/+OKNhDQgasSXJxBtb6A1jSQo+N0wVVi9Lk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUmz3GGnVILQU59Kysn40FSxkT8bt5TPwkPzZtci0BluunYjJjPmdduFUJqarZyH1v2JXUTOjupLhZjrYUozT+FcTcT6du2M9hGwkuWBTlkdnpVn3dqqzn9LJGsqSW1TXM3U9i2o8u7e5xvTAE25ld72nyqzXZUfPLGP0maDynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=H0q2WnWP; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434BUfLl025075;
	Thu, 4 Apr 2024 11:08:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=TOabRFtQG8zLH9kv0ddXFT6E7a8XzuYFGYp40QV1b3E=; b=H0q
	2WnWPB1tevJBBy4zjWgBujooBpMVStc4BYKzQe8MBd6NE72NqgsuM1XCHoFhDmDo
	DwgfSpjwRKXnTucls4GJIkJvT2k5WqzOKy1WB7a0Q2MTqxsYnFBleGi+dco8GDSO
	uxs3aLW85RiZzxQlVqR7vUjrpVQzEj/+EpRtsQXZcvtS+wuJfbqgLhkJa1TBuGEZ
	ZtztImiAAgsgRb/caYfr9ufXIjhsRSOYWj7ELUGmbPvq2sestNPhQEym0olGOv1H
	jmYwy0nGwwoIodnTNhmjPx8JK8Hk7zXxSntgAT4KXS7KsFjYK7vWmNAC1ksTp+AN
	Wp54613exdT1Jq2sOQA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x9em4kkpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 11:08:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 11:08:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 4 Apr 2024 11:08:34 -0700
Received: from POWEREDGE.marvell.com (POWEREDGE.marvell.com [10.28.8.3])
	by maili.marvell.com (Postfix) with ESMTP id 6A0C93F7070;
	Thu,  4 Apr 2024 11:08:29 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <john.g.garry@oracle.com>, <will@kernel.org>, <james.clark@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linux.dev>, <suzuki.poulose@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>, <lcherian@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH V2 1/2] perf: cs-etm: Fixes in instruction sample synthesis
Date: Thu, 4 Apr 2024 23:37:30 +0530
Message-ID: <20240404180731.7006-2-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404180731.7006-1-tanmay@marvell.com>
References: <20240404180731.7006-1-tanmay@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0jO92t8Yx8LSQamazqhXnznhbrOg62Xt
X-Proofpoint-GUID: 0jO92t8Yx8LSQamazqhXnznhbrOg62Xt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_14,2024-04-04_01,2023-05-22_02

The existing method of synthesizing instruction samples has the
following issues:
1. Branch target address is missing.
2. Non-branch instructions have mnemonics of branch instructions.

To fix issue 1), start synthesizing the instructions from the
previous packet (tidq->prev_packet) instead of current packet
(tidq->packet). This way, it is easy to figure out the target
address of the branch instruction in tidq->prev_packet which
is the current packet's (tidq->packet) first executed instruction.

After the switch to processing the previous packet first, we no
longer need to swap the packets during cs_etm__flush()

Fix for issue 2) is to set the sample flags only when we reach the
last instruction in the tidq (which would be a branch instruction).

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
 tools/perf/util/cs-etm.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d65d7485886c..55db1932f785 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1493,10 +1493,26 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
 	sample.cpu = tidq->packet->cpu;
-	sample.flags = tidq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
-	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
+	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet, &sample);
+
+	/* Populate branch target information only when we encounter
+	 * branch instruction, which is at the end of tidq->prev_packet.
+	 */
+	if (addr == (tidq->prev_packet->end_addr - 4)) {
+		/* Update the perf_sample flags using the prev_packet
+		 * since that is the queue we are synthesizing.
+		 */
+		sample.flags = tidq->prev_packet->flags;
+
+		/* The last instruction of the previous queue would be a
+		 * branch operation. Get the target of that branch by looking
+		 * into the first executed instruction of the current packet
+		 * queue.
+		 */
+		sample.addr = cs_etm__first_executed_instr(tidq->packet);
+	}
 
 	if (etm->synth_opts.last_branch)
 		sample.branch_stack = tidq->last_branch;
@@ -1717,7 +1733,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	/* Get instructions remainder from previous packet */
 	instrs_prev = tidq->period_instructions;
 
-	tidq->period_instructions += tidq->packet->instr_count;
+	tidq->period_instructions += tidq->prev_packet->instr_count;
 
 	/*
 	 * Record a branch when the last instruction in
@@ -1797,8 +1813,11 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 			 * been executed, but PC has not advanced to next
 			 * instruction)
 			 */
+			/* Get address from prev_packet since we are synthesizing
+			 * that in cs_etm__synth_instruction_sample()
+			 */
 			addr = cs_etm__instr_addr(etmq, trace_chan_id,
-						  tidq->packet, offset - 1);
+						  tidq->prev_packet, offset - 1);
 			ret = cs_etm__synth_instruction_sample(
 				etmq, tidq, addr,
 				etm->instructions_sample_period);
@@ -1862,7 +1881,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 
 	/* Handle start tracing packet */
 	if (tidq->prev_packet->sample_type == CS_ETM_EMPTY)
-		goto swap_packet;
+		goto reset_last_br;
 
 	if (etmq->etm->synth_opts.last_branch &&
 	    etmq->etm->synth_opts.instructions &&
@@ -1898,8 +1917,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 			return err;
 	}
 
-swap_packet:
-	cs_etm__packet_swap(etm, tidq);
+reset_last_br:
 
 	/* Reset last branches after flush the trace */
 	if (etm->synth_opts.last_branch)
-- 
2.34.1


