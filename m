Return-Path: <linux-kernel+bounces-76284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE585F534
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E1282409
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31E3987A;
	Thu, 22 Feb 2024 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emhN0/bF"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A7383AE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596175; cv=none; b=iyGKv+Pe7yMK3Pt7luueXdhWu7hYRyYD9mb7l2Cn49tfJrKvtI/noUvMmmVp/pg/MyILGuCas6c1qSy5SMgXQ4I5t92YwHURp8V8XRUEGYnnbshkPcmONLTc0WTWiCPg2fzrsq/3o+HXEykg/jY7dqFdEU+JZYeN8sDMb8PBxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596175; c=relaxed/simple;
	bh=RInimDCVRpdNH3bzFeS80PPJB9+hFPpPtbWeDnPW95A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C63m6eqHBD561jk69h5k/WYJS21AsNe0CPR7uwV0QR10+A1SBJZ1wsagAIsLuIb7MTbSQ2b9e7RQFnKLIvRQrZFCqbrFsBtdGzCM2V8hSsSZCdTiNO+BD8IZzPdcfupRVu2eXb7vnE3fs8C+/faE8YMN/gATRJweURcwsYR1fRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=emhN0/bF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso7016515e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708596172; x=1709200972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmFzE5KLUhVYgCITZetTHO3yyNj9Jv9D+xMMJe9LX/c=;
        b=emhN0/bFqvoUTl6IZLG4yf85zi4MhShO+/WVWJJkKlqmRtRa7spx/3Awk6r4sGqxM7
         318LQijm1Dt/jyyzH3obolCJ64lKT2JXTCL9VXHIGZe+7B0g0Am/XguI2MPWhU80YLc6
         ZYC9XHuBIN5QrYAZSfgRucQxfDm/gY3izv/CJ8NKKpHNFIyTLBiQPNjDkTKmphM/HkgI
         PHRK0O4BX04DefcjKlV6TJ8JkC1gdT4YNvs1pRIawTwWfaaIg0z66SM7+q03hzWjCarS
         bMSL/CAEvTtP4saJC+Vy7GlhdoQ7Xxm2iDhE87Pp9WN9uJH32+Oy4Sw2ihMmeWRB+Nki
         CHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596172; x=1709200972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmFzE5KLUhVYgCITZetTHO3yyNj9Jv9D+xMMJe9LX/c=;
        b=oBVtlNPEj+Cw72b7BmHXDqlKalbwm80NoO1NPEous6R9jNnB0YjnczPrFZP1Y2XWM1
         SuCcq1egHXEjkLY5Vr2BvKFzKaqGshTRWe+Hxr3zC+gDhyooLs/FvKV7KkxH8CDsm59r
         RgUhZqg5kfrTa0nOzmY8WJUe4sOt7/c2bcSQxut6IB2evzwS2RLsjoTBctRT7Mqm5Kg1
         jTA8hXYEEAB4r0CJ7SQvus1sA503nRwxoB4JVuojbHMrxqhAoVLHg7HrZAhmNf6G/0eb
         L8Zy42NO7yh3TliskFL0IWZgRohvsSAinloWcKkVWjTn3kW2A6rdJNRNi3RN0fB0FL1P
         cW7w==
X-Forwarded-Encrypted: i=1; AJvYcCVlJovwrxjCMXUS9p7k2CLFYTo92NfY/4dOmKzhpjuU3fMILLaRde7IBTzs6MwiqsnXNJFuPAnw3WS/62VuMWAP+VuZHZwC8J2hoF9x
X-Gm-Message-State: AOJu0YxtOeairMy+ODB514m2mrOe5DKDNP7UYW6b+ifoAA31coRt1IHD
	eoEeQUP7Siwp9bOzxzh2FiMcPo5OPeyJqfjT/3bE764km4WDXQuyQ1mUdxOkCgU=
X-Google-Smtp-Source: AGHT+IGWstWv/PpAhG69C508up9GLKHmunJIqiqA/u3mSeeTLIT3kteM6OrJT0F+RBHSuMWr0yMEUA==
X-Received: by 2002:ac2:592c:0:b0:512:b00f:a55e with SMTP id v12-20020ac2592c000000b00512b00fa55emr7040685lfi.13.1708596171837;
        Thu, 22 Feb 2024 02:02:51 -0800 (PST)
Received: from [87.246.222.6] (netpanel-87-246-222-6.pol.akademiki.lublin.pl. [87.246.222.6])
        by smtp.gmail.com with ESMTPSA id c4-20020a056512074400b00512ab928706sm1730595lfs.167.2024.02.22.02.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:02:51 -0800 (PST)
Message-ID: <f36c69d9-24a8-473b-872c-fa0fb722db65@linaro.org>
Date: Thu, 22 Feb 2024 11:02:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sc7280: Enable MDP turbo mode
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Douglas Anderson <dianders@chromium.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-3-dc0964ef7d96@quicinc.com>
 <CAA8EJpo=9vhM+5YzaFxUoYRuEWQyrMS8wLNPSF3K=bN5JwWyDw@mail.gmail.com>
 <8313a7c3-3ace-4dee-ad27-8f51a06cd58c@linaro.org>
 <CAA8EJpqFj5nf8d_=Uoup7qg+nQrxqQU-DHbL3uSP138m9AcXLw@mail.gmail.com>
 <8fcb5816-2d59-4e27-ba68-8e0ed6e7d839@linaro.org>
 <CAA8EJporaUuddHHqpyYHiYSu=toHmrDxSHf9msZUJoym4Nz72g@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJporaUuddHHqpyYHiYSu=toHmrDxSHf9msZUJoym4Nz72g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/22/24 10:46, Dmitry Baryshkov wrote:
> On Thu, 22 Feb 2024 at 11:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 2/22/24 10:04, Dmitry Baryshkov wrote:
>>> On Thu, 22 Feb 2024 at 10:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 2/22/24 00:41, Dmitry Baryshkov wrote:
>>>>> On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>>>>>>
>>>>>> The max frequency listed in the DPU opp-table is 506MHz, this is not
>>>>>> sufficient to drive a 4k@60 display, resulting in constant underrun.
>>>>>>
>>>>>> Add the missing MDP_CLK turbo frequency of 608MHz to the opp-table to
>>>>>> fix this.
>>>>>
>>>>> I think we might want to keep this disabled for ChromeOS devices. Doug?
>>>>
>>>> ChromeOS devices don't get a special SoC
>>>
>>> But they have the sc7280-chrome-common.dtsi, which might contain a
>>> corresponding /delete-node/ .
>>
>> What does that change? The clock rates are bound to the
>> SoC and the effective values are limited by link-frequencies
>> or the panel driver.
> 
> Preventing the DPU from overheating? 

?????????????

> Or spending too much power?

Would it not concern non-Chrome SC7280s too, then?

Konrad

