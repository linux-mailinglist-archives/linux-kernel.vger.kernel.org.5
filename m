Return-Path: <linux-kernel+bounces-41325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84B83EED4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B0CB21D6F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1612C6B9;
	Sat, 27 Jan 2024 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ4ee8/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0A2C6A3;
	Sat, 27 Jan 2024 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706374412; cv=none; b=Rxd+ULAYm5SI6F58ucRttFwxP+D4yJNvvL2Oyzz9gGlvjLvqGyZ8/B5tuWsabAUutfekfApR09HroTjmvDuAcwZRgIuNSNZM1lhqQmDNVUFxTdTB0fbc1wucB0CjSEteqLkVzDXcYOdS/F5HyvOgH8phNiT3h6SYUcmu2+xba8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706374412; c=relaxed/simple;
	bh=MX45WUOWLd2cSbO/xPGKCwWF+f0wsVvtOSqsJXMyhnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDwUJuMxpciPK5JdX7M+F25RBw/hRJx1+yEemZIX1p5We8uBJwosrYKyY0YuwUVstfJtJqHqWm6aazYR7uameoUnHVnuwfPeGZfbCFkmPtV/+EojqbmyOq0BReU+Nu7aHHktEJaU4UipnUsR3uRpfv/n5o8Aat/5qrphWoELgfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ4ee8/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1361C433F1;
	Sat, 27 Jan 2024 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706374411;
	bh=MX45WUOWLd2cSbO/xPGKCwWF+f0wsVvtOSqsJXMyhnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eZ4ee8/JFVeykeATtiIcv4RZP1QDh45QJfCjFceYqScVjOJq+XvRdAGBvAxJQS1xb
	 slZUFAJw0ZUcAjYoaNiLSMtr30jppFWSktflCND3a++rQ0OSyUh4wPI+3evv1S6H2h
	 IaXGL8KzisDDvEct/5LQpI8qg1YZO5/du6Igtmv+IqehFi45d/uNeSyYqUkwxa+7Yq
	 KKHqFn/dPfIaIfxROW13eUc98cn0BankLc8ln9mxDPDCzKc/R/iIxCBsloMbxWWGTE
	 rz4prQ6tTS5LTAGQkEV2Rh96WACyIExl/s1LBC8yZ6Lii/v+ZjBx0b/aZa8ibsKM03
	 sINnUjpH9Eamg==
Date: Sat, 27 Jan 2024 16:53:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "iio: add modifiers for A and B ultraviolet
 light"
Message-ID: <20240127165319.795eb8a2@jic23-huawei>
In-Reply-To: <b1cfcc79-d9c4-4edc-bdaf-2080b44e77eb@gmail.com>
References: <20240123104305.10881-1-paul@crapouillou.net>
	<0bd3319f-7d63-485b-9b44-d6858c045b37@gmail.com>
	<a6f79ec0025e1862ba170c6a535447dd09e7dfad.camel@crapouillou.net>
	<efdfb611-5ba4-4cd6-a7f0-bd96259cf1a6@gmail.com>
	<20240127155247.00f6aa3b@jic23-huawei>
	<b1cfcc79-d9c4-4edc-bdaf-2080b44e77eb@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 17:08:28 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 27.01.24 16:52, Jonathan Cameron wrote:
> > ...  
> >>> Can you just move these entries to the end of the enum in your new
> >>> patch?
> >>>     
> >>>>
> >>>> Thanks and best regards,
> >>>> Javier Carrasco    
> >>>
> >>> Cheers,
> >>> -Paul    
> >> Sure, I will do it right now.
> >>
> >> Thank you again and best regards,
> >> Javier Carrasco  
> > 
> > Hi Javier,
> > 
> > If you sent a v2, it didn't reach me or the list.
> > 
> > Jonathan
> > 
> >   
> Hi Jonathan,
> 
> I retrieved the To and CC with b4 and it seems that you were one of
> them, but not the iio mailing list, maybe because the modification only
> applies to an include. The linux-kernel mailing list was added, though:
> 
> https://lore.kernel.org/all/20240123-uva_uvb_fix-v1-1-5b9c25d50d90@gmail.com/T/
> 
> Could you apply that patch like that or do you need a RESEND to the
> iio-mailing list?
Please resend.  IIO patches are all tracked via patchwork which monitors the
linux-iio@vger.kernel.org list.

I also use several mail accounts, so only easy way to ensure it reaches
which ever machine I'm on today is to send it to the list.

Explains why I thought I'd seen it during the week but couldn't find it today though!

Thanks,

Jonathan

> 
> Best regards,
> Javier Carrasco


