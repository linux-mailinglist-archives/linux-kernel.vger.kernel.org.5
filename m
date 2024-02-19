Return-Path: <linux-kernel+bounces-71605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6F85A7A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD034B252BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76F4123F;
	Mon, 19 Feb 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3/UM9dNj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VArxm8BU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427373D3A3;
	Mon, 19 Feb 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357210; cv=none; b=QdfDf5lkHCkDJFUMEWiVLb8JqTDvtRiI/5rcbzJBJaixpT8baWnADyJnPv35fJVbNNISps8TMHLy+vUapSgz7dyWtMYLAyuxYrQxRJa+u4tnXA+fZaaHcBpkdD1QASOzwOvDwyE/w2RP4ja9norn2JVE079+Mg8y+t8SFsQgrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357210; c=relaxed/simple;
	bh=pWCDQWj1ZGKNeKtUkk10UnRUvitx2JkEKKGeUE/9QBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cC8q10TjcEKf2kZ3AoMYqZLuUKALtclYc5jd8BASC/W7UTlwFCNBayRVX1sEvTLyBU9Dqg75sSMPCHO6KVVngNTEbo6exN+5umzEdBfrE7BUpCkvCsBSN9ogeBKuWLZEJa6PNahuNmm2joj7Zj+VzYX/vy4IWq0kJLl10qgvWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3/UM9dNj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VArxm8BU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTsHPIZ0ef28j3t4F2fpsa7oGTHGH9ta8CIKVXueM1c=;
	b=3/UM9dNj5/TaM9bUdHKQcc4OKv7ja6XkGFpf2YFpvEfr1XpudXG74nes6wwth2aXCf1p90
	smHhAMqlq1RbZPkaEbFDJ36ydOS4dPPK829KHE8BmozcwkUTy3NNbZwPNSjQTLzdmI70cp
	zb1c/KBdeU05g6/PbpA4DXGttlh1rsOJEQ7Ei+R9wAE1li79sPX4vv5cgThYHA/yfw2rYV
	d1GO4k49vPKz8zgFsUL7fDKAdIINIqOGFTlZoXocRXZoV8kLquPvC3i5MAa4R4WXUJBJoN
	5r6otuTsNVx2fnEULa4TUb+TioXDf/0Tem8ESW8NoOMbwokvxoOU5KH+J1CRLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTsHPIZ0ef28j3t4F2fpsa7oGTHGH9ta8CIKVXueM1c=;
	b=VArxm8BUHFw/wNcOu6uyuCQuJOxxlgvOQN8+8bFiy7NcVxaY2v32b5mFu0FfhaSRY1AnBf
	EPQp4M6V5QF/AvBg==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org
Subject: [PATCH 10/10] csky/vdso: Use generic union vdso_data_store
Date: Mon, 19 Feb 2024 16:39:39 +0100
Message-Id: <20240219153939.75719-11-anna-maria@linutronix.de>
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
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/kernel/vdso.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index e74a2504d331..2ca886e4a458 100644
--- a/arch/csky/kernel/vdso.c
+++ b/arch/csky/kernel/vdso.c
@@ -15,14 +15,8 @@ extern char vdso_start[], vdso_end[];
 static unsigned int vdso_pages;
 static struct page **vdso_pagelist;
 
-/*
- * The vDSO data page.
- */
-static union {
-	struct vdso_data	data;
-	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = &vdso_data_store.data;
+static union vdso_data_store vdso_data_store __page_aligned_data;
+struct vdso_data *vdso_data = vdso_data_store.data;
 
 static int __init vdso_init(void)
 {
-- 
2.39.2


