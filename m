Return-Path: <linux-kernel+bounces-166283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6BB8B987F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B8B1C22652
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9004F56B92;
	Thu,  2 May 2024 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+JKSvy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013C4DA1B;
	Thu,  2 May 2024 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644507; cv=none; b=ERj32MY47kggJ6Wh125fnwaiGRjJqAnjesLMUihdTneO8uOqLfz4btPRONKVdb+Qa6z6pNDWLIPOMOEU2vBu6xxQ1AxwRe1tKd5683lZOghiFzL6x2bL+kaxjDsa7W57EzrG1Bc98EcQiUf9f4va71w+P58cAILHPOTKDQ7xm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644507; c=relaxed/simple;
	bh=6gRnDTDd9REkJXW+GkcBSk8o1rA+zFVylF5o6wzaZjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSF9D+Wprh+7jVWl6JARJ7q13EmloKd9ES6jyQmvkuWA4vwN7Z1OpG05jvCep0J/FqVBIPM+xgI+JryXRIl2Fn4gJVQKlZW22cXO7mN+/zo729wA0Cd9avIqE1qjjGZ6mnWTd0p4ujvXiJM6CVJSMms9ft7cDIL8p40hcBT16sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+JKSvy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D08CC113CC;
	Thu,  2 May 2024 10:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644507;
	bh=6gRnDTDd9REkJXW+GkcBSk8o1rA+zFVylF5o6wzaZjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+JKSvy9CVQzbimOFktsp6xGEfB+mJGpdHBvLaCCPgzmx0BdnL6YS0S1W/SVcmHjh
	 jpWrlci1P48V0XgFuzEfXtJaJYyNMCXeY1CHDT4oPnJBjDtp2Ubo0BjGCMGwAmqGkN
	 79t9DFvpI5CB2CMcWgcWreTsrdqmO3kuYkcDF93QbS+cDjfI2uL2IbacENBYMOUIT6
	 0WSwJIaj6vaQBv2VrCnVYD2V1QTuNxyYKG2E2nNnEaSt8lj8KBE5uXe652gA1vc8FT
	 LzRbzkDRBFPgiQPvpIkvUzEyHN2WWygIx8KKliw3A3BOAJXvfLfN15xZdWfG4Zv6Va
	 3plA5bgYT1zxg==
Date: Thu, 2 May 2024 11:08:22 +0100
From: Lee Jones <lee@kernel.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org, julia.lawall@inria.fr
Subject: Re: [PATCH v3][next] backlight: sky81452-backlight: Remove
 unnecessary call to of_node_get
Message-ID: <20240502100822.GS5338@google.com>
References: <20240502063621.65687-2-shresthprasad7@gmail.com>
 <20240502093623.GJ5338@google.com>
 <CAE8VWiLP-QR_KaHBPYjA=UVJ8SShpKseB5Xp9Hpkd1RMcvt-qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE8VWiLP-QR_KaHBPYjA=UVJ8SShpKseB5Xp9Hpkd1RMcvt-qw@mail.gmail.com>

On Thu, 02 May 2024, Shresth Prasad wrote:

> On Thu, May 2, 2024 at 3:06 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 02 May 2024, Shresth Prasad wrote:
> >
> > > `dev->of_node` already has a reference to the device_node and calling
> > > of_node_get on it is unnecessary. All conresponding calls to
> > > of_node_put are also removed.
> > >
> > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> > > ---
> > > Changes in v3:
> > >     - Remove unnecessary braces
> > >
> > >  drivers/video/backlight/sky81452-backlight.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > No idea what you're talking about.
> >
> > This patch/version doesn't exist in either my inbox or LORE:
> >
> >   https://lore.kernel.org/all/?q=%22%5BPATCH+v3%5D%5Bnext%5D+backlight%3A+sky81452-backlight%3A+Remove+unnecessary+call+to+of_node_get%22
> >
> > --
> > Lee Jones [李琼斯]
> 
> I'm not sure what you mean.
> The patches show up just fine:
> https://lore.kernel.org/all/?q=backlight%3A+sky81452-backlight%3A+Remove+unnecessary+call+to+of_node_get
> 
> If you mean that the first version doesn't show up, it's because the
> commit message
> was changed to better reflect changes.

Those are v2

You replied to a non-existent v3 which started a new thread.

-- 
Lee Jones [李琼斯]

