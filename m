Return-Path: <linux-kernel+bounces-109455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C60881979
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1331BB2116C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF933381AA;
	Wed, 20 Mar 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfC5lqXb"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F312E52;
	Wed, 20 Mar 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974111; cv=none; b=mojlw9YvJiTXPlEAGUzN//kqvgs6uksa8q4HNk3hfEiV9LC/75igOkaQn5iu5mblbWjyFcS9d8DStg8UNdnWt8aU4E8QjhmL5BRsEbeXYvtNFQr5ftzs+Tsdg4tuYmry5KMc+mpqVvK0oO80hhKBy4a3DCbyyHWcodSPyFvLhDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974111; c=relaxed/simple;
	bh=/fsBbXw03619bUqlEGeLUsRsq6EMtANrA9Jhs5wFcvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXKUH4oZKCwia1AvbMUvVx1aiuyNuHiwncIUsLSYfAncrhlI+1Q3Q4czbtc9hPKt64CHwk4z8XSIVeV4LaCoERgrJjJrSf2GTAFU7BLzaOtETF8whGfJH6yykQtUSIR/ivMfdqNVx/MZfTJZxT6clDkbaVJxKjMuiBOYeNbNN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfC5lqXb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51381021af1so623929e87.0;
        Wed, 20 Mar 2024 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710974107; x=1711578907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6uLkytCveodnbEWWcUmeLnZpizFS2D2Bpb03TRInaE=;
        b=TfC5lqXbdG75Cw1pRoBG1lxRBLQ4mCUhENBzaN593gWlGlAxL+kIGsij0FMpbRSo9M
         JbbNvj4OqXNoTGtd3VEwmFeUizojmVC4J0fzeOC5UYMlFR+SE/EJSn3B4p4WpDMTye2d
         HDh7xFinFC8rDlbJ2ALJO9P14tMsWEGxu7fVEQOb7Waw8LpxA0B7skQBxN5wF2sPd5S4
         kgajKofxzxauzwppfc2QMD0B4WPlVQpK5v10iTigfoAU0fwHfjzlrJMp6XC0xxbKXS36
         nsF/ppQgJRmJj2baKekZcnUePPN7F7v/qzcTK9UG/0sWutH6uI1YadaIBol1SnWrLFdC
         T1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710974107; x=1711578907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6uLkytCveodnbEWWcUmeLnZpizFS2D2Bpb03TRInaE=;
        b=sDZaLdST2SUTPqMZIbYtGyaajklRZ4PiWtRnAsTkgXbx3ZO39sggIoKTO6tZNk6E3F
         yajc5b+nWc4++IGfbbkG8G5qPM2SXwM5zlYOMkZ4RSZSg/quGI0QmWEbYYo758zCZ5gk
         9xw7GGzXKgsOXbWZOcKYEY4E7jwtr/+83ef2ICUJFO1UHMUOG1jubtk0ZE+u7SEnYqhP
         9/iuQKsGRsraKm3NSjHIgI3HQcNA0CIPTBiI5eTZ09DdbNwF1bpzfR29RZQHsSY6WeFl
         40TT/uIewy7h2RIxw3bMHfHutKpRll12EDpYd8VI5iAO3VKodtlXgAo/qPK2uRkxNkQW
         LeSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEYfcav2a7ZswySdgvSlYHcCJriFaSxZAHlAss1hgiUlJN5MD3kQjIHa6VQWuev0TemXGcFrU/sGca9W5dJnhFAoXa0VsCbKZXSSAKtuPdgi9rKwlvFJ9X44nldCHv9yCBDOAgG57qFXHfsVsUePl0uOzHlWdx9f91f1meCdMj
X-Gm-Message-State: AOJu0YwtoKXbbv63cFASMgjw6UlXrXgqWaz6gm5FdSJFJWf02KTUmIZM
	GRXT0mhT5Mxm8lcOKeH8HaqOyURMHT1CCe0C6Bw79/6ndbkmkx6cExaHl/2qMetOdQ==
X-Google-Smtp-Source: AGHT+IG5bitWH3Wn0hUC64Y2ptJDiGS2is9++uKcULphEyCayziP1oG59fDb4lRmo1n/NpFN50q/KQ==
X-Received: by 2002:ac2:46d6:0:b0:513:d372:20e5 with SMTP id p22-20020ac246d6000000b00513d37220e5mr290631lfo.16.1710974107030;
        Wed, 20 Mar 2024 15:35:07 -0700 (PDT)
Received: from fedora (host-95-250-206-50.retail.telecomitalia.it. [95.250.206.50])
        by smtp.gmail.com with ESMTPSA id an14-20020a17090656ce00b00a465b72a1f3sm5262273ejc.85.2024.03.20.15.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:35:06 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:35:05 +0100
From: Francesco Valla <valla.francesco@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	fabio@redaril.me, linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: networking: document CAN ISO-TP
Message-ID: <ZftkmQfna3HIyYal@fedora>
References: <20240313223445.87170-1-valla.francesco@gmail.com>
 <20240313223445.87170-2-valla.francesco@gmail.com>
 <20240319120625.GI185808@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319120625.GI185808@kernel.org>


Hi Simon,

On Tue, Mar 19, 2024 at 12:06:25PM +0000, Simon Horman wrote:
> On Wed, Mar 13, 2024 at 11:34:31PM +0100, Francesco Valla wrote:
> > Document basic concepts, APIs and behaviour of the CAN ISO-TP (ISO
> > 15765-2) stack.
> > 
> > Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
> 
> Hi Francesco,
> 
> As it looks like there will be a v2 of this patchset
> please consider running checkpatch.pl --codespell
> and addressing the warnings it reports.
> 

Will do before v2, thanks for the suggestion.

> ...
> 
> > +Transport protocol and associated frame types
> > +---------------------------------------------
> > +
> > +When transmitting data using the ISO-TP protocol, the payload can either fit
> > +inside one single CAN message or not, also considering the overhead the protocol
> > +is generating and the optional extended addressing. In the first case, the data
> > +is transmitted at once using a so-called Single Frame (SF). In the second case,
> > +ISO-TP defines a multi-frame protocol, in which the sender asks (through a First
> > +Frame - FF) to the receiver the maximum supported size of a macro data block
> > +(``blocksize``) and the minimum time time between the single CAN messages
> > +composing such block (``stmin``). Once these informations have been received,
> 
> nit: Once this information has

I never grasped the usage of "information" in English, which is not my
first language. I'll make this correction here.

> 
> > +the sender starts to send frames containing fragments of the data payload
> > +(called Consecutive Frames - CF), stopping after every ``blocksize``-sized block
> > +to wait confirmation from the receiver (which should then send a Flow Control
> > +frame - FC - to inform the sender about its availability to receive more data).
> > +
> 
> ...

Thanks for the review!

Regards,
Francesco


