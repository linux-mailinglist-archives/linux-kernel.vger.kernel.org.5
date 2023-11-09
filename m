Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE93D7E7246
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbjKITYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjKITYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:24:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7043C1D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:24:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-407da05f05aso8289765e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699557884; x=1700162684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1CJqeZ8u7eaD4Q/icHyhIHN2vLT3h3xpvRo3vUPhJI=;
        b=U7WLsYJFwFsCsJMq5C4u34AUFHM4ajgWIHUo1upHZTe3crLKA4SIwekPvzJJSWtPSN
         HIQT9EQNuLHLpmpU/JBUUtRyNPIqkU8NTzXTdDDUBbhG/DDkEibMfNGnmmmjT2aCO/kI
         UW61bP426YTlKNwgywHex1V+QtFhfvUPAnPssoOopRumx6phBa9+DzmeXQ+wx/a0kVrx
         K6+un3WZfZLz6t0v/5m3T9QsE2mXcUcIEQaBO0QTj+2FaVINQXtYyCvl/g10Nj8oEwog
         s0p4xM/bFSJYNBGwU+Pj4hz/0BqNVEufFJ0aQl8vLEp4Byics5+/161odwkMh/21N2UW
         3BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699557884; x=1700162684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1CJqeZ8u7eaD4Q/icHyhIHN2vLT3h3xpvRo3vUPhJI=;
        b=QEM012OIqJDIRv39u5QIWvtjZy8vEt5vAaCMEkvS0NpV7Wn6eT9s48U24nT6oRkXfc
         nOV1qvmlR7lMVXdVx1+i09cnEjP/9HmKEEdAq8fw/t0sqUEsh9yH6PgD+ZkVH0JXpsYN
         Se/Ck2goKKmrVN20Ivw/yJ7qv+Uyffs7f9IBpH36VPSyVfMFWmWK0B99IeSTZG2SihqB
         jES6//M+bi2ab5VFn0CLmBI6swR3dlZYwvpMPZ83IqitfvMm30b40Yf2YK0nme9XSzzA
         4/lLqsjvPi0z+hb0DUl+JUVk6AVc5Z3BNnemaTTT04bGvKi8F0HdtGM1C309gyyLKbG4
         SnmA==
X-Gm-Message-State: AOJu0YzIGTmMM6N+cOs06ANqVKPAt4De2TGJNsfO2QNt3ocAgSV+wvQ5
        X2kDcsiaLhG6AwZaMzlNLuTvOw==
X-Google-Smtp-Source: AGHT+IF/BLKulO6qnWwr/aMbGCtJwiiTSp3nZlhJ8ghABo6m4xXeqoIy0WP2LNWq5jaUk7wkGbi3dg==
X-Received: by 2002:a05:600c:450d:b0:402:f55c:faee with SMTP id t13-20020a05600c450d00b00402f55cfaeemr5287667wmo.26.1699557883893;
        Thu, 09 Nov 2023 11:24:43 -0800 (PST)
Received: from [10.66.66.2] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c430800b00405d9a950a2sm2903833wme.28.2023.11.09.11.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 11:24:43 -0800 (PST)
Message-ID: <4f56327d-abe1-44fa-8979-17edf86cd406@linaro.org>
Date:   Thu, 9 Nov 2023 20:24:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] media: qcom: camss: csiphy-3ph: Add Gen2 v1.1
 two-phase MIPI CSI-2 DPHY init
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231109-b4-camss-sc8280xp-v4-0-58a58bc200f9@linaro.org>
 <20231109-b4-camss-sc8280xp-v4-3-58a58bc200f9@linaro.org>
 <0e325a57-f07d-47e6-8456-523cfa04c52b@linaro.org>
 <1e99ddcc-db3b-4a79-a2d1-815bebb5a5c9@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1e99ddcc-db3b-4a79-a2d1-815bebb5a5c9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/23 18:11, Bryan O'Donoghue wrote:
> On 09/11/2023 13:55, Konrad Dybcio wrote:
>>
>>
>> On 11/9/23 12:30, Bryan O'Donoghue wrote:
>>> Add a PHY configuration sequence for the sc8280xp which uses a Qualcomm
>>> Gen 2 version 1.1 CSI-2 PHY.
>>>
>>> The PHY can be configured as two phase or three phase in C-PHY or D-PHY
>>> mode. This configuration supports two-phase D-PHY mode.
>>>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Aside from initialization, looks like the reset seq should be more
>> complex:
>>
>> https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/-/blob/LA.AU.1.3.7-02900-gen3_gvmgh.0/drivers/cam_sensor_module/cam_csiphy/include/cam_csiphy_1_1_hwreg.h?ref_type=tags#L39-45
>>
>> https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/-/blob/LA.AU.1.3.7-02900-gen3_gvmgh.0/drivers/cam_sensor_module/cam_csiphy/cam_csiphy_core.c#L133-154
>>
>> similarly for the "common regs" that seem to extend the init seq
>>
>> https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/-/blob/LA.AU.1.3.7-02900-gen3_gvmgh.0/drivers/cam_sensor_module/cam_csiphy/cam_csiphy_core.c#L491-527
>>
>> Konrad
> 
> So..
> 
> https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/-/blob/LA.AU.1.3.7-02900-gen3_gvmgh.0/drivers/cam_sensor_module/cam_csiphy/include/cam_csiphy_1_1_hwreg.h?ref_type=tags#L39
> 
> static struct csiphy_reg_t csiphy_reset_reg_1_1[] = {
>      {0x0814, 0x00, 0x05, CSIPHY_LANE_ENABLE}, // this is interesting
>                                                    // powers off lanemask
>                                                    // seems like a good
>                                                    // idea to me
>      {0x0818, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS}, [1]
>      {0x081C, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS}, [2]
>      {0x0800, 0x01, 0x01, CSIPHY_DEFAULT_PARAMS}, // this we already
>      {0x0800, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS}, // do right now
> };
> 
> [1] [2] I don't see why you need that and I'd imagine the reset drives these values to zero anyway.. it should as I read the reg docs, I'd guess this is a reset sequence that comes out of a Si test bench.
Since it's there on shipped devices, I'd skew towards including it, maybe some
chips with this block had an erratum wrt the reset value


> 
> The 0x814 warrants an investigation - i.e. can we add it across platforms without breaking existing setups.
> 
> I'll kick that to a separate - one LOC "series", so we can take our time validating if it has any unexpected side-effects across our various platforms.
Sure, that's what I had in mind

Konrad
