Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A9756E28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGQUY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjGQUY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:24:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C611A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:24:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b708e49059so76249381fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689625492; x=1692217492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUha6zP+pey617bAE9nj1T4TSqiGgsTLog4w9UJtrTA=;
        b=IM9hICpwouhsLSCknjO9XjDCzOYULSfgjqbI9PI1W0pRO5I1kCdttJzPT6Zni+6nVC
         KSix+oSbJvafF2DE0UtQeEQj7n0a58DTw3o+BV33yOtas/TWKno4UiA2phdvv5Y3AbJx
         XmZTZajZRTM+21aDTZ5s8zJLWJ5CSex2WsR7GDKMiOYrURl/+yOOVAtOPqlaGYystFMZ
         rvnR5gHQwrjpMIQKZiOfxsz7XM3lsPg4eJhzad74C2geBtz/nXJsPuSr4Rl+qEXXg8zK
         wRKlXNx+jf9pAP/Lqgf9MRZ1rZn8GskhU0/Uf+mHqOd4AvjAB5GkK/p9m7dJqwTh80U4
         xCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625492; x=1692217492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUha6zP+pey617bAE9nj1T4TSqiGgsTLog4w9UJtrTA=;
        b=BmtyGRgygoFt+PWEE/ZPB61B9Vws1cFwrcppschmHWFRH73QCLsHwZ0AI4ZPgAhcJm
         LXW0zlqO/7M2qk9DZAvNwBfT9R7ZAXdJBm89nwnlaA7WdqR4DLmhiorXE+Kbw+R7jqrO
         q64mLe2kMAfzfqXW6jdXwI7RvMbqXf6KgW1EKti2UkZMMUGxhETFCPJvExROne20CyWM
         XJIHzHet8NtousiCWyJ2LVhUqepqf51Zf8CtNPBAFg3lSoVXI7agPtTFzFxMAdN4Ea86
         ss+7ImrjhYw4k+kOhhFLxXM3lrPGQg+XRNunzms15efOujn6BLD10q/j7l1ZeiUppt8Y
         wQ1Q==
X-Gm-Message-State: ABy/qLbZPKfmRW7h7Nehxha6MTH/Lkq4tFugAtaCEMdPXeVPquHW8+9Q
        p7ZTczHHwOfAXRnfiZPstRZ15w==
X-Google-Smtp-Source: APBJJlHTE3P2Yns04At4vfYRLGnCqDQcP7p3/vrNdbYj1jE0GoHxv6VGcAh6LvGVaOV6EEOZYRZ+bw==
X-Received: by 2002:a05:6512:3f8:b0:4fb:76f7:fde9 with SMTP id n24-20020a05651203f800b004fb76f7fde9mr7271957lfq.30.1689625492258;
        Mon, 17 Jul 2023 13:24:52 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id p24-20020ac246d8000000b004fb326d4ff0sm75263lfo.77.2023.07.17.13.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:24:51 -0700 (PDT)
Message-ID: <5f415647-0cec-b4cd-f9a8-6b6690615498@linaro.org>
Date:   Mon, 17 Jul 2023 22:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 3/4] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3
 connector
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, quic_schowdhu@quicinc.com,
        gregkh@linuxfoundation.org
References: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
 <20230717103236.1246771-4-bhupesh.sharma@linaro.org>
 <ZLUbyocjNT2bGvVt@gerhold.net>
 <CAH=2NtzM=jaVtjeHHO0rY0_wHu9==Jpdz4zx5nCK3gBh2kpL=A@mail.gmail.com>
 <ZLWHwnjjMkJx_ACH@gerhold.net>
 <CAH=2NtxHekJVvzaD5SNhZZmAHXhc=7v4Pr7RMEFNTXXH6x_AgQ@mail.gmail.com>
 <81491f7e-bd2c-7e3c-14c4-a7547d76c307@linaro.org>
 <CAH=2NtxX9jC6-7=bWEWTtgO=5VqX5U_ngnC6vWFZxDJUdsdg+g@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAH=2NtxX9jC6-7=bWEWTtgO=5VqX5U_ngnC6vWFZxDJUdsdg+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.2023 22:22, Bhupesh Sharma wrote:
