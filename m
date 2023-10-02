Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54D27B4FC8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjJBKAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbjJBJ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:59:47 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871BB19AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:59:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c189dabcc3so74746801fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696240763; x=1696845563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=It/ZsR6g1wIRiFAriPbbG+39UjSrUpiZGMRU85VTPSY=;
        b=G3skok1MKC6vlmI+jyZAsTYsCoout3gmSa000keMlZMkQo4G3g6xqVFEsUl/ZVppmg
         9NEL8JXTrl0DFtemHaaWCbTNzAoUv23Z/XlyTXNxjC5qt1E/QFUjsRQByEDbbFCuk6qZ
         Kax/rMpV3slzu2fG8jup9L6JsstqUIGHPI8ScCj6t+H0wWIb9jE8MQlCAEPuG4ObZrBV
         Key3Nju9L1wPo2volVuKmaZOJMn6jWD1k6EGmXOKwMTR8v4wF19cvGcYvyC3wo6YN5de
         sUKeLrRKI53MAtbn1ENsvwBLoEXMz9yQgUmmkHMcbXGN9WEhQUkd8gkU+KcQdrr3B1Om
         IT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240763; x=1696845563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=It/ZsR6g1wIRiFAriPbbG+39UjSrUpiZGMRU85VTPSY=;
        b=kHus9vHZCVgn42w7BdjCSI0IzOErUsX/a3AW8SMfetdEXtom3Ka6Y0Zj65ixurUy8h
         zYyX0/WKIZvfzw3rLJwmJCHUy7MbP6Zdkx4a7eQ7gmX1nJcDqkDjI3rvbd3vQeV6P1XZ
         SclFF1J0d3M/u1L3zXuPav8Zc3yz7Z52JpDv32ccSKXYZhgoHA8VBbmCy9GfidSPq6dl
         k5D4ZaHK80euy38EC6n31hIhgfPQFoWCmQ0KGlmlyvTSz0aLJZSJcX+peQZEJV3h6Csj
         D00Sw4w9zZVIsYT2AzdY9csUAOp7O4vxe4fnQNN8ysZGXsKbZ2chD/2SCvuPlwmg+S7o
         FHfg==
X-Gm-Message-State: AOJu0YxnnNgYUn/FBJPZ26vDpwO5T21mxc3ze2gBJUWd7IWd6kP1rsLe
        NlPa9zg/HVsJsPTuyFjTsxPNLA==
X-Google-Smtp-Source: AGHT+IG9zGr3jMjOp+tFppLZ7eiuoei0EG9Q9/MA2pOK9+Fh8WoqwbL3ppMJyk4vcTqn9zWp5nPhjg==
X-Received: by 2002:a2e:b1c8:0:b0:2c1:7473:f3e0 with SMTP id e8-20020a2eb1c8000000b002c17473f3e0mr9259399lja.43.1696240763114;
        Mon, 02 Oct 2023 02:59:23 -0700 (PDT)
Received: from [172.30.204.164] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x26-20020a2e9dda000000b002c004175d26sm5278691ljj.56.2023.10.02.02.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:59:22 -0700 (PDT)
Message-ID: <86c130a3-4231-a363-f064-a637d599b936@linaro.org>
Date:   Mon, 2 Oct 2023 11:59:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/13] arm64: dts: qcom: msm8916: Add common
 msm8916-modem-qdsp6.dtsi
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-3-398eec74bac9@gerhold.net>
 <45665b43-3be9-4f27-aa88-12cdef56346d@linaro.org>
 <ZRMrqsZ0QeDNFHFj@gerhold.net>
 <1be747ae-1d80-4ebc-9841-c0e98e64a0d1@linaro.org>
 <ZRM8XzmAz8RAqkUg@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZRM8XzmAz8RAqkUg@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 22:17, Stephan Gerhold wrote:
> On Tue, Sep 26, 2023 at 10:01:21PM +0200, Konrad Dybcio wrote:
>> On 26.09.2023 21:06, Stephan Gerhold wrote:
>>> On Tue, Sep 26, 2023 at 08:49:24PM +0200, Konrad Dybcio wrote:
>>>> On 26.09.2023 18:51, Stephan Gerhold wrote:
>>>>> Most MSM8916/MSM8939 devices use very similar setups for the modem,
>>>>> because most of the device-specific details are abstracted by the modem
>>>>> firmware. There are several definitions (status switches, DAI links
>>>>> etc) that will be exactly the same for every board.
>>>>>
>>>>> Introduce a common msm8916-modem-qdsp6.dtsi include that can be used to
>>>>> simplify enabling the modem for such devices. By default the
>>>>> digital/analog codec in the SoC/PMIC is used, but boards can define
>>>>> additional codecs using the templates for Secondary and Quaternary
>>>>> MI2S.
>>>>>
>>>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>>>>> ---
>>>> I'd rather see at least one usage so that you aren't introducing
>>>> effectively non-compiled code..
>>>>
>>>
>>> There are 10 usages in the rest of the patch series.
>>> Is that enough? :D
>>>
>>> IMHO it doesn't make sense to squash this with one of the device
>>> patches, especially considering several of them are primarily authored
>>> by others.
>> I see..
>>
>> Well, I guess I don't have better counter-arguments, but please
>> consider this the next time around.
>>
> 
> Will do!
> 
>> [...]
>>
>>>>> +&lpass_codec {
>>>>> +	status = "okay";
>>>>> +};
>>>> Any reason for it to stay disabled?
>>>>
>>>
>>> You mean in msm8916.dtsi?
>> Yes
>>
>>> For the SoC dtsi we don't make assumptions
>>> what devices use or not. There could be devices that ignore the internal
>>> codec entirely. If there is nothing connected to the codec lpass_codec
>>> should not be enabled (e.g. the msm8916-ufi.dtsi devices).
>> See my reply to patch 5
>>
>> [...]
>>
> 
> Let's continue discussing that there I guess. :D
> 
>>>>> +	sound_dai_secondary: mi2s-secondary-dai-link {
>>>>> +		link-name = "Secondary MI2S";
>>>>> +		status = "disabled"; /* Needs extra codec configuration */
>>>> Hmm.. Potential good user of /omit-if-no-ref/?
>>>>
>>>
>>> AFAICT /omit-if-no-ref/ is for phandle references only. Basically it
>>> would only work if you would somewhere reference the phandle:
>>>
>>> 	list-of-sound-dais = <&sound_dai_primary &sound_dai_secondary>;
>>>
>>> But this doesn't exist so /omit-if-no-ref/ cannot be used here.
>> Ahh right, this is the one we don't reference.. Too bad,
>> would be a nice fit :/
>>
>> I only see one usage of it though (patch 7), perhaps it could
>> be kept local to that one?
>>
> 
> This patch series just contains the initial set of
> msm8916-modem-qdsp6.dtsi users (for devices which are already upstream).
> We probably have like 20 more that still need to be upstreamed. :D
> 
> sound_dai_secondary is fairly rare, but there is at least one more user
> that will probably end up upstream soon.
2 users don't sound particularly great in a devicetree included by 20 
other non-users

> I think the overhead of these template notes is absolutely negligible
> compared to all the (potentially) unused SoC nodes we have. :D
Yes, however the unused SoC nodes are mostly standardized and could be 
used as-they-are on a vast majority of devices

Konrad
