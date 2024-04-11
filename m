Return-Path: <linux-kernel+bounces-139774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 190118A078B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831261F24CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE113C814;
	Thu, 11 Apr 2024 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Ccv5FjoL";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Yc2LXSdw"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECB13C693
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812740; cv=none; b=ZH1lYo29SOEzcnmGFUjdnabEaL8QUzksj284whBltN3BciR33wqpZojCVwFjFxj/1a8jJmSs+uJzoAzDoQXiOCVn+d9Ko5tl41GBw5ioXQ9HcSwohQc9kRSfF9FdPnKsdDYhTin0ew/CfLpghkz999nisgxY60LSE/w/XBIImCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812740; c=relaxed/simple;
	bh=+3l8UbUUZkN6lp2JD04jeJySfez+JOB3Ahyd5svuMK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGwq8JNf4/x2ERdanSGK+qhFqBGukJZDayq7qFPcqtD7VfSPIimWEhGTEGAyFlXhFxP3MKgWN3chGt3aR4rELYe7jZtFf0efZ/ikM+SQoOVpKCeWX/sE/N4k9nLBb/lCZV8Zqu9Rz9f/SVh7tRMYaIQkoPGhItfTUakgig12I60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Ccv5FjoL; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Yc2LXSdw; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1712812283;
	bh=+3l8UbUUZkN6lp2JD04jeJySfez+JOB3Ahyd5svuMK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ccv5FjoL2sQoSiUUVocDFpjEMH7Z21hP7WGi74eC/32vurf1xnXiqoGCkshYZa8eJ
	 79rwacS+C2uwXMEhuAGwDA6sEMugfZdWAt5OI4/f58+S5KhWKniu7m5CAF4j8GZqyr
	 pVfV/mCIjfxPwAy4eK7vdqRHWvpUb1VZK6gVW8jHvkEitpSM8kt2Z4lhRNpgZepjal
	 aFSeeq7PzHrkp68PimSrH+jvJTnqR11qKLp5mj+dIk7s7z1W9YEIVnQcRgEcR1JoAI
	 ilDNUeDNmgYlN497W4RcvZahp3GOgQbjVBzI44MCNvqHZetV/EdIHINNnddxZHeSzi
	 LRS/UyKx2SQXw==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 6DF25B9B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:11:23 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=Yc2LXSdw;
	dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id DF56CB9B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:11:21 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e51108b454so7546215ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1712812281; x=1713417081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYM4XEihFnPGvzUAhdJCr4dtkp/ouRs0QzEOXLER4XA=;
        b=Yc2LXSdwUvI7Y9P2B6j1mXa+zKDVh1VyMNrlE65RPEfzH31oAufqmmOJH4fGIE6aWA
         H3iywtIX0i0Eb7xHm7fUngiDpcQfFB5BfjAyCvEP+JW7WVj5OOGiQk5xfQ0esgZgCOwT
         wJ1OkZJLIhDGwKXBuWlQUPc2FVIXWC7cTQ1/BRYEDSevahciUeWZC74Uc8MUtuQ6DERS
         02cZxSkZU9vgfkDoubLgXJM3tbxWkPlZ49avm31wdlmhz1feIAD+RzAqqEIixBuy3gT8
         MtBrpeZjcZg2gEWHt8InU2yoomeNUccXsEAnCk0DcKX3rpDfw1kK+QKBycxYbk0OkdkQ
         F9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712812281; x=1713417081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYM4XEihFnPGvzUAhdJCr4dtkp/ouRs0QzEOXLER4XA=;
        b=mf5bHugdPbZmZRXElBCihcuO2W3B6LbuOhaPfO7+aYMf8QC6m3rMuAIgS76WIF7oXf
         GOJJ+uRuYPXfzaXPevzzP0BRUGOKFYUOaixZxCKFEltAq3Q6mxgG8gGST1juwpYVBvi2
         Bjvo8b26YElpLXKXuzuLG0UtbSRMIsi8VkAbVl+MVpLosRi5oTJae3fsJXeRBJLea1pa
         nc+/czlHn62HsGkiKcdm6nXwWXq9ZQx5Uwyz+cZoRomjlAmD3kFtFAbVVSlz1UEBuI9C
         mB6etDchYZrYnLBCJdp3r1d956tYyUum6ilHM2li8/6StnGbFsLAcP55Ic5GKaAPQSx6
         7GpA==
