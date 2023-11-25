Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A807F8A90
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjKYMJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYMJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:09:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98490D7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:09:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54b07ba599eso1448349a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700914163; x=1701518963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgispGlB/Vogj3O2jRA/99ot46yAJSqn7bnbdiR7nmw=;
        b=lOnznw1Ghyep38crzua4Z9kh2vwjgL2zc/f5Ii9Db7+yRe2c7Z+p9No5U4lBNkf2Hb
         93WDVBfB5mMdEBfv+WHXWjtD5R8W+rM+ogrf7mIIAHB/s+DIV972DRKklO6pyuJ12Wh7
         4AawvzdKy3C2jQyQvndMgbGdtP43D1leicXEFwMAq9FNLtABIICnWk9VLt+ZFcuJU8Ga
         hLrUePE4jZW44ZytIR11pxBvq0j6kmEEFwBDlrt11v/+CP9a+fhOZUTThtujjFh9KHXi
         1sQLtQ7UeQ+ZIH6tlvnWAutXg9bbaYjTcJyl+oHuKw8lDWRaPSrDi8SdFGzAoxMbFJrL
         Qegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700914163; x=1701518963;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgispGlB/Vogj3O2jRA/99ot46yAJSqn7bnbdiR7nmw=;
        b=W71MNR3JBpi4MLZDXBixjvfH9TTk341Ocmy1S9fbtX1XGf6QE1vB0KC3wCPuHiKnG5
         S4HGPIjbYP+Uqfe6i7tKiAPOqYMxrBUWRDdP0Ig/haFfzkEzYhjPt2abnCJF3WMsY0+O
         EnnJ8Ejgk56Ap0byMP+StklBDKPmni+uQQfhqA6gerWfhnNzI2FhqU9t+HnRJXFp0RtS
         +tjrCfZIRyhbd4+D5NoOhhjrR1budhMcsd5C90MXCqRG3EHQ5ttT46qD7bB4dqkoj74V
         bME5Po7j/x9weBuPqFyAImhHfGZJyIZyEZRJwJTKtMRedFTPUHsuuhVjT2hh+hD8JGgl
         AFnw==
X-Gm-Message-State: AOJu0Yx4TW5eW5PjwDeuoI+wUv0C1zuFhqwD5Eux6Quuzhzx65DjjXbA
        uY6ffah2INmF5c10LdihJ0JavA==
X-Google-Smtp-Source: AGHT+IGEK5umheP6JPfzRi9HgIdCTuo3lZLa9hajwZqnEDRbtozQjh9YQQAf4l7Q4ZpR0YTAUnrzJA==
X-Received: by 2002:a17:906:2c4d:b0:9d4:84b6:8715 with SMTP id f13-20020a1709062c4d00b009d484b68715mr4095357ejh.52.1700914163075;
        Sat, 25 Nov 2023 04:09:23 -0800 (PST)
Received: from [192.168.201.100] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id gw4-20020a170906f14400b009e6af2efd77sm3347884ejb.45.2023.11.25.04.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 04:09:22 -0800 (PST)
Message-ID: <0f7e96c9-de56-415b-bd26-86c7a612dd46@linaro.org>
Date:   Sat, 25 Nov 2023 13:09:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] Add a compatible for Xiaomi Pad 6.
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Luka Panio <lukapanio@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231124212732.731419-1-lukapanio@gmail.com>
 <2023112529-fetch-unwritten-bdbd@gregkh>
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
In-Reply-To: <2023112529-fetch-unwritten-bdbd@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.2023 07:53, Greg KH wrote:
> On Fri, Nov 24, 2023 at 10:27:31PM +0100, Luka Panio wrote:
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Luka Panio <lukapanio@gmail.com>
>>
>> ---
>> v2:
>> Update commit message
> 
> What commit message?  I know I can't take patches without any changelog
> text, maybe other maintainers are more loose?
It was there the last time around, sounds like whatever was used to
generate the patch files got a bit drunk

https://lore.kernel.org/linux-arm-msm/20231024063740.4975-1-lukapanio@gmail.com/

Konrad