> On Tue, 18 Jul 2023 at 01:49, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 17.07.2023 22:09, Bhupesh Sharma wrote:
>>> On Mon, 17 Jul 2023 at 23:58, Stephan Gerhold <stephan@gerhold.net> wrote:
>>>>
>>>> On Mon, Jul 17, 2023 at 11:33:40PM +0530, Bhupesh Sharma wrote:
>>>>> On Mon, 17 Jul 2023 at 16:15, Stephan Gerhold <stephan@gerhold.net> wrote:
>>>>>>
>>>>>> On Mon, Jul 17, 2023 at 04:02:35PM +0530, Bhupesh Sharma wrote:
>>>>>>> Add the Embedded USB Debugger(EUD) device tree node for
>>>>>>> SM6115 / SM4250 SoC.
>>>>>>>
>>>>>>> The node contains EUD base register region, EUD mode manager
>>>>>>> register region and TCSR Base register region along with the
>>>>>>> interrupt entry.
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>>>>> ---
>>>>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 50 ++++++++++++++++++++++++++++
>>>>>>>  1 file changed, 50 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>>> index 839c603512403..db45337c1082c 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>>>> [...]
>>>>>>> @@ -789,6 +801,37 @@ gcc: clock-controller@1400000 {
>>>>>>>                       #power-domain-cells = <1>;
>>>>>>>               };
>>>>>>>
>>>>>>> +             eud: eud@1610000 {
>>>>>>> +                     compatible = "qcom,sm6115-eud", "qcom,eud";
>>>>>>> +                     reg = <0x0 0x01610000 0x0 0x2000>,
>>>>>>> +                           <0x0 0x01612000 0x0 0x1000>,
>>>>>>> +                           <0x0 0x003c0000 0x0 0x40000>;
>>>>>>> +                     reg-names = "eud-base", "eud-mode-mgr", "tcsr-base";
>>>>>>
>>>>>> TCSR is a separate hardware block unrelated to the EUD. IMHO it
>>>>>> shouldn't be listed as "reg" here.
>>>>>>
>>>>>> Typically we describe it as syscon and then reference it from other
>>>>>> nodes. See e.g. sm8450.dtsi "tcsr: syscon@1fc0000" referenced in &scm
>>>>>> "qcom,dload-mode = <&tcsr 0x13000>". This is pretty much exactly the
>>>>>> same use case as you have. It also uses this to write something with
>>>>>> qcom_scm_io_writel() at the end.
>>>>>
>>>>> That was discussed a bit during v1 patchset review. Basically, if we
>>>>> use a tcsr syscon approach here, we will need to define a 'qcom,xx'
>>>>> vendor specific dt-property and use something like this in the eud
>>>>> node:
>>>>>
>>>>> qcom,eud-sec-reg = <&tcsr_reg yyyy>
>>>>>
>>>>> which would be then used by the eud driver (via
>>>>> syscon_regmap_lookup_by_phandle()).
>>>>>
>>>>> But for sm6115 / qcm2290 this would be an over complicated solution as
>>>>> normally the eud driver (say sc7280) doesn't need tcsr based secure
>>>>> mode manager access. So defining a new soc / vendor specific
>>>>> dt-property might be an overkill.
>>>>>
>>>>
>>>> IMO a vendor-specific DT property is still better than messing up the
>>>> device separation in the device tree. The same "tcsr-base" reg would
>>>> also appear on the actual tcsr syscon device tree node. Having two
>>>> device tree nodes with the same reg region is generally not valid.
>>>>
>>>> Something like qcom,eud-sec-reg = <&tcsr_reg yyyy> would at least make
>>>> clear that this points into a region that is shared between multiple
>>>> different devices, while adding it as reg suggests that TCSR belongs
>>>> exclusively to EUD.
>>>
>>> I understand your point but since for sm6115 / qcm2290 devices TCSR is
>>> not used for any other purpose than EUD, I still think introducing a
>>> new soc / vendor specific dt-property might be an overkill for this
>>> changeset.
>> Untrue, there's some mumblings around the PHY properties and PSHOLD.
>> I think Stephan may be correct here.
> 
> Can you share the links to those discussions?
It just seemed off to me that TCSR was not used by anything else (even
from Linux, it would obviously be used by something else higher up in
the boot chain as it contains various configuration registers), so I
took a glance at the downstream device tree and I noticed there are
more users.

Konrad
