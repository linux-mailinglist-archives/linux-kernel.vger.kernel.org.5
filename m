Return-Path: <linux-kernel+bounces-89241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4975D86ED27
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B91CB203E5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9812B9A;
	Sat,  2 Mar 2024 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7lR0OaP"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73C6FB2
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337680; cv=none; b=KmA78/fXo6HGCKsi/KkOMqlgUGRbNczpDJoSZjoUbmunNLrwYtPPa/gRGZbKkFX6M1E4E1yGsxG3zgNzhKhWo5hjB4hG12jn89t8mo9z4Y3HzTa4ZcC1+rje8K4UPs6QJnZn5HAL57CO5uSA1h0nCsYF3joHBCQXewOcnAc72QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337680; c=relaxed/simple;
	bh=3DyDg9JuUnmyDqCjiSkANyfUyBRJ6p75MplMSkxgaHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JBhP9+w++cXdWkOqqkBQJ7HW+/x2U1aFVhFWsXhiayrdlQDgVfzFUM6k3ooI/SFyMTgOZOCABzwHAgBkavBDjxK1e+Mod4bdihizeuX5kM1rRsXBL/59WNT5J09WGj13M7XKTekonr6RKuwVurqFtzxx5kRvNeaJxYdWuLzsyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O7lR0OaP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a44628725e3so309784166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709337677; x=1709942477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emi/O2lEPCqU9U1qSKkLuCeTT4tOafDDfi21fhcSuME=;
        b=O7lR0OaPcX+Gupu6Kk78TJVoZyR+i0/N9c3rBaZbGs0OXik7JmqKBS15Jiz9wSuDyC
         c0A68ot6DpEP3+EB1XCpy3fPSHM6PBRBF187tiav227WvkdQdDmxbWTIpoDxt7XhFLZg
         K/INzZg9+swE7JaLBOZs609XZ7ikIpiqFwJtw6sxGmiDu9TBilOPNK1/IUboZnn08nu/
         9bggSEiwm0C12P8DK0NQoxoSHkrIzk0k9vOmHooweyXjf3wnr4qjeBveYXeVjkV35RfN
         8DHoOUg6umqCb47P2oG2JZ+bfHMSzbIyZrPjdlrHq3GRHyCkjpUF+YkjkyeLV4/5Yx+2
         DQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709337677; x=1709942477;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emi/O2lEPCqU9U1qSKkLuCeTT4tOafDDfi21fhcSuME=;
        b=RwrgkDT5tkVqA3MhXjtfm7f4CoyESnKd/hdOSfItxs5Kom9xYUNsR7xkZLZOEaoVMb
         bFzi93Wy34ogjD8RyUGqNq0oh4IBGQbBfNE6SKyjpMQbGNQp5RK/A3TOr5SDSRdmaSVH
         y4WUYudIQmh0lL0SUNbNx/4B4j8Yhsv/FfYiw8AHL+2JuvQrxOPFIwlQ5h4h2slcOIug
         PeYa7odxzyPpH6DQbJ5qE9XGqcxgdEaxNYPuemk0xqLoscRPPdkSmpJc6W5m+bbcPGJS
         Oh0A4Of0KxVcZf9ktvMdjRdcctYngmfi5+ANcL7cM6WeD43bo4LzfWD9NpgPtOp7Z96X
         6ycw==
X-Forwarded-Encrypted: i=1; AJvYcCVN8fhLz/j8fwAUZzfPE8XZIFx3hc5aXgLgX0ID9xiefEeNOj8eWrOKdBMmy6Yg5ffJ6cVF/F1fpuyKrxDDcNRlxUgIKp1fGentboIH
X-Gm-Message-State: AOJu0Yyj1voJ+qPklk2bly2MtypYg/pgVfb/xOAbnHz4AchJ3+xg6VQu
	kjmWqfMZ64qVmexsGmW6smr09bMZDd8x14G4wddqYki+yab5gu7GLs7LQr1K23E=
X-Google-Smtp-Source: AGHT+IGyc75BIIkwsoofQ9XI3Desgjt8OVnyfdaRyFT+8EwtFRJOn85beJIb5K+/M0gcEYt2CSISTw==
X-Received: by 2002:a17:906:cb8b:b0:a44:c63b:caac with SMTP id mf11-20020a170906cb8b00b00a44c63bcaacmr568786ejb.5.1709337676980;
        Fri, 01 Mar 2024 16:01:16 -0800 (PST)
Received: from [192.168.216.32] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906131900b00a44bd00ed4csm466451ejb.0.2024.03.01.16.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 16:01:16 -0800 (PST)
Message-ID: <8edbe508-9539-49dd-a5f0-42a7979bf770@linaro.org>
Date: Sat, 2 Mar 2024 01:01:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: x1e80100: correct SWR1 pack mode
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240227142725.625561-1-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240227142725.625561-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.02.2024 15:27, Krzysztof Kozlowski wrote:
> Correct the SWR1 Soundwire controller port block pack mode to match
> reference code.  Not sure if this has any impact.

Probably it falls into the "undebuggable if present" kind of issues..

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

I'm assuming your new source is correct-er

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

