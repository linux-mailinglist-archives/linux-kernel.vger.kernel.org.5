Return-Path: <linux-kernel+bounces-7090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2871D81A185
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95EA287161
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86263D992;
	Wed, 20 Dec 2023 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg483YHl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0765D3D979;
	Wed, 20 Dec 2023 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c6ce4dffb5so2061882a12.0;
        Wed, 20 Dec 2023 06:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703083992; x=1703688792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eBS/M67eqFyB1dRDgBWV3AQl//bHp4H9z6F6Hon/YZM=;
        b=Wg483YHlO5WZt/L61/Ku6GShhIqB/biaiQIt2VG9gUG202KSJKUGyoUYQE4ORPKnrW
         VhDeHPEKuffZVXKXF1cGTFNy+fk0KbcOaNmcMM6glzLVU44CXH+OmLT3OVqh2Khe58w5
         lFQGbYwvYgch2JrWVb2oXEEz6X4FZ3RKORDsELLluRxmQzoK9VoBPpXXYda6+VptE/xY
         X8ArlBvNpvny6Vq7FqXTL/J6VonrNKpLPrRhTMZmSZ7mMFpSt0FmXelPl1UlhJpE5hZR
         EEbu7FxU6MdpBGnfBeuRtHbv5m/B1XorrSOhoO7wNK7CMOQ8U8JCnGnz4cF9JCocBxS/
         D2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083992; x=1703688792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBS/M67eqFyB1dRDgBWV3AQl//bHp4H9z6F6Hon/YZM=;
        b=erk8JrEC8KYxTBA2qYcJMafTUun/QE3gZf+IO/lHXdH11zjAH78J0wFqhMYF1T98TH
         wa+OmgZqQJRPfD+xEyIMsr4XGyRtXq78yZ0LDkxDeFfriv3FqLevW/X1IRJ27GB9YtPm
         dQ2hJbvZQlSET09ui+sD9gojaFAy9mpYNXS9/M6wFPzoLqJthfymc4aQXD7BX7bB+Y0l
         F/igDyuzKibOOd5+5mNtlPILl8bJ5KrDzMIfZhyWN+CHv5wayPbl2Ik7XvuqZ0KJXIVe
         noAcfCoe+QS88MGWCWy3eWCXETdljzSOeSXCp6oU5IvUlGILIPFyO8hWQF1N5AC9YlDH
         wcZw==
X-Gm-Message-State: AOJu0YwS0yuYRNfaAW/fGfWYK8lYwzdq6DIqlC0w9RFmYlwDUEVYdXPy
	qZyPOssTcHVyBiSqDmGiIg+bpnMZ2f0=
X-Google-Smtp-Source: AGHT+IGCCAAnChMaFv2ozcGwL6o/84T34DDxfAc4YSlmXTw+qeV3JByCQsOSpoA68Gqc2pZmYDx6kw==
X-Received: by 2002:a05:6a20:3d82:b0:190:c386:3eb4 with SMTP id s2-20020a056a203d8200b00190c3863eb4mr10083440pzi.47.1703083992154;
        Wed, 20 Dec 2023 06:53:12 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id b31-20020a631b5f000000b005bdf59618f9sm20910003pgm.69.2023.12.20.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 06:53:11 -0800 (PST)
Date: Wed, 20 Dec 2023 22:53:07 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org
Subject: Re: [PATCH 2/4] gpiolib: cdev: allocate linereq using kvzalloc()
Message-ID: <ZYL_077xycZ0ZVBy@rigel>
References: <20231220015106.16732-1-warthog618@gmail.com>
 <20231220015106.16732-3-warthog618@gmail.com>
 <ZYL6gIpG5GBONVSO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYL6gIpG5GBONVSO@smile.fi.intel.com>

On Wed, Dec 20, 2023 at 04:30:24PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 20, 2023 at 09:51:04AM +0800, Kent Gibson wrote:
> > The size of struct linereq may exceed a page, so allocate space for
> > it using kvzalloc() instead of kzalloc().
>
> It might be this needs a bit of elaboration. The kmalloc() tries to allocate
> a contiguous (in physical address space) chunk of memory and with fragmented
> memory it might be not possible. So the above issue might (rarely) happen.
> In most cases the call to kmalloc() will succeed.
>

For sure, the kzalloc() generally works - or we wouldn't've gotten this
far as tests with MAX_LINES would've been failing.
We are targetting a very niche failure mode here.

The size allocated can only be determined at runtime, may be more or
less than a page, and we don't care whether the physical memory allocated
is contiguous.
As such kvzalloc() is the appropriate allocator.

Are you suggesting repeating the relevant sections of the
kmalloc/vmalloc() documentation or Memory Allocation Guide as part of the
checkin comment?

Cheers,
Kent.


