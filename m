Return-Path: <linux-kernel+bounces-92738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AAE87252D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05DB1C21B74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CF31429F;
	Tue,  5 Mar 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxVV/cxx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47E14265
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658456; cv=none; b=lb6yJsuPSswDK+vU9MNXRc0iNnNY9Oel61Zr87ddahZgCar5Tq36sPhYH432E1TblvkMMjnA9UnVgIUNCwVob8ZItLFDDxNzizZhVVGaNz36WSmfIDdMi+5wrW/IJQiMQR5GLLqAufevBjD8B48qIPendoEWumyYocIuPcDjg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658456; c=relaxed/simple;
	bh=azV7+Zmb8h3Ad2kZ67JTx3veTnU4KDUstFIT2BaE0Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Znh+mRLqihiGr4S7ladkLgqez6kgj1vuGEfpe2h0BU2zHnSHCYVmXqedjICuDHdWcMb+bxxSnogaMU+/g81XV1lYBp/z58LrWmubc9DqLGbZovyF6I6//YUyHf7boRvxTvfoaKU1zVMGHOAOcgYoF16Nu2GDfLYe9coI7U8p+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WxVV/cxx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a293f2280c7so1024732566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709658452; x=1710263252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qTdpRaahlDa9z2Zha5TherbMQ0/ES+OOUXltLCuc0Q=;
        b=WxVV/cxxZ4H7/Qzj7yDbImosoikH79ap3VUOnFC65D7BZYnsjAXwYSIiLskbvO5hUZ
         epyROsdEUYnyr7TDBS56CUkgRiJRaaWMCbZMUYDQGoHTSzw6PUzXCbzLDoQL5QLy94aE
         ZrsPVtT6pf9k++tJrpSkuCiLQBH7OrQXTJolQLC8oDlPqQcW27ByW8a4d9fZ5t962tgE
         ioeihkUdaHOOZDiezZOM4xpgPydAm6sApVEcD9T8Sn1AhwTNa0NeSWYKYJTVs1lowL28
         uyAekIK628WOz9QVxUTSLg3H1Ei4k2v5hNZPsP2hgV5WBHNkXxGZ8VE2NDxiCA/Garxz
         ZT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709658452; x=1710263252;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qTdpRaahlDa9z2Zha5TherbMQ0/ES+OOUXltLCuc0Q=;
        b=MS3cEy7BUEBUaEQ0Gd0oMZQ2bjOlMzb/MxEp/K+czaYaom0SDzx4Y/U/WQ1EqNrIcg
         YaS1uRBbglRKqt5g41a47LBXkTLxuClgfGqFUYY8SJwZ9Zk7AmuHn+Qe8qIXOHMLIwbu
         HzoEAmEsVDKnvFh8yJmLWAxowj1vC1FiHhSd15YS9E48h/IvwrCJIak9pORG46T8Phi/
         Gwwhbk3osWRgqWmHeQxB4tIKOp8sU1tp/Sih1mBMPw7dytw13NWiFRaegMoOXR1/lF0c
         Y2ZT3mp1S405PbeERpb0lN70TN15mBN7rXHncjDKBVjaEYer7Wm8A1VolMqcK7RAYr5j
         NXVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzYuEzKQQEOAtauNIk8YPLpX97cUYXlJXWsaevkk2v7pZv/F62C7A6UMIsYY/UauoCwiFxd91tFtJDM530HXwDHBKo2lcUFrkP44xW
X-Gm-Message-State: AOJu0YwhDCwoUpSN7cnn21/H6Y0+buXKKbS4z/c5x7v5FmlvUI7rgind
	rNFahYTiQA/WL4B+tC4jvyEZBjGeSq2fqm/03rNPjH6gLx29dQRgKLPHR+3Z6UA=
X-Google-Smtp-Source: AGHT+IGmLwJ5FeUIToG60ygUbtaMv7yy4aE9s/KnfU++LDfwXYn0ZkTLUWLthAXl2MH7KgU0HP0rnw==
X-Received: by 2002:a17:906:37d6:b0:a45:b1fc:52d with SMTP id o22-20020a17090637d600b00a45b1fc052dmr389723ejc.76.1709658452223;
        Tue, 05 Mar 2024 09:07:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061d5a00b00a44f6ce3e7fsm3709759ejh.77.2024.03.05.09.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 09:07:31 -0800 (PST)
Message-ID: <86371fc0-ef49-4dc9-b98c-7c5131cd1227@linaro.org>
Date: Tue, 5 Mar 2024 18:07:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] dt-bindings: usb: qcom,dwc3: Add support for multiple
 power-domains
Content-Language: en-US
To: Sriram Dash <quic_sriramd@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, quic_wcheng@quicinc.com,
 Thinh.Nguyen@synopsys.com, p.zabel@pengutronix.de,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, quic_psodagud@quicinc.com,
 quic_nkela@quicinc.com, manivannan.sadhasivam@linaro.org,
 ulf.hansson@linaro.org, sudeep.holla@arm.com, quic_shazhuss@quicinc.com
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-2-git-send-email-quic_sriramd@quicinc.com>
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
In-Reply-To: <1709657858-8563-2-git-send-email-quic_sriramd@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 17:57, Sriram Dash wrote:
> Some target systems allow multiple resources to be managed by firmware.
> On these targets, tasks related to clocks, regulators, resets, and
> interconnects can be delegated to the firmware, while the remaining
> responsibilities are handled by Linux.
> 
> To support the management of partial resources in Linux and leave the rest
> to firmware, multiple power domains are introduced. Each power domain can
> manage one or more resources, depending on the specific use case.
> 
> These power domains handle SCMI calls to the firmware, enabling the
> activation and deactivation of firmware-managed resources.
> 
> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
> ---
>  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 74 ++++++++++++++++------
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 49 ++++++++++++--
>  .../devicetree/bindings/usb/qcom,dwc3.yaml         | 37 ++++++++++-
>  3 files changed, 130 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> index 1e2d4dd..53b9ba9 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> @@ -44,7 +44,32 @@ properties:
>      maxItems: 5
>  
>    power-domains:
> -    maxItems: 1
> +    description: specifies a phandle to PM domain provider node

Please drop all redundant descriptions. Adding them is not even related
to this patch.

> +    minItems: 1
> +    maxItems: 2
> +
> +  power-domain-names:
> +    description:
> +      A list of power domain name strings sorted in the same order as the
> +      power-domains property.
> +
> +      For platforms where some resource are firmware managed, the name
> +      corresponding to the index of an SCMI domain provider can be
> +      "usb_core" or "usb_transfer".
> +    items:
> +      - const: usb_core
> +      - const: usb_transfer

How is this related to fw-managed? I fail to see it. Don't mix
independent problems in one patch.

> +
> +  qmp,fw-managed:

Please do not upstream vendor code directly, but perform basic
adjustment to upstream Linux kernel. There is no such company as gmp.

Run this first through your internal review process.

> +    description:
> +      Some targets allow multiple resources to be managed by firmware.

You miss clear mapping between compatibles and this property - allOf
restricting it to specific SoCs.

Is this different property than qcom,controlled-remotely?

Best regards,
Krzysztof


