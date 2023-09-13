Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE37E79E660
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbjIMLQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240079AbjIMLPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:15:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA92686
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:14:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso8858223a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694603696; x=1695208496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35Jh6hBwOpQxONFibbiJVQP3eMSJ7hdKNbYbRO9M0Ew=;
        b=jbTY97u2o1xZYDXw1CAA1Md38G17Ls3Lo6FRNiN8tANJjxMEatnocV+nCJ1U1NvRdI
         zIiF/wCR7OM2F3TdJaWI7QidsnHnyBCEp8M3YPPgAPeqj18qchdlkKd/90Lfg/QwtpdQ
         au5eElvea1IwxCM9TMu7Q7qJJnmpsR7UHBsUG6DYFFLFzqcNLOT1WhiNprVwLQ27wO9s
         VYndc4NpxdKJCnWdeCmVJ05O+u03hpaUOhfP9JcAb51e9FDB8kmtoLonC1IQeOutwRuM
         fLaZDwMIfQi30misUp2hhg2On9PQRmb/mL8MInN1eF4fCPPuo+bc3bfhKNiREXfbzgqK
         2iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694603696; x=1695208496;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35Jh6hBwOpQxONFibbiJVQP3eMSJ7hdKNbYbRO9M0Ew=;
        b=Ws5ObFFHx0Elb7XjsF5oH7No2s1SiRxbkG0BZU67lMHJpisEhTXit6nTAfr2hKW/Rg
         +SbpL8svAjkASGPSm5TpcICmPw3PdSo8zH5A43e4vQ+aneYwjhPScXBGRIwnFsht8f01
         Es4gQxfC5KNJS8yg8rw+G9YWUnc8qReYF3RMFdN0NIUFzVKeyjFCfIrZpSPr/7Gnw3ri
         gL9089ZzWTZTFbr/wXnHvHtoNgkDClHKQ5cvl1O1t3lUMdaECk5cOrHvQurfQsewIFHp
         Ay4qswVL9fJoP6C7mCUZZ6X0JxOcURWSsOl6+MNI5NZ08sWYHYaRzScl9xekW+3dDp89
         yoXQ==
X-Gm-Message-State: AOJu0Yz4jyXeE82Hacxi+GwU6gEGXgI03Byv9gpfHpyweCkbF5fUy8Un
        qh0jbi8PtDlzDaM39w1z46LpdQ==
X-Google-Smtp-Source: AGHT+IH4tWmuFJU4lDUDmzfIRDr9cvvAY7/q8Aw7sUDvq3Z/4hYnw2ZLqpW1l8wfK9hIGeuaAGpiRg==
X-Received: by 2002:a17:906:101a:b0:99b:ead0:2733 with SMTP id 26-20020a170906101a00b0099bead02733mr1702880ejm.72.1694603696034;
        Wed, 13 Sep 2023 04:14:56 -0700 (PDT)
Received: from [192.168.37.232] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090690ce00b0099c53c44083sm8235385ejw.79.2023.09.13.04.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:14:55 -0700 (PDT)
Message-ID: <70b19df7-c70c-41ea-ac4c-8af6956f4fc6@linaro.org>
Date:   Wed, 13 Sep 2023 13:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] arm64: dts: qcom: msm8916: Drop RPM bus clocks
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-1-1e506593b1bd@linaro.org>
 <bd11d1b1-efe5-4f96-43e7-163fca5d3278@linaro.org>
 <ac501bcc-80a1-4b65-ba24-272152d1c95c@linaro.org>
 <7b500bba-3091-f425-a60d-e58a3d9e4c1a@linaro.org>
 <9a0ab5a9-d4d8-41b8-94b0-9c62bd686254@linaro.org>
 <30bb6068-6bb8-9a2c-af19-b989960d0be9@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <30bb6068-6bb8-9a2c-af19-b989960d0be9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2023 13:14, Krzysztof Kozlowski wrote:
> On 13/09/2023 12:48, Konrad Dybcio wrote:
>> On 13.09.2023 10:53, Krzysztof Kozlowski wrote:
>>> On 13/09/2023 10:47, Konrad Dybcio wrote:
>>>> On 13.09.2023 09:07, Krzysztof Kozlowski wrote:
>>>>> On 12/09/2023 15:31, Konrad Dybcio wrote:
>>>>>> These clocks are now handled from within the icc framework and are
>>>>>
>>>>> That's a driver behavior, not hardware.
>>>> I believe we've been over this already..
>>>>
>>>> The rationale behind this change is: that hardware, which falls
>>>> under the "interconnect" class, was previously misrepresented as
>>>> a bunch of clocks. There are clocks underneath, but accessing them
>>>> directly would be equivalent to e.g. circumventing the PHY subsystem
>>>> and initializing your UFS PHY from within the UFS device.
>>>
>>> And every time one write such commit msg, how should we remember there
>>> is some exception and actually it is about clock representation not CCF
>>> or ICC framework.
>> So is your reply essentially "fine, but please make it clear in
>> each commit message"?
> 
> I am fine with this change. If commit msg had such statement, I would
> not have doubts :/
Ok, I'll resend, thanks for confirming!

Konrad
