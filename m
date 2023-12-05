Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627AE805C22
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346018AbjLER12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLER10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:27:26 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E669CA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:27:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b5155e154so63841565e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701797251; x=1702402051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhcUNlmdgJstzF2N43vMJv4MrkkmoZWHzFoo+Jlhya4=;
        b=HWrDhAxrf/GR+YgBqJjjvVsLJq99O3HgYOfOCGqMFIoJ6JGMFWVoZxPPoU2sg0RPGA
         /PhF+2DYEyYuIuysp1O6jUGb6BOCBli+oxhUY1/NH6iYQNofidsryveY4mD3WSKzIYnj
         lSPYEOsqb80Bmt8cPE69/EgLHtKreMpg/izEJKv+Ryj7HArJgNGlEjOZBaATMUoBn36u
         TyuMiVZHBu/iKN3lIGecdE/lqLKtqNPCwxYtWFwvhHVmnCqSIoAQWw0O1VVSwwBqHAXQ
         Vt5cx0m+j4q03b1qQ0OM5AMHkaCTUieUpI2HbpuWtDy2UQ3mfrJ7HC+XsVcLuKEWfalm
         eSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701797251; x=1702402051;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhcUNlmdgJstzF2N43vMJv4MrkkmoZWHzFoo+Jlhya4=;
        b=obKiPDE/12ZrOm3oIf/WeFt8/xYuhDG17t2tHDpJGZ736hOnCah38SAlmsATTHIqED
         D9dVmV9X0X8UiHIbkqWq3wgegL+0aLg2dzfts5xYTJ3pqkJdmCT7M6A9IYiigJBpy9zR
         7Y/7GigefnGyiPSr05LR6jZ1oRHuLnffYOTlw5xZGKUMHOr7FaFx0MzqPQWcxQoeWn3P
         zjkKp3R1VvQ6SQUyRuhzGuSxQ26qAVcsE3xpp2qmtklgNLxVFvVHbxpMFy8FS8lP10Un
         Sb6utk4aoHP8g3QgFL7jrMH6KA/bOxSsPnquCGbjeX63ZxIgFC6pDxtWaKSd2cETcd0C
         Bc5Q==
X-Gm-Message-State: AOJu0YxpkBIE+vglgossHTC72sDuldjvAYBu8P/dCyvnWpcr5jOYh5Wk
        sq6ZfWmNJKNUATJ742y8YHJpNQ==
X-Google-Smtp-Source: AGHT+IE87h13X2oU66Q1tgHVT4uxOvk/B+Km1pW6U4ShM+U9Gfma2t/JckYT9obvn8c5tThjZ5Mzmw==
X-Received: by 2002:a05:600c:12c8:b0:40b:5e21:bde3 with SMTP id v8-20020a05600c12c800b0040b5e21bde3mr688197wmd.114.1701797250829;
        Tue, 05 Dec 2023 09:27:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id uz14-20020a170907118e00b00a0a2cb33ee0sm6974520ejb.203.2023.12.05.09.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 09:27:30 -0800 (PST)
Message-ID: <d41ea6ff-3c29-4a76-833d-19e6a6649d3c@linaro.org>
Date:   Tue, 5 Dec 2023 18:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
Content-Language: en-US
To:     Siddh Raman Pant <code@siddh.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+bbe84a4010eeea00982d 
        <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
References: <cover.1701627492.git.code@siddh.me>
 <4143dc4398aa4940a76d3f375ec7984e98891a11.1701627492.git.code@siddh.me>
 <fd709885-c489-4f84-83ab-53cfb4920094@linaro.org>
 <18c3aff94ef.7cc78f6896702.921153651485959341@siddh.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <18c3aff94ef.7cc78f6896702.921153651485959341@siddh.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 18:21, Siddh Raman Pant wrote:
> On Tue, 05 Dec 2023 22:10:00 +0530, Krzysztof Kozlowski wrote:
>>> @@ -180,6 +183,7 @@ int nfc_llcp_local_put(struct nfc_llcp_local *local)
>>>  	if (local == NULL)
>>>  		return 0;
>>>  
>>> +	nfc_put_device(local->dev);
>>
>> Mismatched order with get. Unwinding is always in reversed order. Or
>> maybe other order is here on purpose? Then it needs to be explained.
> 
> Yes, local_release() will free local, so local->dev cannot be accessed.
> Will add a comment.

So the problem is just storing the pointer? That's not really the valid
reason.

> 
>>> @@ -959,8 +963,18 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
>>>  	}
>>>  
>>>  	new_sock = nfc_llcp_sock(new_sk);
>>> -	new_sock->dev = local->dev;
>>> +
>>>  	new_sock->local = nfc_llcp_local_get(local);
>>> +	if (!new_sock->local) {
>>
>> There is already an cleanup path/label, so extend it. Existing code
>> needs some improvements in that matter as well.
> 
> Sure.
> 
>>> +		reason = LLCP_DM_REJ;
>>> +		release_sock(&sock->sk);
>>> +		sock_put(&sock->sk);
>>> +		sock_put(&new_sock->sk);
>>> +		nfc_llcp_sock_free(new_sock);
>>> +		goto fail;
>>> +	}
>>> +
>>> +	new_sock->dev = local->dev;
>>>  	new_sock->rw = sock->rw;
>>>  	new_sock->miux = sock->miux;
>>>  	new_sock->nfc_protocol = sock->nfc_protocol;
>>> @@ -1597,7 +1611,13 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
>>>  	if (local == NULL)
>>>  		return -ENOMEM;
>>>  
>>> -	local->dev = ndev;
>>> +	/* Hold a reference to the device. */
>>
>> That's obvious. Instead write something not obvious - why you call
>> nfc_get_device() while not incrementing reference to llcp_local.
> 
> Should I move it after kref_init()? Here, I'm bailing out early so we
> don't have to do unnecessary init first, and the rest of the function
> will never fail.

I meant, comment is obvious.

> 
>>> +	local->dev = nfc_get_device(ndev->idx);
>>
>> This looks confusing. If you can access ndev->idx, then ndev reference
>> was already increased. In such case iterating through all devices to
>> find it, is unnecessary and confusing.
> 
> I agree, it was something I thought about as well. There should be a
> new function for refcount increment. Maybe the existing one could be
> renamed to nfc_get_device_from_idx() and a new nfc_get_device() be
> defined.
> 
> I didn't want to introduce improvement patches in this UAF series, as
> that would be an independent unit of change.

Best regards,
Krzysztof

