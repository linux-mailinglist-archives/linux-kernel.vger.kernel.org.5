Return-Path: <linux-kernel+bounces-111366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DA9886B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5515BB215A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DB03F8F1;
	Fri, 22 Mar 2024 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zh0PAJB2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RwXlVast"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B1F3EA91;
	Fri, 22 Mar 2024 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107145; cv=none; b=BPQxy5NDb4uo1+rnJ7JtwFZTAwETGhcaXls15xSfrF6Qgw5pr9eVYcT7vdSeGBr1lMs5aAUSNJGSaD8n66VYjHxces6vVYJiQRGH3SquMx/W60/GaD8NLkVrMiPyZbgmePFDSDrazVpW10lPczU6BEt6JngYNdy6LrVYekbqP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107145; c=relaxed/simple;
	bh=90coaIbKQw4ZkhaaF0j7Q5qW8B/dorCNCimYbGkskmw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gwZbmo3w2DOx9shaQEu24q5HCthHgITYyu/XcOa6G1Z6akF4bPEy2aPiavuyEcTiSx9ePJMvhJd4uESp+q0ioabuVGnuvmIATqsYyV7YDEp39ATZ0mSvtrMbqKhF9ISEWgAzAXJDcPC3qUNdZGZkgLsfGF3gAfzzpL28TMB1hfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zh0PAJB2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RwXlVast; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 11:32:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711107142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XutA24CimGtRMlVcPHZI5MoxhxADAvKQO5+U9ScpjW4=;
	b=zh0PAJB2SQVW1hiZIypfNi3o7QjV6HeZ9he1P5qSw2R8bQ3/Z9D6XkzP6QBIoDiGZL+pIo
	jBuWPSDCAQeZyv/e5UTvA6kH8HZ907SAewBJGZ1YLErZIvsTIxmw++w4cShPg+3TwlbpmG
	fY9bE8BPtVB0pMWLOJrhRbAvV99v+SPiYRpKhmJk+Byxa9CZiw5thpC7w0C/G+SEkEf2VB
	fzOxSQ3OV3EY54TWuu+6zXflaATc+xdEOe8Z51k/mwbgNCUD9GFQ3rQMRl1ZBmWbaQ/4YE
	0tyAxfE3BVUyNhEKrNDKPUL4Wi+ilgIEiv+0BQ+fmBybw+lMtDHpqj9Oq7A69w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711107142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XutA24CimGtRMlVcPHZI5MoxhxADAvKQO5+U9ScpjW4=;
	b=RwXlVastRpctiMkNS6telkjWu1X8oPxbPj0wuRu3dHtvGJ5ujDYSXTM7GRc9Sb8HwcTDix
	2Qt7F/ROUBojC6BA==
From: "tip-bot2 for Paul Menzel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/fred: Fix typo in Kconfig description
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240312161958.102927-2-pmenzel@molgen.mpg.de>
References: <20240312161958.102927-2-pmenzel@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110714175.10875.9793594920655903876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3c41786cab885f9c542e89f624bcdb71187dbb75
Gitweb:        https://git.kernel.org/tip/3c41786cab885f9c542e89f624bcdb71187dbb75
Author:        Paul Menzel <pmenzel@molgen.mpg.de>
AuthorDate:    Tue, 12 Mar 2024 17:19:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 12:27:31 +01:00

x86/fred: Fix typo in Kconfig description

Fixes: 2cce95918d63 ("x86/fred: Add Kconfig option for FRED (CONFIG_X86_FRED)")
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240312161958.102927-2-pmenzel@molgen.mpg.de

 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7aed87c..bf2b2cb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -504,7 +504,7 @@ config X86_FRED
 	  When enabled, try to use Flexible Return and Event Delivery
 	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
 	  ring transitions and exception/interrupt handling if the
-	  system supports.
+	  system supports it.
 
 if X86_32
 config X86_BIGSMP

