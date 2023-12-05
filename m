Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C3805B55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjLEQkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLEQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:39:59 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99B812C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:40:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-33350fcb2c7so1391119f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701794402; x=1702399202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8TfjwRcKypybBxsw7XwMuabdDZTIwUX7pnwmTTnOxQ=;
        b=u2gkL5k/RUlcpJ13U/gn1nFMeY48+7tUcVmkJsqGlZjfYPam4AVlffCvutuG18Tg+y
         /cpisIwd18d7VCKEcwnM2uJVUvNZ5BhDFQmDEtRFwMEdiLa2QELPt0ih5k663QF6htaP
         JVIV59l91bIVUesTd0AwScW5AQMYLWV/G7rQclEnVbvj3j8FZ7aHPo+pb4wFqCOrJZLU
         SCQ2OjeEMNFleiw9wbYfN5Q9CkIZje0XxqmKCEBbpQfMtxgFgN1Y+Vo5samLlaQzg82e
         JoaNtpDJtbTQ1nHfDi/Dv12eH6rU3VMwk4r13OK0pIdUeU0aINF386/1cI/TQrbrMxhM
         I0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794402; x=1702399202;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8TfjwRcKypybBxsw7XwMuabdDZTIwUX7pnwmTTnOxQ=;
        b=uz/WHZ67orpslDfZvahPJJJd3csLkQXOx5AdyWl8nl3mM0dCC1F+mAKVEOBywShoPj
         iFSlFF+6WA3VuL/6eX0IhYIgKZTqVZP/6QxPBLJ0CYdVez857VazcXyVnlka67x97awr
         7+0VfhHQiTqCP3LUP4UNTyIMivn+WIPm6Ov/CSgJF/y6l7b4J4R2VrveZ7bTFSBQsJti
         dQ4ytVPY/nWFEUtzK6325zD02FaRJX7/dAqFx7eeUOZzYSjxeEucxhmxKhjd7qK+GhRt
         Ekal2z8LWNoDE2kSao2J4tVAMIhWqgOjp0exmNrRg30tLD5cXGdFKIcvnSBbx/jtBn0y
         TSBw==
X-Gm-Message-State: AOJu0YxPP3DiZ05yDswtgp/+I59v0qg88dl0qRFXpRPF2MHOFuwsp76c
        1yfu93jSmsQMe7CITuI/ciboig==
X-Google-Smtp-Source: AGHT+IGNjsBTSjVxWibdAehjF0N7/gqUi3qVzIscAnMYFEmJjuzQdEcgTP+uvVFAuVt89eP/wfdOTA==
X-Received: by 2002:a05:6000:4ef:b0:333:3f7c:b2bd with SMTP id cr15-20020a05600004ef00b003333f7cb2bdmr3281889wrb.108.1701794402365;
        Tue, 05 Dec 2023 08:40:02 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id dn6-20020a0560000c0600b003333b0d603bsm2306072wrb.42.2023.12.05.08.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 08:40:01 -0800 (PST)
Message-ID: <fd709885-c489-4f84-83ab-53cfb4920094@linaro.org>
Date:   Tue, 5 Dec 2023 17:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
Content-Language: en-US
To:     Siddh Raman Pant <code@siddh.me>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
References: <cover.1701627492.git.code@siddh.me>
 <4143dc4398aa4940a76d3f375ec7984e98891a11.1701627492.git.code@siddh.me>
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
In-Reply-To: <4143dc4398aa4940a76d3f375ec7984e98891a11.1701627492.git.code@siddh.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 14:08, Siddh Raman Pant wrote:
> llcp_sock_sendmsg() calls nfc_llcp_send_ui_frame() which in turn calls
> nfc_alloc_send_skb(), which accesses the nfc_dev from the llcp_sock for
> getting the headroom and tailroom needed for skb allocation.
> 
> Parallelly the nfc_dev can be freed, as the refcount is decreased via
> nfc_free_device(), leading to a UAF reported by Syzkaller, which can
> be summarized as follows:
> 
> (1) llcp_sock_sendmsg() -> nfc_llcp_send_ui_frame()
> 	-> nfc_alloc_send_skb() -> Dereference *nfc_dev
> (2) virtual_ncidev_close() -> nci_free_device() -> nfc_free_device()
> 	-> put_device() -> nfc_release() -> Free *nfc_dev
> 
> When a reference to llcp_local is acquired, we do not acquire the same
> for the nfc_dev. This leads to freeing even when the llcp_local is in
> use, and this is the case with the UAF described above too.
> 
> Thus, when we acquire a reference to llcp_local, we should acquire a
> reference to nfc_dev, and release the references appropriately later.
> 
> References for llcp_local is initialized in nfc_llcp_register_device()
> (which is called by nfc_register_device()). Thus, we should acquire a
> reference to nfc_dev there.
> 
> nfc_unregister_device() calls nfc_llcp_unregister_device() which in
> turn calls nfc_llcp_local_put(). Thus, the reference to nfc_dev is
> appropriately released later.
> 
> Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
> Fixes: c7aa12252f51 ("NFC: Take a reference on the LLCP local pointer when creating a socket")
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  net/nfc/llcp_core.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index 1dac28136e6a..9d45ce6dcdca 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -145,6 +145,9 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>  
>  static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
>  {
> +	if (!nfc_get_device(local->dev->idx))
> +		return NULL;
> +
>  	kref_get(&local->ref);
>  
>  	return local;
> @@ -180,6 +183,7 @@ int nfc_llcp_local_put(struct nfc_llcp_local *local)
>  	if (local == NULL)
>  		return 0;
>  
> +	nfc_put_device(local->dev);

Mismatched order with get. Unwinding is always in reversed order. Or
maybe other order is here on purpose? Then it needs to be explained.

>  	return kref_put(&local->ref, local_release);
>  }
>  
> @@ -959,8 +963,18 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
>  	}
>  
>  	new_sock = nfc_llcp_sock(new_sk);
> -	new_sock->dev = local->dev;
> +
>  	new_sock->local = nfc_llcp_local_get(local);
> +	if (!new_sock->local) {

There is already an cleanup path/label, so extend it. Existing code
needs some improvements in that matter as well.

> +		reason = LLCP_DM_REJ;
> +		release_sock(&sock->sk);
> +		sock_put(&sock->sk);
> +		sock_put(&new_sock->sk);
> +		nfc_llcp_sock_free(new_sock);
> +		goto fail;
> +	}
> +
> +	new_sock->dev = local->dev;
>  	new_sock->rw = sock->rw;
>  	new_sock->miux = sock->miux;
>  	new_sock->nfc_protocol = sock->nfc_protocol;
> @@ -1597,7 +1611,13 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
>  	if (local == NULL)
>  		return -ENOMEM;
>  
> -	local->dev = ndev;
> +	/* Hold a reference to the device. */

That's obvious. Instead write something not obvious - why you call
nfc_get_device() while not incrementing reference to llcp_local.

> +	local->dev = nfc_get_device(ndev->idx);

This looks confusing. If you can access ndev->idx, then ndev reference
was already increased. In such case iterating through all devices to
find it, is unnecessary and confusing.



Best regards,
Krzysztof

