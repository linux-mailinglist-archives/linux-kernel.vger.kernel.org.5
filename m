Return-Path: <linux-kernel+bounces-76632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518185FA42
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3942285215
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DBA13665A;
	Thu, 22 Feb 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Crwxl1B0"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E347134CFC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609815; cv=none; b=ifU0ej9DTmL7Ju0JOzsdppEAxN7kwhDpKIlr/tWUHI3vLpLS73ra1yk6yuRY1AgfGh8fCQhixf0urHvGCrMac/QIRd74fRMYaSfhVi1APDKBwtm0KZP8fUB8hY7wyBZDwRxhf2tWVwOVmbdXGRsbfbJngBwVN4EaLhtN82gFJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609815; c=relaxed/simple;
	bh=sxjrviJKUO4ego+bavj+MGIR978E5EVGQ1XQmUcD98o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4/WK2q5FQI309rYdEDAwKXPKfMnQkPzRb8NtKcbt1yykGobxV5Pu5KYdOkAfHkVvHQbD6chTpdqmLf8mr+9x0cPgVBttmTTwrZxydTKDRx/CQ6YFPJ1ds0tbHg4BHqKBPNcvnQEQjNI6KryC9cMPovgck7tf1DhOkNJJqrh6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Crwxl1B0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512b4388dafso5423294e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708609812; x=1709214612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJephV2azj0AUd3p7RK/qiB+wFc6v/rmXTqmszZdGYI=;
        b=Crwxl1B0FjzMUgXzRAjhwhKxjXDFfw3cobauF6YUniUd/URytp6IHP1Sw1shFQENJY
         JvKlW6TCh6riS9OCk79869+f/zv6LF4/dBdtLhdQnMx6c+sT6Hz2fi5n+CLuAo5k3ypd
         tkMlRz5VwsMn8ho+xMbIhOlg0TS5LnwI/it2l6l5kAJwpNwITibGgZwkTQqtDYWQj1sR
         v8lRBtdRKj6OV26AgIDO1TFdzb5PWjhYPv38wC4o3EsRV3uYEGUO3zGPwpXhkY476LHS
         LWWZUrtbjxnULkm39+/fgX5Lq/g7OjIPXoZGjOIMV8G8b1UYnv1fDiGhyxYC6yvMGJY7
         X28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609812; x=1709214612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJephV2azj0AUd3p7RK/qiB+wFc6v/rmXTqmszZdGYI=;
        b=AIhESegZlbhZpV2Hlq/xRH0tsGWfvudzcqN3R09fDsLkOzRIcQHXCtZ2b0zlZCZirL
         oXWwL768e1GuRcrXjsmdmLRHMrSL/L45Tm9Kj63xWFDdIDvjEIyTYcW8NTIZk0vCuPe2
         3dnuX5buSq6Vk7RRAoNj0LzX2EOd2aEq4W5FIR2cDbIcTE4kLjRCtiGHSBR2B1hZIIIV
         HOo1EfAi/o0/QMCpTVgq+8PTjPrPqTCZswdbEotpbOSEkOVYT4JcvXmvDAxdUFXFsoJf
         ssdBCdnT0tCCiLzN9ewcaMuPe9LRm1GHITV8ZoidA+Q7lRTpf7OgEdk71JgNvyy04pMb
         yXWw==
X-Forwarded-Encrypted: i=1; AJvYcCUI0XWEPrTMVt5Y2DTmw2dAh/d3r3uJxKM7NlOh1FxbsyZTtYohthUbcl/+cvbVAWL/E3+6KHus13EvJhztjL4NJjb+f0+O5n7ja/s8
X-Gm-Message-State: AOJu0YzsbQKk8/e4iayHi23SaPRkYsA94LAGQs7+YF0x1PlCVfhSlYtA
	tt6hW7VRAB0C0fTOo8YXrnE5KSFXqv9jBE9rjgtgnOn1rOei9Ju6S242Hfn0pk4=
X-Google-Smtp-Source: AGHT+IE9BXN2VEhMe3Dj96ylym+FP0b5Vptp4csqYAGSEtnaJOuMGHCx4Xtg1mVnTPnIJMauzl6yEA==
X-Received: by 2002:a05:6512:4cd:b0:512:c802:7a9 with SMTP id w13-20020a05651204cd00b00512c80207a9mr5048333lfq.38.1708609812269;
        Thu, 22 Feb 2024 05:50:12 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r11-20020a05600c35cb00b004120537210esm6505491wmq.46.2024.02.22.05.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 05:50:11 -0800 (PST)
Message-ID: <f0ece748-b60b-49d8-8273-924260af9ee0@linaro.org>
Date: Thu, 22 Feb 2024 14:50:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] thermal: Get rid of CONFIG_THERMAL_WRITABLE_TRIPS
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
References: <6017196.lOV4Wx5bFT@kreacher> <4545870.LvFx2qVVIh@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4545870.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The only difference made by CONFIG_THERMAL_WRITABLE_TRIPS is whether or
> not the writable trips mask passed during thermal zone registration
> will take any effect, but whoever passes a non-zero writable trips mask
> to thermal_zone_device_register_with_trips() can be forgiven thinking
> that it will always work.
> 
> Moreover, some thermal drivers expect user space to set trip temperature
> values, so they select CONFIG_THERMAL_WRITABLE_TRIPS, possibly overriding
> a manual choice to unset it and going against the design purportedly
> allowing system integrators to decide on the writability of trip points
> for the given kernel build.  It is also set in one platform's defconfig.
> 
> Forthermore, CONFIG_THERMAL_WRITABLE_TRIPS only affects trip temperature,
> because trip hysteresis is writable as long as the thermal zone provides
> a callback to update it, regardless of the CONFIG_THERMAL_WRITABLE_TRIPS
> value.
> 
> The above means that the symbol in question is used inconsistently and
> its purpose is at least moot, so remove it and always take the writable
> trip mask passed to thermal_zone_device_register_with_trips() into
> account.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


