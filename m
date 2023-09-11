Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7B79BF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349503AbjIKVdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbjIKLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:22:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442DECE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:22:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so70907471fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694431354; x=1695036154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWYEp19+kxLH9ilfKCkarl8GOyU5SYDVfZv3MA5eqe4=;
        b=mz1Oanf70aSQ1YkqlAtxjvUhIoGj7+/02AxiZlh+CkXaXVyhwjjVoq0buzAdb8gD92
         oP1rx0YIOmKtVnl+A3Jy7mezxIHes54Mka7zPatQM8lrxgbj5Ere217D8JB0t+yiJ3K1
         Q1Isztdrs7Y7egeh6PDW36XUwBqiABG0JBsg1btdYO5c+cHA2WTltZbNQ3pv1tgAVRzt
         YElDcUnsJSNKiCCLklNE+2ugivTZ7QH4Wq02KYWJp4DXKB1nsQl7W8mf03urUM/85Jot
         offUfgLJUn+VQiTDBAsUeygrsxYIAIwtH515oMEnhbfAsu51WXB6Wfp3vr3s0x3iid5b
         GWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694431354; x=1695036154;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWYEp19+kxLH9ilfKCkarl8GOyU5SYDVfZv3MA5eqe4=;
        b=G8ZrRhQzaw0VLycahHlib7484HGx7xcGCjvMW2A6EtFTHrw79qKTAGGWXuJFZJ9coc
         i1a7PD0GfnR6seqIy2a0xhSW5pC2+EyOIE1CD0L1cYo+4zzN4avK3aUkEPyINTWinCfR
         LUnxBqnSBT542mFZ3ZNID5XIPBnTfGgSg197xSkX2klWlbtN6zrs2KzT6NK/rXvvoqRB
         IoJ7+mfvTH74yIl7YA7H07f6xfipBrsDXrzoeGMm87kwvOBHvae0SfYcplLnc2RVL5eE
         Ujzrt/RiwW7C8nlmNkHpOjjMO8s+sas624KTCEj87G+jMTu4EW0cw0dEzl47+1IH2wFD
         /qLw==
X-Gm-Message-State: AOJu0YxSZxvpdA60pmnkCgQVbUeV6Z+kL+BWHpQ94HKvJmIyBwsr4WNZ
        GgW145NJmAQ/IpxwlvC4Jn4Zcu3GUDn/z8um8bzpwA==
X-Google-Smtp-Source: AGHT+IHRLMhGsK6RsT9iyCrETaJpm/vgcvBoo5IaCQ506Q9GN4EWNfwfYVLjJBE5Ml1DRyCm7I/IFA==
X-Received: by 2002:a2e:9e45:0:b0:2bc:dba0:60f9 with SMTP id g5-20020a2e9e45000000b002bcdba060f9mr6734230ljk.44.1694431354467;
        Mon, 11 Sep 2023 04:22:34 -0700 (PDT)
Received: from [192.168.37.232] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id ov27-20020a170906fc1b00b00992c92af6f4sm5207739ejb.144.2023.09.11.04.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:22:33 -0700 (PDT)
Message-ID: <924aa48f-5c23-4e17-8bc0-256887971ba9@linaro.org>
Date:   Mon, 11 Sep 2023 13:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] arm64: dts: qcom: pm7250b: make SID configurable
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com>
 <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
 <CV6NF0466658.20DGU7QKF2UBR@otso>
 <CAA8EJpr1+W3f08X-FpiiVrJ98kg52HaMwbbKn=fG15Whm4C8aQ@mail.gmail.com>
 <728003b9-db27-fdc0-e761-197a02a38c24@linaro.org>
 <CAA8EJpoXreHpxZQ2G10n0OiQzUX4ffk=gvo87dAU4-r+Svqpeg@mail.gmail.com>
 <CVAUDGBO4S08.1F0O66ZE6I4IG@otso> <CVFY7D7ND3WS.2B2EYB4ZO86P@otso>
 <cae7261a-6727-6163-1420-01039bfb8396@linaro.org>
 <CVFZZ0YSWQ6J.2AKRML6LWRMUH@otso>
 <bd418fae-accc-bd79-969a-b3b5791efd35@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <bd418fae-accc-bd79-969a-b3b5791efd35@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.2023 13:15, Krzysztof Kozlowski wrote:
