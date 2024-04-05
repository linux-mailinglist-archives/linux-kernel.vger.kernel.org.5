Return-Path: <linux-kernel+bounces-132999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B5899D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1DFEB241BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24FD16D303;
	Fri,  5 Apr 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lEuSHVAI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lEuSHVAI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B416D321
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320486; cv=none; b=KDzk015i1V0xgNy+ZLkVouq8GCsqVCK384KsY/joIxRhOSsc/Td3WTelEB2QuGHAD+vR+eZHbR4Tl+PTPSTvr2TxrjM0FldF79hn3rmn2Rgb7TyMN2QfMlVTVkWIRb/9Vd6pqba9azVLTvHUBwMyzumsjkFdMX+KavK+2xuHqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320486; c=relaxed/simple;
	bh=yaS5FbovQH9/Auz/WAqnBZgj/Sj2LwFyQC3zGZWmp24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLVSO6AkvTns8p8NbiEVBJrQ8eSKWubzbOJyD4DYz5fH/y7rKHagYIcZ2Vj1m3gTooLEwUKMMFXw4GDYQieAplgYC6SXpKxhDGvp6AmTpRJrIZU9w8xd8XTdsHzETo8pc+pe03RVELrvRAVCUjLcBlxcvnxVU7Kkxdua3Kyr3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lEuSHVAI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lEuSHVAI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9114121A3D;
	Fri,  5 Apr 2024 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712320482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdgprpQ24t5nWyEyGzsG9noWxLeH6m4PgtqIZBKgW8o=;
	b=lEuSHVAIBU6dCMAXHOCGccMqXxdUd0Wjmctmk27IlNyLpPiDPbp8ck74aZiMEns6kDvoM2
	xHYkVofeqi3pCDiIXeEKCZw8byMXwtO+vyBLTYsDddlJ9z+FIumeMvTMdau3P24Y4spx+z
	ou3mjOc0A9xcWpYqMdU1Tm9Zcsin+iA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712320482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdgprpQ24t5nWyEyGzsG9noWxLeH6m4PgtqIZBKgW8o=;
	b=lEuSHVAIBU6dCMAXHOCGccMqXxdUd0Wjmctmk27IlNyLpPiDPbp8ck74aZiMEns6kDvoM2
	xHYkVofeqi3pCDiIXeEKCZw8byMXwtO+vyBLTYsDddlJ9z+FIumeMvTMdau3P24Y4spx+z
	ou3mjOc0A9xcWpYqMdU1Tm9Zcsin+iA=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E871139E8;
	Fri,  5 Apr 2024 12:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QLOLEeLvD2aVGgAAn2gu4w
	(envelope-from <jgross@suse.com>); Fri, 05 Apr 2024 12:34:42 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/cpu: fix BSP detection when running as Xen PV guest
Date: Fri,  5 Apr 2024 14:34:33 +0200
Message-Id: <20240405123434.24822-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240405123434.24822-1-jgross@suse.com>
References: <20240405123434.24822-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.40
X-Spam-Level: 
X-Spamd-Result: default: False [-5.40 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-1.60)[92.42%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

When booting as a Xen PV guest the boot processor isn't detected
correctly and the following message is shown:

  CPU topo: Boot CPU APIC ID not the first enumerated APIC ID: 0 > 1

Additionally this results in one CPU being ignored.

Fix that by calling the BSP detection logic when registering the boot
CPU's APIC, too.

Fixes: 5c5682b9f87a ("x86/cpu: Detect real BSP on crash kernels")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/cpu/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index aaca8d235dc2..23c3db5e6396 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -255,7 +255,7 @@ void __init topology_register_boot_apic(u32 apic_id)
 	WARN_ON_ONCE(topo_info.boot_cpu_apic_id != BAD_APICID);
 
 	topo_info.boot_cpu_apic_id = apic_id;
-	topo_register_apic(apic_id, CPU_ACPIID_INVALID, true);
+	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 }
 
 /**
-- 
2.35.3


