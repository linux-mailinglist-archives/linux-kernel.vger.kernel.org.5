Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0503779B24
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbjHKW44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbjHKW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:56:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D398130D2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:56:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso4093289e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691794611; x=1692399411;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvR/u+ubiKpwwVm3dF2+LsnJYKHYuUDUWGYwZnhRftE=;
        b=nZDE7krCdSqcYfUf7+RQpjSiuFwLxm/Vre7VMam7D7/eXntWBt0kSXTOKDAf9dSpbF
         uBNdMnIyfFi6sXlWttQPW4+KNPyvhruFVsNiF9KG9k+238GhN4viIn/ySwemKrcX47pk
         YjfcWy/IXfZUTEdxefvo0PJwx/MCPMUDEMqm3pw7DzEdykctGlUDVe2N5CipIk60ZJxz
         9kVqX4sTi6oSh3ljZtgcmEbf4wrc/nFWS5ZRIZJMmzbyUtWzenaV5po8NI5GWHU6AegZ
         bVPyag2k7ISOkA/q0eQ8psOqXyHIEl8oLzGyDuCvYGKMZ4ETgRe/OZHRT/dpCaD9q7ux
         Jdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691794611; x=1692399411;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvR/u+ubiKpwwVm3dF2+LsnJYKHYuUDUWGYwZnhRftE=;
        b=Hs6uD9cpx+mCYsu4CTVYhe5tO9qpkABaIQusVRK6i1Aj2jllEh+lYgbhOtNwAaM0kE
         eWiNrlr3pq25rQHnZA/YTO3LFJIfC5rMtUSM0NaIhFUp1T+P8v0szVV1jdSwTa43LtqM
         ljT8VDwZesj3SE7yK3O+rxQYE+RIQ+LO4kdLzEMjZ2SjmwwHG8SPBfRHZdf4zAUa2n0/
         nROXzb6d9r7nnXJLx3QsjdMcIZ0sQnGHWWbg6MOeXtOWD7Uy/4Kor0vpput+13nAWhhD
         7svAn1rikyA4rkdMz0u3/KxgszmHBLM2/t8eJJQLdfysjyfwEPJQLIfl6q7K+AaKIXlP
         camQ==
X-Gm-Message-State: AOJu0YzF4Ff9iQcz7sKuzdyJRvE8KWybyPDFF2n4sIZaHM3q7r/NVdhx
        +XoPSRMCowLDBzpo4xjksHN+QQ==
X-Google-Smtp-Source: AGHT+IFQaDYVpLPQYdsGDCFAtMQbmv6CWfSPBFhaiKCfz3iyP+iP3Wd9bETjrMmM1z0FDNXlQOXtFQ==
X-Received: by 2002:ac2:5e32:0:b0:4fb:81f2:422b with SMTP id o18-20020ac25e32000000b004fb81f2422bmr1867367lfg.54.1691794611111;
        Fri, 11 Aug 2023 15:56:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651204c700b004fbb610c354sm890107lfq.0.2023.08.11.15.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 15:56:50 -0700 (PDT)
Message-ID: <7116b473-7f22-43df-af39-81e5f6db4507@linaro.org>
Date:   Sat, 12 Aug 2023 00:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node
 with bindings
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230811210142.403160-1-robimarko@gmail.com>
 <20230811210142.403160-2-robimarko@gmail.com>
 <4c96210b-4567-4cb5-80bb-7adca6c5f124@linaro.org>
 <CAOX2RU6X0Tww4UkTKVfc=PLY=RKVJdsm+gomytT0vOydTF+Hnw@mail.gmail.com>
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
In-Reply-To: <CAOX2RU6X0Tww4UkTKVfc=PLY=RKVJdsm+gomytT0vOydTF+Hnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2023 23:35, Robert Marko wrote:
> On Fri, 11 Aug 2023 at 23:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 11.08.2023 23:01, Robert Marko wrote:
>>> Rename the SPI-NOR node to flash@0, remove #address-cells and #size-cells
>>> as they should be under the partitions subnode and use the generic
>>> jedec,spi-nor compatible.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>> You can also do "nandmanufacturer,mx25l25635e", "jedec,spi-nor"
> 
> Hi,
> I grepped the vendor U-Boot to make sure it's not being triggered off
> the mx25l25635e
> compatible but the only hit is the IC support itself.
> MX25L25635 was just the original NOR IC Qualcomm used on the board so
> to me it made
> most sense to just use the JEDEC compatible as NOR itself is JEDEC NOR
> compatible.
OK if dynamic identification works fine

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
