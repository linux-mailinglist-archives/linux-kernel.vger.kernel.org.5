Return-Path: <linux-kernel+bounces-81244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCAE8672E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F26B2956D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2441CFB5;
	Mon, 26 Feb 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKHDynml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB87A1CD36;
	Mon, 26 Feb 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945468; cv=none; b=sg20TIzQCFqGDRZ2n+2md0sSTSaOjBmYrqV2kfmXeQc1rUlA2FEn4YF9No1o6gTYa2FXLMf22xDwipalhxSpJki/AsYvLfyGbZARn2l32TIseGoE+cZ9NpdLxKxZUU1lF/8zg0nZulqcdE49WrZwHhyY+Joe1sw+1j5sgbBSlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945468; c=relaxed/simple;
	bh=S0rhOsZnA1jrvwPoXiDoBYFc0m9GRa3dv0XWSQRBK9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raWOraLWjYT6ps9ZbpWv6YCMht151PyyRjTpDQzufKrqWBqM0LG3JpwsZGdw4pfxyJOdaODnRgEHgfqQowd07BhHyZkJV16qmt6X1sRwfMysu7tc9N+L5EzYllIBqAZEAqossuGfJiDhZ6n3LJHm+c7gpAqEZVD9c/t/VwhraoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKHDynml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3208DC433F1;
	Mon, 26 Feb 2024 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708945468;
	bh=S0rhOsZnA1jrvwPoXiDoBYFc0m9GRa3dv0XWSQRBK9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKHDynmlxV+X2FkPX90nYOyeWqYIVkC2uyfeCftFC2AFoFPVCVHnH69Y51eoDQT1m
	 9Tjn6XcfD4qVktFhXcZkYYGw4fe042S1H7UmrtI8Fu3CWaAuD+3nAHSfDkHHBVyDHo
	 WP8ErVmHQPcMGx+VYTbTIGO1MNNuPStF6ePf9oH3p8nKx5QtjI9H0OfQSXvbcAzLdA
	 D96w4kB7AHgInhUJysO0xXEYMCVugF43XHThoBBVOmtYH2aO3YNe4aUp54c5brdtL+
	 4AasIIcUqwX8wvfdhducg37ee9hOgbQuLnS9DgpW+SBteBfvtggFp84UpbN9FAEtEp
	 Xdt1mOILEUBOg==
Date: Mon, 26 Feb 2024 11:04:24 +0000
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the gpio-brgl tree
Message-ID: <20240226110424.GA120668@google.com>
References: <20240226174117.722301b9@canb.auug.org.au>
 <CAMRc=MctN=PqM6O3GxvcFuk2ZT2YcqTiKZiuCiaTnXDEV+gXaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MctN=PqM6O3GxvcFuk2ZT2YcqTiKZiuCiaTnXDEV+gXaw@mail.gmail.com>

On Mon, 26 Feb 2024, Bartosz Golaszewski wrote:

> On Mon, Feb 26, 2024 at 7:41 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > The following commit is also in the mfd tree as A different commit
> > (but the same patch):
> >
> >   4a7b0850fc7a ("dt-bindings: cros-ec: Add properties for GPIO controller")
> >
> > This is commit
> >
> >   7b79740d42e7 ("dt-bindings: mfd: cros-ec: Add properties for GPIO controller")
> >
> > in the mfd tree.
> >
> > --
> > Cheers,
> > Stephen Rothwell
> 
> Hi Stephen, Lee!
> 
> I picked it up because I was already queuing the patch adding the GPIO
> driver. Unless there are conflicts with the MFD branch (doesn't seem
> like it?), I think it should go through the GPIO branch together with
> the driver.

This is the first I've heard of it.  There was no reply from you, even
after I specifically asked you for an explanation.

There is no convincing reason for this to follow the C change.  It's
more important to avoid Linus from facing merge-conflicts during the
merge-window. Please remove the patch from your tree.

-- 
Lee Jones [李琼斯]

