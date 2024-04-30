Return-Path: <linux-kernel+bounces-164678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0518A8B80FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA884B20DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD2219DF5B;
	Tue, 30 Apr 2024 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knhSYUpA"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F212B73
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507323; cv=none; b=i7atNZcvo9BdLDzq2ikBz1BvDGZvM3+NyuomDXyK7LW2uYqwo1BVFHvcB3nojDzn7XmV5Uc6mM0iuxS4T7b31z7npyJd0zUFuTCmqYU8UeWFV1hAWN6NoGZsCk+X9VvE4cznB8EGgDyCvXECen85PixPEtg34zwTzlmkFszhwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507323; c=relaxed/simple;
	bh=FN4XZtRK0P9gi48Gwo7LIStjuliRry5RBF8jsmm8jZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjLEbw4xaCb+5sS5mM+qVXc85aIssGIZsHNrrdTEfDA+FoP+7kOSwxg7NhM9VHT2vn4kVVJyuSN4WRCCjqGCZAC4bGYu7+6j7ZXpSU+B+P3PrBUkz3irRtBm87RHsvsAJZFMvzfZ8a4KsaWwldwJ3/nSZvRNAbMUMNN9AvD1PRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=knhSYUpA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516ef30b16eso7045249e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714507320; x=1715112120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kVY1R1hSDj9BybRi8F7BevcWL48GJ1yftHwTF1g1Te0=;
        b=knhSYUpAAckd9dqMS3wKtLx75xhiqM2Hebdo2W1obKaveMictqMAA7TilQFAx30IIO
         a8beY7bQHys9RzTTO5Gxm3zpHWP1UIZFw7IMXds/6soL94Pb6DU9QqFf7p+wqwRD3ryF
         3qLtc7VnlXRGOvsUzSGoB+35QfQjdz8y8RgG1ISqvsZFDrkiqLoIe4kQPd5+nu9fge67
         0ECl5pI8mdsLraB5i0QvWAJrjgrZZmd2uWVCO9WeiZ3fQXWjzvK1Wdp9j2LkOEdii+DF
         HpIEfWjA5b7vLT55Bi86MXsKq+aYiSbKhz5aJxYCuqU+y++kPe5oGKSv9KV6G79U9msy
         CLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714507320; x=1715112120;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVY1R1hSDj9BybRi8F7BevcWL48GJ1yftHwTF1g1Te0=;
        b=OFQdaSpomMDEllZ4MYW6ZfbI3smroZW/FUNjc7v0aNlo7GGjdzLf4mPJWHI5XEjyDd
         oZN95vobNwNkMD1Keb0dHCuSuTW+U2p0vGgipymqWfPAfq6dy2mXudn+9DtpkakY50P5
         Pc5pb3OQekRk/7Zc4VSL3zWOvM1EUwfKxyDzDQCSfcx/U6qce3GkH2pelojS9cSDqUO9
         OqzDVPjw7CMLxgjoOZ8+akOcPFG4IBYLYKMioL8IuiQ49xRFO/4UMJu2EqUnn+i3XF/g
         tlqWmEL/+idNIkmItQmNuT4NGG+nycktsG8oMR98zn9tgUWSKLN9G5rgQMsUxdV2U9jy
         x1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4YS4GQEStZJx90gz7o6VEmegElRbwwsBDneU7FMbCGtaReZpreuAHOMeCaIkts36jSozaSxrXjosOfjIu/5oHIq6W/hEghupaZlgM
X-Gm-Message-State: AOJu0Yxb91XGottC2zovBG1lItCFXgM39Y9yQCmzZ7HZLEmG/vQ3WQuN
	cJZiCqbvI5pd/Nekf4RIiAW9u/6IIGgfZfykLvhJSwwm2Qjt2LzkrjcX0VmmDS4=
X-Google-Smtp-Source: AGHT+IFPkr89m6eEs/CQkai3hgCL6srE2z30lROhrlCeAec8GfnC5xMtf5satxWc2lPGSwEL1Lquxw==
X-Received: by 2002:ac2:54b3:0:b0:51d:15ef:dc10 with SMTP id w19-20020ac254b3000000b0051d15efdc10mr278416lfk.41.1714507320280;
        Tue, 30 Apr 2024 13:02:00 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a51d3785c7bsm15409877ejq.196.2024.04.30.13.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 13:01:59 -0700 (PDT)
Message-ID: <d36c1163-a3f0-4034-a430-91986e5bbce8@linaro.org>
Date: Tue, 30 Apr 2024 22:01:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode on V6
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Gross <agross@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-6-quic_jkona@quicinc.com>
 <5c78ad52-524b-4ad7-b149-0e7252abc2ee@linaro.org>
 <b96ef82c-4033-43e0-9c1e-347ffb500751@quicinc.com>
 <a522f25f-bb38-4ae1-8f13-8e56934e5ef5@linaro.org>
 <dbd1b86c-7b5f-4b92-ab1f-fecfe1486cfc@quicinc.com>
 <621dbaaa-6b86-45b5-988e-a6d9c39b13d7@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <621dbaaa-6b86-45b5-988e-a6d9c39b13d7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.04.2024 11:50 AM, Bryan O'Donoghue wrote:
> On 24/04/2024 10:45, Jagadeesh Kona wrote:
>>
>> Thanks Bryan for testing this series. Can you please confirm if this issue is observed in every run or only seen during the first run? Also please let me know on which platform this issue is observed?
>>
>> Thanks,
>> Jagadeesh
> 
> rb5/sm8250
> 
> My observation was on a previous _boot_ the stuttering was worse. There is in the video capture three times that I count where the video halts briefly, I guess we need to vote or set an OPP so the firmware knows not to power-collapse quite so aggressively.

We seem to be having some qualcomm-wide variance on perf/pwr usage on some
odd boots.. Any chance you could try like 5 times and see if it was a fluke?

Konrad

