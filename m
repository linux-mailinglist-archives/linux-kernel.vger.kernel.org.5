Return-Path: <linux-kernel+bounces-156659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D627F8B066A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A411F2371A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8D158DDC;
	Wed, 24 Apr 2024 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8PuP6rt"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211C5158DC1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952221; cv=none; b=BvQcHplAfAR8B2h7KiovYbnYCF5LaIYRjtUbU44IhUL08I5QaVV6EnZJEkCCMFCqzDCXMsithtqoTz1dSxBesh2IeUQSq3QbI2vGdgn+ONcGVjx7BufC2ux0opwE4DCfw/F7b6KM68JeE5/WgVaE++VoS9S+i28G1kvPwxU99vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952221; c=relaxed/simple;
	bh=OE4+MtgDFV/x9TPVmJld+nuyU1JQaj6r+uaSviQCUGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aM8+JYkZD/2XOXD/Amx/XUXU6WX5gGHDKOboGhJGvJvkhaoKlSSUKztLmGr/NPrXcIwsC6UMaR8EW1ToUkdFb/zN0pYxdAG2322HzPBfn+kOamtUxNFK0OeNehJI/TRe60uXqVuf4HAayN2qXq+7hnDcQ3gZu5qs2zexFdr9RMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8PuP6rt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so5787593e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713952218; x=1714557018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qkkNo0T4k/vPc6RiPBQsA3Jo1HLwOL4Jh/4Wlzwp3b4=;
        b=B8PuP6rtEUdHGvjiV3ULkGHIHSUTQWBkcVXUz9ajtzbjTvErMzmeEMrjenGRnDtX4F
         HwbCRCQDe2ZL6SuWpj12hzfmz7iBaAT+q/ETjo9ju4w2feGTJHvH0WG/vdVWHhKZtZ9V
         cHrE2DY505LQovWMaCd0sJNRFTKU2QQsKe/PAZaqmN/XhZwV45OBpbxFik+FAGwX6WYv
         haNTD6X72iHgTh7AnmPeaUaNvqBaNs6DCUz2cYs8xV+n2yS0+YkSYgs13cBtJLJm+tyR
         i21mwrdTHuK58g+D4rL+O67MYcRvYNdi1TBId4yqCC3T46Ho/QJG4BBq1ne+Cl9629ez
         zcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713952218; x=1714557018;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkkNo0T4k/vPc6RiPBQsA3Jo1HLwOL4Jh/4Wlzwp3b4=;
        b=EqOr4KUu1gLFb+cn/B+54q4WMbxhEB3YkEBNi034mYB0vkmt0B0HK++hEZbTy13VcA
         TB7IFaZiqstA9b589jmUaVR/x0GZt8+wp2iNY+W7OrwUlMpj/LZWZDSJFW2THTAQM9fh
         54W9QFZjX6nJKmS+lB9iRKjZS2sZuju8YW55/adBEScVtQERXaM42h8nKU4+wZ9GWxkZ
         DwjMzqnITTeQdre4PqanhPXoLBxwgjHo3rrFXTtDH8bahcNN7zoz4ZskJpKP7ASiNNa9
         zR6e0HOApN6dPK3YmHFCyNn6A4SbMozn3JOrIc2gKmf5UIqNkwDDjf7ndZ+7PG9JHgdb
         HrgA==
X-Forwarded-Encrypted: i=1; AJvYcCVNhVyd++g1v+jVJZXKzh48qUXujiwsHK1Laohkq0d3+kDF4KMMJrC3A6D9sCP48oyBEs+r9T/r0GZwsOpFK/kZiZA7+AJOJ13v7ZQv
X-Gm-Message-State: AOJu0Ywl8WDXsQee5PNzqNTDLVwybwA05vnte9d84p5ZLf1lhG1QwVcm
	QovV6q8kIaMYCZOJFoIHhQuNP//yEA57QAjMkYMyVW0n/1fDjUhwaBJtyLCKUPk=
X-Google-Smtp-Source: AGHT+IGAFUf0JcRz0GX5s36HQG4PVbcUKadJh+By3FOzb/j8qZ7E50n00W8LJsgnSnBA2y//OZkwwg==
X-Received: by 2002:a05:6512:10cb:b0:516:d002:47cb with SMTP id k11-20020a05651210cb00b00516d00247cbmr1710582lfg.43.1713952218088;
        Wed, 24 Apr 2024 02:50:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709065f8e00b00a559bbe8a00sm5373647eju.100.2024.04.24.02.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 02:50:17 -0700 (PDT)
Message-ID: <0554309a-f810-47a1-9047-43d09caf533a@linaro.org>
Date: Wed, 24 Apr 2024 11:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: quic_zijuhu <quic_zijuhu@quicinc.com>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Wren Turkal <wt@penguintechs.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <7b3dc952-d202-4377-9bb6-e7598e28de97@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
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
In-Reply-To: <7b3dc952-d202-4377-9bb6-e7598e28de97@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 11:32, quic_zijuhu wrote:
> On 4/24/2024 5:04 PM, Bartosz Golaszewski wrote:
>> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal <wt@penguintechs.org> said:
>>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> Any return value from gpiod_get_optional() other than a pointer to a
>>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>>> power_ctrl_enabled on NULL-pointer returned by
>>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>>>
>>> Nack. This patch does fixes neither the disable/re-enable problem nor
>>> the warm boot problem.
>>>
>>> Zijun replied to this patch also with what I think is the proper
>>> reasoning for why it doesn't fix my setup.
>>>
>>
>> Indeed, I only addressed a single issue here and not the code under the
>> default: label of the switch case. Sorry.
>>
>> Could you give the following diff a try?
>>
>> Bart
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 92fa20f5ac7d..0e98ad2c0c9d 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2327,16 +2327,21 @@ static int qca_serdev_probe(struct
>> serdev_device *serdev)
>>  		    (data->soc_type == QCA_WCN6750 ||
>>  		     data->soc_type == QCA_WCN6855)) {
>>  			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
>> -			power_ctrl_enabled = false;
>> +			return PTR_ERR(qcadev->bt_en);
>>  		}
>>
>> +		if (!qcadev->bt_en)
>> +			power_ctrl_enabled = false;
>> +
>>  		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>>  					       GPIOD_IN);
>>  		if (IS_ERR(qcadev->sw_ctrl) &&
>>  		    (data->soc_type == QCA_WCN6750 ||
>>  		     data->soc_type == QCA_WCN6855 ||
>> -		     data->soc_type == QCA_WCN7850))
>> -			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>> +		     data->soc_type == QCA_WCN7850)) {
>> +			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>> +			return PTR_ERR(qcadev->sw_ctrl);
>> +		}
>>
>>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>>  		if (IS_ERR(qcadev->susclk)) {
>> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct
>> serdev_device *serdev)
>>  		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>  					       GPIOD_OUT_LOW);
>>  		if (IS_ERR(qcadev->bt_en)) {
>> -			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>> -			power_ctrl_enabled = false;
>> +			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>> +			return PTR_ERR(qcadev->bt_en);
>>  		}
>>
>> +		if (!qcadev->bt_en)
>> +			power_ctrl_enabled = false;
>> +
>>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>>  		if (IS_ERR(qcadev->susclk)) {
>>  			dev_warn(&serdev->dev, "failed to acquire clk\n");
> i suggest stop here and request you code review for my changes, i found
> the issue and given fix for my concern.

What are you answering to? What the heck are you implying here?

I think this crosses some threshold of ridiculous mailings.

Please get your managers or colleagues to review your patches and
process you follow.

Best regards,
Krzysztof


