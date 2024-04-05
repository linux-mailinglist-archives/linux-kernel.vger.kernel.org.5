Return-Path: <linux-kernel+bounces-133589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA5089A605
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4728F1C20C99
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6440E175541;
	Fri,  5 Apr 2024 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UErQmK8K"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2EF17334F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352128; cv=none; b=Ge/W4HiEsK8eBZCv0HZ/twIktPgQIJXFQ3iByvXgHcWLxjixfIAfddAJvvRoyejBUaAYpiFnsnz5N65tJ79DCtdKvl1hUdmt0u97ymetDCTfQiWU/sbXY6rpJ0s0rkCRy6s873G2LVMC5BwA7ZiFEIsELhq3lxpzfKFFmJbDTUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352128; c=relaxed/simple;
	bh=Q04UiuMyRXbGVxJakumDS8nr1AiT4+472waBBZEdOo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfA4aOHg7QxuFbgSouRJTT0J6DQuhJtez6I/NhOzIS+7uu5aW2BkVwNl6m6TtHWMOVC3PA7oBg3G15x+KdnKYLRv1W5+wa86Y/guK0M0qkOOqRJFfOWxPnb/IJEWGH+hnYxibKfk+naS3LHHTmuoTlz+3BcZAmHeMMl5rJRR61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UErQmK8K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0d8403257so23800425ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712352126; x=1712956926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=usb2eToxZqr2+tKAK3YBZ5ATHfFIYXjx4gZa/I7hs4w=;
        b=UErQmK8KRRN4fgUabuoV53OIRZB1qViIgQgzKqM7TNHi76Q5tVlEj6ve32zXF0IxXu
         CZzsip4wrbamiTAyy17JQ/c2vnjuDrEQqfY5rt1xXjAkkkpVXxG7vs9+8MDYomC6T2r4
         06ToMvdbneTOaLM5Rii98awMwrsM6Dt6Hi7q40mwvFemIp3iNoTpEkV3UwHu+nH3z/x8
         Nkm+6i5wGGfMnicJH9UGLpMCupQ+kS8U5Li3fEQbIiv7Ww3BgXd9PnpEnCzoZn7LCtBY
         0of6cUmar4YMGKJIgi4UG5erQ/aiw7YYpYFaFSZbM4nai7GE5jxNXn3+jcAfOfWlYFte
         t9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352126; x=1712956926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usb2eToxZqr2+tKAK3YBZ5ATHfFIYXjx4gZa/I7hs4w=;
        b=WsNIsKxdg1QSPiJQ5+PfIFtDuZ1pNP8j+ozm7iczKP1M3sfdCFVMbVEpBCxb5n47no
         xffbVA6lIleTyzkXvC8fovA1K4CXZ+jACC7Z2Te83Pk4mcRLf1M3LGPQ6hLNo1IUFBwY
         56GaFBWM9b3EqxHUkEhntLL5joINsFQjqWqlfPmKisz2Ly2Q9t4pIpJAt4aliYavW4eN
         3B86MK0LucB8RXPiyHsMBaAh2KRxZ/5IWB17pS510Eyk0nPuxZmLrxWUDMb4kaWeTP+o
         vE59XH1uSXf+drVPyR9zrLIdc7aSt7YFNJu9glw2Ckr47n3KAbLJ9OBueb9gLO3DH2wJ
         fMxA==
X-Forwarded-Encrypted: i=1; AJvYcCWni5+274KJepnCJIEsR0r7aAZxrjw0mGRCdDOOvWO+9gV/LqWCV/uXabxRbJBMUKZ2QjLQQvlcc1goZn6kjysRJ/Xowf4qr/zuaxBg
X-Gm-Message-State: AOJu0YzXgN55f4oeXx6aPtmBfsd4oCL83W009VDzyIfXM7dkXd163X0P
	Zz8XRlqrMWO7vupmMRxVJC/3iRY2T2GNUpri0rZ5aKM1R1HkpPFuxKgdqqgCl0QHQA==
X-Google-Smtp-Source: AGHT+IG8uZKBY56GrIfR0tYPyGgVCIFZ6EmnJZmso58ECHQNdnyePLWbLj7ian9poAK/ZbsgkisM0g==
X-Received: by 2002:a17:902:82c7:b0:1e0:2995:c330 with SMTP id u7-20020a17090282c700b001e02995c330mr2413480plz.63.1712352126269;
        Fri, 05 Apr 2024 14:22:06 -0700 (PDT)
Received: from jc-ubuntu-dev-korn-1 (c-98-210-1-68.hsd1.ca.comcast.net. [98.210.1.68])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902ea0b00b001e0ea5c910dsm2075113plg.18.2024.04.05.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:22:05 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:22:05 -0700
From: Jackson Chui <jacksonchui.qwerty@gmail.com>
To: Alex Elder <elder@ieee.org>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Clear up precedence for gcam logging
 macros
Message-ID: <ZhBrff8qkkmum4wc@jc-ubuntu-dev-korn-1>
References: <20240404001627.94858-1-jacksonchui.qwerty@gmail.com>
 <658e1f40-d1eb-4ba7-9ba3-0aa05a1ed06e@ieee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658e1f40-d1eb-4ba7-9ba3-0aa05a1ed06e@ieee.org>

On Thu, Apr 04, 2024 at 05:05:09PM -0500, Alex Elder wrote:
> On 4/3/24 7:16 PM, Jackson Chui wrote:
> > Reported by checkpatch:
> > 
> > CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid
> > precedence issues
> 
> I agree with your argument about the way the macro should be
> defined.  But perhaps these gcam_*() functions could just
> be eliminated?
> 
> I see 15 calls to gcam_err(), 1 call to gcam_dbg(), and none
> to gcam_info().  It would be a different patch, but maybe
> you could do that instead?
> 
> 					-Alex
> 
> 
> > 
> > Disambiguates '&' (address-of) operator and '->' operator precedence,
> > accounting for how '(gcam)->bundle->dev' is a 'struct device' and not a
> > 'struct device*', which is required by the dev_{dbg,info,err} driver
> > model diagnostic macros. Issue found by checkpatch.
> > 
> > Signed-off-by: Jackson Chui <jacksonchui.qwerty@gmail.com>
> > ---
> >   drivers/staging/greybus/camera.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> > index a8173aa3a995..d82a2d2abdca 100644
> > --- a/drivers/staging/greybus/camera.c
> > +++ b/drivers/staging/greybus/camera.c
> > @@ -180,9 +180,9 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
> >   #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
> > -#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
> > -#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
> > -#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
> > +#define gcam_dbg(gcam, format...)	dev_dbg(&((gcam)->bundle->dev), format)
> > +#define gcam_info(gcam, format...)	dev_info(&((gcam)->bundle->dev), format)
> > +#define gcam_err(gcam, format...)	dev_err(&((gcam)->bundle->dev), format)
> >   static int gb_camera_operation_sync_flags(struct gb_connection *connection,
> >   					  int type, unsigned int flags,
>

Thanks for the feedback, Alex!

I thought about refactoring it, but I feel it is worth keeping
the macro around. It acts as an apdater between callers, who 
have 'gcam' and want to log and what the dynamic debug macros 
expect. Without it, the code gets pretty ugly.

Jackson

