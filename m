Return-Path: <linux-kernel+bounces-50492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852018479D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73D81C2424A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80C8060A;
	Fri,  2 Feb 2024 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gIo0KBDJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5445FEE6;
	Fri,  2 Feb 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903011; cv=none; b=sqwPBKuckFxdlhxcfyWyat78DWuxZOmSLQZT3WiD8NDnSAVcdXWGxqlGtbOICXC78rwwvMX0lhxGUP2NmCXA4OjaabCy4L185kPBd8LECncNGD58ES5a6JCbbwtvg0VeIk8/KMD6B9KbD14OsMD3n2ufxtaEuv9QhOt+/X26+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903011; c=relaxed/simple;
	bh=lbyO9bs5vcEz3F5e40/huafqreecjrqSvcrhBKsUBc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMTobhwtkb9ZXTtDvba3wrJRhQUKbxHmBSx20v7xfdtZNbjmqdrXCcCVndJuqRpq/mY+M+vM4S7TFuUjy/kVS4x1/dpZxvRu/5TYoNqiSpW9yI5EmlDmV5wbO/yUS+gP31UHtUCzbKpyzSTOK7kkGEaQigQjx8YS0WIJddmbGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gIo0KBDJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B859D40E016C;
	Fri,  2 Feb 2024 19:43:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aFksFHODyALI; Fri,  2 Feb 2024 19:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706903000; bh=dsgfmzI3ZvkQhmwZVBfUC/2ZuLpZMGoxYodNZ83gS9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIo0KBDJwE4dI4nlDGwcpJmhSEEyddDPQhJv804Vjj6YYJTbx1OuxC1L8TVBlKv64
	 YYBPfrrw8MBRJ+nBqr0sUyLEUMyC8e01RvpOckFZu3yRd1wyQQfei+joq7NCQtFW6a
	 H3ucAiR6+gZfXuJmTiTncudlxeTQDKCD766n0anWtcpoh9+XUPBSPpEW6WwTWYmIf6
	 ZEeu6Rv6wcZvWW6NQFilGv1epWwPdR8gbHY11BQsCOzXxrd4AfLhRhZ9SvRMupDlyH
	 UeLCQvxBQyTLk9wbVJmseNR+lO9qLYdyRq2iSmxMz+mgx0uQ0DMD8GOeTelESIgYbn
	 9vk17+kkvaNzHH6HAEMWTfhSGOPkrnnPI5llvXjVdDA2kmV147M+zvmLCjgbbCewL0
	 HQjGiLOiNl0jEsgvm30TzPbv9n4EgrMQAel+zr+vEAmB7nN8JECvmOL8szP6xoGCN3
	 9izjn+ZE4hVcPMHtCiMVg78g8JBMjvgyG0zFms24YK/B0zEbuZzUa1w6UTjafkhaFE
	 Fmh4URJ05B3hjbiWrJDeZSSKxjIl/b8ovbya1RAIIpgUoepdD0L6kpn6yGCY8JdOL9
	 86A7j3SOB6BESmk1d9uUyZ8VJF/TDCA5/zKvtNrcAOFuYWzIo0N4edspzXlYHfTpc8
	 GXEDZhTWIIUZwXAfhrdboM6Q=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 218D740E00C5;
	Fri,  2 Feb 2024 19:43:04 +0000 (UTC)
Date: Fri, 2 Feb 2024 20:42:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
Message-ID: <20240202194257.GFZb1FwcPPO8WXF86H@fat_crate.local>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
 <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
 <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
 <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
 <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>
 <20240202133911.GBZbzwf-M37M-J3EJX@fat_crate.local>
 <SJ1PR11MB6083A60DE19FBFB1B0CA6B3DFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083A60DE19FBFB1B0CA6B3DFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Feb 02, 2024 at 06:44:32PM +0000, Luck, Tony wrote:
> At least on Intel you can only get a machine check for operation on poison data LOAD.
> Not for a STORE. I believe that is generally true - other arches to confirm.

So what happens if you store to a poisoned cacheline on Intel? It'll
raise a poison consumption error when that cacheline is loaded in the
cache? Because you need to load that line into the cache for writing,
I'd presume...

What happens if you have bits flipped in the cacheline you want to write
to?

That's fine because you're overwriting them anyway?

I'd presume ECC check gets performed on cacheline load and then you'll
have to raise an #MC...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

