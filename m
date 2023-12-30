Return-Path: <linux-kernel+bounces-13415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861088205DA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB612820BF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FD28BED;
	Sat, 30 Dec 2023 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UdTmY8PN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE679EF
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5555f9061b9so3531544a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 04:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703938933; x=1704543733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WraejfcK2e2j5BfUVDmZdtIL5eFxZdjlTkM6VwDeTVI=;
        b=UdTmY8PNFYbmblYxw7hPNxvRCIn36zCMi8eXvlKUi1WLs5Rlmye9eaP4+7vA8uBiRM
         RjpbWA04HOzVZiJmsR8io1p+96XQtZ6scoA7Iu4C0wkXVgYUU2I1Hr8Shh2zjZJUDSoB
         yZWMETjJFJsvudSSCjkr9cKnKkB+richEhYHDUBaHi9Sr/Zt72FUQAiH0OHRdaljCWqU
         bNlXvsPnXa5ckhsAp7i1l+kIh8eDD0kNVxmL9r1Kiu3Xp0FRdKRdOXGKVwCZVV9m4lIK
         vrMrvd5+FpM/lkOaABJmvsXsykxq0Wm2l5G9CbXm3tn+PmXapx8ZqCN3N3XOJI8wagrN
         1CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703938933; x=1704543733;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WraejfcK2e2j5BfUVDmZdtIL5eFxZdjlTkM6VwDeTVI=;
        b=aZIipgPYI8pk/q1gLncKEVieiNDeGDlImcD6a05DCWF0iShHbGFj4AwsXbhbghtv7h
         wliPZC2F7Rictb2O/UpMvZFE7IykNsSpKb+wicWUztvNJXcwJDqfYDGAWVre9pre8cRq
         2K4xpEuJ08c8PYRHx6rKf32okzzSmci4uShaT9s66CWmjogGp1B8ZaxwJs/oSDu2K3ck
         enMGtL2TVmdzTIlQdSPT99wkxFj+lFJEy60OXm5frjf8Hs315QORVZ6ORIRoaY1381Of
         ROntsZN74UuZRkQAiJo0/u/CwPICe3EB2NdjU9/N/ZCOiGlaBOAV7VicQrzT5+sGeO4U
         a/4w==
X-Gm-Message-State: AOJu0YzH9UBEtsl2dIniHOGtjssXWTPLqogqGjrUdiAupKUNZxJGELdg
	2JmykktrHPn8UomkcARZiJv/iIHX9bAokA==
X-Google-Smtp-Source: AGHT+IGioza2ZLJGqYDEiNM69okkxaTquc5p5kuP+zRZUhfhEuqvZbJCDySqOqnouQ7x7+YejTIElA==
X-Received: by 2002:a50:8acb:0:b0:554:4dce:9d47 with SMTP id k11-20020a508acb000000b005544dce9d47mr7873841edk.14.1703938932976;
        Sat, 30 Dec 2023 04:22:12 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402015400b005530cb1464bsm12202499edu.15.2023.12.30.04.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 04:22:12 -0800 (PST)
Message-ID: <dc11577e-7088-4975-8543-ad8001e678fe@linaro.org>
Date: Sat, 30 Dec 2023 13:22:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sa8295p-adp: Enable GPU
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold
 <johan+linaro@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
 <20231220-sa8295p-gpu-v2-7-4763246b72c0@quicinc.com>
 <4a1c18e3-39c8-4070-ae55-b1148b3dc65b@linaro.org>
 <20231227202130.GA1315173@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231227202130.GA1315173@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.12.2023 21:21, Bjorn Andersson wrote:
> On Wed, Dec 27, 2023 at 02:09:47AM +0100, Konrad Dybcio wrote:
>> On 22.12.2023 05:39, Bjorn Andersson wrote:
>>> With the necessary support in place for supplying VDD_GFX from the
>>> MAX20411 regulator, enable the GPU clock controller, GMU, Adreno SMMU
>>> and the GPU on the SA8295P ADP.
>>>
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>> [...]
>>
>>> +&gpucc {
>>> +	vdd-gfx-supply = <&vdd_gfx>;
>>> +	status = "okay";
>>> +};
>> Already enabled
>>
> 
> No, we're disabling these in sa8540p.dtsi, so they need to be re-enabled
> here.
> 
> I don't remember if it's because the attempt to bring up gfx.lvl or if
> it's the attempt to operate the GPU components without adequate VDD_GFX,
> that is causing the issue...but either way, we don't survive boot.
Oh right!

On 8155 touching mmcx, lcx or lmx would kaboom the platform..

> 
> 
> It's possible that we could move the max20411 up to sa8540p.dtsi to
> avoid the intermediate disable, but I'm not confident that it's "part of
> the platform"...
Yeah, it's probably a question that is impossible to answer, as my
wild assumption is that all designs are ADP-derived anyway..

Konrad

