Return-Path: <linux-kernel+bounces-141737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E08A22CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684631C21FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9881373;
	Fri, 12 Apr 2024 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T93DSPFq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E921361
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880639; cv=none; b=hzsc50X1i8HDB3qWW861IaxkrYwoda0QoRkB8GhYHcWchYY2nH85hpMEl8aiFPcR3DFqItY/f1FWk9uZqIzW8I3T1DBwbqvWpaKaoTvY62iSijWhc8KjFJKifwEGoFnDWLQKqUyVfT/HU9WfRSGSrZKUq9guRnZ/doAEPW15h+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880639; c=relaxed/simple;
	bh=sQTNnIYHgfKGUn3VmqYNRjZP61Vv3s3ZfEeOIWFjfQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBd5FCGXSmIT7UK8oD/+u/ojaxxm9rp0l4avgjRKD1XVwKxQL4pgpWiSE20F2d2NfJK42oJdb2f3oj9DeeKvoUDFxFXAffhEzSxS2MbhXOrtNaaclCkzImW7Nw/YZA3QVWYA9tW5Yee21J/WrquGL8znLOWEy1x8hmzVSfmNE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T93DSPFq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d487659bso489407e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712880634; x=1713485434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWeAeryC+HSBQqc05Jp0Ysdkpvfyotn0oaGu/IDriio=;
        b=T93DSPFqVQeokljdRYFMUv4jRvcYYhfecIuL5x9BQerhP3wIE1eHaMjVzCfInkz2Uj
         /Uusvkxu4lNtCNtPDb/yZ6qu+HvPH8lfdZ+44AXIJwk43ZJNYCmy+woij515sE5hOx2c
         eINbenHHqupvbTR86Y4FbdJ0zbIgM5ltgZ1aLPXMnWjGZj2lEKPZJQ38AWD0YCQKJ4W/
         +TnGfvzITFBcLuU9GK73d7c88cflCu6Hr3DKKs6ETrFrpOjPBOKN1LV8u51lYYX7ksUO
         kww5s+UMiObg07wxW8VOtWdIkTzuHu8g483rPoJQpU1/V/EIMq8t8m+hJ6L2wl0tBxyB
         Wtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712880634; x=1713485434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWeAeryC+HSBQqc05Jp0Ysdkpvfyotn0oaGu/IDriio=;
        b=MHvu+wKiJ+AnUunq0YV+miRZMWsBpMUk3i5/2dVb2OO3bPBLBSKuac3TQ+NMtID1NS
         OAOpPL1MP1XgxRFFFhk+C74xCpQC50VUjuzBy3gmTpjTQlLyCgZji4d5dPBbmvMOEWI7
         SCSKGrUYCRWmGW+1BMjVi399WmI0coKPxzw2lkWMri2poQEiyA6ek2NWpNxgIyu8hEJF
         YcnLTZvL89A9l5hASiNaZvRFe4pav6Ef9SG1KMSDFJHKVlmiZ/1+ZbFq3Eb8Zw0O78VO
         QrMMCOrJOU2rao/HH7ePgWYBMu1qUDn09IzqeLvfTNUiFD5T+BhKf4CbdLxnZ+CWaCBg
         7WDg==
X-Forwarded-Encrypted: i=1; AJvYcCVxU0XNELOZdQN7/SY0/VZ6LjmVnTpc2dKzWunfNULMNyFkkWjSerMdJ4YHWS8t3srSw3aJ4RZmoW498+D0VcsXK86hIDibeSnuMbeq
X-Gm-Message-State: AOJu0YwmaHJ6roA8imf2RgQNt8QDSHObksvYcX1NOM+s9kADkfIWSnPl
	WlX7akdsyf2Kt+2IDvYOP3PD+vGh/CmBgwcydaOkJ6qePORdDsa+b3G80Ue59vI=
X-Google-Smtp-Source: AGHT+IFXAtUviYLODojZB8y1DGATalo/JeZWCLCv1nVOL1U9loFS9KRzrRPuGc6MkUfK7tlXBtUy6g==
X-Received: by 2002:a05:651c:1543:b0:2d4:6c52:23d5 with SMTP id y3-20020a05651c154300b002d46c5223d5mr620714ljp.50.1712880634395;
        Thu, 11 Apr 2024 17:10:34 -0700 (PDT)
Received: from [172.30.204.35] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e6a0f000000b002d868f2939bsm331735ljc.103.2024.04.11.17.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 17:10:34 -0700 (PDT)
Message-ID: <7634a8ba-e783-46ce-be91-779cd603bd3b@linaro.org>
Date: Fri, 12 Apr 2024 02:10:30 +0200
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
 <bbec514f-9672-4e5a-bd83-20ab59b3dcd9@linaro.org>
 <20240411162849104-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240411162849104-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/12/24 01:49, Elliot Berman wrote:
> On Thu, Apr 11, 2024 at 10:24:08PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 4/11/24 22:09, Elliot Berman wrote:
>>> On Thu, Apr 11, 2024 at 10:05:30PM +0200, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 4/11/24 20:55, Elliot Berman wrote:
>>>>> On Fri, Apr 05, 2024 at 10:41:29AM +0200, Konrad Dybcio wrote:
>>>>>> In preparation for parsing the chip "feature code" (FC) and "product
>>>>>> code" (PC) (essentially the parameters that let us conclusively
>>>>>> characterize the sillicon we're running on, including various speed
>>>>>> bins), move the socinfo version defines to the public header and
>>>>>> include some more FC/PC defines.
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> ---
>>
>> [...]
>>
>>>
>>> 0xf is the last one.
>>
>> One more question, are the "internal/external feature codes" referring to
>> internality/externality of the chips (i.e. "are they QC-lab-only engineering
>> samples), or what else does that represent?
> 
> Yes, QC-lab-only engineering samples is the right interpretation of
> these feature codes.

Do you think it would be beneficial to keep the logic for these ESes in
the upstream GPU driver? Otherwise, I can yank out half of the added lines.

Konrad

