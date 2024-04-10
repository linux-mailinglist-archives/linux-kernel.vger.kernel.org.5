Return-Path: <linux-kernel+bounces-139273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B70E8A00CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6541C2302B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78092181CE4;
	Wed, 10 Apr 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2fBz/1Hc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jD8GmCjF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA50181BBB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778334; cv=none; b=ENvpYinNE+e/OtFiRvxkzTIKZGZB0MsUUSrP0DM93sLf1uh67sX3grM3Bcl5fmJkpW2EKe2HjyP9PWd5TOgAgsejocMNvIlwn/H2KrqpCkr9dmfUwXaxo7wKLgS8XGQKbcsXj3fTq1SBWwaDLZWaMYizJd4F4fVVQjKV484N63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778334; c=relaxed/simple;
	bh=OY6SSXDr+6cHYc29dZmZxroatfwI+VSkaKDFcpsWDEc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rJnIYFm/ca6M5RWnmNtzAaevTKfmbWZBMKiQOslF7xASE0aeF4NLuiUHSeXHHrMv6rtUCYnwy/iaPCPQha9bn1UfT0T9m2hV5wonCB9YhH2kqY2memHQIRhCfRwIZdqNg7jgrj8MIZEUZpzNvPcmb0O2EnME+G46kxYhmq5D7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2fBz/1Hc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jD8GmCjF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410194311.596282919@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712778329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=va2Nll9HHzvPdob3UeD97WobBzwKGtRa6ldSxMK6EQA=;
	b=2fBz/1HcmlRoAX9UGkR4rWmfRx9uMvfqm36rpQrk250zodYoYPJyv6gV0exPnyEAe40Acu
	kLRkHKIGcp/ztiF1Zs0ArAV1RW3uDycbOIBAonDE43bsrerpmBVLLT/bsniMl3YUZ64NJl
	2O2AY5jm6K4uf7uleKBm6spBfhu6Vj9bgIVTowOdLi1q/rK5CidTdvdpl2XbELzUvLjkKu
	3teuF+v1ovhX1e0gPtWePFxONLvJb3nYzLzW1nWpT7cKERgSp7Q6djhwTRVSUGz4kr2Bm/
	y6l7NFllAzHoHyfSB6x0+LpNE/mrejXp1JqgwUGZUeXW8KZ/kBGLFbpfs9liAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712778329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=va2Nll9HHzvPdob3UeD97WobBzwKGtRa6ldSxMK6EQA=;
	b=jD8GmCjFmwEYSQPUlTNS7eOmkMeLoK47NBnEkcLtC+WmpFPvjh4OVii/KubPUgEZ8XJ4Kg
	euz9jAoitdHtMMBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Laura Nao <laura.nao@collabora.com>, x86@kernel.org,
	kernel@collabora.com, regressions@leemhuis.info,
	"regressions@lists.linux.dev" <87il0p2era.ffs@tglx.smtp.subspace.kernel.org>
Subject: [patch 2/2] x86/cpu/amd: Make the NODEID_MSR union actually work
References: <20240410161141.261818-1-laura.nao@collabora.com>
 <87il0p2era.ffs@tglx>
 <20240410194002.909839385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Apr 2024 21:45:28 +0200 (CEST)

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
Reported-by: Laura Nao <laura.nao@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology_amd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -121,13 +121,13 @@ static bool parse_8000_001e(struct topo_
 
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


