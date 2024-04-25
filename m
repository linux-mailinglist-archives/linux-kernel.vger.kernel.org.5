Return-Path: <linux-kernel+bounces-158953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBEF8B2748
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1854CB23381
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D021514FA;
	Thu, 25 Apr 2024 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yNnF8av7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PinOisYW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A914E2F8;
	Thu, 25 Apr 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065044; cv=none; b=nbyMD4+4fLOwJcUfa6ke9jSBm+oinTTF8+oUP7XSOk93bF00qEYgp7MXpy9GgYvleEopRXE6roUBg011MDMUbGzUIIKTsWiAXnJC+Y65hzjjHxS22QmJxE9SwYZ3dUg3Ar3LbZbbc/zylxcaAHR50xxvHyJ/KZVar2gnszSy4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065044; c=relaxed/simple;
	bh=6MbGMOujy+tiqHsWvUKDC4jXi0u6ocHC+SQfYEKODMs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=iOAynFeBYzKG7BSSRHnUqJ6Fn6LhBwkLIXoCPu2KopgTyJ6fP8Yr+xpo0Y+Z3GqdCodgFolduadRwZ7OfKktKnblEgFkMWajJZs3FbZq+7Dje7nN2OifEl38gWBJkWYhOAaYltycFuWocyXkp2WSJTpPDXd4S0RLlxSU2Lksdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yNnF8av7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PinOisYW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 17:10:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714065037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uv9cuuEliL13TRce8JcOpWFtAIXuxAJG8J8BE8Vx0S4=;
	b=yNnF8av7EWDD/c7tgDlPbQcSYhYHb0DLcMLyL1Wou0Y3X913Efp+jRS0eQNRLkL3abjQKP
	hKY4ty7jY6C5TBNV5yyYQS63rocuNfKUHpYjlg9yeBTOEwrSl06+neZiSrRPikbP5ziyj+
	bE1WxJRFamwnr/2spmn/WQtByGCCb8595ihOn5kpOjUMbvS4LqMOHe8ZRCQdm+p0BS/NqD
	BHzlbkSQaaQ+8KUqrbGxPuUI01RPeHgECJPkX8ezvAF+9jIaiKGmzh5MivGLHDoCinY1VS
	4KXbT3MxMhhlAklt3EmKovtyeARo/94A+cps1yk7cKDqMqMNTHGHAzx4MVGjyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714065037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uv9cuuEliL13TRce8JcOpWFtAIXuxAJG8J8BE8Vx0S4=;
	b=PinOisYWBT2ZolqDUkpMJr5LdkLnCh/x4jCbpaC0y/iw5N5TXrVfI6qLpInAJKn/2qxtnN
	deNLrsk7SDrC7yCQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] perf/x86/intel/cstate: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171406503691.10875.7504488684211839663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     5ee800945a3466c3b126020c8f4ffc6b54d6986f
Gitweb:        https://git.kernel.org/tip/5ee800945a3466c3b126020c8f4ffc6b54d6986f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:14:59 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 25 Apr 2024 09:04:32 -07:00

perf/x86/intel/cstate: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181459.41500-1-tony.luck%40intel.com
---
 arch/x86/events/intel/cstate.c | 144 ++++++++++++++++----------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 326c8cd..54eb142 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -696,78 +696,78 @@ static const struct cstate_model srf_cstates __initconst = {
 
 
 static const struct x86_cpu_id intel_cstates_match[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&nhm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&nhm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		&nhm_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,		&nhm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,		&nhm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,		&nhm_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&snb_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&snb_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&snb_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&hswult_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&slm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	&slm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&slm_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&snb_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&snb_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&hswult_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&hswult_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&hswult_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&hswult_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&cnl_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&knl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&knl_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	&srf_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	&grr_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&icx_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&icx_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	&icx_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	&icx_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_NEHALEM,		&nhm_cstates),
+	X86_MATCH_VFM(INTEL_NEHALEM_EP,		&nhm_cstates),
+	X86_MATCH_VFM(INTEL_NEHALEM_EX,		&nhm_cstates),
+
+	X86_MATCH_VFM(INTEL_WESTMERE,		&nhm_cstates),
+	X86_MATCH_VFM(INTEL_WESTMERE_EP,	&nhm_cstates),
+	X86_MATCH_VFM(INTEL_WESTMERE_EX,	&nhm_cstates),
+
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,	&snb_cstates),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&snb_cstates),
+
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&snb_cstates),
+
+	X86_MATCH_VFM(INTEL_HASWELL,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		&snb_cstates),
+
+	X86_MATCH_VFM(INTEL_HASWELL_L,		&hswult_cstates),
+
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&slm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_D,	&slm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&slm_cstates),
+
+	X86_MATCH_VFM(INTEL_BROADWELL,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&snb_cstates),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	&snb_cstates),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&snb_cstates),
+
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		&snb_cstates),
+
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&hswult_cstates),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&hswult_cstates),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&hswult_cstates),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&hswult_cstates),
+
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&cnl_cstates),
+
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&knl_cstates),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&knl_cstates),
+
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&srf_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&grr_cstates),
+
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&icl_cstates),
+	X86_MATCH_VFM(INTEL_ICELAKE,		&icl_cstates),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		&icx_cstates),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		&icx_cstates),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&icx_cstates),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&icx_cstates),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&icx_cstates),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	&icx_cstates),
+
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&icl_cstates),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		&icl_cstates),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		&icl_cstates),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		&adl_cstates),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&adl_cstates),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_METEORLAKE,		&adl_cstates),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);

