Return-Path: <linux-kernel+bounces-91617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12357871447
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF472845EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A337715;
	Tue,  5 Mar 2024 03:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko1aSzn5"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F029CE9;
	Tue,  5 Mar 2024 03:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609387; cv=none; b=U3bH+IUUI4MWbGA+Pxnu42+zLB0Z8Lci44QDiZlH51A0bFbv7EcFPnsCnTIuuieOkVAqmy5OSSQxfkwV2wx4rlnWQc7Do3jl1q/FFyeOpDn4JjoACbT0e1Iy5dJP3TXBHMcTbELicUc6NR5vgd98+kjm4ZKnhW6j+Q9rk6YGjbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609387; c=relaxed/simple;
	bh=DjAO2u7PVrXzRcnJJKgnPLvebnRRPbpCp1OkVSCAaR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1d4w8TWvdW6JnSJIdnNvuds1hTvyGHSfm4QjQgfg+8+xBMDADabewsHr0x8/rcxujXohpeYBScKarmW5gZR7Q/TUCCW4aVBMlCZvAqQDmVmz7noQjj8bTJqHPCCa08WqA1sm/AC+DU58FEmcf5X0RCtqmFsDE0R9n8+0cf344Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko1aSzn5; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6900f479e3cso2673676d6.0;
        Mon, 04 Mar 2024 19:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709609384; x=1710214184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzlmmvRCQh1bj1Yx5DjGSZCSGlxLY62tQPxGASsPEGE=;
        b=ko1aSzn5jqz3m+qoHIr6xUhvzSg9785j6yBy9AFYyXuxO+DvYSUCptnndG8Ph1pLWp
         0FWPl+E9EluIPkNO7YY27afR/vdDmZhfvGVNBuPOgbkUnasIRCzQpXO2fTtEVI8Nzt4N
         /WR7p4Ugttlw4NmmvD9iiUu/07nb2gjdw+KtPMt6aQHk12qgi6IWG8x4GQfU9oqDKq7x
         yN7/g1gV0XPGzq+YZnlvbwfkYSmjaqbkke5N8379LkITWTKVuFOZ7keP5a8PNTZBQ2XO
         ZxSdWXXdE+KrNQPcF8cMrwuWorkq3rlSsj5kZ04ei0ypd4pZQoRsKmlNP3sxagsTM3S+
         BOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709609384; x=1710214184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzlmmvRCQh1bj1Yx5DjGSZCSGlxLY62tQPxGASsPEGE=;
        b=Ef7GCI++FjTVfcxjAWPd31W5RA3pxKRZthHCsgw2bVI/0emk4wibVhXE6PiTUa5Lcd
         QJpNw7qC/kME2IDL6etCYQRUMRuyLZSjjG7A8xQ5Vq1bwu+3a7o4Pny4+89ftbtoq+P/
         UdXOdMsgCmwgTuNRfUccQEEbvhE1gOIuhpy3LuuaCdqt6QJYlkaAMn0S79GLf9mvdidY
         5ek7Jz9apRABfal7FdwmIlaA22ctdO+KyggTDBKERx+zQe3mJ7UNuq1H08r/9NFlSG0w
         YUyx5oZNQmOVNk6zkEzGgrRm3Gr5fM/oHcOd7ZG+BIC18lPoMf0HVyN0PpkfEA2gpP9Z
         TKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA03q97Rg1f5trsOoAXsFY90QC3o62SiiFOa1AyqlCJRjkx1os8l9FZThd1VrS5gNPIsu3kSqTuWFa8ovJT8N8wIP9qTvFoB4/lmqbh49LiaQBIZYVItGQWr44iwhtMqZLHnWTWqd9blO496R1t47lnZAIWNCGOEQbca4a+zGoZrmDvpY=
X-Gm-Message-State: AOJu0Yx4CK2lUKqXbLYMJBoH8ZtZlSXGSiuAI/BAd0gw2Y1XWcN5eNeM
	WRhPzolDSAo/RL5EvnNNGnoTRQUpLQojnzwM+TasvCDNUrZmG77/
