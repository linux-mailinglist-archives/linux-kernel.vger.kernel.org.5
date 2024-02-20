Return-Path: <linux-kernel+bounces-72609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D9785B60E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117A1B2395E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CD85F465;
	Tue, 20 Feb 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IzLVuyGZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVZVDs3D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE2627F3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419149; cv=none; b=oloceh/FUk8CK9jeUklkeFpqlc0m3hzlT6HF4mFJBh8K4/ZLbwPgoPeME+uhrwDVpU5QjTcADumS3WBGv6esB3R4gvKgNt1yddGQx7WlWdy5L82ewJJJFWLC6cdAgMskubeHcT3ZmRbrc+Ck/OICeKtRE+cJLOnGp7t/dYFXmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419149; c=relaxed/simple;
	bh=/G+9zo4wU1/IoJJgwk4k1gXyHPeaOE6m1As2PizN0ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAZ4ECUVJVM93+K2OrJWOlqcduMUDnUmBpMF9fqeRq3ITZnnJQexRk1ebJytUCT1BCrbXfFZRKyHSz7ADE32EDtwHIfoSutcfYTO1FJBcK3MVf8IVxvWIkH6pLKx9Rpa+Vzj2IBx4iPmHO05XS12Umxo4g3vbUJkLl8w1Mejftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IzLVuyGZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVZVDs3D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708419145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRJ6q+w6PWpmy1zIT6leu3Z5s7/O2Fle24NL27shHS0=;
	b=IzLVuyGZR+3MMByVPrc0qDiSJ9LPePvFUId3+fMVczmxkwoJC4Pmp+HxhnHe1mjMRA9d16
	MK3rauiN6/y7dLiS4a8tWIpdn+s+PdOV2Ao/fbM352GUtnqxCzqdPVnzhKvottAgfS5Jpv
	+sVfL/oXqHzQkv+f+1mnDG+xkngje+BkLgKfpvO2KJGeLSwOTwSgRD9do8Lu6YBTGA7bNz
	7TRo+XRf3wcD4WhKQIf4sI/b/Z+0DsqQmEzwb96PoxiemIppwqIz1eMik2LYgNEJAVWx8y
	T2BZHto4opPMZ4UVNm50BDN2J0jDMcHXKfpdsD78k8OpbUshVZjlCVBC2+5Iuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708419145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRJ6q+w6PWpmy1zIT6leu3Z5s7/O2Fle24NL27shHS0=;
	b=gVZVDs3DqBXIydK1NNlQDSB1Z0oouZ4f/SeqnfAykhrMEH+KNNVdoATlwV+T6JYu6LBfba
	XCebOD4yIVZGWOAw==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v1a] riscv/vdso: Use generic union vdso_data_store
Date: Tue, 20 Feb 2024 09:52:12 +0100
Message-Id: <20240220085212.6547-1-anna-maria@linutronix.de>
In-Reply-To: <20240219153939.75719-7-anna-maria@linutronix.de>
References: <20240219153939.75719-7-anna-maria@linutronix.de>
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
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/kernel/vdso.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 2cf76218a5bd..98315b98256d 100644
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
-- 
2.39.2


