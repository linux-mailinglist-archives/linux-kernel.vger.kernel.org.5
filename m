Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41E679BD9E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbjIKVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbjIKLPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:15:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807BAE4B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:15:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so45442715e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694430946; x=1695035746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oYncRXl8MdgOuj5ecatA5YK1hlf20bUpcsVqj8+B7w=;
        b=iy6Ly+qSIjUUd4/DUtUNVlBHa1u5LTfvhrT/hl4O1wLhMitDehJL8lXvytikvsFVcS
         H/IAUTW7iN5XWLire2POO6epX+pXGgn4E1jMTwlhTDG8n8FR4auFzhs98SAplSxmp1PF
         bCbAY+tCpf2+Udd+6x6m1+oZCxZmzbcRVDo1OptZ06DKeRET75y72J2q0sp08bLPoB+k
         OxnYZYAJotbPiTq/56PeJKOhtcJoOhBkc2b9P1KJDV+DqEW2j0pagLTiXDdOSHI402xq
         GAc7Vmi75iRRMsaf2Jmorz88gcd2/B4xIT1h+3+/oKVyP66b10KM/HrGpbTDYE+j8qt1
         rWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694430946; x=1695035746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oYncRXl8MdgOuj5ecatA5YK1hlf20bUpcsVqj8+B7w=;
        b=uRJYXtZ+tupT6RGkOkdFn8W0a0a60aRLxEtedeZkGjuLjb1TCTKKaO8IMLM9BTTyny
         PYFjeYZufgFswOUCy3nYeZirWG4K6Q4lZ9KusKt3lRcOFOwbnS9EJ84vBixklWzSDHMW
         ZccnzTPCqLMwGOFdnxxKYWbKmj14pNyj+FWAMat012l9P/IY3ItEfe6NzdYicFbwYHVG
         nbCiIsD9xuwDwMaXZyu5MFpDadJxRf9lRzh1ZqB6hprGZeZNsSYsP90rRURvXU7XD+ad
         Df2WmtenKnagJMCg9Qtwn4r4jG4MlOhg7vfd41LtV3WWQ+SWuLUIEeTQAK4WIPVBn5AO
         VXOw==
X-Gm-Message-State: AOJu0YxJAG5tVkA56HIC7N1PC6OjOKJMdXTDWnaYiipOEQg2S4Ou81HJ
        /3bRWLphHWB8o3PHCsndFVxa3Q==
X-Google-Smtp-Source: AGHT+IFMPWetHW3X3w0vf7JC2rs7SsnHakGdeLJ9bxL9NSEuCvaDE4Qf7g+s2Jq63JasENDVFi2WvA==
X-Received: by 2002:a05:600c:6028:b0:402:f55e:ac11 with SMTP id az40-20020a05600c602800b00402f55eac11mr7826062wmb.20.1694430945795;
        Mon, 11 Sep 2023 04:15:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d634d000000b0031c5e9c2ed7sm9783914wrw.92.2023.09.11.04.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:15:45 -0700 (PDT)
