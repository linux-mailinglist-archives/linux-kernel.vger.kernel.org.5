Return-Path: <linux-kernel+bounces-33608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4657D836C39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB3F1C26734
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B347A7D;
	Mon, 22 Jan 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNn2+TAx"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6FD47A74
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937707; cv=none; b=lywLelnS+Yi3Q28pO/75G4tyyXV2UEMFwsDYAH4G4j9PkyRVc8rEpimo6mUpfJ3AKq3fsGYbcwYQjv1Yvqd6HpR2RxKynWHj2OsTbh/LBSZjCF3A1Zhpw8YCtPpw4bhNuzXeDydCGEEMRKvZSDXgNJqwUvCxYDCvyj1g0rfI5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937707; c=relaxed/simple;
	bh=2V3IlyGGnL9L4mNjyRFVxFS6i/HCwHMRcC7I3z1wWb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMEs44Pidk7Ij7oWloBJ3WdnOkJbit9/PLBdc8XA1j/rvsReEy3K0ZUwlLAumqwULZmU3Et7RUi/u2Dpoyz+jb37UcCa3Yy4plLeNPKaVmDMhBLUNjaX9TDfobRt0O7YT8/ebGUC9vaYERjffGRJ3flqwTnu+fHS19AVQ0HeWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xNn2+TAx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso312807066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705937704; x=1706542504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJaOVUR+a2RILxmbVMeV4oAVZHNJjmiKxODj4kHUZ/w=;
        b=xNn2+TAxfbe2XkXx+f0isc+qN6UnEYBf2uJ85xplR1a7aDimagqO3H+2xuDDimPsoJ
         Fap6EMhmefMvI4krW3vpTRCM+NwR5/SP8w1vK94eptDowdiar2FG5cCUy5jIayIS2zda
         I24KEuNOLvle/XKTwXmUv59ZqI0IttQmn3BX4qYCk3PNpQykReGQtAn9CLhoRkFIvfCK
         32vUx1j0bojV5dRkzuvVnJ4k6McMXp9rwJpDmJCS6/R7f+mj8+wvzLZPxcEzf/Jdri7V
         7ll+SpzvsG9QlQm/m8bbxD5DLNEaG355gW/JZJldSnQOeVvobVc/jDPSQVBCcJ0u9Eqa
         ciHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705937704; x=1706542504;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJaOVUR+a2RILxmbVMeV4oAVZHNJjmiKxODj4kHUZ/w=;
        b=X7hBPVVj5Bl/TRCqAETfKzilaNmZ30CqOVIeBxKF20YBNe4HoRV5Cw2w8St65AlBKQ
         ZpAtMEivN7fXovWZjrmwBGDK+LtpnpaguilJ01NcNZuYOyTAO7ReBK9Fm0EH2IO0Eewv
         L9Nk23i0gVLIRp4nE1zIGobTzeRsVzl6hUBrN3XEP5pvuiXAC53s8M+/qdikZrT51Dk+
         VfXSK84gMHcWxVbzAvalkkWn3ciPK9ptWx1H6X9F/T8dVJDUwEgISY4RBQVpRc7Z1B9G
         5IwSUCCRHgodk5aJbTDeb3sFq8dnysnj9zHvQLx0RqtYL/Jlj8fi3Im7Q1NSng6gm4+o
         BLxA==
X-Gm-Message-State: AOJu0YztpI3xQBwU0cj2KWkzjrVAXB3yeVr0MAUMERpLodbjt8iQp+iu
	hmBFcj8L0pLlDHR8KmsykbIv75qjCZGiqEeF1BMG1fRZ1ZuJdM4a3Jnw+lDvaYk=
X-Google-Smtp-Source: AGHT+IHvIt1F8qfqjs+sSFh64xKJOll2DHZGhsUwJZXh6rJUsXC/M4TaK6XJLnb9FNliR0obl04S9w==
X-Received: by 2002:a17:907:d405:b0:a2f:c878:f696 with SMTP id vi5-20020a170907d40500b00a2fc878f696mr3034088ejc.54.1705937703731;
        Mon, 22 Jan 2024 07:35:03 -0800 (PST)
Received: from [192.168.231.132] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090699d600b00a3076ed99fdsm629263ejn.41.2024.01.22.07.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:34:43 -0800 (PST)
Message-ID: <fcb3c92e-df59-4135-83c7-2850f537e57c@linaro.org>
Date: Mon, 22 Jan 2024 16:34:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Use GIC-ITS for PCIe0 and PCIe1
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240122-topic-sm8550-upstream-pcie-its-v1-1-aff5d0d7d6dd@linaro.org>
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
In-Reply-To: <20240122-topic-sm8550-upstream-pcie-its-v1-1-aff5d0d7d6dd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.01.2024 16:28, Neil Armstrong wrote:
> Both PCIe0 and PCIe1 controllers are capable of signalling the MSIs
> received from endpoint devices to the CPU using GIC-ITS MSI controller.
> Add support for it.
> 
> Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
> msi-map-mask of 0xff00, all the 32 devices under these two busses can
> share the same Device ID.

Copypasta! you didn't actually add these :P

Konrad



