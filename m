Return-Path: <linux-kernel+bounces-163904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E298B7589
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A585DB20E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443D13DB90;
	Tue, 30 Apr 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxqfuUbq"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525B13D2A6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479341; cv=none; b=IvEUmtGsJCBrY9dDy25++2n9z0asTOJrXmGPMr/fJJEW/E22eWdtZHiwZi8ytQI98mhFOkgO4sFAoWu46GAH22ouk4kvsoHGG9eofuUrSFTWY8iSRPJfccd0UGigY0DGyjSCr+AB8UPJBIYypiaTgTFUJNdUg3zzk32k+0E2zK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479341; c=relaxed/simple;
	bh=HYgAGgg95uxY3rUpbJokNIWTJqd/TL6F2P1lkeA1tug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Azmr3t220VGWL9XicndI2H5ZGm7VmPvpgmPoMK4V4CBx7wLPtLU1ot3J/glUPozCI8bNXHpQFHipvloTOHF2155PL2cX96sHw1/U6MjuMSefsEk5oKf4nidorRDi2RuBYTCefb4fQRAuikY8ELzxZ3XcLNe3Qw50ah9rlmGzc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XxqfuUbq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572a092dd2dso486792a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714479338; x=1715084138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HcZRGGRQNN6JFN01bYHR/sF88Y20eFPOUJv7CvIs2yU=;
        b=XxqfuUbqq/j80iJfswyAxueWhRfRSUDusRwtjfhLNAib+KxSqBvhOmKedENKHejdVZ
         SMTmbHIpd9vVYsoe93m8XWpEkVXhSrWueDJ5GZXGQytwdIMlEMV5WXel1ktUKbvRdQT3
         8rtC+/22G7OWydukc88+WVA13Y0d+Mq59suSltZtvln++MCoiPmvNPTmiSpY+NShQz35
         DnCC9FiEI8915xSUekvq+Bhv5S2siWVSv8IQ2c8kt10IKD3TZUAoKRFIUx+c2GY0hoY8
         NG9dEiHm537T8xsh9xfrdJNhY6U/l/zGciZYH6i7uYoujHzUPeEGIuSWOtmAUrVuytQk
         KkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714479338; x=1715084138;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcZRGGRQNN6JFN01bYHR/sF88Y20eFPOUJv7CvIs2yU=;
        b=NGaZiF+WRxbzI4V0S8MbA0YYpeWjyzh8BGAyiGkAijnKMX5AV5H3pQ7HuEC8p5UvKg
         4mf4OjLjafA6UQkylKXLhlHI5hf0ZzRBVOwZ2xun6LWr7yoPWAxogzVhpqKjSszw8cSj
         bbknKvF1hjgLfWlellc8TvVp2rvSk0lqeOOuMfasoK13DyQtyHMPAg0EJhztLkzq76Ma
         G6vPSID6jqtOYADt3/pvSCMSsBKmnYBH+EIEqOMKQCIoz6bHrLt9Ns/xdFdtQRxwGNlC
         5vToIHAQzO3z9vV7o5Ov6lIFHEEahPHM4wYgSdpkagWThdr8yZLFK6YPefLDYo4Ms9GI
         9tQg==
X-Forwarded-Encrypted: i=1; AJvYcCUPrfaVJIOWhEuU4U8212rZCGG8a4++yeE+ZtlXF5KcSk7YQpipxAaDkm24ZjVqfHevTUrnRWgRWdC4ZiO3EB4NahLDNKqnaaewXUSd
X-Gm-Message-State: AOJu0Ywm4FAPK8LOj7vLxw9AotJRHfCAIA1hlrTFNsSXEdlI7ymFMvBf
	fx6JrqRNEA3maazun9P/KbL3chTETnZhq6trZ1qKcW7MxFcGI9mEaLaVOXdP4AM=
X-Google-Smtp-Source: AGHT+IHYivGwREaww/1+g3Qx78tYtFlcfzl/pCUZp8c8sEZma9Vm5ZHTkpWY5HF/p/o1P5FOeqXHqg==
X-Received: by 2002:a50:d65a:0:b0:566:4aa9:7143 with SMTP id c26-20020a50d65a000000b005664aa97143mr2163344edj.14.1714479338031;
        Tue, 30 Apr 2024 05:15:38 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i32-20020a0564020f2000b005723bcad44bsm6231057eda.41.2024.04.30.05.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:15:37 -0700 (PDT)
Message-ID: <5a595993-04a2-4055-b8ba-806fdd266812@linaro.org>
Date: Tue, 30 Apr 2024 14:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] sched: Rename arch_update_thermal_pressure into
 arch_update_hw_pressure
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
 agross@kernel.org, andersson@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com,
 rui.zhang@intel.com, mhiramat@kernel.org, daniel.lezcano@linaro.org,
 amit.kachhap@gmail.com, corbet@lwn.net, gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Qais Yousef <qyousef@layalina.io>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240326091616.3696851-1-vincent.guittot@linaro.org>
 <20240326091616.3696851-5-vincent.guittot@linaro.org>
 <95760e2b-ec38-4f04-8f86-e4f935d24a83@linaro.org>
 <CAKfTPtDhVfpvO46YWmMnVhJmiKUbNJt7d2cvmyXfPJ4g1YZkXg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAKfTPtDhVfpvO46YWmMnVhJmiKUbNJt7d2cvmyXfPJ4g1YZkXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.04.2024 2:00 PM, Vincent Guittot wrote:
> H Konrad,
> 
> On Tue, 30 Apr 2024 at 13:23, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 26.03.2024 10:16 AM, Vincent Guittot wrote:
>>> Now that cpufreq provides a pressure value to the scheduler, rename
>>> arch_update_thermal_pressure into HW pressure to reflect that it returns
>>> a pressure applied by HW (i.e. with a high frequency change) and not
>>> always related to thermal mitigation but also generated by max current
>>> limitation as an example. Such high frequency signal needs filtering to be
>>> smoothed and provide an value that reflects the average available capacity
>>> into the scheduler time scale.
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> Reviewed-by: Qais Yousef <qyousef@layalina.io>
>>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>>> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>
>> Hi, I'm not quite sure how, but this commit specifically breaks booting
>> on Qualcomm platforms with EAS..
> 
> This is the fix:
> https://lore.kernel.org/lkml/20240425073709.379016-1-vincent.guittot@linaro.org/

Yep, works now!

> 
>>
>> https://pastebin.com/raw/1Uh7u81x
> 
> Which platform is it ?
> I tested it on dragonboard rb3 and it booted and run tests  even w/o the fix

As the log suggests, SM8550 QRD

Thanks for your prompt response!

Konrad

