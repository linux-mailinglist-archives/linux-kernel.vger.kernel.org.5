Return-Path: <linux-kernel+bounces-71601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BAA85A7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B137C284D81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03093FB21;
	Mon, 19 Feb 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e8ck0Fru";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OUpLh70/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7343C49C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357210; cv=none; b=HHfNONNeIFKtRSstN7pOYO4FVqdCcX8avaIZHTZZ0L0ax5MBkZdg7MokCB1EJwvV6B3N+8r9GUEiKK7CMf/G8o8H0HQ+G1yw3FGnVy4jxDyn3F/66c/ZXHe/tyKNs1x4FEA998VA8M8g9hYoJgkWrHuq6KD5snKg6N61q+0zDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357210; c=relaxed/simple;
	bh=uwGKUudqINu/l2LS4UDnc84Sy7bVMtcbCFymgjZtMeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fKj6gQQq0AyMv2Jc17r2iresi6F7MBpd4xH62iFbVN4TIyoqcGbJrMZkWhKVKfqY9MLrWvoN7lW7chR/zp8YNcSgNAOrRro4TjRXWsVrQnBb8A9iX3MhjKUBer/061jPZDYeTJ3BX6t2NTNLWHGmOhHzI/EjvqHa6FqMrYpC2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e8ck0Fru; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OUpLh70/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSJH2Cy3AOqZmgikXh7qng6szl5HlWuz3PgXeKPeks4=;
	b=e8ck0FruzZ8Ag+/b5iHDLfIUxz9zmagc1f5rEiyK5hbbzj/S1I6gnFAFXaVxyBtsMkqHzF
	r3sco+vWtbdQfXMs/jAETq3/y9aizlcKB6nlpxeqssBVvNsHtpfgiak0jRhNchDVoGjYKq
	RZPEA3ub6REw1ibtUcbODrfwKIIwHzy60GRhDTtZ0y3wAORbzXwiK2V4vJ3zVWTB+L9Ky5
	3ZV9koyLq5KoU80y9k6mp+yeksnv1k5N8zMCi65KDKTGZ+G0Y5ATW8+/nHgR91kIoE43T1
	GIvca5Ues2wsqmpjhDoIhNEMY5vX7qfxmb3U9m4wISnoEoWZyJSTVNr2dPeqsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSJH2Cy3AOqZmgikXh7qng6szl5HlWuz3PgXeKPeks4=;
	b=OUpLh70/kjYmndXYQ+Zlava3G4i+VeFfT1Xxc2MZrt7OW5qubKGDDj7Q3tgRl3hGOuaL6g
	Nbk18oNRr5ZzodBA==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 06/10] riscv/vdso: Use generic union vdso_data_store
Date: Mon, 19 Feb 2024 16:39:35 +0100
Message-Id: <20240219153939.75719-7-anna-maria@linutronix.de>
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
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/kernel/vdso.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 2cf76218a5bd..100cdea6d3e3 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -30,13 +30,7 @@ enum rv_vdso_map {
 
 #define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
 
-/*
- * The vDSO data page.
- */
-static union {
-	struct vdso_data	data;
-	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
+static union vdso_data_store vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = &vdso_data_store.data;
 
 struct __vdso_info {
-- 
2.39.2


