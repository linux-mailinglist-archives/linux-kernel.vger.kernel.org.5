Return-Path: <linux-kernel+bounces-140207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE728A0CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0311C21BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF61145B13;
	Thu, 11 Apr 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G9gbSkp7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB714430D;
	Thu, 11 Apr 2024 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829190; cv=none; b=TEyMnB5qBAqCzEdpT93P24br5cSJNK06+ZDzHcl2YX7ArmcJU/QzeIMdbBBvi8mhSm7DB6jqA1sjgQcq80RMjwb1snLl1RjYXWFOApA4IZ8Am1DjxOvcCEipEQHXAZ8z9v/B9O4jyt9BOcX5XIY4OfFXx6BCs7dhVLSFmBgO7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829190; c=relaxed/simple;
	bh=8SQ0a8KIXg+9Q6wH7l7+OtKBY0yEhH+2/6JYQpE8re8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vB5hEHyywfhcvcv+fvEEZf8d2X/uyJN/Hy7ui94BBySY4H4gPvrGl+P+/zSeMDVYQCd5dqresws/5G84xkgk4Fd0ExQTHfWb4jkyfOtB8FUkOeKall+CrssRv61xTpUhTcNQ511UOZG3kiozxgDKR/PWO3bk5+pHiz3wtzzvls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G9gbSkp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9EEC433F1;
	Thu, 11 Apr 2024 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712829189;
	bh=8SQ0a8KIXg+9Q6wH7l7+OtKBY0yEhH+2/6JYQpE8re8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9gbSkp7oEzeuI3Q0PgtuXj1sVQzFoshmy35z6knqC8VODQ8M+jRQp7yJomxLQOXD
	 dNeFOGL+XQjg1Lf2s1UGNC+/Gb7l6z6PIuHfU5o20nIO11lpOhSIOQ3Ur3vC7CZ+k4
	 PEcm0JAXlJGRqkpmoG1eD++BQeSEoTmEozBpgA5s=
Date: Thu, 11 Apr 2024 11:53:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] docs: stable-kernel-rules: mention "no
 semi-automatic backport"
Message-ID: <2024041151-reflected-dancing-607a@gregkh>
References: <cover.1712812895.git.linux@leemhuis.info>
 <c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info>
 <2024041156-backache-dolly-a420@gregkh>
 <3f395eca-fc24-469b-b5fc-de47ab2a6861@leemhuis.info>
 <2024041123-earthling-primarily-4656@gregkh>
 <dad33d1c-77da-4b97-a0ec-4bf566f8d861@leemhuis.info>
 <2024041159-undone-deacon-3170@gregkh>
 <CAMuHMdXMRJM1xQLHDc6yKWvs97W2iTZnYnNNZE=8-WrtnGRNfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXMRJM1xQLHDc6yKWvs97W2iTZnYnNNZE=8-WrtnGRNfw@mail.gmail.com>

On Thu, Apr 11, 2024 at 11:19:57AM +0200, Geert Uytterhoeven wrote:
> On Thu, Apr 11, 2024 at 11:13 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Apr 11, 2024 at 09:50:24AM +0200, Thorsten Leemhuis wrote:
> > > On 11.04.24 09:40, Greg Kroah-Hartman wrote:
> > > > On Thu, Apr 11, 2024 at 08:59:39AM +0200, Thorsten Leemhuis wrote:
> > > >> On 11.04.24 07:29, Greg Kroah-Hartman wrote:
> > > >>> On Thu, Apr 11, 2024 at 07:25:04AM +0200, Thorsten Leemhuis wrote:
> > > >>>> Some developers deliberately steer clear of 'Fixes:' tags to prevent
> > > >>>> changes from being backported semi-automatically by the stable team.
> > > >>>> That somewhat undermines the reason for the existence of the Fixes: tag,
> > > >>>> hence point out there is an alternative to reach the same effect.
> > > > [...]
> > > >>> I do not understand, why are you saying "cc: stable" here if you do NOT
> > > >>> want it backported?
> > > >> Because the only alternative the developers have to make the stable team
> > > >> not pick a single patch[1] is to deliberately omit a Fixes: tag even if
> > > >> the patch normally should have one. Like it was done here:
> > > >> https://lore.kernel.org/all/cover.1712226175.git.antony.antony@secunet.com/
> > > > That feels odd, but ok I now see the need for this for some minor set of
> > > > changes (i.e. this has rarely come up in the past 15+ years)
> > > >
> > > > [...]
> > > >> E.g. 'ignore for the AUTOSEL and the "Fixes tag only" tools'. That was
> > > >> the best term I came up with.
> > > >
> > > > Thinking about it more, I think we need to be much more explicit, and
> > > > provide the reason why.
> > > >
> > > > How about:
> > > >     cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
> > > >
> > > > and we can make that address be routed to /dev/null just like
> > > > <stable@kernel.org> is?
> > >
> > > Totally fine with me, but that feels somewhat long and hard to type.
> >
> > I want it long and hard to type and very very explicit that this is what
> > the developer/maintainer wants to have happen (again, because this is
> > such a rare occurrence.)
> >
> > > How
> > > about just 'no-stable@kernel.org' (or 'nostable@kernel.org')?
> >
> > More words are better :)
> 
> And after that, someone discovers this turns out to be (a hard
> dependency for) a very critical fix that does need backporting?

Then we backport it and let the person know like always.

thanks,

greg k-h

