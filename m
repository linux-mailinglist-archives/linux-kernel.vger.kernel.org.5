Return-Path: <linux-kernel+bounces-60013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA02784FE87
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A104E280FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA5D524C4;
	Fri,  9 Feb 2024 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwT7yTee"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C3524A9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513037; cv=none; b=ivbkviLRy5kdTKcA0p7IPkXBAqW9Cquk9HrNXkubKALXGhufZfOxm1RLcLnfCwEyLQegOB4QG6YhnkAITbQz7TH8/0PEf99u3tWj/SUlXHJxljwfaj5mplHktT/axw1T3WXTI7yZBefikKzk9m5uEQBr5PFiFzS3QajnPoE1kJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513037; c=relaxed/simple;
	bh=2vjvS5sq/meEEjzl1dSjLlS5UDvty5zIyDecyRkLEQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIWU2NFWuSBLhXXOaVTHAb5QnOaZmQMRPtNXdf1IzL8GrubHbg8yuOCmgNp4jvaR0YOugSNwdDRiLvGIXwWR8EyKqxCU37fhCCCWaDwOkthMWp2DCRIFt9ANhyEH85QNpCuuMUOuXOf+huVyj0ZfwOTwv+/Y1hkimPTZiTZbgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EwT7yTee; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5611e54a92dso1803236a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513034; x=1708117834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lz8OIucAr0zZ3B0lyDXRMPZ4gjhkvqUIJ9jeciUSfSA=;
        b=EwT7yTee0luHIeuw+hIajFhKSnjHEqgD7wtn7jqwO951wFhtI8cXLx4coVBKdg3EnW
         JH6L+2X1ck9qP5gjxfAOjUw5uD/zvgMMaliT7ssBOQIkRLvr9zzcMMgiEMNy1WhApRVK
         BcpoLkzSUPSdn2HPKUcZA2OMiLRYEg8jiuHJhLDsxFQvnnwc1p+HK6UEIVeQCrImEb6v
         bIdFwr6z7vI7SWdOoX8Z4xRl9GsAHJA5DeqsmB7mxZ9kkju0FGH7RhvmyyD/ME4QMsLI
         cZMsGWG5ov46Fy8p8l2H2tKfr4EhiXxoMX02Iz6gz52+RsZtd5bxGx8KmdbQ07Z02h0V
         7pEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513034; x=1708117834;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz8OIucAr0zZ3B0lyDXRMPZ4gjhkvqUIJ9jeciUSfSA=;
        b=vBjlOuCZm4I2kGxkDSEiJHxy40JAVW1Fe+EbHhKA9l5kXj8tTf1QETwzOSF+dGxdC5
         vwliujFkJK2yv2yhEcCOt0DR51z9usXq4OAxdvj71azAElQcfWehdeMF9oRXOZOZNdCV
         XpPNouR3xEr+kfDVKrnklqJLgaEmsjfpeUhp1zM5hN7WhjJNp2J+WHuo8Hf9svAVlsAM
         CKeJiQArqz98zpSHe0Q/CNfUGgptTsrU5d3/gi4lcf9bmSlFnCf1RVfBcT+4BPkX5UAi
         OxDyPujwrQngAgIidrPcZPBdijNOZ7aWkW4Xw30GSixlxRa6TvOFgYKA2EUn7ENy1PIH
         U8uw==
X-Gm-Message-State: AOJu0YwbTdRvjIIKkiU+SqjGVXvSMnZeFzCFGn1a3RTuowZYpdddUER3
	4qhQfqus0UHixUlu97GNESnPsMwSAZSrv8mTHk/C/r2JB1cZPeAIukiWyF1S3bY=
X-Google-Smtp-Source: AGHT+IGIClcD3CCK95LlB0DYp9S3ZIhFoVqcLf9t6U2xxuYY3GDWJ90CyW0i3TPHR5r/7He39lsQDw==
X-Received: by 2002:a17:906:370e:b0:a38:215c:89b with SMTP id d14-20020a170906370e00b00a38215c089bmr159692ejc.73.1707513034732;
        Fri, 09 Feb 2024 13:10:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWm28I4epj+SAZCn6DxZkZlsjmleMbJ9f2He48l/bQ0i2Z+LndgubUFAVE1OufG94TS8xu7cxYJJ/hhcgKq0BKmcvJ1XZTz5T3hmntqfeoSmWq+pgVli45EbC3dqzOj0uEwPqI9FjxwqT+U/Q9BrVEXrKaoCisDQ+pBx9j5TK1u1Pbx/BAF5sKssv0Udo4Xf/DI65rSt1rJ6/MycFZtugHxKCJSiC58EmOmSkzrBxD2vBtf3hQlrnw8GlmDo4cg/0XcP1xjpXJ08U7/9AKXtOZgEvvdODQQCrdhLo6sNEJv3ShcOH6A+7HJQza3INt+FdAV8l4f+3CVs+bg7E6KsS7mKfx6dfDpy6hl+X51pJr3Xi3Eo/Fs1AvAw27WBWDNmBoQbUKCp/XT8IE9J9pO17PQA0ieShrVDUuw9LQoiiTqBFsmZqw9SFSxjVhkaO0LYnQscQsHQhXFBVgODFD/5L+xw21gmTiIHJI=
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id ox27-20020a170907101b00b00a38a3201085sm1111615ejb.193.2024.02.09.13.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:10:34 -0800 (PST)
Message-ID: <58e42e1c-3cfd-4ecd-8bd4-9f727a82bd81@linaro.org>
Date: Fri, 9 Feb 2024 22:10:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] Venus cleanups
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v2-0-fa090d7f1b91@linaro.org>
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
In-Reply-To: <20230911-topic-mars-v2-0-fa090d7f1b91@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9.02.2024 22:09, Konrad Dybcio wrote:
> With the driver supporting multiple generations of hardware, some mold
> has definitely grown over the code..
> 
> This series attempts to amend this situation a bit by commonizing some
> code paths and fixing some bugs while at it.
> 
> Only tested on SM8250.
> 
> Definitely needs testing on:
> 
> - SDM845 with old bindings
> - SDM845 with new bindings or 7180
> - MSM8916
> - MSM8996
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Apologies for sending this twice. The other submission should be looked at.

Konrad

