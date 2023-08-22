Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687E5783CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjHVJ22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjHVJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:28:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E57FCE7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:28:20 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso35325761fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692696498; x=1693301298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYCWuDEeHYOPtK0AWhMM3Rkt4Ap4j/1KSwrOJimYE0c=;
        b=TgyBqpv+oi8jw1TRC8VqEQTvviqa31xM4CjbVK2AG0PYnHwMDCZ0v+XJzDBtbx9bR+
         7bCXX4yB0bVIj6oEYt8YcFMKcXD07rMH9hSe3RpoHkmaihtt2mXd5lugViTwfVdItRvF
         NUskZlO5bCFrWJWmHuaDbHiRrNRKL+grXplbV3wam/e7uBYS66Hg0bsXjFfUGxT331xw
         rmwrKHqO1Rq+NQlRcYZrRtnsUl2qpu80p4rw1ew4J9ZADPLm9eytN38kn4C/6DHUambm
         8i0smNIV1mfn5qURhiXF4FQRSi+ndVv/rdHWADYaFGhsr9uLxt0f1Vh64MRz57aTa+l/
         9XiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692696498; x=1693301298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYCWuDEeHYOPtK0AWhMM3Rkt4Ap4j/1KSwrOJimYE0c=;
        b=KJ3elGA3MIysMIy6zh+KMnYdNsAZDQjIrVVclWGdZNMlad7Ex5m7GYZ9TWaOM6e+ep
         K4rpHhnso8G+1enTIu0b93o/+85r19rY3A6hG6O8kNZh4EVJdwTo2xYUgZ4C0Fk0ifOz
         uh1u2udx5Tm5OFCzvmVPoUHFG7dcvEGk/nQhWPS79RsoIOAFjnFY4B/kyp4UI30AYYnO
         PADyszbu3ltNNdrp3qInz/YNErq8uq7UWiRUe5mJOouWGuJjcgsBb+0Bienexi/0tmFJ
         PgsolhVsnIF/Wp+muZ4XDgjf6Tvdz4m+CWw2Mt5/Qe1xg6aow/t0e7F6sPxUjcWzud83
         F0zA==
X-Gm-Message-State: AOJu0YyQzB4QyTxABiGbFj10PQIb8nrR/zDcoJtaYpB3kaJoRChJSjBj
        4gdwzt3UEuYiB5TMdMl/KHVDMA==
X-Google-Smtp-Source: AGHT+IHR+jJX2by5mywacWQBry3iE+GcPa7XIz8URqXavA8ii73gAuzZ6NBlhgbJw5Sgc2bUB3vAUw==
X-Received: by 2002:a2e:6814:0:b0:2ba:18e5:1070 with SMTP id c20-20020a2e6814000000b002ba18e51070mr6998865lja.24.1692696498193;
        Tue, 22 Aug 2023 02:28:18 -0700 (PDT)
Received: from [192.168.1.101] (abyk189.neoplus.adsl.tpnet.pl. [83.9.30.189])
        by smtp.gmail.com with ESMTPSA id p17-20020a2e9ad1000000b002ba053e1f9bsm2687133ljj.35.2023.08.22.02.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 02:28:17 -0700 (PDT)
Message-ID: <6f324696-1648-461a-a3ac-20f0b76e41f0@linaro.org>
Date:   Tue, 22 Aug 2023 11:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: regulator: qcom,rpmh-regulator: allow i and
 j as RPMh resource name suffix
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230822-topic-sm8x50-upstream-rpmh-regulator-suffix-v1-1-23fda17f81f7@linaro.org>
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
In-Reply-To: <20230822-topic-sm8x50-upstream-rpmh-regulator-suffix-v1-1-23fda17f81f7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2023 11:27, Neil Armstrong wrote:
> Add "i" and "j" to the allowed subffix list as they can be used as RPMh
> resource name suffixes on new platforms.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Also 'n' and 'm' for 8550

Konrad
