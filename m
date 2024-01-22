Return-Path: <linux-kernel+bounces-32773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9827835FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D1E1C24615
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158433A8D8;
	Mon, 22 Jan 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnX4o8CZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85D3A1C0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920220; cv=none; b=t4DxdUJpEqZMswy9zGDXvQgbj4V1hK6mww6hnOC8Fb/NwDkqPBk2BvOlpNIEHpTuzYHxf7i6wA6Up87DqbepSGjK30odCFlI3Cai1nLuurb1T0p8+ClmJpRVWV+u4ZED81EfpG5SnorBNidLcAqhLGq8Ry/k+FM3tJgExhqC6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920220; c=relaxed/simple;
	bh=SYImlEaJH/Jealdq0FPzHywiTrW4AlV0b9Sn8/s5j5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVEM1Odavxl2JsA7xOUvaSwRcMmyoIWsqZRWi0UbTdCtC4krB+ZG3Subib0Ihme7PZ7Bzq9y0PAO5K2+BURZnUv//kJm1/mt9Rzu06i1B+z94i7v2DGmE6Qc88YM+gmJzz8l6ARmEI3xw5hgZvPigugxx37UeSJJ2Tc3x5Emj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qnX4o8CZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e8801221cso30168135e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705920217; x=1706525017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBWNCLLFubdT9fJ3cv8e16Ff7jYhvZKyENiuEu8Dr8s=;
        b=qnX4o8CZr21tY8pU730x+25Zw7BPm4w3XKVCxtmKCk3H3/frj3c+2UT0awZ7dg0AOp
         gCss1Kcg1DUXAA1C+u+C5HqkAlo6f5HLplnumd/F12/CLk08gypYvO2y0/vEwSUoXzjF
         gYt+LLnxcrYD4AnlxgWM58EmXRXop1SwUpJJhQQimC4NvB0vAeepY+1UbF7MJ2Cn48xG
         0bc0BLvM8QlcS1uo5CXF09whkBCyhICOYVBTJXBhRLTm5fwhPCZSRnWFfmtxw95jfICM
         5Sh17e2IhPvT//KSqcHBEY6ZApFKD6UPMSL99kZuWEtvVlBjDzkW8pEGA2YdR918R+ov
         HLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920217; x=1706525017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBWNCLLFubdT9fJ3cv8e16Ff7jYhvZKyENiuEu8Dr8s=;
        b=KUS17llThlscKhiKcGaNLgMNGe4eCQ/ci4hHQ3TuIov8xwQjx1fGjqpGR9Wd6M2sJm
         WdW2h1enELuzJYsdugn5ELPd/p9K+XFTn0bkN15ABLoVIGuEx3oBsy705KWySDdCOFBZ
         moTJBdr9RN7Y0TxkZpvFamUM8q0vmMsNWgAXKUs5BJjQ58Nr8q+0CQn40/wm712ZZ0ZK
         9yVNRKFK33UzCdsz8mspT50qo1Vz/OosoXUqGPKeKzKmX6B5xs6Cmoq82STjbw2Qbw6j
         zXFJCty1OEWJVgAUdpJi2jbKOMkWm2JMF6EpNxg2mCcUnmmkMWNm2s8Z8f5vOGbz+Plm
         EGag==
X-Gm-Message-State: AOJu0Yx5lrS/CLnsnWDLmMVZ+l1HmFyizVweaKchxPmP7y/3WjifL/sS
	uy0RWE+Ho+gTCACAZL1JmRu1h4qoKwX7+Ij8jYFwlK7tzq3oeDjcZ+1Itf5dNM8=
X-Google-Smtp-Source: AGHT+IHzftdJu5Tfe2SF8LvabynhKKZASp+dGkCarsLc7Hm4XRhrssvAPcplXGyZx9jwYzzGDAuLwQ==
X-Received: by 2002:a05:600c:1d87:b0:40e:ae91:1d38 with SMTP id p7-20020a05600c1d8700b0040eae911d38mr512318wms.33.1705920217017;
        Mon, 22 Jan 2024 02:43:37 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040e3bdff98asm42176303wmn.23.2024.01.22.02.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:43:36 -0800 (PST)
Date: Mon, 22 Jan 2024 10:43:34 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 2/4] backlight: hx8357: Move OF table closer to its
 consumer
Message-ID: <20240122104334.GD8596@aspen.lan>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>
 <878r4rovk4.fsf@minerva.mail-host-address-is-not-set>
 <Za0g47CgOH4MhdRe@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za0g47CgOH4MhdRe@smile.fi.intel.com>

On Sun, Jan 21, 2024 at 03:49:23PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 15, 2024 at 09:22:19AM +0100, Javier Martinez Canillas wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
> ...
>
> > > +	{}
> >
> > While at it, maybe add the { /* sentinel */ } convention to the last entry ?
>
> Maybe. Is it a common for this subsystem?

I'd answer that slightly differently. Backlight does not aspire to be
special regarding this sort of thing. If this pattern is becoming common
within the rest of the kernel then its absolutely fine to use it here!

There are certainly backlights that use this convention... although they
are not yet the majority.


Daniel.

