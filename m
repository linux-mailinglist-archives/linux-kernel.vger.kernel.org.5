Return-Path: <linux-kernel+bounces-161245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1146E8B4975
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2499CB21819
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B6A3C38;
	Sun, 28 Apr 2024 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM5EvGzS"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9623A0;
	Sun, 28 Apr 2024 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714275793; cv=none; b=HzYiSKsmtp1ZEATBKbsZFTOK4xQ0vrF/E+F7AAPB2/STaf+54J2cI5iYwME64jzJoENvK8jZSWVcAfBcBzNGkp8+tw/HMA11XSHCgvsrFVWyYASp838giOIP4xm5UjipHpj+WZ4YdATy2SwttjmliGBcTl1b1hfxodMBIBi9jvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714275793; c=relaxed/simple;
	bh=QTm0oGZ4jKozHwlGDj3XCzZ34Hs+9vRs4XWHvTGRbyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VE5Xfmeo8p0FaVG0fO2eMe/8V0GaLk+R/LHXDZav9WOkTlXR0axwWkSTEgfqzLjsYtATehYf+yJqATnfLRKmNDSXq+id//3X3KiHCqBg/FFjLEDZChSQ79Ch26Pc27Gic68lhNniz+LnlrbseRB6y269oVmKgMdv0I1Dfx2sQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DM5EvGzS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ae229e9176so2839205a91.0;
        Sat, 27 Apr 2024 20:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714275791; x=1714880591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cF3gFSsAF8/xhEBnIsSjdFtkiMowyOcPJ+4xKxqvds8=;
        b=DM5EvGzSfKhgkwoPnH72SohnZPlAt3Ig0zt6eeSlDoSDz3wZwr2P27nDRtlcABkgje
         h962s3XN+CMeGMaTgEgX2BnQWJ4Z7ME4nm180CuWxYXX/ckJDK5GdobLgHa2A1a05wQF
         SKOmo0uq9nOelgTBGsOFHqVNJxmxd1WJGWgVwZr7PZ9m4KM2+oz+f6zZ7ah+/5ssMwWw
         SxF163Q9jjsVAv9qpDNTlty6cPapA9ZJgr5t+Rp8dqDYONmGiauwYL7s4g2X/RtqAcaF
         rRkHc0BW5F/Odlkss0tAaSSe1fQ1kMrd+YRVVKYnQSHNd3pBa868kpDOuTB6Mo+Njptt
         CP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714275791; x=1714880591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cF3gFSsAF8/xhEBnIsSjdFtkiMowyOcPJ+4xKxqvds8=;
        b=QUWTR3wRymSqCCrZmPgAihxs/jU9QqEEpZv5Z8teZvhVVG38MEXIBZyhEUIudbwxjV
         ZMxzeJ778ikYA7lTVYQpdBIiW0uPoVk019DJbW/uufGHqc770+LEuw+k3lYg1JcdaajK
         YRKgFCik/cns+lOfWooUlwG7CxZwRDtaoAsKh1ZLca7EE9Xsw/vFvsbLOOc0zYO+TGXy
         syHF9eJVDK0JsLA0wmfB6Hhbnbwx50LP5aAll4U2q0Mvk6fFgm7anLV7MkoDxcVrD76Y
         vkD9konMcmXn3boIPteI27tYRZF+tIECbTw+YarEcrUHhkMdWKIw/qtX6X9MMuhfiyHY
         LSXg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Qpk0Bfuq7G+E5VtmSzHCARBftrSy7Xl+FPmuxsxtsZjmtYjnjbV/VHNqIaNVs0moX6vYK5hXCkc5MrUKFSup3zJMWWdw8xMYOjEUFKVwZOGm2PajHuctpjb2V/kkQmh1hzfAncmnAfMoxjuzyJhInX9fK8lPSVCgnUugUyiW6NjSnn5/MCI=
X-Gm-Message-State: AOJu0YxDqhvGEc7/NjEwYNqKj9RKH++O27YU2rZ+vQZeB7dqQhY1qToq
	BhDGjbXUJ90Pb6qlDGjSHD/IQD+R3+CPBXSRQP/tx5y/8bZUD7xE
