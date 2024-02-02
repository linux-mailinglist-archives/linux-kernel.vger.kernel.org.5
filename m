Return-Path: <linux-kernel+bounces-50451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0084791D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B52286918
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE4130AD0;
	Fri,  2 Feb 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHGqS+Y5"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DD12F374;
	Fri,  2 Feb 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900112; cv=none; b=BDy/aI4AZeTHU35URM0kz2brlVajgL6qVgAb84NzjxJo/Qatj6DSKjgEsfsnupFVlirLQfGdCajZcfDG9qHfIJOz7rX27N5lZmDrm81GAzFG1z0xkqrwEUQVXp7VDCQ6JTHArxUCZBLr0BBhbdDuGXgdwT+cwxL4/3ZsHKoqB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900112; c=relaxed/simple;
	bh=wI0PcvPaxVwO8f49oHmqgaiLgaJCeRkjcjORXrj0yQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpC2+ZnJ2AE+o9XGzznAnSmnbwdQg3shjACVMpKvmknbPlyYh7n2VGczBq9tHVB5PQjS/sSUwHaZWddHWIIRk2uwEzog1SUz0bEChAtRNMWgGb01N5OoqIZ+JYOoCrVVHD2Bq1NZATCXagNRQ5yI2rBrI4w2fUtt1mkGyzFo7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHGqS+Y5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6dfc321c677so1816667b3a.3;
        Fri, 02 Feb 2024 10:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900110; x=1707504910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdDfaxSXjG2k+vpTWUrpgFDiN2k8y42uIGZB8zp3Ae0=;
        b=dHGqS+Y5Vmpe41zCIOJRZWS/KRZUi5DgnU5H+AF2Za4wl83zdEDrtbOzrE5kehNlA2
         9OH8jSIROMCb2ypgu6gvWwyKtiVnf4Ahx7peLUG0+rTdKcncNHZoQkOe++w+1NImRTpC
         93CJO0BFgKL3ZhbdT9rh6WDkhQm/QxZpbzf4Z30qA+hq0NvNr4ZB1VESTIs4MYK1LGXu
         Lm7xLbE/eOy+C7M9WsIkaIafoFCbBc17NRLNk3930HEFgx7KgciGcAgS+m/GUarSKNHI
         3vhUihsRnZDNNr0oRvay/SA9WHmH8kzhMXLAWi3IsYqWdai6njFKMvR7sPm4pdWxYdkY
         ojBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900110; x=1707504910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdDfaxSXjG2k+vpTWUrpgFDiN2k8y42uIGZB8zp3Ae0=;
        b=VdDakdOfs4hRI3wxlAB3fLMlyUvitVxUW8OMMSPCZy3DoU4duGQWIcO7sTE9TBzZ6L
         6WZoLZnM615dy8D9QW8nNMuysn/D6JwigUX52QoFrku4X0xD8QTTsXT6rkhkcOj/i93T
         sk3KhOcj6KR7/Oungl/MnZjA+vCmn9tPj19nA2jcEeDd6mW6bKjo5JXQgRu8DfpVUMd6
         E8nYLiEdnqGKj2IS2oXWWvVVAXYNHElV6fpoU9IHuHy/qB/W9XOH+7kt/C6AlSHLJV2D
         TML5IgssjQxd2MFdcGYTZ/BDpC350+R1S5e/sGGly924SPoEXaBGk1ZFy8QIpk45lQMT
         behw==
X-Gm-Message-State: AOJu0YzYExFJi1XbXhjVHvSOmg7i7ibdA2eJT4WiprStEj1ddxvv1Kgg
	2XMNgaYL8WdVnF2+ofPzUVn3pApBQ3ucOLdOWIYBZaejEL9qZZQt
