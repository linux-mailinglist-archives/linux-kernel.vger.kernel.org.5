Return-Path: <linux-kernel+bounces-71602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E285A7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030B01C229FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B3A3FE4E;
	Mon, 19 Feb 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gyzqlXGu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="98MXiKOK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E43CF53
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357210; cv=none; b=dBJgAUV0ElnsXemL2K4fPZL1NWMZ+0rR2f7NIClOLQyRGxtpHj0LSfjgr4MpNHrV+Z15GXyeae7BkoDtCcSw6ZhJ9gLHJ36leMF7PVcV2RLq5VKr9L09cN79T7tp512L9friHbGQimydz3b7ooQqHAWEhoMx7gry7NeoN1A63d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357210; c=relaxed/simple;
	bh=2fbQDpTO4Tey39i4Yfg4XMK0iSzMhLQFeet5tLx71IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUxsXVGGX//b3Iwc0UzZPtJt76lbyA8/k0KtjQIZBEJ6Dj4FtomgOWbfsMYP/TxGYZ5MkUL6Kgvlww03OAXtSuLhCvfFO64T6ycRS9IRhrzKdOqO/SBor+BpURSpODlXeXI/nvV8jyiLP4P+oafgFyBCpF761HRjbbyf9cEqzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gyzqlXGu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=98MXiKOK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lp+RzcryxMV8zaG1CzKINGmkFkhMVE/l8rdV67gjFt0=;
	b=gyzqlXGuzWp4QMqcPJo5aZYgAIRs0qFNLdXXEiXhtJi65M/ccdsGa8e0KaHDcDA1K2WZIp
	mCUtwyavQxP9ujmzKPuqrsiOJArtP+nA/jresToDIXNc6w5o2Uf8JJuxH+SYemvwp5Ot8O
	OyF7jnQm3LpTgWFv+DUJhmHEg9y0VH3fJXIfT5OYQz36rEXKCw0cUTW4Z+1c6HnBpj5zfK
	6cJgYkqosyTi71L2vSZfrIx/fv51LSXR4H4zdtQLPsIepESzAVkr3e24dl5P5vj8ojFk2Z
	okDzTCfyt8fqBfnlHG+sXtqHgBHruzCX5JCrIC7FYpoJ2xiijxtQExx4OO1J1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lp+RzcryxMV8zaG1CzKINGmkFkhMVE/l8rdV67gjFt0=;
	b=98MXiKOKw1HG+Rcg0+36jc63lJvDkwgBP/Aoa8RFjRKVULn80umgrTa8zsCcVLTWf8rvyt
	Gp/WTg07f+n/0ECw==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev
Subject: [PATCH 08/10] loongarch/vdso: Use generic union vdso_data_store
Date: Mon, 19 Feb 2024 16:39:37 +0100
Message-Id: <20240219153939.75719-9-anna-maria@linutronix.de>
In-Reply-To: <20240219153939.75719-1-anna-maria@linutronix.de>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already a generic union definition for vdso_data_store in vdso
datapage header.

Use this definition to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/kernel/vdso.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 14941e4be66d..90dfccb41c14 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -21,15 +21,13 @@
 #include <asm/vdso.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
+#include <vdso/datapage.h>
 #include <generated/vdso-offsets.h>
 
 extern char vdso_start[], vdso_end[];
 
 /* Kernel-provided data used by the VDSO. */
-static union {
-	u8 page[PAGE_SIZE];
-	struct vdso_data data[CS_BASES];
-} generic_vdso_data __page_aligned_data;
+static union vdso_data_store generic_vdso_data __page_aligned_data;
 
 static union {
 	u8 page[LOONGARCH_VDSO_DATA_SIZE];
-- 
2.39.2


