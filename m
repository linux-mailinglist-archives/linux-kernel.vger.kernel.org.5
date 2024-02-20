Return-Path: <linux-kernel+bounces-73645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8E085C56E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8A5B23508
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E514E2C4;
	Tue, 20 Feb 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kU2LSl2p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ghp+GXu3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF914C5AB;
	Tue, 20 Feb 2024 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459473; cv=none; b=r8/6P+m0HnP0sxKnK+h2BZn+DGBGPwv9N/ryqvBPdTw+YPZcXQQXtlKrE3PZQPyziMBC34GF33v+kyXB9zYZRyeBQGmQVx4L1bvl9Rc1ZrZgAN1k49gax2iOyxC36NDivW3SS3O7cxR1gk/zk7DpHMBrxOIlb9LvjjWFy1gxrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459473; c=relaxed/simple;
	bh=YlaTgNvGPByvLzFwbPsWzVzBF/o2vLeyAX2wtTMioH4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZjZcFRYgpF5sBanunLVUfYry84DzqycUwFyhQnNoK2cRPWFEjdf2YztF3U2H8gk79Kgc5flcA1zsG1Qsdbo5sCWHcs4BhZuPpgiY/MHWCU+lb2FCxoMINlTOaCivBOtyoKCwGe7QAPP3ZFW2pDTE3TuUK8qcF/zmyEl0knjgiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kU2LSl2p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ghp+GXu3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 20:04:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+PAS7/iXPjIql4qTvsf+2JNdjp8EdmiSMeG4dWW9k0=;
	b=kU2LSl2pVsIohvsK1fGQzh4ZKGyXHRVmoCXJ4l90ReZsgWChsmGRKmppcDOn2WPeH6ulBj
	Wckg/PYy+l+FMDbLEGb9R+M6M8X0+Zw+6InGMTMGZYTcc7mEQtMW2ZIgNPmGEur8k2z5zI
	G5AgN8kKdK27Abdrf0NL92C/dZiN/D8mOSdp3v5jn926yPBB45Vjexgo9QWHbV42SPhx+B
	qYRYkjbN0+MBake4ZR9qVLlQRltXvTuaCPwm1SC0XWvoYpbcV2jIsaPd6UAo3G//tW2ppH
	cnmdtgqgZWxxK2E+QNTft4AhhgRwdOZnv23Tx6oH7fAS5nLVN2SjIs5N2SX5KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+PAS7/iXPjIql4qTvsf+2JNdjp8EdmiSMeG4dWW9k0=;
	b=ghp+GXu3CUsMcI0Ty0l8uB2OB7M5C1XeS0gfmUt9umLz+0fQT8FwasF9/iZ4WPyMsAZevT
	uLwJMWQ99yW0TGDw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] riscv: vdso: Use generic union vdso_data_store
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240220085212.6547-1-anna-maria@linutronix.de>
References: <20240220085212.6547-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170845946887.398.13250110950661481313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     eba755314fa7bcb147193f51a44546697f3888f1
Gitweb:        https://git.kernel.org/tip/eba755314fa7bcb147193f51a44546697f3888f1
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 20 Feb 2024 09:52:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 20:56:00 +01:00

riscv: vdso: Use generic union vdso_data_store

There is already a generic union definition for vdso_data_store in the vdso
datapage header.

Use this definition to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240220085212.6547-1-anna-maria@linutronix.de

---
 arch/riscv/kernel/vdso.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 2cf7621..98315b9 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -30,14 +30,8 @@ enum rv_vdso_map {
 
 #define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
 
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
 
 struct __vdso_info {
 	const char *name;

