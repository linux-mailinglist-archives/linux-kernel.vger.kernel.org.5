Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ACC7AD05B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjIYGmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjIYGmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:42:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335F4A3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:42:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405524e6769so19569775e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695624133; x=1696228933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxPA+KdsJMnTVrzO2Y8BmmDcflApuxJbXgL4sNW4wUo=;
        b=jPzMmtO32dFUCtGTYN1JFRS/Ba3/ITmgf/GACD+wxiwBuMkr7WEpVT9X33596PikoU
         dMkclaDtL5LixXwMJIRmcKtEe5xcTLaJb/+RtIRRu/ovcJP48ZfUsSlkzxK5RsWK6bL9
         6iZhBBKOJmdTSDBc5T06yML5LZYAICkQrMQF8HOZjBfaqjD9pwfzo8n7B0dOTNHDXo7z
         d1ng95kkrYBtbAtqm5eCAfgoe+mFuDLFuZH1Tqa3rYviHfTs70QEr75YM0WS2G7b5GNW
         D6c8U6HZ4+NagUELfEPYX8pPtMG1m0s6rCbaUwN8tN4PtxYSIyeiDrPPy+Dtdu0RLF/E
         3nUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695624133; x=1696228933;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxPA+KdsJMnTVrzO2Y8BmmDcflApuxJbXgL4sNW4wUo=;
        b=itn199xu5nQD0WqpRZzOBps9O3S0K5Qjqexe7U9d5xJK3EofHemhYQjsZzgqCS20IT
         m94Y37v28VmJRFfcwrWGcWrUklwNmqAVUxjDlwZwkhBpRvzKbvXeRLWTBBg+VUkLXXBn
         0nIx67+dkdBhoAVvcDarDn3mCzuX/7Z42gNi/nUHd/dv7R0qdrlKqpGYi5lpilhjyh5E
         OrE3PSVqJOp4/cOzMs96b98nTFCyitV1oaaIjXM7r7pB6MqlTmQtDS8rjRAcX6NfdNBq
         El7c/mFUN4PsShIOrREykbhoYpQF9t++DAtK50CWt3zyWIlz1DXtox8Dp3G4jouRt6L6
         Sp1Q==
X-Gm-Message-State: AOJu0Yxy4XTFRcNUPHPHQam/rNkVpgZGkpyUXk/ZdmCb3tOXLB8MafMl
        AgRbjUKoFJnylpl1aG+y96I1gw==
X-Google-Smtp-Source: AGHT+IF3BuvnLiDMOCnyW5AJa/rMsbhaZSmkEDsEHvVaD90jVBMWixO3kjtvNOuQdxzuSq5gRUzjnQ==
X-Received: by 2002:a05:600c:cf:b0:401:609f:7f9a with SMTP id u15-20020a05600c00cf00b00401609f7f9amr6744769wmm.8.1695624133076;
        Sun, 24 Sep 2023 23:42:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id w10-20020adfd4ca000000b0031762e89f94sm10899573wrk.117.2023.09.24.23.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 23:42:12 -0700 (PDT)
Message-ID: <e69ca292-e0b9-4ee2-9f4e-6e9300a636a6@linaro.org>
Date:   Mon, 25 Sep 2023 08:42:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] dt-bindings: gce: mt8195: Add
 CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Content-Language: en-US
To:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?UTF-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?UTF-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?UTF-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
 <20230918192204.32263-3-jason-jh.lin@mediatek.com>
 <20372e40-e4fc-467a-d91a-fcf8e26728bc@linaro.org>
 <1f324b04cbd8faa7510a3519eb718c0be25af2be.camel@mediatek.com>
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
In-Reply-To: <1f324b04cbd8faa7510a3519eb718c0be25af2be.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2023 07:05, Jason-JH Lin (林睿祥) wrote:
> Hi Krzysztof,
> 
> Thanks for the reviews.
> 
> On Sat, 2023-09-23 at 20:01 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 18/09/2023 21:21, Jason-JH.Lin wrote:
>>> CMDQ_SYNC_TOKEN_SECURE_THR_EOF is used as secure irq to notify CMDQ
>>> driver in the normal world that GCE secure thread has completed a
>> task
>>> in thee secure world.
>>
>> How can #define be added after its usage? Does it even make any sense
>> of
>> being separate patch?
>>
> 
> This definition is used in the mt8195.dts at [PATCH 15/15] and the CMDQ

No, the define is used in previous patch, which means your patchset is
not bisectable and not tested.

Best regards,
Krzysztof