> On 11/09/2023 11:59, Luca Weiss wrote:
>> On Mon Sep 11, 2023 at 11:44 AM CEST, Krzysztof Kozlowski wrote:
>>> On 11/09/2023 10:34, Luca Weiss wrote:
>>>> On Tue Sep 5, 2023 at 10:30 AM CEST, Luca Weiss wrote:
>>>>> On Thu Aug 31, 2023 at 2:27 PM CEST, Dmitry Baryshkov wrote:
>>>>>> On Thu, 31 Aug 2023 at 14:54, Krzysztof Kozlowski
>>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>>
>>>>>>> On 31/08/2023 13:33, Dmitry Baryshkov wrote:
>>>>>>>> On Thu, 31 Aug 2023 at 13:13, Luca Weiss <luca.weiss@fairphone.com> wrote:
>>>>>>>>>
>>>>>>>>> On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
>>>>>>>>>> On 30/08/2023 11:58, Luca Weiss wrote:
>>>>>>>>>>> Like other Qualcomm PMICs the PM7250B can be used on different addresses
>>>>>>>>>>> on the SPMI bus. Use similar defines like the PMK8350 to make this
>>>>>>>>>>> possible.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>>>>>>> ---
>>>>>>>>>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
>>>>>>>>>>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>>>>>>> index e8540c36bd99..3514de536baa 100644
>>>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>>>>>>> @@ -7,6 +7,15 @@
>>>>>>>>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>>>>>>  #include <dt-bindings/spmi/spmi.h>
>>>>>>>>>>>
>>>>>>>>>>> +/* This PMIC can be configured to be at different SIDs */
>>>>>>>>>>> +#ifndef PM7250B_SID
>>>>>>>>>>> +   #define PM7250B_SID 2
>>>>>>>>>>> +#endif
>>>>>>>>>>
>>>>>>>>>> Why do you send the same patch as v1, without any reference to previous
>>>>>>>>>> discussions?
>>>>>>>>>>
>>>>>>>>>> You got here feedback already.
>>>>>>>>>>
>>>>>>>>>> https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org/
>>>>>>>>>
>>>>>>>>> Hi Krzysztof,
>>>>>>>>>
>>>>>>>>> I did mention that original patch in the cover letter of this series.
>>>>>>>>> I'm definitely aware of the discussion earlier this year there but also
>>>>>>>>> tried to get an update lately if there's any update with no response.
>>>>>>>>
>>>>>>>> I think the overall consensus was that my proposal is too complicated
>>>>>>>> for the DT files.
>>>>>>>
>>>>>>> I proposed to duplicate the entries. Do you keep QUP nodes in DTSI and
>>>>>>> customize per address? No.
>>>>>>
>>>>>> At the same time, we do keep SoC files separate from the board files.
>>>>>> Yes, I'm slightly exaggerating here.
>>>>>>
>>>>>> I think that for PMIC files it makes sense to extract common parts if
>>>>>> that eases reuse of the common parts.
>>>>>
>>>>> Hi all,
>>>>>
>>>>> what can I do for v2 now?
>>>>>
>>>>> 1. Keep this patch as-is, and keep pm7250b in device dts.
>>>
>>> This was NAKed by me. What Qualcomm SoC maintainers decide (or not
>>> decide) about other options, should not cause the wrong solution to be
>>> re-posted...
>>>
>>>>>
>>>>> 2. Drop pm7250b patch and drop from device dts, until _someone_ figures
>>>>> out a solution talking to the PMIC on different SID.
>>>>>
>>>>> 3. Something else like copy-pasting pm7250b.dtsi to pm7250-8.dtsi and
>>>>> changing the SID there, and using that in device dts.
>>
>> @Konrad, @Bjorn: Can you give any feedback here what's preferable?
>> Otherwise I'm just blocked on this series.
I'm sure Krzysztof will disagree, but all of the solutions (which are
either duplicate the dt, add ifdefs or skip adding this pmic) are
equally band-aid-class.. A bright future where this PMIC thing is
handled on the driver side that will hopefully come soon(tm) should
resolve such problems..

From my side, ifdef is the least burdensome, even if ugly..

Konrad
