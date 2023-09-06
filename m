Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49471793C6F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbjIFMOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbjIFMOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:14:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498211717
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:14:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98377c5d53eso519104566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694002457; x=1694607257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9Bg/dVDxo6+g7+rfRY3uAFK7nbPJavtKsvDCjgO83M=;
        b=SWORc7IVDuFZ3ZAJTGAQxrFg4mRJ/KVbZEbqpVmBvHne+SJkBuEEnybAKLRsl254IY
         U0OF2lquiYUpPrEbna05Px1KfsURKF5H5sF+WPd7jiCfNKqJ928R7UF72TtvDC9wWF7f
         N6srf/GR1fe4GLMO6Jt1H9UvpBF2VsGNr9oBD9ArZUB7jHOol2Cs7zCyHWrojvulR1iy
         FoNntshOix+cA0qKIWj5iBatAhUmemETiKqiv7JiXI7MdTlpUlVwz5hRTfDZRDabfUAW
         iGIYGbeZ3JZ4K9j0s/Sn/TCzErZHUZHkON0//tDZWwCRwoZLIRDT8ICV3CEQ/xdMYKTg
         qeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694002457; x=1694607257;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9Bg/dVDxo6+g7+rfRY3uAFK7nbPJavtKsvDCjgO83M=;
        b=NPr8qHygQBO4oAzTGV2onri8SirEtL2ta0z0Nqb9GgqBmI8fO5hm5NBqdgAfpUQTm4
         22kzN68QHzt0brV0tEm9TXZbiJebFLfjtxzTx7p4MfaNVSmMNX9tjhO9sAfH89VrkvyG
         up5fRgNpZtzxibzMk0iLFH6Oqi05ET+5IRewuCg23mqjvO9AQZmohO7pdvMRArAgWc1r
         xicO3b9zbkp9pjCRCpRQoWX9wpltBQYE2bxjm+XppvqEDZTTUU+K4kTkv7jkpFx/Mpfy
         4j/7rx+cayixfMPHF1RbyT+aF3klllUjIUfp2kRFC22dEHfAqMXOcPjhwFS3PIcpxy0K
         zA0w==
X-Gm-Message-State: AOJu0YyOJcs5MhF00PntIs/ySea7T9whxPe8H83ICzo6p4mRX6IOWsDX
        02SJJyY7bzLSjCru7cVN+iNq/A==
X-Google-Smtp-Source: AGHT+IH1I047qgp4y+1te3h85OCKarvoSoPFP7FaNdo0dTzZvZK0rxlW12L/JPkfB2o/sYR65Beq3A==
X-Received: by 2002:a17:906:5dae:b0:9a1:c659:7c62 with SMTP id n14-20020a1709065dae00b009a1c6597c62mr2058303ejv.66.1694002456757;
        Wed, 06 Sep 2023 05:14:16 -0700 (PDT)
Received: from [192.168.37.154] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id rn5-20020a170906d92500b0099cc402d3ddsm8800515ejb.202.2023.09.06.05.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 05:14:16 -0700 (PDT)
Message-ID: <10520827-dc01-475c-b09a-35cefc9e0a62@linaro.org>
Date:   Wed, 6 Sep 2023 14:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/53] icc-rpmh multi-RSC voting groundwork
Content-Language: en-US
To:     Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230807215739.GA9621@hu-mdtipton-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.08.2023 23:57, Mike Tipton wrote:
> On Thu, Aug 03, 2023 at 07:48:08PM +0300, Georgi Djakov wrote:
>> Hi Konrad,
>>
>> On 11.07.23 15:17, Konrad Dybcio wrote:
>>> Many parts of Qualcomm SoCs are entirely independent of each other and can
>>> run when the other parts are off. The RPMh system architecture embraces
>>> this by giving each (loosely defined) subsystem its own connection (as in,
>>> physical wires) to the AOSS, terminated by per-subsystem RSCs (Resource
>>> State Coordinators) that barter for power, bandwidth etc.
>>>
>>> This series introduces the groundwork necessary for voting for resources
>>> through non-APPS RSCs. It should allow for lower-latency vote adjustments
>>> (e.g. for very high bandwidth / multiple displays) and could potentially
>>> allow for full APSS collapse while keeping e.g. MDSS operating (say
>>> refreshing an image from a RAM buffer).
>>
>> This is good stuff. Thanks for working on it! Actually the path tagging,
>> that have been introduced some time ago could be used for supporting the
>> multiple RSCs. Today we can get the tags from DT, and tag the path with
>> some DISP_RSC flag (for example) and avoid the qcom,bcm-voter-idx property.
>>
>> Mike has been also looking into this, so maybe he can share his thoughts.
>>
> 
> Yeah, the current way we've been supporting multiple voters (e.g. RSCs)
> doesn't scale. We currently duplicate the topology for any path that
> requires a secondary, non-APSS voter. Which means we have duplicates
> nodes and bindings for each hop in those paths, even though there's only
> a single logical path.
> 
> For example, in qcom/sm8550.c, each node and BCM ending with _disp,
> _ife_0, _ife_1, or _ife_2 is a duplicate. The only reason they exist is
> to allow clients to target their votes to the non-APPS voters. And to
> provide separate, voter-specific buckets of aggregation. But everything
> else about them is 100% identical to their default APPS counterparts.
> For sm8550, this amounts to roughly 643 extra lines of code.
> 
> Initially there was only the one secondary display voter, so the scaling
> problem wasn't a huge issue. But sm8550 has four voters. And future SOCs
> will have even more.
> 
> We should only define the logical topology once. The ratio of NOC ports
> to interconnect nodes should be 1:1, rather than 1:N where N is the
> number of voters that care about them.
> 
> The general idea is that we could use tags for this. So, instead of...
> 
>   path = icc_get(dev, MASTER_MDP_DISP, SLAVE_EBI1_DISP);
> 
> it would be...
> 
>   path = icc_get(dev, MASTER_MDP, SLAVE_EBI1);
>   icc_set_tag(path, QCOM_ICC_TAG_VOTER_DISP);
> 
> I have an early prototype with basic testing already. I can hopefully
> clean it up and post for review in the next couple of weeks.
I was initially not very happy with this approach (overloading tags
with additional information), but it grew on me over time.

My only concern is that if we reserve say bits 16-31 for path tags
(remember, dt-bindings are ABI), we may eventually run out of them.

Konrad
