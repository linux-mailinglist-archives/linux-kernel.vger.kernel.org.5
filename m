Return-Path: <linux-kernel+bounces-74954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DADB85E071
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF781C23F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792180047;
	Wed, 21 Feb 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxcv9QCS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D427FBD2;
	Wed, 21 Feb 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527786; cv=none; b=SBm3aWuyt2+Y+HXMFNEYFbzHj3BMXZ5zHN5A6VZMgAJNi03n1Qc3YYsnPQ3/3i5PKa4wM5jkF0Xp5PTNWgUjLGieTMKCe8Zv7MpXnAHzHQFEfWj10PY9MEYlM8eCtbq87YS0hUfJwEqMhli7tOE138/vZH+E0CHWKYcAsIsYnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527786; c=relaxed/simple;
	bh=1CtEOyx2YcI+N1p30TgJ+jc78ftKgIOaBRAAhCXGC5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slg4yrWwckUtoFYPb8r5T3fpEmZ2zA26m1zzvSHA7k0cwwKGPvmKhAn6YW+I4uaiGk91hvuNODwDDHW97zKah9XnCqYnBZup05ZVA0mpRfBbvoVPyNUtKXDhNUVq5RsxGZyd7B0q7cgVbJkEJKAhHiKLlwnP6XQ+TazGRvYslds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxcv9QCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A41BC433C7;
	Wed, 21 Feb 2024 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708527785;
	bh=1CtEOyx2YcI+N1p30TgJ+jc78ftKgIOaBRAAhCXGC5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxcv9QCSmf0h6efzbD/gnBpg7HJE4h7qF6Ay+rxFcgymR8Id49/wB+NnAtWSYm8U6
	 5RcrNlJhPxjyw7m7IogkoGect8UklJ37b4vtBr8mCxhHdAdaN9g4KRGRPwEo4adOOQ
	 1ksaWTQkNkMlvo/CGshXs86mgZO/RPltpXC9D8hFgV3iebTxzSkGIt/t6T2KRe4szb
	 1dK7fIXjOKBhz3P05lp+ycpjse4fe6tRcFobaOkWpT78UZz674oZcnDQp3rVcLV8qp
	 YVy0fzOkolTtRdNMShRbqovzuVrD6ZEafc48cUKYKKg2/kuRuAmjq+i1OFgeY3OORO
	 W2qU13medhlfg==
Date: Wed, 21 Feb 2024 08:03:03 -0700
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add missing prefixes used
 in compatibles
Message-ID: <20240221150303.GA2792906-robh@kernel.org>
References: <20240216025839.902288-1-robh@kernel.org>
 <20240216-percolate-wooing-b5e4f6814d15@wendy>
 <20240220163845.GA3606739-robh@kernel.org>
 <20240220-colonial-shame-e217e4399184@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-colonial-shame-e217e4399184@spud>

On Tue, Feb 20, 2024 at 05:51:37PM +0000, Conor Dooley wrote:
> On Tue, Feb 20, 2024 at 09:38:45AM -0700, Rob Herring wrote:
> > On Fri, Feb 16, 2024 at 08:59:56AM +0000, Conor Dooley wrote:
> > > On Thu, Feb 15, 2024 at 08:58:29PM -0600, Rob Herring wrote:
> > > > +  "^calao,.*":
> > > > +    description: CALAO Systems SAS
> > > >    "^calaosystems,.*":
> > > >      description: CALAO Systems SAS
> > > 
> > > > +  "^IBM,.*":
> > > > +    description: International Business Machines (IBM)
> > > >    "^ibm,.*":
> > > >      description: International Business Machines (IBM)
> > > 
> > > These ones add duplicates with no indication of which one is to be used
> > > going forward. Why not mark one as deprecated?
> > 
> > Because I couldn't decide which... It's a mixture with no clear pattern 
> > of on what or when each one is used. Power is kind of special.
> 
>  That might be true for ibm, but is it true for calao systems?
>  The website appears to now be something to do with Korean gambling, but
>  the twitter remains and looks to have produced arm sbcs:
>  https://twitter.com/calaosystems?lang=en

I used this:

https://en.wikipedia.org/wiki/Calao_Systems

The company went bankrupt in 2016. ST based systems used one prefix and 
Atmel based systems used the other. Which do I pick to deprecate? I'm 
not expecting any new boards either. 

Rob

