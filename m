Return-Path: <linux-kernel+bounces-119999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807EB88CFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48D11C655C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482EE13D632;
	Tue, 26 Mar 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZHZNtBu"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC313D2B6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488205; cv=none; b=XYMVH+Oprrpvh89eB01toBcZtzxOD15wPIwGPcVpC4Du2Jg5C3BeYj0wtBetT9PE818VTYiuPhPqrIiaFhfcHiHz9M4ns17/0xjJVZlpg2LHIoyRWI0xTrNa/mN/HHDhTif05r0/P3MNlZlP+hvRRc7VVYzaTQH1bYbm6mHa8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488205; c=relaxed/simple;
	bh=KB3fBfKAsAsVahX2Imwy63fUY9kwoiUJhzg1hqHbxNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFj5mUDDpcbIqJ2RScAGYnMWxdihgRdxYZIbbOWlmZEOn9TrgrfL5kN2kt+cIPaYQRIVCtiDtxLYLOcKPjXCOCNAJDE5PKS4TwAz5d7NcdZ7Lk3u/yO2PCGgMIasal1qwiPvlp3kmx80KrU2x87CysM+7OB6y3dM8hNxNxNz9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TZHZNtBu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so25365101fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711488202; x=1712093002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aUA1eKIjstzPMAQh15tq67r3z7acaeD1KAeNR4PnxL4=;
        b=TZHZNtBuLJTiLGqG3Cz+jsO2Co6J/qYZUHJh69HsNw1Xtq+qRUmZ1+WYwDHtx4CTyq
         NENS6IQ6rnVXCKdfZRWvXnGSYT8SSOpXAjFXC6dSIXNC681mKJPAQhNQtLWnjGA85EHq
         1UHiPkCeKqh7Ky3OE9JggYbFwe3jsk/OczqhQP03OVSazZAFfFwuad5Qw0F1IOsKhf82
         pGfh+zIiS94qSF5TjGBU/2cWDnpWg5Ewi/vW+JmsDwu9GyFrc8knkJsBZV6gN26y6yHl
         /24zuwRyAKTM5DLHnj5SvXeYLqhOg4R0Nvu1Zb4QUsERdNSRBsfJTLH2bvx12X3abYJx
         SYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711488202; x=1712093002;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUA1eKIjstzPMAQh15tq67r3z7acaeD1KAeNR4PnxL4=;
        b=ar91yYpuO9Ybh8Yff/YWNH3EXV+vCLkwrF2RJl32RAY/+z59xC1W5x00b1lSLtrAJy
         9ORRfkkdVdmz/RkhY7NDFnkXeBgseXZhGMgn+Up6F+2Ny84w02x1oT/aszGXDdZanyvY
         l8fenvKGecPLOaAhZyQrlFpq/WEFgbdIWbpOvnRxFi+kVDP0SQJg9QzOi5XwrodfIU9s
         lskZz+Q19e9iPINHp5MEqOmn3NuDgcriSbVfx6CvqQjgHxggKQw9aEiDuZL3fUXTXoeN
         uXH4bp0j7gFVJRcMNtMUmhuk12OSFfYBN4KkfMGRZBDmyce4h06nvtGEaHENjcZEpa4I
         WBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUApJPOvmdT5U5UPXPr63Sh40rq/OVK1rjumgUP/T86oFBK5YYaKVfcq2GgxNejB++fOj+U3dFpFrz445jle3NKzX2Ck3zi71hOfWnG
X-Gm-Message-State: AOJu0YytJd5WsBNfSa5iqYBXqMWAPsH+Say1XFzcs7eOKQ+APDLVBXqO
	CvJXVZowD7H25JPbnTRbNspmOBErjMLPqAA+u7edss5/WazctobinzgwlwvokSs=
X-Google-Smtp-Source: AGHT+IF0AgRSqTva0bG8hoc/EnLu0gzYyV20H+4JEOL9JUGZpUWDSMN6vPuZ9jhSy3BqEksd4kPafw==
X-Received: by 2002:a2e:998a:0:b0:2d4:96ae:2d9d with SMTP id w10-20020a2e998a000000b002d496ae2d9dmr2971574lji.33.1711488201897;
        Tue, 26 Mar 2024 14:23:21 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id p29-20020a056402501d00b0056c051e59bfsm3660362eda.9.2024.03.26.14.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 14:23:21 -0700 (PDT)
Message-ID: <30945f7a-b18b-483a-bc43-99f913fb98c3@linaro.org>
Date: Tue, 26 Mar 2024 22:23:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/20] media: venus: pm_helpers: Add kerneldoc to
 venus_clks_get()
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-3-3dac84b88c4b@linaro.org>
 <b6d6beab-39f5-4f00-8427-52b662181864@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <b6d6beab-39f5-4f00-8427-52b662181864@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6.03.2024 1:20 PM, Bryan O'Donoghue wrote:
> On 09/02/2024 21:09, Konrad Dybcio wrote:
>> To make it easier to understand the various clock requirements within
>> this driver, add kerneldoc to venus_clk_get() explaining the fluff.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/pm_helpers.c | 28 ++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>> index ac7c83404c6e..ea0a7d4601e2 100644
>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>> @@ -23,6 +23,34 @@
>>     static bool legacy_binding;
>>   +/**
>> + * venus_clks_get() - Get Venus clocks that are not bound to a vcodec
> 
> Get non-codec Venus clocks.

No, this is not necessarily the case.. these may still include
vcodec clocks, that are specified under the root venus node (which
is the only way we'd like to keep)

I applied the rest of your suggestions, do I keep your rb?

Konrad

