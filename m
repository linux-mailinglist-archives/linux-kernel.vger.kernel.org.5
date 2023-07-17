Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4F756E10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjGQUTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGQUTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:19:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5BC18B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:19:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b708e49059so76166261fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689625166; x=1692217166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT95tFT96QhXbNqSGHmz3kdxmAgbV5cr95EhcCxQElI=;
        b=Vc5pvu+yk4BljMbr5NJv2jpJJ4nqpDDtp8yZbaWWa46iN2FTbLxjUo2sZBPWUo4NWJ
         TIHIpFVQ7igvgeTq5p3sYlZRMLcifNxhad8pGdt1Wqv1EeBGCk7MuKLktBlUVfYFxCRY
         5d91T1mHEa2uXtcpr3D9qs+LHt57jGj3bu6XlvEZyEC2UnqOnGwnVQXokmzGq8GDx+SE
         XmYQXapgVOGDhl701QKRSxfup6pida42Xfqu+IFmoznp5PnCVgeY4nDSMYIQPXzBKka3
         8zqT5rOq0O+5NX9PnUYpneYl8jgrfBjq1mDHGu4Q7NUkWhHwgevBPaXQqs1UioKvMX3i
         LOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625166; x=1692217166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QT95tFT96QhXbNqSGHmz3kdxmAgbV5cr95EhcCxQElI=;
        b=RsY+g26V+kwM+19Ds+IWzp0Oj/aLeUNYVu8jGcsA10fB5OEPpNYImRqPePxVVbnAPV
         UZi9JfIVZRjyucLnT5BNnhEf4QQlmy/Z0+H2x4tmaxcfeMsCU1wx56jN1j/g/HKhCVIf
         zhNfG14sed/xIR0TKu88uWE+a8euzcl1T2zALy42YiCRSeUl7QotBWIdqyT708DKm2+I
         HF7CuHkW8ZF0QPqdswVi21x8DBhIzSx9uKrcvLNF/4TEYZ9xdNX9+2WQcrzZouDADNPk
         jJ0sC/jgF13ro/QVfUIQF2Vw9GtyWMYBZ3NFylXziB31kbWuMmHdj4peK+0hvTVNoXjV
         knjw==
X-Gm-Message-State: ABy/qLbGD+0V+hnh3DD0O+Zfh8NIqGftrbBxYdTn4ua/lfgz50smUBU9
        9QK8aMzGBSSjUvuJ92dNzAtAXA==
X-Google-Smtp-Source: APBJJlHZktGOsHd5r4797G/opftgBKdZIwBm6vlSanKfUXBVFkeHbs0HGwNdIVnTEYtP4YoTU+PLwQ==
X-Received: by 2002:a2e:83c9:0:b0:2b6:a057:8098 with SMTP id s9-20020a2e83c9000000b002b6a0578098mr8765102ljh.0.1689625165734;
        Mon, 17 Jul 2023 13:19:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id f3-20020a2e9183000000b002b6d576a257sm84868ljg.96.2023.07.17.13.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:19:25 -0700 (PDT)
Message-ID: <81491f7e-bd2c-7e3c-14c4-a7547d76c307@linaro.org>
Date:   Mon, 17 Jul 2023 22:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 3/4] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3
 connector
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAH=2NtxHekJVvzaD5SNhZZmAHXhc=7v4Pr7RMEFNTXXH6x_AgQ@mail.gmail.com>
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

On 17.07.2023 22:09, Bhupesh Sharma wrote:
> On Mon, 17 Jul 2023 at 23:58, Stephan Gerhold <stephan@gerhold.net> wrote:
>>
>> On Mon, Jul 17, 2023 at 11:33:40PM +0530, Bhupesh Sharma wrote:
>>> On Mon, 17 Jul 2023 at 16:15, Stephan Gerhold <stephan@gerhold.net> wrote:
>>>>
>>>> On Mon, Jul 17, 2023 at 04:02:35PM +0530, Bhupesh Sharma wrote:
>>>>> Add the Embedded USB Debugger(EUD) device tree node for
>>>>> SM6115 / SM4250 SoC.
>>>>>
>>>>> The node contains EUD base register region, EUD mode manager
>>>>> register region and TCSR Base register region along with the
>>>>> interrupt entry.
>>>>>
>>>>> [...]
>>>>>
>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 50 ++++++++++++++++++++++++++++
>>>>>  1 file changed, 50 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> index 839c603512403..db45337c1082c 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> [...]
>>>>> @@ -789,6 +801,37 @@ gcc: clock-controller@1400000 {
>>>>>                       #power-domain-cells = <1>;
>>>>>               };
>>>>>
>>>>> +             eud: eud@1610000 {
>>>>> +                     compatible = "qcom,sm6115-eud", "qcom,eud";
>>>>> +                     reg = <0x0 0x01610000 0x0 0x2000>,
>>>>> +                           <0x0 0x01612000 0x0 0x1000>,
>>>>> +                           <0x0 0x003c0000 0x0 0x40000>;
>>>>> +                     reg-names = "eud-base", "eud-mode-mgr", "tcsr-base";
>>>>
>>>> TCSR is a separate hardware block unrelated to the EUD. IMHO it
>>>> shouldn't be listed as "reg" here.
>>>>
>>>> Typically we describe it as syscon and then reference it from other
>>>> nodes. See e.g. sm8450.dtsi "tcsr: syscon@1fc0000" referenced in &scm
>>>> "qcom,dload-mode = <&tcsr 0x13000>". This is pretty much exactly the
>>>> same use case as you have. It also uses this to write something with
>>>> qcom_scm_io_writel() at the end.
>>>
>>> That was discussed a bit during v1 patchset review. Basically, if we
>>> use a tcsr syscon approach here, we will need to define a 'qcom,xx'
>>> vendor specific dt-property and use something like this in the eud
>>> node:
>>>
>>> qcom,eud-sec-reg = <&tcsr_reg yyyy>
>>>
>>> which would be then used by the eud driver (via
>>> syscon_regmap_lookup_by_phandle()).
>>>
>>> But for sm6115 / qcm2290 this would be an over complicated solution as
>>> normally the eud driver (say sc7280) doesn't need tcsr based secure
>>> mode manager access. So defining a new soc / vendor specific
>>> dt-property might be an overkill.
>>>
>>
>> IMO a vendor-specific DT property is still better than messing up the
>> device separation in the device tree. The same "tcsr-base" reg would
>> also appear on the actual tcsr syscon device tree node. Having two
>> device tree nodes with the same reg region is generally not valid.
>>
>> Something like qcom,eud-sec-reg = <&tcsr_reg yyyy> would at least make
>> clear that this points into a region that is shared between multiple
>> different devices, while adding it as reg suggests that TCSR belongs
>> exclusively to EUD.
> 
> I understand your point but since for sm6115 / qcm2290 devices TCSR is
> not used for any other purpose than EUD, I still think introducing a
> new soc / vendor specific dt-property might be an overkill for this
> changeset.
Untrue, there's some mumblings around the PHY properties and PSHOLD.
I think Stephan may be correct here.

Konrad
> 
> Thanks,
> Bhupesh
