Return-Path: <linux-kernel+bounces-73641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CC985C565
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDFC285E50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5B414A4E4;
	Tue, 20 Feb 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wIFxmS5c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OsBiEu+J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44377656;
	Tue, 20 Feb 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459469; cv=none; b=tzsCI4kwf9tMDae3R6ZUYQIEfoxv49qxjZwbtZoNMBHMVzyDwklCJq5BM8i3xQ3eDISOCX75a+NoL/A4IMcxlLzGBoMtQVHtDY72HjqS7jaLlmnQq5yKMn2Ch06mGkhernWUkcbe8cEyW7ZdzZDrm0aczz8buXh4wTmCarQsqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459469; c=relaxed/simple;
	bh=eHlSqloIhq0tmAe4tDKZ7xiQw+QcxGeQPTn6DD+rnig=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p5jhghcGbLalqlRhjNnDaK/nOKmSCR9bqF1F90oRz+Xnjt+WZ0bHkJK99iLY7wDoRxJ1GmlhKHiZBuWiFkGePgFOfcyRx4HZfGS9UykUOodev8Fizo88oqYNBpxkL8TSoAzOFHWRGwSC/wz+fYGag+Ydp2tChPI3cxZO8eB91Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wIFxmS5c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OsBiEu+J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 20:04:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48pgenB3n3PaeoLPCSGxzErJYm6lQq+mkpGxA/mdBnM=;
	b=wIFxmS5cTJcKE53r/yRHHVpS7cjYYH0kL8rTJKQQNAIt/+xh3zb5KmOiD2H42q0RHftzBB
	xgKiwDdrf8t76jCkzX5rXLSpjYLGDyq0Ng0HPD7EWVYOBlQNRpYhtCOisNfcTK6B0BnB8a
	HMVlIybOdi6SLUpTC1OuEVFOcax5g2poYCZHrH6yBDYyPvRUvi2reTFNvT9B09Lyfnaxbo
	62NlcLyo8nz+EeXlg1nvqzh/J23EAAsVAH/iQnFYBDsMcSXzLxxz4DxMuicFjSLzv7eGvR
	p5MOdPkRbkUa8dZW8CiJowhEV3R026LIJxX7CDjBYoImCZbjigm0qK1gCBypDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48pgenB3n3PaeoLPCSGxzErJYm6lQq+mkpGxA/mdBnM=;
	b=OsBiEu+JS6H8bNmPH1FERAxWwuUXmLjpYdrD1T+IJ3I/jHaSTs5Vfu/O5frcFpNM2emZiP
	TrJXIQxSZ+WxdsDQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] csky/vdso: Use generic union vdso_data_store
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240219153939.75719-11-anna-maria@linutronix.de>
References: <20240219153939.75719-11-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170845946510.398.15647064695423653588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     56145a0f84e8862aeb3b36d6e21349bb4dd64269
Gitweb:        https://git.kernel.org/tip/56145a0f84e8862aeb3b36d6e21349bb4dd64269
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 Feb 2024 16:39:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 20:56:01 +01:00

csky/vdso: Use generic union vdso_data_store

There is already a generic union definition for vdso_data_store in the vdso
datapage header.

Use this definition to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/r/20240219153939.75719-11-anna-maria@linutronix.de
---
 arch/csky/kernel/vdso.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index e74a250..2ca886e 100644
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

