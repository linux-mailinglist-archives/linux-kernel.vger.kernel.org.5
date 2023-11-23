Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7329D7F609D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345582AbjKWNnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345603AbjKWNmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:42:53 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440F01B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:42:55 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-5079f6efd64so1088868e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700746973; x=1701351773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIX6Y6OmD18tbJ/H2yRFYnNOAfgH4KdfJCuauNIg3HA=;
        b=D2uOT1hLKrvZJBqbjWGSL7egFYpFSU8XxQdqC9em6RL8EKY2eW+LSOKvPIklt/Ef7j
         kr3e2YPMxl7H5uYUVqR4rfTZjkGpHw1ozxrMNyChrx9dnxoCb+FwNoB+8W5pAhcozlYB
         CsFr2jHHg/yOADB2Plk8xCQ/heJFUTOyMGgZ2qIOPwSlj0AHfJYXLQ2mR5IbPHqRFDuo
         n0hX8eKAtkBUili8y3We0E3FteID7jm3ck3fdCDBqcfID2Awdz+0ak1Z6TQVwck+XBBq
         JWvSd3OYCFSKixj/O27P5DMQXAP/P4jH5G1YTbv5iZaP+R0ON0xrjydieUV2gBo1ihgC
         Q3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746973; x=1701351773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIX6Y6OmD18tbJ/H2yRFYnNOAfgH4KdfJCuauNIg3HA=;
        b=rpl4JKAH6swZMYR4V6crN9n9xlaQBoSafSTz20yX5wY1X/xww9Hd1i/qgZBJyDTiZL
         OwuNg/QB8+doSHEbCrERVRqVtOgZGGoLrpSR82GM0n4BXTwqMZhwTvJiMaXY6VnLmcYa
         4kWbRRaa8CvrHy4fVGpZEKtZWWHYrtYZOhZhw5UKQBuQIO9blJbdfTmsOOKahC+st/3B
         KMHHiUDe12Z2vGn4t66mVfLIfpfDfRujoOakAPxkasTQNCpNUtAbWVyTM3lVdxUotv5a
         XNVEHdsPQYXxytmdD0ISWCruqDoVmR1xi+cg4dUgQrN06i4r4RmTG5cDR2OivsDTFcry
         D37w==
X-Gm-Message-State: AOJu0YyiRNehIONpLq4eUBXOY6+M9NkI+cqLhVGheGsWKigoebcUpRQq
        MZ2s39OHl/NdBIgMmmzo0ArLng==
X-Google-Smtp-Source: AGHT+IG0uOhnZ0oXGp4jok8uSMhhwwR3X72qhblR6OJOvkgTiQCc/tbk0F5CdiH2tbybJtIGVJbw+A==
X-Received: by 2002:a05:6512:32a7:b0:509:f68:ed8 with SMTP id q7-20020a05651232a700b005090f680ed8mr3763564lfe.61.1700746973454;
        Thu, 23 Nov 2023 05:42:53 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c475500b0040b2976eb02sm2067241wmo.10.2023.11.23.05.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 05:42:52 -0800 (PST)
Message-ID: <ee3f943d-3f29-415f-bcb0-94e6c8972597@linaro.org>
Date:   Thu, 23 Nov 2023 13:42:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] media: qcom: camss: Add support for named
 power-domains
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231118-b4-camss-named-power-domains-v5-0-55eb0f35a30a@linaro.org>
 <20231118-b4-camss-named-power-domains-v5-5-55eb0f35a30a@linaro.org>
 <6e66875a-5cb1-42bc-86e0-b69cf73981c0@linaro.org>
 <339c3efd-8d2b-4b71-8dc1-cdc30ab7bb8a@linaro.org>
 <2628b928-248b-41c7-81e2-4e4252d2b0f7@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <2628b928-248b-41c7-81e2-4e4252d2b0f7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 23/11/2023 11:49, Konrad Dybcio wrote:
> 
> 
> On 11/22/23 21:55, Bryan O'Donoghue wrote:
>> On 22/11/2023 19:55, Konrad Dybcio wrote:
>>>
>>>
>>> On 11/18/23 13:11, Bryan O'Donoghue wrote:
>>>> Right now we use fixed indexes to assign power-domains, with a
>>>> requirement for the TOP GDSC to come last in the list.
>>>>
>>>> Adding support for named power-domains means the declaration in the 
>>>> dtsi
>>>> can come in any order.
>>>>
>>>> After this change we continue to support the old indexing - if a SoC
>>>> resource declaration or the in-use dtb doesn't declare power-domain 
>>>> names
>>>> we fall back to the default legacy indexing.
>>>>
>>>>  From this point on though new SoC additions should contain named
>>>> power-domains, eventually we will drop support for legacy indexing.
>>>>
>>>> Tested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
>>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>> ---
>>> So, this commit should be a NOP within this series?
>>>
>>> res->pd_name isn't defined anywhere afaics
>>>
>>> Konrad
>>
>> This series is mergeable though the linux-media tree standalone, yes.
>>
>> Once merged, the dtsi change given in the cover letter will be submitted.
> What I meant to say is that something similar to [1] is missing to
> make use of the infra introduced with this patch.
> 
> Konrad
> 
> [1] 
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/f43942091c01c1f263a6e7adbcd0ed8ce723a303

Yeah, to be honest I debated with myself whether or not to include that 
patch since once defined the code here will execute looking for named pd.

I'm not opposed to sending a v6 to include this additional change 
though, I've thoroughly tested on rb5.

---
bod
