Return-Path: <linux-kernel+bounces-161544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3A8B4D88
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089C41F2143A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C00374418;
	Sun, 28 Apr 2024 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddgEG4UF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B95EEC6;
	Sun, 28 Apr 2024 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714330346; cv=none; b=KOKbG3/mj86aoRWHhjvJjVIXXFgPMPRX6wC4FYtizzavwn04oMeQn50i2AtcJokMWeoi5X1vJLnVcPLNCalvuPGRiKLCvOAJXlgewcPYtzlP8rBEpaKWehW+1aAOmu4z8tVyJx9Pu+mQY+bvExfwZipghsfIphpZFxmpD2lk+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714330346; c=relaxed/simple;
	bh=i08qcoe0Ph/eFDId2t+79a+VFYuTrFN+dA4Nd0o9YeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD0Bku+Rt1gIIEALRR/nMMAOhYZt9qbPUqy/x6KLnAF1ft9aHBJ7RiZHAYATyBpils7Q1DlQJkvXgCZygHlk6xXShzdspewCS39V8uyZ8mGEaZnI966tkxm4KvL1dal+oBywOtfffbO2p6IR0dT/1tQlotGW3E1yfvikUzVl9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddgEG4UF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4266673bbso33233415ad.2;
        Sun, 28 Apr 2024 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714330344; x=1714935144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A50txbCSTHM0D9aUPO2eeX6hnGYpoz3AvNJN0jmEZFI=;
        b=ddgEG4UFBlL60nY5qGtxacJcI3Y/Sqom5BI9T6Xw8BvhsCX3DNgDCHVCFJrHi4zdaA
         A9xkWLMKaVR7WhLPad/BkqkBzhl+e5ngEJ40yVMy4Wbuk2nalwOqxl0mzhSRfmVJZWdt
         wagoxe2SWADg4wE6dYet7dgP3pGUIbAyeumaOTTd3hObJkAfgcyLdild4yBe2xrKhOHp
         4+kCPILWqtLIlfUpMoCDnAPx538Sey2WNYF/3qBEDNNyMcEksZfZhQbXtPxYaCzpJD54
         CauHsUxHIfI7rAaqwXW6j4miDwRZ+asKOqYYvipmDxqv/cVUNZkYvb8ZsbioQ0JehPhq
         Qezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714330344; x=1714935144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A50txbCSTHM0D9aUPO2eeX6hnGYpoz3AvNJN0jmEZFI=;
        b=J6vGR3k62d1B14VjUK1c0QoPYDQJzMxSQhnj3D+HiQVag+/G8c3HF0bC8dt/E9Rd92
         lkmIHwZ002inrRQKuPPJdgVnLF8kJeNvNabyfY6dIOl1vV3ZVy82q7jnI8Vy/e9uvXiW
         HAEHho+hpRqz2zoycMTSUW17Y76614bxj3fsBOez7JKk/LMGEFU/G2a7OHkKSNOhaWn5
         +MN7SC4dgrHboYVWVGpMwTfJ+QKULXIsz7D+zFQx7BvGn+ZNeU2IzZpStGHxzlq3bUgE
         gnJck36zi9D9VloxLFd57M5+86L1KvWDZQe2bVPHYMTR5syKT2pG4NUvXnlps44RP2wd
         N7rw==
X-Forwarded-Encrypted: i=1; AJvYcCWfGiMSMl8acuk/ickWXv0+sAT6k4CdgW2V67HwEbkj4Jw74NXujzf0BqwaWIl+ofbPVYIXQalPsjGuc1oF/sYTXsRaUIsBIsyM3wjJvQKjsEPRdCuVCs3FDqLcOGaOw3FiSXIqkH3+
X-Gm-Message-State: AOJu0YxWFcq8q9Y3IMzeeVXjtjdCWZiK5KJbTi89Td3U1V9x9uHPop42
	Dfbz/FQWSD0T8HkpsXEQpFtlzi17nwLSV4XM1JC6RJkqrJFuvLkR9+8vPA==
