Return-Path: <linux-kernel+bounces-90398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8801186FEA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EA81F22F05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514313D0C5;
	Mon,  4 Mar 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oF47lkb4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bC/zpfQn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553C2556F;
	Mon,  4 Mar 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547152; cv=none; b=riAruhF2j75jW8Bn9NrMr4DmZNFTWtkc6WDfmlnODHZBGIVnQXAmtW69ZoYPPMK1OsgyQBNoCVfzmD6yxe6jzh8u4ysc3ro/dw01Y5EC3gaUAahiAMg9oSzwGcIc9/QwClsQwAnv3LFBYOFelqKAIogNuF/i+ozgBRzhCd6PynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547152; c=relaxed/simple;
	bh=8Pg2EFDXUYjtz+tkcv/kg/YFmeskhKXf43DpJ0nXHlg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KZy83YTahKPQZbeY7QDs05v98+uCQpA0OeK/Hya2bN1F5OwLh9OprjDZ3YO1zQlP+K0c1Dujv9Wtt21wy4GwlXsFSS0Ib76zcPWvZR40OulxUubVM3kGPcJePKx2JuHLkmeYw8p4O8nbeWI+zrCFdoF/OfpLjgTBNvXsshMm6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oF47lkb4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bC/zpfQn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240304005104.841915535@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709547149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CNfpfUdf+bJ/WXlKRuxwbcf+mJAjRsom7OLtmfNUsUs=;
	b=oF47lkb4Rk/qvj8Db0DRNJP1DueeQS9kXvhHnhNzDRR8etK9qNQysmWn7gl1vnhJGoyRVU
	G3nly8CjbNeLALkuKp6qhtOlQd+IXybJsPeFN902wLcz/8bciN4T9Ts55RgXlE5yXECQ4P
	r0ndTbug4smvpyy4oBE5xvh0KjUTBclNR58/LW3vsJX66Po7iz+XKA54haE3NDtexiWtfE
	j/YvojK59blwLY6kn3bHJN7VVH/HW8RXyhm4kDQtDYTYj6yf8zCphUO2GgAQU5u39vfP7p
	BH3jv35bwdDorlupW8PDfesjvd9M9ky6L2OXWfJz+TUUtjJFZ1GURBq9K8kkRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709547149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CNfpfUdf+bJ/WXlKRuxwbcf+mJAjRsom7OLtmfNUsUs=;
	b=bC/zpfQngeugmwtDkBFAMAJ1oOblN8I8e29J1a4Gq0IsYlUkp4Ep8z7A48ioHN+x2JjHE3
	QcneLlx7+eISCTAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: [patch 9/9] x86/callthunks: Use EXPORT_PER_CPU_SYMBOL_GPL() for per
 CPU variables
References: <20240303235029.555787150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  4 Mar 2024 11:12:29 +0100 (CET)

sparse complains rightfully about the usage of EXPORT_SYMBOL_GPL() for per
CPU variables:

callthunks.c:346:20: sparse: warning: incorrect type in initializer (different address spaces)
callthunks.c:346:20: sparse:    expected void const [noderef] __percpu *__vpp_verify
callthunks.c:346:20: sparse:    got unsigned long long *

Use EXPORT_PER_CPU_SYMBOL_GPL instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/callthunks.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -44,8 +44,8 @@ DEFINE_PER_CPU(u64, __x86_call_count);
 DEFINE_PER_CPU(u64, __x86_ret_count);
 DEFINE_PER_CPU(u64, __x86_stuffs_count);
 DEFINE_PER_CPU(u64, __x86_ctxsw_count);
-EXPORT_SYMBOL_GPL(__x86_ctxsw_count);
-EXPORT_SYMBOL_GPL(__x86_call_count);
+EXPORT_PER_CPU_SYMBOL_GPL(__x86_ctxsw_count);
+EXPORT_PER_CPU_SYMBOL_GPL(__x86_call_count);
 #endif
 
 extern s32 __call_sites[], __call_sites_end[];


