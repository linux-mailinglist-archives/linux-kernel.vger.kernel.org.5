Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E5C793B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjIFL1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjIFL1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:27:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C3519BF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:27:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so2731698a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693999613; x=1694604413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nc2UzmhYFvyz0DWch/D/9FsGtOz/O5Zkd3qroAxACJE=;
        b=YkdWGyDaelzcTwyP5NjGas4MSMNy5Tdv6JqlT0DvnuJhbiqVoLcoraDB6lUQthNtrx
         ARSFFocqqJQO8uu8QTRrY0SQ8v19r57uLlo4N8dj+IC16kQ8kTajRbCnrVbSdZ8T+Buf
         GBilTXsJvwgvBa+OdJHHHfRA2xlVR2++5y0GEnbMxOA1WhB0marh/3vZYJOyAdY1ROcL
         Ql2AzrFMPpfD3csWq17YtqpiC6QKQ3S+Aeqdc+VfkP97Mu/MuEi4v5ygzh+ltFnsj76G
         aZYdEl5Nnw0pxRsKbiRuxrScOw9QCbmQcp+wFPZu8OQTnRqLh0J/Ng5ENjO2dhDw/kGZ
         cXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693999613; x=1694604413;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc2UzmhYFvyz0DWch/D/9FsGtOz/O5Zkd3qroAxACJE=;
        b=CejRvlFuqEK7B20mwmCp7nf85c9BlXwd3suHeeD2ca8Sqt70vP14nqOhOdUOgl7rg9
         L/LtoGY77LHQcs18QoFgjaCa3qqkXNvsw0IpJG2HVMoSEo++FPUKRKjqAIl7bNK6iIe/
         ZoWhMURtHIkd1xd95V1c3gIVcfNGsrwSVhxYNyRcazIIKHA+cyzkNS4z+3uNPt4md25g
         DqC/zWlWRzsvCXU8Kw/KNFIjb6kU95B1Y58YZKNeze44u1V/1ByTmiMuIQ4mKS/bzr57
         +1srzrNWVE+qxLIaBxVlM/+c3DVRMVvPMUvjiNHj6pxt8NC7GgBlc1XGLheGlkIGUaV6
         uJGQ==
X-Gm-Message-State: AOJu0YwVaJnW8bdbIKBXhaE8mMaprwjTEbNmrwQ5I/44MBRwB6Dn266l
        zLXFSztyhY9MsKIXoTnizNwTxQ==
X-Google-Smtp-Source: AGHT+IEvAwzVs9BQEzfStjDNk57pZE3k/Cw6JFk+ya+gsHL6us8tqdS1pIY5Z+9/BEcPGY6B4Af9fw==
X-Received: by 2002:a17:906:3152:b0:992:a836:a194 with SMTP id e18-20020a170906315200b00992a836a194mr2319709eje.59.1693999612783;
        Wed, 06 Sep 2023 04:26:52 -0700 (PDT)
Received: from [192.168.37.154] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id lt20-20020a170906fa9400b009a193a5acffsm8770546ejb.121.2023.09.06.04.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 04:26:52 -0700 (PDT)
Message-ID: <ba8faa45-d097-4301-8583-f724013a8589@linaro.org>
Date:   Wed, 6 Sep 2023 13:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq5332: Fix hwlock index for
 SMEM
Content-Language: en-US
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, stable@vger.kernel.org
References: <20230904172516.479866-1-quic_viswanat@quicinc.com>
 <20230904172516.479866-2-quic_viswanat@quicinc.com>
 <c3880fac-7ed4-4981-87a5-8243a81f7342@linaro.org>
 <11a37c52-51fd-40ec-8613-9c87a03cbd5a@quicinc.com>
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
In-Reply-To: <11a37c52-51fd-40ec-8613-9c87a03cbd5a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.09.2023 13:23, Vignesh Viswanathan wrote:
> 
> 
> On 9/6/2023 3:22 PM, Konrad Dybcio wrote:
>> On 4.09.2023 19:25, Vignesh Viswanathan wrote:
>>> SMEM uses lock index 3 of the TCSR Mutex hwlock for allocations
>>> in SMEM region shared by the Host and FW.
>>>
>>> Fix the SMEM hwlock index to 3 for IPQ5332.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: d56dd7f935e1 ("arm64: dts: qcom: ipq5332: add SMEM support")
>>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>>> ---
>> Your downstream says otherwise [1]. Perhaps you need to fix it there
>> as well?
>>
> 
> Yes, the fix is already merged in the downstream branch but CLO is not
> updated date yet.
Ok

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
