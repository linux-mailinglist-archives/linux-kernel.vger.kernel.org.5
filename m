Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4050E768FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGaIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjGaIVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:21:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6A10DC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:20:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe3c7f16bbso238042e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690791656; x=1691396456;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3fq/cbXGs/QxPb7Eea+s0s7hsPmjDBgYbWThXAxt1KQ=;
        b=L1G6UGNI87/2QMFnmY6w3M2a2U9lTfnzXHHx+YO8F+gQXHL5MaQXSOsO/lo2NzVDGB
         xJ8oaiZP/6xpzZER7nuVF116u9sLH4k11Lz3HHZeUc/rgwXluSybDnGyLkVSZpi1VdJd
         7NWZZQn/ldE/aWqp1l79AQuRJto7EHyxnXWwDLVa0iTG2GU3buER3Z15DaNstkq4LXYn
         fCe99s7IkCTkaFP+oH8Lcmzc315i3B/mWBLFqtsvc7cqpl6ULyQMqDqvnpJIUPJK9kwq
         C60qxtd0l0ClA0/E+G1c7ZHgx521G/685EBtno6+Efc+mBdlTIGcNptq7RBTJ7B31+Ku
         t1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690791656; x=1691396456;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fq/cbXGs/QxPb7Eea+s0s7hsPmjDBgYbWThXAxt1KQ=;
        b=B5D1kQpNkUmAVMMzkXQ5oT+C3p8S3ogD7P7BsapHVDMNTrtnrwSy5Jr5LGFFhsa8mC
         eToVAlQLy9AxULx5A+J2WVN4ZOQcxXRUQAP4Hy5DpM8+niHCXIZ1DUOV/wqgPYh1A5oO
         fYoQwBL8DUT1FmDXyslkb1aeTDVpbkKN8T+R6oL9I93QbfeF6Twg0PMpOcjGQVvUaHn9
         Rij4p1pgWXq7wAp5df1tZD7xkm+y0PDskpo31iEFI238PLYw9vWJYFKhxcBlVZYKe0AX
         1A7xo+Xy6nvOlbtdTESEVhGHSE+6Oo43hb4xhxZ6nbcAc8OX/l5UlcbcU1EsmzDfWHfP
         FD1A==
X-Gm-Message-State: ABy/qLaQrrqXmjNQj6whoKM5QMU8XmiYr48eT0VDy9gmIKYcT94O5X48
        ZgdRYkGMPz0WuctrCS+Hfnu6uioAvKPEzbM1Dezpwg==
X-Google-Smtp-Source: APBJJlHPQIFetL7y3mizvcj1exaBpBqoVRTbsWjh59nd6pAnEwG6GyFopmlGma4pizvvPFD9VhJTvQ==
X-Received: by 2002:a19:641e:0:b0:4fe:85c:aeba with SMTP id y30-20020a19641e000000b004fe085caebamr4639898lfb.21.1690791656271;
        Mon, 31 Jul 2023 01:20:56 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id y7-20020ac24207000000b004fbc6a8ad08sm1979206lfh.306.2023.07.31.01.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:20:55 -0700 (PDT)
Message-ID: <0b1b5224-b891-bf6d-8d6f-f5d236890127@linaro.org>
Date:   Mon, 31 Jul 2023 10:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] soc: qcom: aoss: Format string in qmp_send()
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <quic_clew@quicinc.com>
Cc:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-4-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
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
In-Reply-To: <20230731041013.2950307-4-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.2023 06:10, Bjorn Andersson wrote:
> The majority of callers to qmp_send() composes the message dynamically
> using some form of sprintf(), resulting in unnecessary complication and
> stack usage.
> 
> By changing the interface of qmp_send() to take a format string and
> arguments, the duplicated composition of the commands can be moved to a
> single location.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
[...]


> +int qmp_send(struct qmp *qmp, const char *fmt, ...)
>  {
>  	long time_left;
> +	va_list args;
>  	char buf[QMP_MSG_LEN];
> +	int len;
>  	int ret;
>  
> -	if (WARN_ON(IS_ERR_OR_NULL(qmp) || !data))
> +	if (WARN_ON(IS_ERR_OR_NULL(qmp) || !fmt))
>  		return -EINVAL;
>  
> -	if (WARN_ON(strlen(data) >= sizeof(buf)))
> -		return -EINVAL;
> +	memset(buf, 0, sizeof(buf));
Wouldn't initializing the array with = { 0 } be faster?

Otherwise, this looks very cool

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
