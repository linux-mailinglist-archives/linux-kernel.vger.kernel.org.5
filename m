Return-Path: <linux-kernel+bounces-56581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6883D84CBED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130F8289586
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE377F15;
	Wed,  7 Feb 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D6XHv7C9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42776C9D;
	Wed,  7 Feb 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313777; cv=none; b=Wr87gZVFG6aMBgjNCtglwBOKFTsiZ9FqIG5ERD4nOs3Do+bFerYERybZSMCcd8OWvggH94xuVp8GzEBQabKCQ6Mfh7QkY1TsQDSeiZAA60nxndR0EB8c6UxaqeeC1Vuz/kmj+jJuAybEvoBcCV/iQeuw3i0w896IY/e2I+wZ9Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313777; c=relaxed/simple;
	bh=gagwzctTYGVLM9lNLbemXeMrrifQ3wVeVx/2WJycYwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkKWnaU7/Q3ipP0d/VBOhj8+QmdBDJM6CTBLnTMfBBfP4EQ59dR0/S9XGu+LMGfwxJlNFhjuXcu76A9PPlWOBNaNt4QuXCmZPcS/ryua6gKFRWWhnxW6gyo1Ynzwu6eGExhBnOA05CweewKGsF8d9gFcEgo9oJ8X2TFhWu4qdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D6XHv7C9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86FBC433F1;
	Wed,  7 Feb 2024 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707313777;
	bh=gagwzctTYGVLM9lNLbemXeMrrifQ3wVeVx/2WJycYwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6XHv7C9/xyB9I+LZ9WFz6TfoYLqte6dwSaiKfS91tD2N0Q/5xfjDkz9+nnRAwSB6
	 ZavivR6e9fMyjXSyeFwQuEssUUwOaCKNPA9CeNJh3KMLeEUNKL8kRu4LijNWwyunPt
	 6yI7F16s2EVkZI7HavO4JBKLYOHbHJBOineFq5l8=
Date: Wed, 7 Feb 2024 13:49:34 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: set device type for GPIO chips
Message-ID: <2024020723-arbitrary-harmful-53c3@gregkh>
References: <20240201162758.50733-1-brgl@bgdev.pl>
 <CACRpkdbAw5NfSr8GSNiQhOzSi-tERyn=-ZroLfF-FRbsW2JviQ@mail.gmail.com>
 <2024020732-duchess-husband-8b1b@gregkh>
 <CAMRc=MeWD-4xx9Y=P3ajO37XJAsBrZ2TyqNeCE8vkxXW1yXWVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeWD-4xx9Y=P3ajO37XJAsBrZ2TyqNeCE8vkxXW1yXWVQ@mail.gmail.com>

On Wed, Feb 07, 2024 at 01:19:37PM +0100, Bartosz Golaszewski wrote:
> On Wed, Feb 7, 2024 at 11:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Feb 07, 2024 at 11:45:39AM +0100, Linus Walleij wrote:
> > > On Thu, Feb 1, 2024 at 5:28 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > It's useful to have the device type information for those sub-devices
> > > > that are actually GPIO chips registered with GPIOLIB. While at it: use
> > > > the device type struct to setup the release callback which is the
> > > > preferred way to use the device API.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > (...=
> > > > +static struct device_type gpio_dev_type = {
> >
> > Can you make this structure const please?
> >
> 
> I have, there's a v2 on the list already.

Great, let me go dig that up and do a review...

