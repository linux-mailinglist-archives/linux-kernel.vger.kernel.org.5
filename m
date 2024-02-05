Return-Path: <linux-kernel+bounces-52833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49C849D39
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25496B27C43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5E2C1A9;
	Mon,  5 Feb 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqmbeD9B"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942317572;
	Mon,  5 Feb 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143904; cv=none; b=p72vhaiwj2xtwfBvoSmua0tPDY0IVgyhj6rXxBXsxcWS9fEfHDnBqAASsNb74Yf27gA/U1c9kjcFHpHj9WwH+mdMz/zUUvLUWDKnmckihVONMWqENK9cyjTQXDqk8b/YW5ywfiXLuA70NUaC9zzLux49a+uMPZUSnfgL07C+v5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143904; c=relaxed/simple;
	bh=qLIPnSV3z29Njbcyu6Cx1/8YXz/E2I8INhSvjJrNl2k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjr0AKdLcSgrdMVXBrhElVdlnWX9wvZKJ4L5eX16Nyo/BmuSjiJbO0lIA0lm5dHTAD3YCYHl7GiXpXpLIRDPCWDYJdMcO8nKAKshWtW3WvaqR3vn6d+KsIwgpKZodBMtdRa7IZ5luX84p4Ldayn6gGkg51ex5/ZQdzybWepgx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqmbeD9B; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso2349809f8f.3;
        Mon, 05 Feb 2024 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707143901; x=1707748701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GnRPLB6mVKulmCMNCC1XGkAiblhvm2hmB10dmlVxsCc=;
        b=jqmbeD9BkjEgbV3I535QohQqJ4hNPJ+LOWS3NBsSIWx4yffE1fKmttRpqDdvCSByaO
         aa447cv+1hOIky13at+BOQnXsdBe4JxgzO/87AXO69nKLTPT5Mx/GwnYo8dALZgd4JIv
         yTZvxhQZmfRF3JXaAOHhjXELYtzlNovsSbkrECnebuTEjPq6PECtmemNS4ZdtLhR6J2W
         W8FS3HG1Zm1G0XQDuiJE6aVApie3F6ja4ecsAYZFxogLt8zCoVA0aW0OTIhzt4h/9qS7
         T5liLq7sJ2rp0vp00HasmMbmVk587uKZHIvHzXiupsc0OyiM0syPFxlkBXxxAFqXsvwG
         dMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707143901; x=1707748701;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnRPLB6mVKulmCMNCC1XGkAiblhvm2hmB10dmlVxsCc=;
        b=NazSBoykxeuR5L+fcZzvtm593OoZ0a6kvOIt8OVRYflNZBkittjphuPnA5bSUwFfOy
         Mt4BLUjJ2Vx+Hp91txeqXQXHsJ9kshH0H7gtZxR9wzGGJ3fLKrnAOAp7+9exmLxASEiy
         i4igMIJDS9be0gUtbKMMvDVtainenvPhmMg8bni8Qetw0bXi9J6cMpKzIRz6cLgEQiXR
         obTLYtbc4GTlaYr4j3uqUmUtWZxF8+9+AB8zqztjKTLLWv/3rOvs1/olYb6ny2Gty7KA
         +PCGqEaS9YeCQf6DzRElBhje72Tsy92Kv+VtA6ustuQlXlLG0uHbBd4x5rGjb8uy8Rza
         F1dw==
X-Gm-Message-State: AOJu0YzDzSJRGptvV1Zoj/Zonjpl7gJcmW9+JIgUvEvGUrEQwgPmeFZw
	mBMX5DG6d+Lcuz5wJnOgGwSKI7e5Rv3XxvZutN06SSNADNw2sKIr
