Return-Path: <linux-kernel+bounces-62492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD9A85219F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7043B1C2233C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4295B4DA1F;
	Mon, 12 Feb 2024 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WC6GNWEd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FCF4E1C5;
	Mon, 12 Feb 2024 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777762; cv=none; b=AL+pG1QSglOeJ+tWNs8OJJbf4OZMuB+BkGQZMPReMqO7QGwEwLeh9UOOyNudeeMEWOdgWEuWqtokRy9hyK5ofprBUS5k59HFvheX3xC8bvA60h9sitDvULRKMSRSWOLYWCxQV75CAroA/9NpsfSBgI8fOOoP1Hn2NBG0ZK/KstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777762; c=relaxed/simple;
	bh=8kXPD0fz3eMvLUNOcgV0WOmnWYLHc75zgudLhPqDaG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHM6v3oN8CSvIrlCfn5QK6dXBocoG01gibCQQMbqafAnaMFw3qTfmJD5Gl+lEMQwndOnf5ijy8Zpo3fFp0hkI+ClhpI64B5Nr1A7QnZRsl4EcsCdPG5+R9VtSkW9gD8MAUJtD3pUAmPtTyL5GknKiY9Xlf/qR1T+HY6NRaZjDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WC6GNWEd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D3FE640E0196;
	Mon, 12 Feb 2024 22:42:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KTOy966-kHxz; Mon, 12 Feb 2024 22:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707777754; bh=yCQoPT3adfRBUxB8UAr04/eO8kc2ia97mmC+gu+LmLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WC6GNWEdjii1xe0PyUrWAhXzH0uHXo/P52/l9NJtnl3OuzIYpxh72H25qDzr5mvQY
	 6w9iuIcyYbN0FCo+sZygwi1I6uk2HTX65wgiFPo3xpkhVXVzLL0VR+qkricxEUlTqk
	 EbvCRm4eJJDwLEhDO0USw29n+Hu4iphAX+R7jbIY/6W1zPxyoeMcPYvHLBJnqQVEdc
	 ImefsYUeV21fRg6h3ojXgLyJ/b8jtDlljeYkd2Vi/Ryg9rxopELt2rjI/hupHi2huz
	 ojYBYqiYct5npWxspppJpM4Oxa1++tL+vEdJwmobvSM1xtFHU2H8pUbq27ieaqJAlZ
	 FeE88k2guk6zKR7Yj/Wj/rfIe8mdLjW7zsXt0i8zbaBgvl4pwIi06fkmpE1/9WWp/p
	 AOaty/WJk6Y+XTVaAr5onr7hmDzX2tIRYWaO0+n2XUeDL/VwFUWIVR/oB4g5eElcZo
	 pm/AYTMz8Maw5SJNzbRuylborkYa1uZFoy4Mr+gK5/P0pdKpWq5yRV62i5tSdGZ4OQ
	 lOW+pfblxVZ6U0dzpEp2ZUmbY4+uSZuZZPwMy+mYtuwi8X5XYachSWKkG0ev+6tvya
	 JBJYhLlRaJjKGtSUoEYsYcUGJEXlPD+YkkLySpIEcYERtX5Qe76VkLgQI6YrTTOXz0
	 oIDZ4yLy4BhiyQRfEOdFcrHY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EA0240E01A9;
	Mon, 12 Feb 2024 22:42:26 +0000 (UTC)
Date: Mon, 12 Feb 2024 23:42:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
References: <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>

On Mon, Feb 12, 2024 at 11:19:13PM +0100, Borislav Petkov wrote:
> On Mon, Feb 12, 2024 at 11:08:33PM +0100, Borislav Petkov wrote:
> > I'll have to dig into my archives tomorrow, on a clear head...
> 
> So I checked out 648ed94038c030245a06e4be59744fd5cdc18c40 which is
> 4.2-something.
> 
> And even back then, mcheck_cpu_init() gets called *after* mm_init()
> which already initializes the allocators. So why did we allocate that
> buffer statically?

Found it in my archives. You should have it too:

Date: Thu, 31 Jul 2014 02:51:25 -0400
From: "Chen, Gong" <gong.chen@linux.intel.com>
To: tony.luck@intel.com, bp@alien8.de
Subject: Re: [RFC PATCH untest v2 1/4] x86, MCE: Provide a lock-less memory pool to save error record
Message-ID: <20140731065125.GA5999@gchen.bj.intel.com>

and that's not on any ML that's why I can't find it on lore...

There's this fragment from Chen:

--------
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index bb92f38..a1b6841 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -2023,6 +2023,9 @@ int __init mcheck_init(void)
>  {
>       mcheck_intel_therm_init();
>  
> +     if (!mce_genpool_init())
> +             mca_cfg.disabled = true;
> +
when setup_arch is called, memory subsystem hasn't been initialized,
which means I can't use regular page allocation function. So I still
need to put genpool init in mcheck_cpu_init.
--------

And that is still the case - mcheck_init() gets called in setup_arch()
and thus before before mm_init() which is called mm_core_init() now.

And on that same thread we agree that we should allocate it statically
but then the call to mce_gen_pool_init() ended up in mcheck_cpu_init()
which happens *after* mm_init().

What a big fscking facepalm. :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

