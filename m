Return-Path: <linux-kernel+bounces-5140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C778186FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F951F24060
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924CB168C9;
	Tue, 19 Dec 2023 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n9qVQMNn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72358171A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33664b6d6abso2277249f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702987548; x=1703592348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3YR050jxxqtUei61l45Oklud07svtS5N+6+fAR6YhA=;
        b=n9qVQMNnxEkO2UUmM56BYSv7X1Wdp/D/IGM/PNBB74BGymPdxPZtGIfaL9n1DFPZ+Z
         +4q8cwwJclgFD0bTxU7SDl/k6yrDx69seslcN4fgeRPFgnWSJwDlkC4wV2k6SLFGle4g
         wXh5VPrEw6em/8oJqO2i3XREsc9g6JYbEfZIX5tR9oku6hKJFNZsQSMO4MmEfm6EK1IR
         gcmFzEHB8hEpISqCWq+2HJ6DLRfd/mqg/FcaXRAFXlv6tMCPDhlpnD2GLn8Gookh2H2Z
         Du5z+kWjKhdhJCsTelK0hyFn/AP+NVRln8fYVXH3J9IjK84kNvJTRCu5gCd5Jqq2+OMI
         LacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702987548; x=1703592348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3YR050jxxqtUei61l45Oklud07svtS5N+6+fAR6YhA=;
        b=jzn0jHJ3uBmndbCpsMkIuJeuth55F4sve+gpdffuPUZgfar7sOdT70c4qAZ0SkIb/8
         /C3kqr+XtDNEEQ254cN5THW8wKvL+gsdLiHOSMk2zGT48PSkSOwez4CWNUJprpnEPYhN
         nwiFxpTPh9sq0Cnaw0RBIOjwnyjaKycqL0fDYuHgGHrNA5e5yaVoe6p8h1TDSPTwLTxu
         RgZHH1QcHxN1NDUTv8jV60LYj/9iQi+Mu8jsSm189GzWn4YL4CCm0zesQjXqXS+YEBmN
         RRprtIM/lVSbqWa3nesSrkS0jSQSmYhhmWl2hSv/lxA/kCC3uPKyM832xEYFelkuD3ra
         zteg==
X-Gm-Message-State: AOJu0YwZSIHZtwcP1areKBmIn+HXEcppjtcft1V2Lmy8N2P0GhKKajv/
	g1wCqvl4RIPuC2g3ymtahQ19sA==
X-Google-Smtp-Source: AGHT+IF5d2kbKxQ7jOydN8S3q0DvtY7+5q+/TZGiKHZOcdhuKnEn8CMYBJrqz1/C8FrBWWz+Kpwutw==
X-Received: by 2002:adf:ee8b:0:b0:336:66f7:2d39 with SMTP id b11-20020adfee8b000000b0033666f72d39mr1859810wro.11.1702987547704;
        Tue, 19 Dec 2023 04:05:47 -0800 (PST)
Received: from [192.168.10.46] ([37.167.119.56])
        by smtp.googlemail.com with ESMTPSA id v30-20020adfa1de000000b003366cb73f74sm3811062wrv.66.2023.12.19.04.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:05:47 -0800 (PST)
Message-ID: <f2f31c85-70e4-4a2b-b791-73433cdaf881@linaro.org>
Date: Tue, 19 Dec 2023 13:05:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: Print out thermal zone name on
 update_temperature error
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20231218-topic-thermaldbg-v1-1-451bcb723e1d@linaro.org>
 <CAJZ5v0gkko7nWH2ePwEhbfXR-jAb9+f+rsfYXKBMSz04uW4rYg@mail.gmail.com>
 <1e151dcf-d4fc-4aec-9f68-c8ef372a00f2@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1e151dcf-d4fc-4aec-9f68-c8ef372a00f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Konrad,

[Cc: Angelo]

On 19/12/2023 12:48, Konrad Dybcio wrote:
> On 18.12.2023 20:40, Rafael J. Wysocki wrote:
>> On Mon, Dec 18, 2023 at 3:40 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>
>>> Currently, we can encounter an error like this:
>>>
>>>    thermal thermal_zone48: failed to read out thermal zone (-19)
>>>
>>> It's good to know that there's been an issue, but on some occasions
>>> (like the error happening in the middle of a platform crash), one may
>>> not be able to look up what kind of thermal zone that is.
>>>
>>> Add the TZ name to the error message in order to speed up debugging.
>>
>> s/name/type/ ?  It looks like that's what you mean.
>>
>> First, the tz type is not its name (because there may be multiple
>> zones of the same type) and it would be consistent with the first
>> paragraph above.
> That's possible, I'm no expert wrt thermal :)
> 
> Would you be okay with this change, together with an amended commit
> message?

Angelo is looking for how to sort out the name vs type confusion [1].

May be you should wait he comes with a proposal before updating the message?

[1] 
https://lore.kernel.org/all/3428b2af-5522-4090-995a-10eaee90c28e@linaro.org/

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


