Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF627997D1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345485AbjIIMBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjIIMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:01:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D1EE47
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 05:01:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50091b91a83so4744483e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694260859; x=1694865659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXV2JooyU/PVZz1WOaLJre5p9nBH4SIKLGIwtPU9WVk=;
        b=Qr0+mp0o5TuxkZieRfU+49Rnn2yFEe54cM+GauKHZGwg4oDN3T4adON4uiVpleIJNK
         +8kaa+ia/AUETrK/K/aqqtC8WqP4FUtRVJ07r9okHabyMnPNNV4lCK2yBnYTyHfxbyAP
         OTfGEnZopfozZsU/vrcKWYOy8GBNeMuQ9kXyE9xRl/EbrWClrlmgI87wDu4Kt/jmA6ju
         2ZNZFupftxGVNk8e/nk9hhx60dlSCJxOf88iDURE1lUQTHlu3dCFK1LaujU+neQtTE4U
         t8NqzRAkQuNbSLvAZLBxY6kW1M2dgozyzqR3kJEf6jQqRjaPuads/cFcp8Q4Pwfw459W
         4HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694260859; x=1694865659;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXV2JooyU/PVZz1WOaLJre5p9nBH4SIKLGIwtPU9WVk=;
        b=WtUK/d2WWWJRGwN1TN1wVaXvctD7CyPT2TuL9co03xOwZeXBr4hBrQ9SxespSG2H9v
         5t8KeamoOYaTPDdfS6KXSc3E+8ovAE1uC50/YkVIlvv1ZxJY5ut9wLGWSf5D04b2hrie
         UF+Csp4fgm5WZTQ+zAZd/VIoDdziGr8qCiR7Z1IBOpq00BJWD3xqlMoXKmdNir94GEh8
         5j0onihWGR5mFqB/lU9Q+MpBbeiDJlsrlQ6DJ2VqCHyfzqlHjWtpVawqNACDdIhcyMXW
         QKdk91MTgWjRFkK6OuFNcyM5baD6tex7Zhp5niDKR4jNQnKUGPGjQtyobUBUbrsbaPme
         Ifpw==
X-Gm-Message-State: AOJu0YybRp4nx7Z7uQzwWaa6XMaGE1tyQyFUWeFqV6C4bJfT2LKQs1oL
        E4ZcfVDvuNc8jMVGMWqBoOMlrMwvIX2tQ+2EpXq3qQ==
X-Google-Smtp-Source: AGHT+IEYqCmpQrlx5z5ec9Gq6+UfbjbdOIz63oVWUFTi4HiNMpr7f/UdD30eM+b1F1IGzpWr6FhCug==
X-Received: by 2002:a19:910a:0:b0:4fd:d172:fc2c with SMTP id t10-20020a19910a000000b004fdd172fc2cmr3314242lfd.21.1694260858672;
        Sat, 09 Sep 2023 05:00:58 -0700 (PDT)
Received: from [192.168.37.232] (178235177205.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.205])
        by smtp.gmail.com with ESMTPSA id e2-20020a50ec82000000b0052a48f4065esm2109463edr.39.2023.09.09.05.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 05:00:58 -0700 (PDT)
