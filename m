Return-Path: <linux-kernel+bounces-123046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A889016E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8944929712E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BA38287E;
	Thu, 28 Mar 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlV48aIO"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36F8172F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635282; cv=none; b=A3FBST7HWDCaiKWrHVHwK3Cx7Fdmw9D5K5ypN1+kFhyWFKx0eLIkxh3MbvBQRTv6JOnwAOQzhusyepjp2leapNRwZX3MdjrsgT8bWs8hspMFUFHLKeeSF8YNtS0QtFh7ROlCARkI9k6YmceZwu3gWXXiK4O2K0bR5sx+QHVwPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635282; c=relaxed/simple;
	bh=qrYc08EP6AFDenl97miAzK1JrtIi1dnIodt4yH8JsYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILZdUBbXyl5vjkbIIAueevR2goU8hPfuQJBc8WgKsphLvgnWA+B2CPVKLnB85dMqrVApCugNgG7oAIcTgM16xYmCT4mKS6bIFq3WbNHcWGftKTaS96BjOU5Z3M7QbF989xI92Oxb9iEB2LEn5hviKbTWbCWNvNHvCt/1yXQoYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GlV48aIO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d700beb60bso20333621fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711635277; x=1712240077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6oWYRVINerjym6vzjXH/2h5b9vyRctc2Bdq5lqck3tg=;
        b=GlV48aIOa/Kn/Ma6HdTowpp6vF92UIXaf8BA4uwQTvnXXWVhcsYA9h+2bcXKcCJ9Wi
         2ywOkRv+Sv+nOw49ydAjcTYmnXBiPHHE/Q+xsDXg9Kg7AZ+Qe5cz+kAQoP233sQvPk57
         LfZN4jkjMeF3qcTQJKGto0VP2uPUjr/RtGhYArbMrSNZNibqm+0V7crMpnQWXtqluxKT
         euBhouYNGjhy0TDDxZaIHqpiTgdtXvSnOn6f6RlvTQyXXertGjFTVhzIgCVOeqkebFo5
         GBOZG2KoXEZ2sLI9acDa5srbUoBV9V687uKTifdsNPfvUS9AhNvhwWqoXmVmXMLaX5cv
         bmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635277; x=1712240077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oWYRVINerjym6vzjXH/2h5b9vyRctc2Bdq5lqck3tg=;
        b=dkLfgHTMTAqAY0RG5FRvvYGYXQmpoUsP5duhauPuhhJcN1KSxYnw3B98iTeUM7NuGM
         KHZe8DqdqhpcEm6j+Yvsx5B3/DN9H6APSfALFSV7ke1CzJx1n9mOzVTnt5cqP6+BbGZV
         IW1eXkxXQHKtaLIPbytL5vUG3BYqUnABZhQgHCY9l6N9WnJp05ihC+4wyQCUl5b+g19u
         xDYw6WpR2WBINNFLz0+mSBzqXXiuIKR6ARq0KzoI58LYxSsg2VWX/4yuHrif/GJiGDEr
         w5rsscLjvmPu7TCF+ttsEq5WB7a2O3GsqeBqlEVGaM5Szrkq1uPfF8vKt8get/JDKtpY
         BLHA==
X-Forwarded-Encrypted: i=1; AJvYcCXEsnbOvxnsA5wK6E27H5SafWDGDRNOFaRJh/kAmzNRVQVrO9rueIt+MUfurcfszZ+XK7yPSDrRC9X6ZB6IqRzx3Eeuhqb3N0RU3S8S
X-Gm-Message-State: AOJu0Yx9oDyqpVZWusEN8NGrWQc9LBOeMwX9Dks/mW5d00Vb5EABBc+x
	eIER5sLK5N1507hkrGdOTclDjERHQGnwMQivXtZDPWJzRrA6ZsC6km54MUtNyKM=
