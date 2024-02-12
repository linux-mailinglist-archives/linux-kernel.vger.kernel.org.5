Return-Path: <linux-kernel+bounces-62319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5B851E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33C41C22988
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1984C63A;
	Mon, 12 Feb 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eLsIjGYl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242984B5CD;
	Mon, 12 Feb 2024 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768660; cv=none; b=GHphCRnay2O8L2mrycNUPAhuz0/NrMsKavrzpNxbdnOPKgO3C1QC97nkIj0D4gPJtfiHWNukB0xwVCdmQBySWyLWFdinWZH2bGaJBqQR0OUihpbPp5BDIWZA0yqMpr+4t7DIeXE2JnDfb6QFnqTBWfrKDm5zk1LdsoMWbLg7few=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768660; c=relaxed/simple;
	bh=UlC6Xx3GIY5LUoLp/no8oFB5sKB0dJAtxFTRj67yIac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5VTzFmAUif5OW5Mq4DIsNgUHM8qVBDo3/p2mvjZ3ojRnzutcg+fDctR90CD6OBb4/VQZ3L3SE/w2Imq6WVQsgdGaWxrS+fKYlzQp3Il3hVHL56NZgb3rMSAS5ic7DOKk8wDc9H6a9jS0qf9DaguckXwDqcxam/sx35edf+YzSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eLsIjGYl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F135A40E0192;
	Mon, 12 Feb 2024 20:10:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1MdPIPS2Szb1; Mon, 12 Feb 2024 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707768652; bh=rF34L4OO5rzFp4101NZ5iM8gsVj6wYPcNEht86cMhoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLsIjGYlQFk/ogaD85PrI3hgjwsdl4JlX0kzZ2UnPLpEOjTs2ktusq6NoxaoTprEv
	 UmqD7Ua1a8ytF2E2OR/DvjiwGdLT9ulxNucyfIi52VBHMXjSFl0AHy0hqyeqRsRKxs
	 v/XPH1IJWLLR/YsEMOS1GXmBMROY5oBahcV3Yr0pvBZYa/uCmjNo9nHEG0RojFKiVP
	 Mt/Dl3Z1MKbjPd/E1SNLJ71xsGanZMdbKDAMfpRdkHvAhPm1cHSLoXHxcSVbGdpiwH
	 5Z1uuvfdCOI2neWaqA5frfhtJORmF+gXXuijiXMo4prVyIuPNgR7QIt4VbAPJptZrm
	 fJ7uqNfLdEzGy3wUs5q7iwBF/0BWGyg+L92/5SrgcEu1tIV2q+4hZjmjMa098eRtbt
	 5UTAwGOiz7XL0YbIbtJK8AKFHaUjmt/r3x89/EyV/iuyBv21DIC2xU1vaCbKOrqMi5
	 S7iLalV8hR6SRx5NAYg3wjPyFviqK2utolR4o5rmbYN5nY3xA4+RvrI5bH46Yi1Y9y
	 rqzfk8MoIh9L2HqySh0JLHkiDXODjcCSQaq6GY15LHpvE6+dTj/9wMuuOwavzVlOi4
	 aRYgLF1+VquRTqf5e0LcdYGKNkIuC9J6Z3f5otwqluSvODZFXtwUufbwOq4ORGSzuc
	 nOG5eLhzHfk3mJ8+oh4hhDFc=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9647040E0196;
	Mon, 12 Feb 2024 20:10:43 +0000 (UTC)
Date: Mon, 12 Feb 2024 21:10:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	"Naik, Avadhut" <avadnaik@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212201038.GNZcp7PuIqIJndpDM9@fat_crate.local>
References: <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
 <SJ1PR11MB6083E7E11F6C7BCC8C6C7F21FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083E7E11F6C7BCC8C6C7F21FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Mon, Feb 12, 2024 at 07:49:43PM +0000, Luck, Tony wrote:
> Yes. The question is whether a #MC that come in the middle of list_rcu_add()
> can safely do list_for_each_entry_rcu() on the same list.
> 
> RCU is black magic ... maybe it can do this? Adding Paul.

Yeah, the list traversal might be ok as this is what that list_add does
- you can't encounter an inconsistent list - but we still take
 a spinlock on addition and the commit which added it:

7f184275aa30 ("lib, Make gen_pool memory allocator lockless")

says

    The lockless operation only works if there is enough memory available.
    If new memory is added to the pool a lock has to be still taken.  So
    any user relying on locklessness has to ensure that sufficient memory
    is preallocated.

and this is exactly what we're doing - adding new memory.

So, until we're absolutely sure that it is ok to interrupt a context
holding a spinlock with a #MC which is non-maskable, I don't think we
wanna do this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

