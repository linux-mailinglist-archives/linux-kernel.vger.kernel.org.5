Return-Path: <linux-kernel+bounces-157800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C5F8B1667
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39421F2412B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C902616E886;
	Wed, 24 Apr 2024 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="o4UjR2Z/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219816F0C6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998716; cv=none; b=ugAM7PX7ElOjsq0w2KHkZhVdCwCwY4zoM3ubHqe+rT8MUtxdYJTr1ug902I8RSf9ci5FNN9X3f6XWxPo7BhxTgA/4Q0XpBslh3okM/ooLE8stZ2kPu3pOYAHAgQSRc2yUyYMbdidF5dOJIHb5L2My+GmRfpyJRDD0zXcAn9Mq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998716; c=relaxed/simple;
	bh=SXGoP5a7GOT/WhrngqddEad4BYmvCOsgRar0PvnouPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ok+lg2DsbY+2wStrlmvpVpBW93ohlble9rDWQMWPiPvYfmmu8/wxT9OMVAz13z0PrF12DzN8IqclE3op+0By0ZKXjWxz/yGJU+ND9SOb44dq8d1P8qSLJOf/+C0E4RtfJCq+TtgkQaWeat7dGd3FljunL5vEDNPVeqHvPSTdHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=o4UjR2Z/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b3692b508so2197085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1713998712; x=1714603512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjxPm44LNMAJWpuJW83TDZMcoceLZ9YtXan5F0Els34=;
        b=o4UjR2Z/McE0XTYAoiqGRPRSAGG96aVpHFvp3utenO3rwEdogZw2HYrpYQBvrmzBAk
         tfSIRs5u9AJaWcN3xL5dL4aD0V2Gv230w7LPxoz4no9C3iXHR0w4DPOs28dI9HZlJbp9
         wB259XCiUf6RCIRegaRTOrsN9sPPyZTOgVAkoZoIYTjrevb6Rk9gxarTzOZDT8RDxNl4
         XehvfhNg+TNISLIcJsgVHovxQsVdyUlslTLu1PXuf7qbFMxk0/PlpUrkaTzVMFMf9cmu
         sP81lU9cKZZimADG3UIXxXvBorc2cawO7ftSRKIKnixKSbxvlwgjsza1Tj+ja+A9XQQP
         Pa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713998712; x=1714603512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjxPm44LNMAJWpuJW83TDZMcoceLZ9YtXan5F0Els34=;
        b=P2QLk7Z0nbRsAfM6oaey+9TxIIpKnxJdjX8IJr46pywGEcz5BsuJ5r2+DUIFBs7BvV
         k6AxxZPJfCAFXKsREIWtafwJtPq6ZbP7DMT3U9Ff/wLj1aA8+NbbLgGO4ETQOS0g+eUg
         vzP8cKuIhm2mztov4G/PzDyRQALXYAHtn7d8y1YHusYXlvH/fh446G/UGmb6ovm0m/r1
         UZPgBoid7nJDGt6KHmOQPCTpvZbrrsZoO+nvVNWiL/3Vfv8cquDkWYvlycK1v10NZ3GO
         J6aixiDfE/Xn/5rCcvPT6GLWHo0tOb4pim/fDgEJEvJX/Ey+uePDH1MRsr2GgQAUvNUE
         dYAw==
X-Forwarded-Encrypted: i=1; AJvYcCVq5q36cON5JDZsg5HuWLenZ4dK0vbXgS6uQCp5WdZxCT84h3Bne1PM4anrOfOvGHFggce2cyxn2086aTOhMXRXth8mi1hqayQ6U0Hq
X-Gm-Message-State: AOJu0YwdYj1tz4lC9zB6o3//USLoMMSZna1gEcllXLRSzqaA0N7F1iwH
	wZXCxj5CPf9aOJQHQNyzkZIlQ+JZ/In6MIjjzvupmNkpYzuWjQLFgxCvmvk0pPA=
X-Google-Smtp-Source: AGHT+IHo7LKxsrmDSKMk8aOpeGv8Hi5vQ2ujCjvtcHptgMG2NI8nzCY+2dEzhDD7b6VRLZ5xZvE/2g==
X-Received: by 2002:a05:600c:a43:b0:41a:7bbe:c3bf with SMTP id c3-20020a05600c0a4300b0041a7bbec3bfmr2733342wmq.22.1713998712082;
        Wed, 24 Apr 2024 15:45:12 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id k29-20020a05600c1c9d00b00418948a5eb0sm29127833wms.32.2024.04.24.15.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 15:45:11 -0700 (PDT)
Message-ID: <99f51564-df99-4f06-9419-1eaa9501f27d@nexus-software.ie>
Date: Wed, 24 Apr 2024 23:45:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] arm64: dts: qcom: sm8550: Update EAS properties
To: wuxilin123@gmail.com, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
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
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20240424-ayn-odin2-initial-v1-7-e0aa05c991fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2024 16:29, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> The original values provided by Qualcomm appear to be quite
> inaccurate. Specifically, some heavy gaming tasks could be
> improperly assigned to the A510 cores by the scheduler, resulting
> in a CPU bottleneck. This update to the EAS properties aims to
> enhance the user experience across various scenarios.
> 
> The power numbers were obtained using a Type-C power meter, which
> was directly connected to the battery connector on the AYN Odin 2
> motherboard, acting as a fake battery.
> 
> It should be noted that the A715 cores seem less efficient than the
> A710 cores. Therefore, an average value has been assigned to them,
> considering that the A715 and A710 cores share a single cpufreq
> domain.
> 
> Cortex-A510 cores:
> 441 kHz, 564 mV, 43 mW, 350 Cx
> 556 kHz, 580 mV, 59 mW, 346 Cx
> 672 kHz, 592 mV, 71 mW, 312 Cx
> 787 kHz, 604 mV, 83 mW, 290 Cx
> 902 kHz, 608 mV, 96 mW, 288 Cx
> 1017 kHz, 624 mV, 107 mW, 264 Cx
> 1113 kHz, 636 mV, 117 mW, 252 Cx
> 1228 kHz, 652 mV, 130 mW, 240 Cx
> 1344 kHz, 668 mV, 146 mW, 235 Cx
> 1459 kHz, 688 mV, 155 mW, 214 Cx
> 1555 kHz, 704 mV, 166 mW, 205 Cx
> 1670 kHz, 724 mV, 178 mW, 192 Cx
> 1785 kHz, 744 mV, 197 mW, 189 Cx
> 1900 kHz, 764 mV, 221 mW, 190 Cx
> 2016 kHz, 784 mV, 243 mW, 188 Cx
> Your dynamic-power-coefficient for cpu 1: 251

This looks pretty convincing and like good work.

A few questions and suggestions for your commit log.

I'd really love to know more about how you ran this test. What values 
exactly does your power meter give you?

How did you lock the core to a specific CPU frequency ?

Maybe also give the equation to calculate Pdyn in the commit log.

https://patchwork.kernel.org/project/linux-arm-kernel/patch/1500974575-2244-1-git-send-email-wxt@rock-chips.com/#20763985

---
bod

