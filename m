Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FD67AA317
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjIUVqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjIUVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:46:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8449566E6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:27:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so7973175e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695317230; x=1695922030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwmvG5vLsSx5qVJpIDAQauKd5SFkomPYwP2Gxr7JRg4=;
        b=gSVMNjJRXZ/EmuC2kgnI3jWjP6kcO7FB7Cejq/hIIFRG4jxbM1nKE/16O9uOS7xpAV
         5Y9a6ddiQgb03assn8G2TGfvsLR6g5WUsbX6fobYJALWGLm9QTJbM679b0fA+Xtp/MQ4
         jrKsG/IsptJZ/mTnemrtUYTElFkf+5qyGEhgLHqiSTMw8QOorhWP81fXcrJangT45TuA
         RUxX+gPhbpvD5UUgWBC1wQMvz3/KVNQf25A5B0sdjKOPJcNHrPexIxzMGZzPPL2h9B8Q
         Jx7KTej6c8PWMsx8UommQSbhqGdoUo/eL4uGbhP896v2iz6AQ6wHN9d4Vp8qOZzNisIk
         hOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317230; x=1695922030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwmvG5vLsSx5qVJpIDAQauKd5SFkomPYwP2Gxr7JRg4=;
        b=ac8lyQJfGc/98w8JzxnBiW4WidwzQmfQ3noWGT53Tb70BL/eTB0sVN3Re7YwgTEzFu
         mT6/ZX/3bwfVEhBvCvSflXJ2Q1812v/3ezXAQNQlVOXvIh6A6nJdEe9Yl4sP3HSipCua
         mhRC69jVsfQJbl/bLnL4YydLmBN9C5ldz41gdEQbeieUVJl1p6OcTYZCikbNc0H0dHic
         M66bivFQIyDTE4uYy3qYfvcFZXChSV1jYjDAA6RCxRklkdtz0XM9TkEcrX7b3Ispre3M
         1VFkkBth9CbqNh/OlA2Vn84at+C4q28xRaF8jm4fyuZZ+Ret4ROKNp+s6DF4yOk6acnC
         P5sQ==
X-Gm-Message-State: AOJu0YwNnyCFcNOIC9m9m+QRNiv+ecf6uoXZaB2uPwt+sJAGYmxtgUSq
        nowpYnp79n1Lppr3T/FybYP4bmiMIa6cs5thF3yj3KoF
X-Google-Smtp-Source: AGHT+IFhVm19T+LegUcKx3F6tIXfI3FFKdbMKTy0n/7EXfRWUf6QpqiIp9wLl2V2H4TrPU4Mt8A7rQ==
X-Received: by 2002:a2e:b608:0:b0:2bc:b54b:c03f with SMTP id r8-20020a2eb608000000b002bcb54bc03fmr4204197ljn.5.1695279878602;
        Thu, 21 Sep 2023 00:04:38 -0700 (PDT)
Received: from [172.20.15.189] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id b18-20020a170906039200b009ae5674825asm590222eja.47.2023.09.21.00.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:04:38 -0700 (PDT)
Message-ID: <ce67c10d-a589-dc2e-76cf-fb5cfaa48c66@linaro.org>
Date:   Thu, 21 Sep 2023 09:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] drm/msm/dpu: Add missing DPU_DSC_OUTPUT_CTRL to
 SC7280
Content-Language: en-US
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230921-topic-7280_dpu-v1-0-6912a97183d5@linaro.org>
 <20230921-topic-7280_dpu-v1-2-6912a97183d5@linaro.org>
 <444d125c-2a87-3bae-6ea0-b76dffeb63ef@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <444d125c-2a87-3bae-6ea0-b76dffeb63ef@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/23 02:01, Abhinav Kumar wrote:
> 
> 
> On 9/20/2023 3:46 PM, Konrad Dybcio wrote:
>> DPU_DSC_OUTPUT_CTRL should be enabled for all platforms with a CTL
>> CFG 1.0.0. SC7280 is one of them. Add it.
>>
> 
> sc7280 and all other chipsets using DSC 1.2 use dpu_hw_dsc_init_1_2 and 
> not dpu_hw_dsc_init.
> 
> dpu_hw_dsc_init_1_2 assigns the dsc_bind_pingpong_blk op by default.
> 
> So this change is not needed.
Gah, I don't like that we do it behind the scenes but I agree it's a NOP..

Konrad
