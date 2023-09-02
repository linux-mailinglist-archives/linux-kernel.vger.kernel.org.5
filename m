Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68BD790999
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 22:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjIBUdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 16:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjIBUdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 16:33:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666B7CD6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 13:33:15 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so2373771fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693686793; x=1694291593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dH6NiKbQqe9vmnrJhfaltDvwHP6URRATlfVkCOgJw/A=;
        b=UI/XtxaIdFuJGAoWO7uQ7Umhizh1IIONklRZO7+dLCNMSDO56BW/wyL+ZoxKObL+1L
         AbZGD5RbduzbZg8aF+AjeUOyjLxo8nKJJSOEe4J1f8c34CeaLztExaMzQudHRfhoyrFr
         23kuXXWIucZt1va5ZlVVJN0rOm5LhuWgeWoRCPXYoUzfvVjnAvp705vt0a4F8y7zQPED
         Rk8+h98PbebcUSsjzZxiOwBZ184ow2equOFYyvJzU6q/s/mziNeoT+exdpCrg+hNn+Qc
         lhMB3veYcFQixxChVSc8u25t4HCkPjwLFyneiC+l51LvDyBPKBU0EIuFzebrk1Tf8fCQ
         xswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693686793; x=1694291593;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dH6NiKbQqe9vmnrJhfaltDvwHP6URRATlfVkCOgJw/A=;
        b=N4ZFiiDprUhsOUTEasCFNK1oEdw46ppovCbnB7GW0dxPgFUZU7tv1UFoU3Bk5b/oKG
         l5hr6YdHcmUgUaA/et4+oMoh0e4Uaxuddz60LNwCjQWIU1ZVvqIj8xXbRPd/lzQRDGft
         ElZwvxjgdHm9lnUPvPwfML6P96UJeHTcZTv9gyh/d+951aCsj+uxaDW0DB2JG2btA9MF
         63wIR+xlKZ0vSjDIpp1mNmP6b9P6zpCKXTHDoHMhURwv6nDEIBZ7kCgZITWnEaNcVvMs
         YJXpF+qWc5xsVFJW/Um7yAMrd20P7uPbR81aWtIFTGtA/NdHVJPUi/KtnQsBmz05pgaC
         6y/A==
X-Gm-Message-State: AOJu0YxpE9LqajrUdeqj8mKkWxBxJ7bW8GjGzNb2ffE90roDY3Z6UyCA
        nwEWZFLxtraIacJvAjx89TSeF4P4703aaZo7RWLzWw==
X-Google-Smtp-Source: AGHT+IG/ehxGK8nYwyOuB9I9WzwivyALoSIWWDeFS2WRms80E8dL9EPXOMGZNN4nZuejWRmw6y8bxA==
X-Received: by 2002:a2e:95d7:0:b0:2bc:e330:660b with SMTP id y23-20020a2e95d7000000b002bce330660bmr4212501ljh.9.1693686793674;
        Sat, 02 Sep 2023 13:33:13 -0700 (PDT)
Received: from [192.168.1.101] (abxi170.neoplus.adsl.tpnet.pl. [83.9.2.170])
        by smtp.gmail.com with ESMTPSA id z5-20020a2e9645000000b002b9f1538816sm1292880ljh.80.2023.09.02.13.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 13:33:13 -0700 (PDT)
Message-ID: <11f4e8f9-1193-4c6a-a5ae-cf592039a6b9@linaro.org>
Date:   Sat, 2 Sep 2023 22:33:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: qcom: msm8226: Add blsp1_i2c6 and
 blsp1_uart2
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230902-msm8226-i2c6-v1-0-9632b8916789@z3ntu.xyz>
 <20230902-msm8226-i2c6-v1-2-9632b8916789@z3ntu.xyz>
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
In-Reply-To: <20230902-msm8226-i2c6-v1-2-9632b8916789@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.09.2023 19:32, Luca Weiss wrote:
> Add more busses found on msm8226 SoC.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
> index b6ae4b7936e3..3b6114049e61 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
> @@ -230,6 +230,15 @@ blsp1_uart1: serial@f991d000 {
>  			status = "disabled";
>  		};
>  
> +		blsp1_uart2: serial@f991e000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0xf991e000 0x1000>;
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
One per line, please
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
>  		blsp1_uart3: serial@f991f000 {
>  			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>  			reg = <0xf991f000 0x1000>;
> @@ -313,6 +322,19 @@ blsp1_i2c5: i2c@f9927000 {
>  			#size-cells = <0>;
>  		};
>  
> +		blsp1_i2c6: i2c@f9928000 {
> +			status = "disabled";
> +			compatible = "qcom,i2c-qup-v2.1.1";
> +			reg = <0xf9928000 0x1000>;
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&blsp1_i2c6_pins>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
compatible
reg
interrupts
clocks
clock-names
pinctrl-0
pinctrl-names
addrsizecells
status

to make it coherent ish with new nodes being added today

I know it's rather incoherent with what's in the file, but I guess
my wunderwaffe dt sorter script is still on the back burner..

Konrad
