Return-Path: <linux-kernel+bounces-81521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB1867708
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0C91F2B287
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F8129A70;
	Mon, 26 Feb 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P32ywKD6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD1129A6D;
	Mon, 26 Feb 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955053; cv=none; b=OD9fGMGOsvRwgo4YKg51ldp/8g45vCSIh0s4gz2yFvRw/Pb24ojLF5Ts2FK8gvtOXTqa9qhyOv8TqXSN2QgbW0LrrM2yYePsa+4uUckNCGfbR7prjPcTivs8cxC1yXXYTn147RV1Y0m63CLgRgyvIEeFT81DaY4nPMEZRfSUX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955053; c=relaxed/simple;
	bh=bo3c3+NTE2BlYqaNtqxgacvO+ucNRuOHvziljOZ1k2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSzZsFa14NTAdIu28yixGgfivQFFb6IV0csajrwBsFcDKy814iwJsApmbNp9BuM8aE+E8QcFh1DveZJ0K1/TpI5TgHa71+p8sJHRxyI4OiOVyJknl78c0TIamVUxBXt560NpDxnJVTNY2OkiZHaRuRva3mSPkRBseNaUVGLG6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P32ywKD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56E7C43390;
	Mon, 26 Feb 2024 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708955052;
	bh=bo3c3+NTE2BlYqaNtqxgacvO+ucNRuOHvziljOZ1k2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P32ywKD6dwZcFngrzQ+uYqczQ8n8LyCknHiejpIsIEpTaiE0/fVzYSxeCWlGkR0rq
	 YJy0LseLwAVoim/BiJdn5fGedag0uZew/VVaCFwy+orCZHJaczPA447+jABKncjEDd
	 ukX29J8RRivca1/K9A6p9CqlRtzjoEAdwkHa7kRaXeXd8L70I1YS22nRnKqZEmdhT/
	 WOHCvhSYGjFoFzGCPxPmINjFzL+fDOqQUJBUClx3QWg9TIZSkCg5xq14BqXhIzCBZf
	 +psiJDBJpWwcy/7SsYru8r3XgC8B52fMCMWL8ct1w/2/BQbGDsBOtm+nK/HagmvOZD
	 lQ9+Gq9eKEclg==
Date: Mon, 26 Feb 2024 13:44:08 +0000
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the gpio-brgl tree
Message-ID: <20240226134408.GA37938@google.com>
References: <20240226174117.722301b9@canb.auug.org.au>
 <CAMRc=MctN=PqM6O3GxvcFuk2ZT2YcqTiKZiuCiaTnXDEV+gXaw@mail.gmail.com>
 <20240226110424.GA120668@google.com>
 <CAMRc=Md3pfEWcMSoVjdj7_o9MJQUShfKL6=XyWVm3MqEWKFX9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md3pfEWcMSoVjdj7_o9MJQUShfKL6=XyWVm3MqEWKFX9Q@mail.gmail.com>

On Mon, 26 Feb 2024, Bartosz Golaszewski wrote:

> On Mon, Feb 26, 2024 at 12:04 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Mon, 26 Feb 2024, Bartosz Golaszewski wrote:
> >
> > > On Mon, Feb 26, 2024 at 7:41 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > The following commit is also in the mfd tree as A different commit
> > > > (but the same patch):
> > > >
> > > >   4a7b0850fc7a ("dt-bindings: cros-ec: Add properties for GPIO controller")
> > > >
> > > > This is commit
> > > >
> > > >   7b79740d42e7 ("dt-bindings: mfd: cros-ec: Add properties for GPIO controller")
> > > >
> > > > in the mfd tree.
> > > >
> > > > --
> > > > Cheers,
> > > > Stephen Rothwell
> > >
> > > Hi Stephen, Lee!
> > >
> > > I picked it up because I was already queuing the patch adding the GPIO
> > > driver. Unless there are conflicts with the MFD branch (doesn't seem
> > > like it?), I think it should go through the GPIO branch together with
> > > the driver.
> >
> > This is the first I've heard of it.  There was no reply from you, even
> > after I specifically asked you for an explanation.
> >
> 
> Huh, I now see your email in lore[1] but I don't have it in my inbox,
> not even in spam. I would have answered otherwise.
> 
> > There is no convincing reason for this to follow the C change.  It's
> > more important to avoid Linus from facing merge-conflicts during the
> > merge-window. Please remove the patch from your tree.
> >
> 
> This is why I'm asking if this caused a conflict. Whatever, I'll drop
> it alright.

Maybe there aren't any conflicts yet, but we are still early in the
cycle and prevention is better than cure.  Thanks for dropping it.

-- 
Lee Jones [李琼斯]

