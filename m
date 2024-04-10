Return-Path: <linux-kernel+bounces-138424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E812889F10C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E901C22E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5468E15AAB6;
	Wed, 10 Apr 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JnXIpMMv"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C277159589
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749356; cv=none; b=opbfWWYfA1bhZ/Xbd6hRhMqE18ITWXqmnGkN6vpz1qYAiHIboyaLs2D11PX50RoclvIuVI2Ts1ovW4ynnakpHxs+xgq4jvC6gg3z/rv1wRsdNqjlOeR8qHCRmje0+JS5WJzoS6CfVr6kx2xu28sZX2HuGG7k6/EDQt7tw25H8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749356; c=relaxed/simple;
	bh=yaFQxvePqSzegCFFO4PoSuEJoGwSuxRd214Dl7AG+sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQCkRMLtMELZan5ueRza0G4+KRJ13fOXnJnTUio1pgF7hzgy+9fmPqkFXpn0V+n4rScYcivS7IVjcu5kte49+01SrMExPbc+BjgbtnnxPJzLatPG+NxWjAZoCziVIuBCAAVdDNT5p02RWJi56C+EMfGGndn1MuzaSnnNaWq7/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JnXIpMMv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d756eb74so5929161e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712749352; x=1713354152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUA83gpzkWVU1iShuYOjIgJTVa9hCldc/8ck/dDALYc=;
        b=JnXIpMMvgKrv2RwXViwWyX+T38+uGBohIZzQasRMdlbRZndTyW1KcaY3U0YN1yS1Pc
         avSX3xjl71rRuYRQmgSH5+O/9hVw6pPG3c/a8Katqx8FHbFuf3h364TTv9Go4wf/AC4q
         MHU9LFgFCnQHpFUrXH/wRPzQ0bQbzoQ5g/io+RRbmDUUSjrttmbbzVBYdwwmIg4GDzn8
         gKeBcGKBOkDpBndUQSOBPkkZw44RycRy7d4jKLBvTQyRAVO6D4GiX7mZtKbHoPNpQuHx
         LB4zYQbbZ0r1SshQGWYyDv81xPO9USjB/nr/OP2H/eZw+6rvb842rgj31WEfkjfIfg/N
         8nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712749352; x=1713354152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUA83gpzkWVU1iShuYOjIgJTVa9hCldc/8ck/dDALYc=;
        b=lfZ/glRvuv5l5QC9HjF0K78/1jhu/8P9vq9b1BCvytbPkPoy7ctwC8/13o81+Aq8sA
         FLhSgVTWDQjkvgfJnbotwHIyCai0QRmakWdRz5fLsbLssfTPm+tImIfmHSKoXp16n+pl
         ybbBNBCHFx8/oxgWv3HtOtmo144rJvJ1ZTtLwAVqDCS3WMJ3nqOnc/e6Erp8wSoa9dW1
         W1Yrqlg5e/PL2SrAnsCN/ckpXVDdzuuE68uMGAW0T8zS6EBiGEbFKg/R1w8TR8sTnWeT
         vJV0EJYGEinofcw2qrYRzoskDHXhXDVIdPje6jRNTv/J+dY/QqO/dgNsAXAdxhTsTNGO
         xnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTrEzEGu8lyx9TYXyoRiDKmGdoH9/LPfzcM5g4s074rYMWRageROMZVwn3w3vL5aOMVsP26taOtJSBTag3Wtm7qQt9/QijdJLQ/2YF
X-Gm-Message-State: AOJu0Ywk3CxP4+CKSwHyHCT/OZcFPBVIdhlzMba3EujQXq4x9vsA2CKM
	Fl/53jrSR3A7dQQlIG4I/TCCiSTf9EQTl2RuHXYruQnVcoCpJHqhWiX3Asc5AbYvPh92v+hacFQ
	Z25c=
