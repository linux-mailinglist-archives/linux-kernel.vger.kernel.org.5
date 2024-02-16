Return-Path: <linux-kernel+bounces-68617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C772C857D38
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F112284DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929A41292EB;
	Fri, 16 Feb 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9bxg2u3"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53A1292E8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088923; cv=none; b=VbU5Pkp2YD3CfWJOG232/VdKAxVRo8XH8M6IwI/P2nMwjgSquNdzp4/FvNOtMwIFxyOZ+IxAiXXmGCog0C2hMmyZXnSEvho17UP75TU9vhckQTS+GpyhSWFMBRtepE/sJgUpldd1PDSdoDVsdUkueWozDQx5HV8fp5K47LO6tWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088923; c=relaxed/simple;
	bh=5stQm1VFF8J3lI10UYod/loGVvF9YOBClkjxcwe+2OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gA5mFZWQG/yrEtq1okR2LhzOXAqMA0FK9P/fDw93OCIEnHvpkQbi9AOmgA6lCoOalI0bQfjCWr9+zxURj6SE+Yc3JdX5cC4Uc1pwTUPNvlx4SStZPWGjV7b/PlQ4FkXfYbJjSGdfzuWaLHfbLJVTwu8vZIEoezWemFvl/G+yV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e9bxg2u3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so886122a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708088920; x=1708693720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PHl5R1/F8u0/SnHeSmWOc2YsyhnFxuAOA6HDgfKBd/A=;
        b=e9bxg2u3kwvWHKXKyIuGlVtJIXl/zQWztxtE8CoSjT7kGMuLgA4+2HGAxK1p3ncRwO
         BMHfmHzqiVslMyLJAwE6eodYYehui6ZvVOGB40ATxJXwGM1u6ggJ9N8TmtgorYAa0wMp
         3jKcD5A8Zf5T5KOkb7Lib5fwoFmSR+6C/c5j1f+SJAPJQ63+Es6dZAZva2WVTJvZCF79
         JfoVErx1nh25zwf3wzoXByA2qIpr1AFB4eJelLvb2G10FoofibTVQZUBQTLcfN67UmDg
         I6KZ3VtMKTyvPj1uhjdcuszZn12WV13G62IgROFahYpnUX2qg+xlJKGIBKKSd/Qbjx8e
         ImVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708088920; x=1708693720;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHl5R1/F8u0/SnHeSmWOc2YsyhnFxuAOA6HDgfKBd/A=;
        b=BoZ/93HMgMTvmMjawxtK6UMGr45auk4yDrLhNFCEhOOnF8aL9NU2qgxaSJ1jR2Pzb1
         LCkbLQRaU5R4vqiLo+hy7Qj6y23CKMntSqJA+/3G47s2gfyWvIW4iMS+pWtsXm9DpQ1I
         v7a2unbVfBe3igxps8IioNR9EFUlPiJvF96ZlQBTYQBCnMYZcsuKjbbw8/dzJYH9RDX9
         QXGd/K3HiTJviOqNNM+nggjpHtz/7115y0FOi2NaFvd6y57H4M1TkfdoznpYKDyHiVT8
         Gf8hpbks1rhgHIjVBtFegs4ZBoSQn69GJALlOPEPGJPkr/4dqGIg30acnhnNFyPX8ld8
         FjwA==
X-Forwarded-Encrypted: i=1; AJvYcCUVgO1w3sCWHAZnzdjLAIt0/F0EgPgY5nVWOrNcsDFZHCNjOeHGbFMRD1nnyvB6ljV99rHD3/GPHPRXyGB7h9TAdGkMDFGoCTDt8mhF
X-Gm-Message-State: AOJu0YySEtY75cMk8Pg9/WdVWY5mME3qAXmVz+kDnevJPgcmk2DvPBZJ
	AsGSkNngpgcUGTSUOaXhhHi6WXWBpdH8i5LQz61EBHZoFjUutyn86mlU6TEs+4w=
X-Google-Smtp-Source: AGHT+IH2aj2uEfR9qvJA6S2r79SpxswbbkjsplyVP8184MstvK6qPNx1TjY8GAedrF5Ce2y67v97pw==
X-Received: by 2002:a17:906:3bc7:b0:a3c:8d9a:40cc with SMTP id v7-20020a1709063bc700b00a3c8d9a40ccmr3706271ejf.7.1708088920163;
        Fri, 16 Feb 2024 05:08:40 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id fj17-20020a1709069c9100b00a3de1ee1027sm478262ejc.133.2024.02.16.05.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 05:08:39 -0800 (PST)
Message-ID: <69aee03c-efc4-48d1-8260-9dde8393ca0c@linaro.org>
Date: Fri, 16 Feb 2024 14:08:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add fuel
 gauge
To: Raymond Hackley <raymondhackley@protonmail.com>,
 linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Joe Mason <buddyjojo06@outlook.com>
References: <20240216124639.24689-1-raymondhackley@protonmail.com>
Content-Language: en-US
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
In-Reply-To: <20240216124639.24689-1-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.02.2024 13:46, Raymond Hackley wrote:
> From: Joe Mason <buddyjojo06@outlook.com>
> 
> Like the Samsung Galaxy A3/A5, the Grand Prime/Core Prime uses a
> Richtek RT5033 PMIC as battery fuel gauge, charger, flash LED and for some
> regulators.
> For now, only add the fuel gauge/battery device to the device tree, so we
> can check the remaining battery percentage.
> 
> The other RT5033 drivers need some more work first before they can be used
> properly.
> 
> Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
> [Raymond: Move to fortuna-common. Use interrupts-extended]
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

