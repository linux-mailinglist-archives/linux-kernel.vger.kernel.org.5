Return-Path: <linux-kernel+bounces-97831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAF87701D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EBD281EB9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42F6381CC;
	Sat,  9 Mar 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TtNOuUnH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED825753;
	Sat,  9 Mar 2024 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709977637; cv=none; b=YWC4MpKEajRaOodbEqsNxY3klvazUJGfB8vbZNjfwIbPP9oIcEv3VHFdTyo3T6MfOCdYZdMT0BD2Nc9fCPrQ0baD35zo91GlmAWlAE6Y0duWUS7As6wSOasOIvpNexSlOfWxHEc6xhyqfSRixncmpr4dkoPAiwt5prl3Hq0S+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709977637; c=relaxed/simple;
	bh=8S4GFzaUJHNg2/WWALOLoslf/3xIAy84IF8wP1HxgP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4mhHEWpR5jWNh+FqQTmWAbaJTfe6AIxW7rUw2wneEL/O8Xp3aJY5T6ziGUktsyvpUmCO8MH+cDuQKVI43vU5C46t+ADmiMhbUhVKSOmkSIk/mt/zandxU82HsPVsVEjGuTUxFoO9JcgL0AZ16dPJop4nes5K/Z0sNSEZaiIpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TtNOuUnH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 08C5A40E0185;
	Sat,  9 Mar 2024 09:47:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UK9Ug4byV7Cy; Sat,  9 Mar 2024 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709977628; bh=Xg4pJSiMmCpObnqE7m8qOc6nGo6ypCyaFUcMIKmd5Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtNOuUnHswA2QlZ8Xoo1IMaUy3mlWBc0xc9PogzYypz2myUHYwTlf+60RWHoULhPA
	 ta/0ioRUrq2NDtKaglMdbqV+u22ml2/jbVAvYfuI7x0jubK7UAgsdm5r6b9imQ/Hzk
	 2/iUy42Qb961ZXmhwguWNxAbPZSmQeZ9A/q5CSGCQedQXUhxulDvxoY4WZEiari1US
	 0gSCW0e4u4KaCcVbx9TCvHgn7H3bNwOaA1vJ2uvJ5MH20xgNQFCiGckMf8ogcqh7dt
	 vPV5jvHjbhkpv2O+yoIU85nMoFaE8zWhTWEvIWuy8XQx9X5+mKMq1ZJfkxOZAG3Iqw
	 wHUAWsKxht/yqladKv5GbtbIlhmVKujdSLYcrG/slB/riSBXfvyzLAy5F0sGpK6YmS
	 kYdkVfMZyX5cdoH3S/582z2hlRq+DNW4eM9GLy901oBFPGTxoT7fEXLByhbB8n6hA/
	 mcSzCTkbfB020MOA7kl6qUNaeQUGB6pbJAJgFjhiMuxMUbLYioQGgsqjnr6E8bw9Mt
	 /IfJbcOPEq9JOPJgBhwVN5qPWmt2BfwP/wrB+30oOkMqhUn2536bfh3ZTNPC7jT/XK
	 Rpiq0tiQoApVslvNcbPObWazppYyA//WitjxqLGcKAyvAmbEkEBrCL/aCDxso2WjVo
	 99ivT3VKd6fxGRMCiXgLYUfs=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB17A40E0173;
	Sat,  9 Mar 2024 09:46:58 +0000 (UTC)
Date: Sat, 9 Mar 2024 10:46:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the edac tree
Message-ID: <20240309094651.GAZewwC3u3U7DhXBdo@fat_crate.local>
References: <20240227134352.6deda860@canb.auug.org.au>
 <e367a4ad-3431-4cf8-9c0c-1205e00b907c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e367a4ad-3431-4cf8-9c0c-1205e00b907c@amd.com>

On Fri, Mar 08, 2024 at 05:43:26PM -0500, Yazen Ghannam wrote:
> > diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> > index 08c6dbd44c62..65a0ab651ee2 100644
> > --- a/drivers/ras/amd/atl/umc.c
> > +++ b/drivers/ras/amd/atl/umc.c
> > @@ -315,7 +315,7 @@ static u8 get_die_id(struct atl_err *err)
> >   	 * For CPUs, this is the AMD Node ID modulo the number
> >   	 * of AMD Nodes per socket.
> >   	 */
> > -	return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
> > +	return topology_die_id(err->cpu) % topology_amd_nodes_per_pkg();
> 
> "topology_die_id -> topology_amd_node_id" is also needed.

Are you saying topology_die_id() was already wrong?

Because even before the topo rewrite, this was

  - cpuinfo_x86.topo.die_id:

    The physical ID of the die. This information is retrieved via CPUID.

while this code talks about the AMD node thing.

> Does this need to be fixed up in the RAS tree?

I'll give a diff to Linus when I send the pull request.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

