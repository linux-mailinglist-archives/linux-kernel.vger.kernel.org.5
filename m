Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5CC7CC548
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbjJQN4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjJQN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:56:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDD7EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:56:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32db188e254so1781179f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697551010; x=1698155810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C2/K6vlOwwhFZL89gEXx5kDjuahP9rSV9ZYFF3I6k6c=;
        b=P28zlf6nqNSQF+erA0sQFjmx1X9+gX5fClUeWwRko0sF31oDNOHytvNDqnUsvgsRbe
         IcNrwwfHQkJlPxKAn9WquzGNe+ujhDeQPKIAs4CVnI36Zm+GUA7NPjI0x8oCXJDIEcei
         yKvYZ+6tCxZpM5EzXQSQY/DVEqVc4A8MpYOduGg8Bf9hRYW6reCm9NU1OZeHg6JVo1oq
         Zp0JUscd/6BE5Huja97Cw4WpBloPN/+fwWuPR0Ap3L4TA3NgEPj0a+I5euoxwyUq3G4b
         0m4mXGyZ507zO/lAqdFOV6k4vfIulFFiLk5bU9Akysehcf55Dj96DYKGn6d4m80y7fP5
         FQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551010; x=1698155810;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2/K6vlOwwhFZL89gEXx5kDjuahP9rSV9ZYFF3I6k6c=;
        b=HGEqkTeLHCWV4legL9Ybr0ukAm/vYrBFLPNB2oCAlleRxaMRkFBmHnsSP75HpWv35P
         25dagqli26Pc+SnP/L22cCHnprvXcg6zR2LnE59irN3yH7rqTkkObWwXy1bcZJvBy+8j
         lErzx3MovBsaIdy22itDxzEO2wKKcS226weiKVVncAVipUt8jyThHagEn3InXcfx+fpD
         2pOry/1jZH+5Z8ZrxfgC7tyi2wdjaT+t5tTuyK6BR75waGqmTnoacJi+0faCq1tVlS30
         e77t2YVkorrdpKhck+84x+qTG9uodujxkAtetswXD4sReEZ8y26869YSbwYKFNqdJDeV
         QTzg==
X-Gm-Message-State: AOJu0Yxmb/iaaHnCqy+yn7dkF1opokX4jGSZ/hEqDVKjPHmLRhx+S3EK
        phRB/cSLk4ivtxTcVwtG72sOIK0/t7brNI5irdA=
X-Google-Smtp-Source: AGHT+IFqp7nyh53C4rBltbvEuYYkgK1OpCkwsGgRLRleTBBF4dXaMNZDB+CUyI4qWw1ChrcKgUJE/A==
X-Received: by 2002:a5d:45d1:0:b0:32d:a495:435b with SMTP id b17-20020a5d45d1000000b0032da495435bmr2018483wrs.61.1697551010050;
        Tue, 17 Oct 2023 06:56:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id p5-20020adfe605000000b0031fb91f23e9sm1742909wrm.43.2023.10.17.06.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 06:56:49 -0700 (PDT)
Message-ID: <da534343-419d-4fb1-a50a-cf5da19b08c5@linaro.org>
Date:   Tue, 17 Oct 2023 15:56:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: w1: coding-style - naming for master/slave for new driver and dt
 binding
To:     Kris Chaplin <kris.chaplin@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, Conor Dooley <conor@kernel.org>
References: <91104ef7-c9a6-4c65-aad0-61ecb3c29ea0@amd.com>
Content-Language: en-US
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
In-Reply-To: <91104ef7-c9a6-4c65-aad0-61ecb3c29ea0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2023 11:38, Kris Chaplin wrote:
> Hello Krzystof,
> 
> During review of my dt-bindings patches for a new w1 driver 
> (https://lkml.org/lkml/2023/10/13/959), there was mention that the use 
> of 'master' is not considered great terminology nowadays.  Are there any 
> plans to replace the usage of master/slave in w1 as mentioned in 
> Documentation/process/coding-style.rst ?

I am not aware of any plans to rework/rename existing code in w1.

>  As we are in the final stages 
> of our W1 soft IP development, I believe there is a small window in 
> which we can align on our new IP name if appropriate, prior to my next 
> round of patch submission for amd,axi-w1-master and get the binding to 
> match.

Naming of your products is little concern to us. How you name it, it is
your call.

The naming used in Linux matters.

> 
> If there is a preferred choice from the example alternatives in the 
> docs, I can look to see if we can align the naming and update my next 
> patch round accordingly - however if the guidance is to keep to the 
> specification-defined terminology (pre-2020) then we can do so.

The first diagram on
https://www.analog.com/en/technical-articles/guide-to-1wire-communication.html
suggests to use master->host and slave->device naming.

https://www.analog.com/en/product-category/1wire-devices.html also uses
"host" term.

Best regards,
Krzysztof

