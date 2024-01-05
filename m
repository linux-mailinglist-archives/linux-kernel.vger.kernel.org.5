Return-Path: <linux-kernel+bounces-17963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC7825617
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771C3B20D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF8A2E84A;
	Fri,  5 Jan 2024 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LGNHOJge"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3452E836
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F2E4140E0177;
	Fri,  5 Jan 2024 14:46:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tHlnDYwKLLM7; Fri,  5 Jan 2024 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704465975; bh=1xobjEfu3Q6pBw7OE9qufzNffwspDBkmg4vDh1PWMD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGNHOJgeSkPF0KN5PxImngwDgg8wIFigBTnju7sl55PdpD25b+LIJ+Yt2k7pu06tM
	 tWqNXou92CWNFq/oOvOJMEsacIanhXff4xjfu8QqEGa2C0vTIeXdXpZtIV50CLYJvw
	 0UPmbItIabRpO3hxDNCmxiQ2kzojnaUXXD67BlFItBNnsTIfCtqsOaSusXzE8yvhGe
	 l/hcBVaBcnHubUUpIvsireim2J3uTWC6YKYlHF0ELQYlkvHcAnVPVoiWkNqCt2KiRw
	 KxP7pluBvKoY3oNOatlzkIDNMIHYG+DKCTmEq8CKYFimCR09McZtcvavS8cdZRtDde
	 xgZG0V8B/qws4r7mB5wHWj9g3P1b+MmWOgBIP3s1BYIb7EaBEOHoqNDmOcgrL3YURg
	 eW4I/OBkIp0vMn3M5VlhOurPZklpy0K94oivRuhNGEFVEgtGbHR66YTV9FI8JzS1bW
	 8bOPYwRrWVe3+QN9+Qk8lNb11snagp6NuEJWpIOl90xBF1MZV+RXKCIh41Zkmai8qp
	 F+qpdChdoCoqWgqmJMbMFtdI56pZN3yRj+aiXW03XMjqunBqaZ72FaHX+6sRgfPZjS
	 BH472TxGTIwIAqNZlgYHeUC4gZFmIMRbSC6VGYDVj6ROqrRoMsjI103e+fztROYFjI
	 M5MtcjIGXnmD5WgOrmfw3aeA=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B89440E0196;
	Fri,  5 Jan 2024 14:46:03 +0000 (UTC)
Date: Fri, 5 Jan 2024 15:45:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tanzir Hasan <tanzirh@google.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] x86/vdso: shrink vdso/extable.i via IWYU
Message-ID: <20240105144556.GBZZgWJOjq6Ekmps6Z@fat_crate.local>
References: <20231228-extable-v1-1-32a18c66b440@google.com>
 <20231228212511.GCZY3nt3gKI+aDvSF1@fat_crate.local>
 <CAE-cH4rEWU-+ovwo8_-i3b2F8pK17kORJ3gV5tnjnUpRJA+B0Q@mail.gmail.com>
 <20231229093942.GBZY6T3knaGKpeRA9a@fat_crate.local>
 <CAKwvOd=aSQq3mcxGe-csNcygFWCbq03CPYFyc5DhjyvL_qYPAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=aSQq3mcxGe-csNcygFWCbq03CPYFyc5DhjyvL_qYPAQ@mail.gmail.com>

On Wed, Jan 03, 2024 at 11:36:35AM -0800, Nick Desaulniers wrote:
> By being more precise in what's necessary via making more specific use
> of includes (making "indirect" includes into "direct" includes) in the
> .c files, it will allow us to more easily refactor the header files
> themselves.

I know, but you have to realize that header files are not a static thing
- we do "refactor" them all the time. So it's not like we'll refactor
them and they'll be done. No, we'll refactor them again later.

> And yes, these inclusion lists will change over time.  As you say
> below, they can be cleaned up again every couple of releases.  Though
> right now most files have never been cleaned up at all.

Yap, the need for some tool or facility to keep include files proper and
optimal is indisputable. There's a reason it is called the "Include
Hell".

> Over time, they will add up. But not if we reject the patches as
> unnecessary churn.

There's the other side of that coin: if we keep applying those, it'll
turn into a never-ending stream of silly fixes. Like spellchecking and
whitespace cleanups. And maintainers will start ignoring them.

> Maybe the overall numbers are interesting, but landing one patch that
> updates numerous .c files' inclusion lists seems error prone.  I
> suspect it's more likely that a more incremental approach of smaller
> patches allows progress if there are any issues; a build
> failure/mistake doesn't block the whole thing from landing.
> 
> Overall numbers can also be collected after the fact.

You could do a single patch *set* and say, before and after, we get
these improvements. And the whole set goes in in one fell swoop.

> > And then do it
> > again in a couple of releases, when it becomes necessary again.
> 
> That's the use case I had in mind.  Though I suspect the initial run
> of this tooling will result in the most changes, as some files in tree
> are hardly touched between releases. For those, I don't expect any
> automated tooling to be churning those files after the initial
> cleaning.

That's why I said "when it becomes necessary". :)

> Yeah, the idea is that the tooling results in repeatable processes by
> others.  One could imagine build bots running this, or integrating it
> into checkpatch, or git presubmit hooks, or w/e.

Yap, that would be best. Because it'll stop from the whole include hell
from even ensuing in the first place.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

