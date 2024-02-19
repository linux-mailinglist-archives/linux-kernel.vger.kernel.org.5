Return-Path: <linux-kernel+bounces-71600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D31A85A79F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC41C22E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14153FB09;
	Mon, 19 Feb 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0YoW3qr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eQSzwW4k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7003C49A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357210; cv=none; b=ss5td9S4EL/A3Z9mOknZc3B+EkUMTPA3C4qWsk8AleLcVulM1ziIRjdE7SDgCpAeOt7WsWaL837iKBoLpZXtaJCg7gQ3y72N6dihcUuAYivHao8fcyxE1TGQpht7Zr5/Pl30iHv89xi3EgX3C+zXwNlaebvNiEz7HcVhsfGiF9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357210; c=relaxed/simple;
	bh=Egn/4loMwHErFaYxX3+cKQLZn6okX8CccVfeOzBn8aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SinziMD8y46HRsCSwPz1xT4t1qdjQdJAkN51iNN1ofLbgFcVodez1YuHC7nLY9wab7h4JQDjI2Dos1nLDzmXZJeWYIm9nuhDLKLqqopvdq/xMMy/omw92KlB5grwNgM+4o2BIYtOSA5GoBeXy1CpUKlTtblHNTt9D5R7+YnISLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0YoW3qr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eQSzwW4k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TERCToEIU1g/eqQgTt1qdsHKnOD82z4H77Fq474fFqE=;
	b=i0YoW3qrOVk3P8xkqI05dmx7ulsyuLhIy4BdFWKLmt8S0vVUBGjAS9N/d7bdqZ3tBQ6cP4
	IYgQ/JqjZgl5NvI/i3D0gfedBge8Hr+NiZxCJ68h828PLcyLIO4l4DKVQCH9qC+U/dHVC6
	8v4+TDkrgclxK1p289PeCeY4rvh0VVAMCtbdilYydpoVS5y3eEr/cWJsjAGW4PL+k6XPgz
	TgA/OhyqF5SVMKEaHztiL+gHRdbAslL3pcod2JaLuT6pYZGGjALPxLq2pee6FZ9jAxZZY7
	n6G6xf8WF2Sa6i7wlvFtnH+MmjFzxpVC80D894uI5IESwXYVCqcqL6VYU3bPpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TERCToEIU1g/eqQgTt1qdsHKnOD82z4H77Fq474fFqE=;
	b=eQSzwW4kfSJejLlyBll+AQLjET3Cra/9zvqyTsqucpJCt7NwSSKmemZRCwV35XOep+vfRY
	AukEQf4ZmrCFKMBg==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/10] arm64/vdso: Use generic union vdso_data_store
Date: Mon, 19 Feb 2024 16:39:34 +0100
Message-Id: <20240219153939.75719-6-anna-maria@linutronix.de>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/vdso.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 5562daf38a22..89b6e7840002 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -69,10 +69,7 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
 /*
  * The vDSO data page.
  */
-static union {
-	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
+static union vdso_data_store vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = vdso_data_store.data;
 
 static int vdso_mremap(const struct vm_special_mapping *sm,
-- 
2.39.2


