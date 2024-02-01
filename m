Return-Path: <linux-kernel+bounces-47859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D738453CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAC2290111
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB6215D5C5;
	Thu,  1 Feb 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ww6TjA8o"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CF15CD59
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779351; cv=none; b=G1LZlktuJzPZf0i4tzQZNIoOfybyGmPCqxpfa3CLI3nk1jPWq+bGDXncAhmaQeR6DzGWVhmepWrWXVB+YFqZwksc6C8njYBYVtj6EYrVHxmWXWul4lT4Pdjg2OBWjBJc4fxJzrTQkoF0R5Tx4ndW+bLOpRA1jjQO6lFE3V1XbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779351; c=relaxed/simple;
	bh=UCnls0nYScj4Gw8Tni+qyBEbhZH+x58ZT5pwkkhXWKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1yylJXwP2WqnRggvSP2USnKF33Rv62n0ftWBweI6g151lxEWjlRPdPa5/ZbYR59AKifL9gy3ynNuXj/DVudZ5Q2Op90IswYHxuHStYhSPBDPuNLOdqwWl8pkV06sMEZV0ct5elBVlMdyIaTT3VmNXSWU7bn9O79tV0dfD5cfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ww6TjA8o; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so865365a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706779348; x=1707384148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLOoFrUJIzIYtpDfOXSrdtnrXFLb6/vDkUGd/NGgJc4=;
        b=Ww6TjA8oGr4QPtH4oSRNuETiHfvNEnTAOQ1wpz/KNzj9pC+Yz43jQoU05L0N0ApoVj
         o1YcYQWo5gmvxtdtl+33wULgviFuX+kzwZCIp2Y2ygNS04fpZXXibSpbjwUGPlNSonZ5
         MhOcCgsHe5zIFNFvznJ4fTGV9Y/2F0cqH9WstkaUS9+vEfLkP6LanlxJHDJDRzNlH6As
         SQUWQfi7yg4J0rp8qs694OE4IO6F5eVCiJpvfjXx4CvHI+SzCKmUxcHqxupXmOUrne5P
         SigYGpkif1d8E/BvcxkxQhyum8riEqR0X4hkqpN8FslPDfs/m6uGU2GdPS2nHZ91ohzc
         l6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779348; x=1707384148;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLOoFrUJIzIYtpDfOXSrdtnrXFLb6/vDkUGd/NGgJc4=;
        b=rNmnE9o8bNdhy/qCu5Wjg+RLBOIG2OJAXXSEIPdOvZLC4x23aTJSkpO4JGfncsOPJ5
         vDisjSjuynjvkcnpgW1QFvzu4mVR9uF2ymXOae2Zcl2WHYRRJLb0vsCWzAfM+RBejXf/
         M0mdFRm1iv1PKFkvmQ3JFZX/avJCK1TjPEUtQvprqLK75CJZoedPPje1lAOw0kQ24sxl
         gc7dmT1OXdxuX6oOMp2JzVeFvUjgOgUGzafVCjlZ8sHi86lHOlmv25ZwkH/VUqIGyimm
         Rxfr0h4Dv7Tw+ai3pHzGgAI8vp+vVm/RyB3abx5oMp3poOQ4eVzxMM9mv2j01kS1zU33
         o1BQ==
X-Gm-Message-State: AOJu0YwzD8mbOoMvTbgBjETTeUL19MBeFIbtI5cxYK2rK+D5OTDqcGJc
	av7QdJIDoyPe1xl67shdXIC6so6bxtkYJdD9ldsNVO5+0kZapgShRYp23j6M5XY=
X-Google-Smtp-Source: AGHT+IEdbQZgqM2h6eY8gLqVNg8XWX9QtwSGZ5SmwPh1xVOuLb4a2lGd7Op7A7Vh+lmsLadVtp/MWQ==
X-Received: by 2002:a05:6402:4e:b0:55e:f9f8:9026 with SMTP id f14-20020a056402004e00b0055ef9f89026mr2928108edu.6.1706779348132;
        Thu, 01 Feb 2024 01:22:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW9SdMrx3KPqHycp8Ay290Yp26kqUIgVHjr5hnAeu1Sz1ZfTp5wVhw2BxyfF77RlJ5DGnW49SeEUVcPaccVKBoTD3F9+PariBKUXWwVdjhDlKuRZhOrjgzfYdBPYCLG3SaQkFt17dVsk2YU/ItNIIYwwPqUYvo3VU9ju7nNtewvBKn1YmEO975K3CKvCPMobPoVN9WDaF9erutl73Ry/bd7QOL1HMRumEHri7eouPrNm0kfIaBq+RP67RnFy0ardE5rJ2qY6kLp1Ac/rk5v9JiGAcusJvYx7X7mLClz03r427lGjw95+ueWRoZhp/BrElNR6gpVNiid/xgFSsB4e7fw56ymvApOpaYDyS1QcAOpuwhA1R6bnqZk01agJUorYLz/ORvHJ6bPxydr4/ItqMWe5+7DEonf
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ch25-20020a0564021bd900b0055ef4a779d9sm4276981edb.34.2024.02.01.01.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:22:27 -0800 (PST)
Message-ID: <523895fd-5a7d-4467-9a51-b5f85668f0af@linaro.org>
Date: Thu, 1 Feb 2024 10:22:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ARM: tegra: Add device-tree for LG Optimus 4X HD
 (P880)
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Kees Cook <keescook@chromium.org>, Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240201092033.10690-1-clamor95@gmail.com>
 <20240201092033.10690-4-clamor95@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201092033.10690-4-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 10:20, Svyatoslav Ryhel wrote:
> +	pinmux@70000868 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&state_default>;
> +
> +		state_default: pinmux {
> +			/* WLAN SDIO pinmux */
> +			host_wlan_wake {

Not much improved around this.

Best regards,
Krzysztof


