Return-Path: <linux-kernel+bounces-5105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5D081869E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252FD284FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A306015E95;
	Tue, 19 Dec 2023 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VITvBIzY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C56171BF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5532b45c286so3429741a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702986527; x=1703591327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ihBuGoZ+1c73Nfos1FB6nej7cYQmBATwWMmsTrg8PFA=;
        b=VITvBIzYLEXLngF9VfQ3woafFKRO/6pBf2VDg9/0d6oi94iY9yOBnov7EGsmqfyM5K
         +Fi6b2G+t6uo1aLBEOE1T0PTKO6j5QsyReAG7boQMgFemt0H6w4UxkbAgqGYc0ODfg1V
         1NN5Vez+dF4IqoBgw0X98q22EKo7XZFhkqYpnkBAMhq+IrYysG4tpyHszOLRHuObNC21
         bvP74YYxTBp31WN2X3Bk+sw3ofpTvrjd8eTxSvKCDgztu+MlcEANiO11G/LlkRIBOs3j
         vyghWr8pS3pxCFBivvEwrK+hK0I6D8eupTW8eJRWxdq5Q7kCWcbMeWakrJH3uFTm79Hn
         k4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702986527; x=1703591327;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihBuGoZ+1c73Nfos1FB6nej7cYQmBATwWMmsTrg8PFA=;
        b=CeThh/4WytGMrw5++BGJ9RMH/dc7M5gyl1KDkcRltJY8p1FqjnTfr8F4YL1cicgk0V
         hiK7+2SY1vDgIUUTRPSsvVKZMxphTQe+uMQwH1iKWWLmtiUM8nnX5qR3TEnI44oySR78
         jqOt+zPUrwcktfD/W0GNrlhbL78xxqu/2kd1PxU1GT9pGCFiTfTtgEnYlLG3UJadrau1
         FBkmjsORy7t/73yURNUFVda+JqeU0gZYf7YbOhapOmxNWWIvpVpj28+Aw80EhllpbT++
         0xwuDuaSmRzNThbYXo8Y+xVyLzdiWqOud6i+/MjHIDXcyyQ78q40BW8xK/ANiqSuPqd6
         4Iow==
X-Gm-Message-State: AOJu0Yyr/MhIw9Deg14y5cvEM/kEWzdHwb003ihTPAlxO+U3rkV/yme9
	ex7maPD0/NtYb4EuHLgM8hv3kg==
X-Google-Smtp-Source: AGHT+IG89ZtgUTw/LZK4GkiM0IqfWvz72Fos1zNlBWjwTIvFNbawUHVvMSrHDpX1L9W/mpK7g06sKQ==
X-Received: by 2002:a50:c109:0:b0:553:9a7f:aefa with SMTP id l9-20020a50c109000000b005539a7faefamr198446edf.129.1702986526784;
        Tue, 19 Dec 2023 03:48:46 -0800 (PST)
Received: from [192.168.199.59] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id q24-20020a056402041800b00553165eb4f7sm2966501edv.17.2023.12.19.03.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 03:48:46 -0800 (PST)
Message-ID: <1e151dcf-d4fc-4aec-9f68-c8ef372a00f2@linaro.org>
Date: Tue, 19 Dec 2023 12:48:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: Print out thermal zone name on
 update_temperature error
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20231218-topic-thermaldbg-v1-1-451bcb723e1d@linaro.org>
 <CAJZ5v0gkko7nWH2ePwEhbfXR-jAb9+f+rsfYXKBMSz04uW4rYg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAJZ5v0gkko7nWH2ePwEhbfXR-jAb9+f+rsfYXKBMSz04uW4rYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18.12.2023 20:40, Rafael J. Wysocki wrote:
> On Mon, Dec 18, 2023 at 3:40 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Currently, we can encounter an error like this:
>>
>>   thermal thermal_zone48: failed to read out thermal zone (-19)
>>
>> It's good to know that there's been an issue, but on some occasions
>> (like the error happening in the middle of a platform crash), one may
>> not be able to look up what kind of thermal zone that is.
>>
>> Add the TZ name to the error message in order to speed up debugging.
> 
> s/name/type/ ?  It looks like that's what you mean.
> 
> First, the tz type is not its name (because there may be multiple
> zones of the same type) and it would be consistent with the first
> paragraph above.
That's possible, I'm no expert wrt thermal :)

Would you be okay with this change, together with an amended commit
message?

Konrad

