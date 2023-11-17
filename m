Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA17EFC49
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346342AbjKQXxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQXxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:53:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547681AD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:53:47 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so7108276a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700265226; x=1700870026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QpkeRFmyHdjXxHSMX/08tAo8DUmw9sl0gY2M0hTw6us=;
        b=WAr2aqXowqGesSyRlxz8YgLRIJhpWo5Y2wjSCJ6Y1J1stLGLhQD3d1XbOYrliZVNFs
         af3CXcKRJIoQzItRKsxCNvgunuYVehTEgXZD5u7RVh1bGrMtCLXgKsBHVaZyb7rJShF1
         2j2b/IzxYTy8pZtgUgAqf2ROKqU855sM8dybULk3iyX9nlLT5qGcP0KD8wnmhF7+Jwxg
         gPLDiyR45+BTZumQEeRcprARxS3f1mplz8BfQGQ7O1gz3hn16UQOtbkkYguLpPgOiLpe
         6fLOdex1Xo7m4/CiI0/+RdiyhfEGHXc0v76bctWOeCdJQXmbIsvkY6CMANpuokxqN7Dt
         ZxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700265226; x=1700870026;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpkeRFmyHdjXxHSMX/08tAo8DUmw9sl0gY2M0hTw6us=;
        b=aHNpnIImlBa5b8VXEk8fdMwerawslTRjoybd8s9YsF+ne7wWD7aXEqKI9me0PVUw+n
         x9piAE2rqpCKniINvBAgN9+ZKk7tyeY5GqhG6GPUa6hnGaZa/2rXAVjOBZrZxzLEXMeI
         Ani9pI484QCYmyTov9JTx20I+QoBlpWohrjzfptS4YuhEoU0aQyVoP8sa5XCdk7Nzz1e
         7DD8x7H435DdSl4mNbluoeq2/diOcg8F07VKctqh6El69WZ0MgJjoZadZfWnplZSscQv
         c+yncsYkVMBYRqFVO+MwnKPOVCWvoWxdLGw1pitIcFa14wRyDuR5l2Hfzal4koHuG3ww
         DANQ==
X-Gm-Message-State: AOJu0YyGKsWdxwd5eZGdZbZlDxfmAxnJ2hIQqxC+wDLIKs6va/S+EZ+C
        pU3+JEpWh5YlcXOZNRVVjyqEeQ==
X-Google-Smtp-Source: AGHT+IERRUx2K3z9OcsDVqVpgc/p+P/uXFJB6cFpdU9ndK7CI8fuO6ZZUamLOspDZiEx4d/L5233MQ==
X-Received: by 2002:a50:e612:0:b0:53e:1207:5b69 with SMTP id y18-20020a50e612000000b0053e12075b69mr6774002edm.10.1700265225678;
        Fri, 17 Nov 2023 15:53:45 -0800 (PST)
Received: from [192.168.201.100] (178235187040.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.40])
        by smtp.gmail.com with ESMTPSA id j18-20020aa7c0d2000000b00533e915923asm1169741edp.49.2023.11.17.15.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 15:53:45 -0800 (PST)
Message-ID: <bbbd30c4-75ca-4d04-ac07-1b458ee543b7@linaro.org>
Date:   Sat, 18 Nov 2023 00:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.2023 19:12, Krzysztof Kozlowski wrote:
> Document preferred coding style for Devicetree sources (DTS and DTSI),
> to bring consistency among all (sub)architectures and ease in reviews.
> 
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
[...]

> +Order of Nodes
> +--------------
> +
> +1. Nodes within any bus, thus using unit addresses for children, shall be
> +   ordered incrementally by unit address.
> +
> +2. Nodes without unit addresses should be ordered alpha-numerically.
I largely agree with all this given our fight for some level of
tidyness across linux-msm, but there's one specific case where I think
it would make sense to break this ordering, and that's GPIO states:


&pinctrl {
	xyz-active-state {
		pins ="gpio0";
		...
	};

	abc-active-state {
		pins ="gpio1";
		...
	};

	qwe-active-state {
		pins ="gpio2";
		...
	};
};

looks so much more readable to me than

&pinctrl {
	abc-active-state {
		pins ="gpio1";
		...
	};

	qwe-active-state {
		pins ="gpio2";
		...
	};

	xyz-active-state {
		pins ="gpio0";
		...
	};
};

Konrad
