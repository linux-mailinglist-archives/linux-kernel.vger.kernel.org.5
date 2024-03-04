Return-Path: <linux-kernel+bounces-90556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CB5870113
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33F3282157
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F083D99C;
	Mon,  4 Mar 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0RWeU0vn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZgmJISvL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5A3D3A1;
	Mon,  4 Mar 2024 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554512; cv=none; b=ungOt2VJmCbyP9Bqs36N9EpDDYuw3E4SAL0wLDWlpam8DwKvZd5hkl53CZjCTFSzZ+zd2yu42BxjuOxk1vGubgNowpBEiV9TihSFl12GI5GIyfEqlxAdFgWGo4Q6j4TM4FfAenKdCasJBU41dLanUfDWzwoFsCl113Apg8bEw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554512; c=relaxed/simple;
	bh=24gGEBD85uMJ6hyJwnGdczNqQILCUNQ6WPuUDDHuvg8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZsnwiEYHFGMq6jJNyg1M2h/hmsAxE8lJ/Z8eIie+Vy7DgZ29lilLGHtWQ8mWMb3opo9As1iJB1zooc0vNK5pt53jWyM3RL6ecLCb5mywRm8eMDHOggka7NZehhAdm4tFUZd1XNC3cZuD2sEUAb+SumrqAUq0fh1KEMuKAwslKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0RWeU0vn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZgmJISvL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 12:15:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709554509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYjQL1m6PdNqMGrIubduBfk/LF9c7kH7eRNu+74sspE=;
	b=0RWeU0vn3h32AHT/DcjLl0ONM2Iy3RY9b0W8mnHim2uSctMV63r/IR4i8plzO4YSSfjV1R
	DBJurKo9Q5IQuPKKTs6sMWnXCgvcZ1V+rKmDkxVEV5rKQQrplzDnL4Wy7IcVCFPyWG6TY1
	p1VTn/CKwVKDHiLcdiEAGFM7NtU+WXqjavMGfIpdVChtgpMWWdr2OPNGjB/TzEZrQNJokv
	r/SCApn046Td/FbglVF/N+YoqGQYQSMzUg3A7+iPCHyKGQmh2C5k/2XQLfRQhlCGETkQYQ
	v2QyWJFEgGy/oKxbLFO5BNRFs2Z6Q42JguL3slH88WAtCzkdlHjK8syDqwVKTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709554509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYjQL1m6PdNqMGrIubduBfk/LF9c7kH7eRNu+74sspE=;
	b=ZgmJISvLACO2cxHpEHLaaO4wAoCKCsRqyTh6tHC5YT8V8nfFFEgwaEMvu2y46h738N5A4B
	/092ONa6HeHod1BQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] perf/x86/amd/uncore: Fix __percpu annotation
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240304005104.394845326@linutronix.de>
References: <20240304005104.394845326@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170955450855.398.7376903454873999769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     9eae297d5d8d87738a14010af62b2b64b9d98097
Gitweb:        https://git.kernel.org/tip/9eae297d5d8d87738a14010af62b2b64b9d98097
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Mar 2024 11:12:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 04 Mar 2024 11:58:36 +01:00

perf/x86/amd/uncore: Fix __percpu annotation

The __percpu annotation in struct amd_uncore is confusing Sparse:

  uncore.c:649:10: sparse: warning: incorrect type in initializer (different address spaces)
  uncore.c:649:10: sparse:    expected void const [noderef] __percpu *__vpp_verify
  uncore.c:649:10: sparse:    got union amd_uncore_info *

The reason is that the __percpu annotation sits between the '*'
dereferencing operator and the member name.

Move it before the dereferencing operator to cure this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240304005104.394845326@linutronix.de
---
 arch/x86/events/amd/uncore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 5bf03c5..4ccb8fa 100644
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

