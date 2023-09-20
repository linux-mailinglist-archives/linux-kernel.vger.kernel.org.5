Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF597A793C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbjITKbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjITKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:31:31 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A434FD8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:31:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bffa8578feso60967181fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695205881; x=1695810681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVD5SlK5IIGGKLG6UNP4VEDAz9GKCdGc2ijrebuFT2c=;
        b=uZBeFSmRcdmcUtWWjV3NP1z73DKKds3IjxYtFKxKxflbFvRT2joiRLL/87kDo/+9af
         hpfdo6k9rbekNGrrALQmiF9TG/3zeTEBr2HmT0/sFEFjBZukR3TU4QWxy1OpL9ndC9ey
         ByvFuPfahw3TbDbJOSodcpbPfITLzbAM7sqkB66mRneUQoCVEgIKe4Ckm9DGYP846YjX
         LMh5Apa984jP7R29UFo+Qoa1IUZXawTDa0JeQc1N5utHg2OzCF50kRfoCBzFJGBBsWno
         SDdR148eJWHPLoQRasxjpslCBuS/Io6M5BOdSHzwXUpeywmwRbt5MAr1s7c6znr3Q1f2
         W/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695205881; x=1695810681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVD5SlK5IIGGKLG6UNP4VEDAz9GKCdGc2ijrebuFT2c=;
        b=o835Z0XOm5TTldcdiaoX36tNi9XdkiT+4cMdOp3+PfjrO91cQ/2o+4+BBpW2lNh8DZ
         YNXWF0tdxMGWeAZiITH6T4EHUzitghKa3LEHHmj8VK1JZbet3q2HqFRhnIuQC5S1JrBb
         k8xWH4Cte8/14Z411ofZMUmOcTEqjVFhtbBQr90AAl/w2a+EEtY334XPIE0ySMM9dVxt
         2pUTfp/WRyn7rvWr/3eHi9yh9neyTEZ9oLHzTpkzlheLT89EsJ9MzSovrw6Lc/CfzxuS
         o9OBMoTqIwM1NZ7mRDB5zCcvaZYdjvLWuj3QIl7yelJlIlXAb7UBwMq8Qte7oXYeQggs
         fu3w==
X-Gm-Message-State: AOJu0YziM7DTDdaU6g9/eharYgwHN2Gf7NAf6n2YmWZUWEbvh4ZEgiNw
        /5UfaCGnptudWfgWIJViFkY1og==
X-Google-Smtp-Source: AGHT+IHNqvuGUvh6tLyyqGFNnrZS8tPkhKrPSeCFZ5gntA/E1QFWtVaa4IX1aAwgMai+wj0aCBuWPA==
X-Received: by 2002:a2e:888c:0:b0:2bb:78ad:56cb with SMTP id k12-20020a2e888c000000b002bb78ad56cbmr1750067lji.37.1695205880732;
        Wed, 20 Sep 2023 03:31:20 -0700 (PDT)
Received: from [172.20.86.172] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id m21-20020a1709060d9500b009937dbabbd5sm9133554eji.220.2023.09.20.03.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:31:20 -0700 (PDT)
Message-ID: <0c3bc9d9-6c67-a025-ce86-82385794bd68@linaro.org>
Date:   Wed, 20 Sep 2023 12:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add SM4450 interconnect
 provider driver
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230915020129.19611-1-quic_tengfan@quicinc.com>
 <20230915020129.19611-3-quic_tengfan@quicinc.com>
 <dc209ac7-7a06-449b-a198-ce6fb3ba7ff7@linaro.org>
 <73a90202-1127-4469-a46d-7986343c51b1@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <73a90202-1127-4469-a46d-7986343c51b1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/23 03:59, Tengfei Fan wrote:
> 
> 
> 在 9/15/2023 8:43 PM, Konrad Dybcio 写道:
>> On 15.09.2023 04:01, Tengfei Fan wrote:
>>> Add driver for the Qualcomm interconnect buses found in SM4450 based
>>> platforms. The topology consists of several NoCs that are controlled
>>> by a remote processor that collects the aggregated bandwidth for each
>>> master-slave pairs.
>>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>> [...]
>>
>>> +static struct qcom_icc_bcm bcm_acv_disp = {
>>> +    .name = "ACV",
>>> +    .num_nodes = 1,
>>> +    .nodes = { &ebi_disp },
>>> +};
>>> +
>>> +static struct qcom_icc_bcm bcm_mc0_disp = {
>>> +    .name = "MC0",
>>> +    .num_nodes = 1,
>>> +    .nodes = { &ebi_disp },
>>> +};
>>> +
>>> +static struct qcom_icc_bcm bcm_mm0_disp = {
>>> +    .name = "MM0",
>>> +    .num_nodes = 1,
>>> +    .nodes = { &qns_mem_noc_hf_disp },
>>> +};
>>> +
>>> +static struct qcom_icc_bcm bcm_sh0_disp = {
>>> +    .name = "SH0",
>>> +    .num_nodes = 1,
>>> +    .nodes = { &qns_llcc_disp },
>>> +};
>>> +
>>> +static struct qcom_icc_bcm bcm_sh1_disp = {
>>> +    .name = "SH1",
>>> +    .num_nodes = 1,
>>> +    .nodes = { &qnm_pcie_disp },
>>> +};
>> """
>> v1 -> v2:
>>    - remove DISP related paths
>> """
>>
>> you sure?
>>
>> + I still see _disp nodes..
>>
>> Konrad
> 
> Hi Konrad,
> only removed SLAVE_MNOC_HF_MEM_NOC_DISP related code actually as V1 
> comment.
No, I asked you to remove all nodes that only exist to access
non-APPS_RSC BCMs

Konrad
