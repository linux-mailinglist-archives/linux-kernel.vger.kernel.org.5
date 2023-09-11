Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5324E79BBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377341AbjIKWVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjIKJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:44:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D381DE4F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:44:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-501bd164fbfso6808052e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694425485; x=1695030285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmsynpPSy7TOyfTB3IX6VnuTU3cYL9zuQjAjoIV3s/c=;
        b=VzBFzEV1J4+IxY34LUtLRlUghGnPQ4UQQBAMmtnYIzgbRpD+uAAD0jtOMvD0RF1OqB
         z9sv0ZNioLLu2E9zlIobh11tDdZPNhqo5Un1eB8pmUlb6FZw1EQVT1WsHkxDLTxS3PtD
         waydRo7pFXWLjuHkEIsi+5mjq81lCfx5zjG88Hj0sNJymCcCLvPEmt/IIQOWr7QqeCv2
         2977GOCSpJBM9a18P86vMO9v0J7mn5Y1xPBMn7v9SAXPshLpCmpYutt+yanb11JXhDds
         J0cTeiKcZkIpiMr11Q2zibDopGx1B53Kb4hoGZGTL5BCj2CAMcQwd3EcQUOeheRclrdz
         7ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425485; x=1695030285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmsynpPSy7TOyfTB3IX6VnuTU3cYL9zuQjAjoIV3s/c=;
        b=qk6HNuzFMPPLwMe9Uv6RnPfzGR657SRDyQ7S+zAZaIoVXl7UhT54gSy/cR52na9NH2
         yO3IE4j6V4W5UNoZTl7Rn3wL9Ywt8m0cYfRmTLTCUxsIR99t4dMtNGGNzHBk9QgweATB
         PICoLpZkb1m1wMZ6I3cy+cOwlqsA8bSpXYSiGbkOaR41WtQuPGjCBfKxzLivXQwoMd0Y
         I2H6I7Q/DyCXBkhCGPdyJPkT8s/G6Uz2VTJIAOj4zNbjja+dnFigHs5D2YVlGAAv4/Xc
         0Eis3QRvK0U3fUiP0+i7HNwdaFGwW/3IAssFVGUBVHJPAXDWE+Gtpa7pg6uWMaVMbpIN
         7H5A==
X-Gm-Message-State: AOJu0YxX/cM+g3zWJh9BSEeHUvcaaZ8udAsnYN0UO36cmNT1RmB2I4hA
        8aRbXTHoskeNtLXBEGmpB9Jntg==
X-Google-Smtp-Source: AGHT+IFVrYxA7iHydVJRTySy5FxdaMSR909EKZE3dfa0mH+F5dKlXdxHMp4UmfcWfyRPypkx7BXujw==
X-Received: by 2002:ac2:5bd1:0:b0:4fd:faf0:6591 with SMTP id u17-20020ac25bd1000000b004fdfaf06591mr6586243lfn.10.1694425484839;
        Mon, 11 Sep 2023 02:44:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090652c500b0099bd453357esm5030071ejn.41.2023.09.11.02.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:44:43 -0700 (PDT)
Message-ID: <cae7261a-6727-6163-1420-01039bfb8396@linaro.org>
Date:   Mon, 11 Sep 2023 11:44:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 04/11] arm64: dts: qcom: pm7250b: make SID configurable
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CVFY7D7ND3WS.2B2EYB4ZO86P@otso>
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

On 11/09/2023 10:34, Luca Weiss wrote:
> On Tue Sep 5, 2023 at 10:30 AM CEST, Luca Weiss wrote:
>> On Thu Aug 31, 2023 at 2:27 PM CEST, Dmitry Baryshkov wrote:
>>> On Thu, 31 Aug 2023 at 14:54, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 31/08/2023 13:33, Dmitry Baryshkov wrote:
>>>>> On Thu, 31 Aug 2023 at 13:13, Luca Weiss <luca.weiss@fairphone.com> wrote:
>>>>>>
>>>>>> On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
>>>>>>> On 30/08/2023 11:58, Luca Weiss wrote:
>>>>>>>> Like other Qualcomm PMICs the PM7250B can be used on different addresses
>>>>>>>> on the SPMI bus. Use similar defines like the PMK8350 to make this
>>>>>>>> possible.
>>>>>>>>
>>>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>>>> ---
>>>>>>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
>>>>>>>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>>>> index e8540c36bd99..3514de536baa 100644
>>>>>>>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>>>> @@ -7,6 +7,15 @@
>>>>>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>>>  #include <dt-bindings/spmi/spmi.h>
>>>>>>>>
>>>>>>>> +/* This PMIC can be configured to be at different SIDs */
>>>>>>>> +#ifndef PM7250B_SID
>>>>>>>> +   #define PM7250B_SID 2
>>>>>>>> +#endif
>>>>>>>
>>>>>>> Why do you send the same patch as v1, without any reference to previous
>>>>>>> discussions?
>>>>>>>
>>>>>>> You got here feedback already.
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org/
>>>>>>
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> I did mention that original patch in the cover letter of this series.
>>>>>> I'm definitely aware of the discussion earlier this year there but also
>>>>>> tried to get an update lately if there's any update with no response.
>>>>>
>>>>> I think the overall consensus was that my proposal is too complicated
>>>>> for the DT files.
>>>>
>>>> I proposed to duplicate the entries. Do you keep QUP nodes in DTSI and
>>>> customize per address? No.
>>>
>>> At the same time, we do keep SoC files separate from the board files.
>>> Yes, I'm slightly exaggerating here.
>>>
>>> I think that for PMIC files it makes sense to extract common parts if
>>> that eases reuse of the common parts.
>>
>> Hi all,
>>
>> what can I do for v2 now?
>>
>> 1. Keep this patch as-is, and keep pm7250b in device dts.

This was NAKed by me. What Qualcomm SoC maintainers decide (or not
decide) about other options, should not cause the wrong solution to be
re-posted...

>>
>> 2. Drop pm7250b patch and drop from device dts, until _someone_ figures
>> out a solution talking to the PMIC on different SID.
>>
>> 3. Something else like copy-pasting pm7250b.dtsi to pm7250-8.dtsi and
>> changing the SID there, and using that in device dts.
>>
>> Please let me know what to do.
>>
>> Regards
>> Luca
> 
> Hi,
> 
> if there's no feedback I'll keep this patch in v2 of this series and we
> can continue to discuss there (if necessary).

Sorry, I still do not agree and there were no arguments convincing me to
change the mind.

I gave you the solution from my perspective. Why do you decided to
ignore it and send it as is?


Best regards,
Krzysztof

