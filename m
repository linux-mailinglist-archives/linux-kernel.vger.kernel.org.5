Return-Path: <linux-kernel+bounces-121318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6C288E5E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80D8287591
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444131C8FBA;
	Wed, 27 Mar 2024 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dW5sC5+l"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7651C68BF;
	Wed, 27 Mar 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543610; cv=none; b=NM2pHz4sf8pCovQxnz26Z+nISWNVultoSuEwhh9Ll8ixvxbWCBbBumVl5FsPuLaHnF/02RVFQnb2kT85ZfnUniszrI+Gjoe74C2AKCGyYHU6Qhuyy99kdGBnRip5dQ9ie6zu1T9P4oPCL4blTP/w7ZglVBPIGxuEEtlZDYYK1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543610; c=relaxed/simple;
	bh=0uZGm4eHXrSK7trr0xVtDc+aBAuqPicqVHf0Y0YhXrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INc6PooMiqpDz1mirSR4rhMfUj+QeTx81otUvNfGAvAojEWMlsCfZjUcag0CzkmtvAFBiW6EUfV1fzLnwQSGW5La0f4jO3jsyKsuYPjaEzzZVJ7sP5Y1QtJOJfVQeprGZhCA5CBBlE9MUf/SMjQH2uaga/kddvz85Kao48jWmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dW5sC5+l; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCD87240002;
	Wed, 27 Mar 2024 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711543600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYbi+SG27cQyt835c3LcxP516IwaaFwqWpKWdziu/4c=;
	b=dW5sC5+lOIlM/IkIeroEfKUkyPEgRh7+N0SZsGtJC57m/LlNz/4YyHRIOiwZCFJf+EFHi9
	Y0vP6pjQYKo0tUZotQhx272L2u5E/Zub6lwrvAJ0UJaJYma1kfmF0wfdS2pQE39ckjGCKE
	X6G607+PvrU03HT717z2yl4FkX2gZ/BM8UhHEDo+DTfzM9AP/lyHhsQjvDpQpeLuoKzeso
	Ry1zkgV/yGDgEn1kCqeBRW91bjSxGU/NzctDgqC/Q/xM3qhA7kpI0Fws6R8NOSOu5DaMSZ
	rz3yvOj2e3VsEHDet0PafLWNTolXyCTiZqX1/WOWROmCbJDs5x3RoyqzsWsPWA==
Date: Wed, 27 Mar 2024 13:46:38 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Richard Weinberger <richard@nod.at>, Theodore Ts'o <tytso@mit.edu>,
	Tyler Hicks <code@tyhicks.com>
Subject: Re: linux-next: trees being removed
Message-ID: <202403271246389692cfda@mail.local>
References: <20240327101309.4e7d04f3@canb.auug.org.au>
 <20240327041653.GA35281@sol.localdomain>
 <20240327100421604167cd@mail.local>
 <20240327221819.70455754@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327221819.70455754@canb.auug.org.au>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 27/03/2024 22:18:19+1100, Stephen Rothwell wrote:
> Hi Alexandre,
> 
> On Wed, 27 Mar 2024 11:04:21 +0100 Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> >
> > This is exactly my case. I don't mind my branch being dropped and I can
> > ask to add it back once I have urgent fixes.
> 
> Or you could just update it to -rc1 every merge window or so and it
> will hang around.  I don't mind keeping branches around that will get
> used sometime.  I just don't like them being too old.

I've done that now and I'll try to remember to update at each -rc1.



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

