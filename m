Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18F7E6FE8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjKIRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjKIRMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:12:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89BC30D0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:11:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so1836040a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699549917; x=1700154717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKup6gPLqadYBXO4b6NJZJ76nJs2bYooRO5/myvRzOE=;
        b=cMydEhz7e1ZI03lDAh995x7QUUM/RCG+ac9EhtfionJyGErsqfjZnrJv6LUrNlsd4X
         U6BOpkJGDpHrn47AAUaWmoDVwGMcF3HHikW/EKg9BkYsvpgbIgY7jzxkryceYQdOZz4o
         76p+gepx3jQcQ4OlK/tEKG5tuwkeEkEDs/mAeoSZHvjG9nsAUyH5geEgoIp/5rYpx+zz
         F0ZStE0nO33IgLsQBr3bkQVp/HGHx9QXRwvRwLxboUHEB3S7Lb5FqSCDYD9dC2MoPd1W
         HGoljZNeDFuuGTZaUJeeCmuZiiBCb0NZrcq1IAv8nm+OC+T9HPzpkvM6A4i+py2ewuNG
         ryFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699549917; x=1700154717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKup6gPLqadYBXO4b6NJZJ76nJs2bYooRO5/myvRzOE=;
        b=jOtlBN+8UYQNZpqFNHYQ8xuFd5xw+whWhFssjm99D1mgqGbNIonQ6qtNPf0UJy3t3W
         TT0LAbHxlN2LIoNVO2GAyLvQCOzbSuRf/I+4e/INStvtp7r/Um4Ec01VWNhZ59Pd2iJC
         GhE/vWNW9aFBw9WYTpQJYhP630rhHQihLNeQCt651BkMeCuCUJvabhMYBWnuF8oGLwJ0
         v5ZZ+e5poBKIuG6KIjZm5F3C2AI3EpzRdjmFjFwuI1MvRJ0Ncc8iPhv7TuqUrFq1pDUH
         ZKdCHfPiDv+Latlq0QOI/DTPqji5gUuzgqZGwpXsrW4ibm00Wv4Lv7HFqPrUrkIiQz0J
         FdWg==
X-Gm-Message-State: AOJu0YzqyQKlzi+8DMnKsVyRZkyrd5VDF7Cjj8gF7qRUAcL8HGIa4W7P
        aH15kkOsnvcvcn6Wp8sIMViibw==
X-Google-Smtp-Source: AGHT+IFNmTkUKTpurLhMr6Imw2D4ZQw7nrJTojquLN9XZrC0EJudf3CToSRmvMwGsl/XL3CximP5/Q==
X-Received: by 2002:a17:906:fd85:b0:9c6:1143:b52 with SMTP id xa5-20020a170906fd8500b009c611430b52mr4953257ejb.55.1699549916987;
        Thu, 09 Nov 2023 09:11:56 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bcb02000000b004068e09a70bsm2634991wmj.31.2023.11.09.09.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 09:11:56 -0800 (PST)
Message-ID: <1e99ddcc-db3b-4a79-a2d1-815bebb5a5c9@linaro.org>
Date:   Thu, 9 Nov 2023 17:11:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] media: qcom: camss: csiphy-3ph: Add Gen2 v1.1
 two-phase MIPI CSI-2 DPHY init
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, Andy Gross <agross@kernel.org>,
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
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <0e325a57-f07d-47e6-8456-523cfa04c52b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 13:55, Konrad Dybcio wrote:
> 
> 
> On 11/9/23 12:30, Bryan O'Donoghue wrote:
>> Add a PHY configuration sequence for the sc8280xp which uses a Qualcomm
>> Gen 2 version 1.1 CSI-2 PHY.
>>
>> The PHY can be configured as two phase or three phase in C-PHY or D-PHY
>> mode. This configuration supports two-phase D-PHY mode.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Aside from initialization, looks like the reset seq should be more
> complex:
> 
> https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/-/blob/LA.AU.1.3.7-02900-gen3_gvmgh.0/drivers/cam_sensor_module/cam_csiphy/include/cam_csiphy_1_1_hwreg.h?ref_type=tags#L39-45
> 
> https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/-/blob/LA.AU.1.3.7-02900-gen3_gvmgh.0/drivers/cam_sensor_module/cam_csiphy/cam_csiphy_core.c#L133-154
> 
> similarly for the "common regs" that seem to extend the init seq
> 
> https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/-/blob/LA.AU.1.3.7-02900-gen3_gvmgh.0/drivers/cam_sensor_module/cam_csiphy/cam_csiphy_core.c#L491-527
> 
> Konrad

So..

https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/-/blob/LA.AU.1.3.7-02900-gen3_gvmgh.0/drivers/cam_sensor_module/cam_csiphy/include/cam_csiphy_1_1_hwreg.h?ref_type=tags#L39

static struct csiphy_reg_t csiphy_reset_reg_1_1[] = {
	{0x0814, 0x00, 0x05, CSIPHY_LANE_ENABLE}, // this is interesting
                                                   // powers off lanemask
                                                   // seems like a good
                                                   // idea to me
	{0x0818, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS}, [1]
	{0x081C, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS}, [2]
	{0x0800, 0x01, 0x01, CSIPHY_DEFAULT_PARAMS}, // this we already
	{0x0800, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS}, // do right now
};

[1] [2] I don't see why you need that and I'd imagine the reset drives 
these values to zero anyway.. it should as I read the reg docs, I'd 
guess this is a reset sequence that comes out of a Si test bench.

The 0x814 warrants an investigation - i.e. can we add it across 
platforms without breaking existing setups.

I'll kick that to a separate - one LOC "series", so we can take our time 
validating if it has any unexpected side-effects across our various 
platforms.

---
bod
