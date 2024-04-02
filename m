Return-Path: <linux-kernel+bounces-128200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6339F895776
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956701C22AEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BE12F39B;
	Tue,  2 Apr 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nba6eKTl"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126AE12BF23
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069326; cv=none; b=puBGloWAnPvoBVzyG54THcHSscUmKuEfts1m7SlSd4REe3CU4Wn4/eOd+lzK+48xgsa43JNewdHMMXDsCYgErHY/UDgUKQXq4EGTl9gung147kIhayHZerd5y6ZOwjDeEp4XWRrElkTUhRCu3tRrkR/5aLCgoYc8PuHEV4SGWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069326; c=relaxed/simple;
	bh=ic4V7WnlJtfSyGKZ2TLFxgkfjXXzDHkprmFCWInZtUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WClixxPm2y7ZiCEqP4VEuCM07K9Qgjvdyc4HLR4ls2yPbWL9dWBB3YVRzR+lbGVDIi3BfaZZCRMVYW7uFFgP5kSeZwUllActquzjjzQK0ydJEHummAL5Mev5Ye7m8DQ8WqqD0thJiLQ78adWEa6O2NT9aMeZgRHMsOBGoFQYDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nba6eKTl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516b80252c6so595284e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712069323; x=1712674123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UKa91rDf1nIX7qAe0v7E10VCzydbtalm9L4mheenyOk=;
        b=nba6eKTlfP5lSR8pz8sNsMaDeB3SWjDvgGB9f6VTML5NtQ7nwLN/FqHyaa6+bzbtD5
         chnXWAJKmZgm9RF8XA9/YgeyUTpJtib5Myhj0zdwX7l9Gw9x6KQu/XDYwXiKd/h+OTUo
         SnNpsk/dIm2FiGk9Sw1TenVyB+VbX0y7jgduum40mH7msU5TULlfVoHwEwI3b68uAg6b
         ENrAnDJ76IwQnbPWu7PS4G145u3xKrmXj2tK0Or0eHMpuMwxWcspGlWJzbyqTL05UNd6
         chDB56FrZvuLcJB2cwwXgBuWWI5fvg1ZtrVXhyhZrAP1rP5qNPFDNwulq1c27JCUd1KH
         VTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069323; x=1712674123;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKa91rDf1nIX7qAe0v7E10VCzydbtalm9L4mheenyOk=;
        b=KTZxFT5DMJckv9HgNo3tos718jHzy4sK8ZVcPyaJtBzmxXVMTWxJu/XSH/bQEfJnN9
         qcWp+lLOpGbkb3SHfcsdAm070dxpUQ1m6R/HMZOQbItOvgWVaSMLJ+6MsxlMcYoWD+pZ
         ciMGCuGlkXlFwzi5mDZBI68Oa4r2TaSJmSa3guuiAZkV2ptF5OlEOQYNVBgZJI+zTEpf
         jIGuwxfIiHtFBH5QcnbV7+4OMwYAZTN+JlzC5tb23x20T+YZJylfZiBfm9MBnfLXgSsM
         bCbPkcjowjKdgjBA1IkBKKHAD/Oa4FZFiAkFR9QYOaeI7ao2VxeGx+HzIloqmwVfRmoX
         NtiA==
X-Forwarded-Encrypted: i=1; AJvYcCVlyAw+zaudu0OhyMpQRLJNBZ58691MAqCr2+Kk0jN3dnargoU2ZKrMFVinQaz+nNe6LNqGkv8N+LKIi6RCekLtSsQ3kHVpkmLO9Hwr
X-Gm-Message-State: AOJu0Yxq3ODM2NmoA0/REgvuIJUNkype/JMib5kYyKYVA1EVCa0HyQyN
	+LoM/3s6FBHQrrZwGavKcnJCGqA16PQceIfU4RQ3I04d+EGfEpHq6V6Q2ggI8Zg=
X-Google-Smtp-Source: AGHT+IHDLBLNlhpjUxt6Kq3W/EygVN2qBukJRlMwGqfKKGDXH79X1SJfTm9XdmaPjLnSeKf3QNaGZg==
X-Received: by 2002:a05:6512:943:b0:513:3d98:43f with SMTP id u3-20020a056512094300b005133d98043fmr7331964lft.61.1712069323025;
        Tue, 02 Apr 2024 07:48:43 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b0056a033fa007sm6780885edb.64.2024.04.02.07.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 07:48:42 -0700 (PDT)
Message-ID: <e2206445-d560-43ad-8fb1-f0b4967493f2@linaro.org>
Date: Tue, 2 Apr 2024 16:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: qcom: Add missing interconnect bandwidth
 values for Gear 5
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
References: <20240401-ufs-icc-fix-v1-1-3bac41bdfa7a@linaro.org>
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
In-Reply-To: <20240401-ufs-icc-fix-v1-1-3bac41bdfa7a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1.04.2024 5:09 PM, Manivannan Sadhasivam wrote:
> These entries are necessary to scale the interconnect bandwidth while
> operating in Gear 5.
> 
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Fixes: 03ce80a1bb86 ("scsi: ufs: qcom: Add support for scaling interconnects")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Skimming through the code, could ufs_qcom_get_bw_table use a
WARN_ON_ONCE(nullcheck)?

FWIW, this change looks sane (without checking the numbers)

Konrad

