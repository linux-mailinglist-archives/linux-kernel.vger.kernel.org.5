Return-Path: <linux-kernel+bounces-8405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897BA81B6B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C42F282C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAEC77F28;
	Thu, 21 Dec 2023 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUKQgpcS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6877F11
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55372c1338bso818464a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703163214; x=1703768014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+z6IBb57Ppqbid95erAGh0Pwx17723I4teCRYnelRI=;
        b=eUKQgpcSqYKRPfadBuzXvHodNmBODVtGliW0mBFAqcotP0tfLt/6CfhcpgNLk1tL1S
         flN+OpyNPwXsz07OrP3J7QyJJXSP5asVcNru3DMZHEorN0Yf0Zgk3EQ79Jj6xGM7903Z
         WxUBA3FEj1wPrKqIsyGsdUNXRfHgzXv4AA6etL32U5mRkFeE39IKd7OzeBQ0exWNYf87
         v3jGLDE4TS0BMzYX1cSB1D52l+1F791phEuwwvNN2kgxuj6PDb/YArdqBsF3v1/CV16P
         dzYbV1Sy88jMoxPSPVITO2xLjziWDlhXzyULvpx3cC5aZEb1H0KbhlBknts5HfSEcvPW
         mJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163214; x=1703768014;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+z6IBb57Ppqbid95erAGh0Pwx17723I4teCRYnelRI=;
        b=Kve8jrK+gcK0iLoGQwTOvu96v0CPTParl1j86tCyabO/gOR43OumC/O2qu3JxFgMT9
         SSwwRConiBOFejZup3GQgc+Iq8DzVc4vsQHyIaSK3QC06EPi6DxByApXJrbPuHNNVqFA
         6VfJI4TJcNRdluDhPpiPa1pDkJ2Q4OmgbsjxNyCjN7/fepHFTX3SJmr3EWALfQppOwyV
         VUmselI3iPK91C1E7VQA3QpIXvy5tYpx+CMKEp5beWGCJeFW2v/xz7CRUCIh4sI/1Bat
         w0p1DjGsdPWWIKvtS7voQvDCeSWEMKR6e3KTp5Nyh7bjoR+7cfXKMjLjnPM/KKUjmrqD
         7WhQ==
X-Gm-Message-State: AOJu0YwAB8LOHXKycMwEY16Lwb/nVJRIAp1mMB1ItXB+ijLCQoRbvr2C
	R6sarg/FaZEUiU9+V4rRdZyV6w==
X-Google-Smtp-Source: AGHT+IH8WuhcvcvvMLjvCJ3CAdXqw5omFoQd3Z1bMT/YRAxPAgWjh4hH/toJSYDqjXr7zZJ7Xno8uQ==
X-Received: by 2002:a17:906:dc:b0:a23:5d5d:783 with SMTP id 28-20020a17090600dc00b00a235d5d0783mr2423146eji.151.1703163214030;
        Thu, 21 Dec 2023 04:53:34 -0800 (PST)
Received: from [192.168.199.125] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090681c300b00a1f7ae3dfbcsm935159ejx.174.2023.12.21.04.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 04:53:33 -0800 (PST)
Message-ID: <d2007240-2779-4881-8e9d-1c4f5daa55e5@linaro.org>
Date: Thu, 21 Dec 2023 13:53:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fairphone 5 PMIC-GLINK support (USB-C, charger, fuel
 gauge)
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 cros-qcom-dts-watchers@chromium.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20231220-fp5-pmic-glink-v1-0-2a1f8e3c661c@fairphone.com>
 <8d042095-1e09-45cc-9762-909fe8d663a9@linaro.org>
 <CXTU5MLN0YDS.29PPV8KZF8G9R@fairphone.com>
 <CAA8EJpoD3x=kVLu4x2yLtAqCp=wmGSU4ssq5Oj_SD5VQ=GyAYQ@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJpoD3x=kVLu4x2yLtAqCp=wmGSU4ssq5Oj_SD5VQ=GyAYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.12.2023 11:34, Dmitry Baryshkov wrote:
> On Thu, 21 Dec 2023 at 09:33, Luca Weiss <luca.weiss@fairphone.com> wrote:
>>
>> On Wed Dec 20, 2023 at 1:32 PM CET, Konrad Dybcio wrote:
>>> On 20.12.2023 11:02, Luca Weiss wrote:
>>>> This series adds all the necessary bits to enable USB-C role switching,
>>>> charger and fuel gauge (all via pmic-glink) on Fairphone 5.
>>>>
>>>> One thing that could be made different is the pmic-glink compatible.
>>>> I've chosen to use qcm6490 compatible for it and not sc7280 since
>>>> there's plenty of firmware variety on sc7280-based platforms and they
>>>> might require different quirks in the future, so limit this PDOS quirk
>>>> to just qcm6490 for now.
>>>>
>>>> If someone thinks it should be qcom,sc7280-pmic-glink, please let me
>>>> know :)
>>> IMO it's best to continue using the "base soc" (which just so happened
>>> to fall onto sc7280 this time around) for all compatibles, unless the
>>> derivatives actually had changes
>>
>> Hi Konrad,
>>
>> I think at some point I asked Dmitry what he thought and he mentioned
>> qcm6490. Even found the message again:
>>
>>> well, since it is a firmware thing, you might want to emphasise that.
>>> So from my POV qcm6490 makes more sense
>>
>> But yeah since it's likely that sc7280 firmware behaves the same as
>> qcm6490 firmware it's probably okay to use sc7280 compatible, worst case
>> we change it later :) I'll send a v2 with those changes.
> 
> Worst case we end up with sc7280 which has yet another slightly
> different UCSI / PMIC GLINK implementation, but the compatible string
> is already taken.
> I still suppose that this should be a qcm6490-related string.
Right, let's keep qcm then

Konrad