Message-ID: <b1360b3d-0414-46ab-9069-18c8370ae179@linaro.org>
Date:   Sat, 9 Sep 2023 14:00:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/9] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
 <20230217-topic-cpr3h-v14-3-9fd23241493d@linaro.org>
 <CAPDyKFrXT+2NEMUzVv-kWjXAhLinXq99GKq4_Ge2VjthtYxtaA@mail.gmail.com>
 <20230831162835.GA2390385-robh@kernel.org>
 <f1f60df1-7632-48a2-a211-dcd6c1fa419f@linaro.org>
 <CAPDyKFokY6F3dxhR3d8PyUwTvLOrt6+W=_JbfvGW_4XHHPaTsg@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 xsFNBF9ALYUBEADWAhxdTBWrwAgDQQzc1O/bJ5O7b6cXYxwbBd9xKP7MICh5YA0DcCjJSOum
 BB/OmIWU6X+LZW6P88ZmHe+KeyABLMP5s1tJNK1j4ntT7mECcWZDzafPWF4F6m4WJOG27kTJ
 HGWdmtO+RvadOVi6CoUDqALsmfS3MUG5Pj2Ne9+0jRg4hEnB92AyF9rW2G3qisFcwPgvatt7
 TXD5E38mLyOPOUyXNj9XpDbt1hNwKQfiidmPh5e7VNAWRnW1iCMMoKqzM1Anzq7e5Afyeifz
 zRcQPLaqrPjnKqZGL2BKQSZDh6NkI5ZLRhhHQf61fkWcUpTp1oDC6jWVfT7hwRVIQLrrNj9G
 MpPzrlN4YuAqKeIer1FMt8cq64ifgTzxHzXsMcUdclzq2LTk2RXaPl6Jg/IXWqUClJHbamSk
 t1bfif3SnmhA6TiNvEpDKPiT3IDs42THU6ygslrBxyROQPWLI9IL1y8S6RtEh8H+NZQWZNzm
 UQ3imZirlPjxZtvz1BtnnBWS06e7x/UEAguj7VHCuymVgpl2Za17d1jj81YN5Rp5L9GXxkV1
 aUEwONM3eCI3qcYm5JNc5X+JthZOWsbIPSC1Rhxz3JmWIwP1udr5E3oNRe9u2LIEq+wH/toH
 kpPDhTeMkvt4KfE5m5ercid9+ZXAqoaYLUL4HCEw+HW0DXcKDwARAQABzShLb25yYWQgRHli
 Y2lvIDxrb25yYWQuZHliY2lvQGxpbmFyby5vcmc+wsGOBBMBCAA4FiEEU24if9oCL2zdAAQV
 R4cBcg5dfFgFAmQ5bqwCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQR4cBcg5dfFjO
 BQ//YQV6fkbqQCceYebGg6TiisWCy8LG77zV7DB0VMIWJv7Km7Sz0QQrHQVzhEr3trNenZrf
 yy+o2tQOF2biICzbLM8oyQPY8B///KJTWI2khoB8IJSJq3kNG68NjPg2vkP6CMltC/X3ohAo
 xL2UgwN5vj74QnlNneOjc0vGbtA7zURNhTz5P/YuTudCqcAbxJkbqZM4WymjQhe0XgwHLkiH
 5LHSZ31MRKp/+4Kqs4DTXMctc7vFhtUdmatAExDKw8oEz5NbskKbW+qHjW1XUcUIrxRr667V
 GWH6MkVceT9ZBrtLoSzMLYaQXvi3sSAup0qiJiBYszc/VOu3RbIpNLRcXN3KYuxdQAptacTE
 mA+5+4Y4DfC3rUSun+hWLDeac9z9jjHm5rE998OqZnOU9aztbd6zQG5VL6EKgsVXAZD4D3RP
 x1NaAjdA3MD06eyvbOWiA5NSzIcC8UIQvgx09xm7dThCuQYJR4Yxjd+9JPJHI6apzNZpDGvQ
 BBZzvwxV6L1CojUEpnilmMG1ZOTstktWpNzw3G2Gis0XihDUef0MWVsQYJAl0wfiv/0By+XK
 mm2zRR+l/dnzxnlbgJ5pO0imC2w0TVxLkAp0eo0LHw619finad2u6UPQAkZ4oj++iIGrJkt5
 Lkn2XgB+IW8ESflz6nDY3b5KQRF8Z6XLP0+IEdLOOARkOW7yEgorBgEEAZdVAQUBAQdAwmUx
 xrbSCx2ksDxz7rFFGX1KmTkdRtcgC6F3NfuNYkYDAQgHwsF2BBgBCAAgFiEEU24if9oCL2zd
 AAQVR4cBcg5dfFgFAmQ5bvICGwwACgkQR4cBcg5dfFju1Q//Xta1ShwL0MLSC1KL1lXGXeRM
 8arzfyiB5wJ9tb9U/nZvhhdfilEDLe0jKJY0RJErbdRHsalwQCrtq/1ewQpMpsRxXzAjgfRN
 jc4tgxRWmI+aVTzSRpywNahzZBT695hMz81cVZJoZzaV0KaMTlSnBkrviPz1nIGHYCHJxF9r
 cIu0GSIyUjZ/7xslxdvjpLth16H27JCWDzDqIQMtg61063gNyEyWgt1qRSaK14JIH/DoYRfn
 jfFQSC8bffFjat7BQGFz4ZpRavkMUFuDirn5Tf28oc5ebe2cIHp4/kajTx/7JOxWZ80U70mA
 cBgEeYSrYYnX+UJsSxpzLc/0sT1eRJDEhI4XIQM4ClIzpsCIN5HnVF76UQXh3a9zpwh3dk8i
 bhN/URmCOTH+LHNJYN/MxY8wuukq877DWB7k86pBs5IDLAXmW8v3gIDWyIcgYqb2v8QO2Mqx
 YMqL7UZxVLul4/JbllsQB8F/fNI8AfttmAQL9cwo6C8yDTXKdho920W4WUR9k8NT/OBqWSyk
 bGqMHex48FVZhexNPYOd58EY9/7mL5u0sJmo+jTeb4JBgIbFPJCFyng4HwbniWgQJZ1WqaUC
 nas9J77uICis2WH7N8Bs9jy0wQYezNzqS+FxoNXmDQg2jetX8en4bO2Di7Pmx0jXA4TOb9TM
 izWDgYvmBE8=
