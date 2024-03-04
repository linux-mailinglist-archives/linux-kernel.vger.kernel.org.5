Return-Path: <linux-kernel+bounces-90390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ED486FE95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E69E1F22F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3FC39843;
	Mon,  4 Mar 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18molGr0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I6Cd0G1o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB422EE9;
	Mon,  4 Mar 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547142; cv=none; b=RVM93YiZM6nrLCpKvR5rrNGyziYXXLgphI8fr/rsn46Si2dGLUvd1bef4WRjttKxQIudBfgoW8Ez9qjgo3nGbMO302rBqRB7NonIgWbizARjsdo9Tjr3SnPn8YVG0KK6qyP1x51vxZ5RSnKaarezav0id/JKGZJW71HaUTOpOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547142; c=relaxed/simple;
	bh=OxIB2NND+GwRKTASD5QCovsMnnYYsMqrQtarqse8fjU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bb7O70rEBqO8qfX1ZDFjjD9Kl+dP3bpVI4SbaWW2Tc5Jn8jQnV0m05d1dvOlHq/ixvjPcDymyWyLcu/RxjFX9M0aAAa5lnXexDBP1VUETaYlLL4aHkZds4NnjrmU8TnNmKr5xMltKN1Vg3tRueokvo7w+5w27FyKT0RiZ79ZoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18molGr0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I6Cd0G1o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240304005104.394845326@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709547138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A3vlMqUJEQqqd54jjPrJxoXmY2AzGd+lvLwJqkXi5u0=;
	b=18molGr0u2BdjPyrVtj4EuzPZ8saG92VRtLosWyHKUqN7RTwSdyYxCOOHA3hBR65Z+9cua
	UGyGPSikf5PBTaggGn+HQgBChxqSxdFHlUNxcRK/PLssQ6TQG00Ljw66g7ZGAOo+kBz+jL
	+1GQOPDYzzl9QZVcqQ0SeLH/BefvdPSnYGmhuA5/EENb52l5WowQjMujAnzDenn58GaSAb
	/YT5yR2CDCRhy/dXWWA86DApqPso8offxSEcXNsAYJldO3H6XJ8BtDCBiMT8o3ZrsO/eny
	Z+0ZnFS8BlwRFjn0PDFfqfqMurvNEDu2li3R1/oIrEVuM22K+j5Lhn3Rdmr6gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709547138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A3vlMqUJEQqqd54jjPrJxoXmY2AzGd+lvLwJqkXi5u0=;
	b=I6Cd0G1o/AZmLzVbcS4rLiO8uXc1CRKi91dtqC2ynHYdFBQ9uWYdR0ijlQBFFCXge/9w3S
	r5PNP10WdNkansAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: [patch 1/9] perf/x86/amd/uncore: Fix __percpu annotation
References: <20240303235029.555787150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  4 Mar 2024 11:12:18 +0100 (CET)

The __percpu annotation in struct amd_uncore is confusing sparse:

uncore.c:649:10: sparse: warning: incorrect type in initializer (different address spaces)
uncore.c:649:10: sparse:    expected void const [noderef] __percpu *__vpp_verify
uncore.c:649:10: sparse:    got union amd_uncore_info *

The reason is that the __percpu annotation sits between the '*'
dereferencing operator and the member name.

Move it before the dereferencing operator to cure this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/events/amd/uncore.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -71,7 +71,7 @@ union amd_uncore_info {
 };
 
 struct amd_uncore {
-	union amd_uncore_info * __percpu info;
+	union amd_uncore_info  __percpu *info;
 	struct amd_uncore_pmu *pmus;
 	unsigned int num_pmus;
 	bool init_done;


