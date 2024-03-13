Return-Path: <linux-kernel+bounces-101338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40587A5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684C4282B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8673BB33;
	Wed, 13 Mar 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yBapKqPQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PfXDcVcX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286523AC16;
	Wed, 13 Mar 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325361; cv=none; b=QTbNA0myKlMj5RoXfH8m/7rdyWnjbnkmAIVHK5yZzKDB7DjqabVpv0UWGF5fdZ/mWERBiDBTTW/nCD8OyQwTHSHb6WZTvvYlLUwBr8WpJRBdBYQ1gTZDvuoTdsOFP54X2Cl/T7h9pRnurrbWuxbha9jESHEmACGMyefAUqVKkdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325361; c=relaxed/simple;
	bh=sFfSZfnPrnmtWgEdxudp7DxQTYy/1ZbQQVvKKCQx+74=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MqPtfRoFHBSXXqRiRIiC9qc6W3ThWKd18OG+rfKd5flWke195EE7WKaCA4gonks2Uv7iTv0fisH6ZEeD3zljKBcLZu2T1rOjL3XqdOBwyPzNfvSxrbLxjwEsqZP4oZc7PWxT0Mum8DkKh/RJ2OMiqMZX50LzB1wi91VnSWwUPew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yBapKqPQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PfXDcVcX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 10:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710325358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Yk7qDMn+1Xb0f6DQG5+5LLC7rR5uLbKjcnR9tq6A28=;
	b=yBapKqPQN7YNqYAhPDq7WbeVxZD4G+QFeV81goEbD26pykhp2FMxutYnZ31BDycasET2G1
	CmVd5QBsvRK17o79XozNkcD2X437ccrFrJGuoIED3022BDsTk5Wt2u1iX0LU0NnMJdehH7
	pRrKu1RTAmhluNZUAhtlr6+9FFsPIsZSnxGiu8TGsgXpF/jBsVXw1K5bzmqQyVtYjQUB4e
	qd887kLe+tL1Bk8K4b0l3m/qU7hFthQqA3WuNiv5zyWhBW84lmK2WVlw3N69AHAS6/zbH3
	awcuwuY1ZVC6GazekQCpRB07AzWA02C6o8Q4LlB3sSThNKnjGMP2fGQtyFpI9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710325358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Yk7qDMn+1Xb0f6DQG5+5LLC7rR5uLbKjcnR9tq6A28=;
	b=PfXDcVcXqCoaZQgSyW8T1nC7UyGjRBqwQMVABprqX4uv8kSt4vfwew0a6p8ELhXj2WtOtS
	h99ji3ORd+JWbKAg==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/lbr: Discard erroneous branch entries
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C3ad2aa305f7396d41a40e3f054f740d464b16b7f=2E17065?=
 =?utf-8?q?26029=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C3ad2aa305f7396d41a40e3f054f740d464b16b7f=2E170652?=
 =?utf-8?q?6029=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171032535764.398.4968779200381631373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     29297ffffb0bf388778bd4b581a43cee6929ae65
Gitweb:        https://git.kernel.org/tip/29297ffffb0bf388778bd4b581a43cee6929ae65
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Mon, 29 Jan 2024 16:36:25 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Mar 2024 11:01:30 +01:00

perf/x86/amd/lbr: Discard erroneous branch entries

The Revision Guide for AMD Family 19h Model 10-1Fh processors declares
Erratum 1452 which states that non-branch entries may erroneously be
recorded in the Last Branch Record (LBR) stack with the valid and
spec bits set.

Such entries can be recognized by inspecting bit 61 of the corresponding
LastBranchStackToIp register. This bit is currently reserved but if found
to be set, the associated branch entry should be discarded.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://bugzilla.kernel.org/attachment.cgi?id=305518
Link: https://lore.kernel.org/r/3ad2aa305f7396d41a40e3f054f740d464b16b7f.1706526029.git.sandipan.das@amd.com
---
 arch/x86/events/amd/lbr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index eb31f85..4a1e600 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -173,9 +173,11 @@ void amd_pmu_lbr_read(void)
 
 		/*
 		 * Check if a branch has been logged; if valid = 0, spec = 0
-		 * then no branch was recorded
+		 * then no branch was recorded; if reserved = 1 then an
+		 * erroneous branch was recorded (see Erratum 1452)
 		 */
-		if (!entry.to.split.valid && !entry.to.split.spec)
+		if ((!entry.to.split.valid && !entry.to.split.spec) ||
+		    entry.to.split.reserved)
 			continue;
 
 		perf_clear_branch_entry_bitfields(br + out);