X-Google-Smtp-Source: AGHT+IH8mJdZTclWb62UvmTjNjCFpNOr+GkX5xNCJ3l7df3vwRT//5dtC2idHbg5/5JmAE8+hAlxkQ==
X-Received: by 2002:a17:90a:e641:b0:2ab:257c:4747 with SMTP id ep1-20020a17090ae64100b002ab257c4747mr6214969pjb.6.1714275790697;
        Sat, 27 Apr 2024 20:43:10 -0700 (PDT)
Received: from [0.0.0.0] (42-3-109-144.ptr.netvigator.com. [42.3.109.144])
        by smtp.gmail.com with ESMTPSA id gb23-20020a17090b061700b002b15a672805sm354415pjb.23.2024.04.27.20.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 20:43:10 -0700 (PDT)
Message-ID: <c69021e6-2397-4cae-a640-9a3b6ce2e404@gmail.com>
Date: Sun, 28 Apr 2024 11:43:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] arm64: dts: qcom: sm8550: Update EAS properties
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-7-e0aa05c991fd@gmail.com>
 <99f51564-df99-4f06-9419-1eaa9501f27d@nexus-software.ie>
Content-Language: en-US
From: Xilin Wu <wuxilin123@gmail.com>
In-Reply-To: <99f51564-df99-4f06-9419-1eaa9501f27d@nexus-software.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/25 6:45, Bryan O'Donoghue wrote:
> On 24/04/2024 16:29, Xilin Wu via B4 Relay wrote:
>> From: Xilin Wu <wuxilin123@gmail.com>
>>
>> The original values provided by Qualcomm appear to be quite
>> inaccurate. Specifically, some heavy gaming tasks could be
>> improperly assigned to the A510 cores by the scheduler, resulting
>> in a CPU bottleneck. This update to the EAS properties aims to
>> enhance the user experience across various scenarios.
>>
>> The power numbers were obtained using a Type-C power meter, which
>> was directly connected to the battery connector on the AYN Odin 2
>> motherboard, acting as a fake battery.
>>
>> It should be noted that the A715 cores seem less efficient than the
>> A710 cores. Therefore, an average value has been assigned to them,
>> considering that the A715 and A710 cores share a single cpufreq
>> domain.
>>
>> Cortex-A510 cores:
>> 441 kHz, 564 mV, 43 mW, 350 Cx
>> 556 kHz, 580 mV, 59 mW, 346 Cx
>> 672 kHz, 592 mV, 71 mW, 312 Cx
>> 787 kHz, 604 mV, 83 mW, 290 Cx
>> 902 kHz, 608 mV, 96 mW, 288 Cx
>> 1017 kHz, 624 mV, 107 mW, 264 Cx
>> 1113 kHz, 636 mV, 117 mW, 252 Cx
>> 1228 kHz, 652 mV, 130 mW, 240 Cx
>> 1344 kHz, 668 mV, 146 mW, 235 Cx
>> 1459 kHz, 688 mV, 155 mW, 214 Cx
>> 1555 kHz, 704 mV, 166 mW, 205 Cx
>> 1670 kHz, 724 mV, 178 mW, 192 Cx
>> 1785 kHz, 744 mV, 197 mW, 189 Cx
>> 1900 kHz, 764 mV, 221 mW, 190 Cx
>> 2016 kHz, 784 mV, 243 mW, 188 Cx
>> Your dynamic-power-coefficient for cpu 1: 251
> 
> This looks pretty convincing and like good work.
> 
> A few questions and suggestions for your commit log.
> 
> I'd really love to know more about how you ran this test. What values 
> exactly does your power meter give you?
> 
> How did you lock the core to a specific CPU frequency ?
> 
> Maybe also give the equation to calculate Pdyn in the commit log.
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1500974575-2244-1-git-send-email-wxt@rock-chips.com/#20763985
> 
> ---
> bod

The power meter accepts a fixed 4 volts input, and outputs to the 
battery connector on the board. It is also connected to a computer for 
data recording, including voltage and current.

The CPU frequency pinning and Pdyn calculation is done by a script on 
the list: [1]. I just removed the power measuring part since it was done 
on the computer with the meter.

I will improve the commit log in v2.

[1] 
https://lore.kernel.org/all/CAD=FV=U1FP0e3_AVHpauUUZtD-5X3XCwh5aT9fH_8S_FFML2Uw@mail.gmail.com/

-- 
Thanks,
Xilin Wu


