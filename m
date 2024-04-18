Return-Path: <linux-kernel+bounces-149850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC078A96C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21051C22035
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6188F15B146;
	Thu, 18 Apr 2024 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEB8BLmT"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8715B125
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434018; cv=none; b=Xwox5npHkJ71xlucDQNk0JjMa6mK7oacjRgX1cr57qkO+J2F0f2BgfT1WC0F0LdDT/laj4rELhMqFL/h6y0uZEoZsdys1/9IUXwZxZ7YCgWcqcsc0512j7LaoPDcsxTtbE2JqxMRzFX3keA2S/bX7Ldmtf/hm+/djnooznYVCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434018; c=relaxed/simple;
	bh=Ol7MBBNXfsfudRNvI/1+uyPhECVqgRb4C7elmYU1isI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L28JUSEZbop9dTnacPBXocvDbPYQNQCUALem7kocSReXnuJqYk0pAm/kohjx0SbPRBx6lHvvWzJKFKq38JOSSFkggoAL8HxcuCBW5ztFOUgvGciNSrdfubGmFCbFfY47S8fIL/5h4MRkCv8GiVvO5HbuPBNJotjD3J8juhWUk9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEB8BLmT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a53f131d9deso66949166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713434015; x=1714038815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VLkgZOZ90U32RSTtgOrkaBwhPTaXy2bpzcFJ6tojey4=;
        b=tEB8BLmTrqIt7lFft50mbT4YVlUOe/LAG+01SodHsbJajB8blguHEAQ/C4KRr8UkTk
         78laMQz1o/8FQgh3nBSyeVi794IXbDQV9USv7OkXllZJzbhmSRwtLk9VV5SzSTz8ESMi
         0BRQZ3HhS7huPcHQoVfCu7Bp9OUY8rk4IEseGt9xjuci41qfSFMU8fO4O6wbcsnQy5Hn
         Qsd1g7n09hqsv8gXFcWpeHJydHzRb0M6eiwATRY6A+6DKnYTKwdfVDi+02V+CRm2IUns
         rdqHDNK9BFnlSQFPkuMtmKGEawHJhKqn7j6/zhI2Om9e83Im1tc9YDlLxNs5cVZ1W+Iz
         k2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713434015; x=1714038815;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLkgZOZ90U32RSTtgOrkaBwhPTaXy2bpzcFJ6tojey4=;
        b=kID54uHuLk/eUKBGMrtZwAVayU7BLPgE2CEjjINq3PpgDziC9DIkQ6yPnGn6hfkqMG
         bkavMzhfHypfrJuymPZT9ZSmx9dsCfs5Mcd436RVBkdYs7Aqq1OhqNDC9+cw1kCkxUm4
         SbA+IRVH4pkC5fzGMa8cDFWzGHAV/y5DxbKkKvM7wWWJ54J5Wc+ti7Ercadj6++81775
         jqwXPShiHsdf2RWsdYrjz3ZT8opIqDeKzBp6N7eDI+Gsroj9qXD8p+dfRWTtGXUSmCqo
         FB4H8DJR+CYo1LWxHJhcr7S+aYm5BGhiw/GO5MB90VWp+NTDX52cHKbbxl9ATmksHWoZ
         hVyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqaQsxG1hXQpaIBBndQCFapCl1YJwdA9xbltnWwchxbPD+5J+Wf5k1g8Iy0cuTriE9LsjsJvp7B0NgJid8da352KOPUoumxWTx4mOV
X-Gm-Message-State: AOJu0Yz4RJb6lTStQ8UyiDDUvicc+bU0p3vy3ut7BgTZml87YF4jDsRe
	HXis+gnwHnBqqY2LA1fpuSJHCxxJ4lFl3TNDmRwE2suSRPHn/0SaUCMojF8PlDc=
X-Google-Smtp-Source: AGHT+IGqguX6zc1dY53s7tQdvvJIHYrELOBLXEo4pkndtUrRrRSjHC6R2HouIgqmWsQT+z+tey7clw==
X-Received: by 2002:a17:906:851:b0:a55:6606:bbf7 with SMTP id f17-20020a170906085100b00a556606bbf7mr1276700ejd.35.1713434015231;
        Thu, 18 Apr 2024 02:53:35 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906051200b00a51ba0be887sm662128eja.192.2024.04.18.02.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:53:33 -0700 (PDT)
Message-ID: <89eccb1f-c527-4820-a084-7fc4ad3f0ab4@linaro.org>
Date: Thu, 18 Apr 2024 11:53:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] soc: qcom: smem: Add a feature code getter
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
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
 <20240404-topic-smem_speedbin-v2-2-c84f820b7e5b@linaro.org>
 <mg6ojmzl3snj3k6fuyi6opkbdovs7xna6sn65pjh52ii4yy7u6@ny2spvjjbfpu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <mg6ojmzl3snj3k6fuyi6opkbdovs7xna6sn65pjh52ii4yy7u6@ny2spvjjbfpu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.04.2024 1:39 AM, Dmitry Baryshkov wrote:
> On Wed, Apr 17, 2024 at 10:02:54PM +0200, Konrad Dybcio wrote:
>> Recent (SM8550+ ish) Qualcomm SoCs have a new mechanism for precisely
>> identifying the specific SKU and the precise speed bin (in the general
>> meaning of this word, anyway): a pair of values called Product Code
>> and Feature Code.
>>
>> Based on this information, we can deduce the available frequencies for
>> things such as Adreno. In the case of Adreno specifically, Pcode is
>> useless for non-prototype SoCs.
>>
>> Introduce a getter for the feature code and export it.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]

>> +/* Internal feature codes */
>> +/* Valid values: 0 <= n <= 0xf */
>> +#define SOCINFO_FC_Yn(n)		(0xf1 + n)
>> +#define SOCINFO_FC_INT_MAX		SOCINFO_FC_Yn(0x10)
> 
> This is 0x101 rather than 0x100 or 0xff. Is that expected?

Yes, this is "the first invalid one", similar to ENUMNAME_NUM

> 
>> +
>> +/* Product codes */
>> +#define SOCINFO_PC_UNKNOWN		0
>> +#define SOCINFO_PCn(n)			(n + 1)
>> +#define SOCINFO_PC_RESERVE		(BIT(31) - 1)
> 
> This patch works on fcodes, why do we have PCode defines here?

I decided they're useful to keep.. Didn't want to split them to a separate
patch for no reason.

Konrad

