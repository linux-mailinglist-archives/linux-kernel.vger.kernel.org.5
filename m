Return-Path: <linux-kernel+bounces-51126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332498486D9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F2328573D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B225EE9A;
	Sat,  3 Feb 2024 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE9kFe4Z"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107DB5EE75;
	Sat,  3 Feb 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972047; cv=none; b=TFHFEaoxrfH61xBUT3p7MiEj4W9Zz8PzNrYE00DHNSzurd7N0h8pkIMVQQgRA8b4PH7PFoWnRSdmmfgqM6OEMQgFIrP4Hw6rspTXE0W8U06HUM2v7/PAu5KDbJj9sNKvwiICvD68NxeHvL/PVuohvZQSUMutwf28nCpatv+xe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972047; c=relaxed/simple;
	bh=Zcd+iH5Y0Ii9p4R4z+n/nvtDelVSfGxKcxHReLO5oTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzVbHHtHGnYta9fYypVh7gp7vfyXaLvm6jXAkyV/QgA/poDJsax4nyjvSnXEqpEJ6VufhkC6I2YRhB2gJZbXWCr8qXn72S+6Ba6f4X5yFAj8ookz4UdyZg5ZJ5RqiekLGOSp1B93tKYCVnHPiQVryJRDqKEEfiT4IJHuyxWJGNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE9kFe4Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fc6578423so14208685e9.0;
        Sat, 03 Feb 2024 06:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706972044; x=1707576844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ePAtovw+k3zbA+OWhit8yy/P/cL4JvFGKoi/21GByA=;
        b=UE9kFe4ZQhxUrRRZUPUvb8qSEjuZMBCvtxQn4XxgHf5BW9VSiwFUzpKj5+4FJS9AmM
         3Rp1P0CN7/dpEpnm3Seewn0pgV3JsFhS5eXAI74VM5xS6p6TvSbOrf4TpxU0pxz9ZJ+1
         LxHc4ky7UlnDkw1ewLTOQ76TaZI3FtZRTR9IUA62KLK69HOXJlyAx0/TqMVyDdBx0mZT
         WFbAb810HTFOtFuMuAMITDweoxxdS/TJeDsb+IIdo/OAwnWoEcdrNmDai7npT5Ki/Gdp
         6oMxQPxg4lfI2ewDA2eYo0/z6qusoRKknKuUlBJDICH3FNf+6asLatvXfRtM61aScO/4
         CgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706972044; x=1707576844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ePAtovw+k3zbA+OWhit8yy/P/cL4JvFGKoi/21GByA=;
        b=pyQvKVVOUObpp6FeA3bod0/70jakQyykMxUg/Z7XLk+A/v8dGJ4Ll6/KbD+cV2bIGT
         yxVfq4f8vE1K9Kvxkedy6hT9mjml/LCa0ZMLWBwAD3q0yAWc9QBdAfI6HmvbY5AbNxio
         CistGvYh9XBsGidgz05D8QY+L9hlPpSo5hVa+c2SpgDPTEADBvemdUtlZpdJM/iNHFd3
         6NlKBhLs82ex19MU7WzwFvqIvYuQbhKlVlVY/f0N/TbAIN7hq/XFo7Ur36tzbetOQu1j
         x8RekUbKCOqyCuvLFbMwOViaqNcPZeWatfOHV2tIVALtV1EV5Pf6Nku/XOaf+O7OOQn2
         4Wsg==
X-Gm-Message-State: AOJu0YyFCW1OffROWYNDtZHVuHwhZCT1rKtQ24wCbzOHXX8ko3nXQtcY
	2ir1TPepxbK9kCWbj9/5gRhUhaJYYhBM1A5UbQTqlF44oqkPYaOMm70tX9gm
X-Google-Smtp-Source: AGHT+IFNuh0mUvKtg1xYcF7ygw9nkUXrqmyMckhN1LIWsSbrWMQUyQzpx9tzCOOKOQbmhocTmF2pWA==
X-Received: by 2002:adf:eccf:0:b0:33b:295f:4e6 with SMTP id s15-20020adfeccf000000b0033b295f04e6mr1863399wro.55.1706972044033;
        Sat, 03 Feb 2024 06:54:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUcBQHNzSNfwu0bq76K4EN4l5Pbu/RUYCFqvKYawM2sLGcGAerRm3q9ft8bZu2sROSM/oAbYQ5uQta9u3YJhvMmrSUCfxl85kZ22cvsKixXKFm4AwA+HLzBUmkYOX8+DCmDQZ4mANeomq56CxK3e1/NJ9w+HZukz4FQ8/tpNeRLsbEpvs1fhi2LG6nL5iaeVtScoPUprPD+HIVPHJQ=
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id fg5-20020a056402548500b0055fec2accffsm1680644edb.45.2024.02.03.06.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:54:03 -0800 (PST)
Date: Sat, 3 Feb 2024 15:54:01 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 579lpy@gmail.com,
	jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240203145401.GC3727@debian>
References: <20240203090530.53374-1-dima.fedrau@gmail.com>
 <236dc9db-8525-413e-a77b-54df198c86f5@wanadoo.fr>
 <b789eb01-5b5d-4513-88d2-1f14e95969d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b789eb01-5b5d-4513-88d2-1f14e95969d9@gmail.com>

Am Sat, Feb 03, 2024 at 11:06:02AM +0100 schrieb Javier Carrasco:
> On 03.02.24 10:58, Christophe JAILLET wrote:
> > Le 03/02/2024 à 10:05, Dimitri Fedrau a écrit :
> >> [...]
> >>   drivers/iio/humidity/hdc3020.c | 339 +++++++++++++++++++++++++++++++++
> >>   1 file changed, 339 insertions(+)
> 
> ...
> 
> >> +    guard(mutex)(&data->lock);
> >> +    switch (chan->type) {
> >> +    case IIO_TEMP:
> >> +        /*
> >> +         * Store truncated temperature threshold into 9 LSBs while
> >> +         * keeping the old humidity threshold in the 7 MSBs.
> >> +         */
> >> +        val = (((val + 45) * 65535 / 175) >> HDC3020_THRESH_TEMP_SHIFT);
> > 
> > Why 175?
> > If the span is -40/+120, I guess it should be 160 and if it is -45/+120,
> > 165. No?
> > 
> > Maybe something like:
> >   #define MIN_TEMP -45 (or -40)
> >   #define MAX_TEMP 120
> > in order to avoid hard coded constant?
> > 
> 
> the 45 and 175 values come from the conversion formula provided in the
> datasheet (page 13), even though the sensor range is from –40°C to 125°C.
> 
Will add following constants:
#define MIN_TEMP -40
#define MAX_TEMP 125

It's the supported temperature range by the chip as Javier already
explained. Thanks for finding this.
> >> [...]

Best regards,
Dimitri

