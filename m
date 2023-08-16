Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6247B77E7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbjHPRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345353AbjHPRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:55:37 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C72711
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:55:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so108905031fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692208535; x=1692813335;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mke2nJVuibz+ntzl/bsBaTa9gqqjODSerlITEf8dYmM=;
        b=O2rHWSYcSCDwFpCVmryYwxpsiRNVb9yb0ZoH+H5gsI5SAqslbEBpA950yU5VNketwF
         1Sd00W3lRgX0RTzjUma4tUleLp0XvLLiS23jwHgXnRiKRL8T48xF4zdiBtshaFfTYUH+
         eMgGi/APVNFLTRKzBf7mrPsQL/4Snw4DYPyOkYFl7y/q4PKzekV05rpnClejUQiIQ7oc
         IUJkr++fgEqSfLMhiviNOeRn1mP3vo6szQDy5Yp2L3QRlk3ZW5Ahk/otMdnrYi8rtlEy
         PPdbGt4uTCw0qhMcoBm+/StrxmKqz6GrP7gDjrTlqwFsINsg2fP2WRcWat6COvJCWM28
         sU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692208535; x=1692813335;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mke2nJVuibz+ntzl/bsBaTa9gqqjODSerlITEf8dYmM=;
        b=ik0kTrK/pCAi9u5YYrfyNVQyz26gVlkGQnfwlgcLmAaG7hv0xAwcaaoZxjb+XC7Me6
         FUdyS54PBVJpU5qgeTf6yYgDfTwZjaYXQzAr/vn5lKMsf1ysVv9XGkqTi0LMOIzL3Ycn
         12/8yY2OWukZ+Hdqa29S6BLCbz5rMbZLTA3NH4vzQEC+0ax0WCKoR9aKDi8Pw/bd+5Mm
         evwMc9s5tSw7kTTNe5ur7MTTnych2UfAspga7vHUh+EWfLLo1GFqyV2UsqX0IjcZgtm2
         HcxtMXmcsCOp9jTLq7TiCIwa43AAqMYEeIkKifvDz/rUHrnaFZbPjqol5O3d3LqWFuDk
         Emmw==
X-Gm-Message-State: AOJu0YwUzWC6IF25RVVooVJWcRjHPTMtoRcPf+5efMW2i1DPhyukP1j4
        lWdYBvl+RaLesiZXD1UBoDqGUQ==
X-Google-Smtp-Source: AGHT+IEYfOcYVxdoQ86Hst1wbm2fNZNuNK4G4d7/ulBpAjnnd8IfqYl3ER59P8bQNULSMamj2nUlHQ==
X-Received: by 2002:a05:651c:203:b0:2b8:67ce:4ad7 with SMTP id y3-20020a05651c020300b002b867ce4ad7mr2238864ljn.6.1692208534845;
        Wed, 16 Aug 2023 10:55:34 -0700 (PDT)
Received: from [192.168.1.101] (abxi8.neoplus.adsl.tpnet.pl. [83.9.2.8])
        by smtp.gmail.com with ESMTPSA id k22-20020a2e2416000000b002b9e0aeff68sm3581086ljk.95.2023.08.16.10.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 10:55:34 -0700 (PDT)
Message-ID: <0b147103-12cf-4a74-916c-0b8da0040082@linaro.org>
Date:   Wed, 16 Aug 2023 19:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] clk: qcom: gdsc: Add set and get hwmode callbacks
 to switch GDSC mode
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
 <20230816145741.1472721-4-abel.vesa@linaro.org>
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
In-Reply-To: <20230816145741.1472721-4-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.2023 16:57, Abel Vesa wrote:
> From: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
> Add support for set and get hwmode callbacks to switch the GDSC between
> SW and HW modes. Currently, the GDSC is moved to HW control mode
> using HW_CTRL flag and if this flag is present, GDSC is moved to HW
> mode as part of GDSC enable itself. The intention is to keep the
> HW_CTRL flag functionality as is, since many older chipsets still use
> this flag.
> 
> Introduce a new HW_CTRL_TRIGGER flag to switch the GDSC back and forth
> between HW/SW modes dynamically at runtime. If HW_CTRL_TRIGGER flag is
> present, register set_hwmode_dev callback to switch the GDSC mode which
> can be invoked from consumer drivers using dev_pm_genpd_set_hwmode
> function. Unlike HW_CTRL flag, HW_CTRL_TRIGGER won't move the GDSC to HW
> control mode as part of GDSC enable itself, GDSC will be moved to HW
> control mode only when consumer driver explicity calls
> dev_pm_genpd_set_hwmode to switch to HW mode. Also add the
> dev_pm_genpd_get_hwmode to allow the consumers to read the actual
> HW/SW mode from hardware.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/gdsc.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 5358e28122ab..3e4a721f1605 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -363,6 +363,34 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>  	return 0;
>  }
>  
> +static int gdsc_set_mode(struct generic_pm_domain *domain, struct device *dev, bool mode)
> +{
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +
> +	if (sc->rsupply && !regulator_is_enabled(sc->rsupply)) {
> +		pr_err("Cannot set mode while parent is disabled\n");
> +		return -EIO;
> +	}
> +
> +	return gdsc_hwctrl(sc, mode);
> +}
> +
> +static bool gdsc_get_mode(struct generic_pm_domain *domain, struct device *dev)
s/mode/hwmode would probably be more descriptive for returning true/false

Konrad
