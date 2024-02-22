Return-Path: <linux-kernel+bounces-76354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AC785F605
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11291F23C22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A43FE27;
	Thu, 22 Feb 2024 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tplJAyO8"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D33FB3C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598858; cv=none; b=Svp2LXLwIazM/VSh+v745PkGcntOGRbZMrqpLMwFIvNLRmA9wc42C9xL/d+Epp3jbq2GdUKjP5RKu18dW1UrY/BPOvrrq3PblXv4D5ikrT1PS9oS2tJpsN4L/NZ1+AFzgYjrMb+x3w8lnI3qE6Z9+wYaeqzzmlB+nimmvmxFDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598858; c=relaxed/simple;
	bh=3zP/VtA1AgtaTaQw2U6AxyLni4JwLiOiv99igy1cVDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JabsGLaHjRNLx3HMA3pgHGQNfOX9gMqaCOLPrGe9NrUcHQri0q7A7nRTK3gK1IN17rCPOm8l8wRIAJmNsesMxx7+PvWf115y8LpQnV1d8YoEpHM8Odlwsx87UL6NWf7d5/mwdTjTYdcXJnphOfqPaQR7qx6FI8Isj/dgjwVm+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tplJAyO8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d9d43a1eeso23124f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708598855; x=1709203655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aqpcdx+kqPsDksMwy3/1ZpsNRD3e+cH+lqKOGDH4SU=;
        b=tplJAyO8ImuOx31ipVmS25WlR0yZtap78n7NHrgNzYv5S3HdVHA72P3W2jhEvVUUmz
         e62zXAIXW9p5yY5kG60AEnjenkHxaTX9fao7uHfOzd9uPaqrWIQaiVuHfK9TBtied5Ju
         +uSUyCiTpqKFsPwLu0GtqXzPYBmrIVFrCnDUUwRBG/vg+7BG4BVs3FDVhnrACM/hyES4
         E7AJxiZg9ZsAEHAL3jeskg+eYqIDOGGAy6Wlwz3FdEiAtahWNy9ueiFpUIvYL0hdJO1W
         B3UpIUv0X1q5SXXe7a4K/cWP44JvQX60MZQpSJ2lDhY3MCVHub60iVPCSOKR2uaRT5k4
         Psag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598855; x=1709203655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aqpcdx+kqPsDksMwy3/1ZpsNRD3e+cH+lqKOGDH4SU=;
        b=ejz6ma1XJ/ZcF+p/bMdcMwjB5U+t+SNYj8mofEn2EsgPgFcv4FWzP3ksdolreSRkS/
         mQgTQaoo6+hdt9d36gEB4jLoVZxPkf7YW101nJ8SOiFuVdaWpLiJyHo1ZjwssHut5edq
         hMTSSyHvzwKh39K1G8Bq5xxVmZ7eFrvIs11Dl9RLgu0Q62VnhUbpIJ3p4m8xHHN0c1DD
         iZvRTaXDXSuWnZ4saPt4kJyXn2wKn7KVbBMTO1z2dOWQ7hdBSg3MoB2o7O7hKH2GuU72
         dkca8/U6YX7RyB3kQa0yb9/sFyvH/77RdU5b7TlCv6gxNby1b92uTsUjsDQHfFNmPC/D
         BpgA==
X-Gm-Message-State: AOJu0YydzBh7XT0wWjmnJEtV0MS7BhhoG3V2yKu3f7PhPt7hs674NcSC
	EIR8aQ5Joh186DJTN/wFRxsDICABV3GjsjzKWXqZRK8TbbKUiQD/qm3DOKJVGGY=
X-Google-Smtp-Source: AGHT+IGs1kam3tuErV0BZMvW5Bv5dj9iYPqaMk+UBtUuUvBtTpsPOm3+SsvB5+lg6Z2no0OLjEXKYA==
X-Received: by 2002:adf:ec4a:0:b0:33d:82c2:ad8d with SMTP id w10-20020adfec4a000000b0033d82c2ad8dmr2582908wrn.56.1708598855237;
        Thu, 22 Feb 2024 02:47:35 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bo29-20020a056000069d00b0033d5f5571b4sm11278754wrb.44.2024.02.22.02.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:47:34 -0800 (PST)
Message-ID: <ffa37950-d850-44e2-a33e-837466238d6d@linaro.org>
Date: Thu, 22 Feb 2024 11:47:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] thermal: core: Store zone ops in struct
 thermal_zone_device
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <2262393.iZASKD2KPV@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2262393.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code requires thermal zone creators to pass pointers to
> writable ops structures to thermal_zone_device_register_with_trips()
> which needs to modify the target struct thermal_zone_device_ops object
> if the "critical" operation in it is NULL.
> 
> Moreover, the callers of thermal_zone_device_register_with_trips() are
> required to hold on to the struct thermal_zone_device_ops object passed
> to it until the given thermal zone is unregistered.
> 
> Both of these requirements are quite inconvenient, so modify struct
> thermal_zone_device to contain struct thermal_zone_device_ops as field and
> make thermal_zone_device_register_with_trips() copy the contents of the
> struct thermal_zone_device_ops passed to it via a pointer (which can be
> const now) to that field.
> 
> Also adjust the code using thermal zone ops accordingly and modify
> thermal_of_zone_register() to use a local ops variable during
> thermal zone registration so ops do not need to be freed in
> thermal_of_zone_unregister() any more.

[ ... ]

>   static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
>   {
>   	struct thermal_trip *trips = tz->trips;
> -	struct thermal_zone_device_ops *ops = tz->ops;
>   
>   	thermal_zone_device_disable(tz);
>   	thermal_zone_device_unregister(tz);
>   	kfree(trips);

Not related to the current patch but with patch 1/6. Freeing the trip 
points here will lead to a double free given it is already freed from 
thermal_zone_device_unregister() after the changes introduces in patch 
1, right ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


