Return-Path: <linux-kernel+bounces-137195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3842989DE99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A391C219C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058AF13B5A1;
	Tue,  9 Apr 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgtPpHpA"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B213B58F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675603; cv=none; b=DSH1qc7dlXK6o7mBk+yUOCXCdGg+w8uuT1j/JwYw76g2jBoMIWlsne85CAggflqBMWE29VaVITlWfgHoEfO9a384aKnJW9vGKh7m0nbKfB0GMqm2tz1AVLaogeS5nu2gC9dO05l7s5M4BwYkZ1MH3TwSo96599nMTQCgyG3n/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675603; c=relaxed/simple;
	bh=8zS/aBSiaDopJsrV6iViyi5TVd9qN+1iM93inBrcRGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxuCKrty5uB/oXB9pQYmrffcJwa/pL/LZ4bpnqbfAx0eItg31nztuZzkrnnLCAUa4ekqz7+kqzUpjRodkqUTJpTGk3NGKRvweJW/QIXLNsB80oBBI8eIqfhiQj39Ic0/0YQsZ6AK7XG19D3LJz5H1xbN3rQWgk9DCn/0vDvuv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hgtPpHpA; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516c403c2e4so4956098e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712675599; x=1713280399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Y8LMcLnVJ7kXsKs8XUXqanjMzUM/+eZalvbhRQqwe4=;
        b=hgtPpHpAElTNDZ5QPIA3zWEy9UupvVN4++ZNAmGUDHVfLW5tms8FB6ezoTg1xfyskz
         J7VvhbCCdWM6Q3tUFBXOCdq8KiN4KqajbQ+IEfqgx1JdFi5r1QizyTDnSSvn1YU+Updl
         S5ahZfQi4ggAxhjAtEUL3CIbuLvziSrhgzlxyd8NGglihspARyBc6S7eKUdYKKNufx1a
         P6b1fSbUoHMZzrFBZJ1tafcPKnCoGYacxY3PqNlaH9iMPD+z0lse51iZcs7lVlyGgZWx
         xjmqhVo3kAIPYH0i/UklMkw4EKN/6/s/oWBpkQ3qTW11G07teOP3C4QnS50HsdGnmz1v
         H/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675599; x=1713280399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y8LMcLnVJ7kXsKs8XUXqanjMzUM/+eZalvbhRQqwe4=;
        b=Lj0MI5lfpqbgUKnjcA6adP1j6LTMAANyGew7hcmfQwyXUAfU1DQbDg1wtsMTryeNaC
         hNCF87dB09z67vGRyA3a1o5HAfjpHDtCvmJkOS2Y0lAF0zJJTWN9lG1SsFxBUJqQfhWJ
         0ihTPz2YGIoPXMEZmjio2Gi7NdVXOyjG33qkpTNjmxvjPO7i4KvMTSrxA1GsAb29/Mkt
         zH6HqPEsUn7wUdeIOTBnLpGN5I1u2qCfmaNjOVidsdSqJ07jCBNYHIwlVkAomd4MSNDx
         Y6H8pvVKqNAq1gMaVUTCUtP5pDmO1CCOeJDAOUZbuTKxcMX5Orw0f88Oqu4WV5v2quz+
         pUsg==
X-Forwarded-Encrypted: i=1; AJvYcCXKle16dROBQ6Z40PSW3PNvuBDwfOdGAOT1mE5VFhFNZEgKQitsaKC4z9EW0TmF66HmI3WN7deGHiSNURybIRRNa11+CaZFb58iKoCx
X-Gm-Message-State: AOJu0YzKOT+J3R5fgQdJ1kUlo8Vur2RTRydVJoZTYpug7HbCbiS490jZ
	Jq8CT5WTnmML6AEXR/50IcY72eFpglgknm9vKKJcF0eg2NEDJRCw7bY6+qavo3I=
X-Google-Smtp-Source: AGHT+IFlaw2LMhoJukUATahy8181y2HaVjByLfM38iyBHMbY2UF2znz52B2OFJre+KGvD+E2b0w0ew==
X-Received: by 2002:a19:3812:0:b0:513:d1d9:9eda with SMTP id f18-20020a193812000000b00513d1d99edamr982073lfa.27.1712675599395;
        Tue, 09 Apr 2024 08:13:19 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id 10-20020ac25f0a000000b00516cea36d5bsm1603418lfq.21.2024.04.09.08.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:13:18 -0700 (PDT)
Message-ID: <0955cabc-fc4e-4790-a82c-7f6f807fe36b@linaro.org>
Date: Tue, 9 Apr 2024 17:13:15 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <nek4paofg3hturvjwpa2bnsvmicwmvwixzr6e6iuqstemgrqyo@cagcrnzjsne2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/6/24 05:25, Dmitry Baryshkov wrote:
> On Fri, Apr 05, 2024 at 10:41:33AM +0200, Konrad Dybcio wrote:
>> Add speebin data for A740, as found on SM8550 and derivative SoCs.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/adreno_device.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> index 901ef767e491..c976a485aef2 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -570,6 +570,20 @@ static const struct adreno_info gpulist[] = {
>>   		.zapfw = "a740_zap.mdt",
>>   		.hwcg = a740_hwcg,
>>   		.address_space_size = SZ_16G,
>> +		.speedbins = ADRENO_SPEEDBINS(
> 
> I think this deserves either a comment or some info in the commit
> message.

"this" = ?

Konrad

