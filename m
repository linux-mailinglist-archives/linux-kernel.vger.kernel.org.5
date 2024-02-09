Return-Path: <linux-kernel+bounces-59053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF8584F079
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55EC28120C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087B41AB8;
	Fri,  9 Feb 2024 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eqGvwdxR"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1456B71
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461732; cv=none; b=KAqDYwxIdIqb5945eI18Wlh0PneRz6iAhAEsLHJSGx4JNLMinUfvuSLm/sY6d3A6h0ZSwf1j6n77QwRgcSHS2W+No3AaDQcwoQ6S1SUAAClD18H9TRKzwrIHxbDxb5O1sjMylHaA6kyY14s4O10dFyXVib3gFWyJjTn580lolOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461732; c=relaxed/simple;
	bh=711cHkfsOgZL9MPEIGbLJw6rxtGeCrt5XH4lwE/BkYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpFaFoGUb5/0z+0OAs25kiBi7qfhz8JXHiWyOyiMTslIZpReaCXWTdO6xEl1nw+eAAvt4UMfn92hoiuW4SgDzqazBDzHtQ0gRbm0OjGLucTB/L7V1vj+WgIKCa9STsFNlu4QZeJJv49WCQaOpKsj0cnaY0LRu2Vyha/IQHFpIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eqGvwdxR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4102f273c46so5598385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 22:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707461728; x=1708066528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdmhTFAG6NaVssbeznKI3+O6lsTy9x8b3RBjAgRQHbg=;
        b=eqGvwdxRp44etQhRBblUs8VkRGXVUfA2vnANJVH8uElAkHKHFfXhULxGOyvf7xVnZ4
         kImY/S4awjzl76fCWYqB9BRHnsGwOMcCVvyjTAuaCd8td5ZMwyo1YhxyGyR9z1PcJPD1
         FDbO1Njk/o5S84xg14Zh8Hw06B50ZLaVH698037NfMisAbYfBM2cxFdiBsYz9RE2Y9iy
         N5K1CAls9q594WUBOgL4HNhzand6c/kmhto2J/SiMfayedlVBKMl8cZwBLCQeELdNJhT
         vOJiuV/cOdAS1qKK6dk9tChNb6QBJCv4bEwds/Q0oUIBFh250gnBWWENXEuLXVYLKopB
         sGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707461728; x=1708066528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdmhTFAG6NaVssbeznKI3+O6lsTy9x8b3RBjAgRQHbg=;
        b=l4qEJXIifEdHtYVthia2QqQRyGHGNrOhMQmZV4VGpAKTVf5ax1Q+UuzdvThJf0qlSi
         N9JDSLOCb0htBu78OO6sF8j52XghBwpNHFv+dghH4ezRAUzi1kaYdwuQpm5MrBClAtrN
         4zDLfoQHO6m+kLTh9FnWGYTRzab8KJlCopImr9NIWPT7oJP3vmE7Fn1C9JYK/egWCla/
         sQygXJjFGX81KBSBZd34hLTM44PzNMRgxM1MIMQS35kBNGnHE2xSqA7StgeBh8IZU5+I
         Z7YpQ3LPExpijnWK/XtO/oTWd/OO4CAclw4MYfo2tjbonae/LtP/7fsDFzqf/NPY2SKp
         iwpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxVqH82wS1eDQqNuoHS+zLQThin0jCeRTG4/w1GcZvNwDu2AbZC/3Vel5+taMQAjkTftnFLNb5xMk1wgjT0ajBQe3gCBoPx8lD0krQ
X-Gm-Message-State: AOJu0YytvyCyD9PPsyeL0lhpC2MAYKDYmDtyuiEtkDoRgigmmkNJfrkL
	8KmlYqpg0ukdE6Nze8y5Y0itmcbjy/6daKdkBomaiTvw4INqfcwe6RSgpE5Pf84=