X-Google-Smtp-Source: AGHT+IE3br1OhO1/0SPJPwkg2myEiiviYtyqBnpxzvQ+t1dUHLWgpGeIq7RDtQXfcR5zXgo+wJaZ8w==
X-Received: by 2002:a19:910f:0:b0:513:e0b8:563a with SMTP id t15-20020a19910f000000b00513e0b8563amr2582312lfd.62.1711635276475;
        Thu, 28 Mar 2024 07:14:36 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id w27-20020a170906131b00b00a4df7d02395sm793978ejb.86.2024.03.28.07.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:14:36 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:14:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: addac: ad74115: remove redundant if statement
Message-ID: <2b3d418d-55ee-4ca4-b6ae-bab441a76adf@moroto.mountain>
References: <20240328112211.761618-1-colin.i.king@gmail.com>
 <3db9a68c6f71a67d95d25886fdc708de6269adc2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3db9a68c6f71a67d95d25886fdc708de6269adc2.camel@gmail.com>

On Thu, Mar 28, 2024 at 02:52:43PM +0100, Nuno Sá wrote:
> Hi Colin,
> 
> Thanks for your patch...
> 
> On Thu, 2024-03-28 at 11:22 +0000, Colin Ian King wrote:
> > The if statement is redundant because the variable i being
> > assigned in the statement is never read afterwards. Remove it.
> > 
> > Cleans up clang scan build warning:
> > drivers/iio/addac/ad74115.c:570:3: warning: Value stored to 'i'
> > is never read [deadcode.DeadStores]
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  drivers/iio/addac/ad74115.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> > index e6bc5eb3788d..d31d4adb017e 100644
> > --- a/drivers/iio/addac/ad74115.c
> > +++ b/drivers/iio/addac/ad74115.c
> > @@ -566,9 +566,6 @@ static int ad74115_set_comp_debounce(struct ad74115_state *st,
> > unsigned int val)
> >  		if (val <= ad74115_debounce_tbl[i])
> >  			break;
> >  
> > -	if (i == len)
> > -		i = len - 1;
> > -
> 
> Hmm, this change is clearly good but I think we're actually missing the proper fix in
> here. I'm being lazy and not checking the datasheet and Cosmin can further comment.
> But I'm fairly sure that the intent of the code is actually to use i in the call to
> regmap_update_bits(). I mean if we look at the mask AD74115_DIN_DEBOUNCE_MASK and the
> possible values of val...

Good eye.  I haven't looked at the datasheet either, but logically I
would think you go until you hit something that is too high and then
step back to the valid valies.  In other words the <= should be < and
the i = len - 1 should just be i--.

(The first element in the ad74115_debounce_tbl[] array is zero btw, so
it's never going to break with i == 0).

regards,
dan carpenter

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index e6bc5eb3788d..8d484cefe5ff 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -559,19 +559,16 @@ static void ad74115_gpio_set(struct gpio_chip *gc, unsigned int offset, int valu
 
 static int ad74115_set_comp_debounce(struct ad74115_state *st, unsigned int val)
 {
-	unsigned int len = ARRAY_SIZE(ad74115_debounce_tbl);
 	unsigned int i;
 
-	for (i = 0; i < len; i++)
-		if (val <= ad74115_debounce_tbl[i])
+	for (i = 0; i < ARRAY_SIZE(ad74115_debounce_tbl); i++)
+		if (ad74115_debounce_tbl[i] > val)
 			break;
-
-	if (i == len)
-		i = len - 1;
+	i--;
 
 	return regmap_update_bits(st->regmap, AD74115_DIN_CONFIG1_REG,
 				  AD74115_DIN_DEBOUNCE_MASK,
-				  FIELD_PREP(AD74115_DIN_DEBOUNCE_MASK, val));
+				  FIELD_PREP(AD74115_DIN_DEBOUNCE_MASK, ad74115_debounce_tbl[i]));
 }
 
 static int ad74115_comp_gpio_get_direction(struct gpio_chip *chip,

