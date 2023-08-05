Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3FE770F99
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjHEMVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjHEMVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 08:21:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB74684
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 05:21:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so4987993e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691238085; x=1691842885;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4fuVm2NsarONTn0gk++arYrDspsQdT5CM32pOSdp0c=;
        b=QJL9ADB4Kuz/5Wu91VWjmfN7fZ617JEp6NMhD/mGzyVDc7+FjvKyvCB4JQzKq0+7Cc
         /qUZNM9ryVlA+QJ5DrF93UvDlSyZvDQgjpowFW9gssjYhadFn1n5RmM1sY+yUX/N1CqZ
         apI6uTSE73bs1Jq4EjOWcVMkLgRScIZts/a4Icqb+79raNNEKCctU8pRKesjiteIjbaH
         DpNEejLTxvATx1YeUBT4TJ/nqaS1y9bU7ptvzgZKvyJlU8/w1W1PLhgtSzEkNbDZqaFW
         CwIJ4q+OLwcQsKeT3NPOoYz1LT3GZ2+DOV4/hsUTZVp1qEhB1Ukh3DDzrnJQCTdOHMnI
         eTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691238085; x=1691842885;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4fuVm2NsarONTn0gk++arYrDspsQdT5CM32pOSdp0c=;
        b=ZJPuTn98yF88naginM5+vJ8B+eXplYgy9GR4DzRXwuzWPJ4qPYBtaa6sHVLtQGU1Px
         nifJ/zX3ZTs2+BOKYHS8nh1kIQvi8UiV8CwXJlRee7ERH1iQij90nrMaM9SVJY5kL9Zd
         mkRNKwnD+lgHU6ojgFmcm4I0GB9N4qb2ZKg/8FPUmRo5haVwiMWKFy3pBVgmf4rxqhVk
         rwB2GJ5zTYd/XOIhj1N0rIWmKKii4OkFZ0n5v+PUFfsg/AvtL/wHk+Tk2r++BxGURWrf
         TP8Fd+X7XhM8lgVU3/bZGu1sMtp1P8qk74qkWAK0O8EdcP4qGyWGo9Rns9oAax3C7VGT
         ddpw==
X-Gm-Message-State: AOJu0YwE8a+X7Y+AWriwpjMqQDaAedJgEsnLR4f5X7ABoVnxkZElnN+z
        9d1SyACwOE+gosCKGf4QkFJ6zw==
X-Google-Smtp-Source: AGHT+IEXpLmpelmdAn8s/QxkgEw8dYNuiOYZddosYx6v17IUsra5FyE/WDdeO2FJV6vhmfM57ppyqw==
X-Received: by 2002:a05:6512:3585:b0:4fb:fb4e:7580 with SMTP id m5-20020a056512358500b004fbfb4e7580mr672917lfr.8.1691238084364;
        Sat, 05 Aug 2023 05:21:24 -0700 (PDT)
Received: from [192.168.1.101] (abym15.neoplus.adsl.tpnet.pl. [83.9.32.15])
        by smtp.gmail.com with ESMTPSA id v6-20020ac25606000000b004fb8f4df9bdsm738855lfd.226.2023.08.05.05.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 05:21:23 -0700 (PDT)
Message-ID: <6c0a7f12-10d2-4a07-a07f-67ec0d39b279@linaro.org>
Date:   Sat, 5 Aug 2023 14:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] mailbox/arm64/ qcom: rework compatibles for
 fallback
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.2023 18:41, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v2
> ================
> 1. Split fixes to separate patchset which is now dependency:
>    https://lore.kernel.org/linux-arm-msm/20230322173559.809805-1-krzysztof.kozlowski@linaro.org/T/#t
> 2. Add Ack
> 3. No other changes, as discussion with Dmitry did not reach conclusion on incompatibility.
> 
> Changes since v1
> ================
> 1. Rebase
> 2. Make msm8994 fallback for several variants, not msm8953, because the latter
>    actually might take some clocks.
> 3. Two new patches for SDX55.
> 4. Minor corrections in bindings style.
> v1: https://lore.kernel.org/all/20230202161856.385825-1-krzysztof.kozlowski@linaro.org/
> 
> Description
> ===========
> 
> If entire approach is accepted (and correct), there are no dependencies and
> patches can be picked independently.  Although the best in the same cycle, so
> there will be no new `dtbs_check` warnings.
> 
> Best regards,
> Krzysztof
Looks like this was only partially merged, resulting in schema warnings

Konrad
