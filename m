Return-Path: <linux-kernel+bounces-31802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C948A8334D4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275DCB21F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51BF9E0;
	Sat, 20 Jan 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvmeDe2r"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F337EEDA
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705757673; cv=none; b=Sy4ArIV2K82ZoPep0Ckr6fuuZvznfnxJZB0+0y1uZtTz09O5jFcpjU1A30ToxWEdF2AC/FDTGlwKWEkhZ0Su/yMd/HJWO69CSbJFM+k/hGUALeGFXhMagiJX6AH2Pbb4cCgI0hUWv+fLyPYNpJC2hp4RHfaOnGdqvcX9Hm+Q+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705757673; c=relaxed/simple;
	bh=/51rCxbz4hfQlo+gW3a9ksrMwWzL5zOFSXEqn0flkb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Su8G1k5+xJcN0y9jgkdHWjoT9nm2bJq6hPIBkYid2v5kpEeRLXRAYKX3wfb01JnuMwwxIFg7gVjrPtKPpJzWNiqytM3ZnL64/iIGZY/tX66nweyE/2hqeVzOEAGsR0tzO73ZuaqzgrP6sQ/69nmRUPjEIsuVjq/ggOswgoUrT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HvmeDe2r; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5578485fc0eso1669172a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 05:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705757670; x=1706362470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wu6dpe6+3cVT9RSClVfzBxKDp3jj/1XAUoktye5Nmic=;
        b=HvmeDe2rsao/j4fctvohf6DfXMEIsoFa4pyodwwGl5ihFGzbU/jFw6wSJUPwmh7ZdU
         6ZB1HeoES/WmOsL/LliXa0zZ/pp9bek/v3XurnZR9YAp/fYNLGkmb7x163vJ6bMXiHld
         HukZRqOJNMD132pwuLBaDETAPKtf5ZucVFlMfNPrehfN7UHuQt0LgslcVKjh6+l2FEnn
         NAoPqGq5TeDVCrCLlvqpSnEIl6puyAtuaax8ur/DyE2lCsF0SuZNm++3caIks1z+IyNk
         2fZZYBo/NDfDuv4bTU6425pI2NzH2NX9Hd8+V2fi3BytDUnCvYSqr9uYsKg6nZsjj4fo
         EYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705757670; x=1706362470;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu6dpe6+3cVT9RSClVfzBxKDp3jj/1XAUoktye5Nmic=;
        b=dAXe5cLskW0ciZKRxa8kkz/Fidvi2ryQMj14SIMA54l4ulbcOJ2kyzeUMXj88bHFpb
         B0nJwB+dN+c9X0G4vb2LFIRT5cEIImB3343DKDPlgx828vuWxduUjje5pwFJK1DtGFFK
         bjei72yboZd1/k4XijS9/e6++XIF6I2IQHne08Ezs5aQ8JxeDkQl5Bo5quzLXjzaZwCJ
         ILUlbPUgIuQzkLf9USwDrz6l4bhwV6h3BJpVL5Rx0zK/X2gUmNlF67CTCAvTxUaqzsU1
         jVJSapxZwfQtGthFGFmJhlX67+MfPHVxyiGCfSWessCxXhsURd8aGfVxgrw+8vouNUir
         8umg==
X-Gm-Message-State: AOJu0YzrOPBzgVKPpouQvnqTTF1RMEdio3c0rqR8kTb3C/xBZTWaWafm
	Fep/CkQT9WotQyBTDx6ujGjKCKWbakO5szrtMSnvJ7SmmgMuVV8Edtqt517vTBc=
X-Google-Smtp-Source: AGHT+IGhe66/+NRLVvjDgSeqDMDVfeXFfGZUTFsWFNF/yIHwycWmc1mCzaLUwlElPtGesWd293jQ9Q==
X-Received: by 2002:a05:6402:d55:b0:55a:383e:504f with SMTP id ec21-20020a0564020d5500b0055a383e504fmr720579edb.6.1705757670278;
        Sat, 20 Jan 2024 05:34:30 -0800 (PST)
Received: from [192.168.231.132] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id h9-20020a0564020e0900b00559736b84ffsm6826087edh.89.2024.01.20.05.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 05:34:29 -0800 (PST)
Message-ID: <46d20df5-4613-4c7f-aeb4-9d2fe38083a0@linaro.org>
Date: Sat, 20 Jan 2024 14:34:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Introduce additional tsens
 instances
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118-sc8280xp-tsens2_3-v1-1-e86bce14f6bf@quicinc.com>
 <ce77861a-b362-4ecc-8e92-7fb846c7e508@linaro.org>
 <20240119190027.GQ3013251@hu-bjorande-lv.qualcomm.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240119190027.GQ3013251@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.01.2024 20:00, Bjorn Andersson wrote:
> On Fri, Jan 19, 2024 at 12:31:06AM +0100, Konrad Dybcio wrote:
>>
>>
>> On 1/19/24 00:00, Bjorn Andersson wrote:
>>> The SC8280XP contains two additional tsens instances, providing among
>>> other things thermal measurements for the GPU.
>>>
>>> Add these and a GPU thermal-zone.
>>>
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 37 ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 37 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> index febf28356ff8..68b5ac0339a0 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> @@ -4033,6 +4033,28 @@ tsens1: thermal-sensor@c265000 {
>>>   			#thermal-sensor-cells = <1>;
>>>   		};
>>> +		tsens2: thermal-sensor@c251000 {
>>> +			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
>>> +			reg = <0 0x0c251000 0 0x1ff>, /* TM */
>>> +			      <0 0x0c224000 0 0x8>; /* SROT */
>>
>> I've previously called for removing these comments that we've been
>> copypasting around for years and years, and I'm gonna stand by that :P
>>
> 
> I'm not against that idea, but are you requesting that I update the
> patch, removing the comments as well. Or that I send another patch
> removing all of them?

Sending a patch that you immediately fix up is a little besides
the point. But the latter would also be nice, if you could.

> 
>> [...]
>>
>>> +		gpu-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>
>> Hm, did tsens only gain support of non-polled reporting with 8450?
>>
>> If not, we should definitely update all the relevant SoCs.
>>
> 
> Are you referring to the fact that 8450 seems to set most*
> polling-delays to 0, which are "valid" delays but would cause
> thermal_zone_device_set_polling() to just cancel the timeout every time?
> 
> We should be able to do that on all platforms with working interrupts,
> no?

That's why I'm asking!

> 
> [*] Some of the zones has a passive timeout of 10?
> 
> 
> That said, as above. Would you like me to fix that now?

Yes, please!

Konrad

