Return-Path: <linux-kernel+bounces-71596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD2985A79A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD54285245
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF513B7A8;
	Mon, 19 Feb 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I0m32Lb6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SjXnqLKO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6F3A267
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357207; cv=none; b=FtvH0w65rds4/JzZumY5yVnGl2DYwzDAI9XzqoDicH2KMBEOQqVhq4ge+/sGhoi6xm/yb/bhbGE8w/J+ThiwcYeTQ2INxZrYwppAshCKot2jLkGVYqPxv9554k6EXZialRkISGKAHWqqNNS7tcMX0axTF+uBXGbbNPykD76Uyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357207; c=relaxed/simple;
	bh=/FzeKqaG0j2mmEV30Lj3oWwxV021Lej+8GfyOXwTkJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltPIYOirBp9Zn0pW5G9O3z55ntiLfHz4dmsqyCOXsVah5kWSCGGhXGtaa+zOyyS4CcbAhZ4+jMK7OHWGAXwII1qbVoY9XoOp7Gvv96txMpMEB3Um2FS+foOz3Xsiwyuv1n1OSsc8ovTv43dpg1rfrI5YvAPDULllVhs5deg0mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I0m32Lb6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SjXnqLKO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2THOEnwAJiXgtrKYZPFtdOpgH3pVV/ELbGPBq/l2joE=;
	b=I0m32Lb6T/ObtZKMnhjIHn4MwbFOMtybRMuAVEWI9k/eJvcHdm4qGkmYaxccoxK3r84qIw
	bfHTltqdWu2hR8sF8DlqiJKqhreFB3O79TUxlBJdIgsQgY6gDunzDYSw2Pjnpd0vSzyjBo
	97K4qJkMRsRuXMxNcYocS+P8Laab76ZrWv1XD/SClO29CjtNdKPGLszNNi6I3BymGHg54w
	hguzTh5Ew8uTbgoxdHjBKjMynA2OaoHuOIfYvp5BSZGymt13B0tQkgMYigPJC7TikiOW9z
	8MjumUxi6P1VZwmGnyh5fDo19Yb27+Q3mpCqpZjG+oA17gXzLJO+DegrpQhhaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2THOEnwAJiXgtrKYZPFtdOpgH3pVV/ELbGPBq/l2joE=;
	b=SjXnqLKO7XBqm2sC7xJY+X1D3xKVo9NNT3JTkgrn/es1HLWwFPqzMh5KEPPIA5Lgq0FrHq
	Ms3/yiU7V5Dt6kDg==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 01/10] vdso/helpers: Fix grammar in comments
Date: Mon, 19 Feb 2024 16:39:30 +0100
Message-Id: <20240219153939.75719-2-anna-maria@linutronix.de>
In-Reply-To: <20240219153939.75719-1-anna-maria@linutronix.de>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/vdso/helpers.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 9a2af9fca45e..73501149439d 100644
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
-- 
2.39.2


