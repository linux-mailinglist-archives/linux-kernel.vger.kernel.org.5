Return-Path: <linux-kernel+bounces-120280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF8288D543
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620F5B21F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC1241E1;
	Wed, 27 Mar 2024 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adddd1rL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9723748
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511863; cv=none; b=Su6avHnBbTU9w7akB3rUaPiNB5XbHUMP8k/15Yd206bjD0i4dclqAkk3Sy9u7rqqvLLEtqRXLnEdgLOlJVwm3EB3wSSKD1WFG8mijymYEXRSpj7vOc7qtw3lUD7orrG5FanJLt/uHsK5+d9bj1d6DfapojVT5TlcWTqyeDEV3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511863; c=relaxed/simple;
	bh=hFyZI6JIOVqAKDWWNwsqHoUwPVj8nbkInCOWf9ACfHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouc4vwsVBfdP1NfgxLBA0GBmoPf/HAkXquKZPAD9FHU/plDKeyuXQAXwJzRkMqzeVm0lgsZfNnWTc9fi77iBHjzGE20Ioa6V7A8/Vg0+vI1hdTMgUFr2L6qoIV54feid20r0wnrMFZr+mehpL1GSYr8pHGE7RAcZrgav1b71xcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Adddd1rL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BB4C433C7;
	Wed, 27 Mar 2024 03:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711511863;
	bh=hFyZI6JIOVqAKDWWNwsqHoUwPVj8nbkInCOWf9ACfHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Adddd1rL98guyiZFj5FfObOrFOobEIRw6q4ipEBoapNyoe/xKQ0WdShxIXzZARJA+
	 SkQPX3SZkjxwRahusbq70SGVkRFrJsjE0vR3djmHzsdI+/Bymr33Dnf0ES8JjW2eHx
	 yrWCdkOf2401DsX797QLPKP6tdmKjyN1OJ7aq6hetU4Im+Nhw5ewV97FC/FLqiG4ec
	 fIeT3vAF1Y9ExtrbrZHt7XM42pGY1Z7lbNnQonRVSC+RuGzkD5pRbJZfObQR66AOA7
	 QkZAwWzmCqRmqQYKs2E4wxKI2aKnoao0evoqgIq6yByEpKIJA4g24JqZ1LV4eG97zV
	 P6PAqF+KG5PeQ==
From: alexs@kernel.org
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org (open list)
Cc: linux-kernel@vger.kernel.org,
	"Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH v2 2/2] objtool: remove unused parameter for has_modified_stack_frame
Date: Wed, 27 Mar 2024 12:00:47 +0800
Message-ID: <20240327040047.478695-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327040047.478695-1-alexs@kernel.org>
References: <20240327040047.478695-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Remove unused 'truct instruction *insn' to save a bit code text.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 88ac3e2be2bd..ecc56a5ad174 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2680,7 +2680,7 @@ static bool is_special_call(struct instruction *insn)
 	return false;
 }
 
-static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
+static bool has_modified_stack_frame(struct insn_state *state)
 {
 	struct cfi_state *cfi = &state->cfi;
 	int i;
@@ -3473,7 +3473,7 @@ static int validate_sibling_call(struct objtool_file *file,
 				 struct instruction *insn,
 				 struct insn_state *state)
 {
-	if (insn_func(insn) && has_modified_stack_frame(insn, state)) {
+	if (insn_func(insn) && has_modified_stack_frame(state)) {
 		WARN_INSN(insn, "sibling call from callable instruction with modified stack frame");
 		return 1;
 	}
@@ -3503,7 +3503,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 		return 1;
 	}
 
-	if (func && has_modified_stack_frame(insn, state)) {
+	if (func && has_modified_stack_frame(state)) {
 		WARN_INSN(insn, "return with modified stack frame");
 		return 1;
 	}
-- 
2.43.0


