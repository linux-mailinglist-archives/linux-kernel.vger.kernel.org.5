Return-Path: <linux-kernel+bounces-39876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5583D6E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F391C2E708
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6221106;
	Fri, 26 Jan 2024 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru3wASNj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61214017
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259834; cv=none; b=Oh00UhNdMvtcELyGXOmtb0W6yh7ycaCFkmNGaPlIIcBpw9GQm31leWO75YpSCmUxDNUVTZUdjZVwaVdEftV56CtJ8SkpB5npYsJfdkkHW7az3mbi4JKaUH9GZzpXRQdO9tTAIH4CwRg2YqK7POas3dpoO2ImV+5l1t9XzNK5SMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259834; c=relaxed/simple;
	bh=fV7HdBUhrnGxvTqyCfo0MGDIM92JbvzmJYFrGTUjjRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2lmyQK1I0+ayhCdXwu0Dl3jqLrRTpEsJNxah9w6drJUcwe/SklZrpX6LR6PyvpUa+e2WpXyZQSRGOaRK+yqZyoKg4KrZT/0wAjhvBY/UVpr564x4/4whY09WUCx2+zERCP8IthJeBc+Fse41SJay1RQaL4lMXBMqvJtiWDQUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru3wASNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D907EC433F1;
	Fri, 26 Jan 2024 09:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706259833;
	bh=fV7HdBUhrnGxvTqyCfo0MGDIM92JbvzmJYFrGTUjjRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ru3wASNjqofp4e53mKuCpDHABpIDjq+oXydsSbbu5bn1AALIpQblx7yVGu28BwgJc
	 010P0E3s5L0qFI6sWsTsmaPhrm6N6hTYyOUEfFBV44dJq3n8Dc4Q+OUOyp3RlLBK0j
	 ur/WO/g1Rh09Y+LkeNN1ys/jNloXpa+PM9aA238IxsjHJAUO9aE2NFvcJkJO+F/1cn
	 64X+HUWjm94L59Gb+DzyD5ID7y3nfp+grciarwxwpZtvQzQLUHlNv/0rTKPK85qSQf
	 v2MNvBNgqW66HXrsxzoTAXFbSXsOUVjIge4BoqCHzbo847b4jJrq0KylcURDj0ptNT
	 iYGgv7vR04w8g==
Date: Fri, 26 Jan 2024 09:03:49 +0000
From: Lee Jones <lee@kernel.org>
To: alex vinarskis <alex.vinarskis@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 0/2] Fix LPSS clock divider for XPS 9530
Message-ID: <20240126090349.GN74950@google.com>
References: <20231221185142.9224-1-alex.vinarskis@gmail.com>
 <170496815117.1660675.17225837755492911459.b4-ty@kernel.org>
 <CAMcHhXrZvw3QGuoHk+fBaetpPfpTqWa3hrfkENtFuggOZ7UHSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMcHhXrZvw3QGuoHk+fBaetpPfpTqWa3hrfkENtFuggOZ7UHSQ@mail.gmail.com>

Please don't drop the list.  Other people may benefit from your questions.

I'm redacting some of the text which may cause conflict and adding back
the original recipient's list.

On Fri, 26 Jan 2024, alex vinarskis wrote:

> > On Thu, 21 Dec 2023 19:51:40 +0100, Aleksandrs Vinarskis wrote:
> > > Dell XPS 9530 (2023) uses spi-pxa2xx with clock-divider enabled from
> > > intel-lpss with the ratio of 1:32767 (Dell's firmware bug). This caps SPI
> > > controller's speed at very low value of 3051Hz, which makes the interface
> > > practically unusable. Since either spi-pxa2xx or intel-lpss should have
> > > clock divider enabled, not both, and SPI controller can have higher speed
> > > than requested by the device, it is preffered to disable intel-lpss
> > > clock-divider, and let SPI controller handle it.
> > >
> > > [...]
> >
> > Applied, thanks!
> 
> Hi,
> 
> I've got a quick question regarding the merging procedure, apologies
> if this was trivial,
> I am still rather new to this:
> 
> I noticed that this series was staged for `for-mfd-next-next`, while
> only `for-mfd-next`
> was merged to 6.8-rc1. Does that imply that following series is not
> planned to be included
> in 6.8, but rather in 6.9?

Yes, that's correct.  The `for-mfd-next-next` branch comes into play
when `for-mfd-next` gets locked down for inclusion and gets merged into
`for-mfd-next` once the merge window has closed.

> If yes, could I ask why? It was under the impression that it was
> submitted in time (at the late stage of 6.7 testing) to make it to 6.8

It was not.  Most maintainers stop merging new patches in the mid to
late -rcs for inclusion into the next merge-window.  I like to have
all new additions soak in Linux Next (-next) for at least 2 to 3 weeks
before sending to Linus.

> (sadly, not in time for LTS > 6.7).

I think you're confusing 2 different things.  I assume you mean the
-rcs.  LTS (Long Term Stable) is for fixes.  Commits end up there
*after* they land in Mainline so long as they conform to the rules set
out in:

  Documentation/process/stable-kernel-rules.rst

> Reason I am asking is
> because this is the last series required to fix audio on XPS 9530
> laptops: [1] was merged in
> 6.7, [2] was merged in 6.8-rc1 and backported to 6.7.1-rc1. Thus me
> and other XPS users
> are extremely eager to see this land in the next kernel release, as
> there was quite some
> community effort to get this done.

Adding support for new devices isn't usually a good enough reason to
submit to the -rcs.  The -rcs are used to fix issues that broke during
the merge-window of the same release and for urgent bug fixes.

This set will be applied to v6.8-rc1.  From there you can apply to have
it backported (or better still, backport and submit it yourself) to
Stable (a.k.a. LTS).  Since it's the LTS' that you will usually find
running on your distro of choice, your audio will likely be fixed with
an upcoming `apt upgrade` or equivalent.

> Once again, apologies if this question is obvious,
> Thanks,
> Alex
> 
> [1] https://lore.kernel.org/all/20231203233006.100558-1-alex.vinarskis@gmail.com/
> [2] https://lore.kernel.org/all/20231221132518.3213-1-sbinding@opensource.cirrus.com/
> 
> >
> > [1/2] mfd: intel-lpss: Switch to generalized quirk table
> >       commit: d43b5230c38ed6001f996eb9262b457713b31ef8
> > [2/2] mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
> >       commit: 106362167f49a0e83f4e6c26f9653f3061575229
> >
> > --
> > Lee Jones [李琼斯]
> >

-- 
Lee Jones [李琼斯]