X-Forwarded-Encrypted: i=1; AJvYcCVFuzNHMmzdRvi8FiL/jnUADRhwaL6J/DYzSs+ydKX02cEHCxMOBk4I+EHOQElbOAS4q2olcmDRzWiMmo2uuRTNKyyomByVL5VhRe+m
X-Gm-Message-State: AOJu0YwjKthP2lw/OUW8USzKTqYy+2C7Q0gDA0exLD3NB+zXfBQWbFQ1
	BzyUEiGzy7Q3bgCXHbNb7vY4AOzCl/gpjMKr6HcgQqfzEIZfeki6wd6WyaMg1fPIIv68/OJWdab
	QmHeH4oIsVGfIetHVgvTepBv5+856Iz3YZnIB/cmLs2TpJgk2hrK2iuQfwORmFQw=
X-Received: by 2002:a17:902:a506:b0:1e5:2883:6ff6 with SMTP id s6-20020a170902a50600b001e528836ff6mr2439151plq.11.1712812280799;
        Wed, 10 Apr 2024 22:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPz2rOs7Q88TP2vpTyjyricUo5wqvT4PCM1GrqrEBYpN9J4sruu7OeLfrUYQtbbQepJwvbww==
X-Received: by 2002:a17:902:a506:b0:1e5:2883:6ff6 with SMTP id s6-20020a170902a50600b001e528836ff6mr2439129plq.11.1712812280404;
        Wed, 10 Apr 2024 22:11:20 -0700 (PDT)
Received: from pc-0182.atmarktech (145.82.198.104.bc.googleusercontent.com. [104.198.82.145])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902d50a00b001e0f5034e95sm417774plg.288.2024.04.10.22.11.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2024 22:11:19 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rumiU-009uEk-2P;
	Thu, 11 Apr 2024 14:11:18 +0900
Date: Thu, 11 Apr 2024 14:11:08 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <Zhdw7GPdOe2nOhJy@atmark-techno.com>
References: <Zd7qz1Qte8HWieF_@atmark-techno.com>
 <20240228142441.00002a79@Huawei.com>
 <Zd_zB_ymxkx0HB3q@atmark-techno.com>
 <ZfPg-nMANUtBlr6S@atmark-techno.com>
 <CAMknhBG_kJx8JPvTBQo7zpy3mFAkUjZpRY3DLBfXt+39nRJWiA@mail.gmail.com>
 <ZfejyEvPIncygKJ9@atmark-techno.com>
 <20240318122953.000013f3@Huawei.com>
 <20240331152042.394b4289@jic23-huawei>
 <Zgpt136Q2rGL-cl_@atmark-techno.com>
 <20240401174756.0000786a@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240401174756.0000786a@Huawei.com>

Jonathan Cameron wrote on Mon, Apr 01, 2024 at 05:47:56PM +0100:
> Good luck.  If you have time it might be good to hear what you end up
> with!

Just a quick follow-up since you asked -- given we manage our own kernel
that already has its share of patches and it's not something
user-visible we'll stick with the aliases approach for this kernel to
make identifiers static.
(and I'm adding labels for meticulous users, but not expecting it to be
used in practice, it'll mostly be used in automated testing to make sure
the number doesn't change on our end)

The rationale was as per my previous mails that paths in
/sys/devices/platform have changed in the past so we'd rather not rely
on these being set in stone, and while a new symlink would have been
workable it's a user-noticeable change so we've prefered just pinning
the device numbers.

I'm always reluctant to take in more "in house" patches in our tree but
in this case it's "simple enough" (death by thousands paper cut?), and
we'll rediscuss this if/when another upstream solution shows up.


Thanks a lot for your time thinking it through and discussing it though,
that was appreciated!
(Jonathan and everyone else involved)
-- 
Dominique