X-Google-Smtp-Source: AGHT+IHIr0ifpryJ3EV2/HqCQDfzc/+8MNeGNvg9Mo+9XDrJrdOekj30XZkKOI6ZJ9iIEL5E3F7oQA==
X-Received: by 2002:a17:902:8483:b0:1e9:6609:37d5 with SMTP id c3-20020a170902848300b001e9660937d5mr6919400plo.27.1714330344472;
        Sun, 28 Apr 2024 11:52:24 -0700 (PDT)
Received: from localhost ([2804:30c:1f6c:5400:ea32:e7c8:5bc0:103])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902b08a00b001e2c1e56f3bsm18667469plr.104.2024.04.28.11.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 11:52:23 -0700 (PDT)
Date: Sun, 28 Apr 2024 15:53:12 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mcp9600: Fix temperature reading for
 negative values
Message-ID: <Zi6bGN70PFGl4UJ_@debian-BULLSEYE-live-builder-AMD64>
References: <20240424185913.1177127-1-dima.fedrau@gmail.com>
 <Ziy8DsMCeAGK79E7@debian-BULLSEYE-live-builder-AMD64>
 <20240427195758.GA3350@debian>
 <20240428144606.5b3d9a7e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240428144606.5b3d9a7e@jic23-huawei>

On 04/28, Jonathan Cameron wrote:
> On Sat, 27 Apr 2024 21:57:58 +0200
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > Am Sat, Apr 27, 2024 at 05:49:18AM -0300 schrieb Marcelo Schmitt:
> > > Hi Dimitri,
> > > 
> > > Interesting patch this one.
> > > I think this does apply, although, the cold junction register has for sign bits
> > > so I think we could also have a mask to clear those out.
> > > Some code suggestions inline.
> > >  
> > Hi Marcelo,
> > 
> > the temperature bits are in two’s complement format for hot and cold
> > junction. Equations to calculate the temperature are also the same in
> > the datasheet. There should be no difference when handling them. I don't
> > think we need to do anything more with the value except sign_extend it to
> > the appropriate data type. If the sign bits aren't right, there is a bug
> > in the chip, until then futher processing of it is unneeded. I could add
> > a comment here if it helps.

Ah yes, I missed the fact that other bits need to be set to make the value
smaller (closer to zero) when the MSB of two's complement number is set.

> 
> Agreed - by my reading the original patch is correct. Maybe it would act
> as cleaner 'documentation' to have the sign_extend32() for the cold junction be
> from bit 12 rather than 15, but I'm not sure it's worth the effort.

Yes, the original patch should be correct.
Yeah, no practical difference using bit 12 or 15 to sign extend the number so
probably not worth changing that.

> 
> Andrew, would be great if you can review this fix in case we are all missing
> something!
> 
> Jonathan
> 
> > 
> > > On 04/24, Dimitri Fedrau wrote:  
> > > > Temperature is stored as 16bit value in two's complement format. Current
> > > > implementation ignores the sign bit. Make it aware of the sign bit by
> > > > using sign_extend32.
> > > > 

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> > > > Fixes: 3f6b9598b6df ("iio: temperature: Add MCP9600 thermocouple EMF converter")
> > > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > > ---
> > > >  drivers/iio/temperature/mcp9600.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > > > index 46845804292b..7a3eef5d5e75 100644
> > > > --- a/drivers/iio/temperature/mcp9600.c
> > > > +++ b/drivers/iio/temperature/mcp9600.c  
> > > 
> > > #define MCP9600_COLD_JUNCTION_SIGN_MSK GENMASK(15,12)
> > > ...
> > >   
> > > > @@ -52,7 +52,8 @@ static int mcp9600_read(struct mcp9600_data *data,
> > > >  
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > > -	*val = ret;
> > > > +
> > > > +	*val = sign_extend32(ret, 15);  
> > > 	if (chan->address == MCP9600_COLD_JUNCTION)
> > > 		*val &= ~MCP9600_COLD_JUNCTION_SIGN_MSK;
> > >  
> > This won't work. Assuming int is 32-bit ret = 0xfffe and *val = -2 after
> > sign_extends32, this would result in *val = -61442 which is wrong.
> > > >  
> > > >  	return 0;
> > > >  }
> > > > -- 
> > > > 2.39.2
> > > > 
> > > >   
> > Best regards,
> > Dimitri Fedrau
> 

