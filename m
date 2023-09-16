Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DE37A2CC9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbjIPAzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbjIPAzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:55:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D212733
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:54:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b703a0453fso44996601fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694825657; x=1695430457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YouDa+ERRcXfsKD05SHv7uq2HbLul8fzNckpEFgl+38=;
        b=A/rXRJ+5hj8kZa4RuChDDkIJtcazBhGC0MaUBkPsdLogNF5KaF8LJJ07/6fvpnJRi6
         Jc072txH1x7ImV90wUQBnfsGU0rhB0gfb8RFRQ9o3PFxA1nHm661EX9L18pUUjsV3bvm
         gKTVBsmURcasuyxnH/7V/TEVlEIhXnbE9h7cCO5b4MFL17N9qKnUq+hgw0jPTyoLmXDb
         OgEsoUGl723pYIBipj4arNIINORb1Ud10xn/3IwD4ouUGORWVFCi817alll4cnHCxoi0
         vP9+GXkR7AVa0QH7xq15RgExKOzwNlEqytzvWfECLmejltwg9XiBmJLrfYeSm7aT+VXk
         EL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694825657; x=1695430457;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YouDa+ERRcXfsKD05SHv7uq2HbLul8fzNckpEFgl+38=;
        b=lpzUB9KFJRs363pU0w6C0TwZqAKUWR09M6vhMZShnuuPtGQVmfNniLv3k11YxF8TGU
         d2826DONFCJ3zLukHSrtYlImUlAvJUbBXe/+91F35tTTnvJfjSKXKpmiBhNZjT9LaPk7
         hqw8ARzncxwkIEyokePVmkz+kxfC36j16fpzZypwK4LVh9Gr2YTJpExRj6QC2nFBT4ZT
         dx8rNXQjhdmoy+zJ7wPG81u+SiDC9eYX7v4hUEpwVzcwlAWZBD/n+qSN0JfBlp97meCi
         jF3lrzkSKYWd428pbeXTeXxTayIH5nxtvqPdtLppQjaMV/GuDDeNUPIivND6468XoTtL
         CtvA==
X-Gm-Message-State: AOJu0Yz+XPpUW4A0fBCZzEthPToUxKuqb+ll6w9wIVZesrJ8F7mgCdyS
        dUNJ2C62IQ9um/3ft3k59/pBeQ==
X-Google-Smtp-Source: AGHT+IHUdnhlfTeK4MtrE3fpZApJQcwswA5kVYL+eRCHSesSPAIVMBTUHObYeXXNmyeSYbM6adsOHQ==
X-Received: by 2002:a2e:3505:0:b0:2bd:10b7:4610 with SMTP id z5-20020a2e3505000000b002bd10b74610mr2594910ljz.25.1694825656782;
        Fri, 15 Sep 2023 17:54:16 -0700 (PDT)
Received: from [192.168.37.154] (178235177186.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.186])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906248a00b00993928e4d1bsm3046483ejb.24.2023.09.15.17.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:54:16 -0700 (PDT)
Message-ID: <49687bc6-7121-422c-99fd-e68dd46aae95@linaro.org>
Date:   Sat, 16 Sep 2023 02:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/53] icc-rpmh multi-RSC voting groundwork
Content-Language: en-US
To:     Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <c067a45f-9629-d516-9e56-36538e4ff6db@kernel.org>
 <20230807215739.GA9621@hu-mdtipton-lv.qualcomm.com>
 <10520827-dc01-475c-b09a-35cefc9e0a62@linaro.org>
 <20230913012951.GA19284@hu-mdtipton-lv.qualcomm.com>
 <ffc58838-c306-49f3-a90a-95b2cf02ae3d@linaro.org>
 <20230914023239.GA25147@hu-mdtipton-lv.qualcomm.com>
 <978fd46d-8142-41e6-9c62-df678018d6c2@linaro.org>
 <20230915160525.GA14240@hu-mdtipton-lv.qualcomm.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230915160525.GA14240@hu-mdtipton-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.2023 18:05, Mike Tipton wrote:
> On Fri, Sep 15, 2023 at 03:43:27PM +0200, Konrad Dybcio wrote:
>> On 14.09.2023 04:32, Mike Tipton wrote:
>>> On Wed, Sep 13, 2023 at 10:31:49AM +0200, Konrad Dybcio wrote:
>>>>> The applicable voters should likely be defined in the target-specific
>>>>> headers, rather than the common qcom,icc.h. The bit range used for them
>>>>> could be common, but each target may only support a small subset of the
>>>>> total set of possible voters across all targets.
>>>> I'm not sure how client drivers would then choose the
>>>> correct path other than
>>>>
>>>> switch (soc) {
>>>> case 8450:
>>>> 	tag = QCOM_ICC_TAG_VOTER_8450_HLOS;
>>>> 	break;
>>>> case 8550:
>>>> 	tag = QCOM_ICC_TAG_VOTER_8550_HLOS;
>>>> 	break;
>>>> ...
>>>> }
>>>>
>>>> which would be unacceptable.
>>>
>>> The same general way it's handled for the endpoint bindings, which are
>>> already target-specific. 
>>>
>>> Any client drivers hardcoding the endpoint bindings in their driver
>>> would have to include the appropriate, target-specific binding header
>>> (e.g. qcom,sm8550-rpmh.h). That would only be possible if their driver
>>> file is itself target-specific. Otherwise, it would have to pull the
>>> endpoint bindings from devicetree. Or just use the recommended
>>> of_icc_get() and let devicetree do everything for them. Same for the
>>> target-specific voter tag bindings.
>>>
>>> Clients can also specify their tags in devicetree. They don't actually
>>> have to call icc_set_tag() directly. For example:
>>>
>>>     #include <dt-bindings/interconnect/qcom,sm8450.h>
>>>
>>>     interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_VOTER_DISP
>>>                      &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_VOTER_DISP>;
>>>
>>> Then when they call of_icc_get() for this path it'll automatically have
>>> QCOM_ICC_TAG_VOTER_DISP set for them.
>> I think I'd skew towards the "define everything in the DT" approach.
>>
>> One thing that makes me uneasy to go on with this approach is the
>> question whether there is a case in which we would want to switch
>> from e.g. voting through DISP to voting through APPS (or similar)
>> from within a single device.
> 
> It shouldn't be common. But it could be done fairly simply by listing
> paths for each different voter in the dt properties. 
> 
>     interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_VOTER_APPS
>                      &mc_virt SLAVE_EBI1  QCOM_ICC_TAG_VOTER_APPS>,
>                     <&mmss_noc MASTER_MDP QCOM_ICC_TAG_VOTER_DISP
>                      &mc_virt SLAVE_EBI1  QCOM_ICC_TAG_VOTER_DISP>,
>     interconnect-names = "path-apps-voter",
>                          "path-disp-voter";
Eeeeeh, I don't know.. this almost sounds like a patch-up solution
to a problem that doesn't quite yet exist.

I debated introducing a third interconnect cell for this, but I am
not sure the added complexity is worth it.


Having a global set of RSC-bound tags would be a "nice" and tidy
solution.. Maybe we could even allocate like 24 bits to these, as
I don't think you'll be introducing new buckets (or at least I hope
you won't!).

24 is an obscene amount of RSCs to have, even counting virtual
channels, so unless you folks have some dark plans to make all
pieces of hardware powered completely separately from each other,
I suppose I could ask for a pinky-promise to not exceed that
number, ever :D

Konrad
