Return-Path: <linux-kernel+bounces-73650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C921D85C576
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844F1282292
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105CF1509B5;
	Tue, 20 Feb 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D79Eduaa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtF0E4PM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1D14F9C9;
	Tue, 20 Feb 2024 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459477; cv=none; b=ojnSH+9uFZ0JM+DflVgzj7WwV8+Su3Ij0FBC4THyeluP0pBm9XtNTQXwi82NfVVKXDSk649nrGmxaBhMsm7eFnMQiW8Zhg/EoY8qF8K9dH1vDjRtq/LS01DhxTibKqanJBBRAXQu+v2gWXXFQKnoz8P3bFqPhREO1IoSSaKrj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459477; c=relaxed/simple;
	bh=f/onlCNJE/4HdqE8p5ygkJ2fiui56INuqXbSLjJ48zI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FmaRG6zyajjZ28GxVzs9yxXGHTcQt7gjbjJhDakV2Pn9oN4TQlJRTH+OYUeClmr7JMy4p0wE0BO6LpDbu5MkXgtb6pKDomOFsVB8XJjlFCPwdOq2D0ON2yH8MkAUJB0BhrPqaG45bRNoYqU2Miv2LYME+exttZACYeL4vppCphs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D79Eduaa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtF0E4PM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 20:04:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459474;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd3ZWLHwHXMhTGdTD690PfAMv0icI6becbTxFWs89hM=;
	b=D79Eduaab0lfTRBZ+2duA0u3mlJCN52xDcRPvynFKKYqUCstT1UzvRgsX3CZi5QMnNepoi
	GaXzvZJprc2H0KNs+mK9MCHGJLU6pYHJl6K+4HoY3lHPqD04zEjE4cgOG79IbsDG8u/hT3
	x/7/ckpLnOs6BaImQM3KsIH/WVzN+4OvGQdCkITGG0P4lGe0qnwKIbpM9sW4XFhXi98IV9
	b184FQ4Sv7DWVUm+udCe0g4O4kta+itjMlaIQ3QhUuSC60SJ/uwhWwfpOpu6P/2hb8m4KY
	XIie+NO1WhS3zH9mft3BG5KHcB5SYG4f+/jE2T97aZg2Ki6T3qq4U39gbxbkbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459474;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd3ZWLHwHXMhTGdTD690PfAMv0icI6becbTxFWs89hM=;
	b=XtF0E4PMS6nClI6S6fvsgkOtp6Z5M6RQ/AK++C/NVFJcexM59NqYctMsa16VkSM44OC/GB
	fGf/CgM8mkY9uhCg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso/helpers: Fix grammar in comments
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240219153939.75719-2-anna-maria@linutronix.de>
References: <20240219153939.75719-2-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170845947324.398.12984654701310950500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     eeb9f5c2dcec90009d7cf12e780e7f9631993fc5
Gitweb:        https://git.kernel.org/tip/eeb9f5c2dcec90009d7cf12e780e7f9631993fc5
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 Feb 2024 16:39:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 20:56:00 +01:00

vdso/helpers: Fix grammar in comments

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20240219153939.75719-2-anna-maria@linutronix.de

---
 include/vdso/helpers.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 9a2af9f..7350114 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -30,9 +30,9 @@ static __always_inline u32 vdso_read_retry(const struct vdso_data *vd,
 static __always_inline void vdso_write_begin(struct vdso_data *vd)
 {
 	/*
-	 * WRITE_ONCE it is required otherwise the compiler can validly tear
+	 * WRITE_ONCE() is required otherwise the compiler can validly tear
 	 * updates to vd[x].seq and it is possible that the value seen by the
-	 * reader it is inconsistent.
+	 * reader is inconsistent.
 	 */
 	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
 	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
@@ -43,9 +43,9 @@ static __always_inline void vdso_write_end(struct vdso_data *vd)
 {
 	smp_wmb();
 	/*
-	 * WRITE_ONCE it is required otherwise the compiler can validly tear
+	 * WRITE_ONCE() is required otherwise the compiler can validly tear
 	 * updates to vd[x].seq and it is possible that the value seen by the
-	 * reader it is inconsistent.
+	 * reader is inconsistent.
 	 */
 	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
 	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);

