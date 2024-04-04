Return-Path: <linux-kernel+bounces-131940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A27898DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EBE1F2C88C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FFE13246F;
	Thu,  4 Apr 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="F9+nIWdV"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C0130486;
	Thu,  4 Apr 2024 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254131; cv=none; b=i79QY1gNMfE1rsk8i6s/deUCg6DspfUKwxexJfXG1pWtBa0nIB6r1I0oSyLgZvlin7e03u14MM1R0I7cm/IXNxvdrReDmM/tdStBFak7Vnmke9oWcJtArGU73q22lW/77wqQHnLoTbgB30nVUID20lVdM2AHqJ1qiMU4h3fibW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254131; c=relaxed/simple;
	bh=whxOD+12dLAYPGaIgNLWaUtgIqUiZ0Gq8qWeXfT4t7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hMpuYCEOOETZRS2URpIUCsVwld5XpoRDI9Dy7wstV/PjrDlnCSB4+AriQ7d9hgUkonewStW0m+HBf1dbskEidq6eTsQQovZIfe0uqHdailgjmgqzN1kAXp+wGIF3k9Fo70WA37+A2z/ZWMhgwTBzF8JJ/ikobINz2304i5JXzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=F9+nIWdV; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434GsWuM030547;
	Thu, 4 Apr 2024 11:08:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=2fQHR/QP
	ziiwV0xMwMaSaBgJWBoHDC5/OXUOImeI4Xg=; b=F9+nIWdVDJPdaOn7TE6R5yTl
	RV9Mq4RFyU5MzcUHYdD9DJP7F2uOEIyTOnXHaruSUKZ1XE27Qqc1EuMRsel7faNF
	O5cxbFrvPuh9ZSOZid5Grl7vPZeLr4ix24QlCJraqif50QvULZTlmvroreRD88VR
	pZAjpC5aeRNN9uZXNb8sj4OvX4e7fJeomvMUGXr9doT7mio/NLWEY1VU6oBJFv+s
	ui8YFJcUv39I35I/TPPis+unemyA/V5hsdd1vk1mr2/qe54xxz275A0e/RGl0vEU
	2AgqeC1H0RfwG8fWkwB1pQw57w3+0zyV+roy8BUWeA6YRLysF9vbVgIwwYbpIw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x9em6kk6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 11:08:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 11:07:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 4 Apr 2024 11:07:58 -0700
Received: from POWEREDGE.marvell.com (POWEREDGE.marvell.com [10.28.8.3])
	by maili.marvell.com (Postfix) with ESMTP id 2A8103F7070;
	Thu,  4 Apr 2024 11:07:52 -0700 (PDT)
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
Subject: [PATCH V2 0/2] Fix Coresight instruction synthesis logic 
Date: Thu, 4 Apr 2024 23:37:29 +0530
Message-ID: <20240404180731.7006-1-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TGZ0rNbCBB2i8lZeFidxwG7Xgksor3Ml
X-Proofpoint-GUID: TGZ0rNbCBB2i8lZeFidxwG7Xgksor3Ml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_14,2024-04-04_01,2023-05-22_02

When we use perf to catpure Coresight trace and generate instruction
trace using 'perf script', we get the following output:

# perf record -e cs_etm/@tmc_etr0/ -C 9 taskset -c 9 sleep 1
# perf script --itrace=i1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,addr,symoff,flags,callindent
..
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed54 coresight_timeout+0x28
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed58 coresight_timeout+0x2c
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed5c coresight_timeout+0x30
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed60 coresight_timeout+0x34
 perf  9024/9024  [009]  2690.650470551:      instructions:   jmp                                  0 ffffb305591aed7c coresight_timeout+0x50
 perf  9024/9024  [009]  2690.650470551:      instructions:   jmp                                  0 ffffb305591aed80 coresight_timeout+0x54
 perf  9024/9024  [009]  2690.650470551:      instructions:   jmp                                  0 ffffb305591aed84 coresight_timeout+0x58
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aede4 coresight_timeout+0xb8
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aede8 coresight_timeout+0xbc
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aedec coresight_timeout+0xc0
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aedf0 coresight_timeout+0xc4
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccec ete_sysreg_read+0x0
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccf0 ete_sysreg_read+0x4
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccf4 ete_sysreg_read+0x8
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccf8 ete_sysreg_read+0xc
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccfc ete_sysreg_read+0x10
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bcd00 ete_sysreg_read+0x14

This output has the following issues:
1. Non-branch instructions have mnemonics of branch instructions (Column 6)
2. Branch target address is missing (Column 7)

This patch fixes these issues by changing the logic of instruction syntehsis
for the Coresight trace queues.

Output after applying the patch:
 ...
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed54 coresight_timeout+0x28
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed58 coresight_timeout+0x2c
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed5c coresight_timeout+0x30
 perf  6111/6111  [008]   457.332794461:      instructions:   jmp                   ffffb305591aed7c ffffb305591aed60 coresight_timeout+0x34
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed7c coresight_timeout+0x50
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed80 coresight_timeout+0x54
 perf  6111/6111  [008]   457.332794461:      instructions:   jcc                   ffffb305591aede4 ffffb305591aed84 coresight_timeout+0x58
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591aede4 coresight_timeout+0xb8
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591aede8 coresight_timeout+0xbc
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591aedec coresight_timeout+0xc0
 perf  6111/6111  [008]   457.332794462:      instructions:   call                  ffffb305591bccec ffffb305591aedf0 coresight_timeout+0xc4
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccec ete_sysreg_read+0x0
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccf0 ete_sysreg_read+0x4
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccf4 ete_sysreg_read+0x8
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccf8 ete_sysreg_read+0xc
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccfc ete_sysreg_read+0x10
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bcd00 ete_sysreg_read+0x14

Changes in V2
  - Updated commit message of Patch 1
  - As discussed in the previous version [1], there were differences in instruction
    trace output before and after the patch. The timestamps for the instructions
    were not in sync. Added a patch 2 which fixes this issue.

Changes in V1
  - https://lkml.org/lkml/2023/6/23/912

[1] https://lkml.org/lkml/2023/6/28/506

Tanmay Jagdale (2):
  perf: cs-etm: Fixes in instruction sample synthesis
  perf: cs-etm: Store previous timestamp in packet queue

 tools/perf/util/cs-etm.c | 49 +++++++++++++++++++++++++++++++---------
 tools/perf/util/cs-etm.h |  1 +
 2 files changed, 39 insertions(+), 11 deletions(-)

-- 
2.34.1


