Return-Path: <linux-kernel+bounces-51410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A27848AEA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066F3B24192
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308AB17E9;
	Sun,  4 Feb 2024 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="VuBoUPpO"
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0AC1C0F;
	Sun,  4 Feb 2024 03:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707018342; cv=none; b=qZASpeTjiL+KoWq6GDh2GPM4Ozf0z9l7MFB7PgBcNZaRk4kAvflsUOZl+55ChfAZkPn00BFl614cblKDkTxh2qya6+AvprymPwQdofEnMfn0U5WtTx81B+T0PEZbn4j9zXMSbZvEWp62k7ZjoAuVql/TNNOw7NSHC3Oous6y1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707018342; c=relaxed/simple;
	bh=bp3+moavKJUOU9+YcZZ62WFzPtg6yWFvn6eFkIqmXdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0sT6s/vcudNnYZ6w7G6KnV5QYlLfnByTd0Nd2pHIkViYQ4NV0NYpeKX++vuE2+xGnrIRwrio3lIqZFK+6Y8C3YMlqKcJOZ+TFEyPf88JEQSyr1h2TFgMiNwrd0zcpgwh4YRv0Wj7Oz8bCZNmNy5to/O7dGX96tDw3DkE+cyISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=VuBoUPpO; arc=none smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166257.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41432XDK027752;
	Sun, 4 Feb 2024 03:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=campusrelays; bh=ed8waYid509TfcIsLqBzgp/9YodzRQmW/h6oOEGt1rk=;
 b=VuBoUPpOtJ3EOrtirkhidspd7kjf8Yb3fLEPLU/54q1tfk38gQUZq46pdEbnzAq3Xnhe
 YlfjixALde/JlgA0Q2CGDSVXmGUPnjr9yyussiP5mj/QtyHoS77Y4+JY0NnERnSr5XUZ
 scFC7otRSHgpHuAKib6R0it9d2qCPGPqt26D2IsEBl8gngHcvA53lSum4CjW/ym2NA2j
 Pv5y3ctpPK59qoQKT7wryF4aYBpEOUMWqDPJnPesQQmU0DI31vmzEDOkV4O2cTLG1myk
 SKjVB9ZVpvmncPmiVbs+jfZ69Ml2Ts/7OZuiHt+b7Ow1w8jdBb3F8+8ZvVvM7WgT1Sxl pA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 3w1e8n4ktp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Feb 2024 03:13:04 +0000
Received: from m0166257.ppops.net (m0166257.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4143D4Fu010150;
	Sun, 4 Feb 2024 03:13:04 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0a-00007101.pphosted.com (PPS) with ESMTP id 3w1e8n4ktm-1;
	Sun, 04 Feb 2024 03:13:03 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Xin Li <xin@zytor.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinghao Jia <jinghao7@illinois.edu>
Subject: [PATCH v2 0/3] x86/kprobes: add exception opcode detector and boost more opcodes
Date: Sat,  3 Feb 2024 21:12:57 -0600
Message-ID: <20240204031300.830475-1-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mn5VSJ0mvjV8e4iC5xZSg_c-bVZsA20H
X-Proofpoint-ORIG-GUID: 904boGWkVLvojL-KnoPb6Eo3_D3d1Dp0
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402040022
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Hi everyone,

This patch set makes the following 3 changes:

- It refactors the can_probe and can_boost function to make them return
  bool instead of int. Both functions are just using int as bool so let's
  make them return a real boolean value.

- It adds an exception opcode detector to prevent kprobing on INTs and UDs.
  These opcodes serves special purposes in the kernel and kprobing them
  will also cause the stack trace to be polluted by the copy buffer
  address. This is suggested by Masami.

- At the same time, this patch set also boosts more opcodes from the group
  2/3/4/5. The newly boosted opcodes are all arithmetic instructions with
  semantics that are easy to reason about, and therefore, they are able to
  be boosted and executed out-of-line. These instructions were not boosted
  previously because they use opcode extensions that are not handled by the
  kernel. But now with the instruction decoder they can be easily handled.
  Boosting (and further jump optimizing) these instructions leads to a 10x
  performance gain for a single probe on QEMU.

Changelog:
---
v1 -> v2
v1: https://lore.kernel.org/linux-trace-kernel/20240127044124.57594-1-jinghao7@illinois.edu/

- Address feedback from Xin:
  - Change return type of is_exception_insn from int to bool.

- Address feedback from Masami:
  - Improve code style in is_exception_insn.
  - Move instruction boundary check of the target address (addr == paddr)
    right after the decoding loop to avoid decoding if the target address
    is not a valid instruction boundary.
  - Document instruction encoding differences between AMD and Intel for
    instruction group 2 and 3 in can_boost.

- Add an extra patch to change the return type of can_probe and can_boost
  from int to bool based on v1 discussion.

- Improve code comments in general.

Jinghao Jia (3):
  x86/kprobes: Refactor can_{probe,boost} return type to bool
  x86/kprobes: Prohibit kprobing on INT and UD
  x86/kprobes: Boost more instructions from grp2/3/4/5

 arch/x86/kernel/kprobes/common.h |  2 +-
 arch/x86/kernel/kprobes/core.c   | 98 ++++++++++++++++++++++----------
 2 files changed, 69 insertions(+), 31 deletions(-)

--
2.43.0


