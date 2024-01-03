Return-Path: <linux-kernel+bounces-15613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15721822ED8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF1D1C228C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A594819BCF;
	Wed,  3 Jan 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3x2HOcp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3A19BB1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55559e26ccfso6469198a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704289520; x=1704894320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsIhcx0F5Z1NtIOJr0Hzom+dK6vehkOAFF2M48jCfJ8=;
        b=z3x2HOcpcqXU9pgEYLM5jo5dwXicJ6JxwXnuKF9mWtZ9iBUwGgMFDK4G6ig/tH8o4X
         eejxUPWjQ9ctQueybVMp9ACNN5NHOxDRuly2vGeTFbVH+9pDe9MoTqtQRtrXoM9OdHdN
         8Y8SP4LG3yI7SHgf2d26THNwf95vS4k2tyS5Stz7Ed/OnGgjOXOxQk3ORx5/lhqLhc3u
         wMJm97YDo7nBH4RkHKP8SLbPNvTeYdlCS7PNydRKcfwkQF14HGZSkH9+uXVAE48awafu
         eDcsY4xAbo55R99VjrPObRGAtL5QP9b3ATuLg1O9r8Jn1Ois6VzvoMq+QRylHddvBBxg
         91CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289520; x=1704894320;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsIhcx0F5Z1NtIOJr0Hzom+dK6vehkOAFF2M48jCfJ8=;
        b=hfpkdESWec3ivSOiJWUW5WE09iNIjS4dRyHN1j9vzCz+gNTK1WnxRLrU4fbkUqm+KD
         ahKHO4V8Z0h6pzrdbf/rssKlV1uynG3NHSL7m0FGAvR5JCEpZVWmJzIYFFbznfZYiann
         A8Lw3hxKJdi8bvWG4asBovFNzMQKWwsnHCv+ckEvzT275Nesu/jCvvyAl/OXli59OBvC
         ZS8pi41fdiMyYmu38Oppy20U8a3d48cg6Y3UJvMrOn21Gw5EZI5H0ddrUE+YkAsVj7e/
         DKSDjSSd39rX1E0w56jLLUM+spKZUiPGWkxszpsbOvXW91tQAh3C5odxDe7d/bqOTeFg
         JAwg==
X-Gm-Message-State: AOJu0YzceXXzOeATY9RsVqWTYdxf9L+0Qlp6G4VVDtqtnniDbv9ouRSo
	BTTY3ylYAa/c7DYe09DSa1SksxqXF9V5yA==
X-Google-Smtp-Source: AGHT+IEyt8SRxfZ1kEROdTfCF8MqxjEm/Hy0O7yhWovad1YkbKXSAV7pYdHWIEcCgU/PV1ncPiG1gg==
X-Received: by 2002:a17:906:5184:b0:a1d:2e32:d28c with SMTP id y4-20020a170906518400b00a1d2e32d28cmr6205909ejk.146.1704289519725;
        Wed, 03 Jan 2024 05:45:19 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ad21-20020a170907259500b00a26af11a335sm7461729ejc.2.2024.01.03.05.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 05:45:19 -0800 (PST)
Message-ID: <c2cb26f6-dea5-4b37-9854-96fb0bbad59d@linaro.org>
Date: Wed, 3 Jan 2024 14:45:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/34] media: iris: initialize power resources
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-8-git-send-email-quic_dikshita@quicinc.com>
 <6c2e7cac-6f3d-42f0-84de-72a14e8f9ef5@linaro.org>
 <5c3c686a-1500-7261-b112-1ea94d9e346e@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
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
In-Reply-To: <5c3c686a-1500-7261-b112-1ea94d9e346e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.12.2023 09:04, Dikshita Agarwal wrote:
> 
> 
> On 12/18/2023 8:39 PM, Konrad Dybcio wrote:
>> On 18.12.2023 12:32, Dikshita Agarwal wrote:
>>> Add support for initializing Iris "resources", which are clocks,
>>> interconnects, power domains, reset clocks, and clock frequencies
>>> used for Iris hardware.
>>>
>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>> ---
[...]

>>> +
>>> +	for (i = 0; i < core->clk_count; i++) {
>>> +		cinfo = &core->clock_tbl[i];
>>> +		cinfo->name = plat_clk_table[i].name;
>>> +		cinfo->clk_id = plat_clk_table[i].clk_id;
>>> +		cinfo->has_scaling = plat_clk_table[i].has_scaling;
>>> +		cinfo->clk = devm_clk_get(core->dev, cinfo->name);
>>> +		if (IS_ERR(cinfo->clk)) {
>>> +			dev_err(core->dev,
>>> +				"%s: failed to get clock: %s\n", __func__, cinfo->name);
>>> +			return PTR_ERR(cinfo->clk);
>>> +		}
>>> +	}
>> Are you not going to use OPP for scaling the main RPMhPD with the core
>> clock?
>>
> We are using OPP for scaling the vcodec clk.
> Could you please elaborate you query here, may be I didn't understand fully.

It's just that this approach of scanning everything we know and
expect about the clock seems a bit unnecessary.. Going with the
approach I suggested below (i.e. separate struct clk for important
ones like core or mem clock) simplify this to the point where you
just set opp_set_rate on the imporant ones and you can throw
clk_bulk_ operations at the ones that simply need to be en/disabled.

Konrad

[...]

>>> +
>>> +struct power_domain_info {
>>> +	struct device	*genpd_dev;
>>> +	const char	*name;
>>> +};
>>> +
>>> +struct clock_info {
>>> +	struct clk	*clk;
>>> +	const char	*name;
>> I'm not sure why you need it
>>
>>> +	u32		clk_id;
>> Or this
>>
>>> +	bool		has_scaling;
>> Or this
>>
>> you could probably do something like this:
>>
>> struct big_iris_struct {
>> 	[...]
>> 	struct clk *core_clk;
>> 	struct clk *memory_clk;
>> 	struct clk *some_important_scaled_clock;
>> 	struct clk_bulk_data less_important_nonscaling_clocks[X]
>> }
>>
>> and then make use of all of the great common upstream APIs to manage
>> them!
>>
> Will explore this and get back.



