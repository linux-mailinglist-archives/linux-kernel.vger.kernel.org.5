Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4B7EFC83
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346371AbjKRAZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRAZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:25:44 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862FAD68
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:25:41 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9d216597f64so348745166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700267140; x=1700871940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYZ2P38kCYM35x5B5FPJNVqy70cWHqJDjEu04Go9UTI=;
        b=pzdwiFk/HhpNlJLI5P9x+hS13xulhjGhqNdIC2IMKggUzleRvUHknZvXE9v7qJR4b3
         9VdMbfc5PSfgGwqzHZSokBdnqn3C3qVGwKcul+In4fP+AbLXJf0ZSBVIurzMo33hLjig
         Mop1jly3ExvDGUzGYqFObh2N9pWGDdT+5Fu6/07jgOXxKsqBfoNwCGB0vRpKSh3FTQ5H
         HM2puOR8ov014Df+pt7qjILCRSfhhcBCKE+VS0SVBfU5vCnJE4uOpNS2jhNyFos7WYL5
         E/z+8csGtBSD4vR2fkHQV22GhpTcUBrJG2Otoekv6ZZShTQgae1O6LffD9vcDLB3p3ZG
         6ZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700267140; x=1700871940;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYZ2P38kCYM35x5B5FPJNVqy70cWHqJDjEu04Go9UTI=;
        b=TrVMLH77Z+BtcDLcBweA30XzJFngeFhOKWYHkUcgcr/Gc+5inimgduUo33ycS9hd8I
         LnxFIDupooGk4ClMcqH3jefqZisJX5qLezj5k7SB6TDMz1d2XXM674fnOWJdFxxEoDrb
         p3KlpCHP+EHxe1UwMXeZEsowBF6sqMKrPYwPY9k3aFDn4Zu4NHPsmYKxbh7TRpuOfYes
         0o+mXjSdyajQYDkAGX7rXzD3n2aYPsXz7xBNUhgt9oVQ8E1JmhsmUehmDv2bu9PDO0Uv
         r2Y18RKkZJBKYVjtyG3deMH958U+leHQfYr4vpmgCq41Lq0Dw1pYRH9FihhR0mf/ne2s
         y95w==
X-Gm-Message-State: AOJu0YwTV2zHoXn1lNtFYdSNVrWtrYzzkWQF/lY6a1X4cSe3XQGQqbqd
        vHa2W/FT/lnTbOx5dXqaUBJxn9HmwR41/MHeEc8=
X-Google-Smtp-Source: AGHT+IEQI0WXX9RuRxolI/x91zcvGvz1C1hlZvB/sTj9ukBz+761wFUy64usrWIs8WGsF2CKHlEsVw==
X-Received: by 2002:a17:906:748f:b0:9bf:10f3:e435 with SMTP id e15-20020a170906748f00b009bf10f3e435mr580665ejl.1.1700267140068;
        Fri, 17 Nov 2023 16:25:40 -0800 (PST)
Received: from [192.168.201.100] (178235187040.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.40])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906530b00b009d23e00a90esm1335264ejo.24.2023.11.17.16.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 16:25:39 -0800 (PST)
Message-ID: <3f3f7c21-0d03-4b59-b12c-a72e1d2b82af@linaro.org>
Date:   Sat, 18 Nov 2023 01:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm8650-mtp: add interconnect
 dependent device nodes
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231106-topic-sm8650-upstream-dt-v2-0-44d6f9710fa7@linaro.org>
 <20231106-topic-sm8650-upstream-dt-v2-7-44d6f9710fa7@linaro.org>
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
In-Reply-To: <20231106-topic-sm8650-upstream-dt-v2-7-44d6f9710fa7@linaro.org>
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

On 6.11.2023 09:39, Neil Armstrong wrote:
> Now interconnect dependent devices are added in sm8650 DTSI,
> now enable more devices for the Qualcomm SM8650 MTP board:
> - PCIe
> - Display
> - DSPs
> - SDCard
> - UFS
> - USB role switch with PMIC Glink
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Little nits:

[...]

>  &tlmm {
>  	gpio-reserved-ranges = <32 8>;
> +
> +	sde_dsi_active: sde-dsi-active-state {
Dmitry voiced concerns about having the "SDE_" part here lately
is it part of the actual pin name (in the schematic)?

[...]

>  
>  &usb_1_dwc3 {
> -	dr_mode = "peripheral";
> +	dr_mode = "otg";
Isn't that the default?

Konrad
