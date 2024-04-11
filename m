Return-Path: <linux-kernel+bounces-141568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4888A201E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BBE28BD40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A4317C7F;
	Thu, 11 Apr 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEPP92Ch"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3117C6D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867054; cv=none; b=O1W6ojC2nUkR8lZdFVj/LPq24z7YmYAGbM34DQjzPeY16UIr/UK+I75dlfJSerLDQ1xf/oAtlHg++hV/ef2E9ec3wtBYOWKkKPwmhcKoqkLThpB80cCpCIQUeaTVUDLsWBgbJqLCgJ0ESWhT6bEi5wCCyb6wMUGGfkT5O8boPC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867054; c=relaxed/simple;
	bh=QqxmKREBd98R95lxy1BDt4/C4X/1ZCgWeLkeabMbOEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GD1TMsJX2tSKYeT75qvmrxvf0ZswmRdJw0hj5wkLlRF9D1DLuzluecsEYCzvLGZ7gu0RnHJf0myLgxUXkHPLzLMJE/NbbMj4O+qnyvlQ0641NsdqtS+NSRe2uWPB4Pc/J5E4ETGvBhkXgvYo+83+yxnXkEkYtBJ8/RCjDGEr3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HEPP92Ch; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d485886545so2670391fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712867051; x=1713471851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkivZAy8vHp+8K7Um26GAxu/l7QEtqH2ogeAPyc9feU=;
        b=HEPP92ChPg4pOcong9yW0dsFZyHT0Pau2psj7nyeyyH7dnFsQGY4Y0h8klNpaIPMFr
         uB1oCbuOnyZ/QQu4ltfgALX6pNC/G7Sh7z4twNAlZx5wIuoBbSrdqdKIvmQhq9z2R/MR
         +FdaocwAISbH14MZQHBHxIID+chGKo2W6UFwVVXucOu/C0yWXPd6Tj7d5i2BiTvRC4KB
         IoZDWRlpLYoB0ofPYmPPsq1I4GdWCbBCjy6ks9KT9nC/gLQLaIxMvfJ8GIC4L6GNC5fe
         SLIDs3RhnrOGijK63uTkIC1GZDTBu8UFn+Chy0WQaEBxiXSZnTzCpUSL5RZMFni0CcYG
         h9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712867051; x=1713471851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkivZAy8vHp+8K7Um26GAxu/l7QEtqH2ogeAPyc9feU=;
        b=b92BSNOYRVVdgH4GCxaYFqtZSHsZW520h9db37TfGkcPJwNjeRauGB5qRbW+t5ianS
         MA5UkdeSk+JXgidoBj538h0qeWgq/+aojAvs61LSEupo22s6c2T0eJcerLILNWiNY7Fx
         L90D8f8nF44ZfXEPbFu+Ecwj0IhlLhNHjHmzcK1Ey30bUzxkaoosZDoWpY031hSgSLeM
         oJX1Y+I89ENi1YwctpfgBbTWWWHtWr6ZOjhyWyYzCTa7cLJJwqloW9Nl7LexPBfrOiaa
         4GfnTulFgb/2vom1Tl628Dgf7KGWRrSGJxfKFGB+ne2E68vspWiZa+LiCVmZIZbY8R+t
         q9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVWyPoUweGD/hQ7plWrNCwreygWwnFthPP2A9XFcRCyaRgz5GBGQpzPLBRD4H0X2lIalQQm+iqW/dw2/Vz5zqMCVIpEGv91oi08hWmJ
X-Gm-Message-State: AOJu0YxpIzoRymFWUlN29PI69w2LsRcugG8WbqzZZCnlKKbmqqEefpTG
	KKCJz+fN9TKaNKRRSj+XlTzhJOMYA4bJEmHBARL+FloqXj3KYa/XBE22F3ug7Ic=
X-Google-Smtp-Source: AGHT+IFmKV1cZUNf2RDPXfgrp5jM/80Z18N3yhtpLtRxKHZ1VDKWNvDrx521CSjJRJIGHFCmxXfoWA==
X-Received: by 2002:a2e:7d15:0:b0:2d4:49d1:38e with SMTP id y21-20020a2e7d15000000b002d449d1038emr508466ljc.28.1712867050958;
        Thu, 11 Apr 2024 13:24:10 -0700 (PDT)
Received: from [172.30.204.35] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f24-20020a2e6a18000000b002d4295d8563sm291115ljc.62.2024.04.11.13.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 13:24:10 -0700 (PDT)
Message-ID: <bbec514f-9672-4e5a-bd83-20ab59b3dcd9@linaro.org>
Date: Thu, 11 Apr 2024 22:24:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] soc: qcom: Move some socinfo defines to the header,
 expand them
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-1-ce2b864251b1@linaro.org>
 <20240410132510649-0700.eberman@hu-eberman-lv.qualcomm.com>
 <2c2bca6c-b429-4cef-b63a-ee3bd6c9eecb@linaro.org>
 <20240411130802689-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240411130802689-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/11/24 22:09, Elliot Berman wrote:
> On Thu, Apr 11, 2024 at 10:05:30PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 4/11/24 20:55, Elliot Berman wrote:
>>> On Fri, Apr 05, 2024 at 10:41:29AM +0200, Konrad Dybcio wrote:
>>>> In preparation for parsing the chip "feature code" (FC) and "product
>>>> code" (PC) (essentially the parameters that let us conclusively
>>>> characterize the sillicon we're running on, including various speed
>>>> bins), move the socinfo version defines to the public header and
>>>> include some more FC/PC defines.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---

[...]

> 
> 0xf is the last one.

One more question, are the "internal/external feature codes" referring to
internality/externality of the chips (i.e. "are they QC-lab-only engineering
samples), or what else does that represent?

Konrad

