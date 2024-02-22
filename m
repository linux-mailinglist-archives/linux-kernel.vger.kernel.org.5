Return-Path: <linux-kernel+bounces-76722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B285FB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856332856F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1814A087;
	Thu, 22 Feb 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXvIVA2V"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AB1474C2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613306; cv=none; b=RUhb4l3BYS8dCZFvzTW47PyCvyWMuD3neq6dbe+EXdPhyl8jZF1KLcoRSkJzlzLvgXYIECAPF8aKPCFYnRSHFKbFEkZor7f1n4LEjqOUv2YwrLmsgeUpyvomLJ69urxEQU1NBNPZ6EPnBFd3xI319jQxS2Kco11O7ktnBR/+sak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613306; c=relaxed/simple;
	bh=oTNiQOVa9UPc+CcXKg/4uP4XhIhH0XZw8JWypLjnUrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk9RHkF7e+/9fE2zF4c/jBasPgSG4DQw709O/ZOOXqDlPNq+l+/1hNParZFF/bpfpRchcMLw8tc50g2KhR8pu8rvEOlkSXVSODSnX8SQ6w7Hf4M+4j7Rxsx7lLZ/LsfyAYVtYsuxfjYJ61R7g8Zzg3aKRmb7vHu28QC5Lk8GC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXvIVA2V; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5101cd91017so10363660e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708613301; x=1709218101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=peIj76sTqyfZMIrz7VgORO7dcy5u5KgAsi9Knmv8iBM=;
        b=QXvIVA2Vmwewwfw9hfU6jg46jk+xCtAE6LgAIdZWdCQRkxBquR1ZoRpdNC2x6Vfs8x
         lOC9dsb90JgiELVmwcyP0jEcvI1wFRaHLVTMc5w89JWh6ufQu1gaXtPYP95wVQqqfJoh
         vcXnvc/BXlfpLO1c1SVOheXDRgS2ThIuPuXNAd/ogBWQZqEAp0ID/WnET1aJ/eUwhL8b
         I9MVrT/nn2dj2G7CUDwOnIeNjFa//hIy9gLuo58VJnpyzfRYCGB988sS3hf1CupHiCXO
         Cp+aaqymR+eZ+DcOBa1y8sjlGaHFtIGuGORJCz4jRaKr0j/q24DFHOGF/odka+uAjNrM
         2v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708613301; x=1709218101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peIj76sTqyfZMIrz7VgORO7dcy5u5KgAsi9Knmv8iBM=;
        b=fVNOEDwCZtXRjPWSftqkqTjD41n/7mHwxIvpA23l7V1AP7s0HJBekT4Kw52F12GS+/
         BwHvpFyNf4jCdr3mordG8Hb6S3D3RTDqkHph4h5sapy7AsyhZu29U0D7oKKSOGZZHsN5
         d5RZmjagQx6WYQfrnlaA7sRi2rH7OqKepZ5M7rvzoYs+aIXExmAuhiW3H7+XNzSoo0Of
         s60NDwfkn/WU8gqFcJ2ooqIwqwp2VAT1n6pf7NLK+5V+Z9UOZHIZ4IoKCTEcbIzggJqX
         gXwr9zazCr+83rl0CfS2NxFWHAgQFb4TfCmZ8jZp9oJGoNjeOVWBXqkz50K8o8kvG43s
         Wnww==
X-Forwarded-Encrypted: i=1; AJvYcCXBaF9e3C/Fnd7qB6NZwMcPpeXiTiYLyp5GasztzICbCDNWXH9e3qXe3g55wS9sxYc3PAVsZTjNTE850zKeXmH0Ow37ag9CSqhbfkrE
X-Gm-Message-State: AOJu0YwTJwVXy09JXQrGxTks6Firn8NzsYKKha4kJT4ecB9gJxF7ZkPD
	TRM9jWAQ5l+MyO9y4rn+Xpf2o4jmDgI83yVXi1Mjnd6XxmjYDJSuoHTgvA0Okjs=
X-Google-Smtp-Source: AGHT+IHjV4zsu+gepvm6hVV3ZEWYhg3xi0pO8rAfzf0Mj/Hk8VjjKzGsYl5EVyFm+i8ZMKbveXDTJQ==
X-Received: by 2002:a05:6512:3b0b:b0:512:e240:c5af with SMTP id f11-20020a0565123b0b00b00512e240c5afmr463099lfv.1.1708613301172;
        Thu, 22 Feb 2024 06:48:21 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f19-20020a05600c155300b00411ff030f06sm22717689wmg.9.2024.02.22.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 06:48:20 -0800 (PST)
Message-ID: <e9947180-a10e-4359-b015-096506c1e39f@linaro.org>
Date: Thu, 22 Feb 2024 15:48:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] thermal: core: Drop the .set_trip_hyst() thermal
 zone operation
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <2923201.e9J7NaK4W3@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2923201.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> None of the users of the thermal core provides a .set_trip_hyst()
> thermal zone operation, so drop that callback from struct
> thermal_zone_device_ops and update trip_point_hyst_store()
> accordingly.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


