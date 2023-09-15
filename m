Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A267A1EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjIOMoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjIOMoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:44:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CF61FFA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:43:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-501bd164fbfso3419614e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694781834; x=1695386634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFljp9E8gsOJ/1p6IiKTImrdTZUSwDHU/eK5zLOImj4=;
        b=UHgBhviFEdgNddmEN7dnJIThVlvYYB1hOl50g5DOZzSSRG/wBcbuthyOb9/ZMTEeUu
         b7V9a5SVaBAAuxYYnqRhTcYJSgdJdxl3RIyIGvvwF8iDPxkggdAh+4E+146lDMsjM0wP
         DgvwVCg4ZxNaG7VSIsb03V/EYg1iENYe1WlODKg2K2xD1xSh7sDCV+RTYy05531eutiP
         r5/FK9oMqEm1jAgoGFjGCXfWW8iRCJ3QAxJQf+Y3OjugGb9CRy/MHg7okhPbhFm8f8qC
         K1NtejFfxlAygt6aUibMj1hLnt01AGlLquAoeuL7iUCijD9ZQqTUTBQQtvVyQIeUQ3b+
         9k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694781834; x=1695386634;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFljp9E8gsOJ/1p6IiKTImrdTZUSwDHU/eK5zLOImj4=;
        b=qsV9hh3ozeZtkdLdIXawFDZ/u3z3T65Co9+uKkY4j6QKvjgwwa+8b28CCDZmAVARnL
         sYab/nkaIGRXzGIth8twyY9jOt2CXZp2oK6L8W0FNuVOmNXraG8cyKPwh2a+Pe6B0eRO
         PkohbinOUum90nky1sdShRu7IzG1jbQhKyFtjV3hi7Y60SxgYGzgh8IMHI/lfdQzS+i+
         WMSkLpOdfMncSYlMW4pcoIkuthMyrvmf4fXXZT5HgpnTt/5zgN1g3+BpbqE/s4BROxUj
         20I54bojw9NBLzB6ke3iovHTUe7v5P40t6WsBhtI1Wk6Ho+cJzMKM5QF6a0p/fOGaz3W
         SWRA==
X-Gm-Message-State: AOJu0Yz3uWx9ElcUlotSz5Z78rwDC2s0MKS1JKanTSN37m9vLUyR3MYV
        DRGzbFozie07YQzEG+8E6HJpVQ==
X-Google-Smtp-Source: AGHT+IGwlUdYQGRipw08GY0WtxSkYDl6R15YdguhB/awRKjc+aS5WFLY0Mno/es7gzGOxAnPhLbxmw==
X-Received: by 2002:a05:6512:eaa:b0:500:99e8:573e with SMTP id bi42-20020a0565120eaa00b0050099e8573emr1618758lfb.7.1694781833829;
        Fri, 15 Sep 2023 05:43:53 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cbe:bc7d:62a6:5d09:5ba7:be5b? ([2a00:f41:cbe:bc7d:62a6:5d09:5ba7:be5b])
        by smtp.gmail.com with ESMTPSA id o8-20020a056512050800b004fb757bd429sm633300lfb.96.2023.09.15.05.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 05:43:53 -0700 (PDT)
Message-ID: <dc209ac7-7a06-449b-a198-ce6fb3ba7ff7@linaro.org>
Date:   Fri, 15 Sep 2023 14:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add SM4450 interconnect
 provider driver
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230915020129.19611-1-quic_tengfan@quicinc.com>
 <20230915020129.19611-3-quic_tengfan@quicinc.com>
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
In-Reply-To: <20230915020129.19611-3-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.2023 04:01, Tengfei Fan wrote:
> Add driver for the Qualcomm interconnect buses found in SM4450 based
> platforms. The topology consists of several NoCs that are controlled
> by a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
[...]

> +static struct qcom_icc_bcm bcm_acv_disp = {
> +	.name = "ACV",
> +	.num_nodes = 1,
> +	.nodes = { &ebi_disp },
> +};
> +
> +static struct qcom_icc_bcm bcm_mc0_disp = {
> +	.name = "MC0",
> +	.num_nodes = 1,
> +	.nodes = { &ebi_disp },
> +};
> +
> +static struct qcom_icc_bcm bcm_mm0_disp = {
> +	.name = "MM0",
> +	.num_nodes = 1,
> +	.nodes = { &qns_mem_noc_hf_disp },
> +};
> +
> +static struct qcom_icc_bcm bcm_sh0_disp = {
> +	.name = "SH0",
> +	.num_nodes = 1,
> +	.nodes = { &qns_llcc_disp },
> +};
> +
> +static struct qcom_icc_bcm bcm_sh1_disp = {
> +	.name = "SH1",
> +	.num_nodes = 1,
> +	.nodes = { &qnm_pcie_disp },
> +};
"""
v1 -> v2:
  - remove DISP related paths
"""

you sure?

+ I still see _disp nodes..

Konrad
