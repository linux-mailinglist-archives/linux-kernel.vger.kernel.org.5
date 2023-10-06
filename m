Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BBC7BC311
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjJFXrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbjJFXrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:47:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266A4C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:47:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so2585933f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 16:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696636065; x=1697240865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjGK0/6qgtKOqmSnRUWSkBW57qXKO6wGZP23q42Isck=;
        b=r8pQsvcsmW4f41SJoVGoUtvSUSw0AXMUb8bx1Vw1g5ABYgP7bXY6nD1Lxcoq/0XqwQ
         uFUVvmmiatFINpp4Cuf4oSTZdjjyqT6ftsbkUrw8GkonqaMLBr53fl+oE5NgIKc8NcfI
         bZ2hS7HPsPCR68PwiiD8ik/XJb5lscLaYyAQzBfcCC+6x60Ipj6ZUHrj+zVHvOz83Aoo
         p3HEDhWcudX91eLU6GQMEFaBckBFDccmOvVz/O/3D6vZ4cmG+bCXyXhdiwCtLNIo0QQe
         TmGFBlu0t3gDIvYV6j2NElYD8hluO97NBJJB0GIxndXFWx5cyamV5cjLRSuOIDobmCpK
         8edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696636065; x=1697240865;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjGK0/6qgtKOqmSnRUWSkBW57qXKO6wGZP23q42Isck=;
        b=QApMpaBFXp6E4BYS3yFPdIIJ29s6Vm1olhoQee67o7FFd0R7Rn/t/DIHCvGOaCUtSv
         yzoptE0nBTBOlydtXQWWFineGSq2r1IG3gZp5rZT9Fymg9XrXy08TY4L+SQYnjD9TQtk
         XQXpC6ejQPcYG/xCaopE3fXNa+dEY5xxGPBmtifwlDjNMfU97X8uCeKFGtDxEvwTV1I3
         ddxN/kFE33Tsy7Ul3yp4gKEgHRO2WAxcgA4/EPGYJN/5S3M0jZdUKfNb220Ik6i0zOFW
         UK2OjhIjCWqoXOlyF7tIcRou+NIv+ImR+vBEWgpOsqrTje68hcVUlKgttCIIaJ3Kpr7z
         trsw==
X-Gm-Message-State: AOJu0YyiI9Zn7uaQsfh6VMau4pG8Yc1PCuwbVTq7fKIO4JuxOi9wQFIB
        Cm78Y6Le8PkPDS7x9WldAssVr9M7hsd/gloHA6A=
X-Google-Smtp-Source: AGHT+IGClN/2krp5lfgxqpF0EZe557a6/RY6T3XZ1telHabNqYg3yLAf1JuScCUqZ/MwBWu6WQdkMw==
X-Received: by 2002:a5d:6311:0:b0:320:4cf:5b50 with SMTP id i17-20020a5d6311000000b0032004cf5b50mr8499282wru.5.1696636064916;
        Fri, 06 Oct 2023 16:47:44 -0700 (PDT)
Received: from [192.168.200.173] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id 1-20020a05651c00c100b002bfec05a693sm981733ljr.22.2023.10.06.16.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 16:47:44 -0700 (PDT)
Message-ID: <56db233f-1488-4725-9253-b4d6246fd5b7@linaro.org>
Date:   Sat, 7 Oct 2023 01:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] clk: qcom: add SM8550 DISPCC driver
Content-Language: en-US
To:     neil.armstrong@linaro.org, Sophon Wu <wuxilin123@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, andersson@kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org
References: <CAEPPPKu=yxS6SgdLZiuhbF2DRURKVUBNgNbUQ96LxHHbtsJ6Sg@mail.gmail.com>
 <c6a974ce-511c-47f8-b6cb-baeec5283af9@linaro.org>
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
In-Reply-To: <c6a974ce-511c-47f8-b6cb-baeec5283af9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.10.2023 09:16, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 03/10/2023 04:17, Sophon Wu wrote:
>> On 09/01/2023 16:47, Neil Armstrong wrote:
>>
>>> Add support for the display clock controller found in SM8550
>>> based devices.
>>
>>> This clock controller feeds the Multimedia Display SubSystem (MDSS).
>>> This driver is based on the SM8450 support.
>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>
>> Hi Neil,
>>
>> I'm trying to enable display on SM8550 but having trouble with clocks. Do you
>> have any idea on this maybe? Full dmesg here: https://bpa.st/7E6Q
> 
> You may need to remove the cont-splash memory zone and the simple-framebuffer,
> if you leave the cont-splash the bootloader will leave the MDSS on and Linux
> will fail to take over and initialize the clocks.
Huh???

Does the bootloader poke at the devicetree to check for its presence
on this board!?

Konrad
