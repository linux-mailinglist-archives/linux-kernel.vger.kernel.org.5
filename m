Return-Path: <linux-kernel+bounces-76610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419F85F9FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74294B273AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E2D134CDC;
	Thu, 22 Feb 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wmnz7T4V"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B21131E5C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609111; cv=none; b=CrAsE4WZ9rGKWoBeP0C70fAQS9ky1zWwJ87RbHQmEdrIZ26iiaE56479KhEvMQbE8alJYc3P1QK5NqizK6tYPQEwKvrElI/qe2lyewn7GtYDs5f57SHNM/obs27Y9pNTQNWqyaZWyUtPcxv69P7xpupd71e0226/BhumJcFUveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609111; c=relaxed/simple;
	bh=dnP6Na2KFoHfi/00jkUuH2sx/m/bitJm1og9b7z1FOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYtK4hs0iFI2fd043GEZPPhhXObX+m4w7nT7LIJiVOuFCe+cOZCwIzku6Qo8fWq0B9rUE4UIMbEiK2jzh9JFWymS0b/5+IuIOJxzK0KY2owNxij7MVVJ1CzU22Z5H61N/mUk2WjyB89oLoG03QeBf0C5BoEE9g7jz7uT4tWXcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wmnz7T4V; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4128e15d5e5so1356995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708609108; x=1709213908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0eeSj0Rbo8Tyxk9+gjLQ2yol07l3Rs5IcpVi8aXUFs=;
        b=Wmnz7T4VTWdXNdsRdQiQsuAII/BAIrrgq0uXxoTvioFxQ1mCZ0fDhOdD+0gHBPArHe
         tncRF9DTSzxJiVgzWoLXyiZyDIOmyPp8EUXmeFF7dAiMdlkAziEc7dXeZGqbe6nStSPY
         vJqT2bI5l/FmAld0YUUEzyUo2p/30a/Yly0hY3ukr2J1IXoL2vywHEEgS4A4yVLg381d
         IvWbhiKNI/7MNElA3eEn9P5EZ7HbXoU8ouVO9jUydurw9tukPnhxZYndciUS8GYlNiwI
         PYmOlQpp/ADsZJcTeLs1NFzmD0xlPMa44nsfmhJutmmhW1u6T0PoBKacHvM8y4gRxhUD
         pGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609108; x=1709213908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0eeSj0Rbo8Tyxk9+gjLQ2yol07l3Rs5IcpVi8aXUFs=;
        b=nT1spF0a4B/ZUXTVJqVgjnMsOyv4vYs4zfpM+C26obNXN4WDl1eVGu38rfwJx0K4Kk
         OPeaL6uiJdunrVRnG7ltlZB2CkCBWX+ZpRArfoYi5rTIEhBq0NjqVor5bz60eB4alJHO
         uE+hCbDUhhBULfqRnwHMRKMJ9QkebGBtO6NF+fspTll9hU3NEVNsaJnGN2w/hYQONMWL
         UQR13aJBSIjEcIZUgitqi5zlXbLw/UJX3A3M2o8EOvooZC0C+P4njBVlbSJ9sjoJXxyZ
         dUObuTNbebDpgaUI/VxJ6XhS6PusjwgGoJ5TgeHJ2H3rfnjRjhxGCVHLOsDnqrNwd044
         J+8A==
X-Gm-Message-State: AOJu0YxfjqdYRUKU6HV/+qjN2LU1Q8CdnmLSuixIckg0mY5HuTo/t3gh
	aubrYrNKNZ2+5Yp3LC+5YDN147H5RXu6doYJosVYtevmpH5jdweEiPxn+KK4WYk=
X-Google-Smtp-Source: AGHT+IG891wIGj3n6n+q1STkih4LzXtpjLUJ07Dpm8f6+K69gfvd5F6o5ICUx3SMCN+wGTidEMMoCg==
X-Received: by 2002:a05:600c:a03:b0:410:deab:96bf with SMTP id z3-20020a05600c0a0300b00410deab96bfmr15301794wmp.22.1708609107670;
        Thu, 22 Feb 2024 05:38:27 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 11-20020a05600c228b00b0041288122af0sm95586wmf.0.2024.02.22.05.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 05:38:27 -0800 (PST)
Message-ID: <0de4fb24-8e33-4c2b-b6a6-d9e8a7b358bd@linaro.org>
Date: Thu, 22 Feb 2024 14:38:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2.1 1/6] thermal: core: Store zone trips table in struct
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
References: <4551531.LvFx2qVVIh@kreacher> <1883976.tdWV9SEqCh@kreacher>
 <12405371.O9o76ZdvQC@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12405371.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 14:10, Rafael J. Wysocki wrote:

[ ... ]

> Index: linux-pm/drivers/thermal/thermal_of.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_of.c
> +++ linux-pm/drivers/thermal/thermal_of.c
> @@ -440,12 +440,10 @@ static int thermal_of_unbind(struct ther
>    */
>   static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
>   {
> -	struct thermal_trip *trips = tz->trips;
>   	struct thermal_zone_device_ops *ops = tz->ops;
>   
>   	thermal_zone_device_disable(tz);
>   	thermal_zone_device_unregister(tz);
> -	kfree(trips);

thermal_of_zone_register() must free the allocated trip points after 
registering the thermal zone.

>   	kfree(ops);
>   }


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


