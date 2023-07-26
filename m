Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F77763D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjGZRTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjGZRTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:19:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DEB2116
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:19:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so23149e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690391976; x=1690996776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcY6ppKtrAlO+6g+Nzg+cqFbT2ZkT49HVufXW9jRMos=;
        b=M7sBZNW35OruOCwUhTCHtB4mqwKXIuNZaeJKeYbR7qDSztacBhYvhjft0YG6dCq/Rf
         FLltEXylv1x9LmUT8uD+He2OLlzhVzbizQHCd2n4QurMhpl0cK62dBtXSxSYL1SaEsJh
         IISPlCMkdsvdwCfWHKkr7mz9zJ9tDjYZ5vTBpWCRLw9djZ+pfhzR+6VAjunryfrp4lRz
         H1ueOx+TBXHKla1nWD8HVTob8jwx1+7CvMng/eG7ZLSv1DsLiF0qQcg7lvYvmUohmvYl
         E7xyVYGILbADWmEik3W9XQZA/s9zhzUtPVsdAVSK8Xh/G8Q61WIVGlNVVm3Vb/MIdg/k
         MmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690391976; x=1690996776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcY6ppKtrAlO+6g+Nzg+cqFbT2ZkT49HVufXW9jRMos=;
        b=CnziYbMyClFMElcfsBM7E6Bpvt5v/PTdQtUZORQx1cKsLJiyeRrc3BehRiLDKNkXY/
         9vBOMak8naBKJdra+kehyWXfWz4KVi8n3Rx6nDvLpIsmypHCrkcOL40n1giL88EWxiwP
         u3ISHcXSo3LPLLaWY9cTmI9jkmYvJLtxRcpVPv7kqaDj4/x6N+udxA7pea3y8tJ5V+zv
         nbWf9p9c77uqTbrimx4ZH0RI5cfj05nRires6BN83qmZXwA7DZ6uCisB66L5bQSJ2WGi
         q1IfBiO9yU1tr4gvsd2lfRXXfCFEX+VjDlwLkPJ04UQW6t0/IBsOrdIRvu5l9XMbw2B9
         lSiQ==
X-Gm-Message-State: ABy/qLZDtg9UMyX5OXF5c96pbApSefM8KJDNDMIg7uqeZoTQ81/0R5am
        /kz3re9n4vziTxTjJpyOwLrhiA==
X-Google-Smtp-Source: APBJJlGkpkzCWlW1YcfxlenPF/OLCi5w0GDJBAuua2RDhiRV3jjrKInCfhANQf1wiUkGHYNOmkv+KA==
X-Received: by 2002:a05:6512:159b:b0:4fd:fad6:5495 with SMTP id bp27-20020a056512159b00b004fdfad65495mr2318027lfb.18.1690391976525;
        Wed, 26 Jul 2023 10:19:36 -0700 (PDT)
Received: from [192.168.1.101] (abxh240.neoplus.adsl.tpnet.pl. [83.9.1.240])
        by smtp.gmail.com with ESMTPSA id m9-20020a056512014900b004fb8ff1f531sm3334272lfo.70.2023.07.26.10.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 10:19:36 -0700 (PDT)
Message-ID: <829c2da7-4f88-4669-a114-c80603ccd4e1@linaro.org>
Date:   Wed, 26 Jul 2023 19:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] interconnect: qcom: icc-rpm: Add AB/IB calculations
 coefficients
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
 <20230726-topic-icc_coeff-v1-1-31616960818c@linaro.org>
 <ZMFU-hFSOHLr3hFP@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZMFU-hFSOHLr3hFP@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2023 19:16, Stephan Gerhold wrote:
> On Wed, Jul 26, 2023 at 06:25:43PM +0200, Konrad Dybcio wrote:
>> Presumably due to the hardware being so complex, some nodes (or busses)
>> have different (usually higher) requirements for bandwidth than what
>> the usual calculations would suggest.
>>
> 
> Weird. I just hope this was never abused to workaround other broken
> configuration. A nice round ib_percent = 200 has mostly the same effect as
> 
>   - Doubling the requested peek bandwidth in the consumer driver (perhaps
>     they were too lazy to fix the driver in downstream at some point)
>   - Halving the node buswidth
> 
> It's probably hard to say for sure...
As per usual..

[...]

>>  
>>  	/*
>> @@ -315,6 +317,12 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_r
>>  			else
>>  				agg_avg_rate = qn->sum_avg[i];
>>  
>> +			percent = qp->ab_percent ? qp->ab_percent : 100;
>> +			agg_avg_rate = mult_frac(percent, agg_avg_rate, 100);
> 
> 			if (qp->ab_percent)
> 				agg_avg_rate = mult_frac(qp->ab_percent, agg_avg_rate, 100);
> 
> Would be likely more efficient (no calculation if unspecified) and not
> much harder to read.
Oh right!

> 
>> +
>> +			percent = qn->ib_percent ? qn->ib_percent : 100;
>> +			agg_peak_rate = mult_frac(percent, qn->max_peak[i], 100);
>> +
> 
> agg_peak_rate doesn't seem to be used anywhere else? 🤔
Whoooooops....

Konrad
