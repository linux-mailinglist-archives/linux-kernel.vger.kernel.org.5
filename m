Return-Path: <linux-kernel+bounces-76342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF085F5DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B581C21062
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FB73FB14;
	Thu, 22 Feb 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nubu1fyR"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1D3EA7B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598104; cv=none; b=gPXAr278HZGlyUjGVg9Wn3vTH5Ie0/RGo3RQjLOgFYXm4UEpa4BStMerNRgMWWZoFJ1+8DMCGmrnj/oq7yQjnSbiaEBAGRRYu3L9Ez0HuKCgiqmi47FYbSf0EFj4Y17WTC0DUHI/UYmFxE0ygG3ErZO/JcMn+cRVG6tG6Du+WEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598104; c=relaxed/simple;
	bh=DUuD5h3whIgZurEejVIOfjuaYKqtr3eaOdEzgCLsmvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=To7D174enjBMEBkUzQD7hjbbTCR1xOgGBe4Q0mhZ0R4jp61r5Kbrp/H2vTwfKB0lO6WPnBAa0aU/BWupsgr7SkiVnpxz/LVgdnMOfcAhMQhnQ1nim/Egaof21BNqmJtlLz3OgokWDegBmwQrCd4lyeMNseAKo5AU2oVrat3ne+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nubu1fyR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41279203064so9491505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708598101; x=1709202901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=099bI5whegJNM3kSvHcOsymL7sW/VeG2lWeP0GznoQ8=;
        b=Nubu1fyRYOH6t1kPysYfEatDHrpl5VY0BVpl0kIxTt+qCR4zio9I5rE9UrXxu2ontI
         tK66eSnqk0TUKK0+zUPnHbG8/DkRlUpI/DnCRhuw5KSD/oswGITmVMkIKMP9F3AzNxzP
         9UrgrbGqwLkRLyTnTEUuC9NFwkQfaJfN96AAHpQnVQUQ67qFupTGLhBDNx8hLhLwbUX/
         cndoRs6jdqzxiY+BVn9q5dhuuj2rrLtkkAI3L6U9AkfyiUaKwDVnhwZTTdxSEBMUxL29
         d3oNMYEbcD5X4vdjD4rmoipYL0uM9XzzbNh/yDmYfHBurugfCJac3wmjGIY5yo/4x1Uu
         PWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598101; x=1709202901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=099bI5whegJNM3kSvHcOsymL7sW/VeG2lWeP0GznoQ8=;
        b=KyETIOW+INnGPLLmnA8v5HddgcXvZgRXJi9Z2x0xiiFD8l9ZyxKgWN7kjBLeM7QPuc
         D9RoR7cnwuv3xHjTJC0S1Xj+U5lEGkEf+YEg7fZUzjZhEfXjlYoet7/niTBn81WjOL0W
         WIxJ4+yMklMukL4S1UK/zpk5Znj4FG+maMnlMRFffYVF9dKQqMPO7PTdqjEJ8aIlfaTO
         E6ctQLn7lyedjipT1eYpRDzUDKfctQb2CV+5b5hE1f5M5YaCfqw6vEr70RmhJ2YrYB8X
         0KM4Z6mEW8Hzy4hFT9DN6dn4FCjYlNZMWjaM2Or8nuKsP7M8F0Dd3xHgsXD9QCoEnrFi
         wH7A==
X-Gm-Message-State: AOJu0Yxe3i+cFI9rJqYrin0Ptrr7PKxYq0xt/inpuy4kuozx6aYJD1m4
	0vlz9MZvO+n49RGyhcXkADXGzgvxt7mFczpgoFKiL6Di0Dza/3qu5T60YiFylFo=
X-Google-Smtp-Source: AGHT+IFy8GOQQB6SlMWw6li/ppqbiYFPN6dz8gJI4RgkqeNAmBoIQEonmSoWKBV4qkxMOL7S4P+J7A==
X-Received: by 2002:a05:600c:5390:b0:411:c789:5730 with SMTP id hg16-20020a05600c539000b00411c7895730mr15352026wmb.35.1708598100671;
        Thu, 22 Feb 2024 02:35:00 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f9-20020a05600c44c900b00411e3cc0e0asm20587921wmo.44.2024.02.22.02.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:35:00 -0800 (PST)
Message-ID: <3669e59f-a8d5-4f29-a0d7-3b40938d84c2@linaro.org>
Date: Thu, 22 Feb 2024 11:34:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] thermal: intel: Discard trip tables after zone
 registration
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
References: <4551531.LvFx2qVVIh@kreacher> <3287354.44csPzL39Z@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3287354.44csPzL39Z@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because the thermal core creates and uses its own copy of the trips
> table passed to thermal_zone_device_register_with_trips(), it is not
> necessary to hold on to a local copy of it any more after the given
> thermal zone has been registered.
> 
> Accordingly, modify Intel thermal drivers to discard the trips tables
> passed to thermal_zone_device_register_with_trips() after thermal zone
> registration, for example by storing them in local variables which are
> automatically discarded when the zone registration is complete.
> 
> Also make some additional code simplifications unlocked by the above
> changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


