Return-Path: <linux-kernel+bounces-153145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911278ACA21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26EE1C20A29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7A13E3ED;
	Mon, 22 Apr 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="43hEQLjB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P0bS7eSC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8012837C;
	Mon, 22 Apr 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780077; cv=none; b=quB8KiCB3RgNGObZaunaIsoHQSkfAcfac9CenUabqJfKN50mHgLwVW/fqSXIy1tElXtTNjs4PJMGudbY2JT8s9uDm84UARCh3Vmc6E7piZDryFFyqhBrYZtD7RK/pKEKtiOANarMM4/uelhFOfhtPGw/e7dnPPnT9F7a0hjlhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780077; c=relaxed/simple;
	bh=KiS5jBM9kAdav3nfwdQ3HeNKVj2AIlwsVJFHBYU+x+A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oJMGWHDFCkL+nyE7aWpUdfyk8sjxhNo+QhK7JGlMlHo+oGRw3LNVvOSbVi4c1xxAdnzxRvJhr9LR31z80u0WJbPxKOY2W/SA7cM+B+gVl8CnaVqwIHq+Mkc/weXn/WT7m32DQS9OHIm7HbTWnLof+ZKIZXW1LquwAgAdaJWOmBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=43hEQLjB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P0bS7eSC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 10:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713780071;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k36/OzTuWnVZCdzvGZGEbyXGQwInx3at1IQn4KQjoFk=;
	b=43hEQLjB4sl/83AyyjjeDLq2Qo6GHWGfQokopMEX/uF9FFwylqNFdxYei8ticn8qfSY4Ng
	ZlElczdWcd804n0wZTK2XS75VyvcHejlwtid2Vs+/TAuUyUheGADFhMpHO9hwjaKa3wwu5
	xBoW1uy+kpBSr0gFjv2t1OnhJlqhVdfp/WWrB9FKDDMPWRWM+gOQxZdlIt7sEo9AFM8OJf
	EgDNeEH/d6xjve3nndtFn0fZkxI4rv9d7GtmmGrwB/tvd7jGBnIexWABtjNyMgISr9y7y1
	pvsj+9J57ZuHajUB69bb0U2OmFqOh04OOv+Nr62B8Pbqnsvhy2hogFdsS/cmLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713780071;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k36/OzTuWnVZCdzvGZGEbyXGQwInx3at1IQn4KQjoFk=;
	b=P0bS7eSCTvZfeOmsn+/uRwN7sKz6Xfi8aGaX+SmFkbSB8nUeOf7NNs8UVTn9iJj7ZWPawu
	xh3Jcsy58DwWEkAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/vfm: Add/initialize x86_vfm field to struct
 cpuinfo_x86
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240416211941.9369-2-tony.luck@intel.com>
References: <20240416211941.9369-2-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171378006893.10875.6298031558412078369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a9d0adce69075192961f3be466c4810a21b7bc9e
Gitweb:        https://git.kernel.org/tip/a9d0adce69075192961f3be466c4810a21b7bc9e
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 16 Apr 2024 14:19:03 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 22 Apr 2024 11:43:48 +02:00

x86/cpu/vfm: Add/initialize x86_vfm field to struct cpuinfo_x86

Refactor struct cpuinfo_x86 so that the vendor, family, and model
fields are overlaid in a union with a 32-bit field that combines
all three (together with a one byte reserved field in the upper
byte).

This will make it easy, cheap, and reliable to check all three
values at once.

See

  https://lore.kernel.org/r/Zgr6kT8oULbnmEXx@agluck-desk3

for why the ordering is (low-to-high bits):

  (vendor, family, model)

  [ bp: Move comments over the line, add the backstory about the
    particular order of the fields. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240416211941.9369-2-tony.luck@intel.com
---
 arch/x86/include/asm/processor.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f..e0f9251 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -108,9 +108,23 @@ struct cpuinfo_topology {
 };
 
 struct cpuinfo_x86 {
-	__u8			x86;		/* CPU family */
-	__u8			x86_vendor;	/* CPU vendor */
-	__u8			x86_model;
+	union {
+		/*
+		 * The particular ordering (low-to-high) of (vendor,
+		 * family, model) is done in case range of models, like
+		 * it is usually done on AMD, need to be compared.
+		 */
+		struct {
+			__u8	x86_model;
+			/* CPU family */
+			__u8	x86;
+			/* CPU vendor */
+			__u8	x86_vendor;
+			__u8	x86_reserved;
+		};
+		/* combined vendor, family, model */
+		__u32		x86_vfm;
+	};
 	__u8			x86_stepping;
 #ifdef CONFIG_X86_64
 	/* Number of 4K pages in DTLB/ITLB combined(in pages): */

