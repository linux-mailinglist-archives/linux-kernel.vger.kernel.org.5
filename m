Return-Path: <linux-kernel+bounces-137448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4233C89E250
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731041C22967
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437F2156C46;
	Tue,  9 Apr 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQpVK86p"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB315697F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686400; cv=none; b=lu+gVTBCCn+X+MI+iUBMEER2bLIrEMzMj5MccgdRiql75y0iOOe0C21qYf9IpS+5JhKw0aZZjVdkytVdQnx+Ie+ASmmDAVXePnSNldazdeqlZWhaQv73CC/6eCyRd5FoIbq6EkWlbclBLWM5+av6l47w4tg8AAPBrkxO25IT9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686400; c=relaxed/simple;
	bh=uLNeg1qHDIQyx4DVMEosgXpludE+lVP3yhaBpeYJCHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+eJKJx2n+UncFrS4TpZhZZe/qmmNA2+JGciqrbItXz/TuGWDZTbKN+xE7vb82l5H07FpIMrG+Y0DFfRYF2G6NeCj+apsoj1fBCvKDNbc7Hawx24zuDYPVWj30KvbQBc4vdt/n46Xl64JQsOziFB7ZUu//B6AyKtlGjPvTQhhcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pQpVK86p; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so55488731fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712686396; x=1713291196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVvL2F1G6X1zePnKsaGHFi1ccfudklq9eqO3sqLfMAg=;
        b=pQpVK86pEd72nTJgHeERw/U99JtL+PyvlMEZOly41ki8pL1ntemFwcuP1glvkaIGK0
         zsDEE3OgMNf7DtPDXAnkg9va+umiKFjOKRDK8qkSCuFLhg31sxBQ+aIQoR4hRTzrIke7
         6uEf9/dyfrWjamM+DXDAXDp6jm3M3hIh5aUjCJcFbxLK23688Vwza2arS7P22d262GnR
         SlB81KrQhHXU/uK2HdjzgWDviAXvai3/WdbXcnTW4deQlS957sN6+LbRYJ56WkrQNjqN
         KzAm03a1vSYtoZ23Va+vtUEADUWUncC2t0e0V/LTGn6ijyIaAy6qTPObMtchxrvY4Nox
         4iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712686396; x=1713291196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVvL2F1G6X1zePnKsaGHFi1ccfudklq9eqO3sqLfMAg=;
        b=AOu+JEFuwo1d+UxXocUHy9vj25P3wKd2wBbDq5gD2Bi5sOw5HxeeUfn2uH/Ni+jrNq
         MM8gD9Jy7bArvxdAuN/gO/DS/Uv7HFi3sbWTBpkiTzeQnORW8HaKbfof5m+Dq6WRWx61
         RpHvN9OPKwYYlniT7WwHxF0G/ic7c/FzEa486Y31Mc21AVIScjlkVsuOXsnSY6K/cA4j
         t0Rzsnq7ddFY+XshCxiPQESrDUsT90z7/ealF7lW9yw7/0UP5ZyfkTUpc9uGudz0xX3D
         KWopKlqNNXwPHQDwWwIRS9cALoq46pKvhenFhvrcWt+RxMz3Uh++vd8zasoeN2o/9HIK
         Eo5w==
X-Forwarded-Encrypted: i=1; AJvYcCV2Fphj+sEYnPWdApE8pz4srJk5YPYD798z2bofH6+6FzAcHbIy37wcaQ2zj+rkVIbXQ+xhX1Cg+EE1CaQ92PzilcSpjOWp36bkwKyB
X-Gm-Message-State: AOJu0YzR2iWldCMzDnFy53QEd8/cmEpwFpnfUk7JGD+RLjo/XW/9jyiv
	Ry/IbJn3l2oAVfiCqqrwRj82fkZiMEY8LhmCDuLuoZ1I/enx529jgVitfAiEBKo=
X-Google-Smtp-Source: AGHT+IE9IkoN4MIEa62W5SDOs6R2IZNM/Lb7/qVpQfgom65bemgoHxP7/c5kJNTK3D/ZbevsozDIkg==
X-Received: by 2002:a2e:6e06:0:b0:2d8:63a2:50dc with SMTP id j6-20020a2e6e06000000b002d863a250dcmr374922ljc.48.1712686396194;
        Tue, 09 Apr 2024 11:13:16 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z25-20020a2e9b99000000b002d869fec5ebsm1535892lji.79.2024.04.09.11.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 11:13:15 -0700 (PDT)
Message-ID: <fbfc2d7e-2120-428f-bb1f-60aa606b261b@linaro.org>
Date: Tue, 9 Apr 2024 20:13:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/msm/adreno: Add speedbin data for SM8550 / A740
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-5-ce2b864251b1@linaro.org>
 <nek4paofg3hturvjwpa2bnsvmicwmvwixzr6e6iuqstemgrqyo@cagcrnzjsne2>
 <0955cabc-fc4e-4790-a82c-7f6f807fe36b@linaro.org>
 <4ghhtxjtkfjzxeyrajn26get4d6xiq57swwsjmyialcyfivui6@se3ukxxukspt>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4ghhtxjtkfjzxeyrajn26get4d6xiq57swwsjmyialcyfivui6@se3ukxxukspt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/24 17:24, Dmitry Baryshkov wrote:
> On Tue, Apr 09, 2024 at 05:13:15PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 4/6/24 05:25, Dmitry Baryshkov wrote:
>>> On Fri, Apr 05, 2024 at 10:41:33AM +0200, Konrad Dybcio wrote:
>>>> Add speebin data for A740, as found on SM8550 and derivative SoCs.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    drivers/gpu/drm/msm/adreno/adreno_device.c | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> index 901ef767e491..c976a485aef2 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> @@ -570,6 +570,20 @@ static const struct adreno_info gpulist[] = {
>>>>    		.zapfw = "a740_zap.mdt",
>>>>    		.hwcg = a740_hwcg,
>>>>    		.address_space_size = SZ_16G,
>>>> +		.speedbins = ADRENO_SPEEDBINS(
>>>
>>> I think this deserves either a comment or some info in the commit
>>> message.
>>
>> "this" = ?
> 
> I see two types of speedbins here, it would be nice to understand at
> least some reason or some defailts for that (if you know them).

"one is slightly faster"

sorry, qcom downstream has been getting increasingly cryptic lately..

Konrad

