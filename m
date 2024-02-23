Return-Path: <linux-kernel+bounces-78786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF268618CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3CE1F261B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A923912CD90;
	Fri, 23 Feb 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP8EePZm"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372FF1292DB;
	Fri, 23 Feb 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707917; cv=none; b=FLA05cQlobIZEmbzyJLqYiKGImIsuPEFJgvvBOSl0BcwGeZJK4yuNH0WGIFgNrYW8u6oVjKG9n0Xq9NWDMuRGKf6KW0Rr9Mnpv8KmlnnV57kQgz6FtYwkj2vEXoCjBH7CdA4d+Q/q4YrUZiAwLfSrdKlqcBF+VPQaJ31dbe6ZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707917; c=relaxed/simple;
	bh=nTfCHSUZrHylYc95TlvswfvwIsbie0LjLmnPN9Nb4E8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=HUh60EA0JFuXXL4n6+Kgcy9bO0uJkpDYPbv+VmVS/2Hg1NLie6U2bfd9Ls976SqkRvTS2CKkdb+zsa6f8Y7dtXm9ed/9eRKzG9AG5dTnr/Tx0kI769QlViPeoKS3UWdw70kTRMF7omU5iFqXfpNG14mtGckteh39oUY7dNEPcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP8EePZm; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512e01b3da3so1418119e87.3;
        Fri, 23 Feb 2024 09:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708707914; x=1709312714; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=A3Impbxiv5EAmL/2ihqY+6YaD1b8yH8gygmWJaN5vZ4=;
        b=SP8EePZmV8DLbOzmFuPuOLuQRfUzcsoRTI9QPluFNw4CMNlrwmQmyS+5cmw1m+5fTR
         qRXg/XeOP7KeU2iLy0jg3Y8H0CxCSKjZWRD37vD7iOZsjdz59peGLdQce7EntxHVWvmy
         Zyqj34N9rKo9Ly9tS85GVtX0tXVYDYsZN22arHuj0x64Rbwv153klsskoLbzFNdoH0vv
         uamVIBcSjO7ehILGGcqTG4V5zDjORnmO5hJfvlBECRAovpbdJpJ3is1ULun5MvNfYKd/
         M3XfIudCvmT2CYPJFBSPk9SKvmtPcsAwMuG2tgL9GZDdDIZV1aYxPFdKnaiU8ra9AzAW
         /7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707914; x=1709312714;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3Impbxiv5EAmL/2ihqY+6YaD1b8yH8gygmWJaN5vZ4=;
        b=HUno2vYHUoE+T8aFecYZLlykfKylMx0iP0qCgH6UfdwmAkLBbuJs6wcBI2opD6tW26
         fcVhJkvQsahsxo/o/jwq2f9RPFqufHpYadGnqTTAtEy1bmd0Vjnfq/sjlmxh/sbP6XKX
         ZTNR9mPHhIAyWLkxNi3oUTLpkAmOdZp2w39GifQ7r06b3qoGQZfGT0v+Gd0Zsj4jquCW
         RKZEKCIM963VJFqMB5xoxjGdRdeWTU+i21/doip1Y8Pgh7IBN3NbiwncV5bgS3Wcimia
         vXjeOQOWLKVmco6AoqSkMuA+QgP22tFS6fYj8hy3t1KXcQXeANdS2NeAsTBChTiZhOcN
         nBaw==
X-Forwarded-Encrypted: i=1; AJvYcCUyHaYBbEbzPRGWpPTSUUzJGtn3beacr7MDGNS2Mofir4z8KAaXJoa72RMErMXMoKvBdVseq9o7+4Vv2GUJbrpXS9NjajZI4A81FMT2
X-Gm-Message-State: AOJu0Yyb8V0hPIVMyvxHCdPqw8QP7ZraOSbK9vC+3m4vPsDWbTitZ4gw
	+upViVELzQbiv8FXy3n86CJQQXMMyO/zQgEUlfg86aVvxXX66dkj
X-Google-Smtp-Source: AGHT+IHRjiRMWAh93tj+5+l1iYT4rDJQUAZjdAtcDivq865EWbf33d5VqjJE0RQIfxQ2jLfFHhGgAA==
X-Received: by 2002:a05:6512:2523:b0:512:d8ad:b454 with SMTP id be35-20020a056512252300b00512d8adb454mr282175lfb.61.1708707914145;
        Fri, 23 Feb 2024 09:05:14 -0800 (PST)
Received: from razdolb ([37.1.50.248])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b005128c3561b4sm323246lfq.13.2024.02.23.09.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:05:13 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-20-mike.rudenko@gmail.com>
 <20240223114849.GU31348@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, Tommaso
 Merciai <tomm.merciai@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v2 19/20] media: i2c: ov4689: Refactor ov4689_s_stream
Date: Fri, 23 Feb 2024 19:47:18 +0300
In-reply-to: <20240223114849.GU31348@pendragon.ideasonboard.com>
Message-ID: <87msrrcdrq.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Laurent,

and thanks for the review!

On 2024-02-23 at 13:48 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
>
> Thank you for the patch.
>
> On Mon, Dec 18, 2023 at 08:40:40PM +0300, Mikhail Rudenko wrote:
>> Remove repetitive pm_runtime_put calls in ov4689_s_stream function,
>> and call pm_runtime_put once at the end of the "on" branch if any
>> error occurred.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 29 ++++++++++-------------------
>>  1 file changed, 10 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index e997c3231e85..884761d02119 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -555,35 +555,26 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>>  					  ov4689_common_regs,
>>  					  ARRAY_SIZE(ov4689_common_regs),
>>  					  NULL);
>> -		if (ret) {
>> -			pm_runtime_put_sync(dev);
>> -			goto unlock_and_return;
>> -		}
>> +		if (ret)
>> +			goto cleanup_pm;
>>
>>  		ret = ov4689_setup_timings(ov4689, sd_state);
>> -		if (ret) {
>> -			pm_runtime_put(dev);
>> -			goto unlock_and_return;
>> -		}
>> +		if (ret)
>> +			goto cleanup_pm;
>>
>>  		ret = ov4689_setup_blc_anchors(ov4689, sd_state);
>> -		if (ret) {
>> -			pm_runtime_put(dev);
>> -			goto unlock_and_return;
>> -		}
>> +		if (ret)
>> +			goto cleanup_pm;
>>
>>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
>> -		if (ret) {
>> -			pm_runtime_put_sync(dev);
>> -			goto unlock_and_return;
>> -		}
>> +		if (ret)
>> +			goto cleanup_pm;
>>
>>  		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>>  				OV4689_MODE_STREAMING, NULL);
>> -		if (ret) {
>> +cleanup_pm:
>
> A label within an if branch isn't great, readability-wise :-S Could we
> maybe split the ov4687_s_stream() function in two (streamon and
> streamoff, or similar names) ? You would then have a single
> pm_runtime_put_sync() call in ov4689_s_stream(), in the error handling
> path for the streamon function call.

Okay, will split it in v3.

>> +		if (ret)
>>  			pm_runtime_put_sync(dev);
>> -			goto unlock_and_return;
>> -		}
>>  	} else {
>>  		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>>  			  OV4689_MODE_SW_STANDBY, NULL);


--
Best regards,
Mikhail Rudenko