X-Google-Smtp-Source: AGHT+IH9Grpqit8z8R2A1IFxSlj+wq4+2oeE2rI91HMqqs0J2/3mmQWiESJwp3qDzuP2g3Doh8FIyw==
X-Received: by 2002:a0c:e0cd:0:b0:68f:30a1:4bea with SMTP id x13-20020a0ce0cd000000b0068f30a14beamr723384qvk.33.1709609384122;
        Mon, 04 Mar 2024 19:29:44 -0800 (PST)
Received: from abdel (bras-base-ktnron0692w-grc-13-174-95-13-129.dsl.bell.ca. [174.95.13.129])
        by smtp.gmail.com with ESMTPSA id mu18-20020a056214329200b0068fddcdc381sm5845758qvb.18.2024.03.04.19.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 19:29:43 -0800 (PST)
Date: Mon, 4 Mar 2024 22:29:41 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alice Chen <alice_chen@richtek.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	=?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: Add NCP5623 multi-led driver
Message-ID: <ZeaRpSrkeFKAXIlq@abdel>
References: <20240217230956.630522-1-alkuor@gmail.com>
 <20240217230956.630522-2-alkuor@gmail.com>
 <20240301085046.GE1209090@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301085046.GE1209090@google.com>

On Fri, Mar 01, 2024 at 08:50:46AM +0000, Lee Jones wrote:

Hi Lee,
> > +#define NCP5623_REG(x)			((x) << 0x5)
> 
> What's 0x5?  Probably worth defining.
This is a function offset. I'll add a define.

> 
> > +	guard(mutex)(&ncp->lock);
> 
> Are these self-unlocking?
Correct. Here is a short introduction about it
https://www.marcusfolkesson.se/blog/mutex-guards-in-the-linux-kernel/
> 
> > +	ncp->old_brightness = brightness;
> 
> The nomenclature is confusing here.
> 
> For the most part, this will carry the present value, no?
>
Yes, I'll change it to current_brightness instead

> > +	ret = ncp5623_write(ncp->client,
> > +			    NCP5623_DIMMING_TIME_REG, pattern[0].delta_t / 8);
> 
> Why 8?  Magic numbers should be replaced with #defines.
> 
This is dim step in ms. I'll add a define for it.

> > +static int ncp5623_pattern_clear(struct led_classdev *led_cdev)
> > +{
> > +	return 0;
> > +}
> 
> Not sure I see the point in this.
> 
> Is the .pattern_clear() compulsorily?
>
Unfortunately, it is. For example, in pattern_trig_store_patterns, when
hw pattern is used, it is expected to have pattern_clear implemented.

static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
                                            const char *buf, const u32 *buf_int,
                                            size_t count, bool hw_pattern)
{
	...
         if (data->is_hw_pattern)
                 led_cdev->pattern_clear(led_cdev);
 	...
}

> > +	init_data.fwnode = mc_node;
> > +
> > +	ncp->mc_dev.led_cdev.max_brightness = NCP5623_MAX_BRIGHTNESS;
> > +	ncp->mc_dev.subled_info = subled_info;
> > +	ncp->mc_dev.led_cdev.brightness_set_blocking = ncp5623_brightness_set;
> > +	ncp->mc_dev.led_cdev.pattern_set = ncp5623_pattern_set;
> > +	ncp->mc_dev.led_cdev.pattern_clear = ncp5623_pattern_clear;
> > +	ncp->mc_dev.led_cdev.default_trigger = "pattern";
> > +
> > +	mutex_init(&ncp->lock);
> > +	i2c_set_clientdata(client, ncp);
> > +
> > +	ret = led_classdev_multicolor_register_ext(dev, &ncp->mc_dev, &init_data);
> > +	if (ret)
> > +		goto destroy_lock;
> > +
> > +	fwnode_handle_put(mc_node);
> 
> Didn't you just store this ~16 lines up?
> 
Ops! I'll remove it.

Thanks,
Abdel

