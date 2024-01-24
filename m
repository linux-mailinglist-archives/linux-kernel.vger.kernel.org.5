Return-Path: <linux-kernel+bounces-37582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B983B1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7B51C2168F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F00131E4C;
	Wed, 24 Jan 2024 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a1KcDgtJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6BF77F36;
	Wed, 24 Jan 2024 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123720; cv=none; b=qFwbHruDHpmU1lEJpl3nBXnBS8zw2p2AkOA7d3EU5cCzvRWvfnlKASOjf3J05pOksTYU9Y9AHUnm+ZCpYZ/QkP1yk71r8I7GdvaTWFWM3u4TI1EEx7j3t/q/cnxLFLpGttx2Kx6Zbd9NFCh18VRAeMj4M/nk3H1rbmxAMIa7KbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123720; c=relaxed/simple;
	bh=VcHlyJIXlxH3aERAxZ/QM+6SquAmwdoVRQMgH+M+Ow4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdvWL5Wxv07H3fiY30Zx261G7lWVeXjdK/BZBo1mbN34LPype4aI2YjZ5NZQgZUffywa1Qr6GfWUvKy49ZZlRpSztw4j3Ho7BvP/FXmlnkk9iIrrt9X3LGL6vY4uX/1bB2AOUFr68rq0j7z+trefxSm6w/b1WrrG/JNrCs8c/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a1KcDgtJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6DE7C40E01A9;
	Wed, 24 Jan 2024 19:15:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Q8rzXvTGYIO5; Wed, 24 Jan 2024 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706123711; bh=2krLzEMQIQ+tFkjdyDir4TC8HQgYTlc8+l+XGa7jNp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1KcDgtJDEo2ovI49n8md2R/fKXHf09N0P/AWKrEpVFzp3oZzfzQD5+rZPuaPdqju
	 LtI2YkBwx4DtZ2FDC3gg/1Rot4+lHTlH3yzQfpVm6plm6KfbhTXCLhDdWngAMoInzc
	 NvcEb2G3sx49+72RjdaBPsa+phyNdlFW6mfRRqwpf0aEAC2OaqnMwGMI7SF4cgLwzd
	 8mivnFvGsYm3kI5DyM5RBeL/Oy+bGfwhS/94Zxj1nwvkk82Z+j5x16nZvAYXZmMBXa
	 gmGz674ObX+9e6eUbe0ga7RrX0/bPh9Uy+mxbqiiQvTGwky0GD69ygSbDDSATyyLWR
	 fGIzOgsZkqG8TY9rsLBd9boK5ZozTqG/7H+yfyqy8mBmSbbdflXeLSa5Dpg6Km3vdi
	 Ssx240vV9yrnczi2f+jgFt0KO12jk6a8sIz0+FxnC/9XlxH+F+zF2yC1u48yhgA0TZ
	 yZ0ILGhTrQMvtAhu6kxNWxSwcF32l8GCzy+hVPBJwZt4cCZ/SKymbQo9fsgz4qYmtZ
	 mXI+byFxGGZzV7qtrDtw4sEMW2p7DmVkv94t8SLxsizHWU71vPpF2jhBj5Necrc3SA
	 jUW0Op06airRtlY16D/vwqwNgbsiGrcAZd2BYBw/D2K3+DuQkS+eIbI5VJRE14U18Z
	 WzjEKLu+DggB4qP30LEpAHQQ=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFBD840E0177;
	Wed, 24 Jan 2024 19:14:36 +0000 (UTC)
Date: Wed, 24 Jan 2024 20:14:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
	yanjiewtw@gmail.com, kim.phillips@amd.com, lukas.bulwahn@gmail.com,
	seanjc@google.com, jmattson@google.com, leitao@debian.org,
	jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	peternewman@google.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Message-ID: <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>

On Wed, Jan 24, 2024 at 10:51:49AM -0800, Reinette Chatre wrote:
> Thank you very much. For what it is worth, I do agree with the actual fix
> and you can add:
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Ok, have a look at the below, pls, and lemme know if that's ok too.

mbm_config_write_domain() only returns 0 so it can be void. So the
callsite doesn't need to check retval either.

Thx.

---
From: Babu Moger <babu.moger@amd.com>
Date: Wed, 24 Jan 2024 11:52:56 -0600
Subject: [PATCH] x86/resctrl: Remove redundant variable in
 mbm_config_write_domain()

The kernel test robot reported the following warning after

  54e35eb8611c ("x86/resctrl: Read supported bandwidth sources from CPUID").

even though the issue is present even in the original patch which added
this function

  92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")

  $ make C=1 CHECK=scripts/coccicheck arch/x86/kernel/cpu/resctrl/rdtgroup.o
  ...
  arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "0" on line 1655

Remove the local variable 'ret'.

  [ bp: Massage commit message, make mbm_config_write_domain() void. ]

Fixes: 92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")
Closes: https://lore.kernel.org/oe-kbuild-all/202401241810.jbd8Ipa1-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/202401241810.jbd8Ipa1-lkp@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2b69e560b05f..c33eb77b6d70 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1614,11 +1614,10 @@ static void mon_event_config_write(void *info)
 	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
 }
 
-static int mbm_config_write_domain(struct rdt_resource *r,
+static void mbm_config_write_domain(struct rdt_resource *r,
 				   struct rdt_domain *d, u32 evtid, u32 val)
 {
 	struct mon_config_info mon_info = {0};
-	int ret = 0;
 
 	/*
 	 * Read the current config value first. If both are the same then
@@ -1627,7 +1626,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	mon_info.evtid = evtid;
 	mondata_config_read(d, &mon_info);
 	if (mon_info.mon_config == val)
-		goto out;
+		return;
 
 	mon_info.mon_config = val;
 
@@ -1650,9 +1649,6 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	 * mbm_local and mbm_total counts for all the RMIDs.
 	 */
 	resctrl_arch_reset_rmid_all(r, d);
-
-out:
-	return ret;
 }
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
@@ -1661,7 +1657,6 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
-	int ret = 0;
 
 next:
 	if (!tok || tok[0] == '\0')
@@ -1690,9 +1685,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 
 	list_for_each_entry(d, &r->domains, list) {
 		if (d->id == dom_id) {
-			ret = mbm_config_write_domain(r, d, evtid, val);
-			if (ret)
-				return -EINVAL;
+			mbm_config_write_domain(r, d, evtid, val);
 			goto next;
 		}
 	}
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