X-Google-Smtp-Source: AGHT+IH0+JJIgaOrT6Rtm4Iaj3kAzRyP1f2o2KvzIHaHdG7P6BeuIaEO3YdnIAP8OVrErSr8qWw4XQ==
X-Received: by 2002:a05:6512:e85:b0:516:ea55:324d with SMTP id bi5-20020a0565120e8500b00516ea55324dmr1833879lfb.31.1712749352436;
        Wed, 10 Apr 2024 04:42:32 -0700 (PDT)
Received: from [172.30.204.89] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s24-20020a197718000000b00516c600cfcasm1853162lfc.106.2024.04.10.04.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 04:42:32 -0700 (PDT)
Message-ID: <730d6b9e-d6b4-41fd-bef3-b1fa6e914a35@linaro.org>
Date: Wed, 10 Apr 2024 13:42:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/msm/adreno: Implement SMEM-based speed bin
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
 <20240405-topic-smem_speedbin-v1-4-ce2b864251b1@linaro.org>
 <scvwfj44z3wpp7phvesfwjuv5awtlkwby2vvrpaq4i5fircrt3@i3ebya4iymf3>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <scvwfj44z3wpp7phvesfwjuv5awtlkwby2vvrpaq4i5fircrt3@i3ebya4iymf3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/6/24 05:23, Dmitry Baryshkov wrote:
> On Fri, Apr 05, 2024 at 10:41:32AM +0200, Konrad Dybcio wrote:
>> On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
>> abstracted through SMEM, instead of being directly available in a fuse.
>>
>> Add support for SMEM-based speed binning, which includes getting
>> "feature code" and "product code" from said source and parsing them
>> to form something that lets us match OPPs against.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]

>> -	return nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
>> +	u32 fcode, pcode;
>> +	int ret;
>> +
>> +	/* Try reading the speedbin via a nvmem cell first */
>> +	ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
>> +	if (!ret && ret != -EINVAL)
> 
> This is always false.

Right, a better condition would be (!ret || ret != EINVAL)..


> 
>> +		return ret;
>> +
>> +	ret = qcom_smem_get_feature_code(&fcode);
>> +	if (ret) {
>> +		dev_err(dev, "Couldn't get feature code from SMEM!\n");
>> +		return ret;
> 
> This brings in QCOM_SMEM dependency (which is not mentioned in the
> Kconfig). Please keep iMX5 hardware in mind, so the dependency should be
> optional. Respective functions should be stubbed in the header.

OK, I had this in mind early on, but forgot to actually impl it.

> 
>> +	}
>> +
>> +	ret = qcom_smem_get_product_code(&pcode);
>> +	if (ret) {
>> +		dev_err(dev, "Couldn't get product code from SMEM!\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Don't consider fcode for external feature codes */
>> +	if (fcode <= SOCINFO_FC_EXT_RESERVE)
>> +		fcode = SOCINFO_FC_UNKNOWN;
>> +
>> +	*speedbin = FIELD_PREP(ADRENO_SKU_ID_PCODE, pcode) |
>> +		    FIELD_PREP(ADRENO_SKU_ID_FCODE, fcode);
> 
> What about just asking the qcom_smem for the 'gpu_bin' and hiding gory
> details there? It almost feels that handling raw PCODE / FCODE here is
> too low-level and a subject to change depending on the socinfo format.

No, the FCODE & PCODE can be interpreted differently across consumers.

> 
>> +
>> +	return ret;
>>   }
>>   
>>   int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>> @@ -1098,9 +1129,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>   			devm_pm_opp_set_clkname(dev, "core");
>>   	}
>>   
>> -	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
>> +	if (adreno_read_speedbin(adreno_gpu, dev, &speedbin) || !speedbin)
>>   		speedbin = 0xffff;
>> -	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
> 
> the &= 0xffff should probably go to the adreno_read_speedbin / nvmem
> case. WDYT?

Ok, I can keep it, though realistically if this ever does anything
useful, it likely means the dt is wrong

Konrad

