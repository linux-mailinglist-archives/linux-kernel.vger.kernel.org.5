Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89A179E22E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbjIMIb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbjIMIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:31:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC110E6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:31:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so111534741fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694593912; x=1695198712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/fV9qh2c8oVm1pKivt47UMLiB1/YyxBVKUII8eUOWbE=;
        b=oZQMjOTGqOiBks4v46AUoi6NDa1KrIlUpCq/hPTT1MmlvtvTLUvaQBJ0wsaaMwbi5n
         hq0jzP5gBJWhuqbswlf1YbfgSyZMvk9zXJYAms+llXrFP4ZJovhpS3nPICfzBmXe6mXT
         EvW9dsz270aRSpcAU53vRvaOBSo78Vsf43L3Lf6PeJU+VlBl54jYdDnffa9rZ6PnWWSv
         XMo3FEy964WFINxXqVFuIpmsSCzj382TSQnqCdkrauU6PlHV+UA4B65iUg4lB1RD1Hy7
         mbQ+v3StxZGfqQLy2fo7/AkSiPH0RCLGVHZOFDqvWZRK9J9ltS0uBUhkpMXJ7+05OL5S
         2BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593912; x=1695198712;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fV9qh2c8oVm1pKivt47UMLiB1/YyxBVKUII8eUOWbE=;
        b=V5VONQATmYTHHn2y+VJDN5/RvUPYE/nDohCJXEpwx9LGvDX1iDn5bwhtCYSC/7aXEs
         Gbc1EeB85WxYCOyGM0kqUDl4efvfXUXuKtoxWw3kr3cm9orKOL682ovGRg5ya0kL6n0R
         tbbp0hYbVpSl2znVGnGptxzymi/Um5qZm+pLFr5hj+9zQMVcEl71e2yixo1o1iL4c3pM
         i5bzU3SEyYik5M3lsZ+DppEd0aHXAhDs9eBKT9wgWMPKIPaWcNng18gXtFsCGueVyz+v
         Ha02jV9rpi0X0hMML/yPROA2/N+vFUvDi4uaEUMg7TcQ75MvJlQTMuS2AEfBYWnDCZfT
         XV3Q==
X-Gm-Message-State: AOJu0YzUmDR3GEsZcJ1E7/ZgIVlqXf701TXiXp4vZcBErlJZOIj/seEV
        FmhBIMrcV2LKoD1T+JiYx6e/5A==
X-Google-Smtp-Source: AGHT+IHETiP36DYc5WwbiejX2cRFqqVKi2cd44OEfzhFjfmB6ZRMSIqwBkzJiyYFJQFQ3IkHzKKR+w==
X-Received: by 2002:a2e:8696:0:b0:2b9:f13b:613c with SMTP id l22-20020a2e8696000000b002b9f13b613cmr1844262lji.2.1694593911936;
        Wed, 13 Sep 2023 01:31:51 -0700 (PDT)
Received: from [192.168.37.232] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id h10-20020a1709063b4a00b009737b8d47b6sm7920036ejf.203.2023.09.13.01.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:31:51 -0700 (PDT)
Message-ID: <ffc58838-c306-49f3-a90a-95b2cf02ae3d@linaro.org>
Date:   Wed, 13 Sep 2023 10:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/53] icc-rpmh multi-RSC voting groundwork
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
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230913012951.GA19284@hu-mdtipton-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2023 03:29, Mike Tipton wrote:
> On Wed, Sep 06, 2023 at 02:14:14PM +0200, Konrad Dybcio wrote:
>>> The general idea is that we could use tags for this. So, instead of...
>>>
>>>   path = icc_get(dev, MASTER_MDP_DISP, SLAVE_EBI1_DISP);
>>>
>>> it would be...
>>>
>>>   path = icc_get(dev, MASTER_MDP, SLAVE_EBI1);
>>>   icc_set_tag(path, QCOM_ICC_TAG_VOTER_DISP);
>>>
>>> I have an early prototype with basic testing already. I can hopefully
>>> clean it up and post for review in the next couple of weeks.
>> I was initially not very happy with this approach (overloading tags
>> with additional information), but it grew on me over time.
>>
>> My only concern is that if we reserve say bits 16-31 for path tags
>> (remember, dt-bindings are ABI), we may eventually run out of them.
> 
> The voter tags wouldn't require bitmasks like the bucket tags do. We'd
> just need an integer for each voter shifted into the proper position in
> the tag value. Thus, reserving N bits for the voters would give us 2**N
> voters, which should be plenty. For example:
> 
>   #define QCOM_ICC_VOTERS_START           16
>   #define QCOM_ICC_VOTERS_END             23
> 
>   #define QCOM_ICC_TAG_VOTER_HLOS         (0 << QCOM_ICC_VOTERS_START)
>   #define QCOM_ICC_TAG_VOTER_DISP         (1 << QCOM_ICC_VOTERS_START)
>   #define QCOM_ICC_TAG_VOTER_CAM_IFE_0    (2 << QCOM_ICC_VOTERS_START)
>   #define QCOM_ICC_TAG_VOTER_CAM_IFE_1    (3 << QCOM_ICC_VOTERS_START)
>   #define QCOM_ICC_TAG_VOTER_CAM_IFE_2    (4 << QCOM_ICC_VOTERS_START)
> 
> The applicable voters should likely be defined in the target-specific
> headers, rather than the common qcom,icc.h. The bit range used for them
> could be common, but each target may only support a small subset of the
> total set of possible voters across all targets.
I'm not sure how client drivers would then choose the
correct path other than

switch (soc) {
case 8450:
	tag = QCOM_ICC_TAG_VOTER_8450_HLOS;
	break;
case 8550:
	tag = QCOM_ICC_TAG_VOTER_8550_HLOS;
	break;
...
}

which would be unacceptable.

 
> Clients requiring multiple voters for the same logical path should be
> rare. On the off-chance they require that, they could just request the
> same path multiple times with different voter tags applied and call
> icc_set_bw() for each of them separately.
> 
> I'm back from travel and vacation and plan to pick this up again soon.
Happy to hear that!

Konrad
