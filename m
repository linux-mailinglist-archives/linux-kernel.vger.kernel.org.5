Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF377949F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjHKQbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHKQbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:31:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9711114
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:31:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso33301511fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691771475; x=1692376275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLkcROD0bRaahMTY5iVtJo3yNizIeUpQp+dJ24ES2Uw=;
        b=RDyb7eyEm+haK0975YQ+/4L22fz9Y6+ak8l8Bcyjf045yR2TwVHulziSP8YCS+8B18
         3ZCxXK57fS/42EDAdDJvj+ckgaSvZPGIRC0Raw3xaWXuxf9HLvJj94MWJ71NkWOOwQ69
         ozcPZUf1e4vD1SU2flS6UsZxBPwZCVHmE1tJhfz9mbvgRjnTFGFtT0qN6bmhgDAcYKT1
         wM5X3ymbk/q49tW5hNZ47BrFn6n1tB8q9nh0yRFGCWUUsnJOc0wEEwsNB4UAylOEqwFQ
         Bejr3x9j32h077Us8WJBD5WIonfix5Tw27uhHu5ex47yjshRUlxjWVxCdpVCOkEh5htI
         gCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771475; x=1692376275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLkcROD0bRaahMTY5iVtJo3yNizIeUpQp+dJ24ES2Uw=;
        b=KOJbihUiBPPRsAJAUPiibnWq60c01sQ3FCRC3IJ6dfm0PtS4iq9bculToFpR9a9Iwo
         N5hVNAOOt/9broKv/pgXMbttpBmNf2837nxKwTwvsTvpM5onjiAs/YY7P2yUnX1s51C5
         2zzWjtJAw6ymqaUIDJc4DjiMnhXp8aMb4ZcQ5YPIvFe54ghNoqoOvzwbioz+kqFJ5fks
         nYKdODod4E+o80hTlSq3s2+N5ug/yN5le+IhDAj+tw3vb6gQcmisWfgf3FPRb7isVdP/
         ucSPUG84LHmve3kXcHZ3RLY+cK6puZY3Yk+sm2//IhbSpmeS/sd8hbpbWjJ3iSo9l7Wp
         wu5g==
X-Gm-Message-State: AOJu0Yyd1h9MQn7jYqu3nIexv0ZrflXFHYEesHj0tPcbmtMJAnTDgPDP
        g2f7FSXvg+O64K+f4rQi23vT9w==
X-Google-Smtp-Source: AGHT+IHFG9ollgImzMMdYBRWWMcnL/V7VX58KVS60uOPaSHqMPSI4Tyau4UrFJ2sGfQ9V423VK6Gig==
X-Received: by 2002:a2e:82d7:0:b0:2b9:3684:165 with SMTP id n23-20020a2e82d7000000b002b936840165mr1991259ljh.8.1691771474857;
        Fri, 11 Aug 2023 09:31:14 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6cb40e9aasm911429lji.103.2023.08.11.09.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:31:14 -0700 (PDT)
Message-ID: <39ffcd61-eb56-41c5-ac43-9ace2595c11b@linaro.org>
Date:   Fri, 11 Aug 2023 18:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a690: Switch to a660_gmu.bin
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230811160505.174574-1-robdclark@gmail.com>
 <CAF6AEGtNgCxsOLyF31=WCdag4Gb7+2FvFEvOWDcqd_TxiTeE3w@mail.gmail.com>
 <d400c787-3c81-4e37-b541-371d6096cf7e@linaro.org>
 <CAF6AEGuHKuW_LGYfC640fBHsf3xzxSiyqL0YVpb5HqE=HSiL4w@mail.gmail.com>
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
In-Reply-To: <CAF6AEGuHKuW_LGYfC640fBHsf3xzxSiyqL0YVpb5HqE=HSiL4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2023 18:21, Rob Clark wrote:
> On Fri, Aug 11, 2023 at 9:11 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 11.08.2023 18:09, Rob Clark wrote:
>>> On Fri, Aug 11, 2023 at 9:05 AM Rob Clark <robdclark@gmail.com> wrote:
>>>>
>>>> From: Rob Clark <robdclark@chromium.org>
>>>>
>>>> There isn't actually a a690_gmu.bin.  But it appears that the normal
>>>> a660_gmu.bin works fine.  Normally all the devices within a sub-
>>>> generation (or "family") will use the same fw, and a690 is in the a660
>>>> family.
>>>>
>>>
>>> possibly this could be considered as:
>>>
>>> Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
>> For a lack of a better response, "meh"
> 
> It would help route the change back to 6.4.y so we can stop explaining
> to folks that they should create a symlink ;-)
Ok fair!

> 
>> Other than that:
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Perhaps we could take this further and do something like
>>
>> if (failed to load gmu fw)
>>         try loading "gmu.bin"
> 
> that (loading random fw) sounds like a bad idea.. plus gmu.bin doesn't exist
I guess we still should hear from Qualcomm on this one, but I
do believe that "aXYZ_gmu.bin" is really "gmu firmware, tagged
at aXYZ release". They're even versioned and adreno-gpulist.h
downstream contains the minimum version for each SKU.

Konrad
