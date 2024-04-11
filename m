Return-Path: <linux-kernel+bounces-140727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48548A1853
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5178E1F22EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B6175BD;
	Thu, 11 Apr 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wJ863Qhm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E7DDD2;
	Thu, 11 Apr 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848343; cv=none; b=tiSkGeAuNBDYRCYKYZn+nVXQQM8nKoygJNNCDH9NyztcV90lGH61X3IVAr7Hi63yJxkohhajbr5g9Rq+MwcrB5kFcWWWO2puF4ZPD0COXoGt5OBVHxi8ELp7y0lOgXETfmKXWnPpTLbLOOgcg8ojPKK9UoCZjkkSbNm7sIfE6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848343; c=relaxed/simple;
	bh=YOADgTAx7P58ArHQWyBgN0Xfa6HVMRCa7sCjvR27Gm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlA74KBTPQh3f4yhHuAjYMVL61UKdiAh2UIH4suirjVaY4U+QV8l0T/D20Qu7KTIOeC+n5cU/DkkEvap9KEITk95HV98sUTvH3dVav9cb4RpxsXtDbKi/Ai2s46TaN3/nankJNkggoL6FrlnFIeRuwKQdSaBxowXcHmpd9jPsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wJ863Qhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4A0C072AA;
	Thu, 11 Apr 2024 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712848342;
	bh=YOADgTAx7P58ArHQWyBgN0Xfa6HVMRCa7sCjvR27Gm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wJ863QhmKZKaJED428m8roo2ffY4+xZzqboWCkTsinzTGQNfka6tAIR+FOONW67TQ
	 xE0ekkk/boIxpxipNgClGmd5OpNNDwmWW8dIStp7QpRGgAyWZkT+UwvD5OmWeNRpA3
	 n4RYq50dHSdQNeeqcLgC/Hu6gwymDcBPle/keVmo=
Date: Thu, 11 Apr 2024 17:12:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] docs: stable-kernel-rules: mention "no
 semi-automatic backport"
Message-ID: <2024041122-handcart-renounce-4eb2@gregkh>
References: <cover.1712812895.git.linux@leemhuis.info>
 <c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info>
 <2024041156-backache-dolly-a420@gregkh>
 <3f395eca-fc24-469b-b5fc-de47ab2a6861@leemhuis.info>
 <2024041123-earthling-primarily-4656@gregkh>
 <dad33d1c-77da-4b97-a0ec-4bf566f8d861@leemhuis.info>
 <2024041159-undone-deacon-3170@gregkh>
 <CAMuHMdXMRJM1xQLHDc6yKWvs97W2iTZnYnNNZE=8-WrtnGRNfw@mail.gmail.com>
 <c7e5a7b5-837c-4ad5-91b9-1abaa245cc15@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7e5a7b5-837c-4ad5-91b9-1abaa245cc15@leemhuis.info>

On Thu, Apr 11, 2024 at 11:57:04AM +0200, Thorsten Leemhuis wrote:
> On 11.04.24 11:19, Geert Uytterhoeven wrote:
> > On Thu, Apr 11, 2024 at 11:13 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> On Thu, Apr 11, 2024 at 09:50:24AM +0200, Thorsten Leemhuis wrote:
> >>> On 11.04.24 09:40, Greg Kroah-Hartman wrote:
> >>>> On Thu, Apr 11, 2024 at 08:59:39AM +0200, Thorsten Leemhuis wrote:
> >>>>> On 11.04.24 07:29, Greg Kroah-Hartman wrote:
> >>>>>> On Thu, Apr 11, 2024 at 07:25:04AM +0200, Thorsten Leemhuis wrote:
> >>>>>>> Some developers deliberately steer clear of 'Fixes:' tags to prevent
> >>>>>>> changes from being backported semi-automatically by the stable team.
> >>>>>>> That somewhat undermines the reason for the existence of the Fixes: tag,
> >>>>>>> hence point out there is an alternative to reach the same effect.
> >>>> [...]
> >>>>>> I do not understand, why are you saying "cc: stable" here if you do NOT
> >>>>>> want it backported?
> >>>>> Because the only alternative the developers have to make the stable team
> >>>>> not pick a single patch[1] is to deliberately omit a Fixes: tag even if
> >>>>> the patch normally should have one. Like it was done here:
> >>>>> https://lore.kernel.org/all/cover.1712226175.git.antony.antony@secunet.com/
> >>>> That feels odd, but ok I now see the need for this for some minor set of
> >>>> changes (i.e. this has rarely come up in the past 15+ years)
> >>>>
> >>>> [...]
> >>>>> E.g. 'ignore for the AUTOSEL and the "Fixes tag only" tools'. That was
> >>>>> the best term I came up with.
> >>>>
> >>>> Thinking about it more, I think we need to be much more explicit, and
> >>>> provide the reason why.
> >>>>
> >>>> How about:
> >>>>     cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
> >>>>
> >>>> and we can make that address be routed to /dev/null just like
> >>>> <stable@kernel.org> is?
> >>>
> >>> Totally fine with me, but that feels somewhat long and hard to type.
> >>
> >> I want it long and hard to type and very very explicit that this is what
> >> the developer/maintainer wants to have happen (again, because this is
> >> such a rare occurrence.)
> >>
> >>> How
> >>> about just 'no-stable@kernel.org' (or 'nostable@kernel.org')?
> >>
> >> More words are better :)
> > 
> > And after that, someone discovers this turns out to be (a hard
> > dependency for) a very critical fix that does need backporting?
> 
> Ask why the tag was set I guess. But yeah, that was among the minor
> reasons why I had come up with "no semiautomatic stable backport" thing,
> as it made the intention more clear. Maybe
> 
> only-manual-stable-backport@kernel.org
> 
> could help and is even longer. But I might be getting into bikeshedding
> territory here. :-D

That one would not work as I would then manually backport the commit :)

Actually, one can say that all of the commits are manually backported as
I review them all that are cc: stable when I apply them.  So while
bikeshedding is fun, this would mean the opposite of what you intend.

thanks,

greg k-h

