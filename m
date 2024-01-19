Return-Path: <linux-kernel+bounces-30755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D264B8323F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2C61F21CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D002112;
	Fri, 19 Jan 2024 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBy3Bzy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393E1C15
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705636856; cv=none; b=Vuw9AZNzp77FH/R6mQ8qi5XL11pZujP0iac85W9IcfDmpkAFPhhvn9Io1hCP8DE/JZV00B9DbS2m9rQkZn142HcBB/GLpE/GEplYVWP55M6Uz7nixWhL2vRJ7LtEtvqV3/4dc4lqO1bOC+Hv9c6bdLDJkIux+wdMwXXOicgsRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705636856; c=relaxed/simple;
	bh=fkABRRGLW7RKFfCsuZ1YMNSS2p5FF4eBJVlssM9g2SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCXlhvYE22FmuRq2fXnOEUqH6og/fV4/Abndi7BJ+bUWOM1B1PDNb9gwLVJB8TnGEsKKfd6Ad/QhegXDpEi+EUOe3JtmFA/oVkGEtH65vdVgYk+Y/QuX7LaJfQKbwgpk+QgWsJLsLETsbMgWrJZboTK+8Tyv3XbyGJ4WGO8ck5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBy3Bzy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94593C433F1;
	Fri, 19 Jan 2024 04:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705636855;
	bh=fkABRRGLW7RKFfCsuZ1YMNSS2p5FF4eBJVlssM9g2SQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lBy3Bzy9comrKqJeJgeD6XCK+VBjj983C6N/3sdm9lrSA7OacD9A8PzIG38XefnT9
	 QtQMiPkdKNlG5Z4JJkTICAH6EPhIydHrtyJDwJBzMrpyroAkenkVb2Y33AN8is27iw
	 wvatuMMCOgL52dOJTs0bKSYo7AEKvxRrruniMEyimuuNAa+xr8ug97P2pypwfBEcXB
	 GANp5mLwuEyvnNWhZxA2+n4NhrH0ShYQCUXEPoKLUav36Iqa4MVABF8Ku0FQAZ4Smv
	 GHHMl4QZ59PYVTxkpYPseZ/5/RiSO5iVP44f13M8K9a8g88T2RlaXa4qKgk5EccCyo
	 IaGaEKea9b2Ow==
From: alexs@kernel.org
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH] objtool: remove unused parameter
Date: Fri, 19 Jan 2024 12:02:41 +0800
Message-ID: <20240119040241.2925185-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Remove unused file parameter from init_insn_state(), insn from
has_modified_stack_frame().

Signed-off-by: Alex Shi <alexs@kernel.org>
To: linux-kernel@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 548ec3cd7c00..ecc56a5ad174 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -274,8 +274,7 @@ static void init_cfi_state(struct cfi_state *cfi)
 	cfi->drap_offset = -1;
 }
 
-static void init_insn_state(struct objtool_file *file, struct insn_state *state,
-			    struct section *sec)
+static void init_insn_state(struct insn_state *state, struct section *sec)
 {
 	memset(state, 0, sizeof(*state));
 	init_cfi_state(&state->cfi);
@@ -2681,7 +2680,7 @@ static bool is_special_call(struct instruction *insn)
 	return false;
 }
 
-static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
+static bool has_modified_stack_frame(struct insn_state *state)
 {
 	struct cfi_state *cfi = &state->cfi;
 	int i;
@@ -3474,7 +3473,7 @@ static int validate_sibling_call(struct objtool_file *file,
 				 struct instruction *insn,
 				 struct insn_state *state)
 {
-	if (insn_func(insn) && has_modified_stack_frame(insn, state)) {
+	if (insn_func(insn) && has_modified_stack_frame(state)) {
 		WARN_INSN(insn, "sibling call from callable instruction with modified stack frame");
 		return 1;
 	}
@@ -3504,7 +3503,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 		return 1;
 	}
 
-	if (func && has_modified_stack_frame(insn, state)) {
+	if (func && has_modified_stack_frame(state)) {
 		WARN_INSN(insn, "return with modified stack frame");
 		return 1;
 	}
@@ -3814,7 +3813,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	if (!file->hints)
 		return 0;
 
-	init_insn_state(file, &state, sec);
+	init_insn_state(&state, sec);
 
 	if (sec) {
 		sec_for_each_insn(file, sec, insn)
@@ -4221,7 +4220,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 		if (func->type != STT_FUNC)
 			continue;
 
-		init_insn_state(file, &state, sec);
+		init_insn_state(&state, sec);
 		set_func_state(&state.cfi);
 
 		warnings += validate_symbol(file, sec, func, &state);
-- 
2.43.0


