Return-Path: <linux-kernel+bounces-140454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDB88A14E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587082861B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28F940C09;
	Thu, 11 Apr 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGuxuqF0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r2MAAyJS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A403A1A2;
	Thu, 11 Apr 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839518; cv=none; b=qyJBYTetZDFQhp0gebtPNOl5VTdL6EK2jKI9lvdSIIx0xaVqn3aNApLojN9SudEm7kZR23auEfxVoRBvlMECrogFNYDxE5NQtV0HfQY9GHIqwO8mH8H8zN3wauXD+sUHrFtQhYa0cCRLpt6jnR+IgJQppPmAcVIb71jtwffOsAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839518; c=relaxed/simple;
	bh=KF2dwmuHgUN99Dm4LQ0GMIRgT3qiERf9RA5zZSa5q7g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FLZs4yyXEKzS/G2gTyJYK9hVXiCMnBSBiY3+DLXMGltIHmKTz/E6j00qHeJvdL8J58ZKSXiEFCJdt6TUaQsh6G+kk29OMDa4loul4a+kXrE6cTkgw4/Okq7omrq4Y9JEzXSi/xDi5d16a4j3rqxvlFxDd7Xq3NF+FhFgBFSH83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cGuxuqF0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r2MAAyJS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 12:45:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712839515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBnBVDJnEEo8Cuf29WIXXNXUEw3lOtrkVKsNhIAtadY=;
	b=cGuxuqF0dPCV+VVlqNqAt/68URSZ3N1UxJk6Pav3hFjccVQ35Zx6eOIyoxHibox9L0h9Rd
	ir598p5UH0826XWejsakLqeLoF/3NXrQTnHheHjFsN/8AbYKZ7qDxA3bRh5TcPllQHLUkE
	m8QeaO/kGgu1DqHrQIwUTITXPLXnfDS/lY/Dfngw29S2kxXk8o60mw1HWWSeUCYS3i4OCc
	HglTY5/vWH0ma3BD5gnTIqN4MJRfB+kXl9ElKr9ljcYdJN0J+01SqPbj7dFKyRc2QJksDA
	SMMQrHFGY9zaQ2NTI3hqEQDVkQ+2XXnbd9wo96bayxipgsTFLgWyG6UG2a2QuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712839515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBnBVDJnEEo8Cuf29WIXXNXUEw3lOtrkVKsNhIAtadY=;
	b=r2MAAyJSnVtb1uPOxgBEQ1ArkcKAmhL7nJSbTEyDLJ5hJKg1aQ4aQJ7b1ghfOFO/nb14Fg
	/KXJSrQ3i25fcqDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/cpu/amd: Make the NODEID_MSR union actually work
Cc: "kernelci.org bot" <bot@kernelci.org>, Laura Nao <laura.nao@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240410194311.596282919@linutronix.de>
References: <20240410194311.596282919@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171283951389.10875.6119406308489152225.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     898e4996e76053bfa0f578629ec6b35baff4224b
Gitweb:        https://git.kernel.org/tip/898e4996e76053bfa0f578629ec6b35baff4224b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Apr 2024 21:45:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Apr 2024 14:18:29 +02:00

x86/cpu/amd: Make the NODEID_MSR union actually work

A system with NODEID_MSR was reported to crash during early boot without
any output.

The reason is that the union which is used for accessing the bitfields in
the MSR is written wrongly and the resulting executable code accesses the
wrong part of the MSR data.

As a consequence a later division by that value results in 0 and that
result is used for another division as divisor, which obviously does not
work well.

The magic world of C, unions and bitfields:

    union {
    	  u64   bita : 3,
	        bitb : 3;
	  u64   all;
    } x;

    x.all = foo();

    a = x.bita;
    b = x.bitb;

results in the effective executable code of:

   a = b = x.bita;

because bita and bitb are treated as union members and therefore both end
up at bit offset 0.

Wrapping the bitfield into an anonymous struct:

    union {
    	  struct {
    	     u64  bita : 3,
	          bitb : 3;
          };
	  u64	  all;
    } x;

works like expected.

Rework the NODEID_MSR union in exactly that way to cure the problem.

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reported-by: Laura Nao <laura.nao@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Laura Nao <laura.nao@collabora.com>
Link: https://lore.kernel.org/r/20240410194311.596282919@linutronix.de
Closes: https://lore.kernel.org/all/20240322175210.124416-1-laura.nao@collabora.com/
---
 arch/x86/kernel/cpu/topology_amd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 79a85a4..7f999ae 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -121,13 +121,13 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
 
 static bool parse_fam10h_node_id(struct topo_scan *tscan)
 {
-	struct {
-		union {
+	union {
+		struct {
 			u64	node_id		:  3,
 				nodes_per_pkg	:  3,
 				unused		: 58;
-			u64	msr;
 		};
+		u64		msr;
 	} nid;
 
 	if (!boot_cpu_has(X86_FEATURE_NODEID_MSR))

