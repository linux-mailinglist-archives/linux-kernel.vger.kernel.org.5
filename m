Return-Path: <linux-kernel+bounces-163909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941D88B759C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C588E1C222EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1519513FD6F;
	Tue, 30 Apr 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIHJIrZ5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9F13D624;
	Tue, 30 Apr 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479723; cv=none; b=M/aiefhIx/S6WMP5JiFNt+bmyzFKPHkwp8uAQgOPKu0z3shVF4Pdc38EUwAYpdOoivz2zr7MQxcdQgwEeyMnsCrKiGZ7DZ2JrGWn/AM2ufsxX0B18LLa5KEhI9FhBaImRuO6zb+Jq2qNUXFRw9JmUt9vNA0Gl55gN/nBHSfBOEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479723; c=relaxed/simple;
	bh=U7E9s83TM3vOZgGKQGLCFOTAh5BRRpA5on5CT9L+mBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksrONkv864l+vk2T66bpoftdG357DyX2Mk9gtBUY9xRgCuk8YErOQBUtZxlQg9BkkrrUQS5fgNRi3WqoW3Pua+YwMffK9bSgnU0RhjfjaiUKGaLB58UKoM/nUjglPHZhme1Rf/wZSr3WK+EtB4OR9mPp8ehf2GRA6rqzuge4hBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIHJIrZ5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b79451145so33172695e9.3;
        Tue, 30 Apr 2024 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714479720; x=1715084520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=edsVaYpHVwrzrHgi4+EDjFOBJJwl4DyDVK7ckDTuNZk=;
        b=JIHJIrZ5PiSoBAVMKwjIsGSMVfhBz2aZM5/K1pPT2aPezDxr+wa5r/H0Fg751e5te+
         mHrOg9Lez+rlP0Q/0In6cngROfEZFdV90MuCXqTzwmsMuc4pa2sGSLOz67Z4laKfkzZL
         5wwWAjit67I4jCvK2XEjqUVo/MT/tsnzb2J5C2zqRwsLB08WXQxpBSqlX2ObZsz44NDr
         aJWd4L/N3XP6QrpLbEEvgYSt0WvyTXmvE/58kgvCBsH0nQ5WsJYxX2bMxsjrJDz0xF7D
         DKS/8sAnxpiO6DpJj2j0F9Les2djmxfnAILG5Tl+7UvI6eXGFyQYtogAjTOjkQsgJIx6
         KSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714479720; x=1715084520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edsVaYpHVwrzrHgi4+EDjFOBJJwl4DyDVK7ckDTuNZk=;
        b=qXjdnX1FmELROdWQWQFll4c4mg7UMUQkwYpnZWKEYC3I39s0f7FoiEr7tXBMwkFmGU
         01igmkBKvW1g0Ee+OQ/lq0hbia4rTkmpxbtXHTpUX5FdwV+j8tPTmCEhZSHptlBD5msW
         hcxh14NTalwAqqXbJMzG3YxBQiqYWFtBD9cO9Br2IgZidh9z+TQCf5xkJZWsNpJFO3sD
         b7TaH/w8uIloB1PdqMHc1xA4/yIbbWOqjkH+SS2Q2EKouAK/PjKMCm1jr3gcwKtBzCP+
         lDRnUpzy0ZaAopnNIOgL20AhR70CtdxGl2w1qpDiP8OGNlOEr57nce1Jlad3RQP5WvQc
         Kkog==
X-Forwarded-Encrypted: i=1; AJvYcCWztP1owkb1Y5Y+SDkksjF5zr3fndEw/7LoZHO0BUkiVz7suKghjMHD4UdKYc/VAOa2OCEIuvBfOllsK2haHVqAUtsll13C+R4kepJIUjNHh+0AlLPxW34UI9OPM79GgmZxelxALeO0
X-Gm-Message-State: AOJu0Yz1vFN/uug4fpdk4mwWiU5TpcnhWPkC+tbR3Ztdmw3B16DVmOtZ
	rTtjczB88vfWslzrVr7yJ0aPLpQuussARmdYSEI/udG1jayDowOHQ/yl4w==
X-Google-Smtp-Source: AGHT+IH/yppXXUbveh7nj+UBG+6YSOIKJEF1oiraKe7YSp92MrCb4r4z9hzES/XZ+7H/d1nwYA5daA==
X-Received: by 2002:a05:600c:4f8e:b0:419:ec38:f34b with SMTP id n14-20020a05600c4f8e00b00419ec38f34bmr8023972wmq.20.1714479720114;
        Tue, 30 Apr 2024 05:22:00 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00419f419236fsm36442762wmb.41.2024.04.30.05.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:21:59 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:21:57 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: temperature: mcp9600: set channel2 member
Message-ID: <20240430122157.GA46332@debian>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
 <20240430120535.46097-2-dima.fedrau@gmail.com>
 <20240430131102.00005e58@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430131102.00005e58@Huawei.com>

Am Tue, Apr 30, 2024 at 01:11:02PM +0100 schrieb Jonathan Cameron:
> On Tue, 30 Apr 2024 14:05:31 +0200
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > Set channel2 member of channel 0 to IIO_MOD_TEMP_OBJECT and set modified
> > member to 1.
> This an ABI change, so needs a strong argument + must be a fix 
> rather than an improvement.  So why does this need to change?
>
Hi Jonathan,

I don't know if it is an valid argument but when using tool "iio_info"
the temp_object wasn't displayed at all. After adding these two lines
the temp_object is displayed. Don't know if it is a problem with the
userspace tools.

iio_info version: 0.25 (git tag:b6028fde)
Libiio version: 0.25 (git tag: b6028fd) backends: local xml ip usb serial

Besides that it eases distinction between the two channels in the last
patch, but I think this argument is not strong enough. :)

Best regards,
Dimitri

> 
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  drivers/iio/temperature/mcp9600.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > index 7a3eef5d5e75..e277edb4ae4b 100644
> > --- a/drivers/iio/temperature/mcp9600.c
> > +++ b/drivers/iio/temperature/mcp9600.c
> > @@ -26,6 +26,8 @@ static const struct iio_chan_spec mcp9600_channels[] = {
> >  	{
> >  		.type = IIO_TEMP,
> >  		.address = MCP9600_HOT_JUNCTION,
> > +		.channel2 = IIO_MOD_TEMP_OBJECT,
> > +		.modified = 1,
> >  		.info_mask_separate =
> >  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> >  	},
> 

