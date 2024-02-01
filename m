Return-Path: <linux-kernel+bounces-48819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF73A846203
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6584628A322
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F43A8E4;
	Thu,  1 Feb 2024 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A9iE2ygj"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63A2B9C2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819952; cv=none; b=U7nluZQHkSRGgTvmC2mr/v2hZ8nCjvarPGXpOS5Fb8FoCEUx9YPCY6r96Fc2mAuC5DPQVVgkdstABi0szpdO3x4pK1qneBqN3siET1fUqwohp2iALZyT8FVluWT4w+mqLQl6C+Y/QoeEaHqmVaJX/PweXoMP2IkDjgx4ltb2KGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819952; c=relaxed/simple;
	bh=+DHBCFZYgh7WBnVrdonCpXXy2S80iyiLUobKfL9zE84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAJNqRylwiCun99OaKvNUgBkJM0uGFBL1AyT9S8rmBU3z6bn8RVD5fUDG8CkcRFzvtLsWwEgisNPttCM46JO0Zp84CrF+3mH6b2breHigkcdO6HVB8XwUwn1ErAmJjo9yR+/pkTJsXbgQigh+UHW7P4ZrX+M/kd/v1/otysOXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A9iE2ygj; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51025cafb51so2195616e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706819948; x=1707424748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9YFKFaHM7YsZHDCZN3lYx4blhCBTgQmFl612USwy9w=;
        b=A9iE2ygjAVk9evM1gaOoWp7OPVqm3AHsKi/8NKDF0mQICHChPztE3YF4nEctlYjgod
         G3WpN1irF4jyH9GOe+3/rz1RmFaX5yoBdYcou96+hfCN1gxG1ZOpQdm0Ldne+lf2AzWN
         R498Akf1SW/+Y5W2f4gw4f7azQVoSPOmvZ/no7kSE6DnaCAvbzOGhQxMDyyLYqxLQNT8
         jKboJ9ZFsabIn3T1cLgNLCABa39gW3smbiyYXpUWrfMbooHvhYrH5pJYnILNXkVmRnnu
         5zYPIoj5zY1D8UJVupnhtCpmvRzF5MJ85Y9r6C0GDNg00WoIujxyqfT9wQ7xJSn9RrAm
         ks4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706819948; x=1707424748;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9YFKFaHM7YsZHDCZN3lYx4blhCBTgQmFl612USwy9w=;
        b=JLmQxQuMGmc8+0hZca0/e6PZ0hnk0aS3S5hMxKO1VCrJkn5w1uWCVe37y+wPdG2Hqj
         Yj9ztcaLwao7JIadX6JSnBPecb3bEUGab74t8gHovnwH0jm4ZqMCDusYR0GqAndsp9+A
         nT8qeEGdY0ssmclVRK4idrA2G7mAaVGU+rg8Pqs0OYZ1fQ//Qogi3opNQ4mAJzo0yhYL
         bB7EJdF7fx4jS+WABIxhxxkGqY/uNxf8Tpsrfga8NaMWGRGD+3QjIHzEqZho/T/gsYRH
         Y9APHfphy5oEDOEnmRvsuI3jtvvWAXz79Ez/SrGFoYnK8rMDBPi0ZZW04Gph/2Fb9D9H
         7SCg==
X-Gm-Message-State: AOJu0YyXlZAakCZvdat+3qyzyfw1HHfp4Pkpj49PISu8Ul1bS1jqbmar
	jtCCC3j3LA64V1nYX8lglW80HwpdudrEIfnQpuSjb/gzcMa3K6urpDAESON2OEs=
X-Google-Smtp-Source: AGHT+IFyjvhbNZIbd/4txylH1j8mJ2YdMR8JU4sJ4+BFPgD9TuJ8ij3WYUxdzQG6ETBYZ7wzx0rRDg==
X-Received: by 2002:a05:6512:2023:b0:511:15ff:5628 with SMTP id s3-20020a056512202300b0051115ff5628mr52039lfs.22.1706819947629;
        Thu, 01 Feb 2024 12:39:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVA/aQBbzvCSoBXiOpEYwvTJ26qIvIpuZ83FxRp6iyIM0JFPIWajvSqx9A8+v6zcBzWXsM/mN/MrizGnoH3rMfWDwkNRKnDb7EyOUduFuLDOn8IeYcurUomIwQLcRhWy42GyKOKQ8RCp2vT0OX8b/OpuATqmaPYdcOLy66h3sN4IO5vJGQT8BRRnB5njxkOJeOPGVSBWya+tKwKl81na0lrkAgoRsdPG/NeV/VnUn8NNJQGx20/VVneYXjaM78NCPjWK3k0C6htCwHUSGRTq3DM7C6Jj+p4/ENEIWprhUDBGdD349ZPuKMm36eY6RcxicmUEpuHPxlMuDXmbtA2zniE+O6K/DU8BPc9RBaI7W1/D8Zhbq4DMilSsT4l3HJEyuHb/ushhS4ipzulyl7RiM3L5ndFWWI=
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906069300b00a35becf3f0csm145526ejb.85.2024.02.01.12.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 12:39:06 -0800 (PST)
Message-ID: <dee1e1fb-107e-4e74-bd0d-762618ec2192@linaro.org>
Date: Thu, 1 Feb 2024 21:39:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: Add dma-coherent property
Content-Language: en-US
To: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: quic_kuiw@quicinc.com, quic_ekangupt@quicinc.com, kernel@quicinc.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240125102413.3016-1-quic_lxu5@quicinc.com>
 <20240125102413.3016-2-quic_lxu5@quicinc.com>
 <918d1d55-e95a-4b00-af59-7b5d7057b9fb@linaro.org>
 <05a5402e-9c9e-4dbe-88a6-f990c5c2fbf0@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <05a5402e-9c9e-4dbe-88a6-f990c5c2fbf0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26.01.2024 03:34, Ling Xu wrote:
> 在 2024/1/26 0:38, Konrad Dybcio 写道:
>>
>>
>> On 1/25/24 11:24, Ling Xu wrote:
>>> Add dma-coherent property to fastRPC context bank nodes to pass dma
>>> sequence test in fastrpc sanity test, ensure that data integrity is
>>> maintained during DMA operations.
>>>
>>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>>> ---
>>
>> How can we replicate this validation?
>>
>> Konrad
> 
> Without this change, case8 and case14 about DMA sequence test in fastRPC sanity test can not pass.
> 
> The steps to do fastRPC sanity test is:
> 1.download code
> p4 login
> export PATH="$PATH:/prj/qct/asw/qctss/linux/bin/vce"
> vce.py view --base fastrpctest.common.1.0 --checkout=<username> --root .

I'm assuming it's not this one.. https://pypi.org/project/vce/


> 2.compile command
> chmod -R 777 ./fastrpc_tests && python3 ./fastrpc_tests/build_fastrpc_test.py -target=LE
> 3.run fastRPC test
> fastrpc_tests_ReleaseG_push_LE.bat
> adb shell fastrpc_tests -e (case number) -d 3
> 

I see, however there has been some talks about halting fastrpc developments
until an open source userspace counterpart is ready, as upstream outright
rejects binary glue..

That said, I am not sure whether I'd be against fixing up the devicetree
component..

Konrad

