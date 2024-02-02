Return-Path: <linux-kernel+bounces-49846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99858847063
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1585DB29800
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF13A210FE;
	Fri,  2 Feb 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBFRj/te"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714F3D72
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877068; cv=none; b=GBnwYbx8p8DyrRmBC+P7Z6X0ZzMyg35tWEpmU9pKOHoGtmoyuyRTN1kGFebybBRViA/FOVQDNvs7l5RYlR67bK+3/HGRl2IjlBtwJOgE+NbqQBNDt4b1gn9SyGUlTNbt+okDn5OjWfKyrhwbEkQOudMWToB0TtGAKcJe/hH9J+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877068; c=relaxed/simple;
	bh=LpszH7bN80s4d8SEsQ1YuXs3jTA07zr8GrbTSAzq/f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmUHU/dUfOqg2uNmKYsy8+S1LmGlPs1ZgsIJpuv0rJWhvAXPq+3V8rY9GvNQYQtOYr5etIVu8x2zgQFgvinGF4Y2WkK2QZwfODWUaFrB2ZCU3OJy6eLrg9Esq+Y+jhEszURYvIcogQQpYWfK7OdEu88WnJHcEjbv02ShL3Cu/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HBFRj/te; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a363961b96aso270018066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706877064; x=1707481864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zay0yPt7mzIwbFHxCrA+J0m0UNJP6Hth5Q4vBN+kW4Y=;
        b=HBFRj/tez72fsdxy2H1LqkMtAXNnxXXdHLBlhJMNOUgbIlOUXPK0qiA0cN4AZn2+tw
         YZVdRkkfGLgjsU6A4cG81Q3zXQzJl+gXG0XNu3ufWkVzmRihyqloCk6tchvdWdT62qBu
         +Ts3/h2VO7m+E7K25tgMCjkmB2qNIK+qu1hryGfl2LPpn25BOmUagvW5stFR4hmoGLw6
         HinWWQOyuDmqTGE6Mfg5txkAFHmZ/s2MrUQBXRD3Lsomxrhvu0nLlV2ZuFtisN+M+bXn
         /Bdnyv8DaHFq5wjafPIHYTEefl3FizSSyxZwdj5ff3XoSyfWYVKg8m/APoVRhesKKDnF
         qrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877064; x=1707481864;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zay0yPt7mzIwbFHxCrA+J0m0UNJP6Hth5Q4vBN+kW4Y=;
        b=R81zuzwWstYknj7ITTloePMTWq1dHwQATaxl3d+FwQ/uak8vD2ngUYSDfTS2ZTPbAI
         yKBYJ/QBT3fpM7XopLdmyMvXZZobxDaP92dsSuEc2l+32NeniTTrwhA14WHVOfB3/9zZ
         SCBSq3peNOINrznEfEf1+HZM1a9Oli/5vYy9uhkRG5miAIbvBXrOmAC95jQtq9rVrEeD
         2LJ1HjghWttLcEeASVfr4KoRVVhOElX0/dPr+bfmHYwoa/yRk6b3RMrxSSdaaMh7uY8W
         ICvmDU/MhWmt4cvYa/QB2o+HRN8GnsZrixihz1uLBu6g30EDRxJhIBStjYD6xJhd9lR8
         asBA==
X-Gm-Message-State: AOJu0Yy5jA6mp9ZVwR1laQVitWusHZzIsyHOLDP394vZUruApVdcd9eq
	Vc7hjYzZj8GdCaL3ODKTrpHHdqmk8L8waZVHETk/OIC+f1tUWmgQUhNL1wlQhyWDXPVZguHFVDR
	E
X-Google-Smtp-Source: AGHT+IGm88eI2qVje8loOU/Pba+0CUUPevNrPoacbfZR46c2qHR5WP3q+owQFrAAJ8bunMkDzHk2GQ==
X-Received: by 2002:a17:906:4ca:b0:a37:2932:df4 with SMTP id g10-20020a17090604ca00b00a3729320df4mr195465eja.15.1706877064127;
        Fri, 02 Feb 2024 04:31:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUshf9fRHSIWw9BSovZa+W594/TCcQIw45cLWNVtgXgAm2u2VrMiP+yRRFGBBjrDyb8ZWG7NVck6t+1Ji4mWEQYShlneFt6AySo19EKGe9Mt/Co6gq9KQxxr5J798jbkvfb8DEE9LVnSsxL4IGjDTAyC3mKcRQCrdxPDY4goXRd1Zs9hgN18ixp
Received: from [192.168.159.104] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id kt17-20020a1709079d1100b00a36f42fa79esm848945ejc.16.2024.02.02.04.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 04:31:03 -0800 (PST)
Message-ID: <17cae1aa-98a8-48f4-adf3-2ddfc451bef6@linaro.org>
Date: Fri, 2 Feb 2024 13:31:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Workqueue regression
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com,
 Bjorn Andersson <andersson@kernel.org>
References: <b3d08cd8-d77f-45dd-a2c3-4a4db5a98dfa@kernel.org>
 <ZbxK01xuA_FFWaE6@slm.duckdns.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZbxK01xuA_FFWaE6@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2.02.2024 02:52, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 01, 2024 at 09:57:59PM +0100, Konrad Dybcio wrote:
>> So, commit "Implement system-wide nr_active enforcement for unbound workqueues"
>> broke *something* and now performing a suspend-wakeup cycle on a Qualcomm
>> SC8280XP-based (arm64) platform hangs when performing the resume tasks,
>> presumably somewhere near PCIe reinitialization (but that may be a red herring).
>>
>> Reverting the commit (and the ones on top of it due to conflicts) fixes
>> the issue on next-20240130 and later (plus some out-of-tree patches that
>> are largely unrelated).
>>
>> Not sure where to start looking.
> 
> Hmm... sorry about that. Can you please boot with `console_no_suspend` and
> retry? Once the system gets stuck, you can wait for several minutes till the
> workqueue watchdog triggers and dumps the state or, if you can, trigger
> `sysrq-t` which has workqueue state dump at the end.
> 
> If the system doesn't become live enough after suspend/resume cycle to get
> more info, the following might help:

Looks like it's too far gone indeed..

> 
> $ echo test_resume > /sys/power/disk
> $ echo disk > /sys/power/state

Sadly, hibernation is not a thing on this platform.. Without going into much
detail of how messy the power management stuff is, you can either have
"on", "off" or "power collapsed" (bound to s2idle).. Trying to trigger this
sequence makes the thing lock up and die due to unclocked accesses with or
without the WQ regression.

Konrad