Message-ID: <bd418fae-accc-bd79-969a-b3b5791efd35@linaro.org>
Date:   Mon, 11 Sep 2023 13:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 04/11] arm64: dts: qcom: pm7250b: make SID configurable
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CVFZZ0YSWQ6J.2AKRML6LWRMUH@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 11:59, Luca Weiss wrote:
> On Mon Sep 11, 2023 at 11:44 AM CEST, Krzysztof Kozlowski wrote:
>> On 11/09/2023 10:34, Luca Weiss wrote:
>>> On Tue Sep 5, 2023 at 10:30 AM CEST, Luca Weiss wrote:
>>>> On Thu Aug 31, 2023 at 2:27 PM CEST, Dmitry Baryshkov wrote:
>>>>> On Thu, 31 Aug 2023 at 14:54, Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>
>>>>>> On 31/08/2023 13:33, Dmitry Baryshkov wrote:
>>>>>>> On Thu, 31 Aug 2023 at 13:13, Luca Weiss <luca.weiss@fairphone.com> wrote:
>>>>>>>>
>>>>>>>> On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
>>>>>>>>> On 30/08/2023 11:58, Luca Weiss wrote:
>>>>>>>>>> Like other Qualcomm PMICs the PM7250B can be used on different addresses
>>>>>>>>>> on the SPMI bus. Use similar defines like the PMK8350 to make this
>>>>>>>>>> possible.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>>>>>> ---
>>>>>>>>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
>>>>>>>>>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>>>>>> index e8540c36bd99..3514de536baa 100644
>>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>>>>>> @@ -7,6 +7,15 @@
>>>>>>>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>>>>>  #include <dt-bindings/spmi/spmi.h>
>>>>>>>>>>
>>>>>>>>>> +/* This PMIC can be configured to be at different SIDs */
>>>>>>>>>> +#ifndef PM7250B_SID
>>>>>>>>>> +   #define PM7250B_SID 2
>>>>>>>>>> +#endif
>>>>>>>>>
>>>>>>>>> Why do you send the same patch as v1, without any reference to previous
>>>>>>>>> discussions?
>>>>>>>>>
>>>>>>>>> You got here feedback already.
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org/
>>>>>>>>
>>>>>>>> Hi Krzysztof,
>>>>>>>>
>>>>>>>> I did mention that original patch in the cover letter of this series.
>>>>>>>> I'm definitely aware of the discussion earlier this year there but also
>>>>>>>> tried to get an update lately if there's any update with no response.
>>>>>>>
>>>>>>> I think the overall consensus was that my proposal is too complicated
>>>>>>> for the DT files.
>>>>>>
>>>>>> I proposed to duplicate the entries. Do you keep QUP nodes in DTSI and
>>>>>> customize per address? No.
>>>>>
>>>>> At the same time, we do keep SoC files separate from the board files.
>>>>> Yes, I'm slightly exaggerating here.
>>>>>
>>>>> I think that for PMIC files it makes sense to extract common parts if
>>>>> that eases reuse of the common parts.
>>>>
>>>> Hi all,
>>>>
>>>> what can I do for v2 now?
>>>>
>>>> 1. Keep this patch as-is, and keep pm7250b in device dts.
>>
>> This was NAKed by me. What Qualcomm SoC maintainers decide (or not
>> decide) about other options, should not cause the wrong solution to be
>> re-posted...
>>
>>>>
>>>> 2. Drop pm7250b patch and drop from device dts, until _someone_ figures
>>>> out a solution talking to the PMIC on different SID.
>>>>
>>>> 3. Something else like copy-pasting pm7250b.dtsi to pm7250-8.dtsi and
>>>> changing the SID there, and using that in device dts.
> 
> @Konrad, @Bjorn: Can you give any feedback here what's preferable?
> Otherwise I'm just blocked on this series.
> 
>>>>
>>>> Please let me know what to do.
>>>>
>>>> Regards
>>>> Luca
>>>
>>> Hi,
>>>
>>> if there's no feedback I'll keep this patch in v2 of this series and we
>>> can continue to discuss there (if necessary).
>>
>> Sorry, I still do not agree and there were no arguments convincing me to
>> change the mind.
>>
>> I gave you the solution from my perspective. Why do you decided to
>> ignore it and send it as is?
> 
> I get it that you are not final decider for qcom dts changes but it's
> quite difficult for someone sending patches to not get any feedback what
> other change to replace this is appropriate. I doubt it's a good idea to
> just implement some random pm7250-8.dtsi or whatever to potentially
> immediately get a response that that way is also bad.
> 
> That's why I'm trying to get some info before working on something and
> sending it. Hopefully Bjorn or Konrad can add their thoughts above.

I understand, and it is frustrating. If such case happens the solution
in upstream is not sending the same NAKed version but send something else.

> 
> Also I don't recall me ever reading a "solution" from your side but
> maybe I need to dig through the old emails again.

Here:
"I proposed to duplicate the entries. Do you keep QUP nodes in DTSI and
customize per address? No."

Dmitry responded that having PMICs extracted help re-using. He is right.
But here you hit the limit of such re-usage.

Best regards,
Krzysztof

