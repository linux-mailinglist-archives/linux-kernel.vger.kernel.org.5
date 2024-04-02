Return-Path: <linux-kernel+bounces-128198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CA895770
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546C41C21E5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1041350D2;
	Tue,  2 Apr 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kEOYK3HN"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94812BF15
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069250; cv=none; b=hh2BO6pUVAoAKMl1c4+QRGy5A70y+BRdpzQw5/9Gfc5eZfK4c6mUdzU83wK3ms3ind+3ieB6UtrUFE99vrbmVPnCPMdOpUr2c4MfJSnGydAMKAPvuzrxL2SxOc6a6VTyzjSO3bzN8GireVhMndkbPhZrQOkYQ0EQZM/2VHFy1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069250; c=relaxed/simple;
	bh=yOuFMfKt3fhU2KvOiQGXseYLvQBMDDOSvq+QfscMDJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSk6X0W5QICgb2uvmVBTqoiOn5CiS9KJVK9cbbjQE+u9X5lc2V6BRBAGPJDILQkIXUFWe7UHSm0JP1fHqQ61i/P8Wu1YVN01eyyOVrF4fvr4cIpJeD1oXIm339j+gksuHBi0YjOYNXTcdcvKbt1/dtL6WMeo8G7e1yIFRkrx0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kEOYK3HN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56dcf805aa1so2169092a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712069247; x=1712674047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hAVh7IlPzqGjm9NpZgxRf0H+NeU99flnbxeI0QSVaJg=;
        b=kEOYK3HNYBoaLX9mLL2lizwyVaID20fE73Hc56G1UdRcle/UVuCx3hltn8614LQx4I
         MnvcF6z3yNIYAEFXZU0hFsMKqCiuP56KSD6fhU2B0zp8I8OoKfkoQiFIZCpvPbgEVFtc
         +Aalx1e5QgW8aYGoJ+l67mSmy+cHvtUWQOpbaHzBWhVm0Su2RGW5ANcQ77OHp1dcpart
         XcLbUqy3jLBJaQg5zel1yX8eUGabfggA81c2/pop4T8BoTL6mUYSXTHIIqvSHi4kiq39
         IxltSd6zcQWdv/kw+TIbuFUNwBZXB/YxApYHkCYEYyCI4QpoNHbL3sbqtTbWi10gYmpB
         M28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069247; x=1712674047;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAVh7IlPzqGjm9NpZgxRf0H+NeU99flnbxeI0QSVaJg=;
        b=UPG/n2c27V1dN0JFD2GfeLnKTlL6tbXvgxe3DUuxQ1+xgWkOTo+rGU7AJqDJlERqDl
         VeusrDKW0LS8wVLiYqcOYsZY0KDWvzIwyYivEKhDIe7VBA2OKxzF891JPh4oojKbtvs4
         lHOusWy6tPh9W27MaIUkWT9rcf5spbyweldlQofVt9/P+Zad0XrUAMK2DpEI63qIX/UO
         4Rfo3/PusW0KGG94RDeMB6upDLsvD29Dl++401VLznMzltW9tn+UIgL8Mqh8gaPvps7P
         PC7YsZ543y8TAkUoISdwsaaTafL5P2YOLA41GiDpGHY1Zf58QyBJdmLO8wkCkScG2DRE
         ybLg==
X-Forwarded-Encrypted: i=1; AJvYcCWAUKJk2dcpdsDqvjdS2hh8uK/FUtic3xvM09iVyx0Nnz8HGKO9yoNNbqlyh4lW/6/oePfrmLlaLhjjijZXW9EX06IktRUk1lrbUXaZ
X-Gm-Message-State: AOJu0Yz1TV7R/a/ssbX4Kwccmzi5RLVtIPhUBQ0B8dzAm4taTinLEn8a
	Q4CDdq79g58aMwOTawLdHS5ZW9fZn00x43iVY6mA49fYS56E02HxldMXYtXFUWY=
X-Google-Smtp-Source: AGHT+IFBVqcsXGsRjPp1iqC7U9wiXJJ38gF3zMb3VBwO2QsXOJos6FFUOnkxbTRiPODXCJMx8xQt8A==
X-Received: by 2002:a05:6402:5190:b0:568:9ba8:8f1a with SMTP id q16-20020a056402519000b005689ba88f1amr9970535edd.7.1712069246823;
        Tue, 02 Apr 2024 07:47:26 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id r1-20020aa7cb81000000b0056dd4bf7660sm2488730edt.52.2024.04.02.07.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 07:47:25 -0700 (PDT)
Message-ID: <d9ba1e11-44ea-4c1f-ab33-56a8bf57ab63@linaro.org>
Date: Tue, 2 Apr 2024 16:47:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: msm8996: add fastrpc nodes
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20240401-msm8996-remoteproc-v1-0-f02ab47fc728@linaro.org>
 <20240401-msm8996-remoteproc-v1-3-f02ab47fc728@linaro.org>
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
In-Reply-To: <20240401-msm8996-remoteproc-v1-3-f02ab47fc728@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31.03.2024 11:10 PM, Dmitry Baryshkov wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> The ADSP provides fastrpc/compute capabilities. Enable support for the
> fastrpc on this DSP.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 57 +++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 7ae499fa7d91..cf7ab01f3af6 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -3545,6 +3545,63 @@ q6routing: routing {
>  						};
>  					};
>  				};
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,smd-channels = "fastrpcsmd-apps-dsp";
> +					label = "adsp";
> +					qcom,non-secure-domain;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					cb@8 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <8>;
> +						iommus = <&lpass_q6_smmu 8>;
> +					};
> +
> +					cb@9 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <9>;
> +						iommus = <&lpass_q6_smmu 9>;
> +					};
> +
> +					cb@10 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <10>;
> +						iommus = <&lpass_q6_smmu 10>;
> +					};
> +
> +					cb@11 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <11>;
> +						iommus = <&lpass_q6_smmu 11>;
> +					};
> +
> +					cb@12 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <12>;
> +						iommus = <&lpass_q6_smmu 12>;
> +					};
> +
> +					cb@5 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <5>;

No need to copy downstream's creative alphabetical-but-not-numerical
sorting.. The entries look OK though.. although, any reason we have
such a weird binding including faux child nodes and not just an array
of iommus? Is the only way to discover the fastrpc nodes' properties
such as qcom,non-secure-domain or vmid belonging through hardcoding?

Konrad

Konrad

