Return-Path: <linux-kernel+bounces-49913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78A84714F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FB52843EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD4B47781;
	Fri,  2 Feb 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KiiExzXL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48A46B9A;
	Fri,  2 Feb 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881182; cv=none; b=tOS/1Nvdo9as0jjh+gCHLqQ6VSnb8RkIuMiOOMLcIlv1gS/B/jR62DGOFznioGaxDpX1miQEStpVFMORz4sWg7wcWaPQocKcX1MzheX96A511n1a1uaA2iNVEraMXQFCYT2CuBvFVKlPMQzyjO3Vk0QJ5VhNkvLhd7sOmYHLPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881182; c=relaxed/simple;
	bh=miDAUqH++egcoxWAD5wW30DmvWxqjaeshiXLXeM5glY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzR32TAD+ogAImLtdzEbmFY3l+tYEpciqreUG29Gf6DKDLZcvq+gxgzY2zyIVxgBvrlhChooCWNB9q1lMBluko1p34rAJB2GHd7P77dwH4F3qMVk0H1NhdXa1Vji+ufEc3Bt7gq2wZbZLfy7blgniqfKCdUCpEp7KOXCxVv2pBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KiiExzXL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B7DF740E01A2;
	Fri,  2 Feb 2024 13:39:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uci-jhhF5SNC; Fri,  2 Feb 2024 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706881173; bh=i41MKt90HCy/J6mZcV7OB0Wu4vTJEn+w5XEKHKNjBAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiiExzXLJY4+AspZZQa0Av26b2H8HFzHlmtkPc/0vs3Q33lr2CivSmBLYVAwvoTN2
	 rxdQq9xq/zktgGVr7XpYMFHB+zptXlm7E+L/Sw8ToT7duFQCmALMqZLhP4Beokw4uO
	 Jg97HZ0IDCzAIw4j8MkrHx2o1iaVpRQufanVh/ia0J3IBa9RxqdMK74Xd1NtDIl54N
	 jvIWUxk5sxX6IwGs4+PhEHuwFbWbFt9n383ROsRBuLk70IZssOk1JHYK8tmCyoWIlR
	 xtMLpRxJP2hNFD5m3I+iyvWuZlsdnPz+Hs5jC+o/Z58TM05iEZnzRGMt7NH352O7UZ
	 uDcgei3r65O9ZwTTNSTT3ETGmaXktkUT+vwFVbgZdVPMAYyJwp03ZSTMTU8g3AULB5
	 ZQw/Zk1Pq09G2gdhTTJDe/d5Eqb9DNtbVAspzxIlQYDA2klONS9fssRqLCigoRBiug
	 xadCEFvVJ2XegD11ZH3/M4Di+8/kCmwnJjx+gh/jB5E3D7xacBNYMriVUs/ZvG1xDo
	 pBRblQhKOCN7Ds7hK4mHVt6hK1dY2UU5eZeH7hn19sjBqRs7LI3pwhIwgp+e086Mp/
	 0g3MWRpmI3iGTue+P8O6/aXow+C0F4F7LTVeaXQeYUakyI0AXak8Y4XmRlVQl3g3aB
	 Zr69JeKncVzcY6dm/LXlM0Yw=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC6BE40E016C;
	Fri,  2 Feb 2024 13:39:17 +0000 (UTC)
Date: Fri, 2 Feb 2024 14:39:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	wangkefeng.wang@huawei.com,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-mm@kvack.org, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
Message-ID: <20240202133911.GBZbzwf-M37M-J3EJX@fat_crate.local>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
 <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
 <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
 <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
 <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>

On Fri, Feb 02, 2024 at 03:51:12PM +0800, Tong Tiangen wrote:
> Currently, there are some kernel memory copy scenarios is also mc safe
> which use copy_mc_to_kernel() or copy_mc_user_highpage(), these kernel-
> to-kernel copy use fixup_type EX_TYPE_DEFAULT_MCE_SAFE. In these
> scenarios, posion pages need to be isolated too and the current

So you have, for example:

  unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigned len)

Now imagine you get a MCE for *dst which is some kernel page which
cannot be poisoned: direct map, kernel text, and so on.

Attempting to poison such a page would not work, to put it mildly.

So, again, what *exactly* are you "fixing" here?

When I read "Currently, there are some kernel memory copy scenarios" and
there's nothing more explaining what those scenarios are, I'm tempted to
ignore this completely until you give a detailed and concrete example
what the problem is:

What exactly are you doing, what goes wrong, why does this need to be
fixed and so on...

If there isn't such a real-life use case you're encountering, then this
all is waste of time.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

