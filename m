Return-Path: <linux-kernel+bounces-33975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB983712F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A322287A69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B64A9AF;
	Mon, 22 Jan 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V75w95Cg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F5E4A9A9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947711; cv=none; b=Z7oOMFsKOiO/nGDvfwDngdf1oEjL0xXP4fFZdyH2pGM3vNHrbKekmErucCRZyjs+Q2/2AvITk/ZHgBdJnOg7qc0d4rV6/jJmDZkpCKcxY0ckE2nzaHhRRRPjoZ7Kxq6d3ny/f9UPt59grf4oHmMdkD6lDPpeum4RcD10M1fbOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947711; c=relaxed/simple;
	bh=5CwBINpwIZ1I1d44NZjFZQKvYM/hTAqqoE/+9rbtQeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBQVXdnf/hJs6gf6AbwNyw9i0Tnp7lAD2hjdWm1o7NiOxr8fPLiWD/bgI6D9xodmKot+dWcuNpQ6cRTSzmRrOGq0+QJKzTBupUARNqPiVdPfDeiaN/BWOu2/N0cXbD054JVxP8VKX+ikfw4x8BlORaZJjfOywZafAT2WZ1Q8O6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V75w95Cg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0D31840E0196;
	Mon, 22 Jan 2024 18:21:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id catqAuf140-i; Mon, 22 Jan 2024 18:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705947704; bh=Ea4MnZg3naLyJOTRFGD9v/aFCpyGZVJ7QpiMOtY7j9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V75w95Cg41NPBBKBnK5VKZXFGQZPcONR8+KNJly1sd5XPFe9zprDKc8R9QFGM3lRD
	 6J/ep1tjOYTGXp1ImX7DfllbnEFTFe6vUsLYke8iJiRdb55HQDVF6ZrP7979qXS3Mv
	 FkMNAshvi02OH104ahkE8UT8J0+9vHw5t5VHC23px1nVNRiTkhiqUSmkV8z50n/aRu
	 OdMwZvFplQMl1HuLCfvaT59S72GDqwNP9Yjn5ExujphNpCFfkSfldn0UzXv0A3hTDZ
	 wRxqA4g5X3XGkkygZXyaTCp2jJGh0Bu/jVxE7nkUjjaHDOhh2l5Po/PeKXHHUZ3n8n
	 hzhbmIsyyLmd/3yXo8tlM2QeaC7DmTqR4D2RrSEynJyslpf2UCPavHUaOt49PJeyRI
	 uMEBYR4RqmbggMHUUeCdgdHfjB5Qe7IffipErXqQkAlMjFhOMX1hbVw+/ktMUp+0Ms
	 9gcN1xwR69nppqgFPo8K+kkuEcCSknSyEChNX5U+xmHqGchnU2AJjbVtBkxVkc5TT7
	 vdDIAZvdx9IDkqQq9GBl+2cFGL3D6WLKDDcTN8rp3zQHXfiqbEX8RmumYfkPNy7ju8
	 WFTTPyuUfvtcC2JSJGsqglMAgJXS0NW74CqKmA/8EyrPZtOcSFtuoHQbIU2iEPCaEQ
	 ATp17NNYNouF1NKkD1HAWr14=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58B6040E01B4;
	Mon, 22 Jan 2024 18:21:33 +0000 (UTC)
Date: Mon, 22 Jan 2024 19:21:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	"Shen, Xiaochen" <xiaochen.shen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Message-ID: <20240122182121.GBZa6yIYPtHQx44EU9@fat_crate.local>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240118214213.59596-1-tony.luck@intel.com>
 <45d2891e-989a-45c9-a527-8b14ff5f8748@intel.com>
 <SJ1PR11MB60837D4884419BDC2DCAA2D2FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <bfa5104f-b887-4cc4-a24c-0497b86d9dde@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfa5104f-b887-4cc4-a24c-0497b86d9dde@intel.com>

On Mon, Jan 22, 2024 at 10:18:01AM -0800, Reinette Chatre wrote:
> The fixes I have as pending are:
> 
> [PATCH v2] x86/resctrl: Fix unused variable warning in cache_alloc_hsw_probe()
> 	https://lore.kernel.org/lkml/ZULCd%2FTGJL9Dmncf@agluck-desk3/
> 
> [PATCH v5 1/2] x86/resctrl: Remove hard-coded memory bandwidth limit
> 	https://lore.kernel.org/lkml/c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com/
> 
> [PATCH v5 2/2] x86/resctrl: Read supported bandwidth sources using CPUID command
> 	https://lore.kernel.org/lkml/669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com/
> 
> [PATCH v3] x86/resctrl: Implement new mba_MBps throttling heuristic
> 	https://lore.kernel.org/lkml/20240122180807.70518-1-tony.luck@intel.com/

Is that the order I should start queueing them in?

If not, pls send me a note and I can start picking up stuff.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

