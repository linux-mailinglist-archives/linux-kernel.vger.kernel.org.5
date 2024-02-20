Return-Path: <linux-kernel+bounces-73644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEEA85C56C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8809283CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD114D457;
	Tue, 20 Feb 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U8rhUSaG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o6gbXSOz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740314AD3E;
	Tue, 20 Feb 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459473; cv=none; b=EWG/DP0j8Kkoc5TrOdSA6vvQt4A71Sgc52VRRvA2KTazc5wjalI3zGcHIq3YoyWWzi+bF9JQ63wPyny2FeSW4JbeMC4wdOXSypDkDnzjP0vAW8+nlzDx/uRaeJKBY04v0HJif1xRWgMGuTNwAF/8f8FdMz2C+fDX/bAhfcBThqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459473; c=relaxed/simple;
	bh=2/pP++SEY3kfHt3ju6B5xWEYK2JC2jz/ghGI3gFwxZw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NfeqiI2sHJS7FYQBDckJRw6xSazLx3WapKPaksKaa742Vbg3D1nyXRzwY6TbAmpRAq28PQh9rAGJNd/0yTLEmbvQ58q5OnGG7Wqjmf753JsXXgDK9yG3iQ7PzvcRJsXAsAZ2IV1io6N+wOonkR4OXlBrdKu2amoQQj3Rx9Ukixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U8rhUSaG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o6gbXSOz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 20:04:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sX5vxbZzENHj474/hG9iZDRw8Ls/xH+loSQrYzFxXrI=;
	b=U8rhUSaGOPZd39hn0oCTiZ06p51fxWlLFeSbbt8EszDH3er2Au5gio9tuVyr9H/HwqltJo
	bZWzGlHKO/0S3MXLIJtYGqSQU/nz527Ysqrd9hDNyXje62aLj048E/CqeOUTXdJ+vuLG2w
	ATlJmNWi2xfEi1Tr2k+0vAMPCGG0nKVXpmddVNTP00V+uNbzPWBb8C9MAkDtpruVN81UtC
	1A/2q5CZuPAI5DpBOMeKC3s5oLEIB4bBTsX64cN9BA8dTE7WOWuyNI6+jxl7LTYYGQIiN7
	TXFBukj6fRFIbegIu09FyjyfCWl7NgESd/JoAwHfejmkYFg1gGwlzwGernj4/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sX5vxbZzENHj474/hG9iZDRw8Ls/xH+loSQrYzFxXrI=;
	b=o6gbXSOzpSU1ZP0n0dcJGZMTdAvW6Qx8eXxaxV7zofTmX7ocg1tl2nonCqjE51Dc/Bv+3e
	rV21+iSJDemQHJAQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] s390/vdso: Use generic union vdso_data_store
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>, Heiko Carstens <hca@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240219153939.75719-8-anna-maria@linutronix.de>
References: <20240219153939.75719-8-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170845946787.398.14130505985159382816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cb3444cfdb48b7ee7d208d19c97a29dd8252d884
Gitweb:        https://git.kernel.org/tip/cb3444cfdb48b7ee7d208d19c97a29dd8252d884
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 Feb 2024 16:39:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 20:56:00 +01:00

s390/vdso: Use generic union vdso_data_store

There is already a generic union definition for vdso_data_store in the vdso
datapage header.

Use this definition to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20240219153939.75719-8-anna-maria@linutronix.de

---
 arch/s390/kernel/vdso.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index bbaefd8..a45b3a4 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -25,10 +25,7 @@ extern char vdso32_start[], vdso32_end[];
 
 static struct vm_special_mapping vvar_mapping;
 
-static union {
-	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
+static union vdso_data_store vdso_data_store __page_aligned_data;
 
 struct vdso_data *vdso_data = vdso_data_store.data;
 

