Return-Path: <linux-kernel+bounces-161155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ADC8B47BE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8520B28236C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57312836B;
	Sat, 27 Apr 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgAZY5dv"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC847E58D;
	Sat, 27 Apr 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714247884; cv=none; b=aM0pca/o1jEjmcNm1ZTz9ZCkF20afZyy2oXVW5eKGWspj1Z31Ue2xQJBf5wsHy+9b3ZderrjB7eOcj4jEiwgzoQaFMMvETVgsTx8JN+vbNeYD0VFYhqvAduwmn4THP0wSY6MpWeH6DPfV6hBd6oxElZipL8/np1s4VOIplu4Luw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714247884; c=relaxed/simple;
	bh=Ui61Kqd3H/BG3qyUqZGqtcVNhOr6wTkCK+eT94OQAKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncB6kYdhbStIrO714DuYKSRPy2buGhGmaw4A6FDKeXhTqli+CctVWW8fEfet561zqvVWJ/KGC0LuUppody3ccsxo/2sAk24j7/8CuwmczXKrpFKYyRxfE0aLhG09fHyWl6iQUU/lSi2IhsWvTjHsTjwv9pdvOkvjlcvEM2hs6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgAZY5dv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343b7c015a8so2510898f8f.1;
        Sat, 27 Apr 2024 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714247881; x=1714852681; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6sLeaB1FlBRZ70pzjbPaLXI6rhtbdR12bImC9yVAPfs=;
        b=TgAZY5dvMK9iS+wRFxPHsUMDwaMa6YtHrHBV908+UpE2anJKGzuJbqmUEyK3l7dQUE
         nBY+1QmkHCJS1gAP0IoBXr4HTHL/G/vCNZ3zzYplcPghsu7v/Q4Aey7q5s1iqgLLtWJP
         CJ9q/G8MZ0nxsGhq/PtAGUeNGig1xCMNhFzJZPJyi2RCoonEVoFyTyYL0S1+OdTnqqld
         3DEfwWvogNXwjaJwyx8PV+sWc1FH++Q5OBhkG2ATXjW47iBBy0rso4+lfQYbAQaBY60l
         CjvPR/5sK63YWateSuRtc5XeGp7hwi/rEsDSd1EfXX+6b4qpWETGsyyy7/EPqBJe+j2m
         h9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714247881; x=1714852681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sLeaB1FlBRZ70pzjbPaLXI6rhtbdR12bImC9yVAPfs=;
        b=QGhjr0MMNXnICJ45zRKrtpSyyPoBMYk8v2WZw4BllSEit7XcZ5i5cxc//nX5EdlARu
         xAbIFXpm5zqTOrXpl0K9Pu0RHPwPYcR1pJnLYiu67cOJdLfj2Vjz9wPbSOjKgJVwYGMs
         KHLb/f2DYeoqwKQIhTtDJ2rVUF4ZizNQLhIyXhimIp8T1zu/DzJ3j0+mtQ30wLpXCwEd
         siYCxnbwCddrhH9F4vbI5TCWG3/CsdAArOTXb5pNLdKUM+WK1o89Ukhsd5swsZzvDbDg
         gzVf/P0wMGw4k+RE8veBaJcef+35qvxoX0AzWNJzTpHJzryig3a+Zo9KNCXE87OHd/wF
         vMwA==
X-Forwarded-Encrypted: i=1; AJvYcCWHczEWqvVgk7uSwjx4iXYqkPBI+iLSxLFsDgLuMFoMJ0hqYLJV/4ceH/fhmUjdGL7JUt5S/ZBZ5NKyCa/NpYqd5Syugf4OfU+zWNZqTz/ZWfxm5/P1Wizkw4FDhFgOAm6IL9V8z6DV
X-Gm-Message-State: AOJu0Yz9BoZLofs7F+yKQd8dYLmy6pSwrIpN1Pd8JGem3/sDdFd6lLqe
	dpw57tLC2qNkSAkYOJaa/8KARs8YibsNZwGytAsBMHZCOmjvCL92
X-Google-Smtp-Source: AGHT+IEHBtMOONwaosJYo1TPf0ytlANQY24e1iMM9bzaAv6Y38WscQM2pqvXe5+AgipOgj89ILTiyQ==
X-Received: by 2002:a05:600c:358c:b0:41b:13a3:6183 with SMTP id p12-20020a05600c358c00b0041b13a36183mr4430923wmq.24.1714247881124;
        Sat, 27 Apr 2024 12:58:01 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b0041bf29ab003sm1870718wmb.30.2024.04.27.12.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 12:58:00 -0700 (PDT)
Date: Sat, 27 Apr 2024 21:57:58 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mcp9600: Fix temperature reading for
 negative values
Message-ID: <20240427195758.GA3350@debian>
References: <20240424185913.1177127-1-dima.fedrau@gmail.com>
 <Ziy8DsMCeAGK79E7@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ziy8DsMCeAGK79E7@debian-BULLSEYE-live-builder-AMD64>

Am Sat, Apr 27, 2024 at 05:49:18AM -0300 schrieb Marcelo Schmitt:
> Hi Dimitri,
> 
> Interesting patch this one.
> I think this does apply, although, the cold junction register has for sign bits
> so I think we could also have a mask to clear those out.
> Some code suggestions inline.
>
Hi Marcelo,

the temperature bits are in two’s complement format for hot and cold
junction. Equations to calculate the temperature are also the same in
the datasheet. There should be no difference when handling them. I don't
think we need to do anything more with the value except sign_extend it to
the appropriate data type. If the sign bits aren't right, there is a bug
in the chip, until then futher processing of it is unneeded. I could add
a comment here if it helps.

> On 04/24, Dimitri Fedrau wrote:
> > Temperature is stored as 16bit value in two's complement format. Current
> > implementation ignores the sign bit. Make it aware of the sign bit by
> > using sign_extend32.
> > 
> > Fixes: 3f6b9598b6df ("iio: temperature: Add MCP9600 thermocouple EMF converter")
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  drivers/iio/temperature/mcp9600.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > index 46845804292b..7a3eef5d5e75 100644
> > --- a/drivers/iio/temperature/mcp9600.c
> > +++ b/drivers/iio/temperature/mcp9600.c
> 
> #define MCP9600_COLD_JUNCTION_SIGN_MSK GENMASK(15,12)
> ...
> 
> > @@ -52,7 +52,8 @@ static int mcp9600_read(struct mcp9600_data *data,
> >  
> >  	if (ret < 0)
> >  		return ret;
> > -	*val = ret;
> > +
> > +	*val = sign_extend32(ret, 15);
> 	if (chan->address == MCP9600_COLD_JUNCTION)
> 		*val &= ~MCP9600_COLD_JUNCTION_SIGN_MSK;
>
This won't work. Assuming int is 32-bit ret = 0xfffe and *val = -2 after
sign_extends32, this would result in *val = -61442 which is wrong.
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.39.2
> > 
> > 
Best regards,
Dimitri Fedrau

