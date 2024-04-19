Return-Path: <linux-kernel+bounces-151058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748F98AA870
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2895D1F21F20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665C328376;
	Fri, 19 Apr 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdDrdKlb"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA32745B;
	Fri, 19 Apr 2024 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508136; cv=none; b=YSPOwkPiyeyw3SbsVqMI3K3KjiZ4JoiBhdNIBpKefrgxVhgGb4nYzhIWBq5qz2ayvznfkgjvZJ9QhOYwKdVTVNwN7B5jdLNe679cFMMFimhUWVSZIRqlVStTLmvBgsBHzjvQ9Tq0W7PlqFRrKj7bv8oCEq2WoD3BY/tL+ufZwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508136; c=relaxed/simple;
	bh=1UYTzjz+pfqOH0vYxIvJvyzR/zOW4BG72BXR0p1u154=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQeQ+pfkmoQ/+5DJEMXaJztTXjBYvH8ByKZzfetfH+2DZscYTmE8SWTCu4kLS+0V13oPsFUMHFYE43By5MhGsXkFNwi8I271zU09bQJJsIgyWK1kV1vL3FlbRpHLzC0OZEXs63Ylisaoct7Qt5X4LRQHzqBl/PLtnMAkz4K/63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdDrdKlb; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de46b71c1abso159610276.3;
        Thu, 18 Apr 2024 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713508131; x=1714112931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mu6SkIqkO1DyCIz7So1K9fJm456SRdCmYKFj3MeAB8I=;
        b=BdDrdKlbjei8+hR0R0+9m3ZAtitnVnDkgHzao7o87vYYH/4Ff06NXTF5kEgu06akCp
         74GO0z8eSusDBO/0Hh8DskMqM/ZIo/N7KmP31ywejzSzta2mUV/yOdkSJnH7rQyagF/N
         Jyz3TEmxddrHutwdlybuk5k5hRNnJoi4pFfcx//tt7LVCYwoq9nnG1CZn9+QIykenD6X
         SnRl7+30682eOp8r1F5ZnbUF1oh7wsFYS2HPC42oeqUPCvO6aSSNQRHlM3eaXG6pAr2C
         rtfqXlZbIoppnakSzAO+oyCIjeVs2Ht+meKRwXYA1zt1BqaTK/LjEBycRoK/3s9dc0oY
         BzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713508131; x=1714112931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu6SkIqkO1DyCIz7So1K9fJm456SRdCmYKFj3MeAB8I=;
        b=eGPGaTuetpdsK8TqpIl3ze9aKT2Rkv+t6uA34cp2FxSyk4WKxT+rcXPPtZiSWI8zNW
         hhV+vuugSuuailA+zdqn606RHizmEyYT2tCJmfHtNdK7Ckhy9j56DZ+wrh4/YjW2HyMk
         85bgCF8vPb3toh3o8vFmVRNRpcyGX7BRsKwWf56U+hQs+f4tXlr4eHn2zEdNA6L2t1c0
         lYHTlo53+Fco+BplDr2Twa1izIHNWs56mYtH7OWx7LdSOUPzQVBRVrE0J0iNdT159cwd
         gE0Jagw3hNeWcZNZTQXBWGORaqL+NgsbAYxiOp+C7p8EioSpEEHLRNUQytn36W6qNPnr
         TyxA==
X-Forwarded-Encrypted: i=1; AJvYcCXtXMevB2abGWepwXsbw7w5QxsXkyJX24IxdC/myr4k1dJoxQy/tunXLz2ddakqyjotU4XwKV1ZwnfU9HojNGUgZaTTjIvhYC6EFnmJORMI2vYGwIsAh5IloUq4EAjKh93xZRq2
X-Gm-Message-State: AOJu0YzGCpgkNvIa5X3qF7jTQrFY6GZVXd82F77/4abT6l1GbL9sjXI3
	x0vG69zhLUy8Ry/BS2p3AA/AkLZF4VChDQZUMbIsKl+43+pzYVrzIPmqSQ==
X-Google-Smtp-Source: AGHT+IFDUH29AJHHr/RUj5RJX8g6snY89358+97NBy5vs/DROj+pB3IKyK024avmMDZ4GFdvckcpKg==
X-Received: by 2002:a81:6c13:0:b0:60a:58b5:891c with SMTP id h19-20020a816c13000000b0060a58b5891cmr753592ywc.2.1713508131354;
        Thu, 18 Apr 2024 23:28:51 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id q39-20020a814327000000b00617f096f95asm667478ywa.16.2024.04.18.23.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:28:50 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:28:48 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
	Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv1 next] ptp: update gettimex64 to provide ts optionally
 in mono-raw base.
Message-ID: <ZiIPIKM1rH7J-Pok@hoboy.vegasvil.org>
References: <20240416215942.150202-1-maheshb@google.com>
 <20240417182445.019fb351@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417182445.019fb351@kernel.org>

On Wed, Apr 17, 2024 at 06:24:45PM -0700, Jakub Kicinski wrote:
> On Tue, 16 Apr 2024 14:59:42 -0700 Mahesh Bandewar wrote:
> >  		if (extoff->n_samples > PTP_MAX_SAMPLES
> > -		    || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]) {
> > +		    || extoff->rsv[0] || extoff->rsv[1]
> > +		    || (extoff->clockid != CLOCK_REALTIME
> > +			&& extoff->clockid != CLOCK_MONOTONIC_RAW)) {
> 
> Since you're touching this condition it's probably a good opportunity
> to fox the coding style.

What is the CodingStyle violation?

Is it starting a line with  ||  ?


Thanks,
Richard