X-Google-Smtp-Source: AGHT+IEPu2RWDQ+KqY+GeGeneEFcPV5/5TrF68Jrl3lB0+Rbgxl+MQ17fkELizSi9cWf1HBBZPTqjw==
X-Received: by 2002:a05:600c:3110:b0:410:6d90:8efa with SMTP id g16-20020a05600c311000b004106d908efamr409350wmo.6.1707461728520;
        Thu, 08 Feb 2024 22:55:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3ZYsENv9ILXsLxYLkoe9NLe2w6+ikhpacM+wGjUX7q/ipaDRsKFVQUfi8xwGVEX85vmWtSyZGq4MkyiRNupbk43NCFAklZdneKzTX63V4ytF7/CP+KrZZgVrOQ6lDQ7Wo637qOJObgAr8t4UzqL2yaYrfY9FdDQ21B/Q6fM5sa8DtEwQG+SA9ngQXvM66WX09fWUMN6Sg7Ipjybk0OxUaQ7GK7r0i/xJXG2USZCMMRweXdtbT+83e3BZzKqbecMmCLdgsNI7Nu8BnPf5laPCuQkUk7Rk0NH0CZF1ps4+DETnbzq53zPTGHYe+Pqmpx3Knv7r4XaJ7btzUlgjBYOUV6/sKc8VrxKxZSG7NQfli0wp59duqk+a/XbCSExbdQnBNU0d+Ds9Z1kf0aL3aMIFNJAHdJqXvMSZyxjGAu+91R6WEFFYfeKG5/MGSYGlR7p+HaXr+/rHEBucD3Ag36XSbQ3C35xNnG253bmGfdYJSTho=
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bx23-20020a5d5b17000000b0033b4b4a216asm1037210wrb.14.2024.02.08.22.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:55:27 -0800 (PST)
Date: Fri, 9 Feb 2024 07:55:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <ZcXMXhQs2n7c4LkQ@nanopsycho>
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207070342.21ad3e51@kernel.org>
 <ZcRgp76yWcDfEbMy@x130>
 <20240208181555.22d35b61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208181555.22d35b61@kernel.org>

Fri, Feb 09, 2024 at 03:15:55AM CET, kuba@kernel.org wrote:
>On Wed, 7 Feb 2024 21:03:35 -0800 Saeed Mahameed wrote:
>> On 07 Feb 07:03, Jakub Kicinski wrote:
>> >On Tue,  6 Feb 2024 23:24:30 -0800 Saeed Mahameed wrote:  
>> >> From: Saeed Mahameed <saeedm@nvidia.com>

[...]

>
>> Ok you don't like DPLL,
>
>I didn't say I dislike DPLL. I think it's a very odd example for
>you to pick for nVidia's contribution. My recollection is:
>
> - Maciej from Intel started developing upstream API for SyncE support
> - I asked him to generalize it to DPLL, he started working on it
> - nVidia expressed interest in creating a common interface, we thought
>   it'd be great to align vendors
> - nVidia hired Maciej from Intel, shutting down Intel's progress for a while
> - nVidia went AWoL, long response times, we held meetings to nudge
>   you along, no commitments
> - then after months and months Jiri started helping Arkadiusz and Vadim
>
>I remember thinking at the time that it must have been a terrible
>experience for Intel, definitely not how cooperation upstream should
>look :|

For the record, I spent huge amount of time reviewing the patchset and
ended up with redesigning significant chunks of it, steering Arkadiusz
and Vadim the way I felt is the correct one. Oftentimes I said to myself
it would be much quicker to take the patchset over and do it myself :)

Anyway, at the end, I think that the result is very good. Solid and well
defined uapi, nice kernel implementation, 3 drivers implementing it,
each with slightly different usecase, all clicks. If this is not
good example of upstream cooperation, I'm not sure what else is...

But, I don't think this is related to the misc driver discussion, I just
wanted to express my pov on dpll process, when I see people talking
about it :)

>
>IDK how disconnected from upstream netdev you have to be to put that on
>your banner.

[...]