X-Google-Smtp-Source: AGHT+IHGCOT1Ti+/uMVOQRX8kYsQp3/4JfBw96NgAYmkBY985PIsqp6sVzoNi8UVkgbQn8Exs1VIAg==
X-Received: by 2002:adf:e806:0:b0:337:c4be:7b9a with SMTP id o6-20020adfe806000000b00337c4be7b9amr8574938wrm.63.1707143901190;
        Mon, 05 Feb 2024 06:38:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW+dhN14Um36x5pygjsMYrqN8wAdX28dPoX5JbKqRQkUqfNIv7G5QRg0inhsc2+Pkq7qKB37qiiEzJW5viPiZidAnOmNGINDo7hj6lWNEBJayKMNuoEgbcQcv2EuBlPn/kbOsiEwKzH4CFvKyfd0HVfTzi9joDalAVccwD7+Et1C5ttca6X2Xlx+mxkJb0fxa8P3jHh20deuoVw9KESOSNngJK/8tD6A9TY4aV8GX+ERs3A8XXuQ3J3L24T/FEpMeiYj/iHca+n6IU7ibEoegygInn/6tk1Eyxe/GZyQcNdr7bakaRbEJQcYSaGWpHXN1QvkEcaKjw=
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b0040fddb65d58sm1663662wmo.13.2024.02.05.06.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:38:20 -0800 (PST)
Message-ID: <65c0f2dc.050a0220.63083.8524@mx.google.com>
X-Google-Original-Message-ID: <ZcDy2T23lKZoiEsI@Ansuel-xps.>
Date: Mon, 5 Feb 2024 15:38:17 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Pavel Machek <pavel@ucw.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: Fix kernel panic on interface
 rename trig notify
References: <20240203235413.1146-1-ansuelsmth@gmail.com>
 <8d51f09b-e6d2-4ee1-9e7d-b545d561798a@lunn.ch>
 <20240205085007.GA19855@google.com>
 <2cf84815-f9b6-4a0a-a3b4-d23628a89aa4@lunn.ch>
 <65c0e874.df0a0220.257a.43b1@mx.google.com>
 <20240205143359.GB53266@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205143359.GB53266@google.com>

On Mon, Feb 05, 2024 at 02:33:59PM +0000, Lee Jones wrote:
> On Mon, 05 Feb 2024, Christian Marangi wrote:
> 
> > On Mon, Feb 05, 2024 at 02:41:46PM +0100, Andrew Lunn wrote:
> > > > > This should have 'net' in the subject line, to indicate which tree its
> > > > > for.
> > > > 
> > > > No, it shouldn't.
> > > > 
> > > > Contributors aren't obliged to know anything about merging strategies.
> > > 
> > > With netdev, we tend to assume they do, or at least can contribute to
> > > the discussion. They often know about any dependencies etc which could
> > > influence the decision. When there are multiple subsystem maintainers
> > > involved, i tend to use To: to indicate the maintainer i think should
> > > merge the patch, and Cc: for the rest.
> > >
> > 
> > I'm always a bit confused when I have to send patch to mixed subsystem
> > (not the case but for net trigger it's almost that). Sorry for the
> > confusion/noise.
> 
> When you have a truly cross-subsystem patch, it's up to you.
> 
>  - Mention both e.g. leds/net:
>  - Mention neither e.g. <device>:
>  - Mention the one that is most relevant
> 
>  An example of the last option might be when the lion's share of the
>  changes occur in one subsystem and only header files are changed in the
>  other.
> 
> In an ideal world i.e. when there are no build-time/runtime deps between
> them, changes should be separated out into their own commits.
>

Thanks a lot for the explaination and the examples!

> > > > Why does this need to go in via net?
> > > 
> > > It does not, as far as i'm aware. Christian, do you know of any
> > > reason?
> > > 
> > 
> > This is strictly a fix, no dependency or anything like that. Maybe using
> > net as target would make this faster to merge (since net is for fix only
> > and this has to be backported) than using leds-next?
> 
> We have leds-fixes for that.
>

Oh! No idea, should I add a tag to the patch to target that branch
specifically?

Anyway Since we have leds-fixes and this is leds related I think it's ok
to use that and don't disturb net subsystem.

(again IT IS a kernel panic but happens only on some specific situation
so it's not that critical)

-- 
	Ansuel

