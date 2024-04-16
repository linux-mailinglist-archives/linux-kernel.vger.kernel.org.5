Return-Path: <linux-kernel+bounces-147642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9736D8A76CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E971C22C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528A13CFA9;
	Tue, 16 Apr 2024 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeD9JxZV"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0F6BFAC;
	Tue, 16 Apr 2024 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302750; cv=none; b=X0MNfBGZaT63rBy33yG03Wh65kOUw0MfQpw+txJtUhxY9Jsn7UZULLKBi/DgoT8OzuQCXFL2OKI13Wxy2OYZ55vG4QUXVzP8/xBHXVtxGzJf/xAgrA2X91S8RmsQrlvENYF6p4aUHETggoyd8myNG3eD5XTky53NYVt6gnfheZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302750; c=relaxed/simple;
	bh=RB4Rxo3I7P044H/tx+EKgHt+XNavBTu4zY8/fN6zuFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crSvuYYgosGmChOKRwc9WqJLmkNA21sy0smuyxSUIuN+JgfcDvdpJi7iRubYr2e8Xb+PZSpr1fAdgGWuBXXkSTKwseu+pQE+nHixXye7SwskOiO9vBtU0BhBhshzcax4Yz0Cb+cjSYRhZH7Mhf4rfyMaDM+zeevJjWni+5LB75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeD9JxZV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ee0642f718so143571b3a.0;
        Tue, 16 Apr 2024 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713302748; x=1713907548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fP5MOJtrXkNm3fcuGMZuhHc4ZbLwMwjSduM2DxDigco=;
        b=WeD9JxZV2986QGO1rYuPOYZd+V7uLLw+76x6UxC1HODRofqwsq2RMMyWjk7qQ6Z8M1
         JEYZTtx3fA8hYNljtS/EmT1B3IYNh3csQJAbESEV0L7WrO/xG6aZZyhU96pHTGocQRbD
         ioTZgy31Vl/9ZnRRqCNv+duODEaxrHnRQ8UYz1xxzm9rxf+hDvwfPHmTIM+VsloHFH5P
         iz0fj4+9neHZWHWRq2Vz8leCnNoSD+Y67IwV9cfWtlDPSHZ3H14xVWr46o1Qvo7i28ZG
         0RDwUaRdOPEi8bnZL+KRT+nOQRJxLZysCI0cIBMg0tjbDorYHwBCUYsGypvS0Ac4rc7J
         89TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713302748; x=1713907548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fP5MOJtrXkNm3fcuGMZuhHc4ZbLwMwjSduM2DxDigco=;
        b=oHW/2ly+y/Of1529X/mJNG+1w+z2DFetQT8jWm7k3Wpi7CBXHo2BKvAHdvrmErnY5u
         usM+9fd7WbxtnzTOWbEQ9YuMkZ6mLIioxCQ2kl6j/HcrI2OjpOz6hPQFeMjdVujSNsvW
         kEmxo1fbNxsxi47Jwdw4WaSRxWJxvbXGVHq5+b/Vh6wivMgwTflE1m4MAdb3agMOY3Qe
         H/CNGBz9c9Ec2rnW7JFmY47RJQhtQuJINV4heyZtAx8tsAgqa80un8RsonVE/PyH+pXm
         xo7UOaiWt5qt4dd7rk1dLRLfHR7niAhYyp9R/HyCRPsGaBDL/HxDrVIltRy6c31rqGGf
         59Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUUtgmjHO9/DKhlp8Fw8Xj1CFkja7AExEm7e50w5nnV0HovNEGxxTIoTtgNkpZlUxq5GlDmtNa8BTXnLGOaWQdFBxDV82oJmqkNtPpKLI/ICXIMtaUNNBbF3tXhzWW6i9exWvT1oW9Q9p0=
X-Gm-Message-State: AOJu0YyXofnSN/pEAo6tgfxuqoKx2X+isIpTONHHxK6CY50BT4qFFcxb
	D1xakc4eY+bXtnYgd3JkvM+mi5amcflL+NgfYoVE1hfcXQ7HCzeQ
X-Google-Smtp-Source: AGHT+IEhDhwTQnDdc0hwtRRPa0zKvBcAkWrkdpJ+nrPPjEM/bTQXfGHrNDWKJLE0uJCZDyYpfIbKCw==
X-Received: by 2002:a05:6a21:3983:b0:1aa:6461:f6e5 with SMTP id ad3-20020a056a21398300b001aa6461f6e5mr1745736pzc.7.1713302748205;
        Tue, 16 Apr 2024 14:25:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e15-20020aa798cf000000b006ea6ca5295bsm9308917pfm.164.2024.04.16.14.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 14:25:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Apr 2024 14:25:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] hwmon (max6639): Use regmap
Message-ID: <65607114-89f8-4f48-83fc-b89d87fee247@roeck-us.net>
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416171720.2875916-1-naresh.solanki@9elements.com>

On Tue, Apr 16, 2024 at 10:47:14PM +0530, Naresh Solanki wrote:
> Add regmap support.
> 

Missing (and not really utilizing) the benefits of using regmap.

> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  drivers/hwmon/Kconfig   |   1 +
>  drivers/hwmon/max6639.c | 157 ++++++++++++++++++++--------------------
>  2 files changed, 80 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index c89776d91795..257ec5360e35 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1223,6 +1223,7 @@ config SENSORS_MAX6621
>  config SENSORS_MAX6639
>  	tristate "Maxim MAX6639 sensor chip"
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  If you say yes here you get support for the MAX6639
>  	  sensor chips.
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index aa7f21ab2395..1af93fc53cb5 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -20,6 +20,7 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_data/max6639.h>
> +#include <linux/regmap.h>
>  
>  /* Addresses to scan */
>  static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> @@ -57,6 +58,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
>  
>  #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
>  
> +#define MAX6639_NDEV				2
> +
>  static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
>  
>  #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
> @@ -67,7 +70,7 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
>   * Client data (each client gets its own)
>   */
>  struct max6639_data {
> -	struct i2c_client *client;
> +	struct regmap *regmap;
>  	struct mutex update_lock;
>  	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
> @@ -95,9 +98,8 @@ struct max6639_data {
>  static struct max6639_data *max6639_update_device(struct device *dev)
>  {
>  	struct max6639_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	struct max6639_data *ret = data;
> -	int i;
> +	int i, err;
>  	int status_reg;
>  
>  	mutex_lock(&data->update_lock);
> @@ -105,39 +107,35 @@ static struct max6639_data *max6639_update_device(struct device *dev)

Conversions to regmap should drop all local caching and use regmap
for caching (where appropriate) instead.

Guenter

