Return-Path: <linux-kernel+bounces-73646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5465885C56D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2E3282F74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CFB14E2CA;
	Tue, 20 Feb 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nliHQMg8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jBtZEobJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC014C5AA;
	Tue, 20 Feb 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459473; cv=none; b=iv2DN6dxTfTkQ1c6v2Ay5/bZ3nCtykjzy25E5pzP4CayBDzV1ZYpqeXZ5qWlSfMiLWBUkYyIOADk+dQxwipGk+9O7/+xnHKw35tO6MuoF0NcWMeh/+gTpKqKheyGmV78GbGKaft5lThyJqj9deEqFUXqBSE00gLRG/gkjw7R34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459473; c=relaxed/simple;
	bh=qKd6PC8dt2Zlr75sWVig97tmMH/ZSxNd9EQoZmCCVgQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rnDZ/UNI2CQX5yoLLiphgDH4I2cP9tcxDHimXhBN/rvUiOrK9xzTX/bfFVEgtcK1g3GveA/hR/76cqtPVfQGA3IQZ9fSp/CqCnc0OKmNteqykLMDJyScCn9gbgZmLAOpzeywX7cTZt0ibu0u8OtmCBn56b5k7hZXfkyzBOTXqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nliHQMg8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jBtZEobJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 20:04:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cupOez831WwgEQmmUacsYkV3FYrJtoBbvg1wYq5V8T4=;
	b=nliHQMg8fqgI7Hq2TqY2G4eQz3zuRrZrGggGvf2vkSRiXkouqkgFv2jvdrpzGKDa/h3p6E
	OwMVOAwCiGW9Fkn1fOTivsPdiR6megC9gvNRKE0gXyBHE5UEVzN7lXddsz4TI9YFElaNa+
	2EYY8AZTvZV75+BiIEiOZQtc/oupUYkCr7JgyPcvCobNzP77toibBkqdXYAKW9rC609cNc
	x9+tPZB2fw9YijCFCbvMpUsRHaBDNkRcVtn7Z+c8ZTAlhmouxl6TyiyrQuncoFXJQLNA7v
	TQjhystPmhiqtJcznDsCCpj60yFYo+KlKJBgmAM/4k1Qxk/FnVkIjGx5mkyOPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cupOez831WwgEQmmUacsYkV3FYrJtoBbvg1wYq5V8T4=;
	b=jBtZEobJ1ZFtS/vh570/4FEVY/2ew3lKZAyC5HQIQnafsyJXm8l5m2jFEpkZx4gBii+Ofn
	0itGioZhGa1D8JCg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] arm64: vdso: Use generic union vdso_data_store
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240219153939.75719-6-anna-maria@linutronix.de>
References: <20240219153939.75719-6-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170845946975.398.3528963742493792295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d0fba04847ae1dc7015a2e87d5e4ae1111f7744e
Gitweb:        https://git.kernel.org/tip/d0fba04847ae1dc7015a2e87d5e4ae1111f7744e
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 Feb 2024 16:39:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 20:56:00 +01:00

arm64: vdso: Use generic union vdso_data_store

There is already a generic union definition for vdso_data_store in vdso
datapage header.

Use this definition to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20240219153939.75719-6-anna-maria@linutronix.de

---
 arch/arm64/kernel/vdso.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 5562daf..89b6e78 100644
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

