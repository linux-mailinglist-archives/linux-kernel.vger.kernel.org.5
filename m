Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7544D78B4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjH1Pim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjH1Pic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:38:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96BE194
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:38:20 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso49528161fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693237099; x=1693841899;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOBUP0ss/TxEKXtPE0CNLju64MbMYbKUX21GZjq3dUc=;
        b=lRbLphjIATg19N4Za/9tYCX5wc34RXXxp2qF1vRQJkQjxZIV4z+O3cUYAL9oRiaq+9
         jgvm6t82Ouz6beTFmD/v+hXhyZwlRtGE/lw1ngdaC78p3rAKHzZVZFNIUmJuuUnB20sa
         XAnuxKp0M/qKyQqgfLEKEdCVCnoZzSCvkzBDvRc1WatYWLRScnyomSjn/VWtwbfYQHSB
         HzrWjsGV4SxF9Y69lFW05gw5R4TgOn6j7ViToNoW/KOMpNZdOPvaO+Z5twQTd748++q6
         gnXZZ3uOGce8FATlPZF33J4rDgbUNuIbHPMh/5kXNgVc591A14iLfINZQigT3TtZtcwt
         vuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693237099; x=1693841899;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOBUP0ss/TxEKXtPE0CNLju64MbMYbKUX21GZjq3dUc=;
        b=DX+8h8CzZdoL9RhJcJLMkvMjp/qdJkuWMBqpxhvkePVSyh1By8I+hgUQIU9omlEAqO
         QvQfoQJBle7mfYHPAoum0k811Upz5eIfh9P6M+Mivk03EE+gKNIAxaMdo7r+FLt230QA
         qaHRSuM5yXRNT61A9Em815KlyOURzGoOWlc4ylwdAXtiZkMjmjHkdaF5bS+ICYNp2lBW
         xdwmhkZ5u4VY4bmtHNmVbT1n9T48yt0vhihCKrNtamJzzSWVTe+FAOG6bbguUaadTacR
         kkDLEAr/3Z0yd9htpj1RCWxrxziTQvYfgX+I62Rb5O9xSg7FuS6frZZq23XVQgTwjRXj
         stAw==
X-Gm-Message-State: AOJu0Yzyl5YCDog0ROHDGpV+hihardRAjClHa8G1AKvomXEzSBjQTEUH
        lZXZQHIBWGqa/6z720mYYxuyVQ==
X-Google-Smtp-Source: AGHT+IF+Xo7ZUXD1LzO6MQw/ppbsocfOjvkWj48oUUWoV0Dei6vTwM1LFGsgzxi+fAENJFq0kzWwLw==
X-Received: by 2002:a2e:7d12:0:b0:2bc:e51d:89a3 with SMTP id y18-20020a2e7d12000000b002bce51d89a3mr10007385ljc.29.1693237099086;
        Mon, 28 Aug 2023 08:38:19 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id z10-20020a2e9b8a000000b002bcda31af0fsm1758578lji.74.2023.08.28.08.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:38:18 -0700 (PDT)
Message-ID: <8310417c-bba9-49ed-9049-bee5b23c2e3f@linaro.org>
Date:   Mon, 28 Aug 2023 17:38:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] media: qcom: camss: Comment CSID dt_id field
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-16-bryan.odonoghue@linaro.org>
 <4929aa72-a134-4eeb-850e-46d9255c011b@linaro.org>
 <b4545982-af6c-5460-d662-36b0eb80bb4e@linaro.org>
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
In-Reply-To: <b4545982-af6c-5460-d662-36b0eb80bb4e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2023 17:34, Bryan O'Donoghue wrote:
> On 26/08/2023 11:18, Konrad Dybcio wrote:
>>> +        /*
>>> +         * A value caled 'CID' gets generated internal to CAMSS logic
>>> +         * which is a concatenation of [vc:6 | dt_id:2] hence we reuse
>>> +         * the least significant two bits of the VC to 'stuff' the CID value.
>>> +         */
>>>           u8 dt_id = vc;
>> And where are you discarding the non-2-lsb?
> 
> At the assignment of dt_id
> 
> vc:6
> dt_id:2
> 
> =>
> 
> cid:8 = [vc:6 | dt_id:2]
> vc == 00110110
> cid = [110110 | 10]
> 
> I have no more information what CID is or how the bitfield is populated than I have already indicated in the comment/commit log.
> 
OK so you're discarding the 2 lsb of the [vc:6|dt_id:2]

however

the way I read the comment would suggest that you're taking
vc[6:2]

Konrad
