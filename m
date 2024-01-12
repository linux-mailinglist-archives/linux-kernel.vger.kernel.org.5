Return-Path: <linux-kernel+bounces-24762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090582C206
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107F01F24AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21066DD1D;
	Fri, 12 Jan 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="elt5CBpF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A16DD05;
	Fri, 12 Jan 2024 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7A78535D;
	Fri, 12 Jan 2024 14:43:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7A78535D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1705070621; bh=hX2vbYDKK5fM8nBKji8rXauO2R5qVnHvz5B0AYqatCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=elt5CBpFjtYsAvyw4vgFwDM0o1ohPPsVFWC83y3wfOfqVncJ4yq7C+WJZ6WdE4jX3
	 b7XuulidUFWzg9xItc+C/LyroLB+tzIWzZarFc8yIZ8rmV/kdBdshEtqFb3BrHyTtz
	 mHamxvGmOrMd/4g78fYvTAfrKgKuvwteiGzGWdJ3bdpA/AGmntkqIC407f4XCl8prd
	 N6rFTo6kp+Ksv2BA2ivqkNPKXh/ze5JhOWMdhEEhcOxhj0IDqNmWNdvQRS809kVexh
	 LI5EFNUp4pe/QUE1T3a4Rf2l9rgM3C0R5cpoIggyaDYS27m1rOuRZ5rP6y6otf4Wtl
	 9cnMWWu7nzssg==
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [GIT PULL] Documentation for 6.8
In-Reply-To: <CAHk-=whtqOvx4_GL8MX+bGroS5hfueP+Arch_qVYwQDJVvFCKg@mail.gmail.com>
References: <87sf37vegj.fsf@meer.lwn.net>
 <CAHk-=whtqOvx4_GL8MX+bGroS5hfueP+Arch_qVYwQDJVvFCKg@mail.gmail.com>
Date: Fri, 12 Jan 2024 07:43:39 -0700
Message-ID: <87v87yk3xg.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[Adding Akira]

Linus Torvalds <torvalds@linuxfoundation.org> writes:

> On Mon, 8 Jan 2024 at 10:59, Jonathan Corbet <corbet@lwn.net> wrote:
>>
>> - The minimum Sphinx requirement has been raised to 2.4.4, following a
>>   warning that was added in 6.2.
>
> Well, speaking of warnings, github now has this "dependabot" thing
> that warns about bad minimum requirements due to tooling that has
> security issues.
>
> And it warns about our "jinja2 < 3.1" requirement, because apparently
> that can cause issues:
>
>   "The xmlattr filter in affected versions of Jinja accepts keys
> containing spaces. XML/HTML attributes cannot contain spaces, as each
> would then be interpreted as a separate attribute. If an application
> accepts keys (as opposed to only values) as user input, and renders
> these in pages that other users see as well, an attacker could use
> this to inject other attributes and perform XSS. Note that accepting
> keys as user input is not common or a particularly intended use case
> of the xmlattr filter, and an application doing so should already be
> verifying what keys are provided regardless of this fix"
>
> with affected versions being marked as < 3.1.3 and fixed in Jinja2 3.1.3
>
> I'm ignoring this github dependabit warning since the issue seems to
> be rather irrelevant for our doc use, but I thought I'd mention it.

I suppose it is worth looking into this, just in case a hostile docs
patch that nobody catches might somehow cause an exploit to show up on
docs.kernel.org.  Seems unlikely but it would be good to be sure.

Akira (CC'd) noted, in adding that requirement, that newer jinja2 breaks
Sphinx prior to 4.8.  I've been thinking that supporting 2.x is going to
prove increasingly unsustainable, but raising our minimum to 4.8 would
surely make some people unhappy.

I like the Python ecosystem for a lot of things, but its approach to API
compatibility is ... not great.

jon

