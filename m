Return-Path: <linux-kernel+bounces-34038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E120A837239
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4581C2A6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F04B5D2;
	Mon, 22 Jan 2024 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sNyIdv99";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VBufSsvk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540D4B5BA;
	Mon, 22 Jan 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950431; cv=none; b=cee6HRWtossOLyWEZ96cVIRMODH4WT+vRNYlxZcm4NLVG0JXYdTQk1MQ82ZE9bYFTscrqsNihREmZdKbfg+wRJnsfXKSoQxkGJ7pvhz5jBESA+OZZVlPKdM1Vu/BDmQECcXX5HVFv/jVxCLy1yKvPCfJbCl6+5R+L/gUudA6/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950431; c=relaxed/simple;
	bh=PRh9dwBF31NtpVfZmzoRaCu2sQRo38CzZ3BHMdCkcTs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pwJIr145tKASPzgwxgZIkTp8w3IVwdgqwv7XHDTDI9loW8XAIYP9W5KyHDaa3+JmPCfayqa/f4tzs/mI0hU9o7+d6n2mqz18jKCRetVIRkMt20IZeCTosFdDPzXIWE2yc8n3os0jI0uLQ0/LA4Yptc06hhF64qZJzYcuJo62zxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sNyIdv99; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VBufSsvk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jan 2024 19:07:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705950422;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LEUs35sDeIr6Y5L91RFWmBlsM22sW9iX8+nznOQvIw=;
	b=sNyIdv99QBAM7nTNMJhn/yG/FUUIuT/Gg+jcnW6kxekn7ne0hm2SmQDQkb1BrlkC269jEF
	jaLDv9DEDXiREu0L2cyxDiELPSmNu18TVbFFDLZ1gbEiynlvBWIhL9L4f2teEnr9+Xj/p8
	DT2erHOIc2i3Pb9/zDaw5e4ZlAscLZEHnruIwGiTLcumapgsp2Ax5sRTYSXpLmBZkhO9Xk
	eYRTmDnATELQ7KYGWHsP0JPObJ2XZGZkUfMzG3bL6df51TgjM+SyxBSFKYKM5IexSscJ6N
	CNj7Z6BHzIaXlVar5t4zIuIRjq35o986fG6O/UuppH9KV4YSBXRyXNP2FWDgbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705950422;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LEUs35sDeIr6Y5L91RFWmBlsM22sW9iX8+nznOQvIw=;
	b=VBufSsvko8u43KhyCj+lYOT6yC0ib2ciYwMzjnHBdpoxUhThJqS5V3UD2ArYTEZSkIf8SI
	bcKurI7rS9AzSwAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Babu Moger <babu.moger@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <TGJL9Dmncf@agluck-desk3>
References: <TGJL9Dmncf@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170595042118.398.14799564036429215323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     1b908debf53ff3cf0e43e0fa51e7319a23518e6c
Gitweb:        https://git.kernel.org/tip/1b908debf53ff3cf0e43e0fa51e7319a235=
18e6c
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 01 Nov 2023 14:26:15 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 22 Jan 2024 19:54:54 +01:00

x86/resctrl: Fix unused variable warning in cache_alloc_hsw_probe()

In a "W=3D1" build gcc throws a warning:

  arch/x86/kernel/cpu/resctrl/core.c: In function =E2=80=98cache_alloc_hsw_pr=
obe=E2=80=99:
  arch/x86/kernel/cpu/resctrl/core.c:139:16: warning: variable =E2=80=98h=E2=
=80=99 set but not used

Switch from wrmsr_safe() to wrmsrl_safe(), and from rdmsr() to rdmsrl()
using a single u64 argument for the MSR value instead of the pair of u32
for the high and low halves.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/ZULCd/TGJL9Dmncf@agluck-desk3
---
 arch/x86/kernel/cpu/resctrl/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 19e0681..d29ebe3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -136,15 +136,15 @@ static inline void cache_alloc_hsw_probe(void)
 {
 	struct rdt_hw_resource *hw_res =3D &rdt_resources_all[RDT_RESOURCE_L3];
 	struct rdt_resource *r  =3D &hw_res->r_resctrl;
-	u32 l, h, max_cbm =3D BIT_MASK(20) - 1;
+	u64 max_cbm =3D BIT_ULL_MASK(20) - 1, l3_cbm_0;
=20
-	if (wrmsr_safe(MSR_IA32_L3_CBM_BASE, max_cbm, 0))
+	if (wrmsrl_safe(MSR_IA32_L3_CBM_BASE, max_cbm))
 		return;
=20
-	rdmsr(MSR_IA32_L3_CBM_BASE, l, h);
+	rdmsrl(MSR_IA32_L3_CBM_BASE, l3_cbm_0);
=20
 	/* If all the bits were set in MSR, return success */
-	if (l !=3D max_cbm)
+	if (l3_cbm_0 !=3D max_cbm)
 		return;
=20
 	hw_res->num_closid =3D 4;

