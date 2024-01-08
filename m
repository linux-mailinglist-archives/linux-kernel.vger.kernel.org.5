Return-Path: <linux-kernel+bounces-19151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8F78268D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3908E281495
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8ADB657;
	Mon,  8 Jan 2024 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmD6OeXs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9BAD5C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so1732072f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 23:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704699932; x=1705304732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4R7zFNbYw2qFYjjZ7Hhvt2bu70OTe/BkCFpVx1f7WyA=;
        b=PmD6OeXstxb5A31LEYjo0xL+Q0E8G0rGGkkYs5U/5cP+MWz/XAxzIX5u773S3CyX0A
         5ttEepIrM3tsH1V/Ni+NPNIQaxgNIUa6KaPjtVkOVQ6OusaYKln59Fol46TX6f6GDpYa
         bzsDlMHXroEfRwURpcwe6OZdPzgNOk9w38thtfJBQis5uMdqa6SmRCh6V+H3wYCn210k
         PJQu90R7VabFKeN9DK8NtOKkdY5296GufRTiVL9hua2XWl+CKu2ftEU5jpcWCdoxRhtA
         NAcdupiUTy9OkDWiL1vP8EXO1MR8X0QK5ed/RZKrzKd60w8fNs18GnAqdmnSralmRJLf
         q+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704699932; x=1705304732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4R7zFNbYw2qFYjjZ7Hhvt2bu70OTe/BkCFpVx1f7WyA=;
        b=hFLg+cKKVeNlYY6yM5k128c2MNAoYEojbP2FwQrxNl7dEBzadJ1XJ7hZvwsJX+HH1s
         TtulRDDbOL4w7Y4lU1DBVCN5U07rW9tY/1X+satn4nVNpbUe2SKnaqcnoTlbZAJxIwti
         GTXJ/ahTDjwP7/vLVQf8eCT/guF5w4RZPI3Hewe/LYjSZLkWdMxiLc3cbRKFFuCGkIwD
         H1+/Qvg0C0OzOdIFRGeTzxu9Ex91KKSdm++Gz6NonDwfPXNHqVPQzYrG1nD4kICIwVkG
         6i+w36B2nCaKJSTyH0N/X0oS4y/+b7UxjSd5S9jcJKeWomYKzoZ8gSahAFW/C7CcLDHo
         88Qg==
X-Gm-Message-State: AOJu0Yy8aZxCwyel85DuMPZDoHT9Vuy4Ql69nf/TzuhPq0NoNfkMa1se
	e/8ioJmFmNs6lpI5cmL3q4uJlS0/40oOig==
X-Google-Smtp-Source: AGHT+IFDv57oOOp3IpBL5sCB33qAJ6m5GSX9lNhBOkjTZxdGEYQWG+1sZpwAZ0e9wHC+AIp1WMXOFw==
X-Received: by 2002:adf:ffce:0:b0:337:5d83:6b93 with SMTP id x14-20020adfffce000000b003375d836b93mr875129wrs.49.1704699931940;
        Sun, 07 Jan 2024 23:45:31 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id c12-20020adfe70c000000b003373fe3d345sm6995818wrm.65.2024.01.07.23.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 23:45:31 -0800 (PST)
Date: Mon, 8 Jan 2024 10:45:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Justin Chen <justinpopo6@gmail.com>
Cc: David Lechner <david@lechnology.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: ti-ads7950: remove redundant assignment
 to variable ret
Message-ID: <8bf3f6b7-5780-42ca-bbbd-8723a75d5128@moroto.mountain>
References: <20240106152251.54617-1-colin.i.king@gmail.com>
 <e0f58f77-1dd0-4def-84ec-eded4b7d2092@lechnology.com>
 <20240107160232.4cdbae62@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107160232.4cdbae62@jic23-huawei>

Justin Chen should have been on the CC list...  It's a little late now
because we've kind of figured things out already, but lets add him
anyway.

regards,
dan carpenter

On Sun, Jan 07, 2024 at 04:02:32PM +0000, Jonathan Cameron wrote:
> On Sat, 6 Jan 2024 12:14:22 -0600
> David Lechner <david@lechnology.com> wrote:
> 
> > On 1/6/24 9:22 AM, Colin Ian King wrote:
> > > Variable ret is being assigned a value that is never read, the variable
> > > is being re-assigned again a few statements later. Remove it.
> > > 
> > > Cleans up clang scan build warning:
> > > warning: Value stored to 'ret' is never read [deadcode.DeadStores]
> > > 
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > > ---
> > >   drivers/iio/adc/ti-ads7950.c | 2 --
> > >   1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> > > index 263fc3a1b87e..f975de059ba0 100644
> > > --- a/drivers/iio/adc/ti-ads7950.c
> > > +++ b/drivers/iio/adc/ti-ads7950.c
> > > @@ -441,8 +441,6 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
> > >   	if (ret)
> > >   		goto out;
> > >   
> > > -	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
> > > -
> > >   	/* Revert back to original settings */
> > >   	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
> > >   	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);  
> > 
> > This does not look like the correct fix. This is the intended return value of the function in the case of no errors. So we probably need to introduce a new variable instead so that it doesn't get written over.
> 
> Agreed.  Needs to stash that in another local variable and return that value
> if ret == 0.
> 
> J
> 

