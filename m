Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D117FE9FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjK3H4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3H4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:56:13 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E96ED7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:56:19 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bc21821a1so952871e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701330977; x=1701935777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxqzb1X121APtDpLdp11t8VEv5Z/kpFijkLxSW6XScE=;
        b=ZaVstZiqRBEbD/mfwj+PrJ+DytcONL2HsA6yI8SShTyOpCjR52ox6iNoHKwZ1P0EJw
         aEIxdcBLw8GMSjA6wnbwEYACjtf+BqLHOxK79//ML+Se4bsPVIoKexqNaaJPtwTBvIwi
         57MfGQdCaKKCgv9dpP6fz/PRL1MKBn46D8VtOxWp5Y92rwlm/tI/13DnZpchh38ZNs9/
         q6sxhtNFWdZeOWcRfxwoMQEcGhAhD7cZoewDcumoOMS/SRzrcVZKGbBREWXR5Hj3VfmL
         asooCsra4tgbcvCkkhDp9ts8NgvAFvyq8Loio2q/TeqdL+IuHTTSv0/QjoJFmJNrRMnr
         xHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701330977; x=1701935777;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hxqzb1X121APtDpLdp11t8VEv5Z/kpFijkLxSW6XScE=;
        b=n0pxeMGWEEFDcjheMCewzwJEeOA4xX3VDYL3mWEQP2hKT4QQQgAhkOk2X4Vli1NaK/
         9IhooZ5EErGTnk4+aD6jrp207YJA2kyEzmlvrpcQUW6o4cubaUpBEbPJmIAvFrE9pBWb
         bUlKXVGz4rW9MEaKk1CTdqcuCGd2uHc7XakVb0SvXOvZDdf6dyivebmRVZiunaEnwr8g
         byg6CREauo9RjsmzLI4gaOtcgnfdhdVIqZ4YfPZEHbITsjyNmn25MqRKYGe2OPPUzol2
         cyGclBdDQQRwlk71UkLSEOE8q6soZ1sU/XXVCEWap5hMDjKOVD8TE9XOsLL6zxJQ4s1+
         0XmQ==
X-Gm-Message-State: AOJu0YzU3wHqjC0PF9Mvsyp4atVNedYebGQvPPzyLtX0itXwJdk6TStG
        LNsQtyKxSdI2Ix7PesfPU6rnhw==
X-Google-Smtp-Source: AGHT+IGyKPSAev+tLQnJ150MF3XpZU+0pGQaPHior9E5YFakCP4IxYBnF6ubaYxYupnQvHtWtC5LnQ==
X-Received: by 2002:ac2:424e:0:b0:509:dd0:9414 with SMTP id m14-20020ac2424e000000b005090dd09414mr10583918lfl.24.1701330977529;
        Wed, 29 Nov 2023 23:56:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id t26-20020aa7d71a000000b00548b55f5ffdsm290854edq.16.2023.11.29.23.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 23:56:17 -0800 (PST)
Message-ID: <e90e171f-8fd9-4b93-9d9c-7216448ca6d0@linaro.org>
Date:   Thu, 30 Nov 2023 08:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: samsung: add irq_set_affinity() for non wake
 up external gpio interrupt
To:     Youngmin Nam <youngmin.nam@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        alim.akhtar@samsung.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38@epcas2p4.samsung.com>
 <20231126094618.2545116-1-youngmin.nam@samsung.com>
 <bb738a6b-815d-4fad-b73f-559f1ba8cd68@linaro.org> <ZWU75VtJ/mXpMyQr@perf>
 <1fd55b36-0837-4bf7-9fde-e573d6cb214a@linaro.org>
 <CAPLW+4n0SAOTb6wocY-WjkxgSFMbx+nVuqdaPcNYVDsbfg+EfA@mail.gmail.com>
 <ZWbjPIydJRrPnuDy@perf>
 <CAPLW+4=QQR_u0Fi2L0orQFTd-_UpYZAQ94Je772Vs-2WKZGuiA@mail.gmail.com>
 <ZWg5/rorgfSM/5UO@perf>
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
In-Reply-To: <ZWg5/rorgfSM/5UO@perf>
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

On 30/11/2023 08:30, Youngmin Nam wrote:
> Thanks for your test Sam. It's really great work.
> I confirmed the patch did work by following your test sequence as below.
> 
> * Before
>      CPU0       CPU1       CPU2       CPU3       CPU4 ...
> 87:    40          0          0          0          0 ... gpg1   0 Edge   Test Key
> 
> * After
> 87:    40          0          0          0         22 ... gpg1   0 Edge   Test Key
> 
> Krzysztof,
> Sam and I tested this patch on e850-95 board.
> Let me update commit message with test result and will update patchset.


Be sure you always run checkpatch on every patch you send.

[Checkpatch]
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
description?)

Best regards,
Krzysztof

