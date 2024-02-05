Return-Path: <linux-kernel+bounces-52499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C497849908
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF612B224B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604FB18EB0;
	Mon,  5 Feb 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFB4YWft"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7E18C3B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133299; cv=none; b=IsZB4SeFrSqR/VevXRurhdjm0ZJqYXKDTFkvk8wZU/UiyEuk03N2k4e/ZSAV/z4uEK5QqxkaHXkNEiB1fz2RqNCYn1j7Qr3Y4WdCs6qFTM8oZqSI93jDCyl6na7k62Z2J/O2DZS+YCMiCvwoMpAzGq0kGGqsUW9MV3BxYxIxol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133299; c=relaxed/simple;
	bh=cawbObaeTNPoPHLs3wzViPvaUp+m9ZRIyvZEw1PShiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jld2uosSr7sZE+tR1T+b6f5Dnhw7POann5+3JEdnohLGtf7NF9AACP7hjKJO/UWAVuQoH48GQIbKfHeeLaUS+TTnVGN8Wee61hziBD60YTlqkiDdlYHUpekPWoLpRxTt3vHIdr4urcP+kap263NRLUvJryvqxih3IhxLKyNbRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XFB4YWft; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a37878ac4f4so138498366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707133296; x=1707738096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdDNzXnnmgs4CmoJ3xT93XgtQHbqN413J4+6ID4w1fc=;
        b=XFB4YWftQbbWpmT0ZWLYHPzSR17tOnNmzPWok3Z/prJVg7btxo8lznFgUgPk21i/l4
         tdSXyKc/k3dvL9/YHzzkkNSxW38lqZFGyM8tDsWRvfXA/P8WoMMUIzmR2DAuAV+Sizb3
         6mr5PtusOJ6xH//Na+UmGKHtK6WGH5zkj8hwYJIjluZuzeMkYbmKcu2CWHzJS+QjeoAi
         HYSjG/BH6ybb9ada13cjnluW3J+zhlEbekvcBsZh4CpYLqFWKa7683/Yy7Q15KmOB4L+
         /0nIRxgSVSrLvmKb642NSQuX4+bdGa3xHdIe/Rsls+JqAgpnPNH4wNdNrnZ+CsWJ3koS
         JUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707133296; x=1707738096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdDNzXnnmgs4CmoJ3xT93XgtQHbqN413J4+6ID4w1fc=;
        b=MC/hV1XlsNa9RodIgsMlagXlbTbg7OiVs55YF3EpkuxTYa6Vjglh1NuP1E1ODz526m
         Wch4YHPf4pN2QXL3FWTiXLRzU/Q8mfaAHIf+nseCpQha0KLmciWLZIZylhUL6+w7fodB
         XmXruoUPHFPXhwIQF7IzlQZf6/VrfdkAPQyr9Eb23sTozZgu8/yEIEOsak0HyPLWrT3K
         cxCLUqq3mTzU9akSwV2eWAvtk62ZuP1jlogYl24ZavLVIxMWVgorqD7y7DNvHYu1l2YT
         gTtxg/6JEvK1C8ka5ABtgL+nrYVenPssEptXtd1ENdzGGfcP6NpplWLfvHG/dNZchusA
         be1w==
X-Gm-Message-State: AOJu0YxHA4C1lnQXU95yEiKdmB0QG5NSCmHjhB+xx0wRR9QV3Cflo9ek
	kFHOc2WJi5xwEmn2e2J0dYwHAru0qFcNrcW6MP9mYxydiz29/PDuGD0X+ZcdZsg=
X-Google-Smtp-Source: AGHT+IEyGaT1GowqBYI/yEWBSuyvilmzJZdwtRyvCm3j7vrIGTt/Z5+W8p0t37oecuPRpTp1jJPcOg==
X-Received: by 2002:a17:906:4:b0:a37:2e82:3c4a with SMTP id 4-20020a170906000400b00a372e823c4amr5262475eja.52.1707133295889;
        Mon, 05 Feb 2024 03:41:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWk2Tsa9AcqE288WYA7nQCODiqIwyfsENZYHM6ugZTYVKR73yYLsjo1KuQvNKEYli/z4wkh7/hPu+bM/QnQ9Z8ZX2QTlAe8Dpq5DiOA2MBHxtbtO8oeYe1yX/K5ktIBGYgKO9cQ5HiHa0mO2YYMZlGd/FSbyl4+APaQRjrFcgPTa1X+0IPEMqbsI8lmihDhvfem+APbn6leQUS9xOzpAkwNXMai8ps/oRQHJw==
Received: from [192.168.159.104] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id a20-20020a170906671400b00a34d0a865ecsm4177184ejp.163.2024.02.05.03.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 03:41:34 -0800 (PST)
Message-ID: <4cdf9c9c-c4fb-48a2-be17-8191aaecb2fe@linaro.org>
Date: Mon, 5 Feb 2024 12:41:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] power: supply: mm8013: implement
 POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
 <20240204-power_supply-charge_behaviour_prop-v1-3-06a20c958f96@weissschuh.net>
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
In-Reply-To: <20240204-power_supply-charge_behaviour_prop-v1-3-06a20c958f96@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4.02.2024 18:26, Thomas Weißschuh wrote:
> The sysfs is documented to report both the current and all available
> behaviours. For this POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE needs
> to be implemented.
> 
> Note that this changes the format of the sysfs file
> (to the documented format):
> 
> Before: "auto"
> After:  "[auto] inhibit-charge"
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---

LGTM, thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