In-Reply-To: <CAPDyKFokY6F3dxhR3d8PyUwTvLOrt6+W=_JbfvGW_4XHHPaTsg@mail.gmail.com>
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

On 1.09.2023 00:02, Ulf Hansson wrote:
> On Thu, 31 Aug 2023 at 18:40, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 31.08.2023 18:28, Rob Herring wrote:
>>> On Tue, Aug 29, 2023 at 01:01:44PM +0200, Ulf Hansson wrote:
>>>> On Mon, 28 Aug 2023 at 13:42, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>>
>>>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>>>
>>>>> Add the bindings for the CPR3 driver to the documentation.
>>>>>
>>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>>> [Konrad: Make binding check pass; update AGdR's email]
>>>>> Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>>  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 286 +++++++++++++++++++++
>>>>>  1 file changed, 286 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..acf2e294866b
>>>>
>>>> [...]
>>>>
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>> +
>>>>> +    cpus {
>>>>> +        #address-cells = <2>;
>>>>> +        #size-cells = <0>;
>>>>> +
>>>>> +        cpu@0 {
>>>>> +            compatible = "qcom,kryo280";
>>>>> +            device_type = "cpu";
>>>>> +            reg = <0x0 0x0>;
>>>>> +            operating-points-v2 = <&cpu0_opp_table>;
>>>>> +            power-domains = <&apc_cprh 0>;
>>>>> +            power-domain-names = "cprh";
>>>>
>>>> Rather than using a Qcom specific power-domain-name, perhaps a common
>>>> power-domain-name for cpus, that can be used for "the performance
>>>> domain" would be a good idea here?
>>>>
>>>> I have suggested using "perf" for the SCMI performance domain [1],
>>>> perhaps that description should be extended to cover this and other
>>>> performance domains too?
>>>
>>> Better yet, nothing. There's no value to -names when there is only 1
>>> entry.
>> As of today, it's required for devm_pm_opp_attach_genpd()
>>
>> Ulf, is there a better way to do this that doesn't require names?
> 
> In my opinion I think using names is valuable from a future and
> flexibility point of view. To pick the proper name is another
> question.
> 
> Anyway, in this case I think you should consider the case of
> potentially having multiple power-domains for the cpu. Having both a
> cpr(h) (for performance-scaling) and a psci (for power) power-domain
> sounds like a combination that should already exist. Maybe not
> upstream wise, but at least this is what I have been told to exist
> several years ago by Qcom engineers.
Riiight I completely forgot about PSCI cpuidle..

Konrad
