Return-Path: <linux-kernel+bounces-166394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0835D8B9A05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE461F220D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3E83A11;
	Thu,  2 May 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EsI0OW04";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJUkxcyE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9069D31;
	Thu,  2 May 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649179; cv=none; b=l3OSvv2v9omApD1QtfJcvSKSkebGq2IPWErdZfTE9jx10ueQMaJRXsotuQaoZI/bf3wLIQIDvfWZU1vHdApOa8b0Q+7xsuNA3N8judO/tF+LORliahDEbo6pAJph1BSqTd+hRJUd4+ljKGiPXjiA9qcEg3mA0tVIqpI43rZ2NXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649179; c=relaxed/simple;
	bh=T6CcwhpXFNNKavNM+yKk5DB8lKbdEXx+terPWIvGdQA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UW3KKM3db3S7+OV44jqzdfxLkBsmtoggobY5fbMt67sQnb4vjoVUxcpSh+L09DfIaiIY1m6XjuOcn4B0QvJSYpRvfH4//bwD6I0WY8HyMVRvlMWJkda+OAq6qw2OGkkqsR2t6u/UjsGYtnRaHOjj+bXuP313r9Lw84PQ40XIrFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EsI0OW04; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJUkxcyE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 02 May 2024 11:26:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714649173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87fpMxVx7XU/350mhvHSVdldTHNVH4wNKKTHafQ/Xik=;
	b=EsI0OW04UWjRT5quHU3Lq2i9YvSxkg8FyqdGrKmcSHxhdoM+RNKc284cQ9rgm6RM9nA2sg
	xryRkhzlrPAZ7W+zT2PVM0LTT0eOxpMCvyD6XJJTBaDO/r4qcS5EkNErtqGAi2EY2j5szA
	ebdCmmUk2xk8aA/jifdQ/Ld+fQ57qvFSaflgkIQjX1OgV2F39Rh9Rm9gvRBFNk+gAKSnQj
	FZwW7mmtMRBizFP4LBDPmGT4LOpT211jg+GTKxl3gpmzDas7jb8TNZV1vlYcE+ZtX6aoiQ
	/rauslC8AYo74fOKII69JeicoYoebMqg281sALhHnGStHThuvTVgmhqLF22M1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714649173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87fpMxVx7XU/350mhvHSVdldTHNVH4wNKKTHafQ/Xik=;
	b=eJUkxcyEVwuis+/OPWWn1hbQIgDSMs0GxpoYXHk4ujVvdIqEHkxoizQhbWJvvK3rkwFZ2R
	w/8YYONSj3q2CZCQ==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/insn: Add VEX versions of VPDPBUSD, VPDPBUSDS,
 VPDPWSSD and VPDPWSSDS
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240502105853.5338-4-adrian.hunter@intel.com>
References: <20240502105853.5338-4-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171464917291.10875.9948863668377147054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b8000264348979b60dbe479255570a40e1b3a097
Gitweb:        https://git.kernel.org/tip/b8000264348979b60dbe479255570a40e1b3a097
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 May 2024 13:58:46 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 02 May 2024 13:13:42 +02:00

x86/insn: Add VEX versions of VPDPBUSD, VPDPBUSDS, VPDPWSSD and VPDPWSSDS

The x86 instruction decoder is used not only for decoding kernel
instructions. It is also used by perf uprobes (user space probes) and by
perf tools Intel Processor Trace decoding. Consequently, it needs to
support instructions executed by user space also.

Intel Architecture Instruction Set Extensions and Future Features manual
number 319433-044 of May 2021, documented VEX versions of instructions
VPDPBUSD, VPDPBUSDS, VPDPWSSD and VPDPWSSDS, but the opcode map has them
listed as EVEX only.

Remove EVEX-only (ev) annotation from instructions VPDPBUSD, VPDPBUSDS,
VPDPWSSD and VPDPWSSDS, which allows them to be decoded with either a VEX
or EVEX prefix.

Fixes: 0153d98f2dd6 ("x86/insn: Add misc instructions to x86 instruction decoder")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240502105853.5338-4-adrian.hunter@intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 8 ++++----
 tools/arch/x86/lib/x86-opcode-map.txt | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 4ea2e6a..24941b9 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -698,10 +698,10 @@ AVXcode: 2
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
 4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-50: vpdpbusd Vx,Hx,Wx (66),(ev)
-51: vpdpbusds Vx,Hx,Wx (66),(ev)
-52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66),(ev) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
-53: vpdpwssds Vx,Hx,Wx (66),(ev) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
+50: vpdpbusd Vx,Hx,Wx (66)
+51: vpdpbusds Vx,Hx,Wx (66)
+52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
+53: vpdpwssds Vx,Hx,Wx (66) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
 54: vpopcntb/w Vx,Wx (66),(ev)
 55: vpopcntd/q Vx,Wx (66),(ev)
 58: vpbroadcastd Vx,Wx (66),(v)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 4ea2e6a..24941b9 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -698,10 +698,10 @@ AVXcode: 2
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
 4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-50: vpdpbusd Vx,Hx,Wx (66),(ev)
-51: vpdpbusds Vx,Hx,Wx (66),(ev)
-52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66),(ev) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
-53: vpdpwssds Vx,Hx,Wx (66),(ev) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
+50: vpdpbusd Vx,Hx,Wx (66)
+51: vpdpbusds Vx,Hx,Wx (66)
+52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
+53: vpdpwssds Vx,Hx,Wx (66) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
 54: vpopcntb/w Vx,Wx (66),(ev)
 55: vpopcntd/q Vx,Wx (66),(ev)
 58: vpbroadcastd Vx,Wx (66),(v)

