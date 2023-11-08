Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF597E4E30
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjKHAgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKHAgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:36:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA910FA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:36:04 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a3b8b113so8029378e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699403763; x=1700008563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLCtsTg94ZkYKlxM35PI/7QpN+IW2xY9/USBi3sx8e0=;
        b=MJ7iTFmgyaWBmmY4IGaip5aDrJrcOq9jDFtsabyuT1LUHyrsNQMcm/ctN1gzE7fygf
         eoZTJ1wqNcXJQBq+10gxZsont/tB/4blfYDuXM1XPjQsgZI1MMjg6l4EtN9UUJ/Aoh62
         zyUst9rAuz8ZP5boXAsW3fv2b2SEdXajpuV0CcYJdQegfazIVJaes3KFjNM66MVZClXT
         yaLFq2Xlpq6LOsbgeyej1sYmrBqpqeOK6dRAo7VyEov8YVsObJEkZOCSHKo33rjbmHAp
         XAjS1msE1UQkRIgZa+wJcT5NEF5P6Bc7oE741KOYwU6S/lplbdssm3egY1zIFdU1B1L5
         s+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403763; x=1700008563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLCtsTg94ZkYKlxM35PI/7QpN+IW2xY9/USBi3sx8e0=;
        b=aVQXSV2Grmt2+JlSLptusXCOSm+7PYxkDQGgILBLKz7n/ciQTvEUT2T5JUBezdDDgi
         rQp2z/b7BlWgpEGWFnI1de7xb7GF0iMixfPnQzCpeujh+4hypHYfOZRge5V7Son3LFS1
         9QnPP1dP59HWGDODSf75S6doNc1OEF3y9isDAorJDif421D41AZJ58WlM3TQMfTTudZP
         9gUPI6TpWJhikWFYl+fmu1s3YVP6MOKBlR6/FNeVhaMYqarkclEdXKRhguGtPftoQLLL
         PmkgN3fi/rtxI5Y8j11ldn5FjGKTqg+kr4XGFb7Ql1n9LI2NmNOuK2sD8FmgRU5g3kS7
         N7Mg==
X-Gm-Message-State: AOJu0Yxm6MZF+wkb4jtlCxA0bD16xXEFNgp5K3qhBLrti2VtQ8W9ZkVi
        qFwPM+ZcdEf6gzq3wwhPgOt0FA==
X-Google-Smtp-Source: AGHT+IHl+VAYGxe/DNmWYTV7boSYThTTOIb/X3vqD8Z9d7rD2VPoeP9ac4YqJU0Le6n452fR4Otgrw==
X-Received: by 2002:ac2:4f06:0:b0:507:9a8c:a8fe with SMTP id k6-20020ac24f06000000b005079a8ca8femr219318lfr.53.1699403762869;
        Tue, 07 Nov 2023 16:36:02 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d53c4000000b0032f7d7ec4adsm3581791wrw.92.2023.11.07.16.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 16:36:02 -0800 (PST)
Message-ID: <27cb79f8-2c44-48db-8f6d-c2ec861dc249@linaro.org>
Date:   Wed, 8 Nov 2023 00:36:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] media: qcom: camss: csiphy-3ph: Add Gen2 v1.1
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
References: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
 <20231105-b4-camss-sc8280xp-v3-3-4b3c372ff0f4@linaro.org>
 <ff8532ca-fe74-4f52-bab9-b14f6a4599b1@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ff8532ca-fe74-4f52-bab9-b14f6a4599b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2023 21:43, Konrad Dybcio wrote:
> 
> 
> On 11/5/23 18:45, Bryan O'Donoghue wrote:
>> Add a PHY configuration sequence for the sc8280xp which uses a Qualcomm
>> Gen 2 version 1.1 CSI-2 PHY.
>>
>> The PHY can be configured as two phase or three phase in C-PHY or D-PHY
>> mode. This configuration supports two-phase D-PHY mode.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
> Makes it sound like the current 2ph/3ph split is rather nonsensical?
> 
> Perhaps we should restructure it to match hw revision? Especially since
> one can get it from the hardware itself..
> 
> Konrad

For the C-PHY though we have to either add or remove caps - I forget 
which on ~ all of our reference platforms.

"The PHY can do it" but I'd be surprised to find there's a single real 
implementation of it outside of a silicon test bench.

---
bod