X-Google-Smtp-Source: AGHT+IE7Gvv+o2fORGrEBqEjpZeNithH+bjHY4zxsqmt0pyGkt3rt2AVH8Hh8p2xwOMl1sb1WHsBkA==
X-Received: by 2002:a05:6a00:93a2:b0:6d9:bc39:e5ac with SMTP id ka34-20020a056a0093a200b006d9bc39e5acmr4079733pfb.6.1706900110171;
        Fri, 02 Feb 2024 10:55:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUH4vGZDmD+gXy5SFx3VkGjYWet+rM9/wJZb8CCC2bRFAPzZOlGTpUXTf1QRew7MUGjL8sKpXbuQrtJtmdVRhGPW/R9rKtC7iCA8H1fiMpC9x/TEckKHXGJFZsK2Lde0YUc9H4BwPSLYCfkA0MVujUv7OaTTPZQC37UGY/v0Mw26qdFsS8yx/TVX3/4TR3Fg0qREUozM7tcN8MZi5XGMGtYDvlbLQKusLsr44VNzvJ8qBQxcRV2xwiOavvv1JVfNjkZ4dJllh8QaHKYnygH8GANv9bF7VJH4suYOMRH57I4bJvakJ7R03Y0HHIa9sS6tBtZpuIHGezFUCi7oJ8AECKpVkiCl8w9FVWp0XLTqYdpJKDHkdmb6pFRy0jZTaFtofShQ8K6
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h15-20020aa786cf000000b006da8f6650a2sm1964358pfo.155.2024.02.02.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:55:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 10:55:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 2/5] hwmon: (core) Add support for humidity min/max
 alarm
Message-ID: <d4e8d58b-840b-4b7b-a7d9-ae8a4d1531ce@roeck-us.net>
References: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
 <20240130-topic-chipcap2-v6-2-260bea05cf9b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-topic-chipcap2-v6-2-260bea05cf9b@gmail.com>

On Tue, Jan 30, 2024 at 10:06:45PM +0100, Javier Carrasco wrote:
> Add min_alarm and max_alarm attributes for humidityX to support devices
> that can generate these alarms.
> Such attributes already exist for other magnitudes such as tempX.
> 
> Tested with a ChipCap 2 temperature-humidity sensor.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/hwmon.c | 2 ++
>  include/linux/hwmon.h | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index c7dd3f5b2bd5..b51d13f08d27 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -586,6 +586,8 @@ static const char * const hwmon_humidity_attr_templates[] = {
>  	[hwmon_humidity_fault] = "humidity%d_fault",
>  	[hwmon_humidity_rated_min] = "humidity%d_rated_min",
>  	[hwmon_humidity_rated_max] = "humidity%d_rated_max",
> +	[hwmon_humidity_min_alarm] = "humidity%d_min_alarm",
> +	[hwmon_humidity_max_alarm] = "humidity%d_max_alarm",
>  };
>  
>  static const char * const hwmon_fan_attr_templates[] = {
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 8cd6a6b33593..f553f8cd6946 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -293,6 +293,8 @@ enum hwmon_humidity_attributes {
>  	hwmon_humidity_fault,
>  	hwmon_humidity_rated_min,
>  	hwmon_humidity_rated_max,
> +	hwmon_humidity_min_alarm,
> +	hwmon_humidity_max_alarm,
>  };
>  
>  #define HWMON_H_ENABLE			BIT(hwmon_humidity_enable)
> @@ -306,6 +308,8 @@ enum hwmon_humidity_attributes {
>  #define HWMON_H_FAULT			BIT(hwmon_humidity_fault)
>  #define HWMON_H_RATED_MIN		BIT(hwmon_humidity_rated_min)
>  #define HWMON_H_RATED_MAX		BIT(hwmon_humidity_rated_max)
> +#define HWMON_H_MIN_ALARM		BIT(hwmon_humidity_min_alarm)
> +#define HWMON_H_MAX_ALARM		BIT(hwmon_humidity_max_alarm)
>  
>  enum hwmon_fan_attributes {
>  	hwmon_fan_enable,

