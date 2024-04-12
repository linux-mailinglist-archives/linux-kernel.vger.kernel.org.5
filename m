Return-Path: <linux-kernel+bounces-142677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074C8A2EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13A31C20D00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B75BAC3;
	Fri, 12 Apr 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctdkXiC+"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3BC5A7AE;
	Fri, 12 Apr 2024 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927009; cv=none; b=L6GJBxIPMUgb3oJ9Sv0SVXE8Nux2dXj0VHZJfhJaMWmfiJ48pUEDPhwpsgBUssDScK7XnUR19vmXURwzYvvsdzxia2/RppfQRYqeFJjBjkYQteKyU6TqlHygiqnTDPOT5KSFrZEm8/rIMW3p2VfAV64Ue0xe2iGJgzwPyLB8lwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927009; c=relaxed/simple;
	bh=2mfkII1UFgJ/UcAysczGES4ndZ4OYOJnqliLmLwA/ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI5a2DdtJFa3H1KV+/BBoByuCniN9fKeFgt29h4pGoCj2bVR9YdTcFeVweL+bTk6qUoRJmeniMYh+t8eIdnpIocjML0FoVBHX/++iY6Ma4PnqK11by0RJ+CZ6UptWOHbl+kaFeQKbmRYwpUVFp2mILh9RTRVW5lvTmbLVBBBFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctdkXiC+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so816038b3a.0;
        Fri, 12 Apr 2024 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712927004; x=1713531804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIsjf3aLoig4q1mbYS+gmuEcYpav6PcrUNtXYP3Kx60=;
        b=ctdkXiC+kUd+C/cJBEylAVhNByIzbtqFukDIeDy93YlzrLYFatfuC1yh4mXv6A8dQH
         2lbb8TJmTNn4R75Xbw/Hnji1mgrcEQVq698/D4GeD15leKGCh1HCxRASntwMLF7Z6IBM
         6e13lmPjMCH2BPfxhtXi8kApU8qcD5b0julAgU/KVkC/UfBIs0Apz9VdwB+cp1xut5T9
         plqVkmo9tA7qIDSxOqRRfM2HXhdqgRNaEBj/NdEUVlVUURDOnJYn5lU0KtDsJi3CC+Eb
         +SGd+ZuIwjAGAHk1u9YUo/o/6h9ncScEkHgwou4kpdlEfd96N99YF2RAHqVWP5iUqNX9
         0Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927004; x=1713531804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIsjf3aLoig4q1mbYS+gmuEcYpav6PcrUNtXYP3Kx60=;
        b=aMH/dwowbFiw/m832m2WvJ0fGEUGvsS3T+n4wog/Yrw6agVTpps4HA/23UclC19PpL
         iuPpF1EgBj0ri3bab5Il7Kv/ZXY4lC6uJqw61Hhsa6YDUbio7CAy3dZ9EgKpyQss8J1F
         XNI4Lx6PfAyjJwk9KdHGz0J8fNacwspgLotkq6WL5JWIelydcdc7A5rWXbrbf2KfZhe7
         lL2vbYR+UOzEVDMb4Uec6ftK56NnAhVITZf4LcaQNcWQJ+D+0K1mLlfnx2toKONcD99M
         ckCxR8TyZzWNnkZuotNWCG39ZP9XVZqzGyndyyZRlt8OLnWvndBMs7wi8wuf6bqnWXPX
         5j7A==
X-Forwarded-Encrypted: i=1; AJvYcCUirwOa6hqA1DaUBCA3drBtfzL91smtAS1uX5hJSLRKleMoXjpEMKrhrkrEmru5UQLhai71P4EOYpoEWxSNRnx4AbmOHLJAAdAMNWFr2lDN+fj+DtOeVmeCINjehclG1TKwoqowkmkeFYk=
X-Gm-Message-State: AOJu0YxQl7IMhY/72/cHFszerSz6fRgtrh0wTFQUbAzWXgoXtH9OUaw8
	YCb58DtaNgLT9fHWqH9aWX1Dsya20pXzxLqOaL1cN95mE5q4zF+t30Up5Q==
X-Google-Smtp-Source: AGHT+IF0XuluccTFbg8j3Mg7G+GD3aqe+WpyKIX9ogwEPa2Yk+UDznXRGU7eXJxACr9rZ3Av8aKPcQ==
X-Received: by 2002:a05:6a21:1f09:b0:1a9:3ac0:f1f1 with SMTP id ry9-20020a056a211f0900b001a93ac0f1f1mr2310292pzb.34.1712927003750;
        Fri, 12 Apr 2024 06:03:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m3-20020a056a00080300b006ecfc3a8d6csm2811458pfk.124.2024.04.12.06.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 06:03:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 12 Apr 2024 06:03:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: max31790: revise the scale to write pwm
Message-ID: <d82d5585-ec6c-4611-ad33-9c2d00745176@roeck-us.net>
References: <20240412032559.3352846-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412032559.3352846-1-Delphine_CC_Chiu@wiwynn.com>

On Fri, Apr 12, 2024 at 11:25:58AM +0800, Delphine CC Chiu wrote:
> Since the value for PWMOUT Target Duty Cycle register is a 9 bit
> left-justified value that ranges from 0 to 511 and is contained in 2
> bytes.
> 
> There is an issue that the LSB of the 9 bit would always be zero if it
> just left shift 8 bit for the value that write to PWMOUT Target Duty
> Cycle register.
> 
> Therefore, revise the scale of the value that was writen to pwm input
> from 255 to 511 and modify the value to left-justified value.
> 

The only difference is that it writes 511 instead of 510. All other
values are the same. I am not sure if that is really worth the
trouble. It would have made a little more sense to me if you had
used DIV_ROUND_CLOSEST(), but you didn't do that. As it is, I really
don't understand the point. If it is really important to write 511
instead of 510, the commit description should explain that and not
talk about the last bit always being zero (which it still is after
this patch except, again, when writing 511 instead of 510).

Thanks,
Guenter

> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  drivers/hwmon/max31790.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> index 3dc95196b229..bd201191da1c 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -49,6 +49,9 @@
>  
>  #define NR_CHANNEL			6
>  
> +#define PWM_INPUT_SCALE	255
> +#define MAX31790_REG_PWMOUT_SCALE	511
> +
>  /*
>   * Client data (each client gets its own)
>   */
> @@ -343,10 +346,12 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
>  			err = -EINVAL;
>  			break;
>  		}
> +
> +		val = val * MAX31790_REG_PWMOUT_SCALE / PWM_INPUT_SCALE;
>  		data->valid = false;
>  		err = i2c_smbus_write_word_swapped(client,
>  						   MAX31790_REG_PWMOUT(channel),
> -						   val << 8);
> +						   val << 7);
>  		break;
>  	case hwmon_pwm_enable:
>  		fan_config = data->fan_config[channel];
> -- 
> 2.25.1
> 

